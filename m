Return-Path: <linux-iio+bounces-6639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD40D9110B7
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 20:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A581F21964
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C701BA07C;
	Thu, 20 Jun 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqiB235M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915BB1B9AB0;
	Thu, 20 Jun 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907605; cv=none; b=XguYU9vEFH5ElVL/useJQq7m6vvefygcsVjm8LmHRsuxIKn2lCeTPg+6dksXvDIH27PKyzTDDJedZ96TVmUsC1lrbel/aXaWAlSJddrQiAjrAuimJMArmJjBEMMgi5BhcBatk1f2RMBMORPz5A1/CYRUedP1r8wxiOKFgLcaWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907605; c=relaxed/simple;
	bh=QgX63jQNvqO33I1TzUV44C84NRXqnUFl5rBJwHLIdk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPUTXO55teJA4J0nf+oiquGioo0cMAbn6DLDRLqzsSkvDN0cvIiisdxo1NVUwEX9GzR8Lc1wvTogE5fzfwB40UIzWyvg2u/BAuDIHBAFw7p4RuAb2HUWT1gdjxp9dTV9QwUna3R4VhCNKbwgTu+6S6KQqaDbc+rEHkfWUpJwjTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqiB235M; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9cd92b146so8448195ad.3;
        Thu, 20 Jun 2024 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718907597; x=1719512397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+8YnXs0GGqZ0tXYzkAA6f85Kk0pjUI8e7op0FH5mYQ=;
        b=GqiB235M7xvC8EOcA8FIfr4ScpRAdX1A2/GJxbDMFj5GKwiaDhl3nL1tdwUBqSug/f
         ZDJJnLgfoNXtPjsZqGXwYk+QDisYL7viKVLZrJizIzZzdJPVTndlKph6wJBv0vTbCRiL
         6GbaecCfVcYCD91kno75bSarI1YnZ/sCwzXvJUHG5BU1QtKoa69Z16fBzpaNKCMbb9Yy
         zGQHnECO3ZwYHImvmLB9pk4A+cjE/2y+wZJe1tdEXqcgLIF1l55V4+bqHcZmpBzZcKIh
         pjeDpmxk2+BiP8wiKu2hJOk5eFj8WhudjEwWJFkMUKkRskihmNWA+Ho/FW7UmzVZQxBY
         8mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907597; x=1719512397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+8YnXs0GGqZ0tXYzkAA6f85Kk0pjUI8e7op0FH5mYQ=;
        b=ffNd5KHl5jQSlhyaVjj+yKc2bqZfSw6rKRsFkXBWqFIZsaJzUb0oe6UzHxBFt5ZS9V
         h6//2KY57VlzEPRYvHO8KgTUhzTx0HPlICwb/wFAbyWJIsxmApalVdX1ZPtjkpxF3cWW
         2eJgTjDhEOatPGNJ0t957tEziU7Czz3RdR+Th3uuSQ8Av12WcFWzqTNvT1/M7ZjSATTm
         raX1PWXc7nDSPBzODtxQ13FaBFdbNI+YfYYsO8REZiGDZHnXdxeXblwCI23BdQVK03qh
         wLZbqCeFEWmFak1SJCw01RNK4ItqThoyYtQ9AqCPwAwiFeSM4azPdxgCRxMXbLjnUiat
         n9GA==
X-Forwarded-Encrypted: i=1; AJvYcCU2VCTbUGd0LSwSSviQp1EsetSdAEl4yCPxBusJaXq9/zAP9qly0CWCNGyiyInxQTA5igg3sRjmLiUN1ItlHY+JsgTwf32+vXHlYr3aQrCjh/ydo6NX74260dexEB8r0WrAw0EikABQnno2Sv5bB/nl2KeR5sNfke8HbEbwywQgLzUYqVpmImplo5xoz5RZasHskpK+ghqgTxmRCKJd6g==
X-Gm-Message-State: AOJu0YxjVyF9xcCA1RJxtY0LATKt0c5gFEFadDQIn+Cbw+e9TDJAqCDE
	64uW0dK4EqyBLccfEIeiy3aFQocVoRmY6oCykbcTMfurgzZT+t/N
X-Google-Smtp-Source: AGHT+IGc7E+J+/uLi09nU0m95G531If0xz4MDJLJ2k/9wbC8InxpvoRZzC6/IsJvHTe7SpJWygL2eg==
X-Received: by 2002:a17:903:2291:b0:1f8:66fb:1677 with SMTP id d9443c01a7336-1f9aa3ab71emr73840375ad.14.1718907597187;
        Thu, 20 Jun 2024 11:19:57 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e72483sm140770865ad.96.2024.06.20.11.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 11:19:56 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:21:21 -0300
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
Message-ID: <ZnRzIb-cD_oOFkg-@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
 <63db9349-f453-4a5b-aa09-d1857ddd8b03@baylibre.com>
 <ZnMqOAPc3IXP-eHC@debian-BULLSEYE-live-builder-AMD64>
 <e7a2438a-f6a3-439e-8058-937248dd5b3f@baylibre.com>
 <ZnRG9wgY3WIaYFyQ@debian-BULLSEYE-live-builder-AMD64>
 <08c09a34-af59-4387-8db9-594f30f85b7a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c09a34-af59-4387-8db9-594f30f85b7a@baylibre.com>

