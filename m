Return-Path: <linux-iio+bounces-9335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB7C97087F
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E7A1C210F2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C83A1741C6;
	Sun,  8 Sep 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EpI2qaIY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147E1C01;
	Sun,  8 Sep 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725810914; cv=none; b=gFXvE4UYWy1q5ZnQNxzEQzUy5W1bZzji9nBbwJYbRl+RoSBeCjmlJQB4vOLAAYJ3ulG4FfVDx+OLaKEIq+qqVlzmcuhhCNwcx4KBowZHhOE1v0TG1aM+71BOSFr5hcD02Xt1nZLnV1ZWVrIkhfsDRTRzkEN6BlS7iUg2PaanfeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725810914; c=relaxed/simple;
	bh=v+PbIhluUYHPkTXQbLEp7rKf+phmDR3lOvJzKK41r7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEKdsbCEqAxjYIwtF4VvUeJs549swPQ7j2nKmEootfGNHJ6/qXnR+TWc0reAshbxgGzyQyYCVfAXweD6Cc1FRBAiKOtmvMTH6FkgRk5e/A3aFnXXFpz+m8Xm1tRs7KyyltYkISnIkhDvyvTnlDyz8faYYCq+6dE4lPWkxKLdb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EpI2qaIY; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nKEfsh3BJyrIRnKEfscxAl; Sun, 08 Sep 2024 17:53:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725810838;
	bh=kngBzB+Sdz8MioJqXgWkYppAfEiKl25T3IlQnUXg61Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=EpI2qaIYiU76k5+uUEt3ZJ0OFwUwoq4Lgkk/fO/xcEi3mt5n9VhnQupHm1way9XwN
	 TTSLn8+pSGMSJIHuNyyMvNt3n5sYKtNWBy8WmWkrrxCar/1KOFvlJQkf9Vm6btW4F2
	 knjTMMHh9mndFuu3YF9yRvXYflekZAMsB0utFCljwY5ycV+MmISKpfN7M2h51lk7ys
	 D0mLi0hCymsmF/nGnvuKNDydqWdBT+leEjTB6XtwL5VfS75uHI+1WUIHGH/zW7Dht4
	 Z/Xv5y3+hrkSr/bQmlXe7g3XXLFDk5FGe1V+LlF32XVaPy/hgWAEnOXkkbTdigoZQ6
	 ZQttCPEVbEK5w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Sep 2024 17:53:58 +0200
X-ME-IP: 90.11.132.44
Message-ID: <88021dc4-d131-49f0-9afd-fd11b1a34bc2@wanadoo.fr>
Date: Sun, 8 Sep 2024 17:53:57 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] iio: dac: ad3552r: extract common code (no changes
 in behavior intended)
To: adureghello@baylibre.com
Cc: Michael.Hennerich@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jic23@kernel.org,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 olivier.moysan@foss.st.com, robh@kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-7-87d669674c00@baylibre.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-7-87d669674c00@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/09/2024 à 17:17, Angelo Dureghello a écrit :
> From: Angelo Dureghello <adureghello-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> 
> Extracting common code, to share common code to be used later
> by the AXI driver version (ad3552r-axi.c).

...

> +#include "ad3552r.h"
> +
> +static const s32 ad3552r_ch_ranges[][2] = {
> +	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},

Maybe add some spaces around { }?

> +	[AD3552R_CH_OUTPUT_RANGE_0__5V]		= {0, 5000},
> +	[AD3552R_CH_OUTPUT_RANGE_0__10V]	= {0, 10000},
> +	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000},
> +	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= {-10000, 10000}
> +};
> +
> +static const s32 ad3542r_ch_ranges[][2] = {
> +	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},
> +	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= {0, 3000},
> +	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= {0, 5000},
> +	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= {0, 10000},
> +	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= {-2500, 7500},
> +	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000}
> +};

...

> +int ad3552r_get_custom_gain(struct device *dev, struct fwnode_handle *child,
> +			    u8 *gs_p, u8 *gs_n, u16 *rfb, s16 *goffs)
> +{
> +	int err;
> +	u32 val;
> +	struct fwnode_handle *gain_child __free(fwnode_handle)
> +		= fwnode_get_named_child_node(child,
> +				      "custom-output-range-config");
> +
> +	if (!gain_child)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "custom-output-range-config mandatory\n");
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "adi,gain-scaling-p mandatory\n");
> +	*gs_p = val;
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "adi,gain-scaling-n property mandatory\n");
> +	*gs_n = val;
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "adi,rfb-ohms mandatoryn");

Missing \ in the ending \n.

CJ

> +	*rfb = val;
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "adi,gain-offset mandatory\n");
> +	*goffs = val;
> +
> +	return 0;
> +}

...



