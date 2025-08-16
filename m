Return-Path: <linux-iio+bounces-22846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E7B28F2A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 17:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B3A23780
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8842513B5A9;
	Sat, 16 Aug 2025 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=watter-com.20230601.gappssmtp.com header.i=@watter-com.20230601.gappssmtp.com header.b="q41O9S6q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4561189
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755358411; cv=none; b=KID6YgiLP3wfHmAljnhOPYSPDbdg/sP7LfEztt/FmCdOKY9nyQCQaiq+PejgonZB9B/Du4Ea8t1jUyPkICEbZWkc0+lBVQPQa87sXj9cDFdzb1k68ms0HAQFejnAqczyCH9LRWJn6sup1/FBVT684Oxl2X5SMtNEXMJuuWTGW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755358411; c=relaxed/simple;
	bh=dbf+21yIHggLWEeSKkhjYBASontrjXkiLG2CL2Izi2E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s/Es/2gVEo427xlhItuVe0vxHr2Vak3YmGp/VnBHD6sS57OfjKEIqHTmKCODergGgkZYmBdLUb8fnLvpgdKuN2KNnicnVIQqwN5F3qBVQjPakW5x85L+adcnayYah6+UJGdd3rGDdUvl7TKO1m0DpjP0EajGTrMpws18/tUd1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=watter.com; dkim=pass (2048-bit key) header.d=watter-com.20230601.gappssmtp.com header.i=@watter-com.20230601.gappssmtp.com header.b=q41O9S6q; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=watter.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b132f943a3so2253311cf.1
        for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=watter-com.20230601.gappssmtp.com; s=20230601; t=1755358408; x=1755963208; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT4GYVc03o/2wHM5Ynf/D/xh1YH2nsw8S0x9olXJtHM=;
        b=q41O9S6qNfstcDRLyrPG2JLChVu8CFliaZ6/J2O+RnZiN9xpzI6imt15JiJMmSZv2m
         oLfPmPALVORAwoHpKGy1UbUT5SPcd5g2JEfW6NfaL4PgnvqBfGVmJNeC2IT03MdzsKnY
         gvnIXm/Nb4sBAHN9Y5AKD+fBSJEOLTit0LPH2+yZKqGW6qFCL4MlYQaoW1uuarKTMq5D
         eSkydsa+iY6UQ2t0y1iDz0H0XkTUleIwkL75N/w24s3GLb4eCzC+z5gGy1fpF+YZ2/Z/
         ELalzIKKmgA0xTCICNnDAA12cHf6DQ8vjRM38WDqC/jgy3bxI5osgY6LwJpo17wz7s/b
         /HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755358408; x=1755963208;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT4GYVc03o/2wHM5Ynf/D/xh1YH2nsw8S0x9olXJtHM=;
        b=D7muDYhDJVGRR/aKmCx14W+zP1LbkA+ZZfIm8lYLtUFJy9l+pcbDR0X5EvnVdncPSI
         Ux7DHEjU98uTF8Mc+f4D+o0K/BFcBUIHPwVEk7GphA+uZvwht94ksnQOHYdvY4ZhQha8
         PwUbfHmD7U2SrNM4sR8oWdxRmbj0EUkqOaMhlDg1WIz31Pg8xiC//IP1R/bQMnWZ/91d
         MeSWwQUSJbdPedqCB+I6ZNKLkw/Twetl7tZyblh34tempyg+KuC0hRkwSm9k/jVLmo+M
         BNbiphVXlJ7KZowKImTQfJo6Vlgze5zWLb9/jYxwhoKjmCTebVY098XzGWueKKkZgWZS
         5B2g==
X-Forwarded-Encrypted: i=1; AJvYcCW0g3dpo92jI/QQB7STV+GXOzGNL8ZT4eM5JDFIGYIG5KauyJ0QhSr8nW1+NJIuszkejt3pu0EQXVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8GAJ/iCjaotDz8YKnJqqe2lIBHwWcUH7gsZNo2nRGzkMZMGmn
	f/YVhX3zyzVKrpoIDeNlX8hP5Hr0ggBKR7u0wZQKhJb7TDj9yKkuaiBL6EHauRl1mg==
