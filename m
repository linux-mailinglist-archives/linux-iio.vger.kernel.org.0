Return-Path: <linux-iio+bounces-22874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D3DB29472
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 19:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002B57B3264
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430A2FFDFA;
	Sun, 17 Aug 2025 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSPcAK9m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00EC2D3229;
	Sun, 17 Aug 2025 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450707; cv=none; b=nbVMXBg/Pa5uvSZKudO9ciHK9NOw7j8wR0eKCmH97zb1XS5cRh3BhNyXV9G0d2zrlX1Q/XzzZEkGxbMuCVmdGrdOSMgccEocskG899iEipoAWedGqV/Z1jVbqp4pwfTj1K4s95b+d+Lg3REQ34a+r8+VUzjrzIn8HKUVZf5GGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450707; c=relaxed/simple;
	bh=BlYNGP9CYq5ljBMBRJorYfhaQ6Rb1gpjPjqOhIC3VFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgmjC3jaAdfuhViR0c+tahYGzM+39c3O0R/6BviznQDRbDhxl6KGkPBfFyNJJLMtyeSACAMfXSl5+WNS7emy6nTY4GCC/+zkF7UEoldWRMSmynQLmqbyEFcJ7yvMN43yeTN7EIm20+wHURd/vr/dNppQzLl3upaNEkPGuo5RdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSPcAK9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6EBC4CEEB;
	Sun, 17 Aug 2025 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755450707;
	bh=BlYNGP9CYq5ljBMBRJorYfhaQ6Rb1gpjPjqOhIC3VFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DSPcAK9m7FYCQmdjfTLbHxOl96JbmUJ+ZQ5Uj3GbMtsj4PVEOKFKOU97QMhvU+t7i
	 qYyBUnDF1ODcQYMAIWFawYOTxipRQgQxpA6cjLsore33qDgUx3gZc9czTEyZhc6gCM
	 iRhXfqOHBclcDTEKGsDrPIG6oSQzYMRQVvtVZN2McHbrXwlldG9S0M6yFxVMTzOWoK
	 eG2nv0oJubJ0Vnv5xUx1NcN4YIya824Xjqy+ntKfMjkkw5qtH74UvtiX0JgPtGfusb
	 R++JHvs79dpce6Y9Wjea2E1WFcNzg9ZrI1RYe3nDxdZaWl2v0BWlxINAqu3iHDIIjP
	 /rDX7bmvgyX8w==
Date: Sun, 17 Aug 2025 18:11:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ben Collins <bcollins@watter.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <20250817181140.1a435673@jic23-huawei>
In-Reply-To: <82f53f02-15d3-43fa-9734-8091b360f4e0@baylibre.com>
References: <20250813151614.12098-1-bcollins@watter.com>
	<20250813151614.12098-6-bcollins@watter.com>
	<a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
	<20250816105410.70e47dac@jic23-huawei>
	<DA11BDA3-E4E3-4C1A-9E4E-84E92F62A4B3@watter.com>
	<20250816160835.3b44a4cd@jic23-huawei>
	<59D7D612-D618-4FF0-A932-2EB0B57D321E@watter.com>
	<93E1A889-81AE-4DAB-9297-2A74C87E38B3@watter.com>
	<82f53f02-15d3-43fa-9734-8091b360f4e0@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Aug 2025 12:16:44 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/16/25 10:33 AM, Ben Collins wrote:
> >  =20
> >> On Aug 16, 2025, at 11:19=E2=80=AFAM, Ben Collins <bcollins@watter.com=
> wrote:
> >> =20
> >>>
> >>> On Aug 16, 2025, at 11:08=E2=80=AFAM, Jonathan Cameron <jic23@kernel.=
org> wrote:
> >>>
> >>> On Sat, 16 Aug 2025 09:12:37 -0400
> >>> Ben Collins <bcollins@watter.com> wrote:
> >>> =20
> >>>>> On Aug 16, 2025, at 5:54=E2=80=AFAM, Jonathan Cameron <jic23@kernel=
.org> wrote:
> >>>>>
> >>>>> On Wed, 13 Aug 2025 17:52:04 -0500
> >>>>> David Lechner <dlechner@baylibre.com> wrote:
> >>>>> =20
> >>>>>> On 8/13/25 10:15 AM, Ben Collins wrote:   =20
> >>>>>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> >>>>>>> to allow get/set of this value.
> >>>>>>>
> >>>>>>> Signed-off-by: Ben Collins <bcollins@watter.com>
> >>>>>>> ---
> >>>>>>> drivers/iio/temperature/mcp9600.c | 43 ++++++++++++++++++++++++++=
+++++
> >>>>>>> 1 file changed, 43 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temp=
erature/mcp9600.c
> >>>>>>> index 5ead565f1bd8c..5bed3a35ae65e 100644
> >>>>>>> --- a/drivers/iio/temperature/mcp9600.c
> >>>>>>> +++ b/drivers/iio/temperature/mcp9600.c
> >>>>>>> @@ -31,6 +31,7 @@
> >>>>>>> #define MCP9600_STATUS_ALERT(x) BIT(x)
> >>>>>>> #define MCP9600_SENSOR_CFG 0x5
> >>>>>>> #define MCP9600_SENSOR_TYPE_MASK GENMASK(6, 4)
> >>>>>>> +#define MCP9600_FILTER_MASK GENMASK(2, 0)
> >>>>>>> #define MCP9600_ALERT_CFG1 0x8
> >>>>>>> #define MCP9600_ALERT_CFG(x) (MCP9600_ALERT_CFG1 + (x - 1))
> >>>>>>> #define MCP9600_ALERT_CFG_ENABLE BIT(0)
> >>>>>>> @@ -111,6 +112,7 @@ static const struct iio_event_spec mcp9600_ev=
ents[] =3D {
> >>>>>>> .address =3D MCP9600_HOT_JUNCTION,        \
> >>>>>>> .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |        \
> >>>>>>>     BIT(IIO_CHAN_INFO_SCALE) |       \
> >>>>>>> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
> >>>>>>>     BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
> >>>>>>> .event_spec =3D &mcp9600_events[hj_ev_spec_off],        \
> >>>>>>> .num_event_specs =3D hj_num_ev,        \
> >>>>>>> @@ -149,6 +151,7 @@ static const struct iio_chan_spec mcp9600_cha=
nnels[][2] =3D {
> >>>>>>> struct mcp9600_data {
> >>>>>>> struct i2c_client *client;
> >>>>>>> u32 thermocouple_type;
> >>>>>>> + u32 filter_level;
> >>>>>>> };
> >>>>>>>
> >>>>>>> static int mcp9600_read(struct mcp9600_data *data,
> >>>>>>> @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *i=
ndio_dev,
> >>>>>>> case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> >>>>>>> *val =3D mcp9600_tc_types[data->thermocouple_type];
> >>>>>>> return IIO_VAL_CHAR;
> >>>>>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> >>>>>>> + *val =3D data->filter_level;     =20
> >>>>>>
> >>>>>> We can't just pass the raw value through for this. The ABI is defi=
ned
> >>>>>> in Documentation/ABI/testing/sysfs-bus-iio and states that the val=
ue
> >>>>>> is the frequency in Hz.
> >>>>>>
> >>>>>> So we need to do the math to convert from the register value to
> >>>>>> the required value.
> >>>>>>
> >>>>>> I'm a bit rusty on my discrete time math, so I had chatgpt help me
> >>>>>> do the transform of the function from the datasheet to a transfer
> >>>>>> function and use that to find the frequency response.
> >>>>>>
> >>>>>> It seemed to match what my textbook was telling me, so hopefully
> >>>>>> it got it right.
> >>>>>>
> >>>>>> Then it spit out the following program that can be used to make
> >>>>>> a table of 3dB points for a given sampling frequency. If I read the
> >>>>>> datasheet right, the sampling frequency depends on the number of
> >>>>>> bits being read.
> >>>>>>
> >>>>>> For example, for 3 Hz sample rate (18-bit samples), I got:
> >>>>>>
> >>>>>> n  f_3dB (Hz)
> >>>>>> 1  0.58774
> >>>>>> 2  0.24939
> >>>>>> 3  0.12063
> >>>>>> 4  0.05984
> >>>>>> 5  0.02986
> >>>>>> 6  0.01492
> >>>>>> 7  0.00746
> >>>>>>
> >>>>>> I had to skip n=3D0 though since that is undefined. Not sure how we
> >>>>>> handle that since it means no filter. Maybe Jonathan can advise?  =
 =20
> >>>>>
> >>>>> This is always a fun corner case.  Reality is there is always
> >>>>> some filtering going on due to the analog side of things we
> >>>>> just have no idea what it is if the nicely defined filter is
> >>>>> turned off.  I can't remember what we have done in the past,
> >>>>> but one option would be to just have anything bigger than 0.58774
> >>>>> defined as being filter off and return a big number. Not elegant
> >>>>> though.  Or just don't bother supporting it if we think no one
> >>>>> will ever want to run with not filter at all.
> >>>>>
> >>>>> Hmm. or given this is a digital filter on a sampled signal, can we =
establish
> >>>>> an effective frequency that could be detected without aliasing and
> >>>>> use that?  Not sure - I'm way to rusty on filter theory (and was
> >>>>> never that good at it!)   =20
> >>>>
> >>>> I=E2=80=99ve seen another driver use { U64_MAX, U64_MAX } for this c=
ase. It
> >>>> didn=E2=80=99t seem very clean. I thought to use { 999999, 999999 } =
or even
> >>>> { 1, 0 }, but anything other than =E2=80=9Coff=E2=80=9D just felt od=
d. =20
> >>> Ah.  Could we use filter_type? (additional attribute)
> >>>
> >>> That already has a 'none' option.  Nothing there yet that works for t=
he 'on'
> >>> option here.  These are always tricky to name unless they are a very
> >>> well known class of filter.   The datasheet calls this one an Exponen=
tial
> >>> Moving Average filter. Not a term I'd encountered before, but google =
did
> >>> find me some references.  so maybe ema as a filter type? =20
> >>
> >> In the docs I have, it says:
> >>
> >> In addition, this device integrates a first order recursive
> >> Infinite Impulse Response (IIR) filter, also known as
> >> Exponential Moving Average (EMA).
> >>
> >> The EMA formula I=E2=80=99ve used for an adc-attached thermistor was t=
he same
> >> formula I=E2=80=99ve seen used in IIR, so I think they are generally t=
he same. =20
> >=20
> > Clarification: An EMA is a 1-pole IIR filter, while IIR filters can be
> > many other types besides 1-pole.
> >  =20
>=20
> We already have a "sinc5+avg" filter, so I would call this one "avg".
>=20
> I don't think we need to get too specific. The main point of the names
> is that for chips with more than one filter, it is obvious which one
> is which. For a chip with only "none" and "avg" is will be obvious
> that "avg" turns the filter on.
>=20
I think average tends to be a box filter rather than an IIR one.  It's
kind of oversampling but you get a read out for each sample.

Jonathan



