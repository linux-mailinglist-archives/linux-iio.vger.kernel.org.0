Return-Path: <linux-iio+bounces-6627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA2F910832
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE1E283E12
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 14:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E21AE093;
	Thu, 20 Jun 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjK/SgZa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7D1E48B;
	Thu, 20 Jun 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893666; cv=none; b=uNzMbiYUgts4pM51mjbSDoQiCYiwg/iLJdtR7z+ffn+mvb3vFYLeyomgshwmTWeeoWlbaG/lBEsQdYsVjdXipILUjhXClqJqK9GaWDMRRbKdfKcyHV948i7kWhOPJUM8GgHB4UpNxV+s67dp7Zi4ObxQwHjxsZcTA/OOQTSiFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893666; c=relaxed/simple;
	bh=/bLyTrvXguBvQLSN2TPEFmPbPNYp27IPUrzHUHXohZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5GyIIDiem+TthIJ/xSU4jSnmU6wPf3hVYw2iugJtzOw66QgnnWNPs2bKVqahvS5LobEGWqIH8WwgzPKBwZRMauZNBwNzwtJOsnKTzY42StYJmu2ES7ygSUoQrGxAu4+/lwF6BVMXUFzqynslB+Lc+MHkSUdlBuXhEWQasaozCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjK/SgZa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6a837e9a3so6574125ad.1;
        Thu, 20 Jun 2024 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718893665; x=1719498465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/M+YMg0UUBHbo3kAq6V+DYYX1VfAAZpXVC+PMxPPVQ=;
        b=AjK/SgZaCVWL36lkbk2qnei+Wh3R7CHfaKCf8RZ+YNIGwpLPk3eB4iuLbZoAMuzXBa
         DUZAfaKr2Uh0HfAqY8ljJrif2+IvrY/H3vUcuvcnvBwt5xY84sZZbO3jceJ7PYe801Ua
         dDixqovGkAjWYy/xw/eNLhO1e8LVn68DGB9MBomiGS66BQ7HdqnbJXBJka/tPVCNLXMu
         WL18C2Iyiwj1KL0oUPRxMY+nf4iR+qD1RQu8sWkVuV/Nr4pRFf0XLKMatcM2r1xx7LJv
         s4XFXkCcEWo1i3kCDvxui+5eMmTF/DZwtlO26KIJ5CwSRrfvtG7ysChG349YiGUj8Do8
         O9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893665; x=1719498465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/M+YMg0UUBHbo3kAq6V+DYYX1VfAAZpXVC+PMxPPVQ=;
        b=cewSxv3wLz9tRPvbD8CknSGtAg4IBC5qzZMOGUgEkGjAlrAZaWxu/mxM5E0QKjH5n6
         Xmfz2Ida8EB6QDr1NFc8BLBlJceS5fIIiW2+6lIfu9PlLt1+LQeSWWQCvhUhMjDXJyfM
         yiC6cyQ5uF9JvcSGClaQJ+Po8BvmQDW+pFAierSWDSwiLZmepg8rigdbKdezufZgPev8
         sov6RllzdqAA1O6+E0oPd85RpyOWH21cpb7J+pWdPUSqglVFIreglRmNgqHTVlJb9rGx
         FBEmC+LTdGrsfh0qpd6sgu3SPIUI1UPhqjzjcxHQGwh46+lXSrHckl9jPZ+pRc3fQ0Dm
         gOsA==
X-Forwarded-Encrypted: i=1; AJvYcCUmTapgHANPrkYm+QvG93pZzta5hSSK6XF5EFtjjaTM2QHrMaPjIyTGXfnIUEU9838fDEp35sqDhNufj8yyrxSbFUer1ugJ6HI/ZTkEvc2zN0WXFQk4rgtSEiTcL0qmHF6y2iIDVTqCq7CR7AkIzapD56dR0N4G53zm5IFXuTEVwQWtWHCxl6p0n40qUuZP+ukC0FZ1ZF0xNeNY+63jOw==
X-Gm-Message-State: AOJu0YybUFSFPPCqz+TibsTHWPP8NVRffWv5skFnYzNoHn84pufyeRY2
	3W+a2roJrmuEyiE9WS+u+cI7Co9GEWaodazrUhTGq1mG6dFn91N7
X-Google-Smtp-Source: AGHT+IE2cJqCETIu3Rx+/F9nUNCxsHWg+dMwSv2D3F8JXCma6ff0mW6JljZxYfUWgBsrTzjkGQU97w==
X-Received: by 2002:a17:903:2445:b0:1f9:d282:7a28 with SMTP id d9443c01a7336-1f9d2829be3mr13251265ad.41.1718893664490;
        Thu, 20 Jun 2024 07:27:44 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9de13d8a8sm4172045ad.148.2024.06.20.07.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:27:43 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:29:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <ZnQ8sO7TEInkjf5i@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
 <e3c12062-9bb3-40fd-8b55-5cecbd2fda4b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c12062-9bb3-40fd-8b55-5cecbd2fda4b@baylibre.com>

On 06/19, David Lechner wrote:
> On 6/18/24 6:10 PM, Marcelo Schmitt wrote:
> 
> ...
> 
> > @@ -3928,7 +3934,8 @@ int spi_setup(struct spi_device *spi)
> >  	 * so it is ignored here.
> >  	 */
> >  	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
> > -				 SPI_NO_TX | SPI_NO_RX);
> > +				 SPI_NO_TX | SPI_NO_RX | SPI_MOSI_IDLE_LOW |
> > +				 SPI_MOSI_IDLE_HIGH);
> 
> This looks wrong to me. Adding flags here causes them to be ignored
> rather than to be checked.
> 
> I also did a runtime check with a random driver and a SPI controller
> that does not have the flag.
> 
> 	spi->mode |= SPI_MOSI_IDLE_LOW;
> 	ret = spi_setup(spi);
> 	if (ret)
> 		return ret;
> 
> It incorrectly passes when used with this change but correctly fails
> without this change.

That's right, adding flags to bad_bits makes spi_setup() ignore those mode bits
instead of failing when they don't match.
Changed bad_bits assignment back to what it was in v3 (i.e. no change to bad_bits).
	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
				 SPI_NO_TX | SPI_NO_RX);

> 
> >  	ugly_bits = bad_bits &
> >  		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
> >  		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
> 