X-Gm-Gg: ASbGncuV0a3be40OeKGoUFdNjVVfdqL7Hz7GD9AU6zsCvJL8keFgR/17u7jZ26zcSxb
	K0jbRulkhtImKkAOb7G8X3b9m9tJfLQl2TORk8tXeiv7XdR7zQ/yoUokVkGvt94l8Zo4KNqBeZj
	lkCww3K2bQoFJeHhmhRcL0oHS+kTTYnalCboBGmBBHnlwNicazWUozPy2+75v4A3kbg5IDo1inN
	jRw+8Gb47XeVXS4PK3gZ6fTUtjlJnybjs81S2bPh7zTR3fOc9fgiykQRZ8pMoN5tjMroRYgrmBT
	C/0Wpf/IO2QYQzc82SufokGDyBBVRJp8Hjai+5EtdZj3TmMVKuK5Hj/80nC0WmzoYap4f/zBWAg
	Y3HFM+6ceWy3SwAf/bReSaq0r7QZaAx7mVifjQoPx4g==
X-Google-Smtp-Source: AGHT+IGSad1ScauPnbohVvSDUUWWl1dpR+oMxuVRES9HnD+0AuwhYLy+nebDAM2aCbUd5zHFkqTUlg==
X-Received: by 2002:ac8:5881:0:b0:4af:195a:b92e with SMTP id d75a77b69052e-4b127b8e894mr53708851cf.39.1755358408456;
        Sat, 16 Aug 2025 08:33:28 -0700 (PDT)
