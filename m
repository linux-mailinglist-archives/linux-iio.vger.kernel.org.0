Return-Path: <linux-iio+bounces-25063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927D7BDABFD
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 19:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5735F3A2B48
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 17:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B7192B84;
	Tue, 14 Oct 2025 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Tvs0SHE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4342050
	for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462130; cv=none; b=EE6nTYW9iSPGtei4j/2PrPMJRnqGYlzyLYRicXVlKBfYnIlnewT9u2He8T2x+LWZvezk35va0nPuVHbre/SIpfsAOuRSnmoLOZLs21VY5bMFMztVgE/z9w/GGrgEFAgFnW0nLizWbUbsdZgLkeNY1qBXU27FoPTx+L71ZixyVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462130; c=relaxed/simple;
	bh=3ONjI64bDHlizWo0b1LjG2CthUgBzXAqMnXVn7XR2gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thMgBjODuGYNnWr6i6hIFVmhbDsxjMJDZDoaoNR1JGHWEAKjhDO3bCbgaq7XHN5CdpoeyB9oeEyTv1JBKY/GGAslciPPfB2/onfZ6D3hY1zapMlFkxNVg9L23HqPBXKDZ9B6Wd01YEq9otSV0leerDC/bSQBIyaUEWfzGHOVUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0Tvs0SHE; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-35acca93e00so3339228fac.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760462125; x=1761066925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dusU1OwoHUTRpZO+ol4Oi2c4ECR07FH9nqxDuIlclnU=;
        b=0Tvs0SHEERwGFSt98e70UZ8sQdT0vqkiZCbZdUrsPBs8bN6pGgd2PZJnIBnPAaynzs
         tEEeXA5/y7CDkbNaJOLndQfuGE2Uur59nx3pszecmhqog2q6xexgdB/GqKkYsi1YzCdH
         aEzwtAC+0qBuDDczpqAoTWUuBJtMyOrUfpyS+E9HyQlbRjih9JMLLpur0gx+ORcSl8My
         U3oWAyOUK2rey5QtDrXhsSNX5N/h0pB+v9ARyPxVO4dIyc6wmFVL4A7t0VEmPT6QUxNv
         d62isNVmpbRxq4IP2XmW54ciLb9TGOQCho4I1nowr/IJDSaDLvg1faW4Qw9M4ly9bAOF
         lBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760462125; x=1761066925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dusU1OwoHUTRpZO+ol4Oi2c4ECR07FH9nqxDuIlclnU=;
        b=gLT5mnPJaFwATA3lrMjahqpxjCSC1sBinOM75oLkP/2q9ZmPaovZTHUNw9aioRfiBH
         k9fMKSRskQ6fUd+X5TylEGj2I8tEmUSB4k92sp8WW91TI/M4G4KV3SAI8rH+StcZvWPe
         77IHAgOOJbSM0SqVfYgvlRFPwQ9/QqBMMVWILuUSrVVbg1RrnaSouUle//Y0HeGg/HxF
         fBJaTfBOODKq4OpKQ1+oXsRUUbuDsUjI7i1vbkKXMLj5lwSe2hGNIs7Eq4yWh0gZamVk
         wE/YkWV9m+mUcBABTWPP0fQrz+kdGP6CSnDFGN61XGujrxGAReAGuqXOYDaJ0QjF/rQ6
         Afeg==
X-Forwarded-Encrypted: i=1; AJvYcCUcU99RGq3ecM4tGq2kfiqhbBHpQx8AQwGBsz3Qv5Vf+oveyaESF0IvwjqYJo4ytci/mxMMCyBm3Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9e6N/j3schjWQf7BIHbt+vHmrpdL1JvL0R4WSeU2m+gRAA8bh
	cYBnkLFkOEXXtUAnf6WtutDV2AP05BCiT653+g30C3BxlzoDEiFv051K4OU+VtiYisU=
X-Gm-Gg: ASbGnctwkzaKmUSrV8iTcdMNUj+WYL39dcZZvwW4IaTqq2JBiG6aCWbANFluoY+7iqU
	VG+B5+7ssGr+QGE4Bpyf8KsijASRbPPSgM93qPDw1YaJgDTX9BHkPNqGJDSil5JvUrDOHLfn79d
	6rDFC3wexnTebgvkzHKt5Iat2dxavWUrxjZy/KMhR4ThUJ4NWqydVE0CS78EzONXM9LGX92FuzR
	c/IprskikX6/YEVSOtFHB0xSMBpobw8XTB3+4N7wbbtKM6ic9p8uXOofS+/Hj5LDsOGaNJRyjF7
	lEv6IbcgTDDLpEoDzsxlvznlzyyd0kbDoMusM78kKKw+b5rFZakXjl0PVmzHErsttPqHTb1eBEU
	WhmNZRG7tq1NdllOo9eDj/xG5TTLM+bnei6uWUefFxP4VJ6qtKT9vbFBejcQy2N4xby+n1pfkHc
	+HWhB6NiXxJkV34ekuCMFCBDfcZw==
X-Google-Smtp-Source: AGHT+IH2XON5AF/q5jmgUfVemoJPjPBwzEhsYeX8Wb4sYr1/vwvblDxujw0DW1K9civYOHNuz0e0pA==
X-Received: by 2002:a05:6871:5b16:b0:365:7ea4:28a1 with SMTP id 586e51a60fabf-3c0fac5583emr10806067fac.48.1760462125485;
        Tue, 14 Oct 2025 10:15:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9bbe:7008:41b0:ed6e? ([2600:8803:e7e4:500:9bbe:7008:41b0:ed6e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8ae1de8sm4669422fac.4.2025.10.14.10.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 10:15:25 -0700 (PDT)
Message-ID: <03b3c597-0576-4468-a23e-cf6a4b7daf86@baylibre.com>
Date: Tue, 14 Oct 2025 12:15:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: ad5446: Add AD5542 to the spi id table
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20251014-dev-add-ad5542-v1-1-cfd197db03a0@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251014-dev-add-ad5542-v1-1-cfd197db03a0@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/14/25 11:11 AM, Nuno Sá via B4 Relay wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This adds support for the AD5542 single channel Current Source and
> Voltage Output DACs.
> 
> It is similar to the AD5542A model so just use the same id.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/ad5446.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index ad304b0fec08..6e4103f4afcb 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -422,6 +422,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
>  	{"ad5512a", ID_AD5512A},
>  	{"ad5541a", ID_AD5541A},
>  	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
> +	{"ad5542", ID_AD5541A}, /* ad5541a and ad5542a are compatible */

Should the comment say ad5542 instead of ad5542a?

>  	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
>  	{"ad5553", ID_AD5553},
>  	{"ad5600", ID_AD5600},
> 
> ---
> base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
> change-id: 20251014-dev-add-ad5542-8c8934de80ee
> --
> 
> Thanks!
> - Nuno Sá
> 
> 

Interesting... no devicetree bindings for these chips?

