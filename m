Return-Path: <linux-iio+bounces-5148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279358CA845
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 08:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C782827C5
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89CC47A7C;
	Tue, 21 May 2024 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4Dl3Diw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313EE4EB24;
	Tue, 21 May 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274694; cv=none; b=WaSCXrgyuFpz7wna0j7vRX2TbGkN18wS21Iyk4Ega81Sx+/aXYTfMvSNcjoY+qz5j3CsHMkaOR7r+jYCdALFSKFJjJ3lC5pwL+4+ZBbqd+7e5DA73yzs6mMZBA8gvn+ugcDXFzWsSotN0b9MpSQYbyKuPbd1h+AvgKm/iby1N60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274694; c=relaxed/simple;
	bh=S1L5vmGoC0m8fnlP6zf0XqLv3lg1zpGo7r8IcCTbE6U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RVEdWX6Ta7H9FC8H4tD6CNAN6ZiXL2FAVeL5KC6k3Gztj1XKj6/TRqEG7rICRhZerm7+T1gCvAhvsQSI976cLDrcTJPRANEEDJMVDi0aKZ10wQl3CAzlqxO0NEN+Wrilp7fM3V/mx/r7bjyJzmb60en3UMF5RTdFjO4PrOu5JDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4Dl3Diw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59cf8140d0so658441666b.3;
        Mon, 20 May 2024 23:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716274691; x=1716879491; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WUq+MD3cDlgv9ew/G/k6DDudnFMyeCNHou9Fxg3fOAI=;
        b=d4Dl3DiwDjWZ/u8F9UecEp1RIwH9R7rzOC79wGr9fsiq8+QMIynU0sHsU6bjxFl8An
         l3FzDX71kbbxdiIwOOQ1NIO7WJQb2MghqKE8+d9pRN/porWm0ZAv9Pu5ZAEjUkAYCdMk
         fnAygq0faLRTtczoeY6ZxJze+BksfI65IxIdxGFx9wYxlpW82hxyWyCjepnNio+C5JQu
         Bkazf+jAjXoZyCMjG9cEZIimv+iV+DIPHcEcT3QMcnBJYcP6es7OG/wz8cxAkBRfvOAP
         vJIAzwc7VbvoHP6kxb3eZHXS+5VpaUiYNiXFe1CqSediYkWEh1KwhNBv6BKw9FXJnEn3
         /PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716274691; x=1716879491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUq+MD3cDlgv9ew/G/k6DDudnFMyeCNHou9Fxg3fOAI=;
        b=OUbDMTj4WdX1sPfROUojgzs6m9SgtZ7cK3DzvjukzDkuIaGHxZGwTri4xeW2B6Xf/2
         9oQWReJ1paaZDotA2W6EhH3Hu5v0azhb+N2BikWKS0ZPH5nKI4uvN7gOC1703DnJ4ZnC
         xQqmcvVE6nSOiRM8lgaOSSAvqeqJ9VL5mZcrxrPiEG0nvlxfbSKhjJyCGe0Oq6DSR0eK
         YUHHEn78ku8MfbC7ZN2c9NdgveBKmzAoFZd0J1CNaFbtcVgFFM4eUNVqGy4YmWySfBpE
         2Syl/Dyf89O/salZchdesfueB5oT6ahdPm5DbWheFUwtHaju4xJWDU60ce4JjdtHS43T
         Ds/A==
X-Forwarded-Encrypted: i=1; AJvYcCXqGmgpQ2KK7WguFpoLZB+yB6ZqXxj+ImJsgJIXyjDvvTaNpSjo2E7sly4AzEU7u7cu/7YkIN+v+pYopWBdGb72IdFuZHjolFH3ICmMrWxv6g+gNivyz84T72eC2kb2tmsaCIneBQ==
X-Gm-Message-State: AOJu0YwkyoEKJt2LqH/eT3aoYO+duLK1qjKCKMmRqZ2NuxeX/Y9Ma3hQ
	U8ACYgmEUX8aFmnTqRBqF+4oprk+ckew3s90Sx2L4l323GzpZrk8G9V0aFbhIj4=
X-Google-Smtp-Source: AGHT+IGLsXZvaNr+YSms8SZ+29sSYLe8eRuQc58MenAVXVrTTR+c0UdLaIjSH88FAy3dKmfcfZAiEA==
X-Received: by 2002:a17:906:3a8d:b0:a59:ad2b:ec95 with SMTP id a640c23a62f3a-a5a2d67e2c0mr1805961166b.67.1716274691247;
        Mon, 20 May 2024 23:58:11 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b177f0sm1561543466b.209.2024.05.20.23.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 23:58:10 -0700 (PDT)
Message-ID: <1b93cc45944c7d1491184adafb55e0c99675ff32.camel@gmail.com>
Subject: Re: [PATCH v3 9/9] drivers: iio: imu: Add support for adis1657x
 family
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Ramona Gradinariu
	 <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Date: Tue, 21 May 2024 09:01:54 +0200
In-Reply-To: <20240519195707.71163f84@jic23-huawei>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
	 <20240517074750.87376-10-ramona.bolboaca13@gmail.com>
	 <20240519195707.71163f84@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-05-19 at 19:57 +0100, Jonathan Cameron wrote:
> On Fri, 17 May 2024 10:47:50 +0300
> Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
>=20
> > Add support for ADIS1657X family devices in already exiting ADIS16475
> > driver.
> >=20
> > Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
>=20
> Whilst it's not necessarily vital to support, it I'm curious about
> what happens to the hardware timestamp? I thought we had one driver
> still doing hardware timestamps directly to the buffer, but I can't
> find it so I guess we now deal with alignment in the few devices with
> this support.=C2=A0 The st_lsm6dsx has this sort of combining of local
> and fifo timestamps for example.
>=20
> As it stands I think you push the same timestamp for all scans read
> from the fifo on a particular watermark interrupt?=C2=A0 That isn't
> ideal given we should definitely be able to do better than that.
>=20
> > +
> > +static const struct iio_dev_attr *adis16475_fifo_attributes[] =3D {
> > +	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
> > +	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
> > +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> > +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> The autobuilder caught this one.=C2=A0 Drop the dev_attr.attr.
>=20
> > +	NULL
> > +};
> > +
>=20
> > +
> > +static const struct iio_buffer_setup_ops adis16475_buffer_ops =3D {
> > +	.postenable =3D adis16475_buffer_postenable,
> > +	.postdisable =3D adis16475_buffer_postdisable,
> > +};
> > +
> > +static int adis16475_set_watermark(struct iio_dev *indio_dev, unsigned=
 int
> > val)
> > +{
> > +	struct adis16475 *st=C2=A0 =3D iio_priv(indio_dev);
> > +	int ret;
> > +	u16 wm_lvl;
> > +
> > +	adis_dev_lock(&st->adis);
>=20
> As a follow up perhaps consider defining magic to use guard() for these a=
s
> there are
> enough users that will be simplified to make it worth the effort.=09
>=20

Already on my queue but if Ramona wants to step in, good. I already have pl=
enty
to do :)

- Nuno S=C3=A1
>=20


