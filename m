Return-Path: <linux-iio+bounces-14450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2BA15D2A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 14:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C04F3A7F9C
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 13:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF4018E756;
	Sat, 18 Jan 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+4117Kc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E6C25A63C;
	Sat, 18 Jan 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737206240; cv=none; b=UiZvfpMCFNB6/F1nOG+StJNtHOcrmC8PCS42iZi7sCe+V9GM5rY4099saUlS+l0tMocIqmhpbH4A7rgeMf+GsU2VtGRhB9iWScjouYS7xi1oNDGXalRqHm+f7yy2D5Xf4rMRTYwaZaLzUZChtsH4iAVDNuMzCpY1aegzV8zakLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737206240; c=relaxed/simple;
	bh=X3+khsUSCTyl4wSxzBR7SZr94vKYaCCG90q1hhfeq4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPTqNWc+Vcmg9gAPRu54czRpquGCf2AirSn/BD2rvVwFjliGqm4nvpYJX76NvTG24XAckZrYZIwWYaZw1rKKqicUHVjF/ryqYzV2ERR4o7cFWhjQOTRXMw68s+W6bP/rVCeP74h5xcvnaOtPnAOQpXHXZikiKOb/ck3OsDEW4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+4117Kc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2efb17478adso5293023a91.1;
        Sat, 18 Jan 2025 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737206238; x=1737811038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4P/a3aKlWEPQSK+FO9BjIPaqGVapnLfpv4tajgCrBF4=;
        b=O+4117KcV390gI5jFKw8dtpWhVmPJHleOX7gPnLIO/BzC83+9FtAyNB/PresRc8UJX
         J2NyDwR5tkI/QVsJVRInbTc8rv9HOjDjIgGBQHA3FNTaJLBT8BZxb2QimTBT3MFxmenn
         bwOsiFYwm1E+x0fjOazIUFYNseX1O/VlnOd9jbtDn4N5n4y5iAGP1Iw1BpJETJeqPRwL
         OSWVYFePkpZq1FM3DDi+izZ4PyQ9BZcVVaNY5ymIRptl98mm6zSgZXc4sn5lMlLS1mLW
         4Ls00QFjmq9S/QukcLo/Q6MzHekmO99nckyM3xIjnau719fXNGJ2Bvt8Lve1ad0Lzy8F
         yXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737206238; x=1737811038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P/a3aKlWEPQSK+FO9BjIPaqGVapnLfpv4tajgCrBF4=;
        b=vYNmhSBJdNBNK4Lavc+0KIzVw5/RfYnvH4fYWb+3391hcuFdFNT4TXm1JN18DfyC+8
         K8iTXeIKCfJzO5O6y3pp4Z4y4CXndSUe34bNqm4VF2L2uxD6FXXd1Stb3P+i1NLAp4oj
         IHmZDtV/AyBQcV6NzxZbwCddwQ4/wIk0Dza+tEnHUjfsOMQajR+/bsp/hRLkXQR+C6ZH
         7ANkVXef3deFbdbH0O5hhCPza0kMVI6AQw3T7njjSQbfknsbR4quD4EBG4mIx6ULvOes
         4+B6AdIwxIDCUErORhGvZWgaUCntshff6ajgniIeIws3+UXilCZ2SbGqrpnMjFgTiwrG
         0AWA==
X-Forwarded-Encrypted: i=1; AJvYcCVELH4PxY633hsU0H439rI+BarzbIMhIAfrVxwqYP8akU93BoccuRSiV29TGGJ+W7JBtWxMnnJxJ0RL@vger.kernel.org, AJvYcCWpUtm7trjvUT+zylqlO0RCaei/RKwV8evRWt12GtOYRX13oTM3lyRXKVsSmahUYb5PQpLt6H3jeWb5@vger.kernel.org, AJvYcCXJlI0YtH7w9kfdUP/R47S7TLGET22PxhiaSW5kTHmPi+LFIWJbzzVRVzph7i6T8fTPkAl9B7veIVsGWuq/@vger.kernel.org
X-Gm-Message-State: AOJu0YxpeDGnHT1NINBgXqlllaEqP/LvY7L3uXlOoTkgVIMCqEW1XGPV
	+a4z7K6JcD8iKCOa2LRto1ZyJ6zAoJeQPjd/73q4sDlo94tnre863b5GUDkH
X-Gm-Gg: ASbGncudHTqdj/bBA+3Qm/YbgDOJBrGqIxPmyqkYgLEg32Oyh+URh0t1oYq46WAPKk2
	wI2XmW4P4qlpHj0ORGjqbK+aS3uZq3G077M9jqB/kHO5DuDpCmDtgcfLN3cWFzQW+1H/yePQSm7
	mG93Pc451njoJkUOZbiauLPdyN+/oT1G3Ek4ANRQOzlDAPmEDNSi99LPYjHsmB/TjQKHUEwLfX9
	VQyRFGhNOD//uYUawFCkdPve1HUJfSQoK103Hx++svg0UQWqNT1aNmWT2jLpiqUnSnwKp7q6V0N
	HA==
X-Google-Smtp-Source: AGHT+IEcrpWEKCLxRllOHhmQcXd7G2kRPglFQmoHOjDJTagBgc0ZFjuwMPLTK11syfCrbz+bkxQ2zQ==
X-Received: by 2002:a17:90b:3503:b0:2ee:d96a:5831 with SMTP id 98e67ed59e1d1-2f782d7dc10mr9205568a91.30.1737206238027;
        Sat, 18 Jan 2025 05:17:18 -0800 (PST)
