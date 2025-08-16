Return-Path: <linux-iio+bounces-22843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D65B28EC3
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 17:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E73A585E05
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A222EA497;
	Sat, 16 Aug 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWj1UUVg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8982E4257;
	Sat, 16 Aug 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356924; cv=none; b=bLyAK/ZiRN2F9g3O9KNOHyv7jn628CmOcw/p13I3aiapCOfCec/xyhUdla0LPYeMbDThEnkMVLUkuJkAgVXLe+WOrErbHVF/E5LyoE7WkQ6sYDw9AiBUt/J88rYphiQGHih+ZqYnakAKoHyR5LU9GKEnws9em7BFlPinQkvmC3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356924; c=relaxed/simple;
	bh=+RGZFvA6bpxj/10sIfp9gMB4/84lr5xJCaDQlx9hklc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkqLZipYX7OFOUAchqBXDIKQF1juX0yL054ccuunH3orlBoVeBqm3daEPmN/8mKjVhHNA0+0PFNzCIB9PZOcvNj4Ut1fMq+uREjCm4aG1nrySV0sRF+I/T6MJyM0xih+slci28R9kYI8INQCrkPgQXtCgzsYuHHwjq3O2nLSUBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWj1UUVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E06C4CEEF;
	Sat, 16 Aug 2025 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755356923;
	bh=+RGZFvA6bpxj/10sIfp9gMB4/84lr5xJCaDQlx9hklc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EWj1UUVgL0U6JMcu83nQpPkPy3/kP34yrDxuGgIbYSgcmI7wwnkowchRpAgTzZbRG
	 8ZHksJKz8CbVLbCH+3mx13i+GN7pnMp1+Je7p/qvmmADflBU60GX01BtrtPGM4V4SY
	 hkcXqGiGjg4Aca7ZOeCFq/gA6K6vgyt4miQRKmVut/hOGZIaqJA4xyfpYqRzTsZv1D
	 JYlDRy0SkDNh5zndjVv0OfG8wWfvokV+Jt0BrZYINAX6oFeOoSxz/sdhD4elzYgTwx
	 x1KcfKrPotD+j4HkoutIErXmj13LLY4rBUIL3/K9lzEhILuT8V3obV7i8TZRaLxcV4
	 W+aXYJJJ/DfyQ==
Date: Sat, 16 Aug 2025 16:08:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <20250816160835.3b44a4cd@jic23-huawei>
In-Reply-To: <DA11BDA3-E4E3-4C1A-9E4E-84E92F62A4B3@watter.com>
References: <20250813151614.12098-1-bcollins@watter.com>
	<20250813151614.12098-6-bcollins@watter.com>
	<a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
	<20250816105410.70e47dac@jic23-huawei>
	<DA11BDA3-E4E3-4C1A-9E4E-84E92F62A4B3@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Aug 2025 09:12:37 -0400
Ben Collins <bcollins@watter.com> wrote:

> > On Aug 16, 2025, at 5:54=E2=80=AFAM, Jonathan Cameron <jic23@kernel.org=
> wrote:
> >=20
> > On Wed, 13 Aug 2025 17:52:04 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> >> On 8/13/25 10:15 AM, Ben Collins wrote: =20
> >>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> >>> to allow get/set of this value.
> >>>=20
> >>> Signed-off-by: Ben Collins <bcollins@watter.com>
> >>> ---
> >>> drivers/iio/temperature/mcp9600.c | 43 +++++++++++++++++++++++++++++++
> >>> 1 file changed, 43 insertions(+)
> >>>=20
> >>> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperat=
ure/mcp9600.c
> >>> index 5ead565f1bd8c..5bed3a35ae65e 100644
> >>> --- a/drivers/iio/temperature/mcp9600.c
> >>> +++ b/drivers/iio/temperature/mcp9600.c
> >>> @@ -31,6 +31,7 @@
> >>> #define MCP9600_STATUS_ALERT(x) BIT(x)
> >>> #define MCP9600_SENSOR_CFG 0x5
> >>> #define MCP9600_SENSOR_TYPE_MASK GENMASK(6, 4)
> >>> +#define MCP9600_FILTER_MASK GENMASK(2, 0)
> >>> #define MCP9600_ALERT_CFG1 0x8
> >>> #define MCP9600_ALERT_CFG(x) (MCP9600_ALERT_CFG1 + (x - 1))
> >>> #define MCP9600_ALERT_CFG_ENABLE BIT(0)
> >>> @@ -111,6 +112,7 @@ static const struct iio_event_spec mcp9600_events=
[] =3D {
> >>> .address =3D MCP9600_HOT_JUNCTION,        \
> >>> .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |        \
> >>>       BIT(IIO_CHAN_INFO_SCALE) |       \
> >>> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
> >>>       BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
> >>> .event_spec =3D &mcp9600_events[hj_ev_spec_off],        \
> >>> .num_event_specs =3D hj_num_ev,        \
> >>> @@ -149,6 +151,7 @@ static const struct iio_chan_spec mcp9600_channel=
s[][2] =3D {
> >>> struct mcp9600_data {
> >>> struct i2c_client *client;
> >>> u32 thermocouple_type;
> >>> + u32 filter_level;
> >>> };
> >>>=20
> >>> static int mcp9600_read(struct mcp9600_data *data,
> >>> @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *indio=
_dev,
> >>> case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> >>> *val =3D mcp9600_tc_types[data->thermocouple_type];
> >>> return IIO_VAL_CHAR;
> >>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> >>> + *val =3D data->filter_level;   =20
> >>=20
> >> We can't just pass the raw value through for this. The ABI is defined
> >> in Documentation/ABI/testing/sysfs-bus-iio and states that the value
> >> is the frequency in Hz.
> >>=20
> >> So we need to do the math to convert from the register value to
> >> the required value.
> >>=20
> >> I'm a bit rusty on my discrete time math, so I had chatgpt help me
> >> do the transform of the function from the datasheet to a transfer
> >> function and use that to find the frequency response.
> >>=20
> >> It seemed to match what my textbook was telling me, so hopefully
> >> it got it right.
> >>=20
> >> Then it spit out the following program that can be used to make
> >> a table of 3dB points for a given sampling frequency. If I read the
> >> datasheet right, the sampling frequency depends on the number of
> >> bits being read.
> >>=20
> >> For example, for 3 Hz sample rate (18-bit samples), I got:
> >>=20
> >>  n  f_3dB (Hz)
> >>  1  0.58774
> >>  2  0.24939
> >>  3  0.12063
> >>  4  0.05984
> >>  5  0.02986
> >>  6  0.01492
> >>  7  0.00746
> >>=20
> >> I had to skip n=3D0 though since that is undefined. Not sure how we
> >> handle that since it means no filter. Maybe Jonathan can advise? =20
> >=20
> > This is always a fun corner case.  Reality is there is always
> > some filtering going on due to the analog side of things we
> > just have no idea what it is if the nicely defined filter is
> > turned off.  I can't remember what we have done in the past,
> > but one option would be to just have anything bigger than 0.58774
> > defined as being filter off and return a big number. Not elegant
> > though.  Or just don't bother supporting it if we think no one
> > will ever want to run with not filter at all.
> >=20
> > Hmm. or given this is a digital filter on a sampled signal, can we esta=
blish
> > an effective frequency that could be detected without aliasing and
> > use that?  Not sure - I'm way to rusty on filter theory (and was
> > never that good at it!) =20
>=20
> I=E2=80=99ve seen another driver use { U64_MAX, U64_MAX } for this case. =
It
> didn=E2=80=99t seem very clean. I thought to use { 999999, 999999 } or ev=
en
> { 1, 0 }, but anything other than =E2=80=9Coff=E2=80=9D just felt odd.
Ah.  Could we use filter_type? (additional attribute)

That already has a 'none' option.  Nothing there yet that works for the 'on'
option here.  These are always tricky to name unless they are a very
well known class of filter.   The datasheet calls this one an Exponential
Moving Average filter. Not a term I'd encountered before, but google did
find me some references.  so maybe ema as a filter type?
=20

>=20
> ChatGPT suggests this:
>=20
>     =E2=80=A2 Clamp to Nyquist frequency
>         =E2=80=A2 For a sample rate f_s, the maximum realizable cutoff is=
 the Nyquist limit f_s/2.
>         =E2=80=A2 At f_s =3D 3\ \text{Hz}, Nyquist is 1.5\ \text{Hz}.
>         =E2=80=A2 You could encode { 1, 500000 } (1.5 Hz) as the maximum =
meaningful cutoff.

Hmm. Whilst kind of backwards as that's where you'll see aliasing it does m=
ake more sense
I think than just a magic large number.

I think I prefer the filter type route though now your comment on 'off' has=
 lead me to it.

Make sure to add ABI docs for the new filter type if you do go that way.

Jonathan




