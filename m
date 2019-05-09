Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41B1877C
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 11:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfEIJKH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 05:10:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:15149 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEIJKH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 05:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1557392996;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=gbUNFATHovNAGfREw8LHI9EbrlHjAvpJ+Pcgy/DMnY4=;
        b=oawbiMTT9oqUXofs8EInPzTaXUtV7hOQsI4r4TcsBYRDbaq1BQQOWfbHLSvXgon/PU
        0yumaDMlDq9H+6FLkNE2GdlwmrHjCxCY0B0poi80QwfO5vPNsvYywekB/VA7s7wEAfKf
        2v1XdqaDCigB+zbyu8vvdfm1V/MinVZy4dRYABo7NA3JQfwLIIA+DFBHEuBB08PRauZX
        35qtPS+L63WwKOcsFCdt6uuR+MTWOmC7wF1NUUl4L1HE4UTT/qz+lGNWrAl0Hs9A/C9m
        EqkEihcJaWh+NUaUGiyhAEjt5sW5MKrzS6wt6Bn43zFeAp6eeSMHs0m9Gzj136hk3+GX
        ajUg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMiw43lhJc="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id j04dc1v4999QJMu
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 9 May 2019 11:09:26 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers to create a /dev/input interface
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190422152014.7c6637ab@archlinux>
Date:   Thu, 9 May 2019 11:09:26 +0200
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-input@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA9A9410-C393-49B9-81FA-D9BC55F04468@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com> <20190407133037.0ad98897@archlinux> <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com> <20190414124029.1f1f6084@archlinux> <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com> <20190422152014.7c6637ab@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,
sorry for the delayed response, but I have to focus on other topics now.

Just some small comments came to my mind to finish the discussion, =
mainly on the accelerometer in the lid case (see inline below).

BR and thanks,
Nikolaus


> Am 22.04.2019 um 16:20 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> On Mon, 15 Apr 2019 23:04:15 +0200
> H. Nikolaus Schaller <hns@goldelico.com> wrote:
>=20
>> Hi Jonathan,
>> we seem to have opposite goals and therefore quite different ideas =
what the right
>> solution is.
>=20
> Yup :)  Yikes this email has gotten complex.  Hopefully I haven't
> lost track of the various points below.
>=20
>>=20
>> I come from user-space and the input side, find that input can handle =
abstract "acceleration input",
>> and some older chip drivers even provide that as their only =
interface. Therefore I want
>> to provide "acceleration input" in these cases where only iio capable =
drivers exist by
>> using the existing in-kernel-iio infrastructure. Nothing more.
>>=20
>> You seem to come from the iio architecture and want to extend it to =
other APIs as
>> general as possible and input is just one of several of them.
>=20
> Yes, my target is to produce a subsystem that meets many (all would be =
nice)
> requirements, including yours.  Whilst I'm happy to debate this for =
ever, I'm not
> sure we are making any substantial progress.  As you mention below we
> probably need to 'see the code' to drive the discussion forwards.
>=20
>>=20
>> Different goals usually lead to different solution architectures.
>=20
> Indeed, but in this case we have your proposal which is a subset of =
what
> I am suggesting.  One architecture can fulfil both requirements.

Not exactly. Yours always needs configuration in every case. My RFC =
works without
user-space config support for the most common cases. This user-space =
config must
be maintained and spread over all distributions. So we can never be sure =
that
if a user changes the distro that it still works.

