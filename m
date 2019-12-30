Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF812D36A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2019 19:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfL3Sbu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 30 Dec 2019 13:31:50 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:37508 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfL3Sbu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Dec 2019 13:31:50 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 3C3229E6A75;
        Mon, 30 Dec 2019 18:31:21 +0000 (GMT)
Date:   Mon, 30 Dec 2019 18:31:10 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        jchevali@mathworks.com, dfrey@sierrawireless.com,
        osadiq@mathworks.com, mtitinger@baylibre.com,
        "Getz, Robin" <Robin.Getz@analog.com>,
        morten.fyhn.amundsen@gmail.com, matejken@gmail.com,
        "Collins, Travis" <Travis.Collins@analog.com>,
        adrian.freihofer@scs.ch, gwendal@chromium.org,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        julien.malik@paraiso.me, andreas.brauchli@sensirion.com,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        remi.lefevre@parrot.com, pjtexier@koncepto.io,
        matt.fornero@getcruise.com, lucas.magasweran@daqri.com,
        geert@linux-m68k.org, jkv@unixcluster.dk, mhei@heimpold.de,
        jeremy.trimble@azuresummit.com, adrian.freihofer@gmail.com,
        jareddpub@gmail.com, linux-iio@vger.kernel.org,
        romain.roffe@parrot.com, doug.geiger@millennium-space.com,
        njpillitteri@gmail.com, gnadl@iabg.de,
        "Nechita, Dan" <Dan.Nechita@analog.com>, jorik@kippendief.biz,
        developer@parrot.com, bmedasan@mathworks.com,
        hr.jonas.hansen@gmail.com, nmacewen@mathworks.com, lars@metafoo.de,
        gizero@gmail.com, kakkala@mathworks.com
Subject: Re: Let's design the next-gen libiio!
Message-ID: <20191230183110.3203245d@archlinux>
In-Reply-To: <1576855707.3.0@crapouillou.net>
References: <1575905163.3.4@crapouillou.net>
        <c97d848ec9898eb46b8adf5bda87ccb4fc8e2e2a.camel@analog.com>
        <1576855707.3.0@crapouillou.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Dec 2019 16:28:27 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Alexandru,
