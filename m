Return-Path: <linux-iio+bounces-9860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E89894CC
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 12:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC521F22D04
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA757143C49;
	Sun, 29 Sep 2024 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZKH8Fu7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC237171;
	Sun, 29 Sep 2024 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727606030; cv=none; b=uuI9a87p/309LTXthjq6e9AkueH2ivcXplsWjYt3LF3p9NERdUg433pw/IQrTVOR9wfem5anMChsK+rGoAZYEeaov94pBhu3Kz0dBWOeMiXl2LDj/LX7KPW7B2Bv0esKPbm/OtwERSJ2h+cxHCky2jodLes3I9eB0Ji4TiBqYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727606030; c=relaxed/simple;
	bh=HUx1Ivfx1IhmcyLvHhuzOyzxa7KUL2zYPRmRLULcpkk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze8QhCbtxhuSxwIyDtZG5yMhdb2CXHk7WfIi4rZAPSH6Bn0x8DA5+wcPo4tBEz9HD8Eg+sM6lEQAijsJbSTKLGAjLJZqmGK5QWDTSgeP43f3586LxdW6g8zPY81gOj65q3dDxaSUP9JJpVQ7LF8x+Ikn6AscXx6EQ7VZBJfOAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZKH8Fu7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso26838005e9.0;
        Sun, 29 Sep 2024 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727606027; x=1728210827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sNu5QIAwEpHkv43P1CIy6bDLiIxagZE2o7RuIezTmQ=;
        b=UZKH8Fu7v4MGOwFzBb93XqkUzRSSCgk6+/5Ql8hjElU5wj8NpZQ1e8KZ+4/assKMtL
         yXMt76k5q5NZSEvSI6F3bQ+IzdoC4R8UrhEMNznpyWmZMVC8hM6Q5sRJQsK6rKn1Ui/x
         2/Mdd1FqDAzHsFxtWGmkjLIXqzsSxLLSgcgaGjs9gUEMwh33tjz6rFWrWC2/a6Ta4Jgq
         22Lk3oZ0WcEDTyVhgr45bFvoaK7QCssrtmIEDG4LQM1FhUz9dPswYPwEVYv4wu5ymiG1
         MuY11C1g6utXzxUdmmB239YCEO4h7ZGRiSEjX1yOaW/nNyIK6/HyCHJp3LJWmvRG/BKY
         OdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727606027; x=1728210827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sNu5QIAwEpHkv43P1CIy6bDLiIxagZE2o7RuIezTmQ=;
        b=F8zKzT7wr1UcyeHTztoFQ8GCUZndnOoDdHukyVxO3fS9mPuGy4nM3twfc5xMa6CmSE
         qLJ6g1T0mXEvE3jGRS32H/4/tWfyW8GtQfek4qcYbvOEC2Sf1f49Ivw9qhXSHlIgvpTX
         G5X4pBsbrjqv293B+YiqyVY2EcTebb35sgqmkUbu5eRtcwdBfYUBjxu5XgYCfvUqsgVm
         oz3xmnIDeNWsTXxZYOVcDeVZ7cm22A7Sg0EtCvHNtpzW5wKkhSFXzlbJrxMV9KuTLdwo
         IKBFSDrOm03tUO7a+RlqJGEcZYBbjRjNF14lK+gPGcN+YI/VQOlGsGUE6wwR010Z4oKb
         b5+A==
X-Forwarded-Encrypted: i=1; AJvYcCUZK1qYGq+D6SHUyIiRSLX9ee92xYZF1LbLnJlrGTPoK2ots3NGPUljkcvpuoYHk33oJRF92+p+1L20EWqn@vger.kernel.org, AJvYcCVajE4pzPgsDbvTAb9M2X0QGccNGNo87c2HPYQ9N3B6oczUc1ftPx0yqnLHGwiSiZHwfjGrso+2Jlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10Q0pi4kXJkYNU9veBcf6JdZU+LZiP5/ReBxzw9pNve76Cqr0
	nkKzWU4VEWBT4Sn5cMIaohwVgJDf25IdWEW5ktfqxtwulCRg+G23
