Return-Path: <linux-iio+bounces-9673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF597D836
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 18:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDDC1C2101A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493A817E00A;
	Fri, 20 Sep 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlJVWQGr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9DC148
	for <linux-iio@vger.kernel.org>; Fri, 20 Sep 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849133; cv=none; b=OTxfxeKsjvEWJULj1jxOlRYiRIx/G/g9wC5sqZ/5WDMVSQAEqN4+9fdC4TRoKavZgWq9tyuiNxwkKreKsHTf62sppv8a3ez3bAEYeHXftoqEQIgXfT/N9NkyWDZmJN74ueWaS4o31dM/igp0tV4Ki/OOfipMDT6+xsRDtXpoKHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849133; c=relaxed/simple;
	bh=J+9Zuih4sL73Lyg2aUFKSx2TwgAQ0BlX4KgNuzyrhls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfPUjiTu30korNL+uo5zyG/o/CWhl0CgWm3aJVIbJoNJFb2sa2nSakjUnoVeZVL2dn4/u8gBIxFaMkrPGHBPou7TjdRvGVuI6FN8w0uBAEFOZ9V81LLs1NMWGInzE4hY9lh0sqLbY92Y5BfPfcZ0Wsf6UaAZcvhvnh9cFOKTGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlJVWQGr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso26902105e9.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Sep 2024 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726849130; x=1727453930; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J+9Zuih4sL73Lyg2aUFKSx2TwgAQ0BlX4KgNuzyrhls=;
        b=PlJVWQGrAW32D/orZTMwlVxwBoIXQO3NX7Z0AVGFRlm0Tsf0ieVKFqub/4yf5Z3wMH
         O9bRkCUzYCWq1i1nzCIBT2ED0jrIwmanNhVAS49LNrcHRYmqwfynmTBlanabvxmrLVi5
         i9+A9DLCYF9ZQRV7tlw+Pg7Nx62capuz7WlVxHZWOHnwd5hUQ3TZL/BCXnSDPSyn/KX6
         tsWHRfjuIepII87ZEe+vlFjqeJxLzrI4utr12IuHbBD9sPNo1EOU/J75yYwu/2aJYZY9
         ehnp21aWwlEJ1EnaPeSgoLMLkAFfxXIMcgYQeAQN82sco73b7SSPdiZdyIZmLaedX29y
         /8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726849130; x=1727453930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+9Zuih4sL73Lyg2aUFKSx2TwgAQ0BlX4KgNuzyrhls=;
        b=T9LtkmtzR3qGvBGQdexRyY7q2CzACibXFmpTS/JCkpKPDbNvwgyp1jgZoXTJTnaRK7
         Ub09DdpBZcoA5gNijX9OiGRFnfF2sBJAF9gamchQmC0WcdcUBivs5N/XxqvxX1YhWdHN
         +zKksFme+bS1j6cwARgm+PmolyDoG+3DFUsNEuxHlYCKS3V0soJ1CZA+3MtGkAy8pS4q
         3r8ocZsYgl+ErcQPVNSBpPHKXlXNywCOXACjGSwrZBT5WE8PaJLpOV7sv3QymI8fHOxP
         SgU2DWEL0oQPgfAFL/PWsoXouVAx/8A/HsiACoslA74t5EcoA6vw/RWLcsuHlDvG8iQ5
         iabw==
X-Forwarded-Encrypted: i=1; AJvYcCUEjwecIsKQwFxN8OG0Tem+auKcLo7YD5+RKPyAA+TSUK7OMzmQeRA9Um7FdMK58OiaNWa6UL9O11E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcLwZ8P76+pQvBpVF3H4CYl3yqvj+6MMZPWV4S/eCXiyqIpyJ
	dYvk9L+zZSTtgGFgLnTr3nY89+FybDJvrSPSyv4DFsBeYEtcsfAB
X-Google-Smtp-Source: AGHT+IEg+SQLOJ9uOHhKHHWsYK8DGxmpY7z3Z2/DbiMEpaeoyXd1Ro6u7KDq6zdg178hjGHXEkghTA==
X-Received: by 2002:a05:6000:d8b:b0:374:c3e4:d6b1 with SMTP id ffacd0b85a97d-37a42367ed1mr2652756f8f.44.1726849129513;
        Fri, 20 Sep 2024 09:18:49 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780016asm18223242f8f.85.2024.09.20.09.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:18:49 -0700 (PDT)
Date: Fri, 20 Sep 2024 18:18:47 +0200
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Drop explicit initialization of
 struct i2c_device_id::driver_data to 0
Message-ID: <20240920161847.pcf73idvu455nyj3@joaog-nb.corp.toradex.com>
References: <20240920153430.503212-11-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240920153430.503212-11-u.kleine-koenig@baylibre.com>

On Fri, Sep 20, 2024 at 05:34:29PM +0200, Uwe Kleine-König wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>

Best Regards,
João Paulo

