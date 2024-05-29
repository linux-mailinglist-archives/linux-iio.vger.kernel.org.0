Return-Path: <linux-iio+bounces-5474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550478D4220
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 01:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8916B247E0
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94791CB329;
	Wed, 29 May 2024 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn7DAx3f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DCA28E8;
	Wed, 29 May 2024 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717026564; cv=none; b=PFUAvu8gXKbMCakJPChw3HHifZ/nhwVAVzMuXzEbTTd93MuCSG3QAyetASgEBlYKTyKAfCMG8ApAse6r6pZpO86YTnfTCCBfWz+4WvhCpnub/M9/IsFILQEoEt/fmRKhWop+rLoydvVhnm8eduBy2xByXZJgxd5/2QHBdhbBjm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717026564; c=relaxed/simple;
	bh=x2aVOwUD3F9tCvVgme9sF7aWoHzcwEI3aj/2Y2l1upM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLpzz6Cj5/Sl46zdUEwAguoGt9QBVSd88T5DfMWlYfrIl+Pr+NxIBvTyNVnTqnrOHaTV5ZLtdv9C7RgmYPlQSzlgkzZVlxq+n3IBjmSEWbbZ7zqWAFkThPgQTTkE8Pbf2+u9jD/Q3HQcH7vg6I2m2GJZcyhsTTA41GHs8lZ5R30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rn7DAx3f; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso3772541fa.2;
        Wed, 29 May 2024 16:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717026561; x=1717631361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9nBHoXpEdG0AwZuUWf4ewl7uV+b4KkibHlTOCLBb8Y=;
        b=Rn7DAx3f38K81pOx6+SdvZ9OA3rwXnm/wlsult2XwXbRJllrGprTfWlTcHOJutqW0c
         ejQm0Cm8zXzapkZQDHFb27do7/tXwOKunzvvuOaqv7iTSBdO7OsCUHBz02+URfYe5d75
         gOphzswL8AxZ3bOCImHwYnpjCcENNTGDYrodmpvbrtZtMdOzIp99YYgd0o5b4RNvc5NR
         QrVSzVdk+liVXLrh5GPNHpCT7CzQVDJX9nN7FmCUZkDvYf/JYF9zoR88jUFO99MzCsp0
         srIgMvUyu0YStScAS65ioYOhm2C6ntb3SFTJe7dvaLWiOfv5O6e9kZNtpZKjtB5NJ/Av
         K8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717026561; x=1717631361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9nBHoXpEdG0AwZuUWf4ewl7uV+b4KkibHlTOCLBb8Y=;
        b=O/O30ZF9tcg2A0g+SPlBoFJDBKqgLit5Zq+51sFqqVUbGQEI2dMXAMXPTPTuXeJoN1
         o9R6edMyWTRBYPy+p4BvPYxmffwnYj/0OR7qZgef93mj0C10l9CzV0HKHdwrydtCXqB9
         gpHbEJKSNYhrhs4mcnrLcI4pRQcGJ+7Ck6Z7t7S/kGI+TJEIjtapOthmKQJQGSJ/E1ay
         9J3/YzyMFU94wa3Qxq6UFVO7j1CgSB+mN6+yw/ss+pp8XqThVqDFHcuezTNYzzIjywa2
         RRrKlHF+Mrs2TmIjLtquDRdJQTArY3VSm0JZBTEc6ZHS6wHqYibm+mrnmhnQgCWUt9wv
         AonQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9JwEKySUtaFhRSCu6MMNlP+3NRX1APiyt097HYjtB3OjEoq0aPY1mrhVW5SKPSHFFxkO59DikI569dOsf1+E32IJ+iGsqqnZUJ7IB4jLo91jeHUeX6Wo4eBuuHG0CWoMadsHD77Ha
X-Gm-Message-State: AOJu0YxlsH+MW/M8EG8PgWueH+VVDE4mfntWIal7MTq4/CaiTTuQQPOm
	yHRJbIDqtrn7YQNhdKkEBFqghZT9wTUw5RmQTtudDly03qRb6K/o
X-Google-Smtp-Source: AGHT+IGQ1wfQ4nVqG0431DiYzj8HZ20GJ5tVZcDweACQcFZqqA3fYviibe14czDSUTvr3UzP4D87MQ==
X-Received: by 2002:a19:c20b:0:b0:523:772c:2c1c with SMTP id 2adb3069b0e04-52b7d43a692mr408706e87.38.1717026560656;
        Wed, 29 May 2024 16:49:20 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:b667:478c:868b:5803])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda6cdcsm757739366b.209.2024.05.29.16.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 16:49:20 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 30 May 2024 01:49:17 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240529234917.GA83937@vamoiridPC>
References: <20240512230524.53990-1-vassilisamir@gmail.com>
 <20240512230524.53990-6-vassilisamir@gmail.com>
 <20240529211228.2d7fbd93@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529211228.2d7fbd93@jic23-huawei>

On Wed, May 29, 2024 at 09:12:28PM +0100, Jonathan Cameron wrote:
> On Mon, 13 May 2024 01:05:24 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> > temperature, pressure and humidity readings. This facilitates the
> > use of burst/bulk reads in order to acquire data faster. The
> > approach is different from the one used in oneshot captures.
> > 
> > BMP085 & BMP1xx devices use a completely different measurement
> > process that is well defined and is used in their buffer_handler().
> > 
> > Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> 
> > +
> > +const struct iio_buffer_setup_ops bmp280_buffer_setup_ops = {
> 0-day noted that this isn't actually used.
> I'll add it to the buffer setup where it's currently passed as null.

Hi Jonathan,

Yes, 0-day informed me, but I was not sure what to do so I was waiting
to see if you would see it during the weekend. Thanks for taking care
of it.

Cheers,
Vasilis
> > +	.preenable = bmp280_buffer_preenable,
> > +	.postdisable = bmp280_buffer_postdisable,
> > +};
> > +