>=20
> I'll leave it for the other thread, but Bastien has raised the case
> (that I'd forgotten) that there already userspace stacks that are
> capable of happily taking in both IIO and Input devices.  The =
confusion
> here is they will now discover 'both' without the existing userspace
> knowing that they are the same device.  We need to be very careful not
> to break those userspace programs.
>=20
> So this is an illustration of why the simplistic case doesn't work
> 'now'.
>=20
>>=20
>>> Am 14.04.2019 um 13:40 schrieb Jonathan Cameron <jic23@kernel.org>:
>>>=20
>>> On Mon, 8 Apr 2019 15:15:56 +0200
>>> H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>>=20
>>>> Hi Jonathan,
>>>>=20
>>>> I still do not fully understand what is worrying you here. =20
>>>=20
>>>>=20
>>>> Do you worry about functionality, flexibility or resources or =
something else? =20
>>>=20
>>> Two main things:
>>> 1) Lack of generality of the approach.=20
>>>  This is a single use trick for input devices. Why does it make =
sense for
>>>  input devices? =20
>>=20
>> No, it is not a trick...
> Bad choice of words. Sorry about that.
>=20
> Any time we register a device as two types of device it is less than =
ideal.
>=20
> If we had the true separation of IIO front end and back end then it
> would be perfectly acceptable to 'only' have an input front end for
> a given device.  That choice would still, in this sort of usecase,
> have to be made from userspace. It's policy, not design.  If there are =
reasons
> a particular device 'is input' then that mapping should be in DT or =
similar.
> It's no different from knowing an ADC channel is wired to an analog
> temperature sensor.  For example, you could build a joystick with
> an accelerometer in the stick - then the usecase would be obvious!
> Hence I would also argue that any dynamic interface should also =
support
> a static path (DT or equivalent) for the cases where is really a
> physical characteristic of the system!  Perhaps the Sony parts
> fall into this category as well.
>=20
> For a bit of historical background, there was a concerted effort
> to produced a userspace stack for IIO for android. =20
> https://01.org/android-iio-sensors-hal
>=20
> Unfortunately I think it died as a result of other moves in Intel on
> one of their periodic shifts in direction.
>=20
>>=20
>> Why does it make sense for input devices?
>=20
> These are not just 'input' devices. They are accelerometers. One =
usecase
> is to use them for input.  The exact same physical device is used for =
games
> input uses and counting steps for example (actually a lot wider cases =
than
> that, but this one is common in android devices).
>=20
> Keep that in mind at all times. There are lots of usecases.
> So we need a solution that does not result in problems for those
> usecases.  We are not writing a subsytem targetting android use of
> accelerometers. We are writing a subsystem addressing as many usecases
> as we can of those devices.
>=20
> Note that the original reason for IIO was to generalize a whole set of
> proposed individual subsystems targeting particular sensor types. So
> that is our focus - solutions that work for everyone.  This isn't
> totally dissimilar from those discussions - at the time I wanted
> to do a small focused ALS subsystem and got a resounding "no" from
> Linus.  Generality matters a lot for the long term.
>=20
>>=20
>> a) because there is no alternative for accelerometer input devices =
and there are some
>> (older) accelerometer chips which only present themselves as input =
devices as soon
>> as the driver is compiled and the chip is found.
>=20
> Actually that is not accurate.  The vast majority of those older =
devices
> that have had any attempt at mainlining are in IIO. AFAIK no =
accelerometer
> driver has been merged to mainline input for many years. This is =
because,
> amongst others, Dmitry has been of the view they didn't belong there =
for
> a very long time.
>=20
>>=20
>> b) because input events define ACCEL input devices. But no =
Temperature or Voltage
>> input or generic ADC input.So there is no generalization of input =
devices beyond
>> keyboard, mouse, joystick, accelerometer and some others.
>=20
> That's not totally inaccurate, but the distinction in the other sensor =
cases
> is that there is a clear 'additional' element that we can map in =
devicetree
> which relates the IIO sensor channel to the input device.
> Doesn't matter for the point of view of this discussion though.
>=20
>>=20
>>> There are lots of other in kernel users and potential
>>>  ones in the future. =20
>>=20
>> This bridge addition does not exclude any (additional) in-kernel use.
>=20
> No but it creates several problems:
>=20
> 1. Two ways to do the same thing.=20
> 2. Two sets of code to maintain.
> 3. Confusion over what is the best way of doing it.
> 4. The known issues with multiple consumers (note my solution has
> that problem as well!)
>=20
> My job here is to maintain the code, which is why I push back on =
something
> that makes that job harder.
>=20
> When the next usecases comes along and someone says they want to map
> all ADC channels to hwmon channels because that is the subystem that
> they expect to measure voltages in, then I don't have a good argument
> to stop them doing the same thing you have.
>=20
> As a side note we have in the past had input drivers for gyroscopes =
and
> magnetometers.  Why are accelerometers special?
>=20
> I really don't see why we should treat accelerometers differently

Not special. I just did not want to add them yet in the RFC phase.
The principle is the same.

>=20
> As this discussion runs on, I am increasingly convinced that there =
*must*
> be a userspace policy control over whether an input device is
> instantiated for a given accelerometer.   Once that is the
> case then I cannot see a reason to treat it any differently from
> other channel types.

Well, I believe that we should avoid any user-space policy control that
can be avoided. At least those cases that can live without policy
control should not need to get one because there are other cases that
need one.

This is something we can't solve by discussion, of course.

The decision is that you are maintainer and I am just proposing an RFC.
So you have two votes and a veto right...

But maybe this can be fixed by proper defaults? I don't know.

