Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD251A79D
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 12:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfEKKyu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 06:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfEKKyu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 06:54:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8933C2146F;
        Sat, 11 May 2019 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557572086;
        bh=tOxRk6/vqjb6nalcTw7v8xT8B7CUvW3J1I+g4sBf1iY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nKDVoxhMvE0d46P+qMgnl+NqoRn2QiC0kVEiA0543zPtmODickhBFattmy+0zARAe
         e0OuVwlkz7fqyMqt+ITARtnTCSKJHH6zjKR9VQZb6RdfEH8o3qwdpTCGj0Gq7przt/
         CsUlrUfAnX3K3H8OsZ077q3/CQ43dhZhuD/51RJA=
Date:   Sat, 11 May 2019 11:54:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-input@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
Message-ID: <20190511115440.3c0eb41a@archlinux>
In-Reply-To: <CA9A9410-C393-49B9-81FA-D9BC55F04468@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
        <20190407133037.0ad98897@archlinux>
        <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
        <20190414124029.1f1f6084@archlinux>
        <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com>
        <20190422152014.7c6637ab@archlinux>
        <CA9A9410-C393-49B9-81FA-D9BC55F04468@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 May 2019 11:09:26 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Jonathan,
> sorry for the delayed response, but I have to focus on other topics now.
No worries. I have the same 'problem'!  Hence nothing yet from my side
on an alternative.

>=20
> Just some small comments came to my mind to finish the discussion, mainly=
 on the accelerometer in the lid case (see inline below).
>=20
> BR and thanks,
> Nikolaus
>=20
>=20
> > Am 22.04.2019 um 16:20 schrieb Jonathan Cameron <jic23@kernel.org>:
> >=20
> > On Mon, 15 Apr 2019 23:04:15 +0200
> > H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >  =20
> >> Hi Jonathan,
> >> we seem to have opposite goals and therefore quite different ideas wha=
t the right
> >> solution is. =20
> >=20
> > Yup :)  Yikes this email has gotten complex.  Hopefully I haven't
> > lost track of the various points below.
> >  =20
> >>=20
> >> I come from user-space and the input side, find that input can handle =
abstract "acceleration input",
> >> and some older chip drivers even provide that as their only interface.=
 Therefore I want
> >> to provide "acceleration input" in these cases where only iio capable =
drivers exist by
> >> using the existing in-kernel-iio infrastructure. Nothing more.
> >>=20
> >> You seem to come from the iio architecture and want to extend it to ot=
her APIs as
> >> general as possible and input is just one of several of them. =20
> >=20
> > Yes, my target is to produce a subsystem that meets many (all would be =
nice)
> > requirements, including yours.  Whilst I'm happy to debate this for eve=
r, I'm not
> > sure we are making any substantial progress.  As you mention below we
> > probably need to 'see the code' to drive the discussion forwards.
> >  =20
> >>=20
> >> Different goals usually lead to different solution architectures. =20
> >=20
> > Indeed, but in this case we have your proposal which is a subset of what
> > I am suggesting.  One architecture can fulfil both requirements. =20
>=20
> Not exactly. Yours always needs configuration in every case. My RFC works=
 without
> user-space config support for the most common cases. This user-space conf=
ig must
> be maintained and spread over all distributions. So we can never be sure =
that
> if a user changes the distro that it still works.

Indeed, we disagree on this and will continue to do so.  My view
is that you will always need userspace policy anyway so might as
well apply the 'right' policy :)

>=20
> >=20
> > I'll leave it for the other thread, but Bastien has raised the case
> > (that I'd forgotten) that there already userspace stacks that are
> > capable of happily taking in both IIO and Input devices.  The confusion
> > here is they will now discover 'both' without the existing userspace
> > knowing that they are the same device.  We need to be very careful not
> > to break those userspace programs.
> >=20
> > So this is an illustration of why the simplistic case doesn't work
> > 'now'.
> >  =20
> >>  =20
> >>> Am 14.04.2019 um 13:40 schrieb Jonathan Cameron <jic23@kernel.org>:
> >>>=20
> >>> On Mon, 8 Apr 2019 15:15:56 +0200
> >>> H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >>>  =20
> >>>> Hi Jonathan,
> >>>>=20
> >>>> I still do not fully understand what is worrying you here.   =20
> >>>  =20
> >>>>=20
> >>>> Do you worry about functionality, flexibility or resources or someth=
ing else?   =20
> >>>=20
> >>> Two main things:
> >>> 1) Lack of generality of the approach.=20
> >>>  This is a single use trick for input devices. Why does it make sense=
 for
