Return-Path: <linux-iio+bounces-19728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55148ABD348
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 11:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2A9174108
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C65265CAC;
	Tue, 20 May 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwM4aFvS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559B25DCF6;
	Tue, 20 May 2025 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733057; cv=none; b=UmvYVXsBrLXuWcB6sg9GzuN661YYT0En0Ce9wsAxl3gvbuVwGGN94Xxyrr86gFIIkj530mG4DWFsbH8KCkfqwd9yfQLrNE/Jsrq2y1I0w0LgNk+Tyn9ms6yOaLXeQlZkuCwyHq55CLdaJF4PY7+Lb4cGxfuLPPh0GHXh8TLdORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733057; c=relaxed/simple;
	bh=v2yvuT3IUZLqGuCU45D0YyytrpZADw5m5hjO08+O0CU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XKojXEz+8gbmoMcAbz9US5kzn2pOTweVQsKnDhEQ9CjiDN5p/5ZzJwKdXJM9Xl8odPvO9Jhm7PAEzjZAa8CuUmuVnNtk66ol2j3xY7w/Vvm4wSG8KIGyP9WSzI9Ltnu8WS/aCmrSkEgzTB9+/qvXB+3z5BV7++gMWHiFvtBCZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwM4aFvS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso67063665e9.2;
        Tue, 20 May 2025 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747733054; x=1748337854; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRtkgOMXEMbTh1Qbv3hnc9A+4hrEhmaNwm9gfsq0Nhc=;
        b=dwM4aFvSlLroR5SfK2qNEwT0XZzhUB/RHI6DLThQtUGYWkNA6TjerC9zu59ii94d14
         b1kWjViW6ftiRiLSOE3AKMU5Vln2H4sZLeNQaR1uULQ3n++eR91KHmEPvLykB488zx8Y
         aww0lorTd66VE7SHmbw/vCj1Fgq4forvlEp9R/8C1QJiGJndOFjskKwe17LV33n8S1RF
         l0ZM7/GA7be1lXfkD7sY0aQnSSGZI3WXOg3Lzygsg6xWo03A952EWO/aVZ8EpsMaKRTI
         ddnk8ZQ8bnNcdg0bAeGmqoPjsNOSpAr943+pxW3hX/RMxBTUavWeu+YO8AyO5rokWIs7
         yTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747733054; x=1748337854;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nRtkgOMXEMbTh1Qbv3hnc9A+4hrEhmaNwm9gfsq0Nhc=;
        b=eM8q9H4kI2O54zuP391+NpwEuikdZUgJJAvAV79+ZSKRFBcnkuuV6tzE8j7EBy/z8P
         yXuLeAXq5uXILmuk8N0L83Dneme8kXKreaMZlYLDrFg99Y+O1bAGOcdmbMiXPOhxbSVE
         qt6U6XsHs3XpNKK06BrsQBt/gRuz8tgHEdgTaEG9m5I/3/Q2pV5v3civlfBh9pMz1byR
         ZwLNtYqKrfgFr0WxJKka1+PZNBaqny9W/+QwEtl9x7tQak8XeZYsi7PXV0heAed+CZHQ
         Tb88MWP3VYjGkOXXe/Ez2g0FN3te0mhKVZn3ceEv4gzYkZNEoMI7+4iOs9bmXK2mGnwS
         6HMg==
X-Forwarded-Encrypted: i=1; AJvYcCU0y7fyF8qczPtxGtiHgjemguIBA7hYq2a7T+GcwFAASC8Tl/GnJ0U5H8cKAqGKP6R7pXwu2Ty8yltI@vger.kernel.org, AJvYcCV2wzORkpt02YvUfAP70MpWLHxCDKiFJPKnmrDiVp3p59/a6RaMqKWmH5sAnmUHwI9lVuZRYvRs7zlJ@vger.kernel.org, AJvYcCW/9Nvw+PS84F6wIDz9fjqSBHafQxBPp5bCENigEaoyTzfe4fvkhcthXydhxxX7kaCWudTgVOaXRH2RQRtV@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgmP0GP7dK/+ay9e25ajX1wm/4uJVpENBaAGgVCHcGDl+JenN
	qudWvm4aUKsMX7eyUqM+2cjz6Mq3GiDg+0FkbSOFVJruq+lToQ7GlMsd7aPXckf0oAU=
X-Gm-Gg: ASbGncvE3pmFU41l2YU1lZdII1t3dTcStxTuQF90xPe/vx8O6OqiYDgW6GcM1901rkP
	Y0nOO7iPOvMcGJ130ONwhpBo4W8982YiUj8w3AT+Z/0ENLA9TuSOKUG+ZNY57rg9svqOK7BmNme
	srRQadL0YTIJsEFk9dJKKaYqEe6h9XXck0lUC8ehoc7ayMFUcehqbdHIeDDxy2XaX5Dy7r7CW/F
	76aKwY+pDjmXR57PXCd/6HJ/X1j7O8nWWzCVu5t3bIXH2yFe1t3f77LMvbhmV8LZUoptXp2Iyfr
	o3jAevcVKo7JsZ367mxVttwlwbnyfFmsDl+bFoc4qo3+HUeAWuw=
X-Google-Smtp-Source: AGHT+IHlQTLxn5Auo2aEn9aaoeXfFsRnYyucKhwri9+rfvgIV0WMVOSdEVDldv8Umqke9pagBmbLxQ==
X-Received: by 2002:a05:6000:401f:b0:3a1:f70c:19bc with SMTP id ffacd0b85a97d-3a35c84f1dbmr15853441f8f.48.1747733054383;
        Tue, 20 May 2025 02:24:14 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef035csm23055215e9.11.2025.05.20.02.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:24:13 -0700 (PDT)
Message-ID: <e9799164b92a5b2c270cd9a9d2af7eddd7ede83d.camel@gmail.com>
Subject: Re: [PATCH v6 09/10] iio: adc: ad4080: add driver support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, jic23@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 	linux-kernel@vger.kernel.org
Date: Tue, 20 May 2025 10:24:16 +0100
In-Reply-To: <9f5dcb2d-3fa9-4e39-9cf9-c5a23847224a@baylibre.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
	 <20250516082630.8236-10-antoniu.miclaus@analog.com>
	 <9f5dcb2d-3fa9-4e39-9cf9-c5a23847224a@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-19 at 10:51 -0500, David Lechner wrote:
> On 5/16/25 3:26 AM, Antoniu Miclaus wrote:
> > Add support for AD4080 high-speed, low noise, low distortion,
> > 20-bit, Easy Drive, successive approximation register (SAR)
> > analog-to-digital converter (ADC).
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
>=20
>=20
> ...
>=20
> > +static int ad4080_properties_parse(struct ad4080_state *st)
> > +{
> > +	struct device *dev =3D regmap_get_device(st->regmap);
> > +
> > +	st->lvds_cnv_en =3D device_property_read_bool(dev, "adi,lvds-cnv-
> > enable");
> > +
> > +	st->num_lanes =3D 1;
> > +	device_property_read_u32(dev, "adi,num-lanes", &st->num_lanes);
> > +	if (!st->num_lanes)
>=20
> Error checking seems not strict enough. Allowed values are only 1 and 2.

I also find it more readable to check the return value and only validate wh=
en
needed. But this is pretty much a nit and personal taste.

Regarding your point, agree that the check should be better. Maybe Jonathan=
 can
tweak or Antoniu can follow up on this?

- Nuno S=C3=A1

>=20
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid 'adi,num-lanes' value: %u",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 st->num_lanes);
> > +
> > +	return 0;
> > +}
> > +