>=20
>>=20
>>> The ability to register additional IIO consumers like
>>>  this is useful, lets make it useful to everyone. =20
>>=20
>> But not everyone and every iio device can and should be mappable to =
the "input" abstraction.
>> This does not make any sense to me.
>=20
> Absolutely.  It should not be.  I clearly didn't explain this well.
>=20
> It should be mapped to a consumer.
>=20
> One type of consumer is iio-input, another is iio-hmwon etc.
>=20
>>=20
>> For example, does it make sense to map a temperature sensor to =
accelerometer input? Or an
>> accelerometer to hwmon? This seems to be possible of your =
generalization unless I am missing something here.
>> If it is, it ignores that iio sensors are already grouped by what =
physical property they do measure.
>=20
> If people want to map crazy channels to crazy sensor outputs, why stop =
them?
> (at this level of the interface).
>=20
> This is a policy question for a userspace script.  Particular consumer =
drivers
> could of course perform sanity checking and refuse to do anything if =
they
> cannot sensibly use the channels.
>=20
> Yes, the interface has this flexibility. Which is a good thing!  Take =
the example
> of the gyroscope as input I used above.  If we want to add that =
support
> in future to your driver (I have no idea if it actually makes sense)
> then we can - without having to change the interface.
>=20
>>=20
>>>=20
>>> 2) To much generality of the specific usecase.  I don't want to put =
an Input
>>>  interface on accelerometers where it makes no sense. =20
>>=20
>> I think you can just ignore the input interfaces in that case, if it =
was created.
>=20
> Bastien raised a case where this isn't true.
>=20
>>=20
>>> The rule of it has
>>>  2-3 axis so it must make sense isn't good enough to my mind.  How
>>>  does userspace know which accelerometer to use (more and more =
devices have
>>>  multiple?) =20
>>=20
>> In our approach user-space can make it known by udev rules based on =
/dev/input/event*
>> (not on iio but the input created for accelerometers). I think I =
mentioned that. This
>> comes for free for any device registering as input. So it is no =
additional code.
>=20
> Sorry, I'm lost.  What in there tells you to use 'this' interface =
rather than one
> of the other N that were registered?  I'm not sure what information =
you
> have available there.
>=20
>>=20
>>> You could do something like looking at the location info from
>>>  DT / ACPI in your driver and pick the 'best' but that's policy. =
Should be
>>>  in userspace.  Sure you can just use the right input driver, but =
the moment
>>>  we do that, we need aware userspace, if that's the case why not =
make it
>>>  aware from the start.
>>>=20
>>> Believe me I've been round this one a good few times and thought =
about it
>>> a lot. =20
>>=20
>> That is fine and why we should discuss all the different aspects we =
have collected.
>>=20
>>> I'll take a lot of convincing that this isn't a problem that
>>> should be pushed into userspace.
>>>=20
>>>>=20
>>>> I think having them mapped always does not need much resources =
(except a handful of bytes
>>>> in memory and some =C2=B5s during probing) unless the event device =
is opened and really used.
>>>> Only then it starts e.g. I2C traffic to read the sensors. =20
>>>=20
>>> The bytes don't really mater. =20
>>=20
>> Ok, good to know.
>>=20
>>> The userspace ABI additions do. =20
>>=20
>> There are only new /dev/input/event devices with well defined ABI. =
This approach does
>> not invent anything new here, hence there are no ABI additions which =
we can break.
>=20
> But it does - we aren't talking general ABI, but ABI on specific
> devices.  Sure, Android doesn't care - though you'd be amazed how much
> individual android device developers will because we just added =
another
> pile of tests to their CI.
>=20
> An industrial sensor platform absolutely does.  They have to validate
> those interfaces.  They can't just ignore them because they feel like
> it because who knows if some future user will use them?
>=20
> For another case, see Bastien's reply to the later thread.
>=20
> Instantiating interfaces has testing costs, even when the are standard
> interfaces.
>=20
>>=20
>>>=20
>>>>=20
>>>> So it is just some unused file sitting around in /dev. Or 2 or =
could be even 100.
>>>> For devices which have no iio accelerometers configured, there will =
be no /dev/input
>>>> file. So we are discussing the rare case of devices with more than =
one or two accelerometers. =20
>>>=20
>>> Well they aren't exactly rare in IIO using systems ;) =20
>>=20
>> This is another thing where our experiences differ. What specific =
devices are you thinking
>> of? I am focussed on handhelds where the accelerometer (or two) is a =
way to do GUI input
>> depending on device orientation in space.
>=20
> Again, you are introducing this interface for everyone. Including lots =
of
> 'interesting' usecases.
>=20
> I have worked with sensor platforms with accelerometers of different =
parts of humans,
> We have people do bridge vibration measurement, flying UAVs and =
tracking the motion
> of trucks.
>=20
> Most are not huge numbers of accelerometers per node but don't rule =
out the
> possibility.  It's normally limited by length of cables rather than =
anything
> else so you used multiple nodes after a while each with their own set =
of sensors.
>=20
> There are lots of plaforms out there that use multiple accelerometers =
in more
> or less the same place to do very high dynamic range measurement =
(without losing
> precision when things are nearly still).
>=20
> Anyhow, it's not a particularly important point anyway!
>=20
>>>=20
>>>>=20
>>>> Now, on every system there are many interfaces and files that are =
not used because it makes
>>>> no sense to look at them. If I check on one of my systems, I find =
for example a lot of
>>>> /dev/tty and only a very small portion is used and generic distros =
have no issue with it.
>>>>=20
>>>> There is even /dev/iio:device0 to /dev/iio:device5 representing the =
raw iio devices.
>>>> Not all of them are actively used, but they are simply there and =
can be scanned for. =20
>>>=20
>>> Agreed, in the ideal case we wouldn't have had that either, but we =
are
>>> stuck with it.  The long term plan is to allow use of IIO backends =
without the
>>> front end being there at all. Lots of SoC ADC users would prefer =
this. We are
>>> stuck with the legacy intertwining fo the front end and back end of =
IIO so
>>> this isn't as easy to do as I would like. =20
>>=20
>> Ah, ok. I think it is a similar discussion of hiding the serdev =
/dev/tty* if it is
>> used for accessing an embedded GPS or Bluetooth chip, for example.
>>=20
>> But is this needed? I think it is not a problem if there are multiple =
consumers for
>> the same iio channel. Some in-kernel, some through /dev/iio:device* =
and maybe some
>> through /dev/input (which boils down to in-kernel).
>=20
> There are quite a few complexities around multiple consumers that we =
really haven't
> solved.  Right now the cases that work are very much restricted.  I'd =
love
> to tidy some of these up, but never enough time and all that.
>=20
> It's not that relevant here, but in short a few of the issues are:
> 1) Interference over control settings.  - Two consumers need different =
filter
>   settings/ sampling frequency / range.  How do we negotiate the =
choice and
>   communicate it to the other consumers.  More complex questions such
>   mediating choices of triggers.
> 2) One driver is doing polled reads, the other is doing interrupt =
driven.
>   Most drivers prevent this combination because the polled reads can =
lead
>   to unlimited delays on the interrupt driven path and hence break it.
>=20
> The main driver for this separation was to present only the 'right' =
interface
> to reduced people's validation costs etc.  People really do want to =
have the
> option to strip back the userspace inteface.  Obviously these are the =
rare
> people who would disable your config option, but the point of this was
> that we actually would like to make even the IIO interface optional as
> well but have a fair way to go before we can.
>=20
>>=20
>>>=20
>>>>=20
>>>> So I do not see a resource problem if every accelerometer =
/dev/iio:device* gets
>>>> some companion /dev/input/event* for being used on demand - but =
only if this bridge
>>>> is configured at all. =20
>>>=20
>>> That argument does not apply. If we add a config option, distros =
will enable it.
>>> So the vast majority of systems will ship with this turned on.  You =
cannot
>>> use a config variable to control policy and expect it to be change =
by anyone
>>> but a very very small subset of users.  So please drop the 'you can =
just not
>>> build it argument'. =20
>>=20
>> This is not my point here. I mention this under the (now known to be =
wrong) assumption
>> that resources do care. I just want to state that kernels built for =
platforms where every
>> byte counts can be stripped down by disabling it. Others where =
resources are no concern
>> simply can map them all, even if not used.
>=20
> Agreed. A subset of users will just build without this.
>=20
>>=20
>>> Userspace configuration changing is a lot easier if people actually =
care.
>>> Sure, many distros will ship the same script to everyone.
>>>=20
>>>>=20
>>>>> I think we need some deliberate userspace interaction to =
instantiate
>>>>> one of these rather than 'always doing it'.   =20
>>>>=20
>>>> My gut feeling is that this additional user-space interaction needs =
more resources and
>>>> adds a lot of complexity, independently of how it is done. =20
>>>=20
>>> Trivial resources and actually fairly trivial complexity.  Key thing =
is
>>> it puts the burden on the users of this functionality to configure =
what they
>>> want. =20
>>=20
>> Hm. No. My proposal does not need configuration which accelerometers =
should go where.
>=20
> Agreed. I was talking about my proposal here :)
>=20
>>=20
>> I assumethat input accelerometer users do not want to configure =
anything, like neither
>> a mouse or keyboard is to be configured to be useable (yes there are =
keymaps but that
>> is impossible to automate).
>=20
> The difference is a mouse is only really useful as a mouse and most of =
the time a keyboard
> is a used only as a keyboard.  Here that's not true.
>=20
>>=20
>> They just want to be able to read device orientation in a =
device-independent scale.
>> Therefore my approach already takes the mount-matrix into account to =
hide sensor position
>> differences.
>=20
> And how does that work on the common case of a sensor in the lid of a =
laptop?
> how do you know what angle the screen is at? =20

