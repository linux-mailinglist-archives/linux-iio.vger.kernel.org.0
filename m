Return-Path: <linux-iio+bounces-7104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A991E6A1
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 19:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C891C21E2B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74116EB4B;
	Mon,  1 Jul 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/K6254y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725416E872;
	Mon,  1 Jul 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854919; cv=none; b=qZTUCYQCvdMv8ZEQ4zQkkqO9W5tdJpIkfVPN/hQ0HWInzfDbUACGTSL8MkEuCrr0OoA6Qmd/KEIaNPgKKbk2GK3IZ6Uh8P69GmUlYb2A94WhEdZqzFUcZuiQnNdCg0FsvbmK4Xap1I2SFT3e8VILFyk+ZE2jQqOSZkPrBb2TLnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854919; c=relaxed/simple;
	bh=Djq+I6/H5NeWMc6k7f+gRN1mfm/Ucj4/tjTrKbX0FKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv9QKYjS99unE8PXK61ge+gqnxCSBxHCYJJhT9vqiUJBp/iJk7SbDR8aoRZGx5HEzsvn2xkmmVeI0wfLF3oU3C/88Qy+SbC7l4A6snVJIYU6Uci/VKu6Zjvq12CY1fomUDx83luQEEbSZcpr6lSS4i0EH3DOvduO3xUBM3KQ/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/K6254y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f9b52ef481so15300975ad.1;
        Mon, 01 Jul 2024 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719854917; x=1720459717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBaHO6wsf3uapECt7oYjoJlQSnwdtRQ+9RONzIUWqL0=;
        b=M/K6254yzC19i2VSLjn91XH7U2HWRsySVL/kSFOtjK0QUWyejiCqfjwGEqDHKyacP5
         US59/5vriQoNN8T0/WfiwUcLPFLokeFC+I1U9C8zuR2C7195bKiz2TzYnVMRiRjo7qw7
         R/u+xAX/JH+pVxnfDlPAQ10n7jPjW7mF80qL7FdN6ibMDEbxZI88+u6NFOq/6SSBdn4F
         4AUIrrmyp8YTplQ1Lh9VdQ75fgh3PF5h6D6EKl654FCtVE0Gcyy0Cjc6nau4Gagc6RwO
         fSSSvPI8qxZuAIG25uNA5nXDnZ5h5Uuob4GdypxigBqw+gadUiG95eCHd/FOYJKp8QvJ
         M9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719854917; x=1720459717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBaHO6wsf3uapECt7oYjoJlQSnwdtRQ+9RONzIUWqL0=;
        b=sBlbWuUfgfnVPgTogxEVUwYqxQ+RGqny5u+r/oZEwYN99coIxrsgjRb8NXkie9zm5q
         9nyvghzEbfaaY4dTT71ajGkh+q2ZA2rVCEfVyD8O58s5nXCxF6SzN4bx/kfAIPGIoHcq
         d8InZGPItR50pZ0K93e949kNXqq+BQqZNqR9h+mLkL9LY2YrFbQDNZPQccUH8IOgs9Jm
         0znEu4hALLFhQdMTZ2VavZruAZxItrIuNshp7Qe0WPF1zUdAG6osW3/2cKkjzV989aS2
         froqJatsei6X/kIxgkKCt69b4vl7iKonVxvseBpGRhUPpRUxFmQp4tUepoy0FlGfa1bN
         xoxw==
X-Forwarded-Encrypted: i=1; AJvYcCWLkAsdFhIE7yaFEp1uP+XdzohRe9ZArF3iGp1COy64T1rD7/l/5zkrLw5YwIgab/noNfi9DWJT+AJ/T5w7eeH9NfqxkSr40GkXnKXKHe/96S3bdlyX0iOJARWzYJYAWOZ8PK3FB3jcXFsn81UuvslKjCNbKB/rYuEiaduuGh1Yp5BiLgp2DO5bzVYGplYyemr4vywu+yyAqYR0emIUIw6lASAjlnF7U6U/Tp5WqVN0XCInMYnu8ba8Ug==
X-Gm-Message-State: AOJu0YzaXGQZvFhD5VyuvZWDIJ+yy1NsAejEzWTmOlgcnoPEMlLp2cNQ
	3rCJOIoLvH78WW1YuOAj1JDS9DoJIInGGs1H9WksqnhZ3a8DyaXs
X-Google-Smtp-Source: AGHT+IFHI6aSahk4LDx5+TUExioY5PoSZ+kWHD3kE361kIjohObRUxjgpnenJDrBbZSIaLc5EMTDeA==
X-Received: by 2002:a17:902:cec5:b0:1f9:edf6:d79c with SMTP id d9443c01a7336-1fadbd248e8mr44825495ad.69.1719854916374;
        Mon, 01 Jul 2024 10:28:36 -0700 (PDT)
Received: from localhost ([2804:30c:165e:de00:82ea:ff72:ead3:4367])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1538ee0sm67657285ad.149.2024.07.01.10.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:28:35 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:30:07 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <ZoLnn9K2caWJtIlQ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
 <7eb23146ad6bf6090183c6340e4d59cb269d83a7.1719686465.git.marcelo.schmitt@analog.com>
 <20240630114716.3e06f18b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630114716.3e06f18b@jic23-huawei>

On 06/30, Jonathan Cameron wrote:
> On Sat, 29 Jun 2024 16:04:40 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > The behavior of an SPI controller data output line (SDO or MOSI or COPI
> > (Controller Output Peripheral Input) for disambiguation) is usually not
> > specified when the controller is not clocking out data on SCLK edges.
> > However, there do exist SPI peripherals that require specific MOSI line
> > state when data is not being clocked out of the controller.
> > 
> > Conventional SPI controllers may set the MOSI line on SCLK edges then bring
> > it low when no data is going out or leave the line the state of the last
> > transfer bit. More elaborated controllers are capable to set the MOSI idle
> > state according to different configurable levels and thus are more suitable
> > for interfacing with demanding peripherals.
> > 
> > Add SPI mode bits to allow peripherals to request explicit MOSI idle state
> > when needed.
> > 
> > When supporting a particular MOSI idle configuration, the data output line
> > state is expected to remain at the configured level when the controller is
> > not clocking out data. When a device that needs a specific MOSI idle state
> > is identified, its driver should request the MOSI idle configuration by
> > setting the proper SPI mode bit.
> > 
> > Acked-by: Nuno Sa <nuno.sa@analog.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> I always like to see some nice ascii art. Very nice documentation.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 93f59ebb5b79..c8ba5e490850 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> 
> > @@ -3950,6 +3956,7 @@ int spi_setup(struct spi_device *spi)
> >  	 */
> >  	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
> >  				 SPI_NO_TX | SPI_NO_RX);
> > +
> 
> Trivial grumpy comment.  Don't touch white space in unrelated code!

Ouf, must have slipped through after messing around with spi_setup().
Didn't intend to add that. Fine if that can be removed when applying the patch.

> 
> >  	ugly_bits = bad_bits &
> >  		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
> >  		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);

