Return-Path: <linux-iio+bounces-9891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3559896BB
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4BA1F224CE
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F2F4204B;
	Sun, 29 Sep 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I94D5DIl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD32263A;
	Sun, 29 Sep 2024 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727634040; cv=none; b=NPJO15f3HGL22NEvdPZVUFfaTFIyJXJwEyFIctHGSk0u8ykJPVxiRM2axD2Qk0IyQiJBnY3IrXIcXSYJSLNixgfqwCPGu9sNZtKkcT/dIyWxI005LzdrA0vlTtbkwWsJbWXOHMJHdmnKxntEfBulhJTFaUAc2hxjKJH0O1Swa8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727634040; c=relaxed/simple;
	bh=dx98SzG0vXnZ6U7aGG4CHNbUS0cwNCxmS94l7CIhOK4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVYXbp9tgTtMi8bpYnM8U3ZWLzujiFYedYpt9bY9ynZA/oTb9rWZaHZ1Lz2mtl6x1GUaZp31gAnG6cFmXd35wj4gIZSrwR1eGELRAKZXURGYEEA1cZ1+Ol7+2E3DFwKPmijFdoY72eOVR98WWcf4mLn/5VAz+Mo+qU+RaKXzF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I94D5DIl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso591284266b.3;
        Sun, 29 Sep 2024 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727634037; x=1728238837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIhQyB1zmp2fourf7t7A6PbiXpMcGdp9O1h0W120jps=;
        b=I94D5DIlCabDkQj8Rr5uHmkjbDRVbGzXzoYG8Jtm1MA/ST7uQsD/BHhvlhRuyDPLQn
         /UkseLqY/xGpuwg350et4eAGTZ/uaC/hGZUF7czBIE4OC4srjm/uiZzP/mj+0LXQ3XRb
         1E9mEWwVtlXIox3y1qB38Mx1+deAqs0KpBS6b+SJKgQxWqkB6kTorymlZQXQpQlW94me
         WPZt7dThprEuv7yz9NUFzjS3fOCoN9I8UrnJuuWIC43zotpq6UADrvNsUkTYAOIvyszW
         OOJG8x0vCL2eeVi+BcweDUt4n4JX5iqUfu8GdaFxkI5kRpwE/ls8rGMZZbX8mxTap/Xp
         y/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727634037; x=1728238837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIhQyB1zmp2fourf7t7A6PbiXpMcGdp9O1h0W120jps=;
        b=jR/FKRximzaemZQQO4EAi92Mx8LZxPnzK0TL8yHTBEpTOBWxUJpGb9pglQeN4skaeN
         vjWPLTbmnGNMo7Me79LFHYEKZs9TP+rkQGT6Y+iDnfmuEsUsjoOJrMXy0C5nlRZB5Fti
         BhpdYe297HeWyaGR635kya1pRDwNhQ2sjcniTg4vWnhnLs4/95N+ZDf+kMQO/s55TYNU
         EbYfAWVWZj/lpIflSOm/4adI8sbzsioY7WnCMcnfLjOvOxWUlaQYu9rMouKHVTkePAEK
         IlO9LzbQnseH/zzJhu5schVZ+hvwiFfoeT6JxSGBTZhnzUsHnrXHqW4epSy+qM/Liom3
         bRDg==
X-Forwarded-Encrypted: i=1; AJvYcCW92SBTTGCF3dj/rCFSpjnMXEGbQHrTi+iSA/yLxfoOsF5RzTKWEypkzj+ZBZXMnrcQoTddg9CO626VHWOv@vger.kernel.org, AJvYcCXiktDpjGfJtY3yTRIEi5jJj1ONvxLOi43h3U3LnkJeqMLiEYyOEMaRw927z7TyAq9EmPOm7TC1JHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm+oI5MHyrG6k84Fs50RxIHhQgg84qLdBEqc3b0J1rjB0X/5TJ
	EhDcYCTOhn4EAkzBuEIIgz4TbZVoqAjVTD0JlilcyMjx+KyW2lfu
X-Google-Smtp-Source: AGHT+IGEp9wZ4D2X3eyEoFntYJnl9jGs+c4/61l25eHGVK0EQEzCZ/jP2ZO52SD6zxW0l6cKqis8XA==
X-Received: by 2002:a17:907:2685:b0:a86:a6ee:7dad with SMTP id a640c23a62f3a-a93c4a4e0a8mr971097166b.52.1727634036526;
        Sun, 29 Sep 2024 11:20:36 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:df60:d786:cd5:d3c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297a2ffsm407216666b.157.2024.09.29.11.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 11:20:35 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 29 Sep 2024 20:20:33 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: pressure: bmp280: Fix type for raw values
Message-ID: <20240929182033.GA213331@vamoiridPC>
References: <20240929112511.100292-1-vassilisamir@gmail.com>
 <20240929112511.100292-2-vassilisamir@gmail.com>
 <20240929175710.2e101abc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929175710.2e101abc@jic23-huawei>

On Sun, Sep 29, 2024 at 06:04:26PM +0100, Jonathan Cameron wrote:
> On Sun, 29 Sep 2024 13:25:10 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > The adc values coming directly from the sensor in the BM{E,P}{2,3}xx
> > sensors are unsigned values so treat them as such.
> > 
> > Fixes: 80cd23f43ddc ("iio: pressure: bmp280: Add triggered buffer support")
> Why is this a fix rather than a cleanup?  Looks to me like all the values
> are going to be small enough that they fit either way.
> So good to tidy up for consistency etc, but why a fixes tag?
> 
> I 
> 

Hi Jonathan,

I used the fixes tag because I though it was appropriate since it was
using a wrong variable type even though it was not posing any
functional thread (I mentioned it in the cover-letter as well).

Since I am doing a new version I can drop the tag, no problem!!!

Cheers,
Vasilis

> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 6c2606f34ec4..472a6696303b 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -1023,7 +1023,8 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
> >  	struct iio_poll_func *pf = p;
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct bmp280_data *data = iio_priv(indio_dev);
> > -	s32 adc_temp, adc_press, t_fine;
> > +	u32 adc_temp, adc_press;
> These are filled as part of a get_unaligned_be24() so the value will never
> be big enough that signed / unsigned should make any difference.
> 
> > +	s32 t_fine;
> >  	int ret;
> >  
> >  	guard(mutex)(&data->lock);
> > @@ -1137,7 +1138,8 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
> >  	struct iio_poll_func *pf = p;
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct bmp280_data *data = iio_priv(indio_dev);
> > -	s32 adc_temp, adc_press, adc_humidity, t_fine;
> > +	u32 adc_temp, adc_press, adc_humidity;
> Same with these.
> > +	s32 t_fine;
> >  	int ret;
> >  
> >  	guard(mutex)(&data->lock);
> > @@ -1616,7 +1618,8 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
> >  	struct iio_poll_func *pf = p;
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct bmp280_data *data = iio_priv(indio_dev);
> > -	s32 adc_temp, adc_press, t_fine;
> These are similar but le24.
> 
> > +	u32 adc_temp, adc_press;
> > +	s32 t_fine;
> >  	int ret;
> >  
> >  	guard(mutex)(&data->lock);
> 