Well, I am not aware of laptops where the sensor is in the lid because I =
am in the handhelds
business, but let's assume it is common.

I realized that if the sensor orientation is related to the lid =
position, while the reference
frame reported to user space is to be referenced to the lap or keyboard =
of the laptop, there does
not exist a static mount-matrix to describe it properly. So no driver =
can report that correctly.

Therefore, such a device needs a dynamic mount matrix, i.e. there should =
be a kernel driver that
reads out the lid angle sensor and modifies the mount-matrix of the =
accelerometer by some sin()/cos()
table.

Well, you can delegate this to the user-space. But IMHO this is wrong =
layering. Every layer
put on top of the lower layers should abstract away implementation =
details so that the highest
layer has the most general interface.

In my view we have here this "protocol" stack (casting into the ISO =
7-layer model):

	L7: application - user space
	L3: input - to get device orientation information
	L2: iio - to get raw data and mount-matrix
	L1: i2c, spi, usb, hdq, ... - to get bits from/to chips
	L0: chips, ...

My RFC mainly mangles the raw data reported from the iio level and the =
mount matrix into
device orientation information. I.e. it is a proposal for L3 =
implementation.

So fixing an issue of L2 (dynamic mount matrix for lid angle) in the =
user-space layer would be improper
layering.

So there are two possibilites:
a) make the mount-matrix dynamical as described above in L2
b) extend my RFC to handle this special case


