Return-Path: <linux-iio+bounces-6019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D39007EE
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 17:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02511C226EC
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90919AD65;
	Fri,  7 Jun 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi/nYlLG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185DC13F42E;
	Fri,  7 Jun 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772082; cv=none; b=eCbGZsFGUFRYaTx91ts7/iMyhwnKVRvhB0P7fEV2GQrehqHNrCSfESouWSxuUSxyREWn04RT8QIX/Fjl2gKTGfJ95zZ1UVgep88N7+aPF6TtJyZUvD99ARzy4MSN5EAH8PTz9giNAwt92wRmUcLrLzjFePPRlc1bUnTlXndxSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772082; c=relaxed/simple;
	bh=CZcl72jk+H5d+pdkzXrnP74ykSCs4Y3XU71rhlOx8Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY5IMZ9GYdLXTku/DXbq2Rf8nx/TJJobAWGzi1Bo5JrrogSm6QZUKS5TImbtWXq0xsNrBXWBdqzCFElnH5bHyBrJRblstgBtNAkJA7U6U2wFFzwNaytQEsDNfLgCmIb+GH+FGhzSRw+6lQPcEapAJNiecjJ6s4XpSiY4/ZjCta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi/nYlLG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c254d9bdd6so1985198a91.3;
        Fri, 07 Jun 2024 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717772080; x=1718376880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20d7DnsPxSqRDB6xbG1JOI4i8wQkep+sp53p+ESLoEs=;
        b=Gi/nYlLGqjoUh9huenrysz9ZYBNaxHXXrJi+PTRQA0m++lWdC2yArebLU4hdw3Sc9w
         DX2O409vMQre/3v+0wLBIC80WqJLxYegFahkypYdy8ZSWnR9tFsMAt87DsctXysbB6yj
         Mn8xDhlZXkEtTwfdt09urPYcxd1ja0EJuKayPJgilXU0xJbrvX1tjcRth+GCPav1jzUb
         C/FLneco1opLPnMhtZVVFGnkfMr49laX9RgyPnmh2LHZYsVE4sGvEw+3ZMpsN4GDEia1
         gd68WJb3ZgTICDAqZ+Sa+nGd6G5/ToR8nWoa4gxUoQNKCBxWWRYdORzaeOJcxprOZPwW
         P5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717772080; x=1718376880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20d7DnsPxSqRDB6xbG1JOI4i8wQkep+sp53p+ESLoEs=;
        b=pe9TGRrWcbqVbRnNREUIeSuNzQycvTGm8n4pwM/zlHWqmwmaAlz1OMjow3IONE8ngq
         MVe9/nTmharANExndFTTEHkDah0SoHJ/LNn8Dl+5WX4FRYz3HDbMeGaqX9yCkSFqjfUA
         3dgzXbXEeT0r5xwb+yIdPsSrP4q6YzY7opRIQ0bby0t7o2ykcWt1BgPPLpErMPvxgEkT
         bphEOP1AJ8oJZ6+3RKiFB/3Y8gLz7Ujj6GDjO0z3z+TE0UTjLdE2iWz152y/ZYmsIyz/
         MjqoIb/DHnej8/96aKSokBdcbFOVEF9c00eF0WLFtHKJwVQIPdEHWJbinGpPRRpQILT8
         1C7A==
X-Forwarded-Encrypted: i=1; AJvYcCWIeEdShe6ERFNZZpFZ8CZ0JT/c6jiTw95p2unhsM9XZbvD+w6ocl6BdGb5M1oEHeP9RY10u+JtqS63Y+DOqcxGxxEUB2UTv8SMuM58pEhVHKxFW3hRtJIjWiswIT1PK8WJhOz+Yme2k1mxyts4bDrrp8CI6IAaBo0dp87xFB+Vqdi6uUg73L0I5Ex78GqIFegLtVAhLY1fWi8NLuFOog==
X-Gm-Message-State: AOJu0YzClimwcxTevvck0axCsbAwr6Z6LYK8FPlNQO2pyDpcZvTSzsL3
	15BtjA2BHVR0SUxF9gMFafa/uhq1QK1NbyDt+gWJC2dPFjxdlNW1
X-Google-Smtp-Source: AGHT+IGp/9b43tVOiKmoFWW8PL5/JRBReddz9gHhTxuxj6eTU6ExPjxoziORzoVoZQ/D3/H3ePLolw==
X-Received: by 2002:a17:90a:f0d6:b0:2c2:7dd6:97b with SMTP id 98e67ed59e1d1-2c2bcaf8895mr2620032a91.16.1717772080131;
        Fri, 07 Jun 2024 07:54:40 -0700 (PDT)
Received: from localhost ([2804:30c:167a:4100:8407:a7e5:9b87:8081])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c20d79fsm3685395a91.4.2024.06.07.07.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:54:39 -0700 (PDT)
Date: Fri, 7 Jun 2024 11:55:51 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
Message-ID: <ZmMfd5KvNaao-miE@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
 <0a716b10-0ae0-425f-919a-ea5d8b7975b6@sirena.org.uk>
 <ZmIUwHhjAUzZnfW5@debian-BULLSEYE-live-builder-AMD64>
 <ZmMQCDCZxyGwqodL@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmMQCDCZxyGwqodL@finisterre.sirena.org.uk>

On 06/07, Mark Brown wrote:
> On Thu, Jun 06, 2024 at 04:57:52PM -0300, Marcelo Schmitt wrote:
> 
> > As far as I searched, the definitions for SPI protocol usually don't specify any
> > behavior for the MOSI line when the controller is not clocking out data.
> > So, I think SPI controllers that are not capable of implementing any type
> > of MOSI idle configuration are anyway compliant to what is usual SPI.
> > For those that can implement such feature, I thought peripherals could request
> > it by setting SPI mode bits.
> 
> The issue here is the one that Richard highlighted with it not being
> clear exactly what the intended behaviour is.
> 
> > But yeah, it's not that evident what this patch set is all about and why this is
> > wanted so I made a wiki page to explain the reasoning for this set.
> > https://wiki.analog.com/software/linux/docs/spi/spi_copi_idle?rev=1717699755
> > Hopefully the figures with timing diagrams and transfer captures there will 
> > provide quicker understanding of this rather than I try to explain it with
> > only text.
> 
> It needs to be apparent to someone looking at the kernel what the code
> is intended to do.

Ack

> 
> > If you still think we need feature detection for MOSI idle capability just let
> > me know, I'll implement what be needed.
> 
> If the devices actually require this mode then we can't just randomly
> ignore them when they request it.

Ok. Yes, when connected in that datasheet "3-wire" mode the MOSI idle high
feature is pretty much required otherwise users won't be able to sample the ADC.
Will document the behavior for the MOSI idle feature and make spi_setup() fail
with better message if the controller can't support a device requesting it.

Thanks,
Marcelo