Received: from localhost ([2804:30c:b30:a800:c057:a90:a425:2f39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77614cba8sm4449808a91.15.2025.01.18.05.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 05:17:16 -0800 (PST)
Date: Sat, 18 Jan 2025 10:17:53 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v1 05/15] iio: adc: ad7768-1: set MOSI idle state to high
Message-ID: <Z4uqAQjDbqs-Eqn1@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <714ff48341753de0509208e3c553b19c1c43e480.1736201898.git.Jonathan.Santos@analog.com>
 <4449ec60-08cd-4074-ba0b-95603864a458@baylibre.com>
 <Z4GXikxVw6mHIYHc@debian-BULLSEYE-live-builder-AMD64>
 <20250112123023.75dc7750@jic23-huawei>
 <Z4UE3p6HCsD8PiGh@debian-BULLSEYE-live-builder-AMD64>
 <20250118120927.08f21fbc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118120927.08f21fbc@jic23-huawei>

On 01/18, Jonathan Cameron wrote:
> On Mon, 13 Jan 2025 09:19:42 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > On 01/12, Jonathan Cameron wrote:
> > > On Fri, 10 Jan 2025 18:56:26 -0300
> > > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> > >   
> > > > On 01/07, David Lechner wrote:  
> > > > > On 1/7/25 9:25 AM, Jonathan Santos wrote:    
> > > > > > All supported parts require that the MOSI line stays high
> > > > > > while in idle.
> > > > > > 
> > > > > > Configure SPI controller to set MOSI idle state to high.
> > > > > > 
> > > > > > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > > > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > > > ---    
> > > > ...  
> > > > > > @@ -574,6 +574,15 @@ static int ad7768_probe(struct spi_device *spi)
> > > > > >  		return -ENOMEM;
> > > > > >  
> > > > > >  	st = iio_priv(indio_dev);
> > > > > > +	/*
> > > > > > +	 * The ADC SDI line must be kept high when
> > > > > > +	 * data is not being clocked out of the controller.
> > > > > > +	 * Request the SPI controller to make MOSI idle high.
> > > > > > +	 */
> > > > > > +	spi->mode |= SPI_MOSI_IDLE_HIGH;
> > > > > > +	ret = spi_setup(spi);
> > > > > > +	if (ret < 0)
> > > > > > +		return ret;
> > > > > >  	st->spi = spi;
> > > > > >  
> > > > > >  	st->vref = devm_regulator_get(&spi->dev, "vref");    
> > > > > 
> > > > > Very few SPI controllers currently have the SPI_MOSI_IDLE_HIGH capability flag
> > > > > set in Linux right now (whether they actually support it or not), so this could
> > > > > break existing users.    
> > > > 
> > > > Good point. Maybe only dev_warn() if SPI_MOSI_IDLE_HIGH is not supported?
> > > >   
> > > > >     
> > > > ...  
> > > > > 
> > > > > If we ever do implement a data read of more than 64 bits without toggling CS,
> > > > > then we could just set the TX data to be all 0xFF and have the same effect
> > > > > without requiring the SPI controller to support SPI_MOSI_IDLE_HIGH.    
> > > > 
> > > > One point of having SPI_MOSI_IDLE_HIGH is that the controller may bring MOSI low
> > > > between data words of a transfer. I think all transfer words are going to be
> > > > either 16 or 24 with the new patches setting bits_per_word in all transfers but
> > > > that might still not be enough if eventually the controller is unable to support
> > > > those word sizes.   
> > > 
> > > Can we make the use of SPI_MOSI_IDLE_HIGH only apply if controller doesn't support
> > > what is required to do the transfers in one go?  
> > 
> > I think so, but that would require tweaking spi controller drivers since we
> > don't know at spi_setup() what transfers will ask for their bits_per_word.
> > Not excited with this idea but may try something if that makes it easier to
> > support these unusual SPI devices.
> 
> I'm confused. Here it is a client driver question I think. That driver knows what
> it is asking for.  It can query if that word length is supported, if not query
> if SPI_MOSI_IDLE_HIGH is possible and if neither fail to probe with suitable
> error message. 
> 
> Jonathan

Ah yes, I think that would be a better way to go. I thought your previous
question was about making SPI_MOSI_IDLE_HIGH support within the SPI subsystem
only apply if the controller couldn't support all of the bits_per_word an ADC
driver would want for it's transfers. Sorry for the confusion.

I'm still a bit skeptical about whether the device really works without
SPI_MOSI_IDLE_HIGH. Though, if setting proper bits_per_word is enough then
that's great because it will allow the device to work with a wider range of
controllers.

Marcelo

> 
> 
> > 
> > >   
> > > > Plus you would have the complication of filling the tx_buf for
> > > > all transfers.  
> > > 
> > > Wrap that up in a regmap, or read and write functions and that should be easy enough.
> > >   
> > > > 
> > > > For the part that instigated the development of SPI_MOSI_IDLE_HIGH, the MOSI line
> > > > also had to be high in between transfers. The diagrams at AD7768-1 datasheet
> > > > page 51 suggest the same would be needed for this chip too.  
> > > 
> > > Whilst the datasheet indeed draws lines for that, i doubt it notices except on
> > > clock transitions and between transfers the clock won't do anything.
> > > If we confirm that the device does notice, then I don't mind limiting the controllers
> > > to those with that can ensure it doesn't get set wrong.
> > > 
> > > Jonathan
> > > 
> > >   
> 

