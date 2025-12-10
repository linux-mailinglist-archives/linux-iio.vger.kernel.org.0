Return-Path: <linux-iio+bounces-26986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BFCCB1E12
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 05:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE8E930FD4E4
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 04:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39E30FC37;
	Wed, 10 Dec 2025 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX3fWj0C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238030E0F1
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 04:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765339718; cv=none; b=ECNnUmJvLNQlYZutSijYPAnTWIZDugAqpF9OWYf9D8hDew+TRX9Jk6i6O3IjLWoyUy+NCR6v2jZTmaP5pN0gcrRN+BAJgQjMgqS4V2OpVQ5cg3xcBiVVDt2iLirtSLE6ObdBTIeqxapZ9SURMFlYyzUorxyAv/9NhvNElOkdxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765339718; c=relaxed/simple;
	bh=Gr53fuTbHZKpl46q1LFj7gcfKtH2HbjrpK1Otwbijug=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=eAO1HRqw9Xy5tlWzCcX4FUqIDlvyBA1OK3j5mcWeVKX7DQ/CpWeQlCOedK8A57geFqD7vCh/upJYR+qFn7iBNo0BYTLG5Nq/6UO6jkuxxUC7FWWvOd24sf0QzRDx+DGOYr56SoCE4HbeylVS457x2qq9BzjZjRLohoHimIKifJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX3fWj0C; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5e55bd6f5bbso1317475137.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Dec 2025 20:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765339716; x=1765944516; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8j58EbJRehVD66NIXI6Vngeh4NEZg0BT3sgTrmPRCJg=;
        b=ZX3fWj0C7UAwfkoTgwzOWxF41qAJaP8U/Y9XUwZb/k19ylwNMaGjcGv4cFGuLiGRrk
         op6oAJWRbHjLGSIbkbcxgWs8wvDbSnal06XXuvaEQMjG3BAY/NvwEE5Vk6poG0AKnzdv
         0MeZTDt8Einri/pVFJaGYB8e+nTbB0XqgE+ukTblDLgXNd2kp06u/5Za/FeLzGTjGKb3
         vFpAALA2Unrevc3xA4Fr+/bJdBAgEBaBhzdiB7w4MduqlmAz7RzzLKFQ5ycdhJIHwT7M
         bMKhYlSK1JtkyCFwweFSmGk1xatuguTCjfDbrjMXJYVgxBvZhYg9JyWo67jJBDPA3Bmn
         Wn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765339716; x=1765944516;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8j58EbJRehVD66NIXI6Vngeh4NEZg0BT3sgTrmPRCJg=;
        b=V/xXe9rY7QcqqWZRlKYHYsuFrO0Dbs93j6RRYtMdtMe90Jv4LYUVUWBdzUBHdpmZRt
         VVXY3Bhep6wc1o+x8zaBQUwmr19L+kkwG0Wr5L4rzhH/oZQrWCjX6ZMb9IAtrJoveV2A
         tNCnMtSfgLLjCTTaEgMCgPjoLqaSCjCWeQPAJ5FAa6+9L1ktBG28QFp6R6AVgG7rzvlc
         v8Zgoj4cb8JaBobSMY1pLJsvOkZYSHVjp+B8qHaX5XsWiTIyxINFf7gyq2SeQObM1tYV
         dp23k187vJamU/W5XjxH9lYwYedBp1MseMGefRTYs1twG4Tu65biFVj2s+XFVrzsOHuF
         uKDA==
X-Forwarded-Encrypted: i=1; AJvYcCXgiT0VLjP/9cILdMyV3fN1mGK5hTPu6QXmrQUsTTuuSNInWMoDk+TnoaRnTBzm0AhAfUAOor2G1gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWyOkpz4ah3WeBlz0soe7Ho5K6IwDrDm40xxw45dQdlQtiaNyT
	UImmZgc2gu/i9yZdcW0K1Of6Z9vohQXoNqQTvlMKj3uQY78i1yT1Mzca
X-Gm-Gg: AY/fxX5Af5T6xvU1NcZEzz/7KpEFuxvjdt+ufJEvVUBahqiXZn9WPUxyoseUb8vtrkr
	qPjdC/180y1FoU6p9wI9QG5FX9Y1D2rvQ6n1ZIGnqn7NKi2ZO6zi7DvAnjemvyp0m9ABLzy6+cQ
	pAdRA69NcqDsvZmunggC8wfAEYRS51p2axt1w/9u1rdkS4tKSWOvnZbjKQIubquMpbrrbTxFm2B
	vYBX7p3yETw2d7U6eq9pr9gEm8SkLGgIJU5ErQjS64wTy/Uk+G3lHVNi5goomkfbnwdWJAH3cvv
	PYrKZchPkE+UWw9ck/4nTeSsbRiZfsmwZQtI3Vf/50/Isgy9CWnyC6P0qn1hXWkHZzbgxHG2FzM
	WNVUuXKtBm8k4qk0bGI9YYBAl0uHlMQDaenuKPJ+F+g7ATUtfWhCNY3wzgD+SjtJd6+JpVITdne
	divHOXanwvQRt29A==
