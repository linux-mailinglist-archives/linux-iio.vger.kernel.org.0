Return-Path: <linux-iio+bounces-17889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CAEA82D7D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 19:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90B619E6893
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B29276032;
	Wed,  9 Apr 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="axX/TkOn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89841C9DC6
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2025 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219355; cv=none; b=M48yYmxr0U1YAyOr4cIyo72KLXn1fNCwozE/yIIhPHAljH/zs/bBDW8XvKb3sqaSxcFjlH10yDDDVeBd0dhqoNQduF6n68f5ad0DK2Ggv4MvQwCzl9Xe9i1btoxDW/SuM0wR4m0rIdvZKTo0YktL2I1rGo2JExJbWOFYWW8eKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219355; c=relaxed/simple;
	bh=hgmZjl/0GFu7aV9zyA1pqvTUbV9/RCV8jgKjSe4y/j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VihL/O+YoauOS7w1RvJSuVyhqgqxEQxr1W66Ei9ew72OtJR22cLZOtGmjrQxP3X6bgie2lFcijBN2CQfwjC0EXbUtGpKrOp4Jfs748zM0Q6D7302JzFWtcNFAXi2S/VREJwFGBMBFlaL+nurc1ehXjXZOEoi5FrLw/jexSNUDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=axX/TkOn; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c873231e7bso3988477fac.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744219352; x=1744824152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUd3DRgpk7IUXe+BG1VM+vufDZdq+6SFGqAIEWolzZ4=;
        b=axX/TkOn0RjSqi5z/NHPBF+rR6/5ih1p+OqpIyjTv491dGMUumA5enzLKFwgEyjCsq
         t30tnVGUeIMhbHHrRAlYasF/BNbJEZNnMRCsUqwtH7E4uC6kPXVB3GeyIKNyRcqMTkCy
         lcZyPNN/ZK+uk8uTismjcfFELQSySyxounFaIpnMP9dPOiwaOyg8RMVRh1z7CeCPD0lq
         m51XYsyxxvl1XuRxsjubfWpdWazTcp7T0iD8Zt+xUoahHEykFjX+/peAxBx3MIlQhJS6
         He/7+w2Be3JapwxfAs7Wxs/WpWL4zeqsrRTQ0AgZiK48tRKNOJ0FTn2L5OcY4XIdoAL8
         AI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744219352; x=1744824152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUd3DRgpk7IUXe+BG1VM+vufDZdq+6SFGqAIEWolzZ4=;
        b=Ox5Ff3Fe+ds50gaqJdo4HZdgaCVX0NbL9Oqcksz97mvUWvmkjZ7qOi1XIbqYaY6GHI
         cNS2HC8kMZVbD6nE67TlqZ/75ZNxE9pE1GjROxixTDuwdPei9R9ek9cqpWONaGMRXH1W
         P9+9jcYwYekFpPfxDzX2mSy097Zj5hF4feQUw+AHsA2+5wEskdAzFsgaxpOd/c8us0UF
         KJ648VdYa725jpyEgS2SEJmqDqBr6mPZSuktPIUi4o8Npj+h/0KtyNOOQccJFJnuf4vP
         n4iaHsWpBiwlFvBGrqNRGBfTLNor0QcMHfCQe1vov0AeD5rsMq8Z/OaImG/2TC7j9GkG
         9KBA==
X-Forwarded-Encrypted: i=1; AJvYcCVeAFV6dNe4AtzETW5SOOfpqI75LZKzncbVQH6iBaObdyDV7lKHGjvhX7Jp4t7TsySVT2iLM0q/O+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIRiUCfk+Aznv71oYnefMydmdxq+3tn7vpnJwBJMoCDuZs81Zi
	R9LJmFtqQOquVy7+24KOFo+2pD0ez35WY7TXZafJ+YnoDwBqUPxpYoWHh4aZ1ys=
X-Gm-Gg: ASbGnctpxBrui68J23wv2kv8Zv+6O0B0M/T6mLsmca7vbL89AmactAMbN9GebKlJxu5
	xf2FQbvO6+gjuaNLRrxInucVaeL9uVopFWW87BrCc/FJxqk5HFkWCxyWnkSGOjV7h3DpefyteaM
	6NNEJaoFc1Tu2LWd+761Jux9oUqkolQbEpMOUfCu+1R+tahWMSdIhM6BbHOJeCWvEXcgdQiQQrT
	CNtN0+ML9x4cLE0UhWHU0DROqN1QYOQeQMHn89F4H8H2T92Cef71m0/4y/oDqPenAuqs8HIJVrf
	qVT5nbcEdKCGK0OAatyiAyi71PCE52owvYJCeHeWmT+E9F5jSRMAr1RVtPrNe+kSi9SoCiaUfbZ
	R/hUvwZfgJZoH
X-Google-Smtp-Source: AGHT+IFztP1mzeKLjJidViQDuyETBIHT+PXnlCCfiLa2H6qKas7z84dDHIdYm/LkCN3/HgD7fYGIwg==
X-Received: by 2002:a05:6870:7093:b0:2c1:c10e:3230 with SMTP id 586e51a60fabf-2d091815336mr1861013fac.18.1744219351661;
        Wed, 09 Apr 2025 10:22:31 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d096cd25fesm295633fac.38.2025.04.09.10.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 10:22:31 -0700 (PDT)
Message-ID: <97d0cc16-cdd4-449c-87f5-f62e0515de97@baylibre.com>
Date: Wed, 9 Apr 2025 12:22:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] iio: adc: ad4000: Add support for SPI offload
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1743110188.git.marcelo.schmitt@analog.com>
 <386ce043a0e3fc9e8ff71f17aef8de128ce5869e.1743110188.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <386ce043a0e3fc9e8ff71f17aef8de128ce5869e.1743110188.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/25 4:24 PM, Marcelo Schmitt wrote:
> FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
> The PWM IP is used to trigger SPI-Engine offload modules that in turn set
> SPI-Engine to execute transfers to poll data from the ADC. That allows data
> to be read at the maximum sample rates. Also, it is possible to set a
> specific sample rate by setting the proper PWM duty cycle and related state
> parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
> trigger) is used in combination with SPI-Engine.
> 
> Add support for SPI offload.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

I think I spotted a bug. With that fixed...

Reviewed-by: David Lechner <dlechner@baylibre.com>

> @@ -690,6 +942,15 @@ static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
>  
>  	xfers[1].rx_buf = &st->scan.data;
>  	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);

Now this needs to be:

	xfer->len = chan->scan_type.realbits > 16 ? 4 : 2;

Otherwise when there is SPI offload, this could read 2 words because
storagebits is always == 32.

> +
> +	/*
> +	 * If the device is set up for SPI offloading, IIO channel scan_type is
> +	 * set to IIO_CPU. When that is the case, use larger SPI word sizes for
> +	 * single-shot reads too. Thus, sample data can be correctly handled in
> +	 * ad4000_single_conversion() according to scan_type endianness.
> +	 */
> +	if (chan->scan_type.endianness != IIO_BE)
> +		xfers[1].bits_per_word = chan->scan_type.realbits;
>  	xfers[1].delay.value = st->time_spec->t_quiet2_ns;
>  	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
>  