> One oddity to note here is that until very recently we deliberately =
didn't register
> certain ACPI IDs because they confused userspace by reporting two =
accelerometers
> without any info on which was in the lid.  Thankfully proper handling =
of that
> is no being sorted.  It's still mostly a case of just deliberately =
ignoring one
> of the sensors.
>=20
>>=20
>>>=20
>>>>=20
>>>> And I think is even less flexible than "always doing it". Let me =
explain this claim.
>>>>=20
>>>> For me, the kernel should present everything the hardware supports =
to user-space
>>>> in better digestable device files or APIs (without making any =
assumptions about the
>>>> user-space code). =20
>>>=20
>>> Agreed, we just have a different view on how this should be done. I =
want
>>> it to be dynamic and extremely flexible, you want the easy way of =
just
>>> putting a fixed set out all the time.
>>>=20
>>>>=20
>>>> Then, every user-space that will be installed can find out what the =
hardware supports
>>>> by looking at standard places.
>>>>=20
>>>> E.g. it can scan for all mice and keyboards. And for all input =
accelerometers. =20
>>>=20
>>> Or, you an have the correct 'fairly trivial' userspace setup to scan =
for all
>>> registered accelerometers and 'on demand' create the bindings to =
bring them up as
>>> Input accelerometers if that is what makes sense for your platform. =20=

