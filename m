Return-Path: <linux-iio+bounces-21785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B9B0B63E
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00CE1898C06
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jul 2025 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E631F150B;
	Sun, 20 Jul 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akmDlGAT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7A4A0A;
	Sun, 20 Jul 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753018250; cv=none; b=I3satmbodt/7ZDsK31zCB6G8ZxKc9XvEgSSb+CNw+G8+DMdivLoIAGRZf9uEI6Y6PEhxtMi5h5czoJeCSbkCkQvkEn3Bql0Dj1Yyh4pRFaDk2TJkG6WijmOx80F+d42JFWTiXvtEguNmBo3wHHzwAD5sQZJBfBn3iS07dwTghrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753018250; c=relaxed/simple;
	bh=wxyJE/T5XPj12UbvZUUUuHdRwA5XH/tgWQV5cN6qGXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twoJtSak101Xu/g3xF4LoznhOGiNJVToM8A5VyhuNDr4odXFB6UH1PqdBDCnsbe5gEjBTm/YE2IBnoNSB+M853KGeeduP8TGBWjxwO/2rXjefp2n3P5VO3yyPN9kWct36EIFUsug2LTq0dPClUoQXulLU2hsgUPyITpH9QnQhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akmDlGAT; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87f74a28a86so4801944241.2;
        Sun, 20 Jul 2025 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753018247; x=1753623047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Dnw8Cv2YtZ1jbKupBbfaDX1MD5TLMG8atQd2GFrhr8=;
        b=akmDlGATiAlP6DTijq0ebJ89DvYAWBtSHoSPcZIVSF8aUPJm4qLr+nvRz3GcJlliOc
         49JQd6avXw80XQCmzOQ7qdjVLwTnPynAb5cEfK50t7XzBPhkjOb6mEPemjh/LL+JxVt+
         oK2rBzmQGjA7+QDKXbMEZVZ1NVut+Yhh/SID5LddDJomoWyHTlh+LWVr8UBevNxTbLiz
         GuZLGb24Gj2YyiGzt8NGdVm0d9SE6ZK2KzR/M7+f6q7FnsEIyuUnMRsg2mjYMeKO20Dd
         PaPzoEDhzzphqYYxX00rMJeVt81l478KSswEzvWkgVVrAiszqlT8gB2eDFQqYsWo1fVp
         LTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753018247; x=1753623047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Dnw8Cv2YtZ1jbKupBbfaDX1MD5TLMG8atQd2GFrhr8=;
        b=GnYevqsrBUlw0q9TglVeYGXZiwu1oz+F8/WdOWxWjPRXWwbKETuYlzmPyJx9/ZNBFS
         dlZIcV07HFyLxBukowPdCUP93KKWH8Jat1s0xYBwGmICPpSZDTpz4U0TpT6DB+uoSXIT
         C1lXdTZ8MKScC2zXKUDEdBzvY2uBQWIVX3vWLDr2JEba/cDLX7xZSVmN3fpwW0j21VmC
         3BjlcgAeS35PljqtCrEDXtTS8BQ8mZdceSytx2rIn+teAFlFxMPi6S3VtZSW2FUepTTs
         VBZZ1xrcVZ3kdJkO2hggrfBYG8i3Jcgt5Gd3s1xhYn2JTtY72FAOh+d8Hh0JT5xf7OfB
         w1mA==
X-Forwarded-Encrypted: i=1; AJvYcCV++IbHewuTB0C/JclqquV/j5qYjnVgKAsCUC11eE2QLsKwClwGWnXy4f+32WNQnZE1flHY1vbjgvq75uJc@vger.kernel.org, AJvYcCV0J/m4CKOEeXuVHVN02XHOuMy0K+dW7LKicXgs33CxPTSQW3dHCz2aR4TAoVNlHq/PxinIgx4aDLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1ln3axqlb1a5g2DC1bk4Hkxm+ffUMNtlUtenP4mLIOt9+dfO
	VGjgMqT8VNU6ZbpXaDEgQ02P5aO9YJ0PyLL7LedsAWLsAucGr98TjGk0llrHofSX
