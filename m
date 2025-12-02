Return-Path: <linux-iio+bounces-26640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699CEC9C277
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 17:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3D43A9D80
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E328469A;
	Tue,  2 Dec 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbmZ5G9F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6588287268
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691698; cv=none; b=BQ4sPELb4XgJ2FhhoVjcpoUk0MF8+WXDQn0d0NeiHy9YtdZquHkFin9wRfvdW9cDbe12ZBdTeNH2OV5fMrAuuRs21dIg0A7fdPP6dBta5rNJNVC986LpZy30oyUwdO9I3QicjkLbzhbJe0qBXHt6Uj4TNB6MbkCnayYehy0c6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691698; c=relaxed/simple;
	bh=g+P6WznOZVMRIKxm6yWTjkhYjM78AYVWkUJIRoCPcC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SO/kRkFA1gRB4xJx6Kv0WQSI8JBTrAftDBlksgxgPVjqR2gCqUKwbbGdY11szsVqJ/lScWs0ek6xLIYkFlt2xA4WyfoHoMuPPskhmnc8+BhIFQcinLjSdNdaPLcgj0C1//tyF4optOvf4pswTSWcng/NDBJJX3tzCC2wWd8RqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbmZ5G9F; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso64685475e9.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764691695; x=1765296495; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8taEGCmJMa0QdyAqmJiHyi9j2hnnWICf9uWNlE276Ag=;
        b=IbmZ5G9FfNxl2/BwbXzWr42hLowUspd+UojzRsZh2mYAMd0nRtFeAwJBv2p44ufVh+
         tKd3V1/xgF8qQFBYwtLF0b2xeTQLThMRKHHRk6BQuN09IeQHgWpN2JVB1VSz94BGs/N0
         Behry0u05+HAxKU7RKwTgVv/5ymSC7vN7VkzweKkICXzVO85aOmyNDY/LkCaWuqMEIcK
         cQzW6mgP9bj9QJOdN31hBbAq/celLpzFrb91FI/6jwYukhneWqZXHPg+aN2eQE2SWZ8j
         yDt2F1B4eL7jdis8dHVKWjNb6tY/n9oAeeVtt4P/ENI9C9gGGWBLCGgdYniVTjhIyuN+
         QgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691695; x=1765296495;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8taEGCmJMa0QdyAqmJiHyi9j2hnnWICf9uWNlE276Ag=;
        b=eCloRdv7sLEQFwBSdIZBvzINifGdyqeVO40Es7UKOsDA8honA4LL8u+ptV8svuOwxn
         lO5YHrHWQkCZtSCTYhIADtXWnRjn7Bi5/Nvy1RtRzcuuXlF4d6K71Ns+85APCNrsME6m
         R/7Hlx1V9REx6+ba6SaogNuamlkvvElVya5E5UTFn0Rc0i+eukewmSpMhUCWVbe3bHPR
         EZtMXbcpiEXMl519tcILIFAgOFIQVPnbi6kmigNrIifY+31V8prbji9ngD/WzxK+P5Ej
         2iioHvcbQKBekNu9E70k3Ex5hdxOdPXLziMXUZ0IfrR6kv/yQCN6UBt1elAQwZ7afhMz
         4/2w==
X-Forwarded-Encrypted: i=1; AJvYcCWSOkGyeFvzfHDiewYid/kvdJlN2QqPvA/y7c0vZP5aNzJ+mvwIMxO+ggyFGNlBaj+ikuUsbeuMifk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXMacH0ug9gKuaDbW+2enw59sCiEMNFjCy7NnKOJyUrDx5Zso
	xu25eoSHZ8Hn+MLJTM28E9WjMg+SuMj1avHduQYB02tZ8nYmEOkSbmAg