X-Google-Smtp-Source: AGHT+IHeJyww8xPuUv2NJf/IVFsizp5qbt8Bdk/UY3APTv8xhYUgPWJ1SWgJYbINgzgxJuiNKs4R1w==
X-Received: by 2002:a05:6102:6b0a:b0:5e5:7055:66f5 with SMTP id ada2fe7eead31-5e571f2f71emr373127137.27.1765339715682;
        Tue, 09 Dec 2025 20:08:35 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e51068471asm7888292137.0.2025.12.09.20.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 20:08:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Dec 2025 23:08:33 -0500
Message-Id: <DEU8P8MUASOG.228OIP4QQDZD1@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Tobias
 Sperling" <tobias.sperling@softing.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 2/2] iio: adc: Add ti-ads1018 driver
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com>
 <20251204-ads1x18-v6-2-2ae4a2f8e90c@gmail.com>
 <20251206200721.5e683a83@jic23-huawei>
 <DES3ZWAKXXEB.2LQPMDZN4JFCB@gmail.com>
 <5b843df0-138e-4e2e-a70d-beb8a39ed85f@baylibre.com>
 <20251207195613.0e222b3a@jic23-huawei>
 <DESJEELPCGK3.3H15VL3YAC0RT@gmail.com>
 <04aee30f-908b-4390-934a-e49990217d15@baylibre.com>
In-Reply-To: <04aee30f-908b-4390-934a-e49990217d15@baylibre.com>

On Mon Dec 8, 2025 at 11:00 AM -05, David Lechner wrote:
> On 12/7/25 10:06 PM, Kurt Borja wrote:
>> On Sun Dec 7, 2025 at 2:56 PM -05, Jonathan Cameron wrote:
>>> On Sun, 7 Dec 2025 11:12:51 -0600
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>
>>>> On 12/7/25 10:02 AM, Kurt Borja wrote:
>>>>> On Sat Dec 6, 2025 at 3:07 PM -05, Jonathan Cameron wrote: =20
>>>>>> On Thu, 04 Dec 2025 13:01:28 -0500
>>>>>> Kurt Borja <kuurtb@gmail.com> wrote:
>>>>>> =20
>>>>>>> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
>>>>>>> analog-to-digital converters.
>>>>>>>
>>>>>>> These chips' MOSI pin is shared with a data-ready interrupt. Defini=
ng
>>>>>>> this interrupt in devicetree is optional, therefore we only create =
an
>>>>>>> IIO trigger if one is found.
>>>>>>>
>>>>>>> Handling this interrupt requires some considerations. When enabling=
 the
>>>>>>> trigger the CS line is tied low (active), thus we need to hold
>>>>>>> spi_bus_lock() too, to avoid state corruption. This is done inside =
the
>>>>>>> set_trigger_state() callback, to let users use other triggers witho=
ut
>>>>>>> wasting a bus lock.
>>>>>>>
>>>>>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com> =20
>>>>>
>>>>> ...
>>>>>  =20
>>>>>>> +#define ADS1018_VOLT_CHAN(_index, _chan, _realbits) {				\
>>>>>>> +	.type =3D IIO_VOLTAGE,							\
>>>>>>> +	.channel =3D _chan,							\
>>>>>>> +	.scan_index =3D _index,							\
>>>>>>> +	.scan_type =3D {								\
>>>>>>> +		.sign =3D 's',							\
>>>>>>> +		.realbits =3D _realbits,						\
>>>>>>> +		.storagebits =3D 16,						\
>>>>>>> +		.shift =3D 16 - _realbits,					\
>>>>>>> +		.endianness =3D IIO_BE,						\
>>>>>>> +	},									\
>>>>>>> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |				\
>>>>>>> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
>>>>>>> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\ =20
>>>>>>
>>>>>> What motivates per channel sampling frequency?
>>>>>>
>>>>>> Given you have to write it each time you configure I guess it doesn'=
t matter much
>>>>>> either way. =20
>>>>>
>>>>> I guess making it shared by all is simpler too, so I'll go with that.
>>>>>  =20
>>>> Just keep in mind that if there is ever some use case we don't know
>>>> about that would require a different rate per channel, we can't change
>>>> it without breaking usespace. Once the decision is made, we are
>>>> locked in. Keeping it per-channel seems more future-proof to me.
>>>
>>> Only way I can think of that might cause that to matter would be
>>> if the complex dance to avoid the onehot buffer restriction is added.
>>> Given you gave this response I went looking and that might make
>>> sense as an enhancement as the SPI protocol would allow a crafted messa=
ge
>>> sequence to do this efficiently.  Extension of figure 15 where first me=
ssage
>>> sets config and after that they read out channel and set config for nex=
t one.
>>=20
>> This is possible, yes. But would the timestamp even make sense in this
>> case? Even in the fastest sampling rate, we would have to wait at least
>> 1 ms for each channel and the timestamp would become stale.
>>=20
>> That was my reasoning for using the onehot restriction.
>>=20
>> Is that acceptable? Or maybe we would need to disallow the timestamp
>> channel if more than one channel is selected?
>
> Yes. We have pretty much the same situation with timestamps on every
> other ADC. The timestamp is usually when one full set of samples is
> triggered. Not when the actual individual conversions are performed.

This is good to know for future patches or drivers. Thanks!


--=20
 ~ Kurt