On 06/20, David Lechner wrote:
> On 6/20/24 10:12 AM, Marcelo Schmitt wrote:
> > On 06/19, David Lechner wrote:
> >> On 6/19/24 1:58 PM, Marcelo Schmitt wrote:
> >>> On 06/19, David Lechner wrote:
> >>>> On 6/18/24 6:10 PM, Marcelo Schmitt wrote:
> >>>>
> >>>>
> >>
> >> ...
> >>
> >>>>
> >>>>> +the peripheral and also when CS is inactive.
> >>>>
> >>>> As I mentioned in a previous review, I think the key detail here is that the
> >>>> MOSI line has to be in the required state during the CS line assertion
> >>>> (falling edge). I didn't really get that from the current wording. The current
> >>>> wording makes it sound like MOSI needs to be high indefinitely longer.
> >>>
> >>> It may be that we only need MOSI high just before bringing CS low. Though,
> >>> I don't see that info in the datasheets. How much time would MOSI be required
> >>> to be high prior to bringing CS low? The timing diagrams for register access and
> >>> ADC sampling in "3-wire" mode all start and end with MOSI at logical 1 (high).
> >>> I think reg access work if MOSI is brought low after CS gets low, but sample
> >>> read definitely don't work.
> >>>
> >>> From the info available in datasheets, it looks like MOSI is indeed expected 
> >>> to be high indefinitely amount of time. Except when the controller is clocking
> >>> out data to the peripheral.
> >>>
> >>> Even if find out the amount of time MOSI would be required high prior to CS low,
> >>> then we would need some sort of MOSI high/low state set with a delay prior to
> >>> active CS. That might be enough to support the AD4000 series of devices but,
> >>> would it be worth the added complexity?
> >>>
> >>
> >> It needs to happen at the same time as setting CPOL for the SCLK line for the
> >> device that is about to have the CS asserted. So I don't think we are breaking
> >> new ground here. Typically, in most datasheets I've seen they tend to say
> >> something like 2 ns before the CS change. So in most cases, I don't think
> > which datasheets? Are any of those for devices supported by the ad4000 driver?
> 
> In the AD4000 datasheet, Figure 59, it shows the time needed for SDI setup
> before CS assertion, labeled as t_SSDICNV. Table 2 gives this value to be
> 2 ns.

That delay is for "4-wire" mode and it specifies the delay before bringing CS
high. In "3-wire" mode, we are bringing CS low to start transfers so it doesn't
look like t_SSDICNV applies to the "3-wire" mode setup.

> 
> So unless a SPI controller has a functional clock of > 500 MHz or somehow
> sets the SDI state and the CS assertion in the same register write this
> minimum delay will always be met. I highly suspect noting like this has
> happened before so no one ever needed to worry about the timing and it
> just works (for the similar case of CPOL).
> 
> > 
> >> anyone bothers adding a delay. But if a longer delay was really needed for
> >> a specific peripheral, we could add a SPI xfer with no read/write that has
> >> cs_off=1 and a delay to get the correct state of both MOSI and SCLK a longer
> >> time before the CS change.
> > 
> > I don't know if that would actually work. I have not tested doing something like that.
> > This also implies the controller will be able to start the next transfer right
> > after the first preparatory transfer ends and it will meet that inter-transfer
> > timing requirement (which I still didn't find documented anywhere).
> > I'm not convinced that would be the best way to support those devices.
> 
> I did something like this in the ad7944 driver where we needed an up to
> 500ns delay before asserting CS. On SPI controllers without a hardware
> sleep or FIFO, the delay will of course be much longer. But the delay
> is just a minimum delay, so longer doesn't hurt. It just affects the
> max sample rate that can be reliably achieved.
> 
In ad7944_3wire_cs_mode_init_msg(), xfers[1] is prepared with spi_transfer.delay
which is the "delay to be introduced after this transfer before
(optionally) changing the chipselect status, then starting the next transfer or
completing this @spi_message." That should work for ad7944 because
it has ADC SDI physically connected to VIO in that setup.
For ad4000, we would want to set MOSI high (by writing 1s) such that MOSI
is high when CS is brought high (if I'm getting what you are suggesting).
But spi_transfer.delay is introduced after the transfer and before changing CS
so I think MOSI may return to low if the controller idles MOSI low.
I can't see how this would work for ad4000.
Other delays we have for spi_transfer (cs_change_delay, word_delay) don't seem
to help for this particular case either.

