Return-Path: <linux-iio+bounces-14151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B98A0A6BC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 01:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7276E166890
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 00:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFBC3232;
	Sun, 12 Jan 2025 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIXVwz3f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7120E6;
	Sun, 12 Jan 2025 00:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736641594; cv=none; b=Lv1ikZliPf1RH51ba4NYsN3Tr2Czl540c7iKwZ8qyvRSvQZ3+RkKSeDkg8Okwc/J/SSQDShKozerUxCgN7NqzxsNvzS973nl0UZ7lma/4E++tTkSut2krbGBhpupQhoC66u617jVyqlCfjaFhwP2nVrh3l4zhIoPyOQtwesCvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736641594; c=relaxed/simple;
	bh=ZYR2ncLEcZIOkWazztcbfkScekNfCPXhgQdQBr6yddM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT1S3ld7VGuzAskhJX5h65vpVoNcbSo2wRG8xCtjOdVX6gFES1QYxbVp9ccI3kNoHx0olUzkvvhHqxs/o5IdCS4eoMCCB2ZCH8dciW+Mk6/P1rem9va/w2dTwdsKLWlBkKQrgsbHC2FAuy0gT+OFXVeMhQkzNZlYVhVd68ac2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIXVwz3f; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb82fc512aso62029b6e.2;
        Sat, 11 Jan 2025 16:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736641590; x=1737246390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0q37gL0J4tzCHMzLwcFXciR9c+zRsUFJpKRfT/0PIg=;
        b=MIXVwz3f4r5iWu/9yUkYYs6lNOrmEoNtz+3RUoG5aUkfyOHCXAPTMtEwssZ5OBKo+I
         OyczQhdQg9tIV11BjBldv2luAcCSef4YZ6/nezmqcLqC6KON8lQhAD0Ff83EDJS3ao1w
         28IAYQOSrN002EjJFx9PA5NBqKhc89g1vNPk4Sv/U5Uc3I7GCCobspFfiAtsBUa55Nyb
         rjlQDXZz4KAzQ+I91iPB4yWaYdHBOsY14MkEF7kWx7Dm/XkN9DIJAW/7jx9L+YBU681A
         n7CQ2H8WwyPw9y3JjQC3I/HaTobEnkjTsoEEseCZk0/Ic6W7WNIg9yE4Kqmf5r3RuMln
         cZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736641590; x=1737246390;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0q37gL0J4tzCHMzLwcFXciR9c+zRsUFJpKRfT/0PIg=;
        b=A3w2GwEyDm/EDc2CYlGAHx1GiW791MRh1PuOJCEJuz2XkOdWiYyMhyLAiBMhYk1ZyM
         LvtbgBDBP3rGABsX+uDHCmwWbp+dBb2rfCkTIsJH4aqKKQhq+yVLcC1NXiuQauFxaOrs
         IWd1Esy3LPG+OnzwlusRvsKP26+CpCytQD7rAvebHzMUlezXut11ekWZL6NHDe+VWKNl
         Shlk32LNeofnpKRTYdZKrk5FKW58Srr1KVfsYueOK6vvMoe1Kq29Ncg9q6WrvlkBG9kE
         QfLqzDN8oYPiCPFDiuf6XR6UVAXHKO1stsR7KYsQE3bGdknEKjOZGel+U+kBVgdIW+Lx
         BMLA==
X-Forwarded-Encrypted: i=1; AJvYcCUy4AieLEWgQLxB5YVi3o9VFQcQEQc4ITye0DFaq8Obzcnrn7VJ4j7ScPU89U3HhaXtXbwd8fQYEAOi8xGK@vger.kernel.org, AJvYcCVjzvB6+id4ahJdj9GvS9AI3ymcaQY41BZc7GcyFRwfhuhBxnP68TKEgNT+W6xLnXcWr7FcOk7i0nTi@vger.kernel.org, AJvYcCWW7bV7BEfnbtBvf3rn+M8sH1mfx54634q+z9kF2L/VLR8lW1CQHFi1MIz/VwHKiyMXP3ZTtdG54wS1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RpGA1lI25s4SKgj7Udyni0a4Un9/V1V6FP3Arn/i5APUtO+s
	Xra4Z2z6OL8WwTopls8E633PJkzNOTWKm9b0Mm2Q2mQymHF8kcni
X-Gm-Gg: ASbGncuihrjGzqyKWOaFhNKlJmF1psWCs8lKim0+FVl3g6VmFyssOYAkysixwUoVTni
	4Id0Mn0ODyXLWsAjWbY6TfH1eqk+RXO4WvXQe1jGMCr5YvcCBMMz+M4O0R7jFkXWJsUhCFuECvx
	seyZ3RpoPz5m2W2lH+7MzAF/xzpHuGzjyA8mTlavFRscKrwPMPp8bptpxG3DjLGLNUZfqkZn53L
	vrVrqT2T2HLb0G+lgdFQiFz2gZbUvpyGhxulEz0YdieBCsluyLbOBNRhzck00aKykPdkbgVIgvR
	TA==
X-Google-Smtp-Source: AGHT+IHSCKkXwzHjhG4S9sReq53EyqzW8rNHHDbQgzcPp6UsSN2IEAy7m2HswRnjU8dPT7kQ1DDzqg==
X-Received: by 2002:a05:6808:1590:b0:3eb:834f:775b with SMTP id 5614622812f47-3ef2ec6e218mr3618937b6e.4.1736641590545;
        Sat, 11 Jan 2025 16:26:30 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f037a22ee7sm1926707b6e.50.2025.01.11.16.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 16:26:29 -0800 (PST)
Date: Sat, 11 Jan 2025 21:26:25 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 08/15] iio: adc: ad7768-1: use guard(mutex) to
 simplify code
Message-ID: <Z4MMMThN0qxIrA6o@JSANTO12-L01.ad.analog.com>
Reply-To: 3de36de0-93ee-4ef3-a4a9-7a8f187eb4d8@baylibre.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <245cce4d379d225ab6794fc3326d95f88d2abf1a.1736201898.git.Jonathan.Santos@analog.com>
 <3de36de0-93ee-4ef3-a4a9-7a8f187eb4d8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de36de0-93ee-4ef3-a4a9-7a8f187eb4d8@baylibre.com>

On 01/07, David Lechner wrote:
> On 1/7/25 9:25 AM, Jonathan Santos wrote:
> > Use guard(mutex) from cleanup.h to remove most of the gotos and to make
> > the code simpler and less likely to fail due to forgetting to unlock
> > the resources.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> 
> ...
> 
> > @@ -484,7 +477,7 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
> >  	struct ad7768_state *st = iio_priv(indio_dev);
> >  	int ret;
> >  
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> >  
> >  	ret = spi_read(st->spi, &st->data.scan.chan, 3);
> >  	if (ret < 0)
> > @@ -495,7 +488,6 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
> >  
> >  err_unlock:
> 
> nit: also rename the label since it is no longer unlocking
> 
> >  	iio_trigger_notify_done(indio_dev->trig);
> > -	mutex_unlock(&st->lock);
> >  
> >  	return IRQ_HANDLED;
> >  }
> 
> I'm also wondering if we should just drop this lock. It is only protecting
> a triggered buffer SPI xfer and debugfs register access from happening at the
> same time.
> 
> Since we have to write a magic value to exit conversion mode, reading registers
> during a buffered read is going to cause problems anyway. So we could just
> remove the mutex lock and use iio_device_claim_direct_mode() instead in
> ad7768_reg_access().
>
Ok, that makes sense. I will change in the next version.


