Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB30012F2DB
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2020 03:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgACCKd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jan 2020 21:10:33 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:52682 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgACCKd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jan 2020 21:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578017429; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CujG9Of3nqcSNV7CMFRa7v/yA8V59MpV//OMV3/Xpzo=;
        b=qCfKKK00/h72AfRzuVSJiglXNiH8OmN7oQshsPKdoEz74TmspsRVI5sbTORlHakFaYKqNg
        eg0CzBDZJcmQWIBH04GPWtCAdUvsVJbu6qTthnJhhk/q4nmgtb1DDJkWUGXdpXoY340kgN
        D8gO05EBB/oF9rY0RxAjlqVacRhHnS4=
Date:   Fri, 03 Jan 2020 03:10:19 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Let's design the next-gen libiio!
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     IIO <linux-iio@vger.kernel.org>,
        Robin Getz <Robin.Getz@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Travis Collins <Travis.Collins@analog.com>,
        Dragos Bogdan <Dragos.Bogdan@analog.com>,
        Dan Nechita <Dan.Nechita@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Romain =?iso-8859-1?b?Um9mZuk=?= <romain.roffe@parrot.com>,
        =?iso-8859-1?q?R=E9mi_Lef=E8vre?= <remi.lefevre@parrot.com>,
        Parrot developers <developer@parrot.com>,
        Doug Geiger <doug.geiger@millennium-space.com>,
        Matt Fornero <matt.fornero@getcruise.com>,
        Ousman Sadiq <osadiq@mathworks.com>,
        Neil MacEwen <nmacewen@mathworks.com>,
        Kishor Akkala <kakkala@mathworks.com>,
        Bhanu Medasani <bmedasan@mathworks.com>,
        Jerome Chevalier <jchevali@mathworks.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Lucas Magasweran <lucas.magasweran@daqri.com>,
        Matej Kenda <matejken@gmail.com>,
        Michael Heimpold <mhei@heimpold.de>,
        Andreas Brauchli <andreas.brauchli@sensirion.com>,
        Adrian Freihofer <adrian.freihofer@scs.ch>,
        David Frey <dfrey@sierrawireless.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Adrian Freihofer <adrian.freihofer@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        JaredD <jareddpub@gmail.com>,
        Jeremy Trimble <jeremy.trimble@azuresummit.com>,
        Johnny Vestergaard <jkv@unixcluster.dk>,
        Jonas Hansen <hr.jonas.hansen@gmail.com>,
        Jorik Jonker <jorik@kippendief.biz>,
        Julien Malik <julien.malik@paraiso.me>,
        Marc Titinger <mtitinger@baylibre.com>,
        Markus Gnadl <gnadl@iabg.de>,
        Morten Fyhn Amundsen <morten.fyhn.amundsen@gmail.com>,
        Nicholas Pillitteri <njpillitteri@gmail.com>,
        Pierre-Jean Texier <pjtexier@koncepto.io>
Message-Id: <1578017419.3.1@crapouillou.net>
In-Reply-To: <20191230182326.47b89c14@archlinux>
References: <1575905163.3.4@crapouillou.net>
        <20191230182326.47b89c14@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,


Le lun., d=E9c. 30, 2019 at 18:23, Jonathan Cameron=20
<jic23@jic23.retrosnub.co.uk> a =E9crit :
> On Mon, 09 Dec 2019 16:26:03 +0100
> Paul Cercueil <paul@crapouillou.net> wrote:
>=20
>>  Hello beautiful people,
>=20
> :)  Good opening
>=20
> Sorry for slow response on this.  I read the intro and thought this
> will take a while and then had work snowball somewhat in the run
> up to xmas.

No problem, I think everybody was in xmas holidays anyway.

> Whilst I've kept a vague eye on libiio and appreciate it certainly
> reduced the number of questions we got on the linux-iio@vger about
> the userspace interface, I'll confess I have never actually used it.
> As such my inputs are going to be very much centered around the kernel
> interface.

Which is perfectly fine, that's the kind of input I was expecting from=20
you :)

