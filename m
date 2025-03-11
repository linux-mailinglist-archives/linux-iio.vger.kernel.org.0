Return-Path: <linux-iio+bounces-16723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6490AA5B933
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 07:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3F1170679
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1876D1EEA23;
	Tue, 11 Mar 2025 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GHzioj3D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F971EB19F
	for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674427; cv=none; b=VxzbZVYYJ20u5L8usB4opd+fkH86R3xP/Cn1cGVphYR/Y0MFNWB/zFzNr6NgS+jBm2gUycPVWuzeWuVEia2RK9lbZPu0m79s9p3w7iLTrCCls1/hzniI42/glTgmlijr8ZztDJOpxZRDZX9lGohk9Ve7a2D7sIpDM6lJhtS8Ol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674427; c=relaxed/simple;
	bh=JKsSL0u4YPjHyf+BYF31K9+WAPulKKTFywTLuMNjNt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOP4bTIHbDw3xgxr4Mv01k1DmgIcwghUhlLRUsKa0vBa9KXmucS7b3iRzFb/ztT1B1vtwZn6y2tlRahT0w6CTdjMIEmjBIzsbCydNTTQH75dhcV1dpFAVRCclso5dZnT85kYajGMqVovuc0MM1kLvf0DNNhUDM1asMbPeZ0AFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GHzioj3D; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe574976so8265545e9.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 23:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741674422; x=1742279222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuOFf9HoIeyoNdzWGpyEjnbtc53ZPD2jJIIiEozQVbU=;
        b=GHzioj3DfiLdp962R0cg11mSmUU63MMjHjBe9pOPDhpQvuMokxMORDXNZm/atDaYoi
         psGkAOI//A56EWssWHzpgWXVQj1FU6j+qU195o+Nzb7sKxAj/64LzeN/A6v6DzNGisQT
         TeK6V2gTSDlDJM1JgQTKEAmphb4s451s+Vh3erRDFhNd7VcJhFvPHOeqivUaDkML27Tv
         kq/2j30Clr3lNDhvfNtVMmSsRtituqmOABOuGWLlamtFS+R2WWSBnXDTmOA2fkfxrwSz
         RgBxO5hE7vpCZFBbyzmJBUvi3URZjZzcj55Ra7qBB9DWmM1bicA6A+syAbneIioIFviI
         JpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741674422; x=1742279222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuOFf9HoIeyoNdzWGpyEjnbtc53ZPD2jJIIiEozQVbU=;
        b=v5zNxuYaamKFNyAgdrCSGJ2NuC1s43fyOAJWSBaqE64ScXMyuKEOtFi2ukFyoZzC9m
         iW4ok+AkCm6VvEmqdTVRHMqQc2OqcH2IJk4cIJT79/Npf2YOWnWLeI84xWD1GLfPcLHx
         sc8ajYPcnLL5SOho1ohfM59IzC08XAmB4Lp12qFNClTWSsYZcx+LqPUL8dLJFkgySZ3F
         S2IA2WHhBroKz1yYYoFWpCRCh4sijMxi5SU0lM11qgB7ZxkA3q4f4db7VqGecc5XDySI
         kQvk0dAIc7PNVSErd1v8GIMeLJeuqoW3dgEeLERysMavjqpcgXG1aMOcawJWqgwW08Hx
         yRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1TdHS6Cp9Kj+nuSqG43nl2eQBSaPdppRnLIWebbtyQ3sbCAjxU/Ak9PuEtewCtqSiOUvXbT2KDV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7MVaTOijSOMjpD1JQjgJiZ6qU9wPyGkkIuHM1aNA7EGrabTD
	4rxZ70tXH5UskcPIEUNiKxLgBOKhf3D12BcoE0w9JP6eyvYSaHEbxDmCJGHWTzo=
X-Gm-Gg: ASbGncsdwh1B9gf0LIFXGpB8852qtkZgpGWj2wVZBZcpHTFNyBZB78bcDwS9gOWMHcH
	SCeN7Tt2qImWSHZdHHouFQv9QEGtQKE25mXkE+/tvbVjNT5KqdaM4+uIKvfoVSyackkFe2vYWV6
	Ztd+AEPY+2G0jrzsUFQTonjandt00hXGsptFXOyh7osiCtssZI8rzoainREx8WWhltDY7oDgpPk
	PSk90qMsOsp5bEByAf5+dq76K8QVJEFc3U9kYBkXT9xyKB2ufJx7CUG1mtgfHBPiFKXNQbI5Knh
	4gc9wj4ZuqZBhbV3XdDXsMMB3/8r0/uDBiI03oJwC7BwLzmVS1H5ZmdeilK0Oqf1VAeDM2G/DQX
	ttDMUEsKi
X-Google-Smtp-Source: AGHT+IGJCKTIXUq41N/f5zPpUWFIGR/W8B5MRTPF/3AmIhFmDDE4ZQ976M6o2Dznx2Uw8tr+EA8N1Q==
X-Received: by 2002:a05:6000:1a8f:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-39263b00732mr2820277f8f.9.1741674422470;
        Mon, 10 Mar 2025 23:27:02 -0700 (PDT)
Received: from dfj (host-82-56-170-15.retail.telecomitalia.it. [82.56.170.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f10sm17246064f8f.65.2025.03.10.23.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 23:27:01 -0700 (PDT)
Date: Tue, 11 Mar 2025 07:25:45 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: ad7380: add SPI offload support
Message-ID: <7abliglzeag4il4dhzuzlvimvfeveqefowq3p2rawjvdpjfgpe@dxasa2dkdksi>
References: <20250310-wip-bl-spi-offload-ad7380-v4-0-b184b37b7c72@baylibre.com>
 <20250310201311.04b56522@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310201311.04b56522@jic23-huawei>

Thanks a lot.

regards,
angelo

On 10.03.2025 20:13, Jonathan Cameron wrote:
> On Mon, 10 Mar 2025 18:39:51 +0100
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > Add SPI offload support for the ad7380 ADC.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> I've applied this to the togreg branch of iio.git and pushed
> out as testing for 0-day to take a very brief look.
> 
> This might well be the last series to make it this cycle depending
> on how busy the rest of my week ends up.
> 
> Jonathan
> 
> > ---
> > Changes in v2:
> > - fix return value on offload probe,
> > - add documentation patch 2/2.
> > 
> > Changes in v3:
> > - fix tabs erroneously added,
> > - fix documentation syntax error,
> > - add a note for the 4 channels ADC variants.
> > - Link to v2: https://lore.kernel.org/r/20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com
> > 
> > Changes in v4:
> > - add offload support to adaq4381-4.
> > - Link to v3: https://lore.kernel.org/r/20250304-wip-bl-spi-offload-ad7380-v3-0-2d830f863bd1@baylibre.com
> > 
> > ---
> > Angelo Dureghello (2):
> >       iio: ad7380: add support for SPI offload
> >       doc: iio: ad7380: describe offload support
> > 
> >  Documentation/iio/ad7380.rst |  18 ++
> >  drivers/iio/adc/Kconfig      |   2 +
> >  drivers/iio/adc/ad7380.c     | 511 ++++++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 495 insertions(+), 36 deletions(-)
> > ---
> > base-commit: 73b788d05b5bd82c40193165583a9dcad2d8410e
> > change-id: 20250220-wip-bl-spi-offload-ad7380-6f1c27cd815d
> > 
> > Best regards,
> 