X-Gm-Gg: ASbGnct9twjz637HQ1mbvdn/Lrfdvx9RxOgMbZODR+gJ/w4+Uaa41CJD2S+/5HPuyRF
	J+5Cb355prL3Ils1x8HxMkTKBnaVzm4Mt/w4sgTLBC50raRvvq9W+S613l0GB8WD7PcBgWmtcpL
	rcXEaN2dvq2oMkv24BxZHctqq8uXs8tOH+L8SUTuurJFKhSyusqgeuPszLXpkAzeW6HgyMGPqia
	obJ2h/eCq5PCoVNKDSLmETBUQdSvR+JR0VcdskJxDTMG1rDSqe2PnrhOjjixmIa3MLkYf1yQ1sV
	whGjDveQ1W1I3UfOOJF/6nzoAgThfTGG8byXoFRpMowcNTOjdAcGJz5im/89NXS3S/4zkn4rvQD
	19VubzZGOjaAKTweaviHyS9bDTSTvwtfa9ISoWI2M
X-Google-Smtp-Source: AGHT+IGzWsJGTtWdEs0gGYgK7YJfX1LZKmOaErCiD97bfwGzxbGrsywa2HH4SXeJxnii5CgmR357vQ==
X-Received: by 2002:a05:6122:3190:b0:531:2f9f:8021 with SMTP id 71dfb90a1353d-5373e29d407mr9035354e0c.5.1753018247321;
        Sun, 20 Jul 2025 06:30:47 -0700 (PDT)
Received: from localhost ([2804:30c:b15:b200:425a:de22:1d7f:2d4b])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53765061c55sm2111987e0c.20.2025.07.20.06.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 06:30:45 -0700 (PDT)
Date: Sun, 20 Jul 2025 10:33:00 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] iio: adc: ad4170-4: Correctly update filter_fs after
 filter type change
Message-ID: <aHzwDHcmU23Er-35@debian-BULLSEYE-live-builder-AMD64>
References: <7b2fec30e9c6a80630a5fc08fb061d17417eb350.1752956751.git.marcelo.schmitt@analog.com>
 <43ed8918-0116-4e8b-943c-2e62906b1fdb@web.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43ed8918-0116-4e8b-943c-2e62906b1fdb@web.de>

On 07/20, Markus Elfring wrote:
> …
> > +++ b/drivers/iio/adc/ad4170-4.c
> > @@ -880,10 +880,12 @@ static int ad4170_set_filter_type(struct iio_dev *indio_dev,
> >  			return -EBUSY;
> >  
> >  		if (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
> > -			setup->filter_fs = clamp(val, AD4170_SINC3_MIN_FS,
> > +			setup->filter_fs = clamp(setup->filter_fs,
> > +						 AD4170_SINC3_MIN_FS,
> >  						 AD4170_SINC3_MAX_FS);
> >  		else
> > -			setup->filter_fs = clamp(val, AD4170_SINC5_MIN_FS,
> > +			setup->filter_fs = clamp(setup->filter_fs,
> > +						 AD4170_SINC5_MIN_FS,
> >  						 AD4170_SINC5_MAX_FS);
> >  
> >  		setup->filter &= ~AD4170_FILTER_FILTER_TYPE_MSK;
> 
> How do you think about to use the following code variant?
> 
> 		setup->filter_fs = (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
> 				   ? clamp(setup->filter_fs,
> 					   AD4170_SINC3_MIN_FS, AD4170_SINC3_MAX_FS)
> 				   : clamp(setup->filter_fs,
> 					   AD4170_SINC5_MIN_FS, AD4170_SINC5_MAX_FS);
> 
Looks good to me.
I'll send v2 with that.

Thanks,
Marcelo

