Return-Path: <linux-iio+bounces-22875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE05DB2947A
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8981189020A
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901662FFDFA;
	Sun, 17 Aug 2025 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBICYq3l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975429E0FD;
	Sun, 17 Aug 2025 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450790; cv=none; b=T+/erMcDLLN0I9smurL9y4aiLiusyiK+B2Wau0LJTGrbAHGmXNTu8h9frJGKydjcY3AzvweInlCLjRsJ4513oj4iZKIJ6TxP52ExvJNGiTvUafn7i2X8CrCLT3UZvxyHSOxfS6yuLCsaHGmMGgL5NuGCza/kIK4u0OdvyO12dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450790; c=relaxed/simple;
	bh=zwHvJevAX0OLJRVG/i975HO4aUFnCQOcWVclxqSMgjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMnpRXMmXfj5QFdlkRrkjsEXGkp9GdYI+uEF1zy8Ow1JHfNGybudz3o1wPtkxPZDdzpWJR43oqjAGxLHHUYvMQiVLsK1/WQNdGPKJX6VEJF20k5DJz5saPydxToJzs/JLXpTiGXMm2w5GoY/zlJJsIfkgrYpBOXHXazr3Pyl5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBICYq3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAA5C4CEEB;
	Sun, 17 Aug 2025 17:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755450789;
	bh=zwHvJevAX0OLJRVG/i975HO4aUFnCQOcWVclxqSMgjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BBICYq3lJBBeqA6vj/M+bIHlcCV18hp6oeSLmpdQ1SChsOhwFNhDyhBVVYlekIxaO
	 Wqk+yYQYy0AZlF0xa3jrP4fSoFVDJUFWA/lGacWBKyzUdVfmZt6ssjQAJ+AAOhP0ed
	 Bp8+1GKXNw6IZOoh745uRia4zMqOPDqqKupN+cW+pi0YT/YUUXhLSgaL6E0aJOpAYb
	 Y7sI/6oafnRVsYoKX3LwsbjYwQ5Xi0KVLtEiKRvz/fcedhvtyVqM2btDUXd3KCZ+Bz
	 Q5ICKkXN52f8rCTU1yG2Id7mbHl5tv+nLwNOxVKnANKDtvtq4bMy11I5x0uo/NW73a
	 BL+lUYdF5OzHQ==
Date: Sun, 17 Aug 2025 18:13:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <20250817181302.28bbda69@jic23-huawei>
In-Reply-To: <59D7D612-D618-4FF0-A932-2EB0B57D321E@watter.com>
References: <20250813151614.12098-1-bcollins@watter.com>
	<20250813151614.12098-6-bcollins@watter.com>
	<a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
	<20250816105410.70e47dac@jic23-huawei>
	<DA11BDA3-E4E3-4C1A-9E4E-84E92F62A4B3@watter.com>
	<20250816160835.3b44a4cd@jic23-huawei>
	<59D7D612-D618-4FF0-A932-2EB0B57D321E@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Aug 2025 11:19:53 -0400
Ben Collins <bcollins@watter.com> wrote:

> > On Aug 16, 2025, at 11:08=E2=80=AFAM, Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >=20
> > On Sat, 16 Aug 2025 09:12:37 -0400
> > Ben Collins <bcollins@watter.com> wrote:
> >  =20
> >>> On Aug 16, 2025, at 5:54=E2=80=AFAM, Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >>>=20
> >>> On Wed, 13 Aug 2025 17:52:04 -0500
> >>> David Lechner <dlechner@baylibre.com> wrote:
> >>>  =20
> >>>> On 8/13/25 10:15 AM, Ben Collins wrote:   =20
> >>>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> >>>>> to allow get/set of this value.
> >>>>>=20
> >>>>> Signed-off-by: Ben Collins <bcollins@watter.com>
> >>>>> ---
> >>>>> drivers/iio/temperature/mcp9600.c | 43 ++++++++++++++++++++++++++++=
+++
> >>>>> 1 file changed, 43 insertions(+)
> >>>>>=20
> >>>>> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temper=
ature/mcp9600.c
> >>>>> index 5ead565f1bd8c..5bed3a35ae65e 100644
> >>>>> --- a/drivers/iio/temperature/mcp9600.c
> >>>>> +++ b/drivers/iio/temperature/mcp9600.c
> >>>>> @@ -31,6 +31,7 @@
> >>>>> #define MCP9600_STATUS_ALERT(x) BIT(x)
> >>>>> #define MCP9600_SENSOR_CFG 0x5
> >>>>> #define MCP9600_SENSOR_TYPE_MASK GENMASK(6, 4)
> >>>>> +#define MCP9600_FILTER_MASK GENMASK(2, 0)
> >>>>> #define MCP9600_ALERT_CFG1 0x8
> >>>>> #define MCP9600_ALERT_CFG(x) (MCP9600_ALERT_CFG1 + (x - 1))
> >>>>> #define MCP9600_ALERT_CFG_ENABLE BIT(0)
> >>>>> @@ -111,6 +112,7 @@ static const struct iio_event_spec mcp9600_even=
ts[] =3D {
> >>>>> .address =3D MCP9600_HOT_JUNCTION,        \
> >>>>> .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |        \
> >>>>>      BIT(IIO_CHAN_INFO_SCALE) |       \
> >>>>> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
> >>>>>      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
> >>>>> .event_spec =3D &mcp9600_events[hj_ev_spec_off],        \
> >>>>> .num_event_specs =3D hj_num_ev,        \
> >>>>> @@ -149,6 +151,7 @@ static const struct iio_chan_spec mcp9600_chann=
els[][2] =3D {
> >>>>> struct mcp9600_data {
> >>>>> struct i2c_client *client;
> >>>>> u32 thermocouple_type;
> >>>>> + u32 filter_level;
> >>>>> };
> >>>>>=20
> >>>>> static int mcp9600_read(struct mcp9600_data *data,
> >>>>> @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *ind=
io_dev,
> >>>>> case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> >>>>> *val =3D mcp9600_tc_types[data->thermocouple_type];
> >>>>> return IIO_VAL_CHAR;
> >>>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> >>>>> + *val =3D data->filter_level;     =20
> >>>>=20
> >>>> We can't just pass the raw value through for this. The ABI is defined
> >>>> in Documentation/ABI/testing/sysfs-bus-iio and states that the value
> >>>> is the frequency in Hz.
> >>>>=20
> >>>> So we need to do the math to convert from the register value to
> >>>> the required value.
> >>>>=20
> >>>> I'm a bit rusty on my discrete time math, so I had chatgpt help me
> >>>> do the transform of the function from the datasheet to a transfer
> >>>> function and use that to find the frequency response.
> >>>>=20
> >>>> It seemed to match what my textbook was telling me, so hopefully
> >>>> it got it right.
> >>>>=20
> >>>> Then it spit out the following program that can be used to make
> >>>> a table of 3dB points for a given sampling frequency. If I read the
> >>>> datasheet right, the sampling frequency depends on the number of
> >>>> bits being read.
> >>>>=20
> >>>> For example, for 3 Hz sample rate (18-bit samples), I got:
> >>>>=20
> >>>> n  f_3dB (Hz)
> >>>> 1  0.58774
> >>>> 2  0.24939
> >>>> 3  0.12063
> >>>> 4  0.05984
> >>>> 5  0.02986
> >>>> 6  0.01492
> >>>> 7  0.00746
> >>>>=20
> >>>> I had to skip n=3D0 though since that is undefined. Not sure how we
> >>>> handle that since it means no filter. Maybe Jonathan can advise?   =
=20
> >>>=20
> >>> This is always a fun corner case.  Reality is there is always
> >>> some filtering going on due to the analog side of things we
> >>> just have no idea what it is if the nicely defined filter is
> >>> turned off.  I can't remember what we have done in the past,
> >>> but one option would be to just have anything bigger than 0.58774
> >>> defined as being filter off and return a big number. Not elegant
> >>> though.  Or just don't bother supporting it if we think no one
> >>> will ever want to run with not filter at all.
> >>>=20
> >>> Hmm. or given this is a digital filter on a sampled signal, can we es=
tablish
> >>> an effective frequency that could be detected without aliasing and
> >>> use that?  Not sure - I'm way to rusty on filter theory (and was
> >>> never that good at it!)   =20
> >>=20
> >> I=E2=80=99ve seen another driver use { U64_MAX, U64_MAX } for this cas=
e. It
> >> didn=E2=80=99t seem very clean. I thought to use { 999999, 999999 } or=
 even
> >> { 1, 0 }, but anything other than =E2=80=9Coff=E2=80=9D just felt odd.=
 =20
> > Ah.  Could we use filter_type? (additional attribute)
> >=20
> > That already has a 'none' option.  Nothing there yet that works for the=
 'on'
> > option here.  These are always tricky to name unless they are a very
> > well known class of filter.   The datasheet calls this one an Exponenti=
al
> > Moving Average filter. Not a term I'd encountered before, but google did
> > find me some references.  so maybe ema as a filter type? =20
>=20
> In the docs I have, it says:
>=20
> 	In addition, this device integrates a first order recursive
> 	Infinite Impulse Response (IIR) filter, also known as
> 	Exponential Moving Average (EMA).
>=20
> The EMA formula I=E2=80=99ve used for an adc-attached thermistor was the =
same
> formula I=E2=80=99ve seen used in IIR, so I think they are generally the =
same.
>=20
> >>=20
> >> ChatGPT suggests this:
> >>=20
> >>    =E2=80=A2 Clamp to Nyquist frequency
> >>        =E2=80=A2 For a sample rate f_s, the maximum realizable cutoff =
is the Nyquist limit f_s/2.
> >>        =E2=80=A2 At f_s =3D 3\ \text{Hz}, Nyquist is 1.5\ \text{Hz}.
> >>        =E2=80=A2 You could encode { 1, 500000 } (1.5 Hz) as the maximu=
m meaningful cutoff. =20
> >=20
> > Hmm. Whilst kind of backwards as that's where you'll see aliasing it do=
es make more sense
> > I think than just a magic large number.
> >=20
> > I think I prefer the filter type route though now your comment on 'off'=
 has lead me to it.
> >=20
> > Make sure to add ABI docs for the new filter type if you do go that way=
. =20
>=20
> I was considering a new =E2=80=9Cfilter_enable=E2=80=9D attribute and onl=
y list the
> other values in the 3db filter available. This seems more robust and
> doesn=E2=80=99t require any sort of agreed on magic number.
>=20
New ABI is always annoying painful and it is useful to give userspace some =
hint
as to what the filter it is playing with actually is (even if super vague).

Jonathan