> 
> I wanted to delay my response to answer in a big email all the feature 
> requests and concerns that came my way, but you've been the only one to 
> answer so far and it's been more than one week now, so I'll answer your 
> comments below.
> 
> 
> 
> Le mar., déc. 10, 2019 at 07:37, "Ardelean, Alexandru" 
> <alexandru.Ardelean@analog.com> a écrit :
> > On Mon, 2019-12-09 at 16:26 +0100, Paul Cercueil wrote:  
> >> 
> >>  Hello beautiful people,
> >>   
> > 
> > Hey,
> > 
> > Before going forward, looking at the current backlog [on Github] 
> > would be
> > an idea. There are some PRs there which are unresolved and have some 
> > real
> > value.
> > Like the plugin-support for libiio, and the Android build support.
> > Not saying we should resolve them now, but they should get resolved 
> > in time
> > [either implement or drop].  
> 
> The plugin support for libiio was in my list, as "modular backends".
> The PRs which are unresolved generally mean that more work or testing 
> is needed.
> 
> > 
> > There's also some static-code-checker that's running, and one of them
> > [Codacy] seems to yield some interesting stuff for C# bindings.
> > 
> > https://app.codacy.com/manual/commodo/libiio/dashboard
> > 
> > So, going forward, a few things from my side that have cropped up in 
> > some
> > time.
> > I did go quickly through your list and eliminated a few [1 or 2] that 
> > were
> > already there. If am repeating something, it is possible.
> > 
> > Bindings:
> > - would be nice for libiio to be present on pypi (for the Python 
> > bindings);
> > I am not sure if this was ever a request, but the idea popped up 
> > here-n-
> > there
> > - Java-bindings for Android; personally, I'm not a fan of Java, but 
> > Android
> > seems to be; and there was someone trying to integrate a heart-rate 
> > sensor
> > with libiio on Android; which makes sense, given all the sensors 
> > people are
> > putting into phones these day  
> 
> About pypi: indeed, that would be a good idea. I didn't add these 
> "small features" to my list as they don't depend on a redesign of the 
> library to be brought to life, which is the focus here.
> 
> Kotlin is all the rage these days in the Android world, maybe it would 
> make more sense than Java? Or both?
> 
> > 
> > Deployment-wise:
> > - there's been talk of trying to deploy libiio in Launchpad [for 
> > Ubuntu]
> > and something [similar to Launchpad] for CentOS/RedHat RPMs; the main
> > benefit here is ease-of-deployment with the latest libiio; people 
> > seem to
> > try to get the latest, and have trouble with it  
> 
> I think it's important to always have the latest version in the 
> software managers of the distributions. It's the case for 
> Debian/Ubuntu, but I don't think it's being packaged elsewhere. 
> Besides, if releases are made more often (e.g. with patch-level 
> revisions, 1.0.x versions), then there shouldn't be a need for an 
> off-the-track solution to get updates.
> 
> > 
> > Configuration-wise:
> > - an alternative to XML seemed to be interesting at at time; JSON was
> > preferred, but now I'm wondering if YAML would also be preferred 
> > [these-
> > days]; in any case, the jump from JSON to YAML may be not as big, so 
> > JSON
> > would be great as a first step; one argument against XML was 
> > libxml2's size  
> 
> XML is only used internally, as a software representation of an IIO 
> context. It's never there to see or modify, so I don't really see the 
> point of switching to another markup language, besides the libxml2 
> problem you mention (but then again, there are other XML libraries we 
> could switch to). Additionally, that would mean breaking the 
> compatibility with the old libiio/IIOD, and I want to avoid that as 
> much as possible.
> 
> > 
> > Communication-wise:
> > - I started getting this idea to maybe use websockets for data-stream
> > communication [using libwebsockets]; the whole idea would be to maybe
> > convert/add a web-server part to IIOD. This would allow people to 
> > write
> > web-pages [HTML + JS] that talk directly to libiio. This would 
> > simplify
> > [and maybe accelerate] some app-development; web-browsers have really 
> > great
> > capabilities to display animated data, and given that there are more 
> > JS
> > devs [than C++/desktop-app devs] in this world, getting things 
> > displayed is
> > much faster. Also, creating simple mobile-apps is really easy with JS.
> > While it sounded that I am a JS fan, I'm actually not, but it's big 
> > enough
> > that it's hard to avoid it, and I do feel that it has become a gateway
> > language for web & mobile [as is C for OS development].  
> 
> I don't really like the idea of having IIOD exposed to the outside 
> world. This has ramifications that I'm not comfortable with, as it 
> means the server software must be fully secure, provide cryptographic 
> functionalities, etc.
> 
> Support for server-side JavaScript (via NodeJS) or PHP would probably 
> be a good alternative, I think. The server software would communicate 
> the IIO data to the client page the way it wants to.
> 
> > 
> > Misc:
> > - throughput & loss-rate measurement: not sure if this should be part 
> > of
> > the library, or an example app [or both], but people have been asking 
> > this
> > same question many times: how do i measure my throughput and how do i 
> > check
> > for losses? at least, i was never able to give a good answer here
> > - profile support: this is something from Lars; but for some more 
> > complex
> > devices, configuration is challenging; so, something to load all
> > configuration params, and perhaps save them back, would be 
> > interesting;
> > this has been pushed to apps, but who knows? maybe libiio? i am not 
> > sure
> > how valid this is  
> 
> The throughput and loss-rate measurement would be easy to obtain if 
> there was a mechanism built into IIO to report overflows/underflows. 
> This is definitely something that we want and need, yes.

This would change how overflow/underflow are reported though.
If you want stats you need a 'how much did we drop' counter.
If you just care about did overflow happen you would be better off
with a single event.

If we are doing overflow for DMA buffers then we can't just push
one event for each scan dropped - that could be an insane number
of events.  Hence something cleverer would be needed.

