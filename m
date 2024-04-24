Return-Path: <linux-iio+bounces-4492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE62D8B08CF
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 13:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDB4B24AB1
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437F915AAA7;
	Wed, 24 Apr 2024 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dewPXTB3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8E15A48B
	for <linux-iio@vger.kernel.org>; Wed, 24 Apr 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959887; cv=none; b=AaVUToj1AHoG8eqNZYVJNL/KWTx2fGNSdn9dFyczve+ALgf3zJGDFibYum8YLrVkzR/4qA2WTwCRZlwSFlTp0lJkjhlL493Zaddp28mJQGR+VlOJvMsR+ksIxwHeOklcXIjiVI2hWWACnGRahyIxUwHOi9ubYjcFunePfYnkQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959887; c=relaxed/simple;
	bh=emMWvZcEAzhT3YKKh9o3OcDcXSiS4xqHIaQQ1tV8Xio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3ScCJD9+fCTFfEKwd/fO0D6YO5QaeNpskYLcJ3rrInzIka+O076YFqrnctMBc68+IwBQ427swqBGlWsfWfuNRjy61QocppIphZZPTmJdYnFe3eaHnjoBTA9AcUKlcY0fPLCRA3ZPuj6X0yhcfJhZTqgCoDVfDo+4bi1FeyCpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dewPXTB3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343f62d8124so5498253f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 24 Apr 2024 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713959880; x=1714564680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmWln6bKBG4CBrts1lYvD1pj2KHD3HpMCL9FzHeEXI0=;
        b=dewPXTB36durv0/qDUf4Ov/TB7PrX3+kAkUNRPKkomUDtlOxvxV1yT1wImfF2fbYQq
         o+Vyt5CdWQXcMIJDgAHUkXYeQaMImEVWBrnaJQGGhRL1wGM+e4EK3QKjUE3YqoXQ/Nxs
         WDB9mcpyROHHfe87eHGS0OD4KAIq8UeNuNumBsRpmY/LcBZcTAEisawC1jN7RUnEzvOj
         SPm1xO1SnsMBpW84YQtWeIBo1wys2pijC3DYE7f9LbMx1OLGZAMNTbQzIXJih58Frisp
         mWvOnwNHPgfQilbeTv+okkmto7pMCRC9MbDkMx+d1A1yFrwZYV59+4y38rVwxaLLFEN/
         h2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959880; x=1714564680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmWln6bKBG4CBrts1lYvD1pj2KHD3HpMCL9FzHeEXI0=;
        b=IsBrGUuKNbo+LE101mCBK9TQ5htFYYp54b8XzwdV6XIUoUEudPiMtRcEzy4Hf7NgYg
         tFu8cA+5PYd2DVzrR8uFLueut6vwTUjJYLO8wudNazG3uMYKcdpN2UR0I1MdBKpqmQVr
         ryD/q2pgtI5obExKxL6BrQ7HGfPL9dmZaOaVdgLNGgkQkBwv31eSiI3iWYLt9BnYKMpk
         FQ8m/r6EN5UZii8RsS3id8MvsmouPU5dNYBo695s7H1yS4vAZNpl1wdVbDrcfA767Aek
         h41ynOoBIFWvwDGwf3dKTYtVtP81czDYW3rilWRJ/+3GV2zF9c5ULO7GeQPtRuwWEJin
         Ap6A==
X-Gm-Message-State: AOJu0YyIqUWQa+sG9z/z+xQVzgt9xbX7qW4IBIug4eL2gNLy+m65260K
	gL5WUI3DvYOFazUb1ji9BD+GOOamldfKsBf9eQqsi3/hDU9VMhRo8dYRsF10WqM=
X-Google-Smtp-Source: AGHT+IHOnvn/t+h/tSQVqcM9yIg1JhxzGapSUpkhBbLv4cSAI29WzDIVYD+89a2zzfjV3Y8FDksjug==
X-Received: by 2002:adf:e5cd:0:b0:34a:4d1:b914 with SMTP id a13-20020adfe5cd000000b0034a04d1b914mr1523700wrn.48.1713959880346;
        Wed, 24 Apr 2024 04:58:00 -0700 (PDT)
Received: from [192.168.0.2] (host-79-16-8-49.retail.telecomitalia.it. [79.16.8.49])
        by smtp.gmail.com with ESMTPSA id h16-20020adffd50000000b00346d3a626b8sm17175456wrs.3.2024.04.24.04.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:58:00 -0700 (PDT)
Message-ID: <5982db7e-1058-4d7d-a434-cfe0f7aae326@baylibre.com>
Date: Wed, 24 Apr 2024 13:57:25 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: fix ad354xr output range
To: Angelo Dureghello <adureghello@baylibre.org>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org
References: <20240424101848.242749-1-adureghello@baylibre.org>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240424101848.242749-1-adureghello@baylibre.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

sorry, please consider this a s 1/1.

On 24/04/24 12:18 PM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>
> Fix output range, as per datasheet must be -2.5 to 7.5.
>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>   Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> index 96340a05754c..8265d709094d 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> @@ -139,7 +139,7 @@ allOf:
>                   Voltage output range of the channel as <minimum, maximum>
>                   Required connections:
>                     Rfb1x for: 0 to 2.5 V; 0 to 3V; 0 to 5 V;
> -                  Rfb2x for: 0 to 10 V; 2.5 to 7.5V; -5 to 5 V;
> +                  Rfb2x for: 0 to 10 V; -2.5 to 7.5V; -5 to 5 V;
>                 oneOf:
>                   - items:
>                       - const: 0

Regards,
angelo


