Return-Path: <linux-iio+bounces-9132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2C796B883
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 12:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFED1C21C55
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17921CF5F5;
	Wed,  4 Sep 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApYbdXhc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90E1372;
	Wed,  4 Sep 2024 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445772; cv=none; b=RufJc6N6CHUl5FwTc/wMmoNo7KUTequxjgWqU9aNXMSGtp3FmXbsdRhZI/GGdB3uA2fgjW/u27vUzKK9jppXAIR5m/CR05bugPURvRqaiXyUCGpvOnRWWCzAW3kZvzsr9mRxkk+22lOiMZmmaJAp1N/qRAOI3iPXfP8C/FusFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445772; c=relaxed/simple;
	bh=WESWS6SFM3t62aROJYgTyzZWIaghXHWlfb72zgAZ7aM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3UuD9gEVwcKVw1GY+L3/+p/ghZ/fwU5TpmI+6ApC9p7HU9ljF/s0yuPmD1LYAG+BqJldjwwkgPPyxVjimiJ7sxkG/MzkgomhNPk/oZwGFEndcOvH9Ma76Y8aylXcnOPH7nPrwPs4qWaKgkNuIZ48nTsoXi9oSgxvH/q2v7tpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApYbdXhc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-533de5a88f8so6559801e87.3;
        Wed, 04 Sep 2024 03:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725445769; x=1726050569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/Tmvx+WxBWtbnthaV/pa6veShIONRZAzv3Z9JQuzD8=;
        b=ApYbdXhc1jZf91vwfhl3ppyBlpSLhA1pC4CwcSXx6tfPMvcsIgWdVpk4+TB/UDsm0d
         Ud1RBaaZWS/dy+DssAJBsyKqHG4JJfWp9Orn/GQLVaCvKrUTW93rFts5TyJOXqi4Qeja
         VIWKB1yguVtZrf+QZxQgA/ILzH/SmojENcSW6giM+DiWYNjnzFyM7BZ/FyiUToHUEnDk
         TIszBZqFgUH4QhW21vUfZdv2fhx99mEwVPvE1M8YSvEk1VH5YR6pJk1R5+SmfVxR+Ozj
         3TiPnkXf6n8khn2VlX2/9E+bu+neuKGV5tBZhW3sOfwY/rbdaOX0mAHCazDZ2b4hgRcd
         I9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445769; x=1726050569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/Tmvx+WxBWtbnthaV/pa6veShIONRZAzv3Z9JQuzD8=;
        b=gNQti7/J0NkZDpUmzuIdKqOUClaEV5v0fAskAOomVe82iVOxfWhu7rt2tiZdv9osfR
         XFScZyNrBGgknyKGoFinAuXde4lq+fmRQ4Xze2Q5DFTZAQy83q6GBvfuK6UFgyA6NYwZ
         +eU/OVevYaJ2UaPh27ATZCQuz3J2E0qOZp8JwJp/+DgDHrrPazC/hUUj/SZejF3LdMJq
         FA61M+F7RqaeRHOGslAPpblJj1blCf0dSsXrvONRyDlld5mrJVAJupzX1Kg8tCH5/5X/
         L0b1gBwc2jCJZJethIwg7RkeDlh735NOAIa5Jrc0UBr1OrYQy5tzeAHWpBMwfL2VW951
         2wFw==
X-Forwarded-Encrypted: i=1; AJvYcCUkyW1xpt0y/mtme8nM3AHaUopPiWt3YjR/pRbhcNNkyxN+2H+T25x5xTCovjn6xHdklSaTlL07SFcoHi+t@vger.kernel.org, AJvYcCW1m2CfC3FqNpsIg2YebPESTp3EKlo7G1qzrYe2pY9fZzKPjGFSisZbCVJyT9kPy0EoT9sNhe8uNiBG@vger.kernel.org, AJvYcCWIPhSqMG7LNlb/fakTO7f6goDAdD9IDXQuLCukdbbGWCQgiksljA3QIG/O1Y5tHuaa5/qKvRC2KegE@vger.kernel.org
X-Gm-Message-State: AOJu0YwQwTHSifOhejiDVSQBQ2YT32/4IQEkrLECELTE1M5oENq9qCdK
	aSw6vQWQ0JQxvwzkKZcVKbiEq8EWmlb94dPjJos4VBMOgLDHQI0a
X-Google-Smtp-Source: AGHT+IHN4NICXwhoNEGwHHFHDZb1kvJDi9A42mZMIDtarOvCZTzHjFVzZokkRcwYynH5aZMHGvgdIA==
X-Received: by 2002:a05:6512:1088:b0:533:482f:afbe with SMTP id 2adb3069b0e04-53546b23dfemr12010523e87.24.1725445767884;
        Wed, 04 Sep 2024 03:29:27 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891dbf2csm778958466b.186.2024.09.04.03.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:29:27 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 4 Sep 2024 12:29:25 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 7/7] iio: pressure: bmp280: Move bmp085 interrupt to
 new configuration
Message-ID: <20240904102925.GC44250@vamoiridPC>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-8-vassilisamir@gmail.com>
 <Ztcfs3Pvy9tzIFNm@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztcfs3Pvy9tzIFNm@smile.fi.intel.com>

On Tue, Sep 03, 2024 at 05:39:47PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 02, 2024 at 08:42:22PM +0200, Vasileios Amoiridis wrote:
> > This commit intends to add the old BMP085 sensor to the new IRQ interface
> > of the driver for consistence. No functional changes intended.
> > 
> > The BMP085 sensor is equivalent with the BMP180 with the only difference of
> > BMP085 having an extra interrupt pin to inform about an End of Conversion.
> 
> This one also LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Thanks a lot for this!

> ...
> 
> > -	int ret;
> > +	int ret, irq;
> 
> I'm not fan of such a churn, meaning a new variable just on the new line to
> make diff less noisy, but it's not a big deal at all.
> 

I understand why, but at some point someone else would have come and make
a new commit probably with "organise/cleanup variable assignments"...

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Cheers,
Vasilis

