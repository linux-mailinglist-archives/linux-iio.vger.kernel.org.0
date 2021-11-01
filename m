Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE84412DE
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 06:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhKAFNp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 01:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhKAFNo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 01:13:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18391C061714;
        Sun, 31 Oct 2021 22:11:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k4so997952plx.8;
        Sun, 31 Oct 2021 22:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q9cjegeF492FoufZbkEsnjMERaGLyhEaMGIR77XVmDE=;
        b=aBUfg+SzPxiu7AvI0rcNNrWmH9uvjLkYrqq3XJYgZ2yqnCLurcj1f5lJeull5P0Vks
         3bbcdiuNsaDgJcTZWeoJckYAF8kZSzg8NxRCAaeuuPSZ43lUsMLZhD+ief3r8BF94CaT
         l1P26y3cEXh1Ko1uZK80efnOZjgPq//5eP19POXD+VLIgGNqA0CHguw6SPMO35wcBhrP
         YyCRLh6la8r6kBBjAJ1axijN/w/SXnDYF9rfBqPSuNK1UjpZ1UFnnoGQh9IeHn1Rxh9j
         ZJSErhzPyYAwe+Ccn02hZ5VgbCeqJoo0vtpo3MjinzfPiz3MS8zzfT/Vm8OmXBRMO2ec
         BoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9cjegeF492FoufZbkEsnjMERaGLyhEaMGIR77XVmDE=;
        b=ycoxLDoy3MkO4FFunkcp2jCCJhx5xdHgehg18PeIg1DxyHyzl5hDaxBVrUHYBPapiN
         0nw7Y/epktbKgigRc5ZWxaYF6TDFVQl8QVmfWwa9JnOu0E+dXhMq5qmWrSAaEXLlT6HP
         cvd3eq0dp96tWr0x1zKSXzthmOFFdjghmp7fFKqMvvf4uhv17KSjcG91OeOd7tkonzMR
         OYS8wu1wfZTH7lsVlIAhZG06jBLVfuCal7TXqfT9re0OJcg22p/f3q6geVJOSCez4s/r
         9jGRWYVUGiKJBJ+Ubmj/sY9bMjYaMh7qBwIUEkjPnZTYOGQs+BniVo5Lj3noBMQwTPf0
         f0CQ==
X-Gm-Message-State: AOAM531FDRuSJdKe8o3ovLSNj70QIhB80TKqIerM1JyMlXdisohlkj3w
        /2nd80UEBiwEPGSpWP1e87XeybFonMo=
X-Google-Smtp-Source: ABdhPJwWX/4TOThQntXEQjLdhWiYUp1ocwzYjqYyY5frthbtc4YjrMznQbpA+MXQnJbUKUZ/lPUD2A==
X-Received: by 2002:a17:90b:4c0b:: with SMTP id na11mr14104568pjb.53.1635743471491;
        Sun, 31 Oct 2021 22:11:11 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id 1sm13331147pfl.133.2021.10.31.22.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 22:11:10 -0700 (PDT)
Date:   Mon, 1 Nov 2021 14:11:06 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] docs: counter: add latch_mode and latched_count
 sysfs attributes
Message-ID: <YX926qQ8ZMKmbx1z@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-7-david@lechnology.com>
 <YXkFzK0TA5zswSrQ@shinobu>
 <e660e9c5-a116-5450-8afb-1053a1504ab6@lechnology.com>
 <YXygyba/r/8+h+W3@shinobu>
 <20211030153939.44c8145d@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yh8hmheFheEY9ofY"
Content-Disposition: inline
In-Reply-To: <20211030153939.44c8145d@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Yh8hmheFheEY9ofY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 30, 2021 at 03:39:39PM +0100, Jonathan Cameron wrote:
> On Sat, 30 Oct 2021 10:32:57 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > On Wed, Oct 27, 2021 at 12:00:24PM -0500, David Lechner wrote:
> > > On 10/27/21 2:54 AM, William Breathitt Gray wrote: =20
> > > > On Sat, Oct 16, 2021 at 08:33:41PM -0500, David Lechner wrote: =20
> > > >> @@ -147,6 +150,14 @@ Description:
> > > >>   			updates	the respective count. Quadrature encoding
> > > >>   			determines the direction.
> > > >>  =20
> > > >> +What:		/sys/bus/counter/devices/counterX/countY/latched_count
> > > >> +KernelVersion:	5.16
> > > >> +Contact:	linux-iio@vger.kernel.org
> > > >> +Description:
> > > >> +		Latched count data of Count Y represented as a string. The value
> > > >> +		is latched in based on the trigger selected by the
> > > >> +		counterX/latch_mode attribute.
> > > >> + =20
> > > >=20
> > > > Latches are pretty common components of devices, and not simply lim=
ited
> > > > to latching the count data. I wonder if it would be better to omit =
the
> > > > "_count" suffix in order to make this more general. Well, the name
> > > > "latched_count" is suitable for counters so you probably don't need=
 to
