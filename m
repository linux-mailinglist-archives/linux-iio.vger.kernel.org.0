Return-Path: <linux-iio+bounces-14230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04AA0AAB7
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CD53AAD9C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D231BD9CE;
	Sun, 12 Jan 2025 15:55:42 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F31BD03C
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736697342; cv=none; b=Etur8QX52VJ2PS3JPQJTQoX92F7WPmixH432/FBP//9aIg+fMNOamRdqldZZU1/oUX3ydSVgjFc5LSP8vLKVhV8X1pygqoaZTMl316diHS8LpVB/qcva7w7MEizJomLxzKbLOUEu1JdOYR5jV8RDE2PP11OZgogYfwJxS1G15b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736697342; c=relaxed/simple;
	bh=BQUV4flNKxyB3lH5h8s0kLEUHqjTd2fdC2+E4Gd7RFA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q79OttlnKE7O0/hMcwyWp8r/OUV8+UzCv91IgfRNNKSqTkloHeyfWLK/PJ84BAffNH0rA+vy+2F4gckaoKoy6N+4InBprkhT3kZq9ebHtxMe78ps7JevAEdfvSg4DE/SQRiZX1bCxDCeVtlmEs+E+jPRCSmBDYqxsbtJnVNJwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 7dbb8fd4-d0fd-11ef-9cd8-005056bd6ce9;
	Sun, 12 Jan 2025 17:54:23 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 17:54:22 +0200
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v9 2/4] iio: accel: adxl345: initialize FIFO delay value
 for SPI
Message-ID: <Z4PlrkU6Ml9N4tx1@surfacebook.localdomain>
References: <20241228232949.72487-1-l.rubusch@gmail.com>
 <20241228232949.72487-3-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228232949.72487-3-l.rubusch@gmail.com>

Sat, Dec 28, 2024 at 11:29:47PM +0000, Lothar Rubusch kirjoitti:
> Add the possibility to delay FIFO access when SPI is used. According to
> the datasheet this is needed for the adxl345. When initialization
> happens over SPI the need for delay is to be signalized, and the delay
> will be used.

...

>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +		       bool fifo_delay_default,
>  		       int (*setup)(struct device*, struct regmap*));

Missing spaces, but it seems the original issue.

...

>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +		       bool fifo_delay_default,
>  		       int (*setup)(struct device*, struct regmap*))

Ditto.

...

>  #define ADXL345_MAX_SPI_FREQ_HZ		5000000
> +#define ADXL345_MAX_FREQ_NO_FIFO_DELAY	1500000

In which units? Usually we add a unit suffix, e.g., _US (for microseconds).

-- 
With Best Regards,
Andy Shevchenko