Jonathan
> 
> About profile support, I didn't list it here, because I consider it a 
> side project - it should be its own library, "libiioprofile" if you 
> want, which would use libiio, and not a mechanism built into libiio.
> 
> > 
> > I guess for now, this is mostly it.
> > Not sure if I forgot anything, but these were collected from various 
> > parts
> > of memory, notes and some issue trackers.  
> 
> Thank you very much for taking the time to answer.
> 
> Cheers,
> -Paul
> 
> 
> > 
> > Thanks
> > Alex
> >   
> >>  First of all, apologies for sending such a long email. Double 
> >> apologies
> >>  if
> >>  you're caught in the email chain and you don't care about the topic.
> >>  Just
> >>  don't click "reply all" when you send me an angry response, as the
> >>  thread will
> >>  be publicly logged.
> >> 
> >>  The reason for you receiving this, is that you've been involved with
> >>  libiio
> >>  (https://github.com/analogdevicesinc/libiio) either directly or
> >>  indirectly,
> >>  or subscribed to the IIO kernel mailing list, or have shown 
> >> interest in
> >>  the
> >>  project, or have an homonym who does.
> >> 
> >>  About five years ago libiio was born, as an easy-to-use library for
> >>  interfacing to Linux' Industrial Input/Output (IIO) kernel 
> >> subsystem,
> >>  either
> >>  with devices preset on the host platform, or on a remote target
> >>  platform.
> >>  I think we did a good job, as the API was never broken since its 
> >> first
> >>  release,
> >>  and the praise/hate ratio we received was very encouraging. We've 
> >> seen
> >>  people
> >>  using it in all kinds of applications, from car infotainment to 
> >> space
> >>  research,
> >>  from drones to software radio.
> >> 
> >>  It's not perfect, though, and its current design has room for
> >>  improvements,
> >>  both inside and outside the library. However, we've hit a point 
> >> where
> >>  such
> >>  improvements would require a redesign of the library and kernel 
> >> bits,
> >>  and as a
> >>  consequence, a breakage of the API. It's time for the next-gen 
> >> libiio,
> >>  and a
> >>  overhaul of the whole IIO stack, really.
> >> 
> >>  Your mission, should you choose to accept it, is to feed me with 
> >> ideas,
> >>  concerns, comments about what you think libiio was lacking or just 
> >> not
> >>  doing
> >>  right. We want to open the possibility for all interested parties to
> >>  help
> >>  sketch the future library.
> >> 
> >>  I have compiled below a list of changes that we think should be 
> >> done,
> >>  comments
> >>  are very welcome. Note that emails in HTML form will probably be
> >>  bounced back
> >>  by the IIO mailing list, so please write responses in plain text.
> >> 
> >>  Thank you for your time.
> >> 
> >>  Kind regards,
> >>  Paul Cercueil
> >> 
> >>  ------
> >>  Kernel
> >>  ------
> >> 
> >>  * Support for buffer metadata
> >>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >>    Support tagging the buffers with any relevant information. Either
> >>  from the IIO
> >>    core for general accounting (e.g. timestamp) or from the driver 
> >> for
> >>    hardware-facing code (e.g. buffer underflow).
> >>    Metadata would be attached to a specific sample in the buffer
> >>  (metadata that
> >>    applies to the whole buffer can be attached to the first sample).
> >>  Several
> >>    entries could be attached to the same sample. The format would be 
> >> a
> >>  simple
> >>    key="value", I don't think we need anything more complex than 
> >> that.
> >>    For DACs, it should be possible to set metadata from userspace. 
> >> The
> >>  drivers
> >>    would then interpret the metadata tags if they need to.
> >> 
> >>  * Facility to detect overflow/underflow
> >>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >>    There should be a way to detect overflows (for ADCs) and 
> >> underflows
> >>  (for
> >>    DACs), if the hardware supports it, and report them to userspace
> >>  (through a
> >>    IIO event, I suppose). This is something that could be done by the
> >>  drivers,
> >>    but maybe it would make sense to have this functionality in the 
> >> IIO
> >>  common
> >>    code?
> >> 
> >>  * Delayed attribute write / Command queues
> >>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >>    We need a mechanism that allows us to change the value of an
> >>  attribute at a
> >>    very specific time (or sample number) after a capture or upload is
> >>  started;
> >>    some kind of script mechanism, or 'command list' analog to the
> >>  display lists
> >>    used in old GPUs. This would be used for instance in software
> >>  applications
> >>    doing time-divison duplexing (TDD).
> >> 
> >>  * Better high-speed buffer mechanism
> >>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >>    The current buffer API is fine for low-speed devices, but we're
> >>  dealing with
> >>    ADCs and DACs of the GB/s class. ADI already contributed an 
> >> improved
> >>  (faster)
> >>    buffer mechanism, but which is incomplete (no support for DACs),
> >>  doesn't
> >>    integrate very well in the ecosystem, and is somewhat redundant 
> >> with
> >>  the old
> >>    one.
> >> 
> >>    The idea would be to deprecate this API and propose an alternative
> >>  that
> >>    makes use of current technology, like dmabuf. The concept would 
> >> stay
> >>  the
> >>    same, each IIO device has a pool of DMA buffers, and userspace can
> >>  queue
> >>    and dequeue buffers.
> >> 
> >>    The rationale behind this change, is that with the current two 
> >> APIs
> >>  it is not
> >>    possible to move data between IIO devices and a network or USB 
> >> card
> >>  without
> >>    having the CPU copy the data. This is an important problem, as
> >>  high-speed
> >>    ADCs and DACs are generally connected to FPGAs running Linux on a
> >>  softcore,
> >>    which stream their data to a workstation for further processing. 
> >> With
> >>  the
> >>    new API, the userspace software would simply obtain a pointer to a
> >>  dmabuf
> >>    from the IIO interface, and simply pass it to the network card 
> >> (this
> >>  means
> >>    the network stack and USB stack would also need to support 
> >> dmabuf).
> >> 
> >>    An alternative would be to keep the current file-based buffer and
> >>    buffer-queue-based APIs, but enhance the former one with support 
> >> for
> >>    splicing (with splice()/vmsplice()). This might arguably be 
> >> easier to
> >>  do,
> >>    since the network stack already supports it. The problem with
> >>  splicing is
> >>    that the kernel swaps each data page with a fresh zeroed page in
> >>  order to
> >>    avoid leaking kernel memory. To be truely zero-copy, this requires
> >>  the page
> >>    cleaning mechanism to be offloaded to e.g. DMA, otherwise the 
> >> process
> >>  isn't
> >>    entirely CPU-free.
> >> 
> >>  * Parsable attribute names
> >>    ~~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >>    IIO attributes follow a certain formatting that does not make it
> >>  possible to
> >>    reconstruct the devices/channels/attributes tree in userspace. The
> >>  channel
> >>    attributes are formatted as:
> >>    <direction>_<type><id>_<modifier>_<extended-name>_<attribute-name>
> >>    The problem is that <extended-name>, <modifier> and 
> >> <attribute-name>
> >>  can
> >>    contain underscores, which makes it impossible to parse. For 
> >> instance,
> >>    with an attribute named "in_voltage0_high_impedence_line_enable":
> >>    Is the extended name "high_impedence_line" and the attribute name
> >>  "enable",
> >>    or is the extended name "high_impedence" and the attribute name
> >>  "line_enable"?
> >> 
> >>    Since the sysfs attributes is ABI, the solution could be to have a
> >>  separate
> >>    sysfs file, for instance <direction>_<type><id>_extended_name, 
> >> that
> >>  would
> >>    contain the extended name of the channel. This should be enough 
> >> for
> >>  the IIO
> >>    sysfs interface to be machine-readable.
> >> 
> >>  -------
> >>  Libiio2
> >>  -------
> >> 
> >>  * stdio redirection
> >>    ~~~~~~~~~~~~~~~~~
> >> 
> >>    Right now libiio prints its debug information unconditionally to
> >>    stdout/stderr, it should be modified to be able to output its log 
> >> to
> >>  any
> >>    valid file descriptor. While that looks simple on paper, it must 
> >> be
> >>  set up
> >>    before a library context is created, since the context creation
> >>  itself may
> >>    print debug information. This require the context allocation to be
> >>  separated
> >>    from its initialization, so a break of API.
> >> 
> >>  * Separate allocation from initialization
> >>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >>    As stated above, functions to alloc/destroy and init/deinit the
> >>  various IIO
> >>    structures should be separate; this would allow e.g. to set some
> >>  parameters
> >>    to a iio_context before the context creation happens, for instance
> >>  where to
> >>    redirect the debug output.
> >> 
> >>  * Modular backends
> >>    ~~~~~~~~~~~~~~~~
> >> 
> >>    Right now the backends of libiio are tightly coupled to the core. 
> >> It
> >>  would
> >>    be great if the users could install only the backends they're
> >>  interested in.
> >>    Of course, backends could still be backed into the core library, 
> >> and
> >>  that
> >>    would stay the default behaviour for non-Linux platforms.
> >> 
> >>    This requires two things:
> >>    - The libiio backends must be able to be updated independently of 
> >> the
> >>  main
> >>   library, therefore they should only depend on the top-level API of
> >>  libiio.
> >>   Apart from a few exceptions here and there, this is already mostly 
> >> the
> >>   case.
> >>    - There needs to be a facility to load external backends based on 
> >> the
> >>   backend name. Thanksfully with URIs this becomes easy: creating a
> >>  context
> >>   from the URI "foo:" would result in the backend module "foo" loaded
> >>  from
> >>   the disk, if not already baked in.
> >> 
> >>  * Event support
> >>    ~~~~~~~~~~~~~
> >> 
> >>    The IIO subsystem has support for events. This allows the 
> >> userspace
> >>  to get
> >>    notified for instance when a temperature gets over or under a
> >>  threshold.
> >>    Right now, libiio cannot easily support events, as the 
> >> client/server
> >>    protocol of the network backend doesn't really allow it. 
> >> Therefore,
> >>  the new
> >>    libiio2 library should be designed from the ground up with 
> >> support for
> >>    events, and the API should offer a way to register a callback that
> >>  would be
> >>    called when a IIO event occurs.
> >> 
> >>  * Context change detection
> >>    ~~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >>    When a device is added, removed or the context becomes unavailable
> >>  (e.g. the
> >>    USB cable was unplugged), there should be a built-in mechanism to
> >>  notify the
> >>    applications using libiio2, maybe using the same mechanism as for 
> >> IIO
> >>  events.
> >> 
> >>    The same would apply on the local backend, if for instance a new
> >>  device
> >>    appears, the library should be able to pick it up and report the 
> >> new
> >>  device
> >>    to the application.
> >> 
> >>  * Asynchronous network communication
> >>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >>    The network communication between libiio and IIO is sub-par, 
> >> because
> >>  it uses
> >>    a synchronous request-response protocol. This causes the 
> >> throughput
> >>  to max
> >>    out way below the theorical maximum throughput of Gigabit 
> >> Ethernet.
> >>    The communication protocol should be modified in a way that fully
> >>  maximizes
> >>    the throughput.
> >> 
> >>    The old communication protocol should still be available and used 
> >> by
> >>  default
> >>    unless the two parties agree to use the new protocol. This ensures
> >>  that
> >>    TinyIIOD (the microcontroller variant of IIOD, the server that
> >>  communicates
> >>    with the network backend of libiio) can still work with the 
> >> network
> >>  backend of
> >>    libiio2. Alternatively, TinyIIOD could be updated to the new 
> >> network
> >>  protocol.
> >>    That way, the old network protocol wouldn't have to stick around.
> >> 
> >>    To implement the asynchronous network communication, we could 
> >> have a
> >>  look at
> >>    ZeroMQ (https://zeromq.org) which seems to be designed for that
> >>  particular
> >>    task, and is available under a LGPLv3 license. It is however
> >>  uncertain how
> >>    that would work on the IIOD side (because of the zero-copy
> >>  requirement - see
> >>    below).
> >> 
> >>    Additionally, the network backend should part ways with its 
> >> current
> >>    ASCII-based protocol. This made sense when libiio was first 
> >> created,
> >>  but it
> >>    requires quite a complex parser on the server side that could go 
> >> away
> >>  by
> >>    resorting to a more classic protocol.
> >> 
> >>  * Zero-copy
> >>    ~~~~~~~~~
> >> 
> >>    Apart from supporting the new network protocol, libiio should 
> >> provide
> >>  a way
> >>    to stream data between IIO devices and standard file descriptors 
> >> or
> >>  sockets
> >>    without having the CPU copy the data.
> >> 
> >>    If a dmabuf-based IIO kernel interface is used, we need a way to 
> >> send
> >>  a
> >>    dmabuf to a socket, and I'm not sure that this is currently 
> >> possible.
> >>    But as dmabuf are internally just scatterlists, and the sockets
> >>  support
> >>    splice(), that should be somewhat doable.
> >> 
> >>    To complicate things, IIOD (the network server) must be able to
> >>  stream the
> >>    same data to more than one client at a time, unless we decide that
> >>  this is
> >>    no more a requirement. This means that one single dmabuf would be
> >>  submitted
> >>    to more than one socket.
> >> 
> >>    Streaming data to multiple clients using zero-copy techniques in 
> >> IIOD
> >>  also
> >>    implies that the data cannot be modified, which means that the 
> >> server
> >>  cannot
> >>    do the demuxing, and this task is devoted to the clients; so the
> >>  (currently
> >>    optional) server-side demuxing option would be removed.
> >> 
> >>  * USB3
> >>    ~~~~
> >> 
> >>    Just like the network, the USB backend should be updated to be 
> >> able
> >>  to reach
> >>    out the maximum throughput offered by USB3.
> >> 
> >>    The principal problem with USB is the short number of endpoints,
> >>  which limits
> >>    the functionality, as it may not be possible to stream data from
> >>  different
> >>    devices at the same time. Right now, a pair of endpoints is 
> >> reserved
> >>  for
> >>    generic commands (read attributes, open/close IIO device, etc.), 
> >> and
> >>  one pair
> >>    is reserved per IIO device streaming data.
> >> 
> >>    There are several possibilities:
> >>    - the USB backend could multiplex accesses into one single pair of
> >>   endpoints, which basically do in software what USB controllers do 
> >> in
> >>   hardware;
> >>    - Rework the communication protocol so that only one endpoint is
> >>  needed per
> >>   streaming device instead of two;
> >>    - Negate the problem, and consider it okay that the number of USB
> >>  endpoints
> >>   is a limiting factor.
> >> 
> >>  * PCIe backend
> >>    ~~~~~~~~~~~~
> >> 
> >>    There is a need for a backend to support the PCIe cards populated 
> >> with
> >>    various chips and a FPGA with a softcore running Linux. The
> >>  communication
> >>    between the remote OS and the host OS would be something similar 
> >> to
> >>  Xillybus.
> >> 
> >>  * Command queues
> >>    ~~~~~~~~~~~~~~
> >> 
> >>    The libiio2 API bits to use the "delayed attribute write / command
> >>  queue"
> >>    feature of the kernel. A command queue would contain several 
> >> commands
> >>  (e.g.
> >>    submit buffer, change a parameter, submit another buffer), that 
> >> would
> >>  be
> >>    built in the upper layer of the library using a specific API, and 
> >> then
> >>    performed atomically on the remote device.
> >> 
> >>  * Buffer overhaul
> >>    ~~~~~~~~~~~~~~~
> >> 
> >>    Instead of having one iio_buffer, that is either pushed or 
> >> refilled,
> >>  the idea
> >>    would be to provide an API that allows the client application to
> >>  request,
> >>    enqueue or dequeue the buffers itself. This would offer much 
> >> greater
> >>  control
> >>    on the buffer management to the application.
> >> 
> >>  * Backwards-compatibility
> >>    ~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >>    Backwards compatibility is not a hard requirement, but it should
> >>  still be
> >>    possible to be done by implementing the libiio API on top of 
> >> libiio2.
> >>  Things
> >>    like buffer refill/push of libiio can be implemented on top of the
> >>  new buffer
> >>    queue system. New features, like buffer metadata support wouldn't 
> >> be
> >>    backported.
> >> 
> >>    This should be considered low-priority - we're not yet at the 
> >> point
> >>  where
> >>    libiio1 is deprecated.
> >> 
> >>   
> 
> 

