Return-Path: <linux-iio+bounces-15152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4274A2D067
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 23:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF2C7A4DF9
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 22:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B11ADFFB;
	Fri,  7 Feb 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZO/T+vc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094A8479
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967003; cv=none; b=o7Zf5Hz2fBXbcv+S4PazIIQ03O8AT0fI0qzZUmdqoKqIQZsHsBbCp9cn4enQTUFRD8+dkB7LCaTv9V2wIwAfoAirSycVU+Sa5OA9EX2LuvcXkKq0DJMn4r4LaJeclrAryfQmVmwA43cS5MhlQacazmTTJMmscUdZyO6wEDrs7qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967003; c=relaxed/simple;
	bh=ieeFSvfJGF2nQotNpCQPJsYU5mE5JGbkoEhHDdbYRGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQl119qUX/dN6Q2CKT2+qJfQ7vIpsMTutwXpWeQcec8oNVIPRsHHUTqiFzPrsHvAoUuFtk/gV2VkZ4MkxHNqEE/5SwN9jgkENIOT9eZcOoSOBBvHTFMYL/D+nLNgsKckXsjr2Q3Jlxxu02dZHiuzeU5uDV16Du8USitporM11DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZO/T+vc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163dc5155fso53875975ad.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 14:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738967001; x=1739571801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ewOlPH4ZswQ/sFUG7/c1QgVPfeZcoGY22s11VYGQZ8E=;
        b=YZO/T+vcg6YaFi+ittGUOb58ieM9hX111h6/ZjnlXitCbYqg5iQfWgQkjkFiR1MKL6
         57e9M13iMfole/gJ6kCLkKc14IaEiNoBJRAURsEOSPjMreJgz+Re+W282dE2Vn96wxlI
         H997dC5hdaK6rBBjazMMqFsODJLU1DHab2N7rj830Ualr1zmR3NjmFRbSvBpyBvNzplz
         U4rdRVrnHUJoenr2H2NeX9g7yHRG1NW7mvlFFmph23Pah5huqfTDxRs6LwbPaMaJHtq0
         gjnbUqt2yrkD/8DprwwSbsMC5STRc6NPJXWPoadjCv4CN2Rd4x23cTsxC9XX8RUF0YHf
         7b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738967001; x=1739571801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewOlPH4ZswQ/sFUG7/c1QgVPfeZcoGY22s11VYGQZ8E=;
        b=I0YHmQ+3XnH61VJjYevOJzszi82waLe5p+4+RLH8kMfNVsXHsdqWkTGgWj4Dw+utZO
         vYIbgTA1q18/ImpYh1KsCyTitTUi1aJosseM8AT6USaOzq9w7Tzik7zuMMmg3fztN2Ie
         LK13m8+on9SfOUEFxr93ttbjRFdtIaw3R3Kf/GjP1rcu2wRPYK5tHIn5rqaw432gtz16
         yOEfMygYDhJDKk7LqKE+w6Hs33GqYWgKyxrG/LgbMSsh2GqcaixbU5pZd/G5eS0JfRud
         RDUA4svz2XNPeEsqlr8Nw/Vf0VqIGw3uP/9Qo5jK/QoR6e4pEaH6pEpvsFhHYIueBnfN
         rEbQ==
X-Gm-Message-State: AOJu0YzhJptT6bwqpENpJ18mIc9xdgmTlDePaA8Zhqr/wzvcdiKj6eKo
	1kfxfmBimK/39bdjQUf/Oa2vOg2/u9voHIHwkXeybuAQ+DFIC196
X-Gm-Gg: ASbGncuSWpOwxTIqQpDqkmcK8azhmj27elsqCYDl2zkszoTyQBDivvRjIbf51GnAGLN
	WbW7duyeHaGLUwC3x05L3QWijNdVGSilqI1KNUYy/92+A7pB4KPsK3Y+q0k8pDP/sWV8VbbcwNv
	cePW8uopZy0c3KTK0L7zh0tBVV2OmSx6vyXc5IS44QN/DYwVa+L93CDXYYCVQR8eCW0QgzVWT9W
	lPqEc8TexZv4ajpylKJn33suLFhDwhR1yefCL/vaGI0XxJRL3IngjMCD/66Mc1kx+FVk+g5BYGy
	k56i8yYkgyFg6+0jYA==
X-Google-Smtp-Source: AGHT+IEszT7URVfHCGaSnfNMllBFWnxt+85NDKuFT6ULHawX4sf7qvQ0jaYQB2eaVmY+prh2O+F5Bw==
X-Received: by 2002:a17:903:22c9:b0:215:9ea1:e95e with SMTP id d9443c01a7336-21f4e6ad3bemr62710695ad.13.1738967001048;
        Fri, 07 Feb 2025 14:23:21 -0800 (PST)
Received: from archlinux ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368d923fsm35637065ad.256.2025.02.07.14.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 14:23:20 -0800 (PST)
Date: Fri, 7 Feb 2025 19:23:10 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Mudit Sharma <muditsharma.info@gmail.com>, 
	Julien Stephan <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, 
	Angelo Dureghello <adureghello@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Guillaume Stols <gstols@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Gwendal Grignou <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, 
	Tomasz Duszynski <tomasz.duszynski@octakon.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 21/27] iio: chemical: ens160: Stop using
 iio_device_claim_direct_scoped()
Message-ID: <y3fchxgukluqernogk7mn7ev7ns6vqj2rjtigivmficjsmclri@dceip325aqzn>
References: <20250204200250.636721-1-jic23@kernel.org>
 <20250204200250.636721-22-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204200250.636721-22-jic23@kernel.org>

On Tue, Feb 04, 2025 at 08:02:43PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
> 
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gustavo Silva <gustavograzs@gmail.com>

Reviewed-by: Gustavo Silva <gustavograzs@gmail.com>