> >>>  input devices?   =20
> >>=20
> >> No, it is not a trick... =20
> > Bad choice of words. Sorry about that.
> >=20
> > Any time we register a device as two types of device it is less than id=
eal.
> >=20
> > If we had the true separation of IIO front end and back end then it
> > would be perfectly acceptable to 'only' have an input front end for
> > a given device.  That choice would still, in this sort of usecase,
> > have to be made from userspace. It's policy, not design.  If there are =
reasons
> > a particular device 'is input' then that mapping should be in DT or sim=
ilar.
> > It's no different from knowing an ADC channel is wired to an analog
> > temperature sensor.  For example, you could build a joystick with
> > an accelerometer in the stick - then the usecase would be obvious!
> > Hence I would also argue that any dynamic interface should also support
> > a static path (DT or equivalent) for the cases where is really a
> > physical characteristic of the system!  Perhaps the Sony parts
> > fall into this category as well.
> >=20
> > For a bit of historical background, there was a concerted effort
> > to produced a userspace stack for IIO for android. =20
> > https://01.org/android-iio-sensors-hal
> >=20
> > Unfortunately I think it died as a result of other moves in Intel on
> > one of their periodic shifts in direction.
> >  =20
> >>=20
> >> Why does it make sense for input devices? =20
> >=20
> > These are not just 'input' devices. They are accelerometers. One usecase
> > is to use them for input.  The exact same physical device is used for g=
ames
> > input uses and counting steps for example (actually a lot wider cases t=
han
> > that, but this one is common in android devices).
> >=20
> > Keep that in mind at all times. There are lots of usecases.
> > So we need a solution that does not result in problems for those
> > usecases.  We are not writing a subsytem targetting android use of
> > accelerometers. We are writing a subsystem addressing as many usecases
> > as we can of those devices.
> >=20
> > Note that the original reason for IIO was to generalize a whole set of
> > proposed individual subsystems targeting particular sensor types. So
> > that is our focus - solutions that work for everyone.  This isn't
> > totally dissimilar from those discussions - at the time I wanted
> > to do a small focused ALS subsystem and got a resounding "no" from
> > Linus.  Generality matters a lot for the long term.
> >  =20
> >>=20
> >> a) because there is no alternative for accelerometer input devices and=
 there are some
> >> (older) accelerometer chips which only present themselves as input dev=
ices as soon
> >> as the driver is compiled and the chip is found. =20
> >=20
> > Actually that is not accurate.  The vast majority of those older devices
> > that have had any attempt at mainlining are in IIO. AFAIK no accelerome=
ter
> > driver has been merged to mainline input for many years. This is becaus=
e,
> > amongst others, Dmitry has been of the view they didn't belong there for
> > a very long time.
> >  =20
> >>=20
> >> b) because input events define ACCEL input devices. But no Temperature=
 or Voltage
> >> input or generic ADC input.So there is no generalization of input devi=
ces beyond
> >> keyboard, mouse, joystick, accelerometer and some others. =20
> >=20
> > That's not totally inaccurate, but the distinction in the other sensor =
cases
> > is that there is a clear 'additional' element that we can map in device=
tree
> > which relates the IIO sensor channel to the input device.
> > Doesn't matter for the point of view of this discussion though.
> >  =20
> >>  =20
> >>> There are lots of other in kernel users and potential
> >>>  ones in the future.   =20
> >>=20
> >> This bridge addition does not exclude any (additional) in-kernel use. =
=20
> >=20
> > No but it creates several problems:
> >=20
> > 1. Two ways to do the same thing.=20
> > 2. Two sets of code to maintain.
> > 3. Confusion over what is the best way of doing it.
> > 4. The known issues with multiple consumers (note my solution has
> > that problem as well!)
> >=20
> > My job here is to maintain the code, which is why I push back on someth=
ing
> > that makes that job harder.
> >=20
> > When the next usecases comes along and someone says they want to map
> > all ADC channels to hwmon channels because that is the subystem that
> > they expect to measure voltages in, then I don't have a good argument
> > to stop them doing the same thing you have.
> >=20
> > As a side note we have in the past had input drivers for gyroscopes and
> > magnetometers.  Why are accelerometers special?
> >=20
> > I really don't see why we should treat accelerometers differently =20
>=20
> Not special. I just did not want to add them yet in the RFC phase.
> The principle is the same.

hmm. I would argue that makes things even worse but there we are.
Now we have input interfaces for a wider set of drivers, many
of which aren't there for input at all.

>=20
> >=20
> > As this discussion runs on, I am increasingly convinced that there *mus=
t*
> > be a userspace policy control over whether an input device is
> > instantiated for a given accelerometer.   Once that is the
> > case then I cannot see a reason to treat it any differently from
> > other channel types. =20
>=20
> Well, I believe that we should avoid any user-space policy control that
> can be avoided. At least those cases that can live without policy
> control should not need to get one because there are other cases that
> need one.
>=20
> This is something we can't solve by discussion, of course.
>=20
> The decision is that you are maintainer and I am just proposing an RFC.
> So you have two votes and a veto right...
>=20
> But maybe this can be fixed by proper defaults? I don't know.

Agreed, we aren't going to resolve this.  I need to at least find some
time to put an alternative on the table rather than just abstract
discussion.

