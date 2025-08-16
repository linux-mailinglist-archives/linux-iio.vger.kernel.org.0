Return-Path: <linux-iio+bounces-22816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF27B28E09
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E985FA212B9
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984032E2DF8;
	Sat, 16 Aug 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=watter-com.20230601.gappssmtp.com header.i=@watter-com.20230601.gappssmtp.com header.b="xjCTLRfJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFDD2D3206
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755349972; cv=none; b=nAaQuDkMgX2341sNnbd71hElKUQOexdPHOsJj6bGN2PzzJuyt5wpkBiULHh74eLgSw4YJkyNOVjnBWmmgBtXlAYJNa9YYlIsKz17n8MgFh86vs9uVd4vtVb7tTef7hKpptchML/sVzcWbwUPsMlAkCIIcElHmbHomE3dZ3aUgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755349972; c=relaxed/simple;
	bh=xuEN5C/Nbr2ntQwhAtJRjzipYu89UfcJvVo4gE+Sxc4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=j+kAMeuAF2a5LXY6zHBZLeAmzOnlgc7wbfGLMAHnyDuwoK/EppjrVH5aRzR8IybbNnzU/uliFIgB8ghAE9wTfo5akYRRXgwSeE4BDcvPRYT1BRelSxLjMN8bmg2GulRpE4vk8qpdafSUeNm6P1lQRawz9mnBscbiSrPrwdY4wVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=watter.com; dkim=pass (2048-bit key) header.d=watter-com.20230601.gappssmtp.com header.i=@watter-com.20230601.gappssmtp.com header.b=xjCTLRfJ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=watter.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70a88ddc000so32109716d6.0
        for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=watter-com.20230601.gappssmtp.com; s=20230601; t=1755349969; x=1755954769; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e3eahyGTlwrpuN1OkAQyzw7sphWbkwXPu/gpLSqi7E=;
        b=xjCTLRfJ8jmT7+mXJI7JfyAtl4e2/dhrvP6Y/z4WyDu01ryESKfVWhn8vyR+oyh9lI
         4YybkLmISnv+EpEIsNhLEKMe21KhpEgZFyj+0XbjlmPeobWDDv1B/pH+eXZ1y+UGGVaD
         s0lhuDytnAHDCFISf8MFG6OulOinKwF/8MWGaVGPFBr9E9In1E+z3zTN4akoIj956k93
         fdEGcHAFudHsf1UxF8pAs0Iq8qIEE09Yewul4rnu8jPRbQUmC8tIjaQi7CG0mF/j/Ew7
         XxWwBxCmS0RtVK5qKs9CbWOmC0SUlk+qWilw0zesf8KFcwXHdoqkHgQQEeUuW7wHcsKF
         4LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755349969; x=1755954769;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3e3eahyGTlwrpuN1OkAQyzw7sphWbkwXPu/gpLSqi7E=;
        b=S3HU0n1EsG1/NGxdUAWXSuqA7DsjrLi//6uhzbEnEurWdSh0x40Qr/k59Yc2GLtLFN
         9HdQLV1WL49Wqag6jZRGHaPv6hZEQhC1t25CYI1S9nvbt+xUefliM94pQLbZhLKQGkMX
         kFbVxAliAzK6UYa5dv5HpJxD2CZrcfkO9TREXQ1ELC/12Cr3KK5I7Kqk9H3LcSp6MVYm
         ZpVkiLEVdydJQviFSl6Dx+lpisywSglLIj5OsgdXlflbCU3cCF3x1tfTIs0rW3dmE4tF
         FG/bsOf6cv+uxEipZ9y+DnJr+fjm/jp+AbJpk0gr+JPxlOWVYOLkVwSLNibauH9egHQE
         uN9g==
X-Forwarded-Encrypted: i=1; AJvYcCXzPayoUGQjCh5dC0duBs63ADgJqB+LPEXkRyfx0hg4qbUUfBSQQnfX1dhF+29NdkGFYMgkfdVR9bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx00nWog92Jz/ugTa2G9OgKwg11ZSOwEGlyu4xU2hrsCMUOYsI
	nV6qJeoTEUSUZWhW2X2s0vXFwyXt0gtgSdMvwqT2qAxebjmQFonq7hPo7ZNdUkl6CA==
X-Gm-Gg: ASbGncvDC33cU2Vg8avdCq2RaY5H8u4SzBYRHqTPKQr8RM+aqbw2wWSew7f9MxgX1BQ
	RPPCp3eEmy1x+4QaGKO2x1GRJyrCqn8G2P4bNPdyae85mTWEGtfp397/sZoOEeRQZko8dQ5oI+z
	upAKPJkL9Gbrl6oiaoCulshbvoMm0t1wYLksgicxXgPp3MguuF1jU2eYxQ7+SMZBMAmCcCEV4eT
	fgIeLLOA2RtSjOzs1IzyZQFEKV223Y4286mpnYfHt64ErrlJnThc1ybfZr+WNF1pl96yaiUAWCH
	vTU8EkHpwvuaWw+nXnxEtClzE/QcCkk6Xr/Whz450R2qB43AD/LbaMdZ4Sogjjl02CWOswvvNwE
	/67qmkWQJ9p+t2mqZl7zcUXRMBncjrX94xNvWU2TXcQ==
X-Google-Smtp-Source: AGHT+IED7ys9c0A/toCeTZHXT2h97zA6/ikubb5ID7vgFskgxGDqiTdoCeRuKjRzsWhaVuatX+jjIw==
X-Received: by 2002:a05:6214:2124:b0:707:70b7:376d with SMTP id 6a1803df08f44-70bb0587ccamr29176266d6.1.1755349969262;
        Sat, 16 Aug 2025 06:12:49 -0700 (PDT)
