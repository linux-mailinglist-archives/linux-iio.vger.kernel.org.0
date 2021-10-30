Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6BD4406B6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 03:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhJ3Bfd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Oct 2021 21:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhJ3Bfd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Oct 2021 21:35:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B74C061570;
        Fri, 29 Oct 2021 18:33:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p40so5929787pfh.8;
        Fri, 29 Oct 2021 18:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m6jN3nJN+pfYVC2xjobCozqqBEVjukM+ZX2LfkYDSc0=;
        b=KvK5qAPMGZwSZtZFnFUKCPpd/arSNuKJdwDWOLD4JhnMpr8tykIgHmO34CPlvNUrm1
         7mvB0ndZJ19CQqAplwYNUtE3QR9LZ9VQUqg6rYHwVgZp+/R9NLz9OE8APvHczs//Fkib
         QwDXKDwpQIDufl487h+dv5jXDAWN3EKEVlThYhxglE8xYI6/u82wVGC34ki1aZKw5tFo
         7+RnOiOWDfHXxQDnTMYVW9Kv6SpQwzgrKcRq2RfZlcgGDNoDj5Y8F5tJsf8+pcjYPoas
         qhoiAMgYuRYiX8fP+wsadgtPU64zKnU94kIb2+0A4xFJI8ZjdXN09y1660jEOHy0f+hE
         PFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m6jN3nJN+pfYVC2xjobCozqqBEVjukM+ZX2LfkYDSc0=;
        b=KKFfyTTzkuw+QD+4+ggoKLjRJKXFP7l15GfjVR6uHMxBQgLkUGWiq6DW7NawJEXzwH
         oG2Bj6lTYCfxISN9eDMSN0QkJDl26bRhmwEGmv8aD/5xuWsM0OHFkic9clWAfjbMv53P
         dreFF/tKKr8p92OSLULjNMB1794PvT3WcaHftvwKCmqgwB+By5vAZsQGsErY7+G9sh1q
         lmjDZlLBwqgtll6ijqczmytJTaR4Qtkum4/h0BS/M2hNxLB34MjUp1CQazRNFKD01H9d
         JLqQcAAdcnZW3gVqbxFORFGLuEIgZCmWZVnyQLavNdL/kpsxBZyO0g+NeX/8lNfPMeOy
         3c1w==
X-Gm-Message-State: AOAM5321ciz2YJM7CqvgaLGXP3pfSGg9rdN4cbBOaGAqbNSiib8C/T+9
        q1w/yNCc5TT2tgjDEtZ/f34pLfzg0LE=
X-Google-Smtp-Source: ABdhPJxXFxw0yYfs4alBe9gyql+YQH/u6OguCy37xJH4GtWswVQWXAMGmWkV9SrRKhrQT+7W6xNvOQ==
X-Received: by 2002:a63:b11:: with SMTP id 17mr10679142pgl.51.1635557582720;
        Fri, 29 Oct 2021 18:33:02 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id s22sm7732323pfe.76.2021.10.29.18.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 18:33:01 -0700 (PDT)
Date:   Sat, 30 Oct 2021 10:32:57 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] docs: counter: add latch_mode and latched_count
 sysfs attributes
Message-ID: <YXygyba/r/8+h+W3@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-7-david@lechnology.com>
 <YXkFzK0TA5zswSrQ@shinobu>
 <e660e9c5-a116-5450-8afb-1053a1504ab6@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hndwlu0J8v0RUkVb"
