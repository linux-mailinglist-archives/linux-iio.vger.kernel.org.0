Return-Path: <linux-iio+bounces-14280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47452A0B698
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 13:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521DB161E33
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1589C204588;
	Mon, 13 Jan 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDHwcVSo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E51CAA99;
	Mon, 13 Jan 2025 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770748; cv=none; b=Pf7c8GSjhUmeHMWrzePSVNDLLz7bTK7pDu5n+NuGr5v/RBrjxXEs5bchT6AOJygj+ejIPjAHatcR10RDQM/OhQtftpJw4LGHOg6WR2U+Bh3tgnuyvUX7UmHrSozbQ0VBkLcZC0tZSVGHbq6v1qw59rzH39PLpLS3VsdVEGrptR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770748; c=relaxed/simple;
	bh=gF9aPXFp3MZBUiRujEgFNRIJYIld8+MclVBdfLI2MoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu7YJYI43uAno0ydd+90kkb89U3Ct5Yjv1l2ImXdEIbIPhIE5H3f3RRzUrnVnEghm5yIymjiygvPouwjX36v9ZKpyKmoCoiSz3SjTQjYt6B7ks/f5MiwWc3wdWkbajm4tUumP5HFPFf/0LynPaBWPPnJxX+qvSkgQh1XXGkyjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDHwcVSo; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e287897ceso2902780a34.0;
        Mon, 13 Jan 2025 04:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736770746; x=1737375546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJhMFZsRRTFUiROv1W77X+iXzKpGATZ1OEQYzcxFZRc=;
        b=EDHwcVSopzc6iWbVulVhUC/RkiVX8C8nuEcFp+q4QxsNxMsvqLo+YjNNkLQwi0bzZZ
         2kcJfstpKKr0inIMR4t7W/mbeRifCyAktYCnbrRkrZ7X1YIv8FsJ/FstcD2IDoACRM6k
         HdlylK3Bl8ZaboCsMSMmx9R3VKbQ291FEhtSyn6qRSbghyFae34jS0xI/l+/vnMT26RP
         nvVAHoRMQtn2EQw/uLI4OAEefq5XngPBnIqml0oBvL8QhoRspHMNT7mzfpynTegnIuuZ
         xmDlDsHCWAzIj+OfHkpRCVzftEXjJzjwoAQOKxxgsT15aD00zdfA9mssz4R3WOMG3kjp
         GN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736770746; x=1737375546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJhMFZsRRTFUiROv1W77X+iXzKpGATZ1OEQYzcxFZRc=;
        b=igPKf5EHtUjqAZmbkVCmPx4eEN/bkZrMjgt6Si92aWDoiM+DWh/7dJgZ59GES2Y9w4
         7PyZTVrhdty1cEGM0AIuRjl29tGh4hWV40K6GASpgWiZZfcKvh+s9QCH/DkoUqeUfTc6
         ax3Zb44JhUvzCTRIrGuZrNglYfFmGIvi7ZLArdseY7zA8vJA11oyX/3VO44GvIYxDo6u
         gWEQGvaSYuBHw4OwZtvLvwpG9ggNt1lwPaKdiMazDDJM9E0Om5CBxh10VyelVaRjTgUk
         AlbTRzcz47rAFKUnNHzeB1jzCGC9RUFMtgY1FzXtp/vQgyUt8wNLoQpTw5SmizFXYLnE
         ZBuw==
X-Forwarded-Encrypted: i=1; AJvYcCUGW+yh9ugrRzEHmC6XNAbhTbHR9t6fN5fjui8gf4oTMlmq0YHGPziTcbIQ24u9agkXL5104MchYV+Y@vger.kernel.org, AJvYcCUNhbh4cmRGUc0wQSIkaqFKUYTNN3Ac6AAo7QxEvV8Txc7h3IDd/ZeplDMNL6vFyBMwxYSQg8yMIlD+HMDX@vger.kernel.org, AJvYcCXyR+kHlRlbMLzKaLVGJkohRcXqkpAKGV1nzPMvr1le6N7/sBeIGzcONgaZ2qXjZHPjgfuS/w1zYJ3i@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/yM6o8sH/XKoEiDZexykv4FUn/fVjjeq5DJ2PS64QjX1Cpopc
	Vn7aTJRw9XVb4P93Sw7zWm8f7EnelvtRD/sKP4TQDHEJqL9ZY7Wj6dP7VkaF