>=20
> >  =20
> >>  =20
> >>> The ability to register additional IIO consumers like
> >>>  this is useful, lets make it useful to everyone.   =20
> >>=20
> >> But not everyone and every iio device can and should be mappable to th=
e "input" abstraction.
> >> This does not make any sense to me. =20
> >=20
> > Absolutely.  It should not be.  I clearly didn't explain this well.
> >=20
> > It should be mapped to a consumer.
> >=20
> > One type of consumer is iio-input, another is iio-hmwon etc.
> >  =20
> >>=20
> >> For example, does it make sense to map a temperature sensor to acceler=
ometer input? Or an
> >> accelerometer to hwmon? This seems to be possible of your generalizati=
on unless I am missing something here.
> >> If it is, it ignores that iio sensors are already grouped by what phys=
ical property they do measure. =20
> >=20
> > If people want to map crazy channels to crazy sensor outputs, why stop =
them?
> > (at this level of the interface).
> >=20
> > This is a policy question for a userspace script.  Particular consumer =
drivers
> > could of course perform sanity checking and refuse to do anything if th=
ey
> > cannot sensibly use the channels.
> >=20
> > Yes, the interface has this flexibility. Which is a good thing!  Take t=
he example
> > of the gyroscope as input I used above.  If we want to add that support
> > in future to your driver (I have no idea if it actually makes sense)
> > then we can - without having to change the interface.
> >  =20
> >>  =20
> >>>=20
> >>> 2) To much generality of the specific usecase.  I don't want to put a=
n Input
> >>>  interface on accelerometers where it makes no sense.   =20
> >>=20
> >> I think you can just ignore the input interfaces in that case, if it w=
as created. =20
> >=20
> > Bastien raised a case where this isn't true.
> >  =20
> >>  =20
> >>> The rule of it has
> >>>  2-3 axis so it must make sense isn't good enough to my mind.  How
> >>>  does userspace know which accelerometer to use (more and more device=
s have
> >>>  multiple?)   =20
> >>=20
> >> In our approach user-space can make it known by udev rules based on /d=
ev/input/event*
> >> (not on iio but the input created for accelerometers). I think I menti=
oned that. This
> >> comes for free for any device registering as input. So it is no additi=
onal code. =20
> >=20
> > Sorry, I'm lost.  What in there tells you to use 'this' interface rathe=
r than one
> > of the other N that were registered?  I'm not sure what information you
> > have available there.
> >  =20
> >>  =20
> >>> You could do something like looking at the location info from
> >>>  DT / ACPI in your driver and pick the 'best' but that's policy. Shou=
ld be
> >>>  in userspace.  Sure you can just use the right input driver, but the=
 moment
> >>>  we do that, we need aware userspace, if that's the case why not make=
 it
> >>>  aware from the start.
> >>>=20
> >>> Believe me I've been round this one a good few times and thought abou=
t it
> >>> a lot.   =20
> >>=20
> >> That is fine and why we should discuss all the different aspects we ha=
ve collected.
> >>  =20
> >>> I'll take a lot of convincing that this isn't a problem that
> >>> should be pushed into userspace.
> >>>  =20
> >>>>=20
> >>>> I think having them mapped always does not need much resources (exce=
pt a handful of bytes
> >>>> in memory and some =C2=B5s during probing) unless the event device i=
s opened and really used.
> >>>> Only then it starts e.g. I2C traffic to read the sensors.   =20
> >>>=20
> >>> The bytes don't really mater.   =20
> >>=20
> >> Ok, good to know.
> >>  =20
> >>> The userspace ABI additions do.   =20
> >>=20
> >> There are only new /dev/input/event devices with well defined ABI. Thi=
s approach does
> >> not invent anything new here, hence there are no ABI additions which w=
e can break. =20
> >=20
> > But it does - we aren't talking general ABI, but ABI on specific
> > devices.  Sure, Android doesn't care - though you'd be amazed how much
> > individual android device developers will because we just added another
> > pile of tests to their CI.
> >=20
> > An industrial sensor platform absolutely does.  They have to validate
> > those interfaces.  They can't just ignore them because they feel like
> > it because who knows if some future user will use them?
> >=20
> > For another case, see Bastien's reply to the later thread.
> >=20
> > Instantiating interfaces has testing costs, even when the are standard
> > interfaces.
> >  =20
> >>  =20
> >>>  =20
> >>>>=20
> >>>> So it is just some unused file sitting around in /dev. Or 2 or could=
 be even 100.
> >>>> For devices which have no iio accelerometers configured, there will =
be no /dev/input
> >>>> file. So we are discussing the rare case of devices with more than o=
ne or two accelerometers.   =20
> >>>=20
> >>> Well they aren't exactly rare in IIO using systems ;)   =20
> >>=20
> >> This is another thing where our experiences differ. What specific devi=
ces are you thinking
> >> of? I am focussed on handhelds where the accelerometer (or two) is a w=
ay to do GUI input
> >> depending on device orientation in space. =20
> >=20
> > Again, you are introducing this interface for everyone. Including lots =
of
> > 'interesting' usecases.
> >=20
> > I have worked with sensor platforms with accelerometers of different pa=
rts of humans,
> > We have people do bridge vibration measurement, flying UAVs and trackin=
g the motion
> > of trucks.
> >=20
> > Most are not huge numbers of accelerometers per node but don't rule out=
 the
