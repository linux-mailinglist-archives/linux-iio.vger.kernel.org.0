Return-Path: <linux-iio+bounces-22554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8A9B203BE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 11:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079AC3BCAF3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BC2DAFA0;
	Mon, 11 Aug 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnPTbA8O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28A3D561
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904720; cv=none; b=kbfc+O98PMQeVtj6L0nXjcRvpTENFPnbCUz97AWX8iTWK9AffpZ7g6y47b5wfrIAdtBUyJx2kqr7JRXjajfXiAEerV4/xp5OiKq5AEssRPsh6Q8H9RgXMuYcUIXanNwQDSHIQITRNIApAX8slLvRALkMCCgyQRGSwz05QtFq9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904720; c=relaxed/simple;
	bh=IrpdKR9yAkB3Rmpkil/9NeKbLdwS0olFlg8z52CbRtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3QV5DuQYdYwaIDMvUwlF1Glovc6+T2obxbTPRl2KIWQS+7FBev9vuplOsxjtlitnBPi0V1W0HLCb0Y5oeXsD83sLgtXucosxmBjNtH/dWFi9R10MJCsHJ5OJmQjidHr4lPSdBhhYUZYqRK6Fp0AwztAaZVMGH5zj5l3mMEBxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnPTbA8O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso26382975e9.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754904717; x=1755509517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n6xsH1EIu8qGRD0WnQaWksaV8nzdTGI17dmLq+Z5Q0Y=;
        b=DnPTbA8OdPhvQ4kdxRCa1RCLvbLIdLJXmqXH9u/PBoLLOUd8YOkY20aWfK3Pva/dQu
         tFdkOyNSuhZ7YnjZxtdc0BTi71820UefWEt1gjYZ+07ISkJsFXnuyUEUhc0lcy7i1W+r
         RUqiyK+JUmFckSrMEY+M6t4Q6TO1G8rQvD7FYNDNq6x4USlfpzjLpz7tmepvXa+IODVU
         AWd4IoeAaqCMwL27WOWmGX2Rb8vCASkzlBIMyegto9kWp98cmEXCjEuJkm3j5/bnI1OD
         2TMHQP6ZpO04HFue5JcE38fpU/H1+N7eIjypy9dZXqGYhqgGXWcOhsqMKrMsjh83j1BO
         2+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904717; x=1755509517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6xsH1EIu8qGRD0WnQaWksaV8nzdTGI17dmLq+Z5Q0Y=;
        b=o1HUtgAoncGTzwWxbgAC/TarYR/Va7dw6MO4Nl2PfKT3dXZbWJkLEhgJtb/opnneXv
         X7q6NIHNQYog4A431ZcrSHJVEtUuS3GJQsP6a4a1/4fqgMXA6yBNYXvsh158v42NWf8+
         /Y7/fQgXRBZV5u6VxAA2cGCxWEDxwcb1AfjdmQ0bv8zz2lZi1B4XtFfYQ1f+tksdz325
         rn13vNtWDb3pxE/6GhcrQnf9cRx/yCEIfwSoejw72M/70J0CIctWuU9kjqEs+vr8X1T5
         M82q+SvdkGSlfQBTSySEwhv3aEz8WfZ2qkwQm042HwTaqkTzkiktAViB9Al5VS8Z9Nso
         xc0w==
X-Forwarded-Encrypted: i=1; AJvYcCXpcLfFF5QZOCHFWX1Cal00/V9d3I7oEmxGKLBZVFgkshwdNSzQ7QvblVHyqodhpXJvV0J998EXds4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8txt8JKU4yivXN7zXWK5kgaI+k/HuTm+OJOYkvSt0yxZmqghK
	kCHOxccyqzD6HfXBkN8fwuhTlfmahtLu/jk+CrbLe9fzKtLQh3YHmnKAZIa9SLe7qYq72w==
