Return-Path: <linux-iio+bounces-26376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDB4C7BF18
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 00:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9553A421E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 23:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE63311975;
	Fri, 21 Nov 2025 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mze3Ca/R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9528FFE7
	for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763767702; cv=none; b=dWoEhLbWW3nBS+kFUa7Qb6hhxIoFkKJHTnONRnSnwNDr2Q18z5HANyo1Iv3SV6+nGvOQvi3q+Epvd2E61r7aEraFEKh5i/4kD+GtC64UVRmY0U09R+k0L0ggDUO5ocbC+0DVTODFv/Cjs6QJPPENetRVxFcluaSj+n1QruXn1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763767702; c=relaxed/simple;
	bh=C5xk5Nu5EFld4DJwl1asaNpmcCYJqbKLczamgBNiJ5U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=l7JKDiHFuf070EY+d0lhfO6xvJLb3YJUPLZf7YpsMYnqjgkvSrXSCgoVbgNZmDP90NU6BS4SZug7+Pt62xkMHBiN2+axaIsdVhASnhq2mmItSD7JfhAqcMbsOgCCsiXZTHk5KBCfQQxFozaHuNiQoISJNE0Z7By8kaxgS6DKh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mze3Ca/R; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-55ae07cf627so866534e0c.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 15:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763767693; x=1764372493; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2vmRyY+CPyo6gdzUvKfso20g3IwmE2bzd6yZ/el5t4=;
        b=Mze3Ca/RV1t/Tj+dk8RDZv9ytKnu4xb01iyb+ZjYiYdVG44FdTQ2kh3lbjPOulwlD2
         K5WDfya8PSTEiJ73Gzx9Ws1Xeta7vVqU81xbE6SOsCqNEEnA+ViklOPL6EjGksqZG1ni
         HSSbJB5EY3Tj9NnkC9+9pp8889K3QqSEDyWOYbf9+X0DgrNWjJ/arMyV/6KoZyuR5ziy
         K7ZAFIwwuGFsMFM7raL/Qw6DJx4XXjwBf6NOxcr9z8YxUo1i0z0a2VLm7LeBMzRMNb64
         eujHgiKbNSSdOeF+hdEosl0VtKBdNpB/nzveqnO1ZbeYNUvCemYxQNN2kFtvIF8H0ftO
         BnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763767693; x=1764372493;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W2vmRyY+CPyo6gdzUvKfso20g3IwmE2bzd6yZ/el5t4=;
        b=jy3AsyOPGhHFQ1R4bIz94cc7aMAalmMpz3LSoz8vwmXCnVPQtRJ0Z457NhsmvCvB/q
         un2bP/R5ijJREIZSSyzpfjW32qDMwTLrIKI/Qk7dMPcv4hUUsqvVDnkZg7/2zZisAfi3
         qPF0MOK6VLKu+OkHKFln82FFb3W6le4UfDQheV0xnoPquXv4lV3n36g4XY7kAWPK8KSv
         PKwZoLGIUVBBar0YHYOr3H1PvaVk7Rm53Rm0+E96ix3QbgYoXWN8EGESDvb/+E5JDfRY
         Cqf6gOdvVGEpwgtJoytHY4oE2hs5QWQrmBkK3doMgJP9i34eZzD6wKeUjgDxACC4YAWj
         1P4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNpEeNR7lJKFQxfyFkXUuZESpz4mLoKDV0miMMsXO55qKnsPBe4SqQPsdgDI8eC5Y9TfUsvToY/HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZesA9bbnEswS6MYHGCy85w1Vsxq8yD76RY6AZMm8LtQqtog9
	C7df1GvWc8kVggkJ1mDTVG+Kzi/Bx6JnkiL2+Y1vt9TA/nx1WKhFfCe3
