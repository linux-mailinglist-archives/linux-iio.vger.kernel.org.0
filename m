Return-Path: <linux-iio+bounces-22690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4BDB25500
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 23:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D417B8EB5
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950722DE216;
	Wed, 13 Aug 2025 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d6OTku5E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065492BE05E
	for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119524; cv=none; b=ZWlOSTJKXZc/rg8YNLAvB7GZh8zHbj12DKWtnktdKiH5MnrYTyZfcTZwt93bNME/qYVd5LFhWvm4Ubol9VALBTh227H9LEMKMMIVGOCC3uA8QK3WKo0pwbB+PxsATTWDPfb8MCNueY6ARmblRzYH7xl9bcFboF+DEp0WTXaOiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119524; c=relaxed/simple;
	bh=27dZsSSc1FtLXlHOWPlo1du2AL2+YgSkzTVnQqxIWgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNn1hYCAFQoycSQepuc+hp1dinpslZJ9Bb92fGD8IWy47AzfgnHFwjRVt04bdrmbsvfWAb33cdzM+WJz6qP5EICzmeBhHcI2GUFA/xVrCBX3wsy55yxJck6EAMmAaGzv4gKAAEZasQVqiJg2e/NVmzd0cb1uT3RUMgOnNWhjG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d6OTku5E; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74381fdb5faso148181a34.2
        for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755119521; x=1755724321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xf3//GLvnzT9i6WfKITOLt4ui/tLiyvxxLpHItWn5zc=;
        b=d6OTku5EfpvZOZvCDJTaH0fK6IFEjDOXJfxOdWGVJ1S6f5B1yAFp53KrV1d4WxIQqD
         D9aR4j5PZgeMZyI1MMryu+iHlZZAv0UZSMbSse32lRDZpfo3tXc232UbuMpjy+5Mio5B
         DxjVPlsjnOzdRjtYt9K0TQ0WfmNmWNqiROFpS3eKLTncTgB4Owg45lXVNgZFlJoPIexu
         DfiOiaRy9qG+7OfPkDpE6RlMcmrAFWIDDJQPI22qmiRdz44aTSpOsgeTfp40bNhK0Jtk
         1BHoIYQQzTCF4q2yWc15p31RDZlu/WrkdR8ij4dhzSmSostqMQXtDFbvNhO+rrRJbj17
         tOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119521; x=1755724321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf3//GLvnzT9i6WfKITOLt4ui/tLiyvxxLpHItWn5zc=;
        b=lfQud0IxgvgihTJHgrXtwb70/KzVPjtA/lI8dT6AhaKbHsYh+zRB7HlCOuwO5FINOB
         HP3a7KYn6EbSZeuG2WBbtxR00l6B8FHSws8e1k3Jn30HvJEATjiVPmB9wkd7STMvoeN0
         2ohu/gprgR34meXVazPtn4ZT2j0JpjlkrPYkWpG62dyLs4/Xp1yjf+0SKAXpx+Xj87z4
         gBgj5sfd6k9DjXtDIAd5+JTCr5OSoa2EnICoDO53LzJ7IqeM31HG6eVM9ocAVo+T224v
         ULRp+LmwGPYlDaBVOgi0AS0FpgkQ3AWJCI5KABL40JcNSTNvIp+OVJMi9y74mVo8blMN
         mcHA==
X-Gm-Message-State: AOJu0YyLWUSkXw5LGzTeh//jeWaJfAKGI7h0U+ve2Pbz2JPTPmpFph7E
	1aTL2HTyLSnFRFMsfbQp9z8nlu/yq68oIMOXmsmyO/4lyIK2Wm98nmtV5rk5DGGXvRg1TTUh2qF
	+jtVZ
X-Gm-Gg: ASbGncvQNJuqP8Xv2YJ6r53hQHvhivNTXo6U4XRuCMk2x/83YjLHgP6M9ny2wRJYykW
	3sL4IewLOaCWdZspQ2kdtY2QCdqN0G+3xulRza2/gKNeZvD3VbZdubuVd6fP0+EAO/Cb5iUg/Gn
	JJExwVPm8XtEXX0MZfnNY7c4mXmwWyUzqi4IAVEbAjaen+7zLAZ3kzqh1mWPLJeyUiJTgrRHXqP
	2TEFQgqb6eTqj8kjrgdEuzyhqFSfxoqMIJVuJ/aehErpLB2z7V7Dna2b0ol40SsP3hz2EEAso+I
	5BpnMQS/V6HKRUs2b3tp2kx7owkw96E0pCYUd5whplTH04B7m7pSQikf1bMLsEs2w4xkVydRB/M
	e6KCi+CM73nFBs5CKlnBwNgKBgimyNsyCWEs+UKxxu+3hw5bUplcSt8y59XS2DL6ceCMAv+ssoX
	NVQNhODCo=
X-Google-Smtp-Source: AGHT+IF9n+F8e1mm/IyBfw7ePpfBTnEUME8yX6HA27qwsIWM/khGHlIzwyYXURZx3W+3vhm1Xj1CzQ==
X-Received: by 2002:a05:6830:60db:20b0:742:f93c:194c with SMTP id 46e09a7af769-74382c06774mr157158a34.27.1755119520991;
        Wed, 13 Aug 2025 14:12:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde? ([2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30ccfdf5075sm180592fac.1.2025.08.13.14.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:12:00 -0700 (PDT)
Message-ID: <623c0ef4-98c0-410c-abf3-fa9563f52688@baylibre.com>
Date: Wed, 13 Aug 2025 16:11:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-2-bcollins@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250813151614.12098-2-bcollins@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 10:15 AM, Ben Collins wrote:
> MCP9601 is a superset of MCP9600 and is supported by the driver.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---


Please include a cover letter with a changelog in v3.


>  .../bindings/iio/temperature/microchip,mcp9600.yaml         | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> index d2cafa38a5442..d8af0912ce886 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Microchip MCP9600 thermocouple EMF converter
> +title: Microchip MCP9600 and similar thermocouple EMF converters
>  
>  maintainers:
>    - Andrew Hepp <andrew.hepp@ahepp.dev>
> @@ -14,7 +14,9 @@ description:
>  
>  properties:
>    compatible:
> -    const: microchip,mcp9600
> +    enum:
> +      - microchip,mcp9600
> +      - microchip,mcp9601
>  

It sounds like it would be useful to have a fallback in this case:

properties:
  compatible:
    oneOf:
      - const: microchip,mcp9600
      - items:
          - - microchip,mcp9600
          - microchip,mcp9600

>    reg:
>      maxItems: 1

Usage would then be:

	compatible = "microchip,mcp9601", "microchip,mcp9600";