Received: from smtpclient.apple ([70.32.192.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87dee34f8sm272871385a.0.2025.08.16.06.12.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Aug 2025 06:12:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.2\))
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
From: Ben Collins <bcollins@watter.com>
In-Reply-To: <20250816105410.70e47dac@jic23-huawei>
Date: Sat, 16 Aug 2025 09:12:37 -0400
Cc: David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA11BDA3-E4E3-4C1A-9E4E-84E92F62A4B3@watter.com>
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
 <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
 <20250816105410.70e47dac@jic23-huawei>
To: Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.2)


> On Aug 16, 2025, at 5:54=E2=80=AFAM, Jonathan Cameron =
<jic23@kernel.org> wrote:
>=20
> On Wed, 13 Aug 2025 17:52:04 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
>> On 8/13/25 10:15 AM, Ben Collins wrote:
>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>> to allow get/set of this value.
>>>=20
>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>> ---
>>> drivers/iio/temperature/mcp9600.c | 43 =
+++++++++++++++++++++++++++++++
>>> 1 file changed, 43 insertions(+)
>>>=20
>>> diff --git a/drivers/iio/temperature/mcp9600.c =
b/drivers/iio/temperature/mcp9600.c
>>> index 5ead565f1bd8c..5bed3a35ae65e 100644
>>> --- a/drivers/iio/temperature/mcp9600.c
>>> +++ b/drivers/iio/temperature/mcp9600.c
>>> @@ -31,6 +31,7 @@
>>> #define MCP9600_STATUS_ALERT(x) BIT(x)
>>> #define MCP9600_SENSOR_CFG 0x5
>>> #define MCP9600_SENSOR_TYPE_MASK GENMASK(6, 4)
>>> +#define MCP9600_FILTER_MASK GENMASK(2, 0)
>>> #define MCP9600_ALERT_CFG1 0x8
>>> #define MCP9600_ALERT_CFG(x) (MCP9600_ALERT_CFG1 + (x - 1))
>>> #define MCP9600_ALERT_CFG_ENABLE BIT(0)
>>> @@ -111,6 +112,7 @@ static const struct iio_event_spec =
mcp9600_events[] =3D {
>>> .address =3D MCP9600_HOT_JUNCTION,        \
>>> .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |        \
>>>       BIT(IIO_CHAN_INFO_SCALE) |       \
>>> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
>>>       BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
>>> .event_spec =3D &mcp9600_events[hj_ev_spec_off],        \
>>> .num_event_specs =3D hj_num_ev,        \
>>> @@ -149,6 +151,7 @@ static const struct iio_chan_spec =
mcp9600_channels[][2] =3D {
>>> struct mcp9600_data {
>>> struct i2c_client *client;
>>> u32 thermocouple_type;
>>> + u32 filter_level;
>>> };
>>>=20
>>> static int mcp9600_read(struct mcp9600_data *data,
>>> @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev =
*indio_dev,
>>> case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>>> *val =3D mcp9600_tc_types[data->thermocouple_type];
>>> return IIO_VAL_CHAR;
>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>>> + *val =3D data->filter_level; =20
>>=20
>> We can't just pass the raw value through for this. The ABI is defined
>> in Documentation/ABI/testing/sysfs-bus-iio and states that the value
>> is the frequency in Hz.
>>=20
>> So we need to do the math to convert from the register value to
>> the required value.
>>=20
>> I'm a bit rusty on my discrete time math, so I had chatgpt help me
>> do the transform of the function from the datasheet to a transfer
>> function and use that to find the frequency response.
>>=20
>> It seemed to match what my textbook was telling me, so hopefully
>> it got it right.
>>=20
>> Then it spit out the following program that can be used to make
>> a table of 3dB points for a given sampling frequency. If I read the
>> datasheet right, the sampling frequency depends on the number of
>> bits being read.
>>=20
>> For example, for 3 Hz sample rate (18-bit samples), I got:
>>=20
>>  n  f_3dB (Hz)
>>  1  0.58774
>>  2  0.24939
>>  3  0.12063
>>  4  0.05984
>>  5  0.02986
>>  6  0.01492
>>  7  0.00746
>>=20
>> I had to skip n=3D0 though since that is undefined. Not sure how we
>> handle that since it means no filter. Maybe Jonathan can advise?
>=20
> This is always a fun corner case.  Reality is there is always
> some filtering going on due to the analog side of things we
> just have no idea what it is if the nicely defined filter is
> turned off.  I can't remember what we have done in the past,
> but one option would be to just have anything bigger than 0.58774
> defined as being filter off and return a big number. Not elegant
> though.  Or just don't bother supporting it if we think no one
> will ever want to run with not filter at all.
>=20
> Hmm. or given this is a digital filter on a sampled signal, can we =
establish
> an effective frequency that could be detected without aliasing and
> use that?  Not sure - I'm way to rusty on filter theory (and was
> never that good at it!)

I=E2=80=99ve seen another driver use { U64_MAX, U64_MAX } for this case. =
It
didn=E2=80=99t seem very clean. I thought to use { 999999, 999999 } or =
even
{ 1, 0 }, but anything other than =E2=80=9Coff=E2=80=9D just felt odd.

ChatGPT suggests this:

    =E2=80=A2 Clamp to Nyquist frequency
        =E2=80=A2 For a sample rate f_s, the maximum realizable cutoff =
is the Nyquist limit f_s/2.
        =E2=80=A2 At f_s =3D 3\ \text{Hz}, Nyquist is 1.5\ \text{Hz}.
        =E2=80=A2 You could encode { 1, 500000 } (1.5 Hz) as the maximum =
meaningful cutoff.=

