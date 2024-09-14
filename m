Return-Path: <linux-iio+bounces-9533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBB3978C32
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E55F1C24AB7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 00:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226434431;
	Sat, 14 Sep 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlCRdcQ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3D1C2E;
	Sat, 14 Sep 2024 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726273840; cv=none; b=Vjwlsd7VqB5GmQOlBfeUsI95blW4a4OxO/mmZFAMaxXkRV8pC349F32/YWI8E6jWGXkz+mA8gfHP8yTzwJbAekiNYUnsglquwY2lG3RHoMQ5SOX3KmQPNC73jWkyrKhT8mXMCVMCGiS2sIHij52QZx9GvreGCVw6ZEjo9T6QLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726273840; c=relaxed/simple;
	bh=VS/w9+FjOSUoGItTyb6HFFrmUwWWjlvcOqrGKD1tMZs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBeiJR0j67L6/HwfrchYZQ8qLJMk6I8AU+xyTCrP7cbQsQJ1Djp2qzQven/35Cgj0UBB2oS0JlAKQpNhgieiNmVwF5V7TgXI3OIRDYD0Utz6XKVLaNCfqd614XbvrJFSEcxgvDEetk6zIOIdc+4SDZDIbCB7d3e09SJfK0NSZ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlCRdcQ+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a81bd549eso310856766b.3;
        Fri, 13 Sep 2024 17:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726273837; x=1726878637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=clKYHVTnGLAXatAsDAW8Z/W+xhYAhmjTu2sFhcCtn5c=;
        b=LlCRdcQ+vIheFUjcS6hYCB28cd3CIHRbCgydWXMqm2iOwSeBzcZgvfTdAmFcO5z8Re
         4yf3gxdAF/rorXFbN3tSQpGTLkBVmemhbvJNLW+oCDHR98zOXk/+FktAOYqhY6s/BArw
         arrA+P9M5gtxv/DpB5RmCx+V/CvAFykSrCYGLRnxcyQRl36nScNOIs6HhjQIKA7WEBp9
         CB8xI5XlGQOzM3TOQ3vX5ze+IFogIOZ+SUADlTDtcIlW49lVn1zC+QyotAqgwhEdXYe1
         /fXDsyeeK+0ufyQSwDExbhvEamA0gm0BkOHZhrejDOMcKEYIfcj99P5ycXop48xyB9jI
         KD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726273837; x=1726878637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clKYHVTnGLAXatAsDAW8Z/W+xhYAhmjTu2sFhcCtn5c=;
        b=N/MY8U62NfxeqchmVvn5LtERLJBDR2u1jCqAX4sJsiIXtxCMZyLyQ2wMMcMTRauoo0
         YeGy7wkTZOagG9Z8rDCRjL9LxW9xvLtmqpUpNtyfhKS5amrj3025u3OKNlSxOeyweeuC
         wwv7QC/QAjUD9gndfnh4GwoAHaBlwEf2+VsxI4SvxVM2pzhePdTgCczd8AYenkIXBe2p
         UySgfinEj+PmQSXNZMNx7rwbDwiRU65INOHmlm6wj7s3CSjNFr7tTelVRi9M6m2vqZ8O
         ZLiYYffSh7MBPYJGPBSurZ+mzNuisgBx2MwbOUaUixmOHNhX6mYWN6KBp/wYbM60xRci
         Jerg==
X-Forwarded-Encrypted: i=1; AJvYcCUvO5YTycwRTNJfVeRga7EeY3MVopJowyjHbQDmMzUdAb3KASFAI5y7aq+8Ho19VqYJaJ3gp2UJCOqi@vger.kernel.org, AJvYcCX/F2YuSwTpVYW7CYdHKkUN6H5bashfrjKAJJ1X2MbSMgCFxzWPDpH/fcPlOMIGwsMUz01tgymWdn/T@vger.kernel.org, AJvYcCX07NkTZP308EfPyDPAfmN5P9rRVDBE7cWBnhAr5dEHbLGPsrGFb19/dF5zvI5t/nCOgbxeqDEI8xBxxAhP@vger.kernel.org
X-Gm-Message-State: AOJu0YzCr0ZBlqUa2wl1mNZEPP1B0asUHm690iGfFcO6USqT4PhrBJ2Q
	bu3SmQbAXoYS/mnHs9vLyDASef1nfHHTxrbVACwYzIJMKRtiUZf+
X-Google-Smtp-Source: AGHT+IG4d8Yu791E7Q7EQ/6vRRF+wpYQIQdFrDUsAQEc59Bzxh9bHGC+gm6CQ29WeAjVgFd7TjQAOw==
X-Received: by 2002:a17:907:f166:b0:a8d:2faf:d329 with SMTP id a640c23a62f3a-a90294ab58cmr809893066b.2.1726273837398;
        Fri, 13 Sep 2024 17:30:37 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:6bd1:9a24:6b02:4a8f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906133049csm14452266b.205.2024.09.13.17.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 17:30:36 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 14 Sep 2024 02:30:34 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v6 0/4] pressure: bmp280: Minor cleanup and interrupt
 support
Message-ID: <20240914003034.GD33362@vamoiridPC>
References: <20240912233234.45519-1-vassilisamir@gmail.com>
 <ZuQL845_lQhpNpSR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuQL845_lQhpNpSR@smile.fi.intel.com>

On Fri, Sep 13, 2024 at 12:54:59PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 13, 2024 at 01:32:30AM +0200, Vasileios Amoiridis wrote:
> > Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> for patches 1 & 3.
> Dunno if a couple of nit-picks warrants the v7, so I leave it to Jonathan to
> decide.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Hi Andy!

Thanks for the reviews! 

Jonathan, I just sent a v7 with these small changes so you can go and
pick up the v7!

Cheers,
Vasilis