>>=20
>>  First of all, apologies for sending such a long email. Double=20
>> apologies
>>  if
>>  you're caught in the email chain and you don't care about the topic.
>>  Just
>>  don't click "reply all" when you send me an angry response, as the
>>  thread will
>>  be publicly logged.
>>=20
>>  The reason for you receiving this, is that you've been involved with
>>  libiio
>>  (https://github.com/analogdevicesinc/libiio) either directly or
>>  indirectly,
>>  or subscribed to the IIO kernel mailing list, or have shown=20
>> interest in
>>  the
>>  project, or have an homonym who does.
>>=20
>>  About five years ago libiio was born, as an easy-to-use library for
>>  interfacing to Linux' Industrial Input/Output (IIO) kernel=20
>> subsystem,
>>  either
>>  with devices preset on the host platform, or on a remote target
>>  platform.
>>  I think we did a good job, as the API was never broken since its=20
>> first
>>  release,
>>  and the praise/hate ratio we received was very encouraging. We've=20
>> seen
>>  people
>>  using it in all kinds of applications, from car infotainment to=20
>> space
>>  research,
>>  from drones to software radio.
>>=20
>>  It's not perfect, though, and its current design has room for
>>  improvements,
>>  both inside and outside the library. However, we've hit a point=20
>> where
>>  such
>>  improvements would require a redesign of the library and kernel=20
>> bits,
>>  and as a
>>  consequence, a breakage of the API. It's time for the next-gen=20
>> libiio,
>>  and a
>>  overhaul of the whole IIO stack, really.
>>=20
>>  Your mission, should you choose to accept it, is to feed me with=20
>> ideas,
>>  concerns, comments about what you think libiio was lacking or just=20
>> not
>>  doing
>>  right. We want to open the possibility for all interested parties to
>>  help
>>  sketch the future library.
>>=20
>>  I have compiled below a list of changes that we think should be=20
>> done,
>>  comments
>>  are very welcome. Note that emails in HTML form will probably be
>>  bounced back
>>  by the IIO mailing list, so please write responses in plain text.
>>=20
>>  Thank you for your time.
>>=20
>>  Kind regards,
>>  Paul Cercueil
>>=20
>>  ------
>>  Kernel
>>  ------
>>=20
>>  * Support for buffer metadata
>>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>>    Support tagging the buffers with any relevant information. Either
>>  from the IIO
>>    core for general accounting (e.g. timestamp) or from the driver=20
>> for
>>    hardware-facing code (e.g. buffer underflow).
>>    Metadata would be attached to a specific sample in the buffer
>>  (metadata that
>>    applies to the whole buffer can be attached to the first sample).
>>  Several
>>    entries could be attached to the same sample. The format would be=20
>> a
>>  simple
>>    key=3D"value", I don't think we need anything more complex than=20
>> that.
>>    For DACs, it should be possible to set metadata from userspace.=20
>> The
>>  drivers
>>    would then interpret the metadata tags if they need to.
>=20
> At the kernel level, this one is a hard problem to solve cleanly and
> I would imagine some of the problems apply even if we somehow insert
> this data 'up the stack'.  What we don't want to break is
> random access into the data stream.  So the spacing in the raw
> data being read back has to be predictable...
>=20
> We've had a few discussions on how to do this in the kernel layer.
> One option was a magic 'meta data index' channel.  It's been a while
> so I may miss some points from earlier discussions of this concept.
>=20
> Basically if that channel contains 0 there is no meta data associated
> with a particular sample, if there is meta data then a magic 'tag'
> value references and entry in a separate meta data store that is
> read via an out of band means (ioctl or possibly a separate file
> handle similar to the event one).
>=20
> This separates somewhat the main data flow from the metadata and=20
> allows
> a nice key/value type format such as you describe (rather than out of
> band description in sysfs).  However metadata lookups become
> expensive...  I'm not sure if that is a problem though.

That's more or less what I had in mind, yes.


> For DAC meta data, we'd be parsing in kernel which is a fair bit
> nastier as potentially we have a large attack surface.

I would think that the default handler could be in the IIO core and=20
just handle "iio_filename=3Dvalue", as if a sysfs file was written. For=20
now I don't think any driver needs to handle any custom metadata tags.

>>=20
>>  * Facility to detect overflow/underflow
>>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>>    There should be a way to detect overflows (for ADCs) and=20
>> underflows
>>  (for
>>    DACs), if the hardware supports it, and report them to userspace
>>  (through a
>>    IIO event, I suppose). This is something that could be done by the
>>  drivers,
>>    but maybe it would make sense to have this functionality in the=20
>> IIO
>>  common
>>    code?
>=20
> Agreed, this would be useful.  So taking ADCs there are 3 cases I=20
> think.
>=20
> 1) Overflow of software buffer (that needs to be in core)
> 2) Overflow of hardware buffer (that needs to be at least partly=20
> driver specific)
> 3) DMA overflow (descriptor not provided in time).
>=20
> It's made more fun by the fact these may be per device, or per=20
> channel (for
> hardware buffers or dma)