> > > > change it, but it's something to think about in the future.
> > > >  =20
> > >=20
> > > I chose the name counterX/countY/latched_count since we already have
> > > counterX/countY/count to read the same (not latched) count. This
> > > indicates that they are the same quantity, just from a different
> > > point in time.
> > >=20
> > > Also for consideration, this particular hardware actually has 3
> > > independent latched counts. One is triggered by the selected
> > > latched_mode. One is triggered by the index signal and one is
> > > triggered by the strobe signal.
> > >=20
> > > The latter two are not implemented in this series, but if there were a
> > > use for those, I would probably submit attributes index_latched_count
> > > and strobe_latched_count. These are unaffected by the latch_mode.
> > >=20
> > > Similarly, the unit timer has a timer latch and a period latch. If we
> > > change the unit timer to be a Count as suggested, then the latched
> > > timer would basically be the same as latched_count. Both of these
> > > are triggered by the selected latch_mode.
> > >=20
> > > So, I supposed if we wanted to keep things really generic, we would
> > > want to introduce some sort of "latch trigger" component (synapse?).
> > > There could theoretically be multiple configurable triggers, so
> > > the proposed latch_mode might need to be made indexed or part of
> > > an index component/extension. =20
> >=20
> > Aside from deriving their latched values from the current and historical
> > count values, these latches don't seem to be related to Counters in an
> > operational sense; i.e. they don't really fit into the Counter subsystem
> > paradigm because they aren't functionally counters, but rather just use
> > the count values here as source data for their own operations. As such,
> > I'm not sure yet if they really belong in the Counter subsystem or
> > somewhere else in the IIO subsystem.
>=20
> In this particular case I think we are talking about latching counts rath=
er
> than something else?  So one event happens and we latch the count at that
> point.

It looks like the unit timer has latches for its time and period values
as well IIUC, but at this patch only implements support for the count
latch. I think if we were to implement support for these other latches,
we would probably expose them in a similar way and just call them
respectively latched_count, latched_period, etc.

> The IIO equivalent is a trigger event driving data into a buffer.
> There are a few examples of this though it's pretty rare.
> The most general corner case is probably what we see with impact sensors.
> In those cases we have data captured around an event (rather than a single
> latched value).
>=20
> They are rather complex beasts but the best we've managed is a special
> trigger used only with that device and some control attributes to say what
> is captured when the trigger fires.  Note this is a stetch in IIO because
> normally triggers are one per sample...

Yes, complexity is something I would like to avoid. I don't want to
shoehorn functionality into the Counter subsystem if a simpler approach
is possible. However, it may be good news to hear that these kind of
complex devices are rarer, so a simple approach with the TI eQEP might
be the best option.

> >=20
> > >  =20
> > > >>   What:		/sys/bus/counter/devices/counterX/countY/name
> > > >>   KernelVersion:	5.2
> > > >>   Contact:	linux-iio@vger.kernel.org
> > > >> @@ -209,6 +220,7 @@ What:		/sys/bus/counter/devices/counterX/count=
Y/count_mode_component_id
> > > >>   What:		/sys/bus/counter/devices/counterX/countY/direction_compon=
ent_id
> > > >>   What:		/sys/bus/counter/devices/counterX/countY/enable_component=
_id
> > > >>   What:		/sys/bus/counter/devices/counterX/countY/error_noise_comp=
onent_id
> > > >> +What:		/sys/bus/counter/devices/counterX/countY/latched_count_com=
ponent_id
> > > >>   What:		/sys/bus/counter/devices/counterX/countY/prescaler_compon=
ent_id
> > > >>   What:		/sys/bus/counter/devices/counterX/countY/preset_component=
_id
> > > >>   What:		/sys/bus/counter/devices/counterX/countY/preset_enable_co=
mponent_id
> > > >> @@ -218,6 +230,7 @@ What:		/sys/bus/counter/devices/counterX/signa=
lY/cable_fault_enable_component_id
> > > >>   What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_pr=
escaler_component_id
> > > >>   What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_=
component_id
> > > >>   What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mod=
e_component_id
> > > >> +What:		/sys/bus/counter/devices/latch_mode_component_id
> > > >>   What:		/sys/bus/counter/devices/unit_timer_enable_component_id
> > > >>   What:		/sys/bus/counter/devices/unit_timer_period_component_id
> > > >>   What:		/sys/bus/counter/devices/unit_timer_time_component_id =20
> > >=20
> > > Just noticing here, I missed the counterX in the device-level compone=
nts.
> > >  =20
> > > >> @@ -244,6 +257,22 @@ Description:
> > > >>   		counter_event data structures. The number of elements will be
> > > >>   		rounded-up to a power of 2.
> > > >>  =20
> > > >> +What:		/sys/bus/counter/devices/counterX/latch_mode
> > > >> +KernelVersion:	5.16
> > > >> +Contact:	linux-iio@vger.kernel.org
> > > >> +Description:
> > > >> +		Read/write attribute that selects the trigger for latching
> > > >> +		values. Valid values are device-specific (given by
> > > >> +		latch_mode_available attribute) and may include:

By the way, the latch_mode_available comment here can be removed as it's
already obvious the respective *_available sysfs attribute is where the
possible values are given.

> > > >> +
> > > >> +		"Read count":
> > > >> +			Reading the countY/count attribute latches values.
> > > >> +
> > > >> +		"Unit timeout":
> > > >> +			Unit timer timeout event latches values.
> > > >> +
> > > >> +		The latched values can be read from latched_* attributes.
> > > >> + =20
> > > >=20
> > > > To make these modes more generic for use in future drivers, I sugge=
st
> > > > removing the "Unit " prefix and just leaving that mode as "Timeout"=
=2E In
> > > > a similar vein, rewording "Read count" to "Count read" would make t=
his
> > > > mode easier to understand in case a future driver introduces a mode
> > > > called "Signal read" or similar.
> > > >  =20
> > >=20
> > > Continuing my thoughts from above and taking this suggestion into
> > > consideration...
> > >=20
> > > Maybe we need a /sys/bus/counter/devices/counterX/latchY component.
> > > This would represent the trigger for a latch. For the TI eQEP in this
> > > series, there are potentially 3 of these (only one implemented for
> > > now).
> > >=20
> > > latchY would have a required `trigger` attribute that would describe
> > > what triggers the latch. If the trigger is selectable, there would be
> > > a `triggers_available` attribute that would list the possible trigger=
s,
> > > otherwise the `trigger` attribute would just be read-only. Available
> > > triggers could could be "X read" where X is a fully qualified compone=
nt
> > > name, e.g. "Count0 count read" or a fully qualified event, e.g.
> > > "Count1 overflow event" (this is unit timer timeout in generic counter
> > > terms). But, there may be potential triggers that don't fit either
> > > of these patterns.
> > >=20
> > > Although not currently needed, the triggers for the index and strobe
> > > latches on the eQEP get more interesting. The `triggers_available` for
> > > the index latch are "index rising edge", "index falling edge" and
> > > "software" (this would require a `software_trigger` attribute that
> > > would be written to trigger the latch). The `triggers_available` for
> > > the strobe latch are "strobe rising edge" and "strobe rising edge if
> > > direction is clockwise and strobe falling edge if direction is
> > > counterclockwise".
> > >=20
> > > Circling back to the beginning, to read latched registers, there
> > > would be attributes like counterX/countY/latchY_count instead of
> > > the proposed counterX/countY/latched_count. So for the eQEP there
> > > would be counter0/count0/latch0_count (triggered by reading
> > > counter0/count0/count or counter0/count1 overflow event),
> > > counter0/count0/latch1_count (triggered by index signal),
> > > counter0/count0/latch2_count (triggered by strobe signal),
> > > counter0/count1/latch0_count (unit timer latched timer trigger
> > > by same trigger as counter0/count0/latch0_count) and
> > > counter0/count0/latch0_ceiling (unit timer latched period
> > > triggered by same trigger as counter0/count0/latch0_count). =20
> >=20
> > The complexity of configuration here is a good indication that these
> > latches deserve their own tree structure as you suggest. Furthermore, we
> > see that there at least three of these latches available for this
> > particular device, so just a single "latch_count" or similar will not be
> > sufficient -- enumeration of the form /sys/bus/../latchY or similar
> > would be prudent.
> >=20
> > Jonathan, perhaps you have some insight here. From a functional aspect,
> > latches are not unique to counter devices, so I wonder if the IIO
> > subsytem has already encountered similar functionality amongst its
> > drivers. Essentially, a latch is just a memory buffer provided by the
> > device.
>=20
> As mentioned above, they exist but are fairly rare, unless you think
> of time triggers as being in this category in which case any data
> ready signal is basically like this.  Ignoring that common case,
> we map them onto a device specific trigger (one that has a
> validate_device callback to check it's being assigned to that right devic=
e).
> Another case where we do odd things like this is SoC ADCs that support to=
uch
> screen type functionality.  In those case we are grabbing data only when
> the screen is touched.
>=20
>=20
> >=20
> > For the TI eQEP device here, the buffer for each latch provides a single
> > read-only value that is updated by the device; the update behavior can
> > be configured by respective control registers. However, it's not so
> > far-fetched to assume that there a other devices out that that have
> > buffers spanning multiple latched values storing historical data.
>=20
> A fifo filled on 'index' event or similar would indeed be a reasonable
> bit of hardware to build.  I've world with PLC code that does this sort
> of things so the requirements are there (tracking products on a conveyor
> belt would be a classic case - you latch the count when a light gate is
> broken).

