Return-Path: <linux-iio+bounces-14474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2D3A15E52
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982C53A4372
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5170A1A840F;
	Sat, 18 Jan 2025 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LGupYWhD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312A1A83E0
	for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737221125; cv=none; b=MSL7NntenqqfmWzQQ6CTIoqdXF2BsJfBkKjsaXaEKdbV516NvZ4dqnu2k97M0HAe9Px+gNi6rxclVTttDW6pnY+RqWh4B8YAGLP0vNhT3pf0ohU+sP/tuaXC1Pdte0XCKkHm7rjXBXM9yY1zFDRT7jv/TmYpeEji1dlQcFhgaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737221125; c=relaxed/simple;
	bh=Vf23WEjHzjld5uILXDs2DveGFAjVVJvu2p0CeNLHjuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7iQunyIj0r3NZDwxrmiO9Z3dWc8gF7/wdOWDKBwcNS2T2j58rpj5CBGjTV35xogaNIk1dP8pBIwTZ/V8l0F1YomXfHqA6Qim1+ttjHY/RPgOWoE6RHomxG7uCeAf8+nOVMQkcQmuxKum7M/uub2SSdKJlytAxqCoEyfgNA9ctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LGupYWhD; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb8accbde3so2313568b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 09:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737221121; x=1737825921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mwRRCG7b4zpNfqNnKd/o9G6lINNdGagr6ZsElsfWxk=;
        b=LGupYWhDjoUGSj/TuCx0cVAjHiqGy3p/84YLb3M3OONBfCxFjFSW5EonRZySFUhGOC
         GvGuEKQLz/63/6L6e265/JGVaWvd74QoD1INasrK+LWgBwQk38VLkVSvJmKlQglWzUeA
         MhEXxjBTV9RTDeDpRUbz4wSufjSVHDgvOwSFLVijDdQ5jRqflixR1oFv+JNmZR4cT3OE
         bN7y3eMh9fAyyhgWq+a51xang42D/jkkvani7tZ2SiA3C1flTRktIN3qFa/LRg5HrD72
         KHZmLEL1XLBq0Vj53WCGKTg3UhdlcQoMRjQw9XgZ3kZ83ObuW6EhDKgfqMhcFqFfrXPr
         +feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737221121; x=1737825921;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mwRRCG7b4zpNfqNnKd/o9G6lINNdGagr6ZsElsfWxk=;
        b=M72fs1937s1H6ZrtBsBnWuRGvzXzdP0N4ExUi/JI0FyMl8Fjl2pLaDLqbGZjtUR/oj
         Bc6VpJIl0B3dnYNXoe8irovfX8MzzXbx+LWXoKGL/cxEU0PhWgDEcHJxLjRsLGODMOJb
         /lH7vvnBIJ4ivZiRC74zKHTuU6lOfCchw4nKLDqb1ja9R7eTqLViIF3s0r29aIkkVOwL
         j2CRkt+38TGfLCIbN0/W1zLTmRDwfrTb7oSW0eSK1nC4M5GvCW7PopBcHZ1V/e7BF5Gs
         GYJZhLNJlS05wCfgZXYBGRvBAH9wpH1kF5KJlEmepUvYUX0pSkfAO0a/uCp/wPUQ7l0M
         gm7g==
X-Gm-Message-State: AOJu0Ywbqy8SpEeSnLFlvLFqAAG8iPyC5QptZ43nuW1qjrbN0WxEnJ6l
	0mGHEnOEgmL+kNNFRaPGOwz5tjKaya+Ejb37CdeQa0W329vJ4U7YCoz5XwwPj8uVnRvR/RWEQSU
	i
X-Gm-Gg: ASbGncv1ywcBvxdrQCa+fbeKqGYBeid+MVCw8yGQONN+1LJJsimKWYSo1XbvuqjjsWA
	8RWJfMto6vcyazMD7zx4L3QMlfMYdqyYZX4Ijntv1DDnliYTpJZniUTMERocoDvnZvQ0InwHww+
	kcDo4+2vWRZ6pefp4cwjsaoFT0T8yc0X6srMc2gvy20eT1EnMNdF2qThxs10+sqBcdyKBMbEyNF
	UrH1Vv7ExfeOyThvXLfS795gJapHnS8FpckadzF4N3oc/OcHnv2TzRos27Cy5c00qmAvF8hlQyW
	8zCSOk7UHMmMrX09b5/T0SCkmTSM7Bg=
X-Google-Smtp-Source: AGHT+IGC/h/bcXL9Lp5quJB/R/LGC2dSCjqCNcjQrZp8oRk9EzSne/JnVr33zs/AqTLg2tortNDblQ==
X-Received: by 2002:a05:6808:8208:b0:3ec:bf55:e33f with SMTP id 5614622812f47-3f1a06f0b35mr4224632b6e.9.1737221121016;
        Sat, 18 Jan 2025 09:25:21 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19da7a23dsm1433375b6e.20.2025.01.18.09.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 09:25:19 -0800 (PST)
Message-ID: <658b7ff2-7019-4a7e-bd0a-58467032978a@baylibre.com>
Date: Sat, 18 Jan 2025 11:25:17 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/2] iio: adc: ad7173: add openwire detection
 support for single conversions
To: Guillaume Ranquet <granquet@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250116-ad4111_openwire-v3-0-ea9ebf29bd1d@baylibre.com>
 <20250116-ad4111_openwire-v3-2-ea9ebf29bd1d@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250116-ad4111_openwire-v3-2-ea9ebf29bd1d@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 9:01 AM, Guillaume Ranquet wrote:
> Some chips of the ad7173 family supports open wire detection.
> 
> Generate a level fault event whenever an external source is disconnected
> from the system input on single conversions.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---

...

> @@ -1375,6 +1523,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		chan_st_priv->cfg.bipolar = false;
>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> +		chan_st_priv->cfg.openwire_comp_chan = -1;

		^

>  		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>  		if (st->info->data_reg_only_16bit)
>  			chan_arr[chan_index].scan_type = ad4113_scan_type;
> @@ -1442,6 +1591,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		chan_st_priv->chan_reg = chan_index;
>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.odr = 0;
> +		chan_st_priv->cfg.openwire_comp_chan = -1;

		^

Looks like the same line added twice in the same function.

>  
>  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
>  		if (chan_st_priv->cfg.bipolar)