Do userspace needs to know which one of the three cases happens? I=20
believe (I may be wrong) it's enough to know that an overflow happened,=20
which means that the data in the buffer is non-contiguous; that's all=20
the apps probably care about.

> The IIO event namespace doesn't have that much room, but we can=20
> probably
> work out some magic coding to squeeze this in.
>=20
> Every now and then there is a general kernel discussion about how to
> report 'unexpected / error cases' in a generic fashion.  However it's=20
> never
> gotten far as it's a very hard problem to get right.
>=20
>>=20
>>  * Delayed attribute write / Command queues
>>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>>    We need a mechanism that allows us to change the value of an
>>  attribute at a
>>    very specific time (or sample number) after a capture or upload is
>>  started;
>>    some kind of script mechanism, or 'command list' analog to the
>>  display lists
>>    used in old GPUs. This would be used for instance in software
>>  applications
>>    doing time-divison duplexing (TDD).
>=20
> In kernel or in userspace?
>=20
> It may be hard to put together a generic way of doing this in kernel.=20
> GPUs
> and similar get way with this stuff because they have very rich APIs.
>=20
> If it's a rigid multiplex case, then we can do something using=20
> consumer
> drivers - I'm not sure how how to handle this in kernel in general.

This could be done with "iio_filename=3Dvalue" metadata tags linked to=20
specific samples, I believe.


>>=20
>>  * Better high-speed buffer mechanism
>>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>>    The current buffer API is fine for low-speed devices, but we're
>>  dealing with
>>    ADCs and DACs of the GB/s class. ADI already contributed an=20
>> improved
>>  (faster)
>>    buffer mechanism, but which is incomplete (no support for DACs),
>>  doesn't
>>    integrate very well in the ecosystem, and is somewhat redundant=20
>> with
>>  the old
>>    one.
>=20
> Agreed. That area has moved on somewhat since the IIO code was=20
> written!
>=20
>>=20
>>    The idea would be to deprecate this API and propose an alternative
>>  that
>>    makes use of current technology, like dmabuf. The concept would=20
>> stay
>>  the
>>    same, each IIO device has a pool of DMA buffers, and userspace can
>>  queue
>>    and dequeue buffers.
>>=20
>>    The rationale behind this change, is that with the current two=20
>> APIs
>>  it is not
>>    possible to move data between IIO devices and a network or USB=20
>> card
>>  without
>>    having the CPU copy the data. This is an important problem, as
>>  high-speed
>>    ADCs and DACs are generally connected to FPGAs running Linux on a
>>  softcore,
>>    which stream their data to a workstation for further processing.=20
>> With
>>  the
>>    new API, the userspace software would simply obtain a pointer to a
>>  dmabuf
>>    from the IIO interface, and simply pass it to the network card=20
>> (this
>>  means
>>    the network stack and USB stack would also need to support=20
>> dmabuf).
>=20
> I'm curious if there are network or USB devices using dmabuf?

Not that I'm aware of, but I may have overlooked it. We're fishing in=20
exotic seas here.

>>=20
>>    An alternative would be to keep the current file-based buffer and
>>    buffer-queue-based APIs, but enhance the former one with support=20
>> for
>>    splicing (with splice()/vmsplice()). This might arguably be=20
>> easier to
>>  do,
>>    since the network stack already supports it. The problem with
>>  splicing is
>>    that the kernel swaps each data page with a fresh zeroed page in
>>  order to
>>    avoid leaking kernel memory. To be truely zero-copy, this requires
>>  the page
>>    cleaning mechanism to be offloaded to e.g. DMA, otherwise the=20
>> process
>>  isn't
>>    entirely CPU-free.
>=20
> Splice also tends to put annoying limits on size of blocks. Not=20
> totally
> sure that is an issue here but it's a pain with crypto ;)