> > possibility.  It's normally limited by length of cables rather than any=
thing
> > else so you used multiple nodes after a while each with their own set o=
f sensors.
> >=20
> > There are lots of plaforms out there that use multiple accelerometers i=
n more
> > or less the same place to do very high dynamic range measurement (witho=
ut losing
> > precision when things are nearly still).
> >=20
> > Anyhow, it's not a particularly important point anyway!
> >  =20
> >>>  =20
> >>>>=20
> >>>> Now, on every system there are many interfaces and files that are no=
t used because it makes
> >>>> no sense to look at them. If I check on one of my systems, I find fo=
r example a lot of
> >>>> /dev/tty and only a very small portion is used and generic distros h=
ave no issue with it.
> >>>>=20
> >>>> There is even /dev/iio:device0 to /dev/iio:device5 representing the =
raw iio devices.
> >>>> Not all of them are actively used, but they are simply there and can=
 be scanned for.   =20
> >>>=20
> >>> Agreed, in the ideal case we wouldn't have had that either, but we are
> >>> stuck with it.  The long term plan is to allow use of IIO backends wi=
thout the
> >>> front end being there at all. Lots of SoC ADC users would prefer this=
. We are
> >>> stuck with the legacy intertwining fo the front end and back end of I=
IO so
> >>> this isn't as easy to do as I would like.   =20
> >>=20
> >> Ah, ok. I think it is a similar discussion of hiding the serdev /dev/t=
ty* if it is
> >> used for accessing an embedded GPS or Bluetooth chip, for example.
> >>=20
> >> But is this needed? I think it is not a problem if there are multiple =
consumers for
> >> the same iio channel. Some in-kernel, some through /dev/iio:device* an=
d maybe some
> >> through /dev/input (which boils down to in-kernel). =20
> >=20
> > There are quite a few complexities around multiple consumers that we re=
ally haven't
> > solved.  Right now the cases that work are very much restricted.  I'd l=
ove
> > to tidy some of these up, but never enough time and all that.
> >=20
> > It's not that relevant here, but in short a few of the issues are:
> > 1) Interference over control settings.  - Two consumers need different =
filter
> >   settings/ sampling frequency / range.  How do we negotiate the choice=
 and
> >   communicate it to the other consumers.  More complex questions such
> >   mediating choices of triggers.
> > 2) One driver is doing polled reads, the other is doing interrupt drive=
n.
> >   Most drivers prevent this combination because the polled reads can le=
ad
> >   to unlimited delays on the interrupt driven path and hence break it.
> >=20
> > The main driver for this separation was to present only the 'right' int=
erface
> > to reduced people's validation costs etc.  People really do want to hav=
e the
> > option to strip back the userspace inteface.  Obviously these are the r=
are
> > people who would disable your config option, but the point of this was
> > that we actually would like to make even the IIO interface optional as
> > well but have a fair way to go before we can.
> >  =20
> >>  =20
> >>>  =20
> >>>>=20
> >>>> So I do not see a resource problem if every accelerometer /dev/iio:d=
evice* gets
> >>>> some companion /dev/input/event* for being used on demand - but only=
 if this bridge
> >>>> is configured at all.   =20
> >>>=20
> >>> That argument does not apply. If we add a config option, distros will=
 enable it.
> >>> So the vast majority of systems will ship with this turned on.  You c=
annot
> >>> use a config variable to control policy and expect it to be change by=
 anyone
> >>> but a very very small subset of users.  So please drop the 'you can j=
ust not
> >>> build it argument'.   =20
> >>=20
> >> This is not my point here. I mention this under the (now known to be w=
rong) assumption
> >> that resources do care. I just want to state that kernels built for pl=
atforms where every
> >> byte counts can be stripped down by disabling it. Others where resourc=
es are no concern
> >> simply can map them all, even if not used. =20
> >=20
> > Agreed. A subset of users will just build without this.
> >  =20
> >>  =20
> >>> Userspace configuration changing is a lot easier if people actually c=
are.
> >>> Sure, many distros will ship the same script to everyone.
> >>>  =20
> >>>>  =20
> >>>>> I think we need some deliberate userspace interaction to instantiate
> >>>>> one of these rather than 'always doing it'.     =20
> >>>>=20
> >>>> My gut feeling is that this additional user-space interaction needs =
more resources and
> >>>> adds a lot of complexity, independently of how it is done.   =20
> >>>=20
> >>> Trivial resources and actually fairly trivial complexity.  Key thing =
is
> >>> it puts the burden on the users of this functionality to configure wh=
at they
> >>> want.   =20
> >>=20
> >> Hm. No. My proposal does not need configuration which accelerometers s=
hould go where. =20
> >=20
> > Agreed. I was talking about my proposal here :)
> >  =20
> >>=20
> >> I assumethat input accelerometer users do not want to configure anythi=
ng, like neither
> >> a mouse or keyboard is to be configured to be useable (yes there are k=
eymaps but that
> >> is impossible to automate). =20
> >=20
> > The difference is a mouse is only really useful as a mouse and most of =
the time a keyboard
> > is a used only as a keyboard.  Here that's not true.
> >  =20
> >>=20
> >> They just want to be able to read device orientation in a device-indep=
endent scale.
> >> Therefore my approach already takes the mount-matrix into account to h=
ide sensor position
> >> differences. =20
> >=20
> > And how does that work on the common case of a sensor in the lid of a l=
aptop?
> > how do you know what angle the screen is at?   =20
>=20
> Well, I am not aware of laptops where the sensor is in the lid because I =
am in the handhelds
> business, but let's assume it is common.
>=20
> I realized that if the sensor orientation is related to the lid position,=
 while the reference
