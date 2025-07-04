Return-Path: <linux-iio+bounces-21364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DCFAF9970
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 19:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FDB189A03D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C04285CB2;
	Fri,  4 Jul 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZA86L84z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5A2E36E7
	for <linux-iio@vger.kernel.org>; Fri,  4 Jul 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751648650; cv=none; b=CSDhwjDsQfx3dSerQzBjrNrhQr+EJ/Ip3GxWPxdGoN8z+MEXqA8SqOiF3t3Xac8S58JaiG/gqVdPGKUqv5+bpzZdwVQwTcIqcm3ckhEvMsQPfmTAz9GgkNgIbKF2APGwb6pceWcOKhS7mO/lLHZCvpxnWopGK6XnGwBP42z429E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751648650; c=relaxed/simple;
	bh=lqYfplVOcJgRqG5FzapqJCwfBcQIrf/J0x6peT/mYX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gK/KJud4HgRCkPLhn/YkwZcZr2gFucJLlAXyeZHbIIeq+46McPclK3aTKu25WlGm7TFcA3NrytZ39pplp1pGzfLaMCM9ANgiBGlq5ACWkVGXfpHzKjDC68CN9MB8ntwGy0lP4RDvlPJhtOgjO7nVGHOVrrnI7MJRWuQmJCiRMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZA86L84z; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-73ac5680bb0so311805a34.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Jul 2025 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751648647; x=1752253447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CN3sOATSj+YBgo48N1dSK7mB6HorpFhEBYf8ysHRS7I=;
        b=ZA86L84zlZsZxMCk8Pw225Rh3S51iiA1fiqwcm4v14l87c6viFExkQ6x03wakKKzix
         nG3y46JVFiQ2pQFW9JHIpYEqByY2jBY/H9sW82sZ4s+lnKhJt0Yf3Hod2zMCHObEFSxm
         TUvRiUd81zwjp7h3h+8f9rEDNekERbJSCL8HtbBFgJ22zvCl4NWyNdRI2+I/o07QtQ5v
         dgo7DXNOpKHp6vbaga40Z8tJXAK+Eml8pu7TwXjzArNH1jgUU/SMbP+4/ykl253NvrZs
         MEbjIuAxYIT+3iex43rG9ck0/lMPkGrRy9DL3zH0cc6Yag8+SOW6TlM17M1DXBD2+es0
         04yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751648647; x=1752253447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CN3sOATSj+YBgo48N1dSK7mB6HorpFhEBYf8ysHRS7I=;
        b=cruJ/gVJNBP84WtVLPcY+z+Wv2QJ5vjeU+lAWh0wR664QetXDszvFDjFCetUG9DU/U
         St9QgESgGWONppuE3XKjGMUdOPmEFXhkuwj1pRvA9pbh2x6YEPfSo7qrAuYLfWZMTwy0
         K1A7Ew9RNuZpCFaGae+OuloSWtUkHtp3dABqgKZ+aRRj+Y0S0QcffsyCdSQ6Dtsi7sc9
         vGWhP63QEVSZn23WIDvPDgKGgwex1JofyhGtLyD2fFQsheUjjt50rwfDesHwFrjzjToq
         JgdhwD5yJvjrZoVywSl7GDk08WAdckqWKb+CoWFI+W0q2laOYu9cEZQfqkyuTTa5lt0a
         DBVA==
X-Forwarded-Encrypted: i=1; AJvYcCUwioSXG7Hvu2v+Y9qSK/emnJs4uXfc9Zh2afWaXoXavluQw3Raz8uHnC1kDa6Piw3UhAj6TPXC3hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ckCNOTVtmL9vuZD8RQ9YqY6QeULLWCiyxGsdfzKCFvuLbGKB
	uR+Bun4mUruZsud04oLMR6Z9DIm187vCpyH9+C2z4aDdAxMZqJQPmWb2D9IO4HVpBb4=
