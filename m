Return-Path: <linux-iio+bounces-24810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56601BC09D9
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BDFA4ECA9A
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E3C2D3756;
	Tue,  7 Oct 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmDZtLXV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF72D29DB
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825493; cv=none; b=p219ZjxQ7dUzMMESGOADSdwtLjbrj7I7xOfhZrr4VY218X76422VX8CRZuh2qCZj2GYtf4KMO6L5OP5cwrq1/N6aKIJGBLyxmV/dijSJhYptwBmVahyT8sZCT+yK6z2hx94Tdv0KeSo69rr90Iay8vThZ/YBBwXBUxSRWOgD4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825493; c=relaxed/simple;
	bh=euAo5I637FVd5Ftucqb1bs2y+kbxAcaoAjiv7WM2hgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j2mktv4KBvPeWy14Ta+qrE5E5Aph7Ls4akFNOTi++FS6ep+8wsblWaNng4wbO5a29Y9viOhl3krv2PZw/k/DRkbtedq1Cw/CfNvx7iOwLzr8tsHYQdiBRHA+Np1xgvhM9bT7nSJ1WbQroBhFp63pLo0NKFc3kWa9baA64ecd5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmDZtLXV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so36036345e9.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Oct 2025 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759825489; x=1760430289; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=euAo5I637FVd5Ftucqb1bs2y+kbxAcaoAjiv7WM2hgs=;
        b=YmDZtLXVKI/kF/alRh0blc1jTRKd2lEeRfRZ1aAls+u+OuY6ctd4JIjm/pjJtlKdUJ
         RgVDnMOK21rxcqA+3J1Yf7tt1HyP9uPlxx/cmt1V2QHIR5WRmlKyXOYea47onqrguRCx
         ichDYMt3xT3sJH0tnRy4UwiC4AXvysC60QFVbi8KBrsWIilU48IooAwGEpgaqPnSm7FL
         jXtnJA2lR8iy8PGVR8PCWWlpV7HFUwxpBsZeSyy9bNmnSDxRtmdJt+VD21ijiw45p2L9
         I9OuFkbBoJUWTceJSGA8HpgbIIh9qNWFCHC9cCzEIlE1C+7vnaBNQtRYHoc7iWfGpPn9
         VI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759825489; x=1760430289;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euAo5I637FVd5Ftucqb1bs2y+kbxAcaoAjiv7WM2hgs=;
        b=uZM4yyOWr72nQrwDASDX3gHsisruRa/q0k1tpFTVKHUessx5jSDWJ/1fSpXe0qtwQG
         TFtVwDqqlII3P6yRBEOelLow+QpoO9ScPLCZeNUp20f/Zb/WUXNK7+8IXXdpAqlAOdU8
         vjRWjFrg5TQcIdjVrca6GV5O+IxQL+1dX/zQEvRlCWpjHDwkCfeFxeDfYeZMznB0kJ4a
         fJ6uXPnkqaWNo1N46DwnyquQIj7Q3tZCkJxaLPHbBoG82uCM3PrVUVYLv8CQG6UzXIkc
         qgH8Z6dNoBq3evX4OimdM7YSWD1VKOOakPdFGW8baUrzELwT3vmTtKUkVa0uyc/8mCME
         bwMw==
X-Forwarded-Encrypted: i=1; AJvYcCUsA27FnQNvD6XMyfMiYFrI1ZwiC5TU7SXcj0RE/nYXL1KnAMxjJFPKUrOpvMtF1ehiGkK3kfFwF2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxnHmnlItEWRnX1ESFTYX2ghXwUlM6x1SD7TWbNPL0ZGP/4MY
	WbRO/GuYiN09u9fIOf34VRlT+pndGd+ONbHZhIku+OQyVvZvmo+7HpqjAeZF8g==
X-Gm-Gg: ASbGncslg4vxxwyvl9jLr52vb2OzwSCXaDK2FR0tTCltO8sVsoTIrxJpmnUi96qCsFj
	H6azhxJ6Z/xGBrdKZ6AM3dCuR4L/fUtSfBS90mRQ6FVZXeIFr9Vh+c7dG3e6ky7J+ijop1WVPFy
	T8zRWTkg/d+sx0mzTy3558AflSWre4L7XqulxRxH6smKAfR43Z+SzNqFtmr2190Q+L0FpxGGaWA
	O+03Qs98vyeyw4bDN1UV7t+DivhKp+oOdjjl1x/77ZMsMsQlDMpxRO8FlzUsQVbK3F3f0RU4rle
	OXjpO20NAkCYyIO9uBA09UV7gyzA6+lub0pH76bfFA9WdnV11EUmJS6hzAtu2fkXo4UL1mQAQXJ
	ao687vfhToP9P+CbFZaVDfjPZHIQjxhAENMvD6JegdhkciNHtGL/hkKfX2A2qfJfIGw==
