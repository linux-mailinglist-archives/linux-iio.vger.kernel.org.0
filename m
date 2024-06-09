Return-Path: <linux-iio+bounces-6110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E79015EB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 13:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60502B211B3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F122626;
	Sun,  9 Jun 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6QzuTIi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17D23749;
	Sun,  9 Jun 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717931893; cv=none; b=Ck/aW81JRKWe19xBtGi6OD1nH0LOHybrNW3yMnXseHZrUo4RiTe3HXMr0qkUYxwBGhsi/R9C1R943wXoncb0r5va5+dpQOHRwdUhkxAxQnvZIIDvh1O1oKhy2Ei+J4R4L0INWh7xgAN7hySknAfLYlt8P3HaNlfXA3B+qXF+kFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717931893; c=relaxed/simple;
	bh=ohMGBC/Z0BYQnKSCNwBKVz4t58YWkzIyQ41yr2RChnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M40VG7s/fUp2GOh8rFX83cCN3vfd2lWIYWBBTYwGIpPfbksGBOC51M3OzrbAO1fkPvDTVYO31tjOK5XnHG7S6EiNNTEay6gLy8TwF446s2Xed9WvXTMVNPhtOFSCGunSs5tCGuP4Y03yHKpSd/5UK9H3oAVPVvsuWxw138CtR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6QzuTIi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f1691b18fso703559f8f.2;
        Sun, 09 Jun 2024 04:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717931890; x=1718536690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GcY4YfSQCSCBOUPAsOEdbHmD7gb7ALNN90cfps1YjtQ=;
        b=e6QzuTIiHz4uQVxXxWo7ykYrYYzz8xrPeikSCsXq4Z6Z/0c+th6iiZR9bjGND2vJL0
         7RNS9mMWVXeMtwd3S/FM9V99qsa1SUFXKCKQEblwgm3IBmKcyCRy2L4uvkUvJL1GTxhu
         BfMgt9MzB6znsumRUhn+wM8lrAZ9KOApXBVdt75skVW0WUwVt5HrsuT87k9CDsYpaEH6
         QexDpYMsjaI5ymv3ExD+evKwUlzK57odSZwqFhONScTG6pXFBWmsdTxw653nM6kpYRpr
         zR64n7h2yKSDb99pqSKGNdq5QDrBI2zc6MtRGe/xNfwukeO+TZiYkHBIrgkwZdFdZiP5
         DLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717931890; x=1718536690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcY4YfSQCSCBOUPAsOEdbHmD7gb7ALNN90cfps1YjtQ=;
        b=SNPbu+YoaHB+ngyI0bE0YlC6SQiaRdDhCQ5TOrpEx41HdpqPaBKT9ZS8z+gbhoJepK
         zQaJC78xQdm6sfVheXTKItzRsftcebdSI7EOJals1wr3GyISKHqPtReYlYxF2LekvB0R
         58tvv5+6bGTRemFdpTFx72Bif5PfWcUMgnhikcma9a8d0lxJ0Qm1UOFME1X3dAlDapEM
         tyS5oSCpw5Qh5YqmCHHWks9MAUoA2+FrkYiYCl7D9bhYSONGXVt0mlhMrNSrUsyuzPYT
         3jmgTvpkI9rGDzJclCYHGy2311yYjlsR/En6KtrSWc5Tyrj4cvAKvu5Z1VMROWjnaypj
         fC2g==
X-Forwarded-Encrypted: i=1; AJvYcCUmhyaNZmHyXauYODZfjUP5WN8eOG2wn9ix13b2axpOe69HDDeNRvUIVqMFbqlH9rWh0do9OESF2QgnCrWV283ih8bAdDz001I5CsHhAls+FYSeL+i/OKRvNKIqO/MMr+a0Mb3m3qb7
X-Gm-Message-State: AOJu0YxVcguiuFoP+19q9P7p/ZhJG0M9WppfPhIYf0Z5ve4GgDHld57Z
	rtdLY4XJSfPVi0PxsjKYb51pdSteUU8D1Jey7IlPoIVmEL2GVYJz