Splice also works with memory pages, which puts more constraints on the=20
hardware since the DMA must support scatter-gather.

> I hate to say it but... 'show us your code'.  I'd love to get this
> whole area cleaned up, but I'm not sure what the right solution is.

I'll show the code once I know I'm starting with the right design ;)

> If we can get dma_buff working well I think that approach is
> a more long term solution.  However, there are other more experienced
> people in these sorts of interfaces so I'm open to alternatives!
>=20
>>=20
>>  * Parsable attribute names
>>    ~~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>>    IIO attributes follow a certain formatting that does not make it
>>  possible to
>>    reconstruct the devices/channels/attributes tree in userspace. The
>>  channel
>>    attributes are formatted as:
>>    <direction>_<type><id>_<modifier>_<extended-name>_<attribute-name>
>>    The problem is that <extended-name>, <modifier> and=20
>> <attribute-name>
>>  can
>>    contain underscores, which makes it impossible to parse. For=20
>> instance,
>>    with an attribute named "in_voltage0_high_impedence_line_enable":
>>    Is the extended name "high_impedence_line" and the attribute name
>>  "enable",
>>    or is the extended name "high_impedence" and the attribute name
>>  "line_enable"?
>>=20
>>    Since the sysfs attributes is ABI, the solution could be to have a
>>  separate
>>    sysfs file, for instance <direction>_<type><id>_extended_name,=20
>> that
>>  would
>>    contain the extended name of the channel. This should be enough=20
>> for
>>  the IIO
>>    sysfs interface to be machine-readable.
>=20
> Almost agreed :)  Call it <direction>_<type><id>_label and I'm happy.
> Label tends to come from DT bindings though, so do we need
> that and extend_name?

Great that we agree on this. We can work out the details when I send=20
the patchset ;)

