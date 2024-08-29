Return-Path: <linux-iio+bounces-8887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F02964EAC
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 21:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104471F2395A
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 19:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D881B86F2;
	Thu, 29 Aug 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSm1pKXK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75FC15C120;
	Thu, 29 Aug 2024 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959265; cv=none; b=I8/gT1U8smbfY44aZOQinq4E1s/zD+IzRE5eb9oRs7Kvp8TgjCiHVrU2stTB+rTQO+fZpdm16StbJdU/Pi5gKYVzUtR2tkSlbIeXjiag2eMi7NIBrkPEUNbsyFlZHAcfzDQhBpnzn2tCp7tRoAzUygFRWGK0GMKbsVWnCkQRsDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959265; c=relaxed/simple;
	bh=Vp1qB20cuMajvScwvgMFDf0ulKthS9o/i8HUa8YCm9o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnzphzyOOQ7dt4VFO5g0DXfXJDMwz8rkQOf8NYxFJcMHClpkCxtmHviV5oFzCENNp/IY7o6/i+iuUJqXRyHfoPphzl39luS+iPK7yWnfPns8CF0QXLiKTAriA0S67mthv9NHBjgvcbVpnWUx1eiRDNLxlv/NBFjukKayrZdGcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSm1pKXK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86abbd68ffso186859066b.0;
        Thu, 29 Aug 2024 12:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724959262; x=1725564062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeqLZUViP/M2fWypwbzzLo+n65w3geFe/ERw4JEFtxI=;
        b=NSm1pKXKtGl1s/dpNvrP2821pO1wHo89dcB2Hk0yph6jtWJdjl7datMgebWY/WzZOD
         LJtbIpyuu0qxkVEPLuu2oGwxFwpaSIP8t4xIHhvtJ1axA/KEWmmw2F59upt4985QLgp5
         tY5Wp2J7+UEMrooH/B7aVy+Ne8qiBTwrHPimyZoxnuUaB/nXU2VRGpBcXseHmjzzd3vz
         IITIOEqm3Asf1U2Sk6oS2eMN8pO7hqKptqGdhCjJJwsPcxMh9pTNo8Td9oIhpfdlv7XY
         fFX1G/R+v5BI6UVhq5b4/Hpli1wcsNKqgnpUK0dAXwtHuBNMUKpKnY1B0Rki51vjpaXE
         0uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959262; x=1725564062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeqLZUViP/M2fWypwbzzLo+n65w3geFe/ERw4JEFtxI=;
        b=sh7pgygWI4kJ7nehU0kVrL7OR33MGNF7737gAb90LwY+lQ66h/uIGIbH9qsGadz7QK
         XCDJsy5viBdvaC/xr7ADJcroHPth2ShVfMgHX3bg8uYUlEncocjCE5J+MBCAMKsTnbvR
         z05ZuRG5XexVvhv3O8KjQRlmz5jIvtr83HPFqh0qccEj01wOe7gczxBT6wXYgyk5KMKY
         Ren9W7MK7im/CSSzaW8oMEPjEC669F7H0cJZCEzvhnbGduip4K15zNbCVJIQc9oS5prp
         PRTfGColCnE0b/wJUfuZte/7pHHP4DyljP5BZwiiocgqiiuLh7S7hKJfsiMiPjOmIYHd
         GlSA==
X-Forwarded-Encrypted: i=1; AJvYcCUL/mD+n8jLvFmZp+C1gRc4H8auf84+PN62DklUj+oIah4aQZKWo1TxOl/xo7TEh5R5UwBPxEujwDsa@vger.kernel.org, AJvYcCUUSQIFNyVa6rq63rUxQCoc7f7qWfe3l6MGiXuXyNdbG1pn9W6/ZvmCuX5KZcfMc3O3jsY40v4UYJmCwSkv@vger.kernel.org, AJvYcCUgK0TL83osAdrOz47ak1d4lmMXtCjH1VS/wbiSNW/RcGKc3qsdmNB/2Izo+J8VXHVW3Pj+9sqmAd1D@vger.kernel.org
X-Gm-Message-State: AOJu0YwOqV5FANbIy4Ir9Pw4f6jszZigEfsA8ggPmJ/xVRgx7aIxFGSq
	17EiG0dHaVIyOMR7Ig9ht3at6y2rY2YdaTOju+jlLTwB4p/j8PJN
X-Google-Smtp-Source: AGHT+IG8YD0R6ddz7qFemzsqM8yiq6wM14ulNUNxnIIFq1K89tnP5WkWaYgzFAOBJyJWtuBsuq5wdA==
X-Received: by 2002:a17:907:da5:b0:a7a:130e:fb6e with SMTP id a640c23a62f3a-a898259d4f2mr375092066b.15.1724959261404;
        Thu, 29 Aug 2024 12:21:01 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:f22f:934f:9b88:e7ce])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989221c63sm110342466b.201.2024.08.29.12.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:21:01 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 29 Aug 2024 21:20:59 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 7/7] iio: pressure: bmp280: Move bmp085 interrupt to
 new configuration
Message-ID: <20240829192059.GF3493@vamoiridPC>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-8-vassilisamir@gmail.com>
 <ZtBsmSGWLhNe8_Zw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBsmSGWLhNe8_Zw@smile.fi.intel.com>

On Thu, Aug 29, 2024 at 03:42:01PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 28, 2024 at 10:51:27PM +0200, Vasileios Amoiridis wrote:
> > This commit intends to add the old BMP085 sensor to the new IRQ interface
> > of the driver for consistence. No functional changes intended.
> > 
> > The BMP085 sensor is equivalent with the BMP180 with the only difference of
> > BMP085 having an extra interrupt pin to inform about an End of Conversion.
> 
> ...
> 
> > +static int bmp085_trigger_probe(struct iio_dev *indio_dev)
> >  {
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	struct device *dev = data->dev;
> >  	unsigned long irq_trig;
> > -	int ret;
> > +	int ret, irq;
> > +
> > +	irq = fwnode_irq_get(dev_fwnode(data->dev), 0);
> 
> You have dev, use it!

ACK.

> 
> > +	if (irq < 0)
> > +		return dev_err_probe(data->dev, irq, "No interrupt found.\n");
> 
> Ditto!
> 

ACK.

Thanks again Andy for the review, it's highly appreciated!!!

Cheers,
Vasilis

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

