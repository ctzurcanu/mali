using Interact, Blink, Mux, Reactive, WebIO

include("stepA_mal.jl")
#ui = button()

#WebIO.webio_serve(page("/", req -> ui), rand(8000:9000)) # serve on a random port

w = Window()# Open a new window
title(w, "taylor")
size(w, 1600, 800)
centre(w)

loadcss!(w, "style.css")

#WebIO.webio_serve(app, port=8000) # this will serve at http://localhost:8000/

#body( ui) # Set the body content

#display(ui)
# loadbutton = filepicker()
# hellobutton = button("Hello!")
# goodbyebutton = button("Good bye!")
buttons = Dict()
for (k, v) in repl_env.data
    #print(k, repr(k), eval(k))
    buttons[repr(k)] = repr(k)
end

drop = dropdown( buttons;
         value = first(values(buttons)),
         label = nothing,
         multiple = false)
txt1 = textarea( hint=""; value="(+ 5 6)")
txt2 = textarea(hint=""; value="")




function doit(str)
    print(txt1[]," ",str)
    ans = EVAL(READ(str), repl_env)
    print("\n\nans: ",ans)
    txt2[] = repr(ans)
end

doit(txt1[])
on(doit, txt1)



box = Blink.floating(w, true)

ui = hbox( # put things one next to the other
    height("90%", width("20%", vbox( [drop]))),
    width("40%", maxheight("500px",txt1)),
    width("40%", height("500px",txt2))
)


body!(w,ui)
#@js w alert("halert!")