> extended_name was a mistake but we are stick with that as it
> currently is.  Thankfully there aren't that many users but we can't
> touch the ones that do use it.
>=20
>>=20
>>  -------
>>  Libiio2
>>  -------
>>=20
>>  * stdio redirection
>>    ~~~~~~~~~~~~~~~~~
>>=20
>>    Right now libiio prints its debug information unconditionally to
>>    stdout/stderr, it should be modified to be able to output its log=20
>> to
>>  any
>>    valid file descriptor. While that looks simple on paper, it must=20
>> be
>>  set up
>>    before a library context is created, since the context creation
>>  itself may
>>    print debug information. This require the context allocation to be
>>  separated
>>    from its initialization, so a break of API.
>>=20
>>  * Separate allocation from initialization
>>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>>    As stated above, functions to alloc/destroy and init/deinit the
>>  various IIO
>>    structures should be separate; this would allow e.g. to set some
>>  parameters
>>    to a iio_context before the context creation happens, for instance
>>  where to
>>    redirect the debug output.
>>=20
>>  * Modular backends
>>    ~~~~~~~~~~~~~~~~
>>=20
>>    Right now the backends of libiio are tightly coupled to the core.=20
>> It
>>  would
>>    be great if the users could install only the backends they're
>>  interested in.
>>    Of course, backends could still be backed into the core library,=20
>> and
>>  that
>>    would stay the default behaviour for non-Linux platforms.
>>=20
>>    This requires two things:
>>    - The libiio backends must be able to be updated independently of=20
>> the
>>  main
>>   library, therefore they should only depend on the top-level API of
>>  libiio.
>>   Apart from a few exceptions here and there, this is already mostly=20
>> the
>>   case.
>>    - There needs to be a facility to load external backends based on=20
>> the
>>   backend name. Thanksfully with URIs this becomes easy: creating a
>>  context
>>   from the URI "foo:" would result in the backend module "foo" loaded
>>  from
>>   the disk, if not already baked in.
>>=20
>>  * Event support
>>    ~~~~~~~~~~~~~
>>=20
>>    The IIO subsystem has support for events. This allows the=20
>> userspace
>>  to get
>>    notified for instance when a temperature gets over or under a
>>  threshold.
>>    Right now, libiio cannot easily support events, as the=20
>> client/server
>>    protocol of the network backend doesn't really allow it.=20
>> Therefore,
>>  the new
>>    libiio2 library should be designed from the ground up with=20
>> support for
>>    events, and the API should offer a way to register a callback that
>>  would be
>>    called when a IIO event occurs.
>>=20
>>  * Context change detection
>>    ~~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>>    When a device is added, removed or the context becomes unavailable
>>  (e.g. the
>>    USB cable was unplugged), there should be a built-in mechanism to
>>  notify the
>>    applications using libiio2, maybe using the same mechanism as for=20
>> IIO
>>  events.
>>=20
>>    The same would apply on the local backend, if for instance a new
>>  device
>>    appears, the library should be able to pick it up and report the=20
>> new
>>  device
>>    to the application.
>>=20
>>  * Asynchronous network communication
>>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>>    The network communication between libiio and IIO is sub-par,=20
>> because
>>  it uses
>>    a synchronous request-response protocol. This causes the=20
>> throughput
>>  to max
>>    out way below the theorical maximum throughput of Gigabit=20
>> Ethernet.
>>    The communication protocol should be modified in a way that fully
>>  maximizes
>>    the throughput.
>>=20
>>    The old communication protocol should still be available and used=20
>> by
>>  default
>>    unless the two parties agree to use the new protocol. This ensures
>>  that
>>    TinyIIOD (the microcontroller variant of IIOD, the server that
>>  communicates
>>    with the network backend of libiio) can still work with the=20
>> network
>>  backend of
>>    libiio2. Alternatively, TinyIIOD could be updated to the new=20
>> network
>>  protocol.
>>    That way, the old network protocol wouldn't have to stick around.
>>=20
>>    To implement the asynchronous network communication, we could=20
>> have a
>>  look at
>>    ZeroMQ (https://zeromq.org) which seems to be designed for that
>>  particular
>>    task, and is available under a LGPLv3 license. It is however
>>  uncertain how
>>    that would work on the IIOD side (because of the zero-copy
>>  requirement - see
>>    below).
>>=20
>>    Additionally, the network backend should part ways with its=20
>> current
>>    ASCII-based protocol. This made sense when libiio was first=20
>> created,
>>  but it
>>    requires quite a complex parser on the server side that could go=20
>> away
>>  by
>>    resorting to a more classic protocol.
>>=20
>>  * Zero-copy
>>    ~~~~~~~~~
>>=20
>>    Apart from supporting the new network protocol, libiio should=20
>> provide
>>  a way
>>    to stream data between IIO devices and standard file descriptors=20
>> or
>>  sockets
>>    without having the CPU copy the data.
>>=20
>>    If a dmabuf-based IIO kernel interface is used, we need a way to=20
>> send
>>  a
>>    dmabuf to a socket, and I'm not sure that this is currently=20
>> possible.
>>    But as dmabuf are internally just scatterlists, and the sockets
>>  support
>>    splice(), that should be somewhat doable.
>=20
> I'd have a chat to the people working a lot with dma_buf
> (Sumit Semwal and John Stultz).  Seems likely they would have at least
> thought about how to do network streaming.

Thanks, I'll drop them an email.

>>=20
>>    To complicate things, IIOD (the network server) must be able to
>>  stream the
>>    same data to more than one client at a time, unless we decide that
>>  this is
>>    no more a requirement. This means that one single dmabuf would be
>>  submitted
>>    to more than one socket.
>=20
> Hmm. That may be 'interesting'.
>=20
> I'd definitely do some benchmarking of this.  People spend a lot of
> time doing zero copy tricks and sometimes it's just quicker to make
> a copy and get rid of complexity.  Hard to know until you have
> a prototype though.

Definitely, there will be benchmarks with small test apps before I=20
implement anything in libiio.

About zerocopy vs. copy: another aspect is that copying from a mmapped=20
DMA buffer means copying from uncached memory, which quickly becomes=20
the bottleneck at high speeds.

>=20
>>=20
>>    Streaming data to multiple clients using zero-copy techniques in=20
>> IIOD
>>  also
>>    implies that the data cannot be modified, which means that the=20
>> server
>>  cannot
>>    do the demuxing, and this task is devoted to the clients; so the
>>  (currently
>>    optional) server-side demuxing option would be removed.
>>=20
>>  * USB3
>>    ~~~~
>>=20
>>    Just like the network, the USB backend should be updated to be=20
>> able
>>  to reach
>>    out the maximum throughput offered by USB3.
>>=20
>>    The principal problem with USB is the short number of endpoints,
>>  which limits
>>    the functionality, as it may not be possible to stream data from
>>  different
>>    devices at the same time. Right now, a pair of endpoints is=20
>> reserved
>>  for
>>    generic commands (read attributes, open/close IIO device, etc.),=20
>> and
>>  one pair
>>    is reserved per IIO device streaming data.
>>=20
>>    There are several possibilities:
>>    - the USB backend could multiplex accesses into one single pair of
>>   endpoints, which basically do in software what USB controllers do=20
>> in
>>   hardware;
>>    - Rework the communication protocol so that only one endpoint is
>>  needed per
>>   streaming device instead of two;
>>    - Negate the problem, and consider it okay that the number of USB
>>  endpoints
>>   is a limiting factor.
>>=20
>>  * PCIe backend
>>    ~~~~~~~~~~~~
>>=20
>>    There is a need for a backend to support the PCIe cards populated=20
>> with
>>    various chips and a FPGA with a softcore running Linux. The
>>  communication
>>    between the remote OS and the host OS would be something similar=20
>> to
>>  Xillybus.
>>=20
>>  * Command queues
>>    ~~~~~~~~~~~~~~
>>=20
>>    The libiio2 API bits to use the "delayed attribute write / command
>>  queue"
>>    feature of the kernel. A command queue would contain several=20
>> commands
>>  (e.g.
>>    submit buffer, change a parameter, submit another buffer), that=20
>> would
>>  be
>>    built in the upper layer of the library using a specific API, and=20
>> then
>>    performed atomically on the remote device.
>=20
> So this does indeed suggest you are thinking to put the write queueing
> into the kernel.   I'm not sure how we can actually do this without
> ending up with really sophisticated handling in kernel (and this stuff
> really needs to be realtime).  If I were designing a platform to do=20
> this
> stuff I'd push the actual synchronization out to an fpga.

Honestly I'm not sure where in the stack it belongs. It would make=20
sense to have it in the FPGA, but then that's a non-standard feature=20
and there is no point in having that supported in libiio, which is=20
meant to be generic.

If the kernel supports "iio_filename=3Dvalue" metadata for DACs, it would=20
be possible to change a parameter at a very specific moment in time,=20
but I don't know if that's enough to cover all applications. That's a=20
question for @analog.com guys I believe.


>>=20
>>  * Buffer overhaul
>>    ~~~~~~~~~~~~~~~
>>=20
>>    Instead of having one iio_buffer, that is either pushed or=20
>> refilled,
>>  the idea
>>    would be to provide an API that allows the client application to
>>  request,
>>    enqueue or dequeue the buffers itself. This would offer much=20
>> greater
>>  control
>>    on the buffer management to the application.
>>=20
>>  * Backwards-compatibility
>>    ~~~~~~~~~~~~~~~~~~~~~~~
>>=20
>>    Backwards compatibility is not a hard requirement, but it should
>>  still be
>>    possible to be done by implementing the libiio API on top of=20
>> libiio2.
>>  Things
>>    like buffer refill/push of libiio can be implemented on top of the
>>  new buffer
>>    queue system. New features, like buffer metadata support wouldn't=20
>> be
>>    backported.
>>=20
>>    This should be considered low-priority - we're not yet at the=20
>> point
>>  where
>>    libiio1 is deprecated.
>=20
> Just a side note to this with my IIO maintainer hat on.
> Compatibility at the kernel interfaces is a must, but we do have a=20
> little
> bit of flexibility when we have good reason to think no one is using
> a given interface...
>=20
> Some interesting ideas.  Look forward to seeing how it goes!
>=20
> Jonathan

Great, thank you for the feedback!

-Paul


=