X-Gm-Gg: ASbGncu5q9UdQO2TqsdT201g5vzOa6KvHnwgeMxjveEhDnvo90BuEeWNyPLdKC+QT0Q
	mrwyopJ51g/hbxVOM8uH6/yapSW4lbIiS9Xgn7RxTSnJjxsiDPITQogrKE/HKoYoqpeJzeytjL5
	0i1y65sMqCcl8lEvvIRSDeUmCWtWesmPQZz4c24bgStEmdbbEEseMgQkWCEGZSkyaqtretJrjlV
	umWe733QWWI5kOxXWtTWqY6tzg7+ipIgDIsbcn8BzidoFvZi++9WnwQSbMqZqtz/phlV1u2dI85
	i4WNzPSfyyS5p7m+b+2KkYIck8wG3shDlk+MNVchW28r6Dov171aQ0iVd1R/AK3xuwZ5eu6k95x
	fFXpH3gROvP2oXQ==
X-Google-Smtp-Source: AGHT+IEBYkXJl+51kUZQSZXlODH5bwxqbOklhXh4qqZRzvx0ZohGDp10Yl1rxnXx4KtJdwNw2KSlSA==
X-Received: by 2002:a05:600c:4511:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-459f4f5474bmr93131955e9.33.1754904716337;
        Mon, 11 Aug 2025 02:31:56 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0a24bf1sm270166585e9.1.2025.08.11.02.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:31:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:32:13 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>, 
	nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
Message-ID: <35fvtdf3esopbs6lt5ps727blc4hj2iyhxvwevmwp7ofomojhx@mcvesuzn4nql>
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
 <20250809185207.04a3665e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250809185207.04a3665e@jic23-huawei>

On Sat, Aug 09, 2025 at 06:52:07PM +0100, Jonathan Cameron wrote:
> On Fri, 08 Aug 2025 17:09:42 +0100
> Nuno Sá via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> 
> > From: Michael Hennerich <michael.hennerich@analog.com>
> > 
> > The ADF4350/1 features a programmable dual-modulus prescaler of 4/5 or 8/9.
> > When set to 4/5, the maximum RF frequency allowed is 3 GHz.
> > Therefore, when operating the ADF4351 above 3 GHz, this must be set to 8/9.
> > In this context not the RF output frequency is meant
> > - it's the VCO frequency.
> > 
> > Therefore move the prescaler selection after we derived the VCO frequency
> > from the desired RF output frequency.
> > 
> > This BUG may have caused PLL lock instabilities when operating the VCO at
> > the very high range close to 4.4 GHz.
> > 
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> 
> Fixes tag?

Oh right! I'll resend and include another outstanding fix I noticed in
ADI fork.

- Nuno Sá
> 
> > ---
> > The Signed-off is because I'm just carrying Michael's patch without any
> > change from me.
> > ---
> >  drivers/iio/frequency/adf4350.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> > index 47f1c7e9efa9f425a4c7cf82be930234e2c18434..2b8b935965ed4536bda835844ed6c7d0a7b88330 100644
> > --- a/drivers/iio/frequency/adf4350.c
> > +++ b/drivers/iio/frequency/adf4350.c
> > @@ -149,6 +149,13 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
> >  	if (freq > ADF4350_MAX_OUT_FREQ || freq < st->min_out_freq)
> >  		return -EINVAL;
> >  
> > +	st->r4_rf_div_sel = 0;
> > +
> > +	while (freq < ADF4350_MIN_VCO_FREQ) {
> > +		freq <<= 1;
> > +		st->r4_rf_div_sel++;
> > +	}
> > +
> >  	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
> >  		prescaler = ADF4350_REG1_PRESCALER;
> >  		mdiv = 75;
> > @@ -157,13 +164,6 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
> >  		mdiv = 23;
> >  	}
> >  
> > -	st->r4_rf_div_sel = 0;
> > -
> > -	while (freq < ADF4350_MIN_VCO_FREQ) {
> > -		freq <<= 1;
> > -		st->r4_rf_div_sel++;
> > -	}
> > -
> >  	/*
> >  	 * Allow a predefined reference division factor
> >  	 * if not set, compute our own
> > 
> > ---
> > base-commit: 6408dba154079656d069a6a25fb3a8954959474c
> > change-id: 20250808-adf4350-fix-3e0b9b7c3420
> > --
> > 
> > Thanks!
> > - Nuno Sá
> > 
> > 
> > 
> 