Received: from smtpclient.apple ([70.32.192.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc188desm24642661cf.2.2025.08.16.08.33.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Aug 2025 08:33:27 -0700 (PDT)
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
In-Reply-To: <59D7D612-D618-4FF0-A932-2EB0B57D321E@watter.com>
Date: Sat, 16 Aug 2025 11:33:17 -0400
Cc: David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <93E1A889-81AE-4DAB-9297-2A74C87E38B3@watter.com>
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
 <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
 <20250816105410.70e47dac@jic23-huawei>
 <DA11BDA3-E4E3-4C1A-9E4E-84E92F62A4B3@watter.com>
 <20250816160835.3b44a4cd@jic23-huawei>
 <59D7D612-D618-4FF0-A932-2EB0B57D321E@watter.com>
To: Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.2)


> On Aug 16, 2025, at 11:19=E2=80=AFAM, Ben Collins =
<bcollins@watter.com> wrote:
>=20
>>=20
>> On Aug 16, 2025, at 11:08=E2=80=AFAM, Jonathan Cameron =
<jic23@kernel.org> wrote:
>>=20
>> On Sat, 16 Aug 2025 09:12:37 -0400
>> Ben Collins <bcollins@watter.com> wrote:
>>=20
>>>> On Aug 16, 2025, at 5:54=E2=80=AFAM, Jonathan Cameron =
<jic23@kernel.org> wrote:
>>>>=20
>>>> On Wed, 13 Aug 2025 17:52:04 -0500
>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>=20
>>>>> On 8/13/25 10:15 AM, Ben Collins wrote: =20
>>>>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>>>>> to allow get/set of this value.
>>>>>>=20
>>>>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>>>>> ---
>>>>>> drivers/iio/temperature/mcp9600.c | 43 =
+++++++++++++++++++++++++++++++
>>>>>> 1 file changed, 43 insertions(+)
>>>>>>=20
>>>>>> diff --git a/drivers/iio/temperature/mcp9600.c =
b/drivers/iio/temperature/mcp9600.c
>>>>>> index 5ead565f1bd8c..5bed3a35ae65e 100644
>>>>>> --- a/drivers/iio/temperature/mcp9600.c
>>>>>> +++ b/drivers/iio/temperature/mcp9600.c
>>>>>> @@ -31,6 +31,7 @@
>>>>>> #define MCP9600_STATUS_ALERT(x) BIT(x)
>>>>>> #define MCP9600_SENSOR_CFG 0x5
>>>>>> #define MCP9600_SENSOR_TYPE_MASK GENMASK(6, 4)
>>>>>> +#define MCP9600_FILTER_MASK GENMASK(2, 0)
>>>>>> #define MCP9600_ALERT_CFG1 0x8
>>>>>> #define MCP9600_ALERT_CFG(x) (MCP9600_ALERT_CFG1 + (x - 1))
>>>>>> #define MCP9600_ALERT_CFG_ENABLE BIT(0)
>>>>>> @@ -111,6 +112,7 @@ static const struct iio_event_spec =
mcp9600_events[] =3D {
>>>>>> .address =3D MCP9600_HOT_JUNCTION,        \
>>>>>> .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |        \
>>>>>>     BIT(IIO_CHAN_INFO_SCALE) |       \
>>>>>> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
>>>>>>     BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
>>>>>> .event_spec =3D &mcp9600_events[hj_ev_spec_off],        \
>>>>>> .num_event_specs =3D hj_num_ev,        \
>>>>>> @@ -149,6 +151,7 @@ static const struct iio_chan_spec =
mcp9600_channels[][2] =3D {
>>>>>> struct mcp9600_data {
>>>>>> struct i2c_client *client;
>>>>>> u32 thermocouple_type;
>>>>>> + u32 filter_level;
>>>>>> };
>>>>>>=20
>>>>>> static int mcp9600_read(struct mcp9600_data *data,
>>>>>> @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev =
*indio_dev,
>>>>>> case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>>>>>> *val =3D mcp9600_tc_types[data->thermocouple_type];
>>>>>> return IIO_VAL_CHAR;
>>>>>> + case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>>>>>> + *val =3D data->filter_level;   =20
>>>>>=20
>>>>> We can't just pass the raw value through for this. The ABI is =
defined
>>>>> in Documentation/ABI/testing/sysfs-bus-iio and states that the =
value
>>>>> is the frequency in Hz.
>>>>>=20
>>>>> So we need to do the math to convert from the register value to
>>>>> the required value.
>>>>>=20
>>>>> I'm a bit rusty on my discrete time math, so I had chatgpt help me
>>>>> do the transform of the function from the datasheet to a transfer
>>>>> function and use that to find the frequency response.
>>>>>=20
>>>>> It seemed to match what my textbook was telling me, so hopefully
>>>>> it got it right.
>>>>>=20
>>>>> Then it spit out the following program that can be used to make
>>>>> a table of 3dB points for a given sampling frequency. If I read =
the
>>>>> datasheet right, the sampling frequency depends on the number of
>>>>> bits being read.
>>>>>=20
>>>>> For example, for 3 Hz sample rate (18-bit samples), I got:
>>>>>=20
>>>>> n  f_3dB (Hz)
>>>>> 1  0.58774
>>>>> 2  0.24939
>>>>> 3  0.12063
>>>>> 4  0.05984
>>>>> 5  0.02986
>>>>> 6  0.01492
>>>>> 7  0.00746
>>>>>=20
>>>>> I had to skip n=3D0 though since that is undefined. Not sure how =
we
>>>>> handle that since it means no filter. Maybe Jonathan can advise? =20=

>>>>=20
>>>> This is always a fun corner case.  Reality is there is always
>>>> some filtering going on due to the analog side of things we
>>>> just have no idea what it is if the nicely defined filter is
>>>> turned off.  I can't remember what we have done in the past,
>>>> but one option would be to just have anything bigger than 0.58774
>>>> defined as being filter off and return a big number. Not elegant
>>>> though.  Or just don't bother supporting it if we think no one
>>>> will ever want to run with not filter at all.
>>>>=20
>>>> Hmm. or given this is a digital filter on a sampled signal, can we =
establish
>>>> an effective frequency that could be detected without aliasing and
>>>> use that?  Not sure - I'm way to rusty on filter theory (and was
>>>> never that good at it!) =20
>>>=20
>>> I=E2=80=99ve seen another driver use { U64_MAX, U64_MAX } for this =
case. It
>>> didn=E2=80=99t seem very clean. I thought to use { 999999, 999999 } =
or even
>>> { 1, 0 }, but anything other than =E2=80=9Coff=E2=80=9D just felt =
odd.
>> Ah.  Could we use filter_type? (additional attribute)
>>=20
>> That already has a 'none' option.  Nothing there yet that works for =
the 'on'
>> option here.  These are always tricky to name unless they are a very
>> well known class of filter.   The datasheet calls this one an =
Exponential
>> Moving Average filter. Not a term I'd encountered before, but google =
did
>> find me some references.  so maybe ema as a filter type?
>=20
> In the docs I have, it says:
>=20
> In addition, this device integrates a first order recursive
> Infinite Impulse Response (IIR) filter, also known as
> Exponential Moving Average (EMA).
>=20
> The EMA formula I=E2=80=99ve used for an adc-attached thermistor was =
the same
> formula I=E2=80=99ve seen used in IIR, so I think they are generally =
the same.

Clarification: An EMA is a 1-pole IIR filter, while IIR filters can be
many other types besides 1-pole.


