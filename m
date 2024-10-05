Return-Path: <linux-iio+bounces-10217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D161B9919D1
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 21:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD481F22251
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0541339B1;
	Sat,  5 Oct 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dZmWHD4K"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-83.smtpout.orange.fr [80.12.242.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547D136E3B;
	Sat,  5 Oct 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728155551; cv=none; b=GM98RiHu5XCelnF0d76LVOtMscYgjMPpQkbb56l1syxFSn+krX5t7FGEC4CRE98pj2oVmkUwhI0W7IXsJIc8wJi1HO30pJa7YO03+aVYGbFIB5aauMbWa59GoUXzclQ/+fmvbQ4A6eQvfniUg6vg+25SfDX2779eS3POh0tQDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728155551; c=relaxed/simple;
	bh=dUW5FPkc6TiqyYbCkpJFU0+sWOPoy25nEgUuilRHOLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyPnmCGk6rIDZMfIH60KcTKr1t+jewbNDdNcP378vstBKCgPb/j4TE/aWwsam9SvQ6b9x1h6k4e/PDr44bDJt4YEJkRvOEbEBciQnLceOWslHe91rJ9SXT5AFfPgGjDCobKALyfIGOlGIQwIE2EQc0CW+JS2Gkx9FurEWMwV55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dZmWHD4K; arc=none smtp.client-ip=80.12.242.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id xACXsHetYzmbmxACXsOuhf; Sat, 05 Oct 2024 21:12:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728155546;
	bh=OhA3E58mj+rLNcMtdMfNrJ61JKFosbd/9IOaIzgO8Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dZmWHD4KENhS1l87rUrChXQ7DoiqmXSem5ckUd1Q/xXVgttHCRNz3Y1SGLoqNLxlh
	 JPYWIHLKiRlFvGkEfe6Gno8Mx65cOxVB7Rnf5mtTeIt6UhbfK38LyHzCECHxmRpta7
	 x7b3spvj5ZEIKOG0sSLItXCPbFylC/LRvw9nqUD/uqOcb1y1Y/oZsyrmH6xcr+2kj2
	 zetxWAAxTPsEgjYyMqXN/aKHfGv67YczY6iq1cuizz5Uw/4Js7PyuwqnY6SiGjwxFi
	 K2sYfML4kMOjHTJm4LN9qJ//PbRVDzkZWYQS/1TL5YUY3RXF8Dpi4tMbCvkC5tZMtn
	 m/78jWP0C/5Iw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 05 Oct 2024 21:12:26 +0200
X-ME-IP: 90.11.132.44
Message-ID: <5e4f121f-85a4-489f-8949-a5b02be99d09@wanadoo.fr>
Date: Sat, 5 Oct 2024 21:12:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iioc: dac: ltc2664: Fix span variable usage in
 ltc2664_channel_config function
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Mohammed Anees <pvmohammedanees2003@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241005170722.19542-1-pvmohammedanees2003@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241005170722.19542-1-pvmohammedanees2003@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/10/2024 à 19:07, Mohammed Anees a écrit :
> In the current implementation of the ltc2664_channel_config function,

Hi,

Usually () are added after function name.

	In the current implementation of ltc2664_channel_config()

Same for other function in the text below.

> a variable named span is declared and initialized to 0, intended to
> capture the return value of the ltc2664_set_span function. However,
> the output of ltc2664_set_span is directly assigned to chan->span,
> leaving span unchanged. As a result, when the function later checks
> if (span < 0), this condition will never trigger an error since
> span remains 0, this flaw leads to ineffective error handling. The
> current patch resolves this issue by using the ret variable for

Usually imperative is preferred in patch description. This could be:

	Resolve this issue by using the ret variable for...
(without "The current patch")

> getting the return value, later assigning if successful and also
> effectively removing span variable.
> 
> Signed-off-by: Mohammed Anees <pvmohammedanees2003-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Fixes: 4cc2fc445d2e4e63ed6bd5d310752d88d365f8e4

Fixes should be before S-o-b.

Fixes should be Fixes: <12 chars of sha1> ("<title line>")
So here: Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 
and LTC2672")

I think that running "./scripts/checkpatch.pl" on your patch should warn 
about it.

> ---
> v2:
> - Using the ret variable to store the result from ltc2664_set_span
> ---
>   drivers/iio/dac/ltc2664.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> index 5be5345ac5c8..7dafcba7ece7 100644
> --- a/drivers/iio/dac/ltc2664.c
> +++ b/drivers/iio/dac/ltc2664.c
> @@ -516,7 +516,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
>   	const struct ltc2664_chip_info *chip_info = st->chip_info;
>   	struct device *dev = &st->spi->dev;
>   	u32 reg, tmp[2], mspan;
> -	int ret, span = 0;
> +	int ret;
>   
>   	mspan = LTC2664_MSPAN_SOFTSPAN;
>   	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
> @@ -579,20 +579,24 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
>   		ret = fwnode_property_read_u32_array(child, "output-range-microvolt",
>   						     tmp, ARRAY_SIZE(tmp));
>   		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
> -			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
> +			ret = ltc2664_set_span(st, tmp[0] / 1000,
>   						      tmp[1] / 1000, reg);

Parameters are not aligned anymore with the opening ( of the previous line.

"./scripts/checkpatch.pl --strict" would also warn about it.

> -			if (span < 0)
> -				return dev_err_probe(dev, span,
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
>   						     "Failed to set span\n");
> +			else

No need for 'else'.

> +				chan->span = ret;
>   		}
>   
>   		ret = fwnode_property_read_u32_array(child, "output-range-microamp",
>   						     tmp, ARRAY_SIZE(tmp));
>   		if (!ret) {
> -			chan->span = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
> -			if (span < 0)
> -				return dev_err_probe(dev, span,
> +			ret = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
>   						     "Failed to set span\n");
> +			else

No need for 'else'.

CJ

> +				chan->span = ret;
>   		}
>   	}
>   


