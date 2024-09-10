Return-Path: <linux-iio+bounces-9435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA7C974563
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 00:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FBCC1C255A0
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 22:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555221AB530;
	Tue, 10 Sep 2024 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET9KAz/n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760817A924;
	Tue, 10 Sep 2024 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006157; cv=none; b=MMEaAb0H/q0ny3WFDtQn8PljCjAVyMcoX3ufcpcIvCqGhhRka3Kzqtqi0h5xEf7/FV4lsGQ7T9IVKQLyfKFBgvnMRIn2V56fmuAYc8ZzxjpgFfMr5X5p0PU0z8PGjE/K1+psx7iu0sQDiish8moXIhqhiRzAhd0QbB4+T1Bq//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006157; c=relaxed/simple;
	bh=THfCkVjJW9VCRbiInylPfB9Z6qvnDL50FgYhdIz+MKo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJsbCrgrI39UjZEa0Ae9coT3WoxHI7sKvUGr/98X5D8zPwTwLkMb/mYyjc3I9l20R7JGHmoy837HC1NvmYAZ3sBzUMZatlxku4REYkLTtHGugrdQyTDFu+tWE1beHh4EvC36VxOfJ9RRKzBJBz2wcOZ5eUBP82GaFTfPYSO3Nmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET9KAz/n; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so6609671a12.2;
        Tue, 10 Sep 2024 15:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726006154; x=1726610954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8m6bnlMnlzD0BX4BUZPfd8GP2Hrc2VovL7bSABmNRQ0=;
        b=ET9KAz/nxs2b9WKUiq9ZO8+9IzRohUSw8TIh/OZaqvbPZzNOYWg9FyywZRp/3B8cIe
         cnC9g9juSV6mjyZ3VjJmWKBoZrqKdEDUSmBOtW6wVz5zMOxdJWebK6Bhc9iJ1APpRcVU
         BwMu2iabKI9hKTWIWsKfFBGwm5zmmutZqpL+XhBV/oI2RAsxYc4cbUxqwgv9mX1eqbAG
         gJTF56ltWn+1rFmYtJ9hrk88+FZJdEDvAZVfn6IjoOElccvPBAojRGarA0avwZiVSXKk
         yTHAhOUi7N0KAJl4d5S/2D5x8BFpgdhVhNsxbfmny9u5F0P51bswXfG4vNXvYlbfNVRi
         jBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006154; x=1726610954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m6bnlMnlzD0BX4BUZPfd8GP2Hrc2VovL7bSABmNRQ0=;
        b=mKIJHeTB9q3Bv1WUP5UeVnS1btwqSbaDFe7jaFwH0oLVbBGJ10SOzMQMq/fWGoq7X2
         KXsAHfbFJhjSDAmimgKqNS4ujBmimQaMnFQwPyxKKgD6xurjg7tggrlHeLSawuWjGFeK
         HeCQH166Sq60wwGkRjTOg8ccH0suCZHKJfoa/F6GQTcNtGyu8zeExwHXEz7HcOmzJ6j+
         h3I52ZfFowNxADdh3Xoc5UF394KciKTEfoCN60R6QGEzgSxow2dNEtXv+kIKZsgx8Emx
         SjPDzWhMwf67SLTXBNdY0YL976HyUNcitp6aHceB+6D/rcU0mpURPinwIkQmm2T0QDSq
         PJjA==
X-Forwarded-Encrypted: i=1; AJvYcCUHRBspezBp4g71iLJtDRoCQMRK0j49+7KDfYX3Ux7TRneFzUibISVYsUq/C9NQV6FS8e2YWn55FzO4xxYp@vger.kernel.org, AJvYcCUhg1TDsmnahuWi50iS3CQAUnH22uX691Ke0qyKgnT1N+bfuKei5D7W3fORg6S2D5RFj1TPCLdaYiJf@vger.kernel.org, AJvYcCUs8ZZI4upuuizFvenF+w/7i+DTTLoz/fiWhqDO5iJvOe/IhoIPRRfFWYvG7TikDhAd6oGbrI9+xo0S@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhh2O2augmeKP5ZmHwnFHztfBkuVzBTrWOEtOtoi9Yy40YOzNK
	sFT/NMuUFZYDPlaNHFWHHtWfySxLUa5ubAs05sfYEwDfa4Nx9lQxMU12/GFNynY=
X-Google-Smtp-Source: AGHT+IExLnZkW4n6uQ3v1XshfECw4H8j9s1Y2UUYFGwAoO73BhinW48PmUl2XGGDcGj1LWWxbUbpMw==
X-Received: by 2002:a05:6402:5409:b0:5c3:3f6a:9767 with SMTP id 4fb4d7f45d1cf-5c3dc7904d8mr13333574a12.9.1726006152945;
        Tue, 10 Sep 2024 15:09:12 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:5d47:19e4:3e71:414c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cdf7sm4697681a12.92.2024.09.10.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 15:09:12 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 11 Sep 2024 00:09:10 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 0/7] pressure: bmp280: Minor cleanup and interrupt
 support
Message-ID: <20240910220910.GA13457@vamoiridPC>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <ZtcfCVcV_1hCVp7N@smile.fi.intel.com>
 <20240904102955.GD44250@vamoiridPC>
 <20240907173537.632e8484@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907173537.632e8484@jic23-huawei>

On Sat, Sep 07, 2024 at 05:35:37PM +0100, Jonathan Cameron wrote:
> On Wed, 4 Sep 2024 12:29:55 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Tue, Sep 03, 2024 at 05:36:57PM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 02, 2024 at 08:42:15PM +0200, Vasileios Amoiridis wrote:  
> > > > Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com  
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > for the patches 1,2, and 3.
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > > 
> > >   
> > 
> > Thank you very much for the reviews Andy.
> 
> Too many patches floating around at the moment (not yours!) so I'm going
> to reduce that number where I can just to make it easier to keep track
> of what needs more focus.
> 
> So picked up patches 1-3 on the togreg branch of iio.git and pushed
> out as testing. Note these are probably 6.13 material now.
> 
> Jonathan
> 
> > 
> > Cheers,
> > Vasilis
> 

Hi Jonathan,

Thank you very much for the continuous effort!

Cheers,
Vasilis

