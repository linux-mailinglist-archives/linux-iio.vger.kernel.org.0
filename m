Return-Path: <linux-iio+bounces-6628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B5910968
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 17:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4BB1C21658
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6801AF696;
	Thu, 20 Jun 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhtgg3v5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D81AED5D;
	Thu, 20 Jun 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896297; cv=none; b=FTuyyI3SNviGYGH3qa74OBwEtjveOunbwTwLlTBCnPqH6smuZJU52hts1yoqarippHrBx3jj0SPamh/Lz+FT47o0cZ2fn45E1NO/lPRSIQdHxX1/GXf2IRRoI7gC2zqURALYnyp0W94UJ1y8oyG671CSzw0LOefbYj9JGVH9ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896297; c=relaxed/simple;
	bh=AU2dIZOHA33jaIyUvKlqFneAYvUEREDs1Wy0TpNk3V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX+bdsyv6jhAZKbAO4o18rLpaN/n/VsOw1hrZJjIqhXHRp6CGvHySOWnbSTUTlWE8IIKUiZDe2dy6XTbWqUBvbU3bDJtbW7WbqBsYx/7QabuoBQwyM4iOpwgF6sP0dSeqTIP7m5bR8xphroMjrQLohl6kbfRhNsecq0xhp0bX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yhtgg3v5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f64ecb1766so7676875ad.1;
        Thu, 20 Jun 2024 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718896295; x=1719501095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BdniuxfIoQMZx6rcrd4+VjHCkWj3zAequC6HSfgqfnY=;
        b=Yhtgg3v5GmfjMzouzJ72dHVciGUj5vyesKnm98lnFabnaVcsXxH1vJglowpQWoR7II
         yqmRahMazLeKchn+OF62mnNUczn50mWjbyq3yHthmNlazMf38CLUv32Q4cqPZLVccc1a
         VotAYSD8N5rQV2JVbPhvf6iuj3nTqLL0AtMsnUKpxAQREWCGF/Heyx/FARJ4ske1PUD0
         8SNJvUDtWjcswHJL+VNnT+Y5aAYak3iFNEmAuPa5h5+qBBoHQQRd32gw2nwj9LBY3Dn6
         j+H6B6D/uIXPTxa2+HF4A4DK2XeYRfKfOfHBoG4gK7K57P+/+Vvyi5TvxDU/nZY4INLP
         980Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896295; x=1719501095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdniuxfIoQMZx6rcrd4+VjHCkWj3zAequC6HSfgqfnY=;
        b=oQAdKtqyZGFHawmGhXWENvdiOtDYpNaV0jsQiGP7FZ7VZJBdEF5EFsWm9O+jy59F1G
         QS+D38Ms1K6zTPzPWYXCFVklbdkhDeodBYD1fO0HxUTRslMC/vWUMuuQUakJWXiDQ/mV
         HkaXb6O0QhjK0v2ceCR0igLIU6KRDu+1N6mI1OKfZy7CnSe/aBhNKm8DUbk27AW3bb2g
         iQD9rLP9Pqdf77lGC1kl5SAvEQDHRhRmTa87vwsyDa7sloCy8aS544w9bYCWHGV+TfOd
         VOqNITfSQMDq++9Jq2I+xLLTikr8nzqexTWzXAehyPs0aqRbQoXPEJJAvUjhdO/xS9pm
         9//Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIehVjDKNAgH4RScBz/Y2BmE+XHRTk13UlvHgdUez7kpdxoFsEy0eaLQnKwELBSkACxUTjtx0nZv8EnQ0Jsk1KLKyOfcut+4l2yYousD265nYvBBRyE1ZjldScnB++L0qc2yaYpgHPVJUO1ZYFm/DlPd4Gf/g8j+JeT3WI5aEP59TvTAxRf4miA7i3t/jO+oidip5pnzMkApCNumG8AQ==
X-Gm-Message-State: AOJu0YyWFhT4Maa5XzeNwyrmpT4pvKmuGdfnvWlMvpvOLFnLIdGrJTpa
	qsDy2YSvY560Hq1xkYiT0uo+VAbpWAbNNGPlK9LeVOqvFaRrxQEU
X-Google-Smtp-Source: AGHT+IHuss2h79Pd0GhHTa2pZZiFuRTtvqKi7+4t8bFj0/hlwRCcSWFghn7T2PJ1oidcm3JN1GN8SQ==
X-Received: by 2002:a17:902:e812:b0:1f6:7f20:d988 with SMTP id d9443c01a7336-1f9aa44fd68mr67061095ad.42.1718896294631;
        Thu, 20 Jun 2024 08:11:34 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f8575b119bsm137589065ad.27.2024.06.20.08.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:11:33 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:12:55 -0300
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
Message-ID: <ZnRG9wgY3WIaYFyQ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
 <63db9349-f453-4a5b-aa09-d1857ddd8b03@baylibre.com>
 <ZnMqOAPc3IXP-eHC@debian-BULLSEYE-live-builder-AMD64>
 <e7a2438a-f6a3-439e-8058-937248dd5b3f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a2438a-f6a3-439e-8058-937248dd5b3f@baylibre.com>

On 06/19, David Lechner wrote:
> On 6/19/24 1:58 PM, Marcelo Schmitt wrote:
> > On 06/19, David Lechner wrote:
> >> On 6/18/24 6:10 PM, Marcelo Schmitt wrote:
> >>
> >>
> 
> ...
> 
> >>
> >>> +the peripheral and also when CS is inactive.
> >>
> >> As I mentioned in a previous review, I think the key detail here is that the
> >> MOSI line has to be in the required state during the CS line assertion
> >> (falling edge). I didn't really get that from the current wording. The current
> >> wording makes it sound like MOSI needs to be high indefinitely longer.
> > 
> > It may be that we only need MOSI high just before bringing CS low. Though,
> > I don't see that info in the datasheets. How much time would MOSI be required
> > to be high prior to bringing CS low? The timing diagrams for register access and
> > ADC sampling in "3-wire" mode all start and end with MOSI at logical 1 (high).
> > I think reg access work if MOSI is brought low after CS gets low, but sample
> > read definitely don't work.
> > 
> > From the info available in datasheets, it looks like MOSI is indeed expected 
> > to be high indefinitely amount of time. Except when the controller is clocking
> > out data to the peripheral.
> > 
> > Even if find out the amount of time MOSI would be required high prior to CS low,
> > then we would need some sort of MOSI high/low state set with a delay prior to
> > active CS. That might be enough to support the AD4000 series of devices but,
> > would it be worth the added complexity?
> > 
> 
> It needs to happen at the same time as setting CPOL for the SCLK line for the
> device that is about to have the CS asserted. So I don't think we are breaking
> new ground here. Typically, in most datasheets I've seen they tend to say
> something like 2 ns before the CS change. So in most cases, I don't think
which datasheets? Are any of those for devices supported by the ad4000 driver?

> anyone bothers adding a delay. But if a longer delay was really needed for
> a specific peripheral, we could add a SPI xfer with no read/write that has
> cs_off=1 and a delay to get the correct state of both MOSI and SCLK a longer
> time before the CS change.

I don't know if that would actually work. I have not tested doing something like that.
This also implies the controller will be able to start the next transfer right
after the first preparatory transfer ends and it will meet that inter-transfer
timing requirement (which I still didn't find documented anywhere).
I'm not convinced that would be the best way to support those devices.

