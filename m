Return-Path: <linux-iio+bounces-10472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689BA99ABA3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 20:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B38B23DE4
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB941CFECE;
	Fri, 11 Oct 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8yK5X/z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B631C68AC;
	Fri, 11 Oct 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672810; cv=none; b=QrVav/CNNN+BN7eyUK6JJKAmMFyRfd3BeznRrrnBxlWkXbE5ksljCRvWnX+HwtCa0NjP+y8TRbzq/hDiAemQaWmz6hNGww6t0jxjGXdEz+doNp9iIoqALXjkQkQh4K3O2cEQRdB8SnIlJHuffK/ci0lpEj1+HWDAf/J3fR5oh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672810; c=relaxed/simple;
	bh=wO52izhtaJkYwZP5/i4Xv7aOxNp/1BOGcLs4pvwgzC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP3P+v6tVre095HyDfqT+n4HHyBBLAbraHQw4Yj47j/dkf1k7zH5qMgfLjUrIWFbcsXQWRmD8FX/A7HQRA9wjby03oTELXUPNnyd11O/51nsdlB5RlFVXOLx5MQXSDt2yaw+RXXHdn1H84UeZLqtWtlTPXhMdUMTR9SfUNy8Ln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8yK5X/z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e3f35268so538847e87.3;
        Fri, 11 Oct 2024 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728672806; x=1729277606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHtdR9gh6gLJx+S+TYBCPLzeRCEOaHqzDMFEdyNLr/w=;
        b=h8yK5X/zUlTP2z8LFLFXCLQ6qFBI2sLVfFt6siZ2mTTYu+m2l3MSvKxIuimDQmBMfG
         z96bRpypYseifQXtkXyFQFQYHTpOSczQri0qTiAR6bKaO2bART9eAYp/rKWU8qRy8Psg
         jLRr8qhJ6jgRDhCIj3gHRwQy2YsOK9qKydpCzl8B13l+6jrMHn4jemRYKhrINuUOzH+r
         +EpyLJO71OqRoetn5P5Mc91QmW2MQlHcm9FC8F1cnkrpXc/tVIwZZu3bzyLXIBNgBqDj
         DCSkJNQmuJech/g0mOCNNJ12LMHpN1n27nuGSQe6QcapdMqayC9Y/T/gUdGt+0kFWnuP
         ds2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672806; x=1729277606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHtdR9gh6gLJx+S+TYBCPLzeRCEOaHqzDMFEdyNLr/w=;
        b=hSuGSOPLtpxKmkhO8YcfVxGLrQR1oK3V4pfcS1puf26Lus1su7AomCe5pb718P8kqN
         HVpzi1zpgnYDoWSbqs5kv5isN9ckE7UKQ12Fa+TCPSq+aTCncFOGSrNIHUjVeanKQnvW
         YhLr7EwTyFsTgX9nLPZTUeHAITMf7yd70g149GPAqO+YD/hnoXQ16z3yJVJVhkA8kaxK
         ILWV3EarYHf+TesMDYppEQ/6r/QdcBQ4k5gGNksafM1EVqQN5Zdw1T3RWD0utzsG04uL
         zXA5CkdMvtWkV1vMX8wDWMBi3EFT/Y6FvNMrF8kf3WjgLOe0ov2N1GlJcKsw+UEC4JfY
         Gm9A==
X-Forwarded-Encrypted: i=1; AJvYcCUuAD2fDtpwrF4h8oXv7Agmqfb4OWrVU49l17g2hN3Z2pE67leM+7BHYwUUS20T7fM+zXYoBlSIEHIv@vger.kernel.org, AJvYcCVbuORXhtsDOGITpQgv0BeEsNiP33YnAKRllGDs0un+yGUtlVVugjLtQZUPR+KMyytk6rpQiJ4Ys/nSWxj6@vger.kernel.org, AJvYcCVjFAsoiefAlJun0s9zxpDoucgYSO6VpQJ98Cuq3Gf2tB1umw9CIpNIE1smFPw7Xab/48VYDsnetvup@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBUZhxylfJfDUOG8X1bYbnZOAH3/x86CvIUAnDuOjkUituv8r
	K9Ip9qPCBvXMhSQwaGUzlrfiYMUxb7gx/aH7uFE6fkxkUEPcgVA5gndMNGCeX4w=
X-Google-Smtp-Source: AGHT+IH3mQrDWOhMaio0jKUTNt1PDvpFsvG5xMJPLXivdzWr7Pe9AF5R7p6TIiO7uYasJ8Md2mytPg==
X-Received: by 2002:a05:6512:696:b0:52c:dfa0:dca0 with SMTP id 2adb3069b0e04-539e5731751mr287408e87.43.1728672806125;
        Fri, 11 Oct 2024 11:53:26 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835d78fsm48459015e9.43.2024.10.11.11.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:53:25 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:53:23 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/13] iio: chemical: bme680: refactorize set_mode()
 mode
Message-ID: <Zwl0IzIp0HssyFTh@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-6-vassilisamir@gmail.com>
 <Zwj3tFd549K6ahbY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwj3tFd549K6ahbY@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 01:02:28PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 11:00:22PM +0200, vamoirid wrote:
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > Refactorize the set_mode() function to use an external enum that
> > describes the possible modes of the BME680 device instead of using
> > true/false variables for selecting SLEEPING/FORCED mode.
> 
> ...
> 
> > -	if (mode) {
> > -		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> > -					BME680_MODE_MASK, BME680_MODE_FORCED);
> > -		if (ret < 0)
> > -			dev_err(dev, "failed to set forced mode\n");
> > -
> > -	} else {
> > -		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> > -					BME680_MODE_MASK, BME680_MODE_SLEEP);
> > -		if (ret < 0)
> > -			dev_err(dev, "failed to set sleep mode\n");
> > -
> > +	switch (mode) {
> > +	case BME680_SLEEP:
> > +	case BME680_FORCED:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> >  	}
> >  
> > +	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> > +				BME680_MODE_MASK, mode);
> > +	if (ret < 0)
> > +		dev_err(dev, "failed to set ctrl_meas register\n");
> 
> This is an information loss. You shuld probably still have a value of mode to
> be printed.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

You are right, I missed a return here.

Cheers,
Vasilis