X-Gm-Gg: ASbGnct6+5OZHdUW3f4ZM7PHpOToQKhOe2FKvmuVKxJ1cQ6Kb8cyz5lRj4Zbom39A2h
	PLusVQi25idt6hWl7+COmHm//lgcUsrENaxqtAiR2PjT0cCh0bq93OPJTMR/uHFP6FHqNsfKBSg
	GDyTq+OtyocVqvtgQEW8luJCGBqcB6CobpOR/FvFM8MrjbsUPWUrPX1/+7PsA3efIzxt8V2Nx5v
	F0anaGK2QIOQDr5C65BiwlgVmuT55I2bUxVEUipPo4FF1KiGZ9fiFBTUzDAZxaYTkc=
X-Google-Smtp-Source: AGHT+IFSE61udVxcN4NGU7g5/PBATh3H6eNg3KChjRywD2F00vIQb9okwni8mkQNOdyXi1TndChLlg==
X-Received: by 2002:a05:6830:6004:b0:71d:eee3:fd1a with SMTP id 46e09a7af769-721e2d06aa8mr12526190a34.0.1736770746296;
        Mon, 13 Jan 2025 04:19:06 -0800 (PST)
Received: from localhost ([2804:30c:1f79:9d00:c6c6:ec89:7531:7838])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3442598a34.33.2025.01.13.04.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 04:19:05 -0800 (PST)
Date: Mon, 13 Jan 2025 09:19:42 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v1 05/15] iio: adc: ad7768-1: set MOSI idle state to high
Message-ID: <Z4UE3p6HCsD8PiGh@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <714ff48341753de0509208e3c553b19c1c43e480.1736201898.git.Jonathan.Santos@analog.com>
 <4449ec60-08cd-4074-ba0b-95603864a458@baylibre.com>
 <Z4GXikxVw6mHIYHc@debian-BULLSEYE-live-builder-AMD64>
 <20250112123023.75dc7750@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112123023.75dc7750@jic23-huawei>

On 01/12, Jonathan Cameron wrote:
> On Fri, 10 Jan 2025 18:56:26 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > On 01/07, David Lechner wrote:
> > > On 1/7/25 9:25 AM, Jonathan Santos wrote:  
> > > > All supported parts require that the MOSI line stays high
> > > > while in idle.
> > > > 
> > > > Configure SPI controller to set MOSI idle state to high.
> > > > 
> > > > Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > ---  
> > ...
> > > > @@ -574,6 +574,15 @@ static int ad7768_probe(struct spi_device *spi)
> > > >  		return -ENOMEM;
> > > >  
> > > >  	st = iio_priv(indio_dev);
> > > > +	/*
> > > > +	 * The ADC SDI line must be kept high when
> > > > +	 * data is not being clocked out of the controller.
> > > > +	 * Request the SPI controller to make MOSI idle high.
> > > > +	 */
> > > > +	spi->mode |= SPI_MOSI_IDLE_HIGH;
> > > > +	ret = spi_setup(spi);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > >  	st->spi = spi;
> > > >  
> > > >  	st->vref = devm_regulator_get(&spi->dev, "vref");  
> > > 
> > > Very few SPI controllers currently have the SPI_MOSI_IDLE_HIGH capability flag
> > > set in Linux right now (whether they actually support it or not), so this could
> > > break existing users.  
> > 
> > Good point. Maybe only dev_warn() if SPI_MOSI_IDLE_HIGH is not supported?
> > 
> > >   
> > ...
> > > 
> > > If we ever do implement a data read of more than 64 bits without toggling CS,
> > > then we could just set the TX data to be all 0xFF and have the same effect
> > > without requiring the SPI controller to support SPI_MOSI_IDLE_HIGH.  
> > 
> > One point of having SPI_MOSI_IDLE_HIGH is that the controller may bring MOSI low
> > between data words of a transfer. I think all transfer words are going to be
> > either 16 or 24 with the new patches setting bits_per_word in all transfers but
> > that might still not be enough if eventually the controller is unable to support
> > those word sizes. 
> 
> Can we make the use of SPI_MOSI_IDLE_HIGH only apply if controller doesn't support
> what is required to do the transfers in one go?

I think so, but that would require tweaking spi controller drivers since we
don't know at spi_setup() what transfers will ask for their bits_per_word.
Not excited with this idea but may try something if that makes it easier to
support these unusual SPI devices.

> 
> > Plus you would have the complication of filling the tx_buf for
> > all transfers.
> 
> Wrap that up in a regmap, or read and write functions and that should be easy enough.
> 
> > 
> > For the part that instigated the development of SPI_MOSI_IDLE_HIGH, the MOSI line
> > also had to be high in between transfers. The diagrams at AD7768-1 datasheet
> > page 51 suggest the same would be needed for this chip too.
> 
> Whilst the datasheet indeed draws lines for that, i doubt it notices except on
> clock transitions and between transfers the clock won't do anything.
> If we confirm that the device does notice, then I don't mind limiting the controllers
> to those with that can ensure it doesn't get set wrong.
> 
> Jonathan
> 
> 

