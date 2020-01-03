Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7012F6D7
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2020 11:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgACKqd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 3 Jan 2020 05:46:33 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbgACKqc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Jan 2020 05:46:32 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E6C8BD913C739CE9835B;
        Fri,  3 Jan 2020 10:46:29 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 3 Jan 2020 10:46:29 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 10:46:29 +0000
Date:   Fri, 3 Jan 2020 10:46:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        IIO <linux-iio@vger.kernel.org>,
        Robin Getz <Robin.Getz@analog.com>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Travis Collins <Travis.Collins@analog.com>,
        Dragos Bogdan <Dragos.Bogdan@analog.com>,
        "Dan Nechita" <Dan.Nechita@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Romain =?ISO-8859-1?Q?Roff=E9?= <romain.roffe@parrot.com>,
        =?ISO-8859-1?Q?R=E9mi_Lef=E8vre?= <remi.lefevre@parrot.com>,
        "Parrot developers" <developer@parrot.com>,
        Doug Geiger <doug.geiger@millennium-space.com>,
        Matt Fornero <matt.fornero@getcruise.com>,
        Ousman Sadiq <osadiq@mathworks.com>,
        "Neil MacEwen" <nmacewen@mathworks.com>,
        Kishor Akkala <kakkala@mathworks.com>,
        Bhanu Medasani <bmedasan@mathworks.com>,
        Jerome Chevalier <jchevali@mathworks.com>,
        Andrea Galbusera <gizero@gmail.com>,
        "Lucas Magasweran" <lucas.magasweran@daqri.com>,
        Matej Kenda <matejken@gmail.com>,
        Michael Heimpold <mhei@heimpold.de>,
        Andreas Brauchli <andreas.brauchli@sensirion.com>,
        Adrian Freihofer <adrian.freihofer@scs.ch>,
        David Frey <dfrey@sierrawireless.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Adrian Freihofer <adrian.freihofer@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        JaredD <jareddpub@gmail.com>,
        "Jeremy Trimble" <jeremy.trimble@azuresummit.com>,
        Johnny Vestergaard <jkv@unixcluster.dk>,
        Jonas Hansen <hr.jonas.hansen@gmail.com>,
        Jorik Jonker <jorik@kippendief.biz>,
        Julien Malik <julien.malik@paraiso.me>,
        "Marc Titinger" <mtitinger@baylibre.com>,
        Markus Gnadl <gnadl@iabg.de>,
        "Morten Fyhn Amundsen" <morten.fyhn.amundsen@gmail.com>,
        Nicholas Pillitteri <njpillitteri@gmail.com>,
        Pierre-Jean Texier <pjtexier@koncepto.io>
Subject: Re: Let's design the next-gen libiio!
Message-ID: <20200103104627.00007f51@Huawei.com>
In-Reply-To: <1578017419.3.1@crapouillou.net>
References: <1575905163.3.4@crapouillou.net>
        <20191230182326.47b89c14@archlinux>
        <1578017419.3.1@crapouillou.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Jan 2020 03:10:19 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> 