X-Google-Smtp-Source: AGHT+IHCHKQ+3UZb9Ue4WC927zZ2fapPCrxN4CYADiZ+ceDNzbzriXz5p6L/wqaKAXwF5s0iSoOUZg==
X-Received: by 2002:adf:9b96:0:b0:37c:c628:51b9 with SMTP id ffacd0b85a97d-37ccdb6872dmr7294618f8f.26.1727606026807;
        Sun, 29 Sep 2024 03:33:46 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:4d6e:df7d:f1c8:ebc2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e30374sm74339435e9.42.2024.09.29.03.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 03:33:46 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 29 Sep 2024 12:33:44 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andy.shevchenko@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 2/2] iio: light: rpr0521: Drop unnecessary checks
 for timestamp value
Message-ID: <20240929103344.GA92011@vamoiridPC>
References: <20240922162041.525896-1-vassilisamir@gmail.com>
 <20240922162041.525896-3-vassilisamir@gmail.com>
 <20240928161527.73fe0ac1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928161527.73fe0ac1@jic23-huawei>

On Sat, Sep 28, 2024 at 04:15:27PM +0100, Jonathan Cameron wrote:
> On Sun, 22 Sep 2024 18:20:41 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > The rpr0521_trigger_consumer_handler() is registered as the trigger
> > threaded handler in the devm_iio_triggered_buffer_setup() function.
> > This function is being called in 2 ways:
> > 
> > a) when there is a registered trigger being trigger like sysfs or hrt.
> > The call of the trigger handler (which is the iio_pollfunc_store_time())
> > follows which saves the timestamp and then, wakes up the trigger
> > threaded handler.
> > 
> > b) The irq handler is using the iio_trigger_poll_nested() which wakes
> > up the trigger threaded handler.
> > 
> > In both cases, the pf->timestamp has already been assigned a value
> > so there is no need to check if it is 0, neither to 0 it after
> > the push to the buffer.
> 
> Not quite right (I think).  The caller of iio_trigger_poll_nested() might not
> be this driver.  There are other potential triggers that are nested
> because of need to check some status register, but can still be used
> for other devices.   In theory you could drive light capture of
> the as3935 for when you want to know how bright it was just after
> a lightening strike :)
> 
> We don't have a general solution for timestamps when that
> happens, so this driver is papering over that with this code.
> 
> 
> Jonathan
> 

Hi Jonathan,

Thank you very much for the reply! I see your point, I also think I 
am wrong after all. I was just interested to see why this driver makes
it so different from the other ones when it is coming to trigger/irq
handling. Thank you very much for the explanation!

Cheers,
Vasilis

> 
> 
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/light/rpr0521.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> > index 56f5fbbf79ac..ae6a22b91b8d 100644
> > --- a/drivers/iio/light/rpr0521.c
> > +++ b/drivers/iio/light/rpr0521.c
> > @@ -446,13 +446,8 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
> >  	int err;
> >  
> >  	/* Use irq timestamp when reasonable. */
> > -	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
> > +	if (iio_trigger_using_own(indio_dev))
> >  		pf->timestamp = data->irq_timestamp;
> > -		data->irq_timestamp = 0;
> > -	}
> > -	/* Other chained trigger polls get timestamp only here. */
> > -	if (!pf->timestamp)
> > -		pf->timestamp = iio_get_time_ns(indio_dev);
> >  
> >  	err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
> >  		data->scan.channels,
> > @@ -463,7 +458,6 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
> >  	else
> >  		dev_err(&data->client->dev,
> >  			"Trigger consumer can't read from sensor.\n");
> > -	pf->timestamp = 0;
> >  
> >  	iio_trigger_notify_done(indio_dev->trig);
> >  
> 

