Return-Path: <linux-iio+bounces-24275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC15B86B77
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 21:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCA91C81831
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DA62D9EF2;
	Thu, 18 Sep 2025 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UpPMRvqf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530852D8790
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224347; cv=none; b=VV8iDsnIu3iUU7t87S4OkfAjs80CrPGnVdXGaI18QuV3d5ZnsyloU/B6dih+ydpEkmy7gXBc1R4a4W41L9WMLdsLHS39JBaF6kTEicbRK6kKVtglc3cA45iNRTdsHsuMcrBx7U517o4daGleEEMG6MzeLVyEnzmwyO3si69o8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224347; c=relaxed/simple;
	bh=VQ3t8/qxZa8M7ApZdBgI92YVOKX5tQcpsXI5KcrvT5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJQfvv6WzaGEOjgI0QqAy3wH5JgOPP5XOZ7jhOjpju/K/ZFuNyh9ox5hczGoZDqyS91VrxG804K3BQgrqaEn7eC1b54sQot3qYPsT1ZKxYSUCjxh+XfsVzUjS0xeiWQ4PHepJ5mAz48yMB0hrKYR5HhoBQPRvipgSBnk6MoafLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UpPMRvqf; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-621a3c43df3so626958eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758224343; x=1758829143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lC1D1RXpqGWlfeokss9Ec91Msfh5uPWlxYgo1Th1KKE=;
        b=UpPMRvqfOgPqzydGEl7JaO4hSSi6dZcUjUkHSSoIz0DfqyvkvF9j/JsdUOSOYTuWhl
         o4jfmM7W5OJJ6zHMOS966ArVDhX66r3qIhCNyNAj/V5S/+eRnEUl4k/slQRRKch3DgS9
         1YXJQznDKqO0M3OQmVewpS7qGTYoAp4N50yo7l1yNvEz5eFrGGs5OHZCc9Lo+O1wNXLq
         SiE03ZfxmRahrzrVmBUYgrc1bMe2B6N/vEv1O/lZqi11l3GtvwdeXe8HMks8gQtDDZ5X
         YBAXo4JzP/OQgVSRtlPYASsrot/bGx966NlHvOMADKz4IdAl0D46ACEB4aAzub+njKCm
         2dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224343; x=1758829143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lC1D1RXpqGWlfeokss9Ec91Msfh5uPWlxYgo1Th1KKE=;
        b=iP5gb+npV4TKYoVA8a2lIDjk2obsWQu/1HWQL69kel0NjEqvox7IBdX6/aMq2Bhb/2
         pdvv5pINc6259V2qBKW37Hylc8TL0UbJVslJNs0gIeiFa25VOlGeAHgMQotAbEfrYYnF
         09qxPJqRJ0nAotbGSkAPyISl8hUmdqo7piYDbUj2Jdcp+aHq2RQTEpLMP6u5dSsli57r
         g8cemr+lcfFsNJoUT9i84j8WiU/7QIu+2emmmdDu3aaMxTTPJmTM+EGdQmEvxCx9Prj4
         qXrEBE6PDVJhrOwfKaXZgheeNEQow3UcGY5imbkt6HEa5XZmISMg0M3ppec0eYOBPTyN
         dhgw==
X-Forwarded-Encrypted: i=1; AJvYcCV2AfVi79a+Gz4aIE+wA+XK9B3Kc5zfrIBDQWUzPkQl4eiJJ7Ov5nUmd9X640ekpplqMIrRZUd3xyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNy4P4llVjiDlp6DmchlxbE7G/ZszOaa4vu9WhT+D4IBr5TxL
	s2NlBj+0NBTyfr03fxskwB8GFvH0BTaI2AMgx/3PF142ToaP4EOuBzcIcbmkZ4aOyDHeuwi7wdM
	4w8ZIjaQ=
X-Gm-Gg: ASbGnctaMucZxoDl1AdgI67P/VTFlQVrGBML8g/SefmbixYkxhmr1vo7UH+wexiZULI
	eelZqZbP9TEZt1fb0npvSfK9tuURaAzo3hs7ur4DBwbFI5BRLRh8LIcDXqXEebNEkcmZl9ZN1fF
	rsUSdpR8cKdiBg4PfVprSSlv4+lipuUmuJeEf2/zJnEEdxokBkydMPXv6HGmr3pzk/r/zwPLE2d
	R91gihrY6AG6IPJhJLfC9bqGOLOJ3s7EST7VwheCi6wvrgr7sQ9yf4IY8VtvtEiHX8pxXw+Ct3v
	pz7WgM+ihLcHhwhsSOfcj4Ke/s0EKsx7axfk4NqdoB+4XIog6sxmNujQ1LuGYEMON9P2+rfUoqU
	2zxcCwT7ZIDnUd6bSB8erstHpSpzhmMxd7b6JE7Tf7rXags3EESrMiufqjyyBBT9qcGRNAeyb+W
	lluansI8wZ4WMBHRW0Kg==
X-Google-Smtp-Source: AGHT+IGwPYMqQBvoGrbWLKmtCrh7hU1R/7J5LL0cXcvqHKYJ/id7TQ+ISZN+tixS6oxGOqJOrN22sQ==
X-Received: by 2002:a05:6808:198f:b0:438:bdb0:89b7 with SMTP id 5614622812f47-43d6c2c68eemr244526b6e.49.1758224343041;
        Thu, 18 Sep 2025 12:39:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c881af7sm1142955b6e.29.2025.09.18.12.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:39:02 -0700 (PDT)
Message-ID: <f7d7f400-cc43-41d9-bc97-39d308363f14@baylibre.com>
Date: Thu, 18 Sep 2025 14:39:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: adc: adi,ad4030: Reference
 spi-peripheral-props
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:38 PM, Marcelo Schmitt wrote:
> AD4030 and similar devices all connect to the system as SPI peripherals.
> Reference spi-peripheral-props so common SPI peripheral can be used from
> ad4030 dt-binding.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index 54e7349317b7..a8fee4062d0e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -20,6 +20,8 @@ description: |
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
>  
> +$ref: /schemas/spi/spi-peripheral-props.yaml#

I think this is already referenced for all child nodes of a SPI
controller because of pattern matching of:

patternProperties:
  "^.*@[0-9a-f]+$":
    type: object
    $ref: spi-peripheral-props.yaml

in Documentation/devicetree/bindings/spi/spi-controller.yaml

So perhaps not strictly necessary?

Would be curious to know if there is some difference.

> +
>  properties:
>    compatible:
>      enum:


