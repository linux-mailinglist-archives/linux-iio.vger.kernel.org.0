Return-Path: <linux-iio+bounces-26629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D667FC9BD10
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 15:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5670E347C44
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 14:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E82367B3;
	Tue,  2 Dec 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Em8LyT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378A21FF5B
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686379; cv=none; b=QD5DuWvqVhutgQsSAGuVXopXaC1XezSzc+fOX33wuAd9r30f5/eLJd3jwIFvSGwE29rbUXgw6qliFw02xv5WIvHapoa9ug+hywSaVkXojvcYiX+KgML55k5n5mX+hCgXFWWaiONCdylWwwIubmYL65tV7jt3nBcfzjHmBGz45IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686379; c=relaxed/simple;
	bh=aZx/6i4PV+XSZWPyBpQN9uU0i2DnHJsbJX8XUXQmjsg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OWxWah/zRVYhDIaHH6F/CWO0Fv6tabbaiIGcCiARK6uLILH8azoZ5ZZT6vXPTG0Qa4b2ZzOYckKe7yS1rId482q04TLs9uuCDTLQ5Hoxh4Z6CE1uYrRLLF7SSaJwyelqKgEW72VHfCi1kazrLyShSVQVW4NLi/X6efMb4FuCyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4Em8LyT; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55ae07cf627so1625020e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 06:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764686377; x=1765291177; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK6PHMqiItEJvhsik8lYBdE/HTgsHGok25qu5RzZyyg=;
        b=A4Em8LyTxXRZkA8vPrjnj/+gB32pHy4oFk3p5hdC3lJo1Pjw7BCZ7IgBveoUSwjbW+
         GA6h3xnGA1RgifvWZ7TRtfNvkuinlBvvsf8fOS9DEiVRpW2GBT+3Ctx/8Xqme88p7Ab6
         Ur5OgGdck9Yc4ngVEqCM19zkzzvNeK1wZ6LpjZCEn3ZJOB9dm/wX9ZG1cgkoJdCzLizu
         R29qYOhRQVJAhcXSg1iWGzWu7awr6dX+j7WFuPd0tj0iCUy9Vy9Wylr9pht+RrS5apgr
         9PgYsDkQApmGMkuIlmqTw6SwAjoWArxT+AkiHmIrv3G4f7DM2hLQCgNgdL4N8qjXOLiW
         Re+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764686377; x=1765291177;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UK6PHMqiItEJvhsik8lYBdE/HTgsHGok25qu5RzZyyg=;
        b=siz4CL/VWjqWTzeG8MEjQYBGV07AuixHaIpfhEU0gvI20AzEMyg6YV8LDZXw4T8u6D
         zhPW8x+SB2nEcSRDtcFiS4hMSkHJNhf0nlsST8WGYIoRk2r57CkczszbYzRczVTVKLCZ
         cl8MNVfgIh6WAcvPlqZR4Ejj7evxIqqHAM7P7aU5KOIv62NlsdEO3U8alL5vOt2vbXGF
         5fAHWJp991LGuAafGFQc+pEQrLXGkyRcXfbh7i2GH1DSZbbtgh/z9nQj/57d1srlBt77
         F5GRiEeacpuXBkOW3jlVuoOU5F0xhuw6s3Sn8Ybtn0+UImumHAfmmH0bbW+kCHMtt1NE
         ElnA==
X-Forwarded-Encrypted: i=1; AJvYcCUCjz3AH1oIwgMNl6ww2s9VKLuxU1ijSER9d93ZGmIKuFxaf7j/K0DiyykBPASFZG/aqwmRg7iR34s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8ZihyrVDV7Zua6Ev7SFQnQ0+xHHspn/D0FbfRmO0mAP0En7O
	WTM3vu+dLmCdv4GchwrBqtddimRue89DSwX11SDC3yD2Le4PMsQr+OPB
X-Gm-Gg: ASbGnctB6KtS9NvYwFvGd6t3JvbcaJUbrnu28RSybFFrPcFltLinlZCT9qSybz1q3EG
	zJ1/DLBTRbNXtNFRJCTd2YqhhlRmbu7clcxSiOuc3DdjVPDCsvTfoUe9L9ysen3TAO5ZcY9UiuQ
	vT8LMK2Q+bSTEl/SDZ/e9L88z89jkI4T5WNdzzW1wVj7zTsdt38u4ddw99DxiED74b6V5e27u5/
	CYLsDIA2Nqa2f7hb74njvXij5oi5YOQ/a26HcqumeIi+opR4bO9k2jF1LxQwaBe/O/jDltzySiJ
	40qIbMkUeRSgdDZuP35shpPS7CdQ/+NtsWztAwBWp40DrX6opuZYLih7LytQ02QdZaztgcM1Wsn
	yWXZDa7zrrsoR9fZigWAAYPAVZB+fuES1+xNlWb/fTovN2WKrDPjeIeI/43x0js0N/L6RSBBIFY
	deZsA=