> frame reported to user space is to be referenced to the lap or keyboard o=
f the laptop, there does
> not exist a static mount-matrix to describe it properly. So no driver can=
 report that correctly.
>=20
> Therefore, such a device needs a dynamic mount matrix, i.e. there should =
be a kernel driver that
> reads out the lid angle sensor and modifies the mount-matrix of the accel=
erometer by some sin()/cos()
> table.

This is where it is tricky.  There is no such lid angle sensor, that's what=
 the accelerometer
is for. Typically you have a pair of accelerometers and need to know which =
is which. which one makes
sense for input use is non obvious.

The reason I raised this at all was to make the point that there is often a=
 need for user
policy anyway. It's not a glorious world of things just magically working.

>=20
> Well, you can delegate this to the user-space. But IMHO this is wrong lay=
ering. Every layer
> put on top of the lower layers should abstract away implementation detail=
s so that the highest
> layer has the most general interface.
>=20
> In my view we have here this "protocol" stack (casting into the ISO 7-lay=
er model):
>=20
> 	L7: application - user space
> 	L3: input - to get device orientation information
> 	L2: iio - to get raw data and mount-matrix
> 	L1: i2c, spi, usb, hdq, ... - to get bits from/to chips
> 	L0: chips, ...
>=20
> My RFC mainly mangles the raw data reported from the iio level and the mo=
unt matrix into
> device orientation information. I.e. it is a proposal for L3 implementati=
on.
>=20
> So fixing an issue of L2 (dynamic mount matrix for lid angle) in the user=
-space layer would be improper
> layering.
>=20
> So there are two possibilites:
> a) make the mount-matrix dynamical as described above in L2
> b) extend my RFC to handle this special case
I would argue that it becomes just another part of the userspace policy that
needs to be applied.  Sure the actual transform would be applied in kernel
but the decision on which accelerometer to use and if additional transforms
are needed, is one for userspace not the kernel.  Probably not that hard
to add as simple controls alongside a binding interface.

Thanks,

Jonathan

>=20
>=20
> > One oddity to note here is that until very recently we deliberately did=
n't register
> > certain ACPI IDs because they confused userspace by reporting two accel=
erometers
> > without any info on which was in the lid.  Thankfully proper handling o=
f that
> > is no being sorted.  It's still mostly a case of just deliberately igno=
ring one
> > of the sensors.
> >  =20
> >>  =20
> >>>  =20
> >>>>=20
> >>>> And I think is even less flexible than "always doing it". Let me exp=
lain this claim.
> >>>>=20
> >>>> For me, the kernel should present everything the hardware supports t=
o user-space
> >>>> in better digestable device files or APIs (without making any assump=
tions about the
> >>>> user-space code).   =20
> >>>=20
> >>> Agreed, we just have a different view on how this should be done. I w=
ant
> >>> it to be dynamic and extremely flexible, you want the easy way of just
> >>> putting a fixed set out all the time.
> >>>  =20
> >>>>=20
> >>>> Then, every user-space that will be installed can find out what the =
hardware supports
> >>>> by looking at standard places.
> >>>>=20
> >>>> E.g. it can scan for all mice and keyboards. And for all input accel=
erometers.   =20
> >>>=20
> >>> Or, you an have the correct 'fairly trivial' userspace setup to scan =
for all
> >>> registered accelerometers and 'on demand' create the bindings to brin=
g them up as
> >>> Input accelerometers if that is what makes sense for your platform.  =
 =20
> >>=20
> >> Why not scan for input accelerometers and leave it as an implementatio=
n detail that
> >> the kernel does serve the physical chips through the iio infrastructur=
e? =20
> >=20
> > If we could separate the IIO front end from the IIO backend I would agr=
ee that
> > would be another valid -userspace- policy.
> >  =20
> >>=20
> >> IMHO some user-spaces may already be scanning all */input/event* and c=
heck for
> >> the device property INPUT_PROP_ACCELEROMETER.
> >>=20
> >> This is a discussion mainly about proper encapsulation of lower level =
differences.
> >>  =20
> >>>  =20
> >>>>=20
> >>>> If the kernel is hiding some chips and needs some initial user-space=
 action before