I've constructed similar devices where I push the current count to a
fifo to track a part's relative position to others on a conveyor belt.
It's possible some quadrature encoding device out has a similar
functionality, but I don't want to jump the gun and start developing an
interface for this if those kinds of device are so rare as to not be
worth the effort.

> > Because a latch can theoretically provide any sort of data, not
> > necessary count values, it seems reasonable that supporting latches
> > would involve their own interface independent of the Counter paradigm.
> > How that interface looks is the question. Should the TI eQEP latches
> > here be exposed through some sort of generic latches interface, or
> > would it be better to have a more abstract representation of what these
> > latches are for; e.g. if these latches are used to measure speed, then
> > some sort of IIO speedometer interface might be appropriate).
>=20
> I'd suggest trying to avoid being too generic about this.  There might
> be some reason to do it in the future but trying to define interfaces
> across subsystems is a pain.  More likely we'll get some bridging
> type drivers to map between different abstractions if they are needed.
>=20
> Jonathan

I agree, after considering this some more I think it's best to keep this
specific to the use case of the TI eQEP for now. If something more
complex appears in the future then we can address the possibility of a
deadicated interface, but for the time being I think simple extensions
to the Counter subsystem will suffice.

Instead of treating each latch with its own enumerated tree structure,
let's go with the simple approach taken initially here:

	* counterX/countY/latched_count
	* counterX/latch_mode

If desired, a latched_time can be implemented as well; the edge capture
attributes can be exposed in a similar fashion (e.g. latched_period).

Whether latch_mode belongs as a device extension or Count extension is
something I'm still contemplating. If we expose the unit timer under its
own counterX/countY, then latch_mode should be a device extension
because latched_time would simply become latched_count for the unit
timer. On the other hand, if unit timer is not exposed like that, then
perhaps it makes more sense to move latch_mode to counterX/countY, and
introduce latched_time and latched_period under there as well.

William Breathitt Gray

--Yh8hmheFheEY9ofY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF/dtkACgkQhvpINdm7
VJKoAw/+IY3fVA20uTr2nohzRQBoCWwvk0uLZy5IjhzV4szWF/dPzpJ+s/QyiIZ/
M9NAxYV/Jaj/GE/pn/jeIAyXvz3+lmWQZE7PMKtHoxOVIgrHOXCu+qXkIdEZb2Sq
gU5oZti1JeJC32NeV3fN0lOPvuI4/9gE0gEB0ENVcWyXAxY+CHYaQeC/U7uE/97Y
3GDotJtWLfKbuWVKwG2DTjsPOz1hrTMQyvSEgOZX5LKdtWiZ6z0lx6GQ92yRZWPi
ErW3o2x2UjxWoDtqZtxgXUKdDl1y0nSHX008mxbl8dI9YX5w5lEMDyi5aKbMQn5O
FJR6HuAz14t6+/1RrMdIYL0mRipfUzmhysY36S/Vzpg+dBbRnV7VmVm/mS2adxxo
Uz9jNacdpIB6gFriQAsycW9WmT7ItcXYIOSunjH8mOkTh3kaNyVzityA5IdNMus+
Mxbg7eZIAYXgA3wi5PQvDvNosaXZITpuDbpAjXDVVWUmEGoY/QS6w26m92MQyW7C
TEy8ezoIEaiQcXtzE9Y5lX3KOCf78cFpHq2mqlhrBMqb0b4IyLd5NQ1Ul88Tyx/B
0KboMnk2tSk0k6zGa/n0LZHA7Ee1Zn2nc8SbKrKlRbOiHrijlnb/FNrXdrYjB57t
+JNcerC/TB+AjYVCuk+b8tQA3i0LFC+8L8N4iLfBel86seJI5sA=
=8uN3
-----END PGP SIGNATURE-----

--Yh8hmheFheEY9ofY--