X-Gm-Gg: ASbGncugB9htyuVPRyvIhQbyI7BOnEuSBaplAMl1svZzH/0m/GmfuzNsg1eRwcdwyco
	d0uAPPrf5WKyl4qfsmDN7VeXYvNnsC/j2kOR3D2whj14ei9u7s7nA7b6+FrYtAQt04WsytPyn/L
	Y87MfJYVvHYZsGDiTyH8ZX1gaBbdFP+q1VXl3PkOl1yiHLutwhivTjUw8BBw8gw/zMZp/0B4dfd
	3IyJsyJcwQusI0y9QhLKAJmmfIjAPL4IxmGRujP1Vwr+WEUTcckEJMqUXRIaUaNhXvc8qvS8/J/
	XmDHKQP3q/L49D0S+yAJPvZFExxN3CnkB7mAow3/ZSo34164n2KTaTIQTdG/BUFmO7wpzpXaLzm
	O8P1ejISgKEBWjT4zBZr5iO8r8UmQK8C8Bv7s22f0zaZdN1A5qhdIztxRbynYikuHgRIktsmPMY
	JA/DpOwX5311xYtw==
X-Google-Smtp-Source: AGHT+IGW1BbieHcjel98FU+b4VtP+Iz6SjkaHRfKnGxBEMggGehiG5MLGPtYSLUCYH2iZ+EhpeqLeQ==
X-Received: by 2002:a05:6122:202a:b0:55b:305b:4e3c with SMTP id 71dfb90a1353d-55b8f00fd2cmr1358436e0c.18.1763767693075;
        Fri, 21 Nov 2025 15:28:13 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f60076dsm3160249e0c.3.2025.11.21.15.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 15:28:12 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Nov 2025 18:28:10 -0500
Message-Id: <DEERGRDZ0TM4.NZ6R9JWCSQPL@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/2] iio: Add support for TI ADS1X18 ADCs
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <05fae891-a4e6-439d-97da-6259370f68b5@baylibre.com>
In-Reply-To: <05fae891-a4e6-439d-97da-6259370f68b5@baylibre.com>

Hi David,

On Fri Nov 21, 2025 at 5:32 PM -05, David Lechner wrote:
> On 11/21/25 11:16 AM, Kurt Borja wrote:
>> Hi,
>>=20
>> This series adds a new driver for TI ADS1X18 SPI devices.
>>=20
>> This is my first time contributing to the IIO subsystem and making
>> dt-bindings documentation, so (don't) go easy on me :p.
>
> I actually had these parts on my radar, so happy to help you out.
> Unfortunately, I don't have the hardware for testing though.
>
> The first thing I was going to do was check the existing drivers
> to make sure that there isn't one already that has a compatible
> register layout. I have a feeling we won't find one, but would be
> good to mention that in the cover to justify adding a new driver.

The closest driver I could find was the ti-ads1015 I2C driver. It has
the same register map and similar specs. Although I think we can adapt
it to be "compatible", I chose to do a different driver for a few
reasons:

  - ads1015 and compatible devices have a separate DRDY interrupt line.

  - The ti-ads1015 driver doesn't support the DRDY interrupt (sleeps
    until data is ready and it doesn't have an iio_trigger).

  - To correctly handle the DOUT/DRDY line we need to manually control
    the spi_bus_lock. And we do it differently based on which IIO device
    mode we are operating on, so it would be difficult to stuff this
    logic into regmap_bus callbacks alone.

  - IMO the end result of merging these drivers would be too messy.

This is just my opinion though, so let me know what you think. If do
agree I will add some of this points in the patch changelog!

>
> There are a couple of similar TI ADCs on the mailing list right
> now, but they are IMHO just slightly too different to share a
> driver, but would be good to look at just to make things are
> consistent on a high level.

Yes, the other two TI ADCs, ADS1120 and ADS131M02 are very different
devices.

>
>>=20
>> As explained in Patch 2 changelog, the DRDY interrupt line is shared
>> with the MOSI pin. This awkward quirk is also found on some Analog
>> Devices sigma-delta SPI ADCs, so the interrupt and trigger design is
>> inspired by those.
>
> Yup, that seems to be the best way we know how to handle this.


--=20
 ~ Kurt


