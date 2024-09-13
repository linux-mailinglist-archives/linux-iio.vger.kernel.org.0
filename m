Return-Path: <linux-iio+bounces-9527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8A7978C04
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 01:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B071C24B30
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 23:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879618893D;
	Fri, 13 Sep 2024 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+VSiZ2A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAB26289;
	Fri, 13 Sep 2024 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726271995; cv=none; b=t4JKwBU7nB98fCSjhU0oEnBDfzxvTC6dAmhptpcI/a83UKrxvef2GtLpnsTx9c6ofKsGeCm2vRb3PP1/45FKECZCkWAIKOdqDD8MWM5UVTkRBxr4oogckvyfB1L8r8qxrXmzdroS3e/yN4tPWO3p48pRXmL7xx22Wkh9jp0nUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726271995; c=relaxed/simple;
	bh=PyEsfkEt9advumn6WUAh2n50qARD97tmon+xhoApBHs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQwifMz62kf8OkWprcSdDSH2LBxK9Ijk3IA/ibW21tyFeXRXofD+jZHuKKomDbs3YMeMPtSIgni4KqfCIe3fbsGFd1lQb6IvMG9PtVYGxsmLXr0rX21Ocf43wkuWov0HrYDkttaJVeR/lXCDHRD6/72sAjNWdoa8pwps7j02kDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+VSiZ2A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so16849345e9.1;
        Fri, 13 Sep 2024 16:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726271992; x=1726876792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULBT/bpFrGmtnm47miXVx8/+nItielIS0X8vYYWItlo=;
        b=e+VSiZ2AuwTzz9QyN//j0/7aSAYHnx5oNIGcnBJlTVpInZ+U5IhpZWCtXH3Kc0KoDq
         qnT+Hwl561d2j8Lu/GGFypprqTeNJh3As4nvWzgrlz7zQYbsM+r1YpeH6hCZrdVPXk8V
         BeV5m29Z6i816uniuVCfiuD7B815Yi9Tb67DwJgVq1xIMvZnDIMrMyNJlnOqO/4jNQwT
         cKphC8K5VGmwQe46T5xPjMBNAAOdWeHjfAtJawLo39zGUmf/qBWHHfvHWzM/PRhG6qhM
         b3SuB7R8rjWQv7rQtKpaJt2b7fxukJwkDQ6lHFZbWD99YDx+4klaIMr77KmvuiJ1gX2I
         Lozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726271992; x=1726876792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULBT/bpFrGmtnm47miXVx8/+nItielIS0X8vYYWItlo=;
        b=UryusCBdolQps7LHmZNeF0zvoBdHbDmZ09bu+FWuaP8jeARkbtPDgfYt7xpRRMzZs+
         Btb9bbA/NXYbTtHZuLGIA63denjoxC4JEvCjPpMMO9wFN8GC1dFFKIPlJAtCDZEQ322R
         CaDLaGdC6hZ4nnD0CQpVsOwDyBUZQuJcDxJIc/ne4gZxtIjmprKjhxaCqZWA/usv6Xa4
         i/XfG68TTr2dcLyJ95nAPAWFX38Ik53WkKyJ/Wbv7BeIn7YXvUGaMlRtgZnF/tiJboiT
         39KePlplPvcxzkxXi8q0jL5FZrOKnGchOARcdBkqDkL476huJ1U6gMeTGu2bi/IHKVH9
         6nBA==
X-Forwarded-Encrypted: i=1; AJvYcCVLFQa6+0PjZ9nIJpFx7k2yhi4L6sbyH9fL8XE1cbfhFvmyl7OiL/AInyeHlja5E5Sqi8LKL+0ldm/N@vger.kernel.org, AJvYcCVwXzoQRf6xxed/urIi3hmh3vOSuHn+NnEPpU6wnCFBBgrxvJgk2K2JqQ97V0d/vYBFCyBojo3xAJvi@vger.kernel.org, AJvYcCXxjCIu79Ac9HN9pm33sO8J4PXDSpOe6ejDVg0anbsWJ6k0xyXJGaJQ+tzTJfpF9i3rSNrNnfMIAT13cJ88@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1+KJ4HUCZ8OLgBsK08IWssMtKWLL3JnbFGVkXFCUd4cH4/R6
	L7p9zB8p+fQ6im1/vR7Z2M+zvxGOb3PkKqKyqG979vcyNfLqIAVf
X-Google-Smtp-Source: AGHT+IHkmiW+QGjdz4SgT9ccPQDc1ak3XHnf/DlHxkQHuqASZNTTHd/WvArY8ccXFoWSg22/Aley7A==
X-Received: by 2002:a05:600c:1ca7:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-42cbddb8169mr92218085e9.4.1726271991892;
        Fri, 13 Sep 2024 16:59:51 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:6bd1:9a24:6b02:4a8f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22e6540sm4465575e9.21.2024.09.13.16.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:59:51 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 14 Sep 2024 01:59:49 +0200
To: Conor Dooley <conor@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v6 2/4] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <20240913235949.GC33362@vamoiridPC>
References: <20240912233234.45519-1-vassilisamir@gmail.com>
 <20240912233234.45519-3-vassilisamir@gmail.com>
 <20240913-overarch-preplan-c899f16a90c8@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-overarch-preplan-c899f16a90c8@spud>

On Fri, Sep 13, 2024 at 07:27:29PM +0100, Conor Dooley wrote:
> On Fri, Sep 13, 2024 at 01:32:32AM +0200, Vasileios Amoiridis wrote:
> > Add interrupt options for BMP3xx and BMP5xx devices as well.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  .../bindings/iio/pressure/bmp085.yaml         | 22 ++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > index 6fda887ee9d4..7c9d85be9008 100644
> > --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > @@ -48,14 +48,34 @@ properties:
> >  
> >    interrupts:
> >      description:
> > -      interrupt mapping for IRQ (BMP085 only)
> > +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
> 
> If you respin, you can drop the description entirely, since you've added
> proper enforcement below.
> 
> Otherwise,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
> 

Hi Conor,

Thanks for the time to review this, I will try to see if I can do it
tonight, thanks!

Cheers,
Vasilis

