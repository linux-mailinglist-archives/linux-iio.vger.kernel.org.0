Return-Path: <linux-iio+bounces-5942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DBD8FF5AA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 22:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D1A2883B1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 20:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191771B27;
	Thu,  6 Jun 2024 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSrpsQnN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7396D1A9;
	Thu,  6 Jun 2024 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704534; cv=none; b=Ee+Q8urXlYNa74SQaHsEOARvooehHn+SBad+oruBcjYvV3neOUAJFIGCua9ZOmksb29yvwG4o3AS248IL6/Z4rdd+vPSAYgkhR11yCxZGmwvN/NSdjoRy7zGCxvrVEriDYgSdIvYUBKkAM1278qH3kaL2U+cbZ2RlIsTKdy3ELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704534; c=relaxed/simple;
	bh=OpNMUkwqhQfJZlVUXGLUpEuMt4+BJxuRA0BScM31vzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNda9Zcsg/5jXNr7u8gLLxlA/8cbYtwWaMVxfmxGQZBSB4/DTYdV1cz87ebY2U+BGjbz3rApnwSrcGs19PF+2e1k5G/xHYsjBTv46g+jdyaVV7BeHew/C7wjxFl0VEha1YPFeH3PLXPp96LlTkEFiehMVWQGGHxIu+s5NMQOlP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSrpsQnN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70249faa853so1157548b3a.3;
        Thu, 06 Jun 2024 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717704533; x=1718309333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S+u3B6Js2/KhMXGfn/CFs7BVqQR1ZpeRVP/jXRmHIMo=;
        b=kSrpsQnNVEDUcssW7DHfha9LWUHv5VR9njQ+nzIq5EhxnZaybKUgwZAViN4qEYyu1i
         ET+0DLZvWv3lSHL7P2Qt17dhBoX8JSlN4tI+eQZbBlriYHaSnXu3x79FxvsJTCqng7T0
         VUtwKxlXp+F0mLOyyNj1wVZ4RW5csz1Kzfe8snPMqLEaQOd4mbA5FieHEO4d8wjWUEt+
         Jay1AlsJKgbvXDAywr9bYXBGkyD4oUg9zH2SrWbMEu+ZD/WayUq5rn5nXsoUNy9Shjmn
         BwDtJHvX8hnfHAn4slEYJ88/k1wFBk65t6zsSBNRmNpvwYISb+PRpKoHCxo5w6D/GqQk
         7kgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717704533; x=1718309333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+u3B6Js2/KhMXGfn/CFs7BVqQR1ZpeRVP/jXRmHIMo=;
        b=e8nvT3C84u+qoKDtcP7PjXWByCPFgMWAEwA2D6nounfVT/3/Gpzcm7H27va+eE8Lae
         rjjy0ffJhAahC4lM4ogBViIXtIaWvCiNUvnz6SoK9ifWSn7g5DrIdea2EsIDBDQ1HtSz
         aYvVa2yrYKL2UaAucf/fG5BIl84TxdHkE6anrhTdrFhza4WT6mXMqquq2kiJwVhYFUAN
         jK4+0bWf6zctIkiPRKbK/9HnHb1P5rmhvV5k+DIFSt3Pqg10ubp+6KSibDcvRiqrR/VP
         eme+FfBiZExPKP5aSbqwinoC1Lhep/vrvEVtSGBYxivfgVsvWvnkvgBTH9z9yMlnKEOL
         hERg==
X-Forwarded-Encrypted: i=1; AJvYcCU7TE0brBN3WzVBHosu0rhrKw2RJ7keREK0mlqZ+7xHISfuLFr8pq0GJgTiqihPtE981qKFxYMXVoGEsHeLshNGEuN3a7UVx+WMEdBDWqoL7m/Fj3NPcfxAB3m0n07WarIHye949+ahmhfl4SYtCdePD9en79ml5GevAnblTZJGW8n54N/RmL8xl+rvSw6YUj45WTRYzdjp7qohdIDHMg==
X-Gm-Message-State: AOJu0YyFeqFSAXhLpRjmw8pgh8KpSb/hNHDonSRqkI7W+s2//YXJii6w
	IlzyXfCG7//sJnKXhBCXpVJ2+94eO2iqn1otCu43oyl7i3wOccVTudewQTmN
X-Google-Smtp-Source: AGHT+IEhFPmS4VDGzAQhEbOE++axuvjBfGKNH+lCuHaFUrp0RLqw8ixQKVrhd54z6BFa06rG4dP7Iw==
X-Received: by 2002:a05:6a21:819f:b0:1b0:2b96:5f9 with SMTP id adf61e73a8af0-1b2f9bc0fccmr586226637.36.1717704532476;
        Thu, 06 Jun 2024 13:08:52 -0700 (PDT)
Received: from localhost ([2804:30c:167a:4100:8407:a7e5:9b87:8081])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3b303esm1499103b3a.93.2024.06.06.13.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 13:08:51 -0700 (PDT)
Date: Thu, 6 Jun 2024 17:10:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
Message-ID: <ZmIXnBSk7nlviIZ3@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
 <21d3314355b43ecd6acc42f9dfedec501418332d.camel@gmail.com>
 <67f94cfb-6a33-4390-8032-a942f5f7b944@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67f94cfb-6a33-4390-8032-a942f5f7b944@sirena.org.uk>

On 06/05, Mark Brown wrote:
> On Wed, Jun 05, 2024 at 11:14:33AM +0200, Nuno Sá wrote:
> > On Tue, 2024-06-04 at 19:41 -0300, Marcelo Schmitt wrote:
> 
> > > +	/* Check against conflicting MOSI idle configuration */
> > > +	if ((spi->mode & SPI_MOSI_IDLE_LOW) && (spi->mode &
> > > SPI_MOSI_IDLE_HIGH)) {
> > > +		dev_warn(&spi->dev,
> > > +			 "setup: erratic MOSI idle configuration. Set to idle
> > > low\n");
> > > +		spi->mode &= ~SPI_MOSI_IDLE_HIGH;
> > > +	}
> 
> > Should we assume such a thing? IOW, should this be treated as a warning or a
> > real error? I would assume this should be a configuration error and return -
> > EINVAL but...
> 
> Right, and the error message isn't very clear.

Yeah, the message is not all that clear. I'll think of something better.
I'm biased towards having this as a warning because I don't see this as a
feature of usual SPI protocol but not really sure about either ...