X-Google-Smtp-Source: AGHT+IHGLovf2MF4ILYdr0Nh40RoWtLVur07F9j/zPPAlfvxgpkHmTgbxJ56E/MDsk1AGto2lqsBBg==
X-Received: by 2002:a05:600c:3b0f:b0:46e:59dd:1b4d with SMTP id 5b1f17b1804b1-46e7110a268mr138034555e9.16.1759825489086;
        Tue, 07 Oct 2025 01:24:49 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72359e0asm203264555e9.12.2025.10.07.01.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:24:48 -0700 (PDT)
Message-ID: <b49f3216d1ba1925f19d78b5f6c38126b7473d76.camel@gmail.com>
Subject: Re: [PATCH v2 0/3] iio: buffer: Fix DMABUF mapping in some systems
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	stable@vger.kernel.org
Date: Tue, 07 Oct 2025 09:25:19 +0100
In-Reply-To: <118c3551-df86-4c23-b385-6f75d9bd5388@baylibre.com>
References: 
	<20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
	 <7eeb3072-b54e-46c7-9fb2-c4d2422188d8@baylibre.com>
	 <2fe00df37ad75591e437813f1c618c3decbdf2cb.camel@gmail.com>
	 <118c3551-df86-4c23-b385-6f75d9bd5388@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 11:44 -0500, David Lechner wrote:
> On 10/6/25 11:25 AM, Nuno S=C3=A1 wrote:
> > On Mon, 2025-10-06 at 11:18 -0500, David Lechner wrote:
> > > On 10/6/25 11:06 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > > > This series fixes an issue with DMABUF support in the IIO subsystem
> > > > where
> > > > the wrong DMA device could be used for buffer mapping operations. T=
his
> > > > becomes critical on systems like Xilinx/AMD ZynqMP Ultrascale where
> > > > memory
> > > > can be mapped above the 32-bit address range.
> > > >=20
> > > > Problem:
> > > > --------
> > > > The current IIO DMABUF implementation assumes it can use the parent
> > > > device
> > > > of the IIO device for DMA operations. However, this device may not =
have
> > > > the appropriate DMA mask configuration for accessing high memory
> > > > addresses.
> > > > On systems where memory is mapped above 32-bits, this leads to the =
use
> > > > of
> > > > bounce buffers through swiotlb, significantly impacting performance=
.
> > > >=20
> > > > Solution:
> > > > ---------
> > > > This series introduces a new .get_dma_dev() callback in the buffer
> > > > access
> > > > functions that allows buffer implementations to specify the correct=
 DMA
> > > > device that should be used for DMABUF operations. The DMA buffer
> > > > infrastructure implements this callback to return the device that
> > > > actually
> > > > owns the DMA channel, ensuring proper memory mapping without bounce
> > > > buffers.
> > > >=20
> > > > Changes:
> > > > --------
> > > > 1. Add .get_dma_dev() callback to iio_buffer_access_funcs and updat=
e
> > > > core
> > > > =C2=A0=C2=A0 DMABUF code to use it when available
> > > > 2. Implement the callback in the DMA buffer infrastructure
> > > > 3. Wire up the callback in the dmaengine buffer implementation
> > > >=20
> > > > This ensures that DMABUF operations use the device with the correct=
 DMA
> > > > configuration, eliminating unnecessary bounce buffer usage and impr=
oving
> > > > performance on high-memory systems.
> > > >=20
> > > > (AI generated cover. I would not be this formal but I guess is not
> > > > that bad :))
> > > >=20
> > > > ---
> > > > Changes in v2:
> > > > - Dropped Fixes tags on the first two patches and Cc stable them in=
stead
> > > > =C2=A0 (as prerequisites for the third patch).=20
> > > > - Link to v1:
> > > > https://lore.kernel.org/r/20251002-fix-iio-dmabuf-get-dma-device-v1=
-0-c1c9945029d0@analog.com
> > >=20
> > > Did you not care for my other suggestions in v1?
> >=20
> > Completely missed them, sorry! I kind of stop reading in the stable stu=
ff.
> > I'm
> > ok with the helper function. For the clarification I feel it's redundan=
t.
> > The
>=20
> I was thinking extra clarification could be helpful for someone new to th=
e IIO
> subsystem. But it would be quite rare to add a new buffer implementation
> anyway.
> So probably not too many people would actually ever read it. :-)

I mean, it does not harm. If you want to add it, I'll hack it (as I feel it
should be a separate patch also covering the other .ops related to DMA buff=
ers).

>=20
> > field is called .get_dma_dev() and the description "called to get the D=
MA
> > channel associated with this buffer" already implies is for DMA buffer.=
 Same
> > as
> > ops like .enqueue_dmabuf().
> >=20
> > - Nuno S=C3=A1
>=20
> I don't feel too strongly about either change, so either way,
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>=20

Thx!

- Nuno S=C3=A1