X-Google-Smtp-Source: AGHT+IH7fizIO7+KGdLojrBhAT/XzIP+DHX2gtOXRoL6CLDGNLusaiuQBPb6eVGX4dV11H/qbh8g4w==
X-Received: by 2002:adf:e809:0:b0:35f:1d7a:c41c with SMTP id ffacd0b85a97d-35f1d7ace13mr1470137f8f.60.1717931889894;
        Sun, 09 Jun 2024 04:18:09 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0b876d80sm5258304f8f.109.2024.06.09.04.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 04:18:09 -0700 (PDT)
Date: Sun, 9 Jun 2024 13:18:06 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: humidity: hdc3020: fix hysteresis representation
Message-ID: <20240609111806.GA107509@debian>
References: <20240605192136.38146-1-dima.fedrau@gmail.com>
 <6481f8ab-5082-4952-a29c-075a57239472@gmail.com>
 <20240609110558.0fd08074@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609110558.0fd08074@jic23-huawei>

Am Sun, Jun 09, 2024 at 11:05:58AM +0100 schrieb Jonathan Cameron:
> On Thu, 6 Jun 2024 16:34:39 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
> > On 05/06/2024 21:21, Dimitri Fedrau wrote:
> > > According to the ABI docs hysteresis values are represented as offsets to
> > > threshold values. Current implementation represents hysteresis values as
> > > absolute values which is wrong. Nevertheless the device stores them as
> > > absolute values and the datasheet refers to them as clear thresholds. Fix
> > > the reading and writing of hysteresis values by including thresholds into
> > > calculations. Hysteresis values that result in threshold clear values
> > > that are out of limits will be truncated.
> > > 
> > > To check that the threshold clear values are correct, registers are read
> > > out using i2ctransfer and the corresponding temperature and relative
> > > humidity thresholds are calculated using the formulas in the datasheet.
> > > 
> > > Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > ---
> > > 
> > > Changes in V3:
> > >   - Add missing changes
> > >   - Remove math.h, already included in math64.h
> > >   - Drop range comments
> > >   - Fix typo devide divide
> > >   - Add empty line before return in hdc3020_write_thresh
> > >   - Keep hysteresis value when changing the threshold
> > > 
> > > ---
> > >  drivers/iio/humidity/hdc3020.c | 325 +++++++++++++++++++++++++--------
> > >  1 file changed, 249 insertions(+), 76 deletions(-)
> > > 
> > > diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> > > index cdc4789213ba..cf00999b826d 100644
> > > --- a/drivers/iio/humidity/hdc3020.c
> > > +++ b/drivers/iio/humidity/hdc3020.c
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/i2c.h>
> > >  #include <linux/init.h>
> > >  #include <linux/interrupt.h>
> > > +#include <linux/math64.h>
> > >  #include <linux/module.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/pm.h>
> > > @@ -66,8 +67,10 @@
> > >  
> > >  #define HDC3020_CRC8_POLYNOMIAL		0x31
> > >  
> > > -#define HDC3020_MIN_TEMP		-40
> > > -#define HDC3020_MAX_TEMP		125
> > > +#define HDC3020_MIN_TEMP_MICRO		-39872968
> > > +#define HDC3020_MAX_TEMP_MICRO		124875639
> > > +#define HDC3020_MAX_TEMP_HYST_MICRO	164748607
> > > +#define HDC3020_MAX_HUM_MICRO		99220264
> > >  
> > >  struct hdc3020_data {
> > >  	struct i2c_client *client;
> > > @@ -368,6 +371,105 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
> > >  	return -EINVAL;
> > >  }
> > >    
> > 
> > Nit: "thresh" instead of "tresh" (applies to several lines of your patch).
> I fixed that up whilst applying.
> > 
> > > +static int hdc3020_tresh_get_temp(u16 thresh)
> > > +{
> > > +	int temp;
> > > +
> > > +	/*  
> > 
> > 
> > Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > 
> Applied to the fixes-togreg branch of iio.git and marked for stable.
> 
> Thanks,
> 
> Jonathan
> 
> 

Hi Jonathan,

thanks for fixing this.

Dimitri