> Le lun., déc. 30, 2019 at 18:23, Jonathan Cameron 
> <jic23@jic23.retrosnub.co.uk> a écrit :
> > On Mon, 09 Dec 2019 16:26:03 +0100
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >   
> >>  Hello beautiful people,  
> > 
> > :)  Good opening
> > 
> > Sorry for slow response on this.  I read the intro and thought this
> > will take a while and then had work snowball somewhat in the run
> > up to xmas.  
> 
> No problem, I think everybody was in xmas holidays anyway.
> 
> > Whilst I've kept a vague eye on libiio and appreciate it certainly
> > reduced the number of questions we got on the linux-iio@vger about
> > the userspace interface, I'll confess I have never actually used it.
> > As such my inputs are going to be very much centered around the kernel
> > interface.  
> 
> Which is perfectly fine, that's the kind of input I was expecting from 
> you :)
> 
> >> 
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
> > 
> > At the kernel level, this one is a hard problem to solve cleanly and
> > I would imagine some of the problems apply even if we somehow insert
> > this data 'up the stack'.  What we don't want to break is
> > random access into the data stream.  So the spacing in the raw
> > data being read back has to be predictable...
> > 
> > We've had a few discussions on how to do this in the kernel layer.
> > One option was a magic 'meta data index' channel.  It's been a while
> > so I may miss some points from earlier discussions of this concept.
> > 
> > Basically if that channel contains 0 there is no meta data associated
> > with a particular sample, if there is meta data then a magic 'tag'
> > value references and entry in a separate meta data store that is
> > read via an out of band means (ioctl or possibly a separate file
> > handle similar to the event one).
> > 
> > This separates somewhat the main data flow from the metadata and 
> > allows
> > a nice key/value type format such as you describe (rather than out of
> > band description in sysfs).  However metadata lookups become
> > expensive...  I'm not sure if that is a problem though.  
> 
> That's more or less what I had in mind, yes.
> 
> 
> > For DAC meta data, we'd be parsing in kernel which is a fair bit
> > nastier as potentially we have a large attack surface.  
> 
> I would think that the default handler could be in the IIO core and 
> just handle "iio_filename=value", as if a sysfs file was written. For 
> now I don't think any driver needs to handle any custom metadata tags.

OK. Let's see what that looks like. (or at least a partial prototype
looks like :)

> 
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
> > 
> > Agreed, this would be useful.  So taking ADCs there are 3 cases I 
> > think.
> > 
> > 1) Overflow of software buffer (that needs to be in core)
> > 2) Overflow of hardware buffer (that needs to be at least partly 
> > driver specific)
> > 3) DMA overflow (descriptor not provided in time).
> > 
> > It's made more fun by the fact these may be per device, or per 
> > channel (for
> > hardware buffers or dma)  
> 
> Do userspace needs to know which one of the three cases happens? I 
> believe (I may be wrong) it's enough to know that an overflow happened, 
> which means that the data in the buffer is non-contiguous; that's all 
> the apps probably care about.

Agreed. They may all map to a particular signal to userspace, but the
handling ends up in different places (all calling the same function
in their handlers).  Probably doesn't matter from userspace point of view.

> 
> > The IIO event namespace doesn't have that much room, but we can 
> > probably
> > work out some magic coding to squeeze this in.
> > 
> > Every now and then there is a general kernel discussion about how to
> > report 'unexpected / error cases' in a generic fashion.  However it's 
> > never
> > gotten far as it's a very hard problem to get right.
> >   
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
> > 
> > In kernel or in userspace?
> > 
> > It may be hard to put together a generic way of doing this in kernel. 
> > GPUs
> > and similar get way with this stuff because they have very rich APIs.
> > 
> > If it's a rigid multiplex case, then we can do something using 
> > consumer
> > drivers - I'm not sure how how to handle this in kernel in general.  
> 
> This could be done with "iio_filename=value" metadata tags linked to 
> specific samples, I believe.

For output devices, that would work.  For input devices do we propose
to have a kind of parallel buffer for this stuff?

Either way, to get something efficient may be 'interesting' and require
some caching etc so the fairly heavy weight meta data processing
isn't happening in the fast path of sampling.

> 
> 
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
> > 
> > Agreed. That area has moved on somewhat since the IIO code was 
> > written!
> >   
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
> > 
> > I'm curious if there are network or USB devices using dmabuf?  
> 
> Not that I'm aware of, but I may have overlooked it. We're fishing in 
> exotic seas here.

Definitely.  Needs some exploration. We don't want to pick a route
for IIO on the assumption that other subsystems will move in a fashion
that helps us to find they go a different way.

> 
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
> > 
> > Splice also tends to put annoying limits on size of blocks. Not 
> > totally
> > sure that is an issue here but it's a pain with crypto ;)  
> 
> Splice also works with memory pages, which puts more constraints on the 
> hardware since the DMA must support scatter-gather.