>>=20
>> Why not scan for input accelerometers and leave it as an =
implementation detail that
>> the kernel does serve the physical chips through the iio =
infrastructure?
>=20
> If we could separate the IIO front end from the IIO backend I would =
agree that
> would be another valid -userspace- policy.
>=20
>>=20
>> IMHO some user-spaces may already be scanning all */input/event* and =
check for
>> the device property INPUT_PROP_ACCELEROMETER.
>>=20
>> This is a discussion mainly about proper encapsulation of lower level =
differences.
>>=20
>>>=20
>>>>=20
>>>> If the kernel is hiding some chips and needs some initial =
user-space action before
>>>> presenting them all, this requires that the user-space has some =
a-priori knowledge
>>>> about which specific devices it should ask for. =20
>>>=20
>>> No more that it needs to know which accelerometer to use? =20
>>=20
>>>=20
>>>> So it does not really need to scan
>>>> for them. Because it must already know. Obviously in some mapping =
table stored at
>>>> a well known location inside the rootfs image. =20
>>>=20
>>> No. Let me give some more details of how this would work.  It's =
really just
>>> a more flexible version of what you have.
>>>=20
>>> A distro, or individual user decides to put the relevant script in =
place for the
>>> following:
>>>=20
>>> 1. Userspace detects a new accelerometer driver, via the standard =
methods (uevent)
>>> 2. Userspace looks to see if it has the required properties. Now =
this includes things
>>> like detecting that it is the accelerometer in the lid of a laptop - =
if so do not
>>> register it as an input device.  If it's in the keyboard then do =
register it.
>>> 3. Userspace script then creates the files in configfs
>>> /sys/kernel/config/iio/maps/
>>> (this interface needs appropriate definition)
>>> Maybe...
>>> /sys/kernel/config/iio/maps/iio_input/iio_device:X/accel_x, accel_y, =
etc
>>> When done it writes to the bind file
>>> /sys/kernel/config/iio/maps/iio_input/iio_device:X/bind
>>> which instantiates the input driver.
>>>=20
>>> This moves all of the policy decision into userspace, where it =
belongs.  If
>>> we want to enable a particular accelerometer on a particular board =
because it
>>> actually works better than the one the default policy says to use, =
then we can
>>> do so.
>>>=20
>>> The resulting infrastructure is much more general, because it lets =
us do the
>>> same for any IIO consumer.  This input bridge is not a special case. =
It works
>>> equally well for the existing hwmon bridge any would even let us do =
things
>>> like provide the information from userspace that we have an analog =
accelerometer
>>> wired up to an ADC on some hacker board. =20
>>=20
>> Ok, understood.
>>=20
>> My approach triggers input uevents:
>>=20
>> 1. kernel detects a new iio accelerometer (looks like an analog =
accelerometer should be
>>   the DTS child of an iio adc and then iio should create an =
accelerometer and not a voltage
>>   channel)
>=20
> Yes ultimately it would be a child device that would be it's own IIO =
device. We
> already have this for some gyroscopes.
>=20
>> 2. iio-bridge registers as input event
>> 3. this triggers an uevent
>> 4  an udev-rule can detect the properties and map it to some =
"speaking" name like
>>   /dev/input/main-accelerometer, /dev/input/lid-accelerometer etc. Or =
if the
>>   accelerometer is to be ignored, it does not get a "speaking" name =
at all.
>>=20
>> The required udev rules are stored in user space and are of course =
user-space and application
>> specific. But this does not require to invent some new configfs stuff =
and special scripts
>> in user-space. Just install some udev rule at a well established =
location in file-system.
>=20
> I'm not sure there is any significant difference between you creating =
a mapping like
> this an udev rule that creates the whole mapping.  Bit more to do =
perhaps but it's
> nothing particularly special that I can see.  Sure there is new kernel =
support to be
> done.
>=20
>>=20
>> Yes, this does not cover arbitrary mappings. But what are arbitrary =
mappings good
>> for? Your scheme seems to be able to map a light sensor to =
accelerometer input.
>> Does this "full matrix of everything is possible" really make sense?
>=20
> =46rom a generic interface point of view - yes it absolutely does.
>=20
> We define an interface that covers all usecases rather than a whole =
set of
> separate ones that cover individual corner cases.  That way we don't =
have to
> keep defining new interfaces.
>=20
> The individual drivers can easily do validation of what they are =
provided with.
>=20
>>=20
>> I can't decide because I have no need for it. Others may have.
>>=20
>> But another thought: does it interfere with this input-bridge? =
Probably no. You can
>> still add your configfs approach for general iio devices to e.g. =
hwmon mappings. Even
>> as an alternate method of creating input devices (enabled only if my =
input-bridge is
>> disabled).
>=20
> Yes see above.  Both approaches meet your requirement (I think =
anyway).
> I do not want to see two long term solutions to the same problem.
>=20
> I'm interested in a long term sustainable solution so I want to see
> the generic one.
>=20
>>=20
>>>=20
>>>=20
>>>>=20
>>>> This seems to make it impossible to develop a generic distro rootfs =
image - without
>>>> asking the user for manual configuration. And that where the kernel =
already knows
>>>> this (which iio accelerometers do exist for a specific piece of =
hardware).
>>>>=20
>>>> This is why I believe a mechanism to instantiate only on demand =
isn't adding but
>>>> removing flexibility because it prevents copying a rootfs from one =
device to another. =20
>>>=20
>>> I disagree, see above.
>>>=20
>>>>=20
>>>>>=20
>>>>> As I mentioned in V1, look at the possibility of a configfs based =
method
>>>>> to build the map.  It's easy for userspace to work out what makes =
sense to
>>>>> map in principle.  There may be some missing info that we also =
need to
>>>>> look to expose.   =20
>>>>=20
>>>> With a "may be missing" it is impossible to write code for it...
>>>> Can you please name which information is missing on the input =
accelerometer
>>>> API? =20
>>>=20
>>> See above. It's not the input accelerometer ABI, it's the missing =
ability
>>> to instantiate IIO maps from user space.
>>>=20
>>>>=20
>>>>>=20
>>>>> In general, userspace created channel maps would be very useful =
for
>>>>> other things such as maker type boards where they can plug all =
sorts
>>>>> of odd things into ADC channels for example.   =20
>>>>=20
>>>> Ok, I understand, but this is a different problem where this =
iio-input-bridge is not
>>>> intended to be a solution. Generic ADCs are not input devices. Like =
SD cards are not
>>>> keyboards.
>>>>=20
>>>> So we should not try to mix the idea of general mapping with this =
input-bridge for
>>>> input accelerometers. =20
>>> Yes we should. You are proposing a solution that is a subset of the =
larger
>>> problem set. =20
>>=20
>> Yes, of course. Because I did not see or know about the general =
problem set.
>> And I still don't see a need for user-space controlled mapping for =
input-accelerometers.
>=20
> We are clearly going to differ on this.  Bastien gave one example for =
why
> this is required.  There will be others.
>=20
>>=20
>>> Why introduce a stop gap like this when we can do it correctly
>>> and provide something useful for all those other use cases.
>>>=20
>>> The only difference here is the uevent triggered script that creates =
those maps
>>> for your particular usecase. =20
>>=20
>> Well, I am a friend of solving one problem after the other in smaller =
steps than
>> immediately aiming at a very general solution, which has side-effects =
of inventing
>> new stuff for things that would work without.
>=20
> That works in a world where you can drop the previous approach as part =
of your
> generalization.  When you are playing with kernel / userspace ABI then =
it
> doesn't. Ideally you have to figure out the extensible general =
solution at the
> start because you are stuck maintaining the 'small steps' for many =
years to
> come.  I don't want to perpetually 'have' to export all 3D =
accelerometers as
> input devices, because we didn't have the ability to chose which =
should be
> exported at some point in the past.
>=20
>>=20
>>>=20
>>>=20
>>>>=20
>>>> BTW, there is a way to define additional mapping using udev rules =
which symlink the
>>>> /dev/input/event* paths to stable names like =
/dev/input/accelerometer.
>>>>=20
>>>> This comes without additional code and is already provided by udev =
and the input system.
>>>>=20
>>>> So in summary, I have not yet seen a convincing scenario where =
being able to dynamically
>>>> map iio channels to input devices seems beneficial. =20
>>>=20
>>> That is true for the narrow case you are talking about. I don't want =
to see that
>>> narrow case solved in a fashion that effectively breaks solving it =
properly. =20
>>=20
>> How does it break your approach if added later? The more I think =
about it they are
>> not incompatible. It is just useless to apply both in parallel.
>=20
> The reality is that if we put one in first that will used for ever =
because there
> will be devices out there using it.  Therefore we have to maintain =
both for
> ever.
>=20
>>=20
>>> If we add this, we have to export all accelerometers for ever under =
all circumstances
>>> to userspace, because to remove it will break existing userspace.
>>>=20
>>> If we stand back and work out if we can do the general solution now, =
we avoid
>>> this problem. =20
>>=20
>> We get a different problem that we break existing user-space that =
simply wants to see
>> an /dev/input/accelerometer without doing more than an existing udev =
rule.
>=20
> I would love to say such a userspace doesn't exist, but reality is =
there are
> all sorts of hideous things out there.  There are cases that deal with =
this
> as an option of course (such as Bastien's sensor-proxy)
>=20
> The number of devices that are supported under mainline as input =
accelerometers
> is pretty small.  It's not a perfect world unfortunately but having to =
add a
> small udev script is at least not a major break if we do cause it.
>>=20
>>>=20
>>>>=20
>>>>>=20
>>>>>>=20
>>>>>> This driver simply collects the first 3 accelerometer channels as =
X, Y and Z.
>>>>>> If only 1 or 2 channels are available, they are used for X and Y =
only. Additional
>>>>>> channels are ignored.
>>>>>>=20
>>>>>> Scaling is done automatically so that 1g is represented by value =
256 and
>>>>>> range is assumed to be -511 .. +511 which gives a reasonable =
precision as an
>>>>>> input device.   =20
>>>>>=20
>>>>> Why do we do this, rather than letting input deal with it?  Input =
is used
>>>>> to widely differing scales IIRC   =20
>>>>=20
>>>> Well, it can't be done differently... And what I call scale here is =
nothing more than
>>>> defining ABSMIN_ACC_VAL and ABSMAX_ACC_VAL.
>>>>=20
>>>> We need to apply some scale since iio reports in (fractional) units =
of 1g, i.e. values
>>>> of magnitude 1. =20
>>>=20
>>> m/s^2 not g, but doesn't matter for the point of view of this =
discussion. =20
>>=20
>> My fault. The driver takes care of this in the scaling formula so =
that "input" reports
>> MAX/2 for 1g.
>>=20
>>>=20
>>>> These are not adaequate for input events which use integers. So we =
must
>>>> define some factor for iio_convert_raw_to_processed() to scale from =
raw value range
>>>> to int value range. We could report raw values but this would be an =
improper abstraction
>>>> from chip specific differences. =20
>>>=20
>>> Hmm. I can see we perhaps need some mapping, but is there a concept =
of standard scale
>>> for existing input accelerometers?  How is this done to give for =
other input devices
>>> such as touch screens?  I'd expect to see a separation between =
scale, and range.
>>>=20
>>>=20
>>>>=20
>>>> BTW: the range (and therefore the factor) is reported through the =
evdev driver to user-space
>>>> (evtest reports Min and Max as you can see in the example).
>>>>=20
>>>> The most important thing is that this is a hardware independent =
definition. Every accelerometer
>>>> chip will report this range. So you can easily upgrade hardware or =
switch accelerometers
>>>> without touching user-space calibration. Like you can replace =
ethernet controller chips but
>>>> networking works the same with all of them. =20
>>>=20
>>> Agreed, it needs to be hardware independent by the time it hits =
userspace, but I would
>>> have thought that scaling would be done in input, rather than IIO. =
It's hardly
>>> a problem unique to our usecase!
>>>=20
>>> Perhaps Dmitry can give some advice on this. =20
>>=20
>> Yes, that would be helpful.
>>=20
>>>=20
>>>>=20
>>>>=20
>>>> Hm. Is there an alternative to attach such private data to an =
struct iio_dev
>>>> allocated by someone else? I have not found one yet.
>>>>=20
>>>> Or can I add some void *input_mapping; to struct iio_dev? Depending =
on
>>>> #if defined(CONFIG_IIO_INPUT_BRIDGE)? =20
>>>=20
>>> Yes, add a new element. =20
>>=20
>> Ok, works fine.
>>=20
>> I already have found one case of iio accelerometer driver where it =
did make a problem
>> not using a special element.
>>=20
>>>>>=20
>>>>> iio_input_find_accel_channel(indio_dev, chan, &numchans);
>>>>> iio_input_register_device(indio_dev, chan, numchans);   =20
>>>>=20
>>>> Well, that looks like it needs some temporary storage of dynamic =
size
>>>> and loop twice over channels for no functional benefit. =20
>>>=20
>>> Use fixed size. The worst that happens is we end up with it being
>>> an entry larger that it needs to be.
>>>=20
>>>> And handle the
>>>> special case of numchans =3D=3D 0 (the proposed code simply does =
not call
>>>> iio_input_register_accel_channel and does not register anything).
>>>>=20
>>>> So I'd prefer to follow the "KISS" principle and register single =
channels
>>>> instead of a set of channels. =20
>>>=20
>>> Well we disagree on this.  A singleton approach like used here
>>> is to my mind not KISS.  I would rather see what is there then
>>> act as two simple steps, rather than interleave two different
>>> actions with a totally different path for the first channel found.
>>> If there is only one channel you just built a load of infrastructure
>>> that makes no sense.  If you scan first then you can know that
>>> before building anything. =20
>>=20
>> Ok, this is more a matter of taste and resource requirements can =
probably
>> be neglected. I'll update the driver.
>>=20
>> So in summary, I'll post a v3 that fixes some bugs of v2 (because we =
need
>> them fixed for our production systems as well).
>>=20
>> Then it is up to you if you want to take this approach or want to =
write
>> a full version following your concept. Or if it is possible as I =
assume, we
>> can have both.
>=20
> Thanks. I think we need at some code for what I was proposing to =
discuss
> much further. Unfortunately it may be a little while before I get time =
to
> work on that.  Hopefully not too long though!
>=20
> Jonathan
>=20
>>=20
>> BR and thanks,
>> Nikolaus
>>=20
>=20