> >>>> presenting them all, this requires that the user-space has some a-pr=
iori knowledge
> >>>> about which specific devices it should ask for.   =20
> >>>=20
> >>> No more that it needs to know which accelerometer to use?   =20
> >>  =20
> >>>  =20
> >>>> So it does not really need to scan
> >>>> for them. Because it must already know. Obviously in some mapping ta=
ble stored at
> >>>> a well known location inside the rootfs image.   =20
> >>>=20
> >>> No. Let me give some more details of how this would work.  It's reall=
y just
> >>> a more flexible version of what you have.
> >>>=20
> >>> A distro, or individual user decides to put the relevant script in pl=
ace for the
> >>> following:
> >>>=20
> >>> 1. Userspace detects a new accelerometer driver, via the standard met=
hods (uevent)
> >>> 2. Userspace looks to see if it has the required properties. Now this=
 includes things
> >>> like detecting that it is the accelerometer in the lid of a laptop - =
if so do not
> >>> register it as an input device.  If it's in the keyboard then do regi=
ster it.
> >>> 3. Userspace script then creates the files in configfs
> >>> /sys/kernel/config/iio/maps/
> >>> (this interface needs appropriate definition)
> >>> Maybe...
> >>> /sys/kernel/config/iio/maps/iio_input/iio_device:X/accel_x, accel_y, =
etc
> >>> When done it writes to the bind file
> >>> /sys/kernel/config/iio/maps/iio_input/iio_device:X/bind
> >>> which instantiates the input driver.
> >>>=20
> >>> This moves all of the policy decision into userspace, where it belong=
s.  If
> >>> we want to enable a particular accelerometer on a particular board be=
cause it
> >>> actually works better than the one the default policy says to use, th=
en we can
> >>> do so.
> >>>=20
> >>> The resulting infrastructure is much more general, because it lets us=
 do the
> >>> same for any IIO consumer.  This input bridge is not a special case. =
It works
> >>> equally well for the existing hwmon bridge any would even let us do t=
hings
> >>> like provide the information from userspace that we have an analog ac=
celerometer
> >>> wired up to an ADC on some hacker board.   =20
> >>=20
> >> Ok, understood.
> >>=20
> >> My approach triggers input uevents:
> >>=20
> >> 1. kernel detects a new iio accelerometer (looks like an analog accele=
rometer should be
> >>   the DTS child of an iio adc and then iio should create an accelerome=
ter and not a voltage
> >>   channel) =20
> >=20
> > Yes ultimately it would be a child device that would be it's own IIO de=
vice. We
> > already have this for some gyroscopes.
> >  =20
> >> 2. iio-bridge registers as input event
> >> 3. this triggers an uevent
> >> 4  an udev-rule can detect the properties and map it to some "speaking=
" name like
> >>   /dev/input/main-accelerometer, /dev/input/lid-accelerometer etc. Or =
if the
> >>   accelerometer is to be ignored, it does not get a "speaking" name at=
 all.
> >>=20
> >> The required udev rules are stored in user space and are of course use=
r-space and application
> >> specific. But this does not require to invent some new configfs stuff =
and special scripts
> >> in user-space. Just install some udev rule at a well established locat=
ion in file-system. =20
> >=20
> > I'm not sure there is any significant difference between you creating a=
 mapping like
> > this an udev rule that creates the whole mapping.  Bit more to do perha=
ps but it's
> > nothing particularly special that I can see.  Sure there is new kernel =
support to be
> > done.
> >  =20
> >>=20
> >> Yes, this does not cover arbitrary mappings. But what are arbitrary ma=
ppings good
> >> for? Your scheme seems to be able to map a light sensor to acceleromet=
er input.
> >> Does this "full matrix of everything is possible" really make sense? =
=20
> >=20
> > From a generic interface point of view - yes it absolutely does.
> >=20
> > We define an interface that covers all usecases rather than a whole set=
 of
> > separate ones that cover individual corner cases.  That way we don't ha=
ve to
> > keep defining new interfaces.
> >=20
> > The individual drivers can easily do validation of what they are provid=
ed with.
> >  =20
> >>=20
> >> I can't decide because I have no need for it. Others may have.
> >>=20
> >> But another thought: does it interfere with this input-bridge? Probabl=
y no. You can
> >> still add your configfs approach for general iio devices to e.g. hwmon=
 mappings. Even
> >> as an alternate method of creating input devices (enabled only if my i=
nput-bridge is
> >> disabled). =20
> >=20
> > Yes see above.  Both approaches meet your requirement (I think anyway).
> > I do not want to see two long term solutions to the same problem.
> >=20
> > I'm interested in a long term sustainable solution so I want to see
> > the generic one.
> >  =20
> >>  =20
> >>>=20
> >>>  =20
> >>>>=20
> >>>> This seems to make it impossible to develop a generic distro rootfs =
image - without
> >>>> asking the user for manual configuration. And that where the kernel =
already knows
> >>>> this (which iio accelerometers do exist for a specific piece of hard=
ware).
> >>>>=20
> >>>> This is why I believe a mechanism to instantiate only on demand isn'=
t adding but
> >>>> removing flexibility because it prevents copying a rootfs from one d=
evice to another.   =20
> >>>=20
> >>> I disagree, see above.
> >>>  =20
> >>>>  =20
> >>>>>=20
> >>>>> As I mentioned in V1, look at the possibility of a configfs based m=
ethod
> >>>>> to build the map.  It's easy for userspace to work out what makes s=
ense to
> >>>>> map in principle.  There may be some missing info that we also need=
 to