True. Though for any non trivial DMA that's pretty much a requirement
anyway - or CMA pain occurs.

> 
> > I hate to say it but... 'show us your code'.  I'd love to get this
> > whole area cleaned up, but I'm not sure what the right solution is.  
> 
> I'll show the code once I know I'm starting with the right design ;)

:)  You know you'll never be sure until prototypes are done!

> 
> > If we can get dma_buff working well I think that approach is
> > a more long term solution.  However, there are other more experienced
> > people in these sorts of interfaces so I'm open to alternatives!
> >   
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
> > 
> > Almost agreed :)  Call it <direction>_<type><id>_label and I'm happy.
> > Label tends to come from DT bindings though, so do we need
> > that and extend_name?  
> 
> Great that we agree on this. We can work out the details when I send 
> the patchset ;)
> 
> > extended_name was a mistake but we are stick with that as it
> > currently is.  Thankfully there aren't that many users but we can't
> > touch the ones that do use it.
> >   
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
> > 
> > I'd have a chat to the people working a lot with dma_buf
> > (Sumit Semwal and John Stultz).  Seems likely they would have at least
> > thought about how to do network streaming.  
> 
> Thanks, I'll drop them an email.
> 
> >> 
> >>    To complicate things, IIOD (the network server) must be able to
> >>  stream the
> >>    same data to more than one client at a time, unless we decide that
> >>  this is
> >>    no more a requirement. This means that one single dmabuf would be
> >>  submitted
> >>    to more than one socket.  
> > 
> > Hmm. That may be 'interesting'.
> > 
> > I'd definitely do some benchmarking of this.  People spend a lot of
> > time doing zero copy tricks and sometimes it's just quicker to make
> > a copy and get rid of complexity.  Hard to know until you have
> > a prototype though.  
> 
> Definitely, there will be benchmarks with small test apps before I 
> implement anything in libiio.
> 
> About zerocopy vs. copy: another aspect is that copying from a mmapped 
> DMA buffer means copying from uncached memory, which quickly becomes 
> the bottleneck at high speeds.

True enough.  You should get some hardware that will do full shared virtual
addressing / page faulting etc.  Gets around these annoying limitations ;)
Can't see that happening on embedded devices for a while yet though *sigh*

> 
> >   
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
> > 
> > So this does indeed suggest you are thinking to put the write queueing
> > into the kernel.   I'm not sure how we can actually do this without
> > ending up with really sophisticated handling in kernel (and this stuff
> > really needs to be realtime).  If I were designing a platform to do 
> > this
> > stuff I'd push the actual synchronization out to an fpga.  
> 
> Honestly I'm not sure where in the stack it belongs. It would make 
> sense to have it in the FPGA, but then that's a non-standard feature 
> and there is no point in having that supported in libiio, which is 
> meant to be generic.

It might be possible to have optional offload, as long as there is
a less performant fallback.

> 
> If the kernel supports "iio_filename=value" metadata for DACs, it would 
> be possible to change a parameter at a very specific moment in time, 
> but I don't know if that's enough to cover all applications. That's a 
> question for @analog.com guys I believe.
> 

Agreed.  This stuff is always cool to think about, but I have no
idea what the real usecases are driving it.

> 
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
> > 
> > Just a side note to this with my IIO maintainer hat on.
> > Compatibility at the kernel interfaces is a must, but we do have a 
> > little
> > bit of flexibility when we have good reason to think no one is using
> > a given interface...
> > 
> > Some interesting ideas.  Look forward to seeing how it goes!
> > 
> > Jonathan  
> 
> Great, thank you for the feedback!
> 
> -Paul
> 
You are welcome!

I'm particularly looking forward to seeing how some of these high performance
devices actually fit into a wider framework.  Who doesn't like insanely quick
ADCs and DACs? :)

Thanks,

Jonathan


