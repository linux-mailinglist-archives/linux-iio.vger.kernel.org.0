Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E284A127F46
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 16:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfLTP2k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Dec 2019 10:28:40 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43014 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTP2k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 10:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576855717; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+LYiHdKzo9taUoZC7tqoKNr1dtjaxxNqBN/Y5XartZ4=;
        b=Cq6hm49TPbxkiJsOg96a5GFbA6+lJgY6eTHq/uNje/sY97OmEtUFeFovi4sVs9/2iTWevq
        6aoB62Ow5HIdPYWLvRLAohMerS2Yp5bgZdwYtT+Y8LnFYK4KFPEIJNjJr9HOaXAuMbQw45
        UtGC76Zzj5mjS8PniVmzlWdehTz59h8=
Date:   Fri, 20 Dec 2019 16:28:27 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Let's design the next-gen libiio!
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     jchevali@mathworks.com, dfrey@sierrawireless.com,
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
Message-Id: <1576855707.3.0@crapouillou.net>
In-Reply-To: <c97d848ec9898eb46b8adf5bda87ccb4fc8e2e2a.camel@analog.com>
References: <1575905163.3.4@crapouillou.net>
        <c97d848ec9898eb46b8adf5bda87ccb4fc8e2e2a.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Alexandru,

I wanted to delay my response to answer in a big email all the feature=20
requests and concerns that came my way, but you've been the only one to=20
answer so far and it's been more than one week now, so I'll answer your=20
comments below.



Le mar., d=E9c. 10, 2019 at 07:37, "Ardelean, Alexandru"=20
<alexandru.Ardelean@analog.com> a =E9crit :
> On Mon, 2019-12-09 at 16:26 +0100, Paul Cercueil wrote:
>>=20
>>  Hello beautiful people,
>>=20
>=20
> Hey,
>=20
> Before going forward, looking at the current backlog [on Github]=20
> would be
> an idea. There are some PRs there which are unresolved and have some=20
> real
> value.
> Like the plugin-support for libiio, and the Android build support.
> Not saying we should resolve them now, but they should get resolved=20
> in time
> [either implement or drop].

The plugin support for libiio was in my list, as "modular backends".
The PRs which are unresolved generally mean that more work or testing=20
is needed.

>=20
> There's also some static-code-checker that's running, and one of them
> [Codacy] seems to yield some interesting stuff for C# bindings.
>=20
> https://app.codacy.com/manual/commodo/libiio/dashboard
>=20
> So, going forward, a few things from my side that have cropped up in=20
> some
> time.
> I did go quickly through your list and eliminated a few [1 or 2] that=20
> were
> already there. If am repeating something, it is possible.
>=20
> Bindings:
> - would be nice for libiio to be present on pypi (for the Python=20
> bindings);
> I am not sure if this was ever a request, but the idea popped up=20
> here-n-
> there
> - Java-bindings for Android; personally, I'm not a fan of Java, but=20
> Android
> seems to be; and there was someone trying to integrate a heart-rate=20
> sensor
> with libiio on Android; which makes sense, given all the sensors=20
> people are
> putting into phones these day

About pypi: indeed, that would be a good idea. I didn't add these=20
"small features" to my list as they don't depend on a redesign of the=20
library to be brought to life, which is the focus here.

Kotlin is all the rage these days in the Android world, maybe it would=20
make more sense than Java? Or both?

>=20
> Deployment-wise:
> - there's been talk of trying to deploy libiio in Launchpad [for=20
> Ubuntu]
> and something [similar to Launchpad] for CentOS/RedHat RPMs; the main
> benefit here is ease-of-deployment with the latest libiio; people=20
> seem to
> try to get the latest, and have trouble with it

I think it's important to always have the latest version in the=20
software managers of the distributions. It's the case for=20
Debian/Ubuntu, but I don't think it's being packaged elsewhere.=20
Besides, if releases are made more often (e.g. with patch-level=20
revisions, 1.0.x versions), then there shouldn't be a need for an=20
off-the-track solution to get updates.

>=20
> Configuration-wise:
> - an alternative to XML seemed to be interesting at at time; JSON was
> preferred, but now I'm wondering if YAML would also be preferred=20
> [these-
> days]; in any case, the jump from JSON to YAML may be not as big, so=20
> JSON
> would be great as a first step; one argument against XML was=20
> libxml2's size

XML is only used internally, as a software representation of an IIO=20
context. It's never there to see or modify, so I don't really see the=20
point of switching to another markup language, besides the libxml2=20
problem you mention (but then again, there are other XML libraries we=20
could switch to). Additionally, that would mean breaking the=20
compatibility with the old libiio/IIOD, and I want to avoid that as=20
much as possible.

>=20
> Communication-wise:
> - I started getting this idea to maybe use websockets for data-stream
> communication [using libwebsockets]; the whole idea would be to maybe
> convert/add a web-server part to IIOD. This would allow people to=20
> write
> web-pages [HTML + JS] that talk directly to libiio. This would=20
> simplify
> [and maybe accelerate] some app-development; web-browsers have really=20
> great
> capabilities to display animated data, and given that there are more=20
> JS
> devs [than C++/desktop-app devs] in this world, getting things=20
> displayed is
> much faster. Also, creating simple mobile-apps is really easy with JS.
> While it sounded that I am a JS fan, I'm actually not, but it's big=20
> enough
> that it's hard to avoid it, and I do feel that it has become a gateway
> language for web & mobile [as is C for OS development].

I don't really like the idea of having IIOD exposed to the outside=20
world. This has ramifications that I'm not comfortable with, as it=20
means the server software must be fully secure, provide cryptographic=20
functionalities, etc.

Support for server-side JavaScript (via NodeJS) or PHP would probably=20
be a good alternative, I think. The server software would communicate=20
the IIO data to the client page the way it wants to.

>=20
> Misc:
> - throughput & loss-rate measurement: not sure if this should be part=20
> of
> the library, or an example app [or both], but people have been asking=20
> this
> same question many times: how do i measure my throughput and how do i=20
> check
> for losses? at least, i was never able to give a good answer here
> - profile support: this is something from Lars; but for some more=20
> complex
> devices, configuration is challenging; so, something to load all
> configuration params, and perhaps save them back, would be=20
> interesting;
> this has been pushed to apps, but who knows? maybe libiio? i am not=20
> sure
> how valid this is

The throughput and loss-rate measurement would be easy to obtain if=20
there was a mechanism built into IIO to report overflows/underflows.=20
This is definitely something that we want and need, yes.

About profile support, I didn't list it here, because I consider it a=20
side project - it should be its own library, "libiioprofile" if you=20
want, which would use libiio, and not a mechanism built into libiio.

>=20
> I guess for now, this is mostly it.
> Not sure if I forgot anything, but these were collected from various=20
> parts
> of memory, notes and some issue trackers.

Thank you very much for taking the time to answer.

Cheers,
-Paul


>=20
> Thanks
> Alex
>=20
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
>>=20
>>    To complicate things, IIOD (the network server) must be able to
>>  stream the
>>    same data to more than one client at a time, unless we decide that
>>  this is
>>    no more a requirement. This means that one single dmabuf would be
>>  submitted
>>    to more than one socket.
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
>>=20
>>=20

=