> >>>>> look to expose.     =20
> >>>>=20
> >>>> With a "may be missing" it is impossible to write code for it...
> >>>> Can you please name which information is missing on the input accele=
rometer
> >>>> API?   =20
> >>>=20
> >>> See above. It's not the input accelerometer ABI, it's the missing abi=
lity
> >>> to instantiate IIO maps from user space.
> >>>  =20
> >>>>  =20
> >>>>>=20
> >>>>> In general, userspace created channel maps would be very useful for
> >>>>> other things such as maker type boards where they can plug all sorts
> >>>>> of odd things into ADC channels for example.     =20
> >>>>=20
> >>>> Ok, I understand, but this is a different problem where this iio-inp=
ut-bridge is not
> >>>> intended to be a solution. Generic ADCs are not input devices. Like =
SD cards are not
> >>>> keyboards.
> >>>>=20
> >>>> So we should not try to mix the idea of general mapping with this in=
put-bridge for
> >>>> input accelerometers.   =20
> >>> Yes we should. You are proposing a solution that is a subset of the l=
arger
> >>> problem set.   =20
> >>=20
> >> Yes, of course. Because I did not see or know about the general proble=
m set.
> >> And I still don't see a need for user-space controlled mapping for inp=
ut-accelerometers. =20
> >=20
> > We are clearly going to differ on this.  Bastien gave one example for w=
hy
> > this is required.  There will be others.
> >  =20
> >>  =20
> >>> Why introduce a stop gap like this when we can do it correctly
> >>> and provide something useful for all those other use cases.
> >>>=20
> >>> The only difference here is the uevent triggered script that creates =
those maps
> >>> for your particular usecase.   =20
> >>=20
> >> Well, I am a friend of solving one problem after the other in smaller =
steps than
> >> immediately aiming at a very general solution, which has side-effects =
of inventing
> >> new stuff for things that would work without. =20
> >=20
> > That works in a world where you can drop the previous approach as part =
of your
> > generalization.  When you are playing with kernel / userspace ABI then =
it
> > doesn't. Ideally you have to figure out the extensible general solution=
 at the
> > start because you are stuck maintaining the 'small steps' for many year=
s to
> > come.  I don't want to perpetually 'have' to export all 3D acceleromete=
rs as
> > input devices, because we didn't have the ability to chose which should=
 be
> > exported at some point in the past.
> >  =20
> >>  =20
> >>>=20
> >>>  =20
> >>>>=20
> >>>> BTW, there is a way to define additional mapping using udev rules wh=
ich symlink the
> >>>> /dev/input/event* paths to stable names like /dev/input/acceleromete=
r.
> >>>>=20
> >>>> This comes without additional code and is already provided by udev a=
nd the input system.
> >>>>=20
> >>>> So in summary, I have not yet seen a convincing scenario where being=
 able to dynamically
> >>>> map iio channels to input devices seems beneficial.   =20
> >>>=20
> >>> That is true for the narrow case you are talking about. I don't want =
to see that
> >>> narrow case solved in a fashion that effectively breaks solving it pr=
operly.   =20
> >>=20
> >> How does it break your approach if added later? The more I think about=
 it they are
> >> not incompatible. It is just useless to apply both in parallel. =20
> >=20
> > The reality is that if we put one in first that will used for ever beca=
use there
> > will be devices out there using it.  Therefore we have to maintain both=
 for