Content-Disposition: inline
In-Reply-To: <e660e9c5-a116-5450-8afb-1053a1504ab6@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Hndwlu0J8v0RUkVb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 12:00:24PM -0500, David Lechner wrote:
> On 10/27/21 2:54 AM, William Breathitt Gray wrote:
> > On Sat, Oct 16, 2021 at 08:33:41PM -0500, David Lechner wrote:
> >> @@ -147,6 +150,14 @@ Description:
> >>   			updates	the respective count. Quadrature encoding
> >>   			determines the direction.
> >>  =20
> >> +What:		/sys/bus/counter/devices/counterX/countY/latched_count
> >> +KernelVersion:	5.16
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Latched count data of Count Y represented as a string. The value
> >> +		is latched in based on the trigger selected by the
> >> +		counterX/latch_mode attribute.
> >> +
> >=20
> > Latches are pretty common components of devices, and not simply limited
> > to latching the count data. I wonder if it would be better to omit the
> > "_count" suffix in order to make this more general. Well, the name
> > "latched_count" is suitable for counters so you probably don't need to
> > change it, but it's something to think about in the future.
> >=20
>=20
> I chose the name counterX/countY/latched_count since we already have
> counterX/countY/count to read the same (not latched) count. This
> indicates that they are the same quantity, just from a different
> point in time.
>=20
> Also for consideration, this particular hardware actually has 3
> independent latched counts. One is triggered by the selected
> latched_mode. One is triggered by the index signal and one is
> triggered by the strobe signal.
>=20
> The latter two are not implemented in this series, but if there were a
> use for those, I would probably submit attributes index_latched_count
> and strobe_latched_count. These are unaffected by the latch_mode.
>=20
> Similarly, the unit timer has a timer latch and a period latch. If we
> change the unit timer to be a Count as suggested, then the latched
> timer would basically be the same as latched_count. Both of these
> are triggered by the selected latch_mode.
>=20
> So, I supposed if we wanted to keep things really generic, we would
> want to introduce some sort of "latch trigger" component (synapse?).
> There could theoretically be multiple configurable triggers, so
> the proposed latch_mode might need to be made indexed or part of
> an index component/extension.

Aside from deriving their latched values from the current and historical
count values, these latches don't seem to be related to Counters in an
operational sense; i.e. they don't really fit into the Counter subsystem
paradigm because they aren't functionally counters, but rather just use
the count values here as source data for their own operations. As such,
I'm not sure yet if they really belong in the Counter subsystem or
somewhere else in the IIO subsystem.

>=20
> >>   What:		/sys/bus/counter/devices/counterX/countY/name
> >>   KernelVersion:	5.2
> >>   Contact:	linux-iio@vger.kernel.org
> >> @@ -209,6 +220,7 @@ What:		/sys/bus/counter/devices/counterX/countY/co=
unt_mode_component_id
> >>   What:		/sys/bus/counter/devices/counterX/countY/direction_component_=
id
> >>   What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
> >>   What:		/sys/bus/counter/devices/counterX/countY/error_noise_componen=
t_id
> >> +What:		/sys/bus/counter/devices/counterX/countY/latched_count_compone=
nt_id
> >>   What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_=
id
> >>   What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
> >>   What:		/sys/bus/counter/devices/counterX/countY/preset_enable_compon=
ent_id
> >> @@ -218,6 +230,7 @@ What:		/sys/bus/counter/devices/counterX/signalY/c=
able_fault_enable_component_id
> >>   What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_presca=
ler_component_id
> >>   What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_comp=
onent_id
> >>   What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_co=
mponent_id
> >> +What:		/sys/bus/counter/devices/latch_mode_component_id
> >>   What:		/sys/bus/counter/devices/unit_timer_enable_component_id
> >>   What:		/sys/bus/counter/devices/unit_timer_period_component_id
> >>   What:		/sys/bus/counter/devices/unit_timer_time_component_id
>=20
> Just noticing here, I missed the counterX in the device-level components.
>=20
> >> @@ -244,6 +257,22 @@ Description:
> >>   		counter_event data structures. The number of elements will be
> >>   		rounded-up to a power of 2.
> >>  =20
> >> +What:		/sys/bus/counter/devices/counterX/latch_mode
> >> +KernelVersion:	5.16
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Read/write attribute that selects the trigger for latching
> >> +		values. Valid values are device-specific (given by
> >> +		latch_mode_available attribute) and may include:
> >> +
> >> +		"Read count":
> >> +			Reading the countY/count attribute latches values.
> >> +
> >> +		"Unit timeout":
> >> +			Unit timer timeout event latches values.
> >> +
> >> +		The latched values can be read from latched_* attributes.
> >> +
> >=20
> > To make these modes more generic for use in future drivers, I suggest
> > removing the "Unit " prefix and just leaving that mode as "Timeout". In
> > a similar vein, rewording "Read count" to "Count read" would make this
> > mode easier to understand in case a future driver introduces a mode
> > called "Signal read" or similar.
> >=20
>=20
> Continuing my thoughts from above and taking this suggestion into
> consideration...
>=20
> Maybe we need a /sys/bus/counter/devices/counterX/latchY component.
> This would represent the trigger for a latch. For the TI eQEP in this
> series, there are potentially 3 of these (only one implemented for
> now).
>=20
> latchY would have a required `trigger` attribute that would describe
> what triggers the latch. If the trigger is selectable, there would be
> a `triggers_available` attribute that would list the possible triggers,
> otherwise the `trigger` attribute would just be read-only. Available
> triggers could could be "X read" where X is a fully qualified component
> name, e.g. "Count0 count read" or a fully qualified event, e.g.
> "Count1 overflow event" (this is unit timer timeout in generic counter
> terms). But, there may be potential triggers that don't fit either
> of these patterns.
>=20
> Although not currently needed, the triggers for the index and strobe
> latches on the eQEP get more interesting. The `triggers_available` for
> the index latch are "index rising edge", "index falling edge" and
> "software" (this would require a `software_trigger` attribute that
> would be written to trigger the latch). The `triggers_available` for
> the strobe latch are "strobe rising edge" and "strobe rising edge if
> direction is clockwise and strobe falling edge if direction is
> counterclockwise".
>=20
> Circling back to the beginning, to read latched registers, there
> would be attributes like counterX/countY/latchY_count instead of
> the proposed counterX/countY/latched_count. So for the eQEP there
> would be counter0/count0/latch0_count (triggered by reading
> counter0/count0/count or counter0/count1 overflow event),
> counter0/count0/latch1_count (triggered by index signal),
> counter0/count0/latch2_count (triggered by strobe signal),
> counter0/count1/latch0_count (unit timer latched timer trigger
> by same trigger as counter0/count0/latch0_count) and
> counter0/count0/latch0_ceiling (unit timer latched period
> triggered by same trigger as counter0/count0/latch0_count).