X-Google-Smtp-Source: AGHT+IEISvZCykKFgKYrPaXC1owxjpY8fdWxMIYnIe0MU5C3tFhzQXFuARyvpNPLVGZ8ihlVpV/rRQ==
X-Received: by 2002:a05:6122:3a14:b0:559:6d5c:9722 with SMTP id 71dfb90a1353d-55b8eb1f6ebmr15630558e0c.0.1764686376558;
        Tue, 02 Dec 2025 06:39:36 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf516ba51sm6569243e0c.15.2025.12.02.06.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 06:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Dec 2025 09:39:34 -0500
Message-Id: <DENT40NRKH0V.3UD0JBGRUSCDS@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <a01f95ba-23c0-4c4b-a6bc-31b316bb04ef@baylibre.com>
In-Reply-To: <a01f95ba-23c0-4c4b-a6bc-31b316bb04ef@baylibre.com>

On Mon Dec 1, 2025 at 6:09 PM -05, David Lechner wrote:

...

>> +#define ADS1018_CFG_DEFAULT		0x058b
>
> Would be nice to use the macros below to define this value so that we
> know what it is actually doing.

I will drop this on the next version. More on it bellow.

...

>> +static int ads1018_read_unlocked(struct ads1018 *ads1018, __be16 *cnv, =
bool hold_cs)
>
> It is a bit odd to me to call this "unlocked" and then call
> "spi_synced_locked()". It sounds like we are using opposite words
> to mean the same thing.

Yes, that's true. I will revert this back to "locked", to match the SPI
naming.

...

> Do we actually need to transmit two words to trigger a conversion?
>
> It looks like there is a "16-Bit Data Transmission Cycle" for when
> we don't need to read the config register back.

Yes, we don't need the config readback anymore. I will convert
everything to 16-bit transmission.

...

>> +static int
>> +ads1018_read_raw_unlocked(struct iio_dev *indio_dev, struct iio_chan_sp=
ec const *chan,
>
> Saying "ulocked" here is a bit confusing since the previous "unlocked" ha=
d
> to do with SPI bus lock rather than iio_device_claim_direct().

I agree, this naming is a bit confusing.

Andy, are you okay if I revert this back to __ads1018_read_raw()? I can
add a comment on context.

...

>> +static int ads1018_buffer_preenable(struct iio_dev *indio_dev)
>> +{
>> +	struct ads1018 *ads1018 =3D iio_priv(indio_dev);
>> +	const struct ads1018_chip_info *chip_info =3D ads1018->chip_info;
>> +	unsigned int pga, drate, addr;
>> +	u16 cfg;
>> +
>> +	addr =3D find_first_bit(indio_dev->active_scan_mask, iio_get_masklengt=
h(indio_dev));
>> +	pga =3D ads1018_get_pga_mode(ads1018, addr);
>> +	drate =3D ads1018_get_data_rate_mode(ads1018, addr);
>> +
>> +	cfg =3D ADS1018_CFG_VALID;
>> +	cfg |=3D FIELD_PREP(ADS1018_CFG_MUX_MASK, addr);
>> +	cfg |=3D FIELD_PREP(ADS1018_CFG_PGA_MASK, pga);
>> +	cfg |=3D FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_CONTINUOUS);
>> +	cfg |=3D FIELD_PREP(ADS1018_CFG_DRATE_MASK, drate);
>> +
>> +	if (chip_info->channels[addr].type =3D=3D IIO_TEMP)
>> +		cfg |=3D ADS1018_CFG_TS_MODE_EN;
>> +
>> +	ads1018->tx_buf[0] =3D cpu_to_be16(cfg);
>> +	ads1018->tx_buf[1] =3D 0;
>
> Seems like we could use 16-bit cycles here too?
>
>> +
>> +	return spi_write(ads1018->spi, ads1018->tx_buf, sizeof(ads1018->tx_buf=
));
>
> Hmmm... In the case where the trigger is not the DRDY signal (i.e. hritme=
r or
> sysfs), it seems like we would want to defer this until we actually recei=
ve
> a trigger. Otherwise, if the trigger is not already enabled and it is a w=
hile
> before the trigger is enabled, then the first data value will be quite st=
ale
> compared to the others since the conversion was done when the buffer was =
enabled
> rather than when the trigger fired.

Because this is configured as ADS1018_MODE_CONTINUOUS, every time a
conversion is completed, it automatically refreshes the last conversion
on the register, so it is never stale (Section 8.4.2.2).

>
>> +}
>> +
>> +static int ads1018_buffer_postdisable(struct iio_dev *indio_dev)
>> +{
>> +	struct ads1018 *ads1018 =3D iio_priv(indio_dev);
>> +
>> +	ads1018->tx_buf[0] =3D cpu_to_be16(ADS1018_CFG_DEFAULT);
>
> Changing DEFAULT to a more descritive name (e.g. SINGLE_SHOT_MODE) would =
make
> this more clear that the purpose of doing this is to take it out of conve=
rsion
> mode. Otherwise, a comment would be helpful here.

I think it's better to just construct a minimal config with
ADS1018_MODE_ONESHOT here.

Ack to everything else. Thanks, David.


--=20
 ~ Kurt