> > ever.
> >  =20
> >>  =20
> >>> If we add this, we have to export all accelerometers for ever under a=
ll circumstances
> >>> to userspace, because to remove it will break existing userspace.
> >>>=20
> >>> If we stand back and work out if we can do the general solution now, =
we avoid
> >>> this problem.   =20
> >>=20
> >> We get a different problem that we break existing user-space that simp=
ly wants to see
> >> an /dev/input/accelerometer without doing more than an existing udev r=
ule. =20
> >=20
> > I would love to say such a userspace doesn't exist, but reality is ther=
e are
> > all sorts of hideous things out there.  There are cases that deal with =
this
> > as an option of course (such as Bastien's sensor-proxy)
> >=20
> > The number of devices that are supported under mainline as input accele=
rometers
> > is pretty small.  It's not a perfect world unfortunately but having to =
add a
> > small udev script is at least not a major break if we do cause it. =20
> >>  =20
> >>>  =20
> >>>>  =20
> >>>>>  =20
> >>>>>>=20
> >>>>>> This driver simply collects the first 3 accelerometer channels as =
X, Y and Z.
> >>>>>> If only 1 or 2 channels are available, they are used for X and Y o=
nly. Additional
> >>>>>> channels are ignored.
> >>>>>>=20
> >>>>>> Scaling is done automatically so that 1g is represented by value 2=
56 and
> >>>>>> range is assumed to be -511 .. +511 which gives a reasonable preci=
sion as an
> >>>>>> input device.     =20
> >>>>>=20
> >>>>> Why do we do this, rather than letting input deal with it?  Input i=
s used
> >>>>> to widely differing scales IIRC     =20
> >>>>=20
> >>>> Well, it can't be done differently... And what I call scale here is =
nothing more than
> >>>> defining ABSMIN_ACC_VAL and ABSMAX_ACC_VAL.
> >>>>=20
> >>>> We need to apply some scale since iio reports in (fractional) units =
of 1g, i.e. values
> >>>> of magnitude 1.   =20
> >>>=20
> >>> m/s^2 not g, but doesn't matter for the point of view of this discuss=
ion.   =20
> >>=20
> >> My fault. The driver takes care of this in the scaling formula so that=
 "input" reports
> >> MAX/2 for 1g.
> >>  =20
> >>>  =20
> >>>> These are not adaequate for input events which use integers. So we m=
ust
> >>>> define some factor for iio_convert_raw_to_processed() to scale from =
raw value range
> >>>> to int value range. We could report raw values but this would be an =
improper abstraction
> >>>> from chip specific differences.   =20
> >>>=20
> >>> Hmm. I can see we perhaps need some mapping, but is there a concept o=
f standard scale
> >>> for existing input accelerometers?  How is this done to give for othe=
r input devices
> >>> such as touch screens?  I'd expect to see a separation between scale,=
 and range.
> >>>=20
> >>>  =20
> >>>>=20
> >>>> BTW: the range (and therefore the factor) is reported through the ev=
dev driver to user-space
> >>>> (evtest reports Min and Max as you can see in the example).
> >>>>=20
> >>>> The most important thing is that this is a hardware independent defi=
nition. Every accelerometer
> >>>> chip will report this range. So you can easily upgrade hardware or s=
witch accelerometers
> >>>> without touching user-space calibration. Like you can replace ethern=
et controller chips but
> >>>> networking works the same with all of them.   =20
> >>>=20
> >>> Agreed, it needs to be hardware independent by the time it hits users=
pace, but I would
> >>> have thought that scaling would be done in input, rather than IIO. It=
's hardly
> >>> a problem unique to our usecase!
> >>>=20
> >>> Perhaps Dmitry can give some advice on this.   =20
> >>=20
> >> Yes, that would be helpful.
> >>  =20
> >>>  =20
> >>>>=20
> >>>>=20
> >>>> Hm. Is there an alternative to attach such private data to an struct=
 iio_dev
> >>>> allocated by someone else? I have not found one yet.
> >>>>=20
> >>>> Or can I add some void *input_mapping; to struct iio_dev? Depending =
on
> >>>> #if defined(CONFIG_IIO_INPUT_BRIDGE)?   =20
> >>>=20
> >>> Yes, add a new element.   =20
> >>=20
> >> Ok, works fine.
> >>=20
> >> I already have found one case of iio accelerometer driver where it did=
 make a problem
> >> not using a special element.
> >>  =20
> >>>>>=20
> >>>>> iio_input_find_accel_channel(indio_dev, chan, &numchans);
> >>>>> iio_input_register_device(indio_dev, chan, numchans);     =20
> >>>>=20
> >>>> Well, that looks like it needs some temporary storage of dynamic size
> >>>> and loop twice over channels for no functional benefit.   =20
> >>>=20
> >>> Use fixed size. The worst that happens is we end up with it being
> >>> an entry larger that it needs to be.
> >>>  =20
> >>>> And handle the
> >>>> special case of numchans =3D=3D 0 (the proposed code simply does not=
 call
> >>>> iio_input_register_accel_channel and does not register anything).
> >>>>=20
> >>>> So I'd prefer to follow the "KISS" principle and register single cha=
nnels
> >>>> instead of a set of channels.   =20
> >>>=20
> >>> Well we disagree on this.  A singleton approach like used here
> >>> is to my mind not KISS.  I would rather see what is there then
> >>> act as two simple steps, rather than interleave two different
> >>> actions with a totally different path for the first channel found.
> >>> If there is only one channel you just built a load of infrastructure
> >>> that makes no sense.  If you scan first then you can know that
> >>> before building anything.   =20
> >>=20
> >> Ok, this is more a matter of taste and resource requirements can proba=
bly
> >> be neglected. I'll update the driver.
> >>=20
> >> So in summary, I'll post a v3 that fixes some bugs of v2 (because we n=
eed
> >> them fixed for our production systems as well).
> >>=20
> >> Then it is up to you if you want to take this approach or want to write
> >> a full version following your concept. Or if it is possible as I assum=
e, we
> >> can have both. =20
> >=20
> > Thanks. I think we need at some code for what I was proposing to discuss
> > much further. Unfortunately it may be a little while before I get time =
to
> > work on that.  Hopefully not too long though!
> >=20
> > Jonathan
> >  =20
> >>=20
> >> BR and thanks,
> >> Nikolaus
> >>  =20
> >  =20
>=20
>=20

