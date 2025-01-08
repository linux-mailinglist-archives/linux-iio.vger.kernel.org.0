Return-Path: <linux-iio+bounces-14041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA84A0670B
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 22:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CD4161C55
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 21:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95160202C51;
	Wed,  8 Jan 2025 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VAHOyRGW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514715E8B
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370985; cv=none; b=TjY69h1iabEgJ5/VDq5gFuDbnycQl9O7GXf3XuN0w0GIe3lehk44vN4bwe8VEQibSxPntd/5udHewsnVLNnKYxOIpWwKAYUn1wbFhFzwA5maCv3WskSU9ma3BeSqR4/sIG83t4wk9tUZGLn/4VPshffQ5nEELpmXgVLtebzlnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370985; c=relaxed/simple;
	bh=HB1NJQDRLX0WEL8mnldgAc5QZZplXpVSWEQYwANwTl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPuJKz8vxhwDjcYaIq9YDdP1zsu2gzSq03oC5Ox1Tyy9QL50CMXXc/90nZhA/jKGFCUZK8yi2ZdfTqN5RNShxk5c7dloVepfyd1KhY+1EKlb5KKqL/NO8Nr1uU832gR0h64HTByMl2XLLvvnxHYuM/BJ6Z5RukhTGrMfu2+K7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VAHOyRGW; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb9ba53f90so76454b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 13:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736370982; x=1736975782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVM62qWNY3HcZseHT9G2aNl4yPSR5DOCQCsjQBmWcYg=;
        b=VAHOyRGWQ1EOSrTlWGaKULtZYDw4zgvy2VhWWUHM5jP6gfrK1iRC6WPm2YldIJKd84
         xtOf2poh3KTa46ICeAko8L5vvR+foJgqvispVUWckqxSngniLB0Iesf/5PKDOuHI+oAb
         CHXz1vhnpdAtdUOqO/YH4Li8RTi9yrQse0ggsjrnPY/5PQwMWlWCe4SuXlL2FPqYosPY
         QRoii11VMacDDccmKs3nEVUHVNCIaSmQX9g2Z72lweXA5XaCwe4xKFeHFrX5vIVSEARS
         AF3yLsdA5FOutD3vAo+SsHJjQz5DEtT7WsyLFr2ygEHVKQ1mJTT2LYDghokJ+uG1AYc/
         WkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736370982; x=1736975782;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVM62qWNY3HcZseHT9G2aNl4yPSR5DOCQCsjQBmWcYg=;
        b=Eyk6G6VFPbwV0CfSs0n/SeK8+Fxc3MmZbD24ek+pmlSYeMhj9K7AqhqNmGlQLlL4SB
         gpQJ1RTLFxAQmM73b++7/jSWMSkqDEnJQdolJbLlVFYAqzjK8qjWEiW359sicgGaB+Ea
         npuZTRDYAs8GF7Msx32c3VaTxyZs/lk0F1pOkJ41ylFqFXASeWreVIkYYjfgv69rw17R
         RyxozWVeqNo6niqtAA41WnLlIYHM5pGSwSK1hA1X0/aoVAzT89coAlV5In6i6xeh9Y9N
         sOWHpX2J+IMSgklWJdYzL4OPmdcJ0GG6ZcP8KKSJRZb1wfmpa83mUphg6+WXXzxfUfNU
         UAfg==
X-Forwarded-Encrypted: i=1; AJvYcCXuN0u6ITytUqijOlLPbjc7UrBJEZOmyfdI9FSR0zAF06IGzdcTwrUGm97HaZYPCGCM2yfwRK3oWWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWltaSXR1nSpNBkL/17Lu/W6V/Pzeek9vI8ZpcV1+KYKBTmoi2
	N9BgecHX1n2SpbzTt0dgYQK2wzdJ/pHzSmYZq89TGlO1WT1sqtoN8kMbbilkMQw=
X-Gm-Gg: ASbGncvenJLMIAH26cpYpmzDYo/TbEvaLAl9ADULIjBDklWDLLQCvNcn1ZXkFtJnu25
	T1CLJUGem3j0NWRXz0DlGSKAbiNhV84RXFdpA0WKiCy9B8e81tee1znmT3/VA1LqKKxjLMswoD7
	OrcRzrk8U5ph+BTxMpqhvpyyxSY3638QvLrUDKm3ddDr76kJfZkaZN2xk6FfKIJZYoCLOdtFPqv
	wAbVsW30mmvUl+MA/1p/vFUAWS5yIzDlB+Elov21b3BPT50vP3Q3BhKJAXshct/JVW622p2qHc3
	w8yNrLQHco01AG1Y+g==
X-Google-Smtp-Source: AGHT+IEmMxvKWJMOeR4+uH7/l+J4PhqThes0jhsV2r0+OgTq2c/ITTmo9FseDL8fxRugjRcrvmQOrw==
X-Received: by 2002:a05:6870:ce03:b0:296:e10f:af14 with SMTP id 586e51a60fabf-2aa06a052dcmr2009298fac.39.1736370982161;
        Wed, 08 Jan 2025 13:16:22 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d77f3bd3sm13646713fac.49.2025.01.08.13.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 13:16:21 -0800 (PST)
Message-ID: <80fa8faf-b5ac-4f3e-84b9-acf8ac6ab26d@baylibre.com>
Date: Wed, 8 Jan 2025 15:16:21 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] iio: dac: ad3552r-hs: use instruction mode for
 configuration
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-6-2dac02f04638@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-6-2dac02f04638@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Use "instruction" mode over initial configuration and all other
> non-streaming operations.
> 
> DAC boots in streaming mode as default, and the driver is not
> changing this mode.
> 
> Instruction r/w is still working becouse instruction is processed

s/becouse/because/

> from the DAC after chip select is deasserted, this works until
> loop mode is 0 or greater than the instruction size.
> 
> All initial operations should be more safely done in instruction
> mode, a mode provided for this.

I'm not sure it is really "safer". The way I read the datasheet, this just
enables bulk reads of multiple registers. So unless we need to do bulk reads
it seems like this is just adding extra complexity to the driver without a
tangible benefit.

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/ad3552r-hs.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 27949f207d42..991b11702273 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -132,6 +132,13 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
>  		return -EINVAL;
>  	}
>  
> +	/* Primary region access, set streaming mode (now in SPI + SDR). */
> +	ret = ad3552r_qspi_update_reg_bits(st,
> +					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> +					   AD3552R_MASK_SINGLE_INST, 0, 1);

Missing undoing this operation in the error path if a later operation in this
function fails?

> +	if (ret)
> +		return ret;
> +
>  	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
>  				      loop_len, 1);
>  	if (ret)


