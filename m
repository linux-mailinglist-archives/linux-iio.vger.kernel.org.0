Return-Path: <linux-iio+bounces-14039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F53EA066C3
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 22:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2566218885E8
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299A72040B0;
	Wed,  8 Jan 2025 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f8zb/9Za"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B91AB6E2
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370054; cv=none; b=eSRAuN4PkZ83TI+WjBvtXtRKL2dqVKnxq3kFQf5z7JnhKbuZZBfDmqI9asD/84xLlK5E04OPdrWtU3gE1EnoPXf7W19Nk2gxQcW7J1e3LA2DfgZ/zyABz2p4E+SjEzDdda1LugxrUdFMGCahOxbFNmnS3djfyG/4nBJrKLYb1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370054; c=relaxed/simple;
	bh=68CJqesHp3uSJcPbz17PjXhGhSmRGGTtP0QJgfgk9lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulOv3OdQNcE9fxL8IKXXk+wDQ251+OqjBViSSP52TBNdlYB9Tec2jeeC0BWRwYi9YMxWbmNRSqAP9w+3pYeoEY7B0F2DfRxr6cvsM2ueLnjregtByVdSF0A36Ezr/ts0N5kOUixrK1p5onznAOBxhgH6lyAS6z7HKGoD3ipiF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f8zb/9Za; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e1b1767b3so108063a34.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 13:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736370050; x=1736974850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDnqOVGed3Z+1J1pMi8WN3nNgxVZA2Nk97dTa2PI2vo=;
        b=f8zb/9ZayaSfXEvZxuUKtCnH7VtIjF0jEEG4HYfNElVc2oLVg5+rOKQZ95NKPz6jrU
         2daczXndA48bw16F0y7TxHcpn+cCxmHTYL/i0vy2m2pW09v/X1TLioXanpjCBCYhJqyW
         klDXjibu6bLut4m0PzNhGh1/owP5Vm/+2DSH5BQvQYz+27fjvqEJF+eC/1fLY8wlZWEi
         95OYGp7ppIswhFkBhDuq3h6SGdECCds1Bz03rXfyqOyWb3FGA4M2U9BsRnEGNOTHNb/g
         ff25q6leKFHDZEEQ6uvXXOTWNygEAo4RZntirngPiwns06Yrj/ghpqaZ8NI7qEreha4M
         MMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736370050; x=1736974850;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDnqOVGed3Z+1J1pMi8WN3nNgxVZA2Nk97dTa2PI2vo=;
        b=sKeo16PFyycYhWYqKlRf5WZ1pq7ocpyyTsVFTXT4HfoJ+Z1l3dVmXg6YDO3O0R3qa1
         esSTZiIb8TF1woSOBYUkpy/iqQEs/CvjSGqf+au3FK6YG6AXuzgsES4Piya3yNXlV7Fe
         yZGb17coXfIYTK9H8np0UlRRnMvKUqp4qCWxITa6ycRIXw0iOYi+bdixhNjezSP5GYTd
         PjDoRoBZvS4ebclyT29Pb7Zv2/YGdJRJcl15xwDVlF7HK3MRFQoXVuCQ7z5kxZKB2Qdz
         FpE6IHFN68+K0y4+6n1PDV3Amwb5O6Rl9FskJMBU8piAVFxgJyrgyVeluyQ4TZH15vjf
         XbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAbHBCk/FCJ94NqzxVmWd4QgTiGbhGIUHOSWH4g1PY890ngheKDAsHRps8/Dvf+aUGAGnoz5lnSlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFvPH5cJOiAoSj4cUzhm88KRJqFbEkCfWHmEs+JAVAVIOijoa+
	/gC/TLXOisuWugKi4s62YUs91yBjF+SLAqwL8FC+nb+67xsl3etnPbQjPyjhw0o=
X-Gm-Gg: ASbGncugPgXcJsx4if0sqX6VdM52MtWGJpo3MLaLUMle/GYRSXvaO+PS5GMnnuaAmaP
	7+RcYAu1dutOTKQk0nRZw8AtO4br4PtfDyixD6NFA+Idey6HFRkSqKuhCxvOh+9Svu0RWne8MVu
	HV9To0tRy4eI0vYeF6jNHDvhsY5fN2/TXpv7yR4/QsxIrKiDWrasHxdDUxZ2VYJ5ASd2GgG6UQN
	nehmS2NcB9kFTaqEQZBKUYvKbzwIbg6OhrxKz73f51P6jTxePfj/UZjk3kQGShynkox6wwFd1sk
	oeXKJRe2srzIbho2WA==
X-Google-Smtp-Source: AGHT+IEXW/0Fuzlx4zBJ6bqcrNtKwhmnVudJ9gy5WUpU3shIF73rSq8aJbAefb5yti3phkinm40t+Q==
X-Received: by 2002:a05:6870:2a46:b0:29e:2da3:3f7b with SMTP id 586e51a60fabf-2aa065102fbmr2087041fac.7.1736370050697;
        Wed, 08 Jan 2025 13:00:50 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d77f0d9esm13768059fac.46.2025.01.08.13.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 13:00:49 -0800 (PST)
Message-ID: <da4fa029-048b-4ada-bfe7-9194b6886436@baylibre.com>
Date: Wed, 8 Jan 2025 15:00:48 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] iio: dac: adi-axi-dac: modify stream enable
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-3-2dac02f04638@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-3-2dac02f04638@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Change suggested from the AXI HDL team, modify the function
> axi_dac_data_stream_enable() to check for interface busy, to avoid
> possible issues when starting the stream.
> 
> Fixes: e61d7178429a ("iio: dac: adi-axi-dac: extend features")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/adi-axi-dac.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index b143f7ed6847..d02eb535b648 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -585,6 +585,17 @@ static int axi_dac_ddr_disable(struct iio_backend *back)
>  static int axi_dac_data_stream_enable(struct iio_backend *back)
>  {
>  	struct axi_dac_state *st = iio_backend_get_priv(back);
> +	int ret, val;
> +
> +	ret = regmap_read_poll_timeout(st->regmap,
> +				AXI_DAC_UI_STATUS_REG, val,
> +				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == 0,
> +				10, 100 * KILO);
> +	if (ret) {
> +		if (ret == -ETIMEDOUT)
> +			dev_err(st->dev, "AXI read timeout\n");

Do we really need the `dev_err()`? I think the ETIMEDOUT will bubble up to
userspace anyway via buffer_postenable.

If we keep it though, it could use a better message. The important part is that
the AXI IP block never became ready, not that reading the register timed out.

> +		return ret;
> +	}
>  
>  	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
>  			       AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);
> 