The complexity of configuration here is a good indication that these
latches deserve their own tree structure as you suggest. Furthermore, we
see that there at least three of these latches available for this
particular device, so just a single "latch_count" or similar will not be
sufficient -- enumeration of the form /sys/bus/../latchY or similar
would be prudent.

Jonathan, perhaps you have some insight here. From a functional aspect,
latches are not unique to counter devices, so I wonder if the IIO
subsytem has already encountered similar functionality amongst its
drivers. Essentially, a latch is just a memory buffer provided by the
device.

For the TI eQEP device here, the buffer for each latch provides a single
read-only value that is updated by the device; the update behavior can
be configured by respective control registers. However, it's not so
far-fetched to assume that there a other devices out that that have
buffers spanning multiple latched values storing historical data.

Because a latch can theoretically provide any sort of data, not
necessary count values, it seems reasonable that supporting latches
would involve their own interface independent of the Counter paradigm.
How that interface looks is the question. Should the TI eQEP latches
here be exposed through some sort of generic latches interface, or
would it be better to have a more abstract representation of what these
latches are for; e.g. if these latches are used to measure speed, then
some sort of IIO speedometer interface might be appropriate).

William Breathitt Gray

--Hndwlu0J8v0RUkVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF8oLUACgkQhvpINdm7
VJIHzw/+NUvFJ88DXI/c9MmsDygo8EsC9XwcCIHMND8dTxghZV7LpYFeJVPbTJKs
T/ZDMktTX+jRPaWe63K5H/LurM7fpUfHqemlC1taUKyH1spTyrGoShjRwV0jL2Ni
SrZ6wGzxjjPxgYEGafgy96S4tjLIXPeHKTlLDpVZVhGpfn408K5Lfki6WbV+FXjT
oP8ON6+j8X9KCvoCgiH87r3xl0iu+aKtCumEAEBPsFLmPdFFkPIbgeD4pLEl8W1e
wWRwqbtT+On8UwL5Tdhhn+B8ZDPXxqbrMZDHFZST8MC40yJ4iPOyCMtPxWHpgmAv
10GUdnh7SkPJHx6nogFy4xIF0e2/yWZBZLoWbYykx91kVZv4LgWulIGht/1g2Y63
nR7zZN+3IUcDm/CF3pMYV9syIaStGA9vd1USAGNZ31KstFP40UImSwBA6zdXoIov
rLl8Q3oVWSsuSgzRXGufapN520jWaHtXIM55bZEekYYavBZIx/nxwzO48+OLeJgh
mKfEdyJse4+Tp+cNpKojDZwPts5RFYP1D4ulZkXVR0on723CuzS5uw6Whv8LYKUE
zp+EmFdTPfrLh13QWQQGx355KRzslbOZAXZCfWtncr0E4UkISsG+RKpT/JIP42P/
1XzvHIVMznhsMvlvJSzB1RL+R5eg4bsgzT9ZsasD1pbKaBqR39U=
=MWQn
-----END PGP SIGNATURE-----

--Hndwlu0J8v0RUkVb--