X-Gm-Gg: ASbGncuofJpNv+ee4i5I4qvz7mon+rmxlcL1Zdl7Z/ktWeWQyhAZt22IJX6I7sNemeK
	lBCHv9j+9cbdKawZ0Xp6Jqi/nWytr+0I8o/jRM/DmXWhkqX+uOJbyDNdyFAx2PtvUwgQcNC6QRL
	4Wq744UeHzGu3aMyFlhA6yM3CNTTroKdzIS3wtdKASwzL0+Sx3efR932ch5ov6zNSNjrz26Pb/3
	3tV5FzSLjfTg383JCk6hDTHP6TIWAAyFC94Uj03XSjHJin9KyZWYU6MGB5lSrNGM7kxHLyqsAgc
	ZcFzXxdl80noXkWeJh5ZgF6pfdqc1SlDsjpbkwq1L7ngfszgDI/wxQfwdNxSGHsiOA0y/nmj+a8
	0M7xTWTrA7IwepVeFK7Z1pn35M334UARpvIFVjc84EPacHjeiEfYpL2eWsytYuUIu7cqkKMb2zC
	otzHza0lDPpyVMfchJRew=
X-Google-Smtp-Source: AGHT+IHN8MLUgVqG1TZJOjfcwHO3vzVTApj51Da/zxDzFVWxbtRl2/o/4nKL8gjUmVEELWg/xEjhFQ==
X-Received: by 2002:a05:600c:4f50:b0:477:ae31:1311 with SMTP id 5b1f17b1804b1-4792a47aadfmr1656855e9.13.1764691695014;
        Tue, 02 Dec 2025 08:08:15 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm32812818f8f.29.2025.12.02.08.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 08:08:14 -0800 (PST)
Message-ID: <2ccd698bb58f36fc1d25c36c43e20a6b689cdf5c.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Jonathan
 Cameron	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko	 <andy@kernel.org>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 02 Dec 2025 16:08:54 +0000
In-Reply-To: <c1cce165-0c34-4277-89b4-b0117ebb4bba@vaisala.com>
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
	 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
	 <aS7zf3ZGVEdTrNvF@smile.fi.intel.com>
	 <c1cce165-0c34-4277-89b4-b0117ebb4bba@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-02 at 17:01 +0200, Tomas Melin wrote:
>=20
>=20
> On 02/12/2025 16:11, Andy Shevchenko wrote:
> > On Tue, Dec 02, 2025 at 12:53:09PM +0000, Tomas Melin wrote:
> > > Support configuring output calibration value. Among the devices
> > > currently supported by this driver, this setting is specific to
> > > ad9434. The offset can be used to calibrate the output against
> > > a known input. The register is called offset, but the procedure
> > > is best mapped internally with calibbias operation.
> >=20
> > ...
> >=20
> > > =C2=A0static const struct iio_chan_spec ad9434_channels[] =3D {
> > > -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
> > > +	{
> > > +		.type =3D IIO_VOLTAGE,
> > > +		.indexed =3D 1,
> > > +		.channel =3D 0,
> > > +		.info_mask_shared_by_type =3D
> > > +		BIT(IIO_CHAN_INFO_SCALE) |
> > > +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > +		BIT(IIO_CHAN_INFO_CALIBBIAS),
> >=20
> > Wrong indentation.
>=20
> Can you please provide example of your preferred indentation for this
> particular case? This is used in several places around the code and
> seemed like one of the more readable.
>=20
> >=20
> > > +		.info_mask_shared_by_type_available =3D
> > > +		BIT(IIO_CHAN_INFO_SCALE) |
> > > +		BIT(IIO_CHAN_INFO_CALIBBIAS),
> >=20
> > Ditto.
> >=20
> > > +		.scan_index =3D 0,
> > > +		.scan_type =3D {
> > > +			.sign =3D 's',
> > > +			.realbits =3D 12,
> > > +			.storagebits =3D 16,
> > > +		},
> > > +	},
> > > =C2=A0};
> >=20
> > I'm not sure about macro-less approach here, I think that we want more
> > consistency and hence before doing this change probably we want to clea=
n up
> > the existing macro, then split it to two, and add another one here base=
d on
> > the low-level, which was split in the previous clean up.
>=20
> As mentioned, this is only needed for a single channel, and since it is
> different than the other, it needs to be separated. Do You think we
> actually need another macro for this?
>=20
> >=20
> > ...
> >=20
> > > +	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
> > > +				AN877_ADC_TRANSFER_SYNC);
> >=20
> > I would make it one line, despite on being 85 characters long.
> > But it's up to you and maintainers.
> I would like to not fight against checkpatch here.
>=20
> >=20

AFAIK, Jonathan policy is that 80 column limit is still the preferred limit=
 unless readability is
hurt. So I would say the line break here is up to the IIO policy.

- Nuno S=C3=A1