X-Gm-Gg: ASbGncu7goSyESEPN7a6qIPpAGjo9mdrd4BZ2UDS5tmXzNd6dFjhX6E80PVWb0ybySC
	JnoNyrTkBIRKSBfsQIIgZhJ+wiwviXBHaoPBYItk3738ck8FlJgZr40XIJCDFhRgAWNnnGrNXc3
	52xSOBpELmbXJGPrkQfY74/pcjDfhc8UTsuSguo47aiVSPct0WTCZw4RfF+QHuzNmrEthiaqoYw
	K0OX2G/9ptF/BFuCq3Ah9Isfox3X1iUgZtUpW8yIlVwCwf2BfbmXbUoMHAUrxHD0im+ofsgwZ39
	NO2jsPL48tiz3Lux1IPSnptc0yNJNUX82cn2ajg2Hz8GTrv+arTnDnNagv+Z/mmdALI5n0f3nhe
	RpaDygRhL84aA1w1urA0HHf3Pm8wRuWRwTjlAvq4=
X-Google-Smtp-Source: AGHT+IG8EgByZwQ/4WmW/RGFyJyd8LeDPxSLfts6w/ve/r5mPINs/1/BOseR8G5eXYSst8Wib3FSWg==
X-Received: by 2002:a05:6830:490c:b0:73b:bd5:b9d9 with SMTP id 46e09a7af769-73ca48f7d1cmr2267150a34.10.1751648646855;
        Fri, 04 Jul 2025 10:04:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d956:6ab3:7240:6bd9? ([2600:8803:e7e4:1d00:d956:6ab3:7240:6bd9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f9801dfsm435962a34.66.2025.07.04.10.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 10:04:05 -0700 (PDT)
Message-ID: <f023c92b-183c-4157-a6eb-ff722dfd716a@baylibre.com>
Date: Fri, 4 Jul 2025 12:04:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad7173: fix num_slots
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250704-iio-adc-ad7173-fix-num_slots-on-most-chips-v2-1-a74941609143@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250704-iio-adc-ad7173-fix-num_slots-on-most-chips-v2-1-a74941609143@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 11:21 AM, David Lechner wrote:
> Fix the num_slots value for most chips in the ad7173 driver. The correct
> value is the number of CHANNELx registers on the chip.
> 
> In commit 4310e15b3140 ("iio: adc: ad7173: don't make copy of
> ad_sigma_delta_info struct"), we refactored struct ad_sigma_delta_info
> to be static const data instead of being dynamically populated during
> driver probe. However, there was an existing bug in commit 76a1e6a42802
> ("iio: adc: ad7173: add AD7173 driver") where num_slots was incorrectly
> set to the number of CONFIGx registers instead of the number of
> CHANNELx registers. This bug was partially propagated to the refactored
> code in that the 16-channel chips were only given 8 slots instead of
> 16 although we did managed to fix the 8-channel chips and one of the
> 4-channel chips in that commit. However, we botched two of the 4-channel
> chips and ended up incorrectly giving them 8 slots during the
> refactoring.
> 
> This patch fixes that mistake on the 4-channel chips and also
> corrects the 16-channel chips to have 16 slots.
> 
> Fixes: 4310e15b3140 ("iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Improve commit message.
> - Link to v1: https://lore.kernel.org/r/20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com
> ---
>  drivers/iio/adc/ad7173.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..9c197cea11eb955becf4b9b97246379fa9c5da13 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -771,10 +771,27 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
>  	.num_slots = 8,
>  };
>  
> +static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
> +	.set_channel = ad7173_set_channel,
> +	.append_status = ad7173_append_status,
> +	.disable_all = ad7173_disable_all,
> +	.disable_one = ad7173_disable_one,
> +	.set_mode = ad7173_set_mode,
> +	.has_registers = true,
> +	.has_named_irqs = true,

> +	.supports_spi_offload = true,

Well drat, I was too quick with the update and the bots [1] noticed that
this conflicts with the in-flight patch that added this field [2].

I guess we can drop this one line, but then the other patch will wait
until this fix makes its way back into the togreg/testing branches.

[1]: https://lore.kernel.org/linux-iio/202507050018.iWEJiG04-lkp@intel.com/
[2]: https://lore.kernel.org/linux-iio/20250701-iio-adc-ad7173-add-spi-offload-support-v3-12-42abb83e3dac@baylibre.com/

> +	.addr_shift = 0,
> +	.read_mask = BIT(6),
> +	.status_ch_mask = GENMASK(3, 0),
> +	.data_reg = AD7173_REG_DATA,
> +	.num_resetclks = 64,
> +	.num_slots = 16,
> +};
> +

