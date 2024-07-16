Return-Path: <linux-iio+bounces-7648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FDD9331AC
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 21:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E381C20C11
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87F01A08C4;
	Tue, 16 Jul 2024 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJUjhV6u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B181A08BA;
	Tue, 16 Jul 2024 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156769; cv=none; b=Q/50B5k8wPM9dZrPw9uI/DmAGbAwWieVZ470Hzo67ih8k3qGightpBGJob9uvxlAhR+OWmpv/ZHD2PJmn8YMV08f/sGjYzaHPP915DjnM6q/UC9buWs9MRDWzVxSRg+JU3nYeZPMGNgr2eftWJMrhwddCM/2CjgiHu5sT7d+lDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156769; c=relaxed/simple;
	bh=yFU1DoqmYUZ73N+0xQPvNCdgLYYR5HJxDDypYhIzXaY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkDDvLFBP4TlH96N1VWwbZS3wFrdBUARXLMSxRt154Pjx7H1xp3r+2Fev/kIGoPVfHQQPZMnTbIjOi3wqCPZ3PMCdR5AmRh7aYLIuGGlDC1uP/cEF2lluLWgJfmUVCXNMy3z77tPJN9O6BoYPdQOmrv2quVPnD0WveLljBSJu8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJUjhV6u; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so11515866b.0;
        Tue, 16 Jul 2024 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156766; x=1721761566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbVRbVtNHjSZAwsTYlzVgrVndpQHet4gZ38C2iUs1ck=;
        b=mJUjhV6u9TGDMXXC8AwpOchTXHqXsBAhkb7AGo6/zdhjz5iySe3fi2YbtxfzmH3C3r
         VbvrLWMtV0e9LC1xX12ZIdlCA/Vh4vkq8vRYzV2ZlOoywT6egTX9YozRCyYQ7rUDskO5
         10+1XwbYQDQiL74z9ZToqQRAAZvLhEakRqklfkCBqkyC22rNGD7cu6QkEkaWWXwKFa1n
         6OrS8T/K0dKGG+ULq7UHe6Qthrv6fedXLa1txo2bh06lZiwQSzw7cMs71XAZtPAKYsM0
         +PTLvSV1ociBtsc+/ss1kaXA0wlm1li+SI9dAEFfV81+8ZZ2Brba/9psnDVxBdD3Ct89
         71Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156766; x=1721761566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbVRbVtNHjSZAwsTYlzVgrVndpQHet4gZ38C2iUs1ck=;
        b=LTf6BK+N2r3E9Fl2K9Mr6o+dabU4owzWgd4rZwFS5glsItsivOwdt0AxA+sV9JGHOL
         oeVNCGi60mGojeznlSGv4EnqSBEZ5XvwpbHKjW+pHMZx+0P5hY/Xw0Gq6Ak+uAT453gK
         +AW+rrfRX3o5GOaY3liMTOSYtld2lhJRcqErXDlXbH1fERJgpr/hMmiS7O3UwYY6HwBa
         ZDP0k6QT6L7H1H0Hm2G3raQo/lgOPWNVNs/DBsjY4nmsf2ZqpyeDFfaDcnYlEwazvSc3
         UNzAy5/+L/O/S8M8LhN7ChOZpEYOTuoqY2w97cyRVZKTreBY4pB7gJuJVwARPRxwNIwV
         0vXw==
X-Forwarded-Encrypted: i=1; AJvYcCX8ENHpyOgBlkaOtXuY2S2ONOQQ3j/2Bc0YfGPYrAg8/Z3VUs5J4rnC38RRGhpQktunh06vSRMjNfbnc5AKzRpjkufLG+HpZB+8RnWBRLylFxRHcSWN+NXHhtX8swHyX376nZ/Gh1Au
X-Gm-Message-State: AOJu0YzM5kCN5q0SgakYGdwMF6rqCg/EitHBCLV4pB0kkTqUSfskZZJd
	rOXsl6DNvwJ8W4avabO8ae8XvTmHFejKxVcLVHqtt5A+tx95aD95
X-Google-Smtp-Source: AGHT+IGwyyZHAsGGgQ5LUdKfGrLf99iEaNORyAqwbpR/LysIFXP4HwONOBRiXWr/rWTj+7tn92MwYg==
X-Received: by 2002:a17:906:1411:b0:a77:d9b5:ad4b with SMTP id a640c23a62f3a-a79eda94957mr261489066b.9.1721156766045;
        Tue, 16 Jul 2024 12:06:06 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:a8e1:c73d:f3db:4b4c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820e27sm345766666b.216.2024.07.16.12.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 12:06:05 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 16 Jul 2024 21:06:02 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Adam Rizkalla <ajarizzo@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	petre.rodan@subdimension.ro, mazziesaccount@gmail.com,
	ak@it-klinger.de, ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	tgamblin@baylibre.com, phil@raspberrypi.com, 579lpy@gmail.com,
	andriy.shevchenko@linux.intel.com, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] iio: pressure: bmp280: Generalize read_*()
 functions
Message-ID: <20240716190602.GA577521@vamoiridPC>
References: <20240628171726.124852-1-vassilisamir@gmail.com>
 <20240628171726.124852-2-vassilisamir@gmail.com>
 <ZpROUow6p78VJsrO-ajarizzo@gmail.com>
 <20240716180850.7c6089f2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716180850.7c6089f2@jic23-huawei>

On Tue, Jul 16, 2024 at 06:08:50PM +0100, Jonathan Cameron wrote:
> 
> > >  
> > >  static const int bmp580_odr_table[][2] = {
> > > @@ -1830,6 +1848,9 @@ static int bmp580_chip_config(struct bmp280_data *data)
> > >  
> > >  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> > >  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> > > +/* Instead of { 1000, 16 } we do this, to avoid overflow issues */
> > > +static const int bmp580_temp_coeffs[] = { 125, 13 };  
> > 
> > I'm not really sure what we gain here from using 125/13 instead of
> > 250/14...but I don't think it hurts either.
> > 
> > I don't have a way to test this with the latest kernel release
> > currently, but lgtm.
> > 
> > Acked-by: Adam Rizkalla <ajarizzo@gmail.com>
> Series applied.  Thanks
> 
> Jonathan

Hi Jonathan,

Thank you very much!

Cheers,
Vasilis

