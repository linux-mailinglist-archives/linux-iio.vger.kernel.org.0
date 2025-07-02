Return-Path: <linux-iio+bounces-21260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C94AF64B6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 00:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B82A7A956A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 22:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567824468B;
	Wed,  2 Jul 2025 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y48xNPQ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4941E9B3D
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493673; cv=none; b=FYT7yzTYgXeZaA2n25BxqW1QibJWTwxZ3QZ7W/oRu7uyRwvotXxgJkRy7F+U4xez4aGsrZZomciX7g8DuI9TCCuBOYYiJa6o1Rp21zEYn85KXXuMVmii7YZBfpjZ/ETgRqrmObxCB6AXQfbw9QbbfXlXN1vKbElgxEgtwUJ2OYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493673; c=relaxed/simple;
	bh=hjhHlOolfaZNDUs+RdvLckgniM7ltNQJFdfTBZFssqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LWpnTwRMGHPiv8B/zvfdtZH+/ykj/RKBq464zrTJygTMtdJDYeVlFHNYD6exKjdxh74ZV0gCux92BWylTp+QmiM6DINJthCpe233F4fnd2lPPWB9beY4bwkGbeVPQiNsgx4fzRcpvoZEW/26YykHcex7eaJmMhC+49OtTRVtCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y48xNPQ1; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73afbe1497bso2718902a34.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2025 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751493669; x=1752098469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKgWS7/qdk7+Eg50DbHdDl8mGYC2JyCvr3ER8bCDhe0=;
        b=y48xNPQ1VGFonG90ers22n9CaIGu/U0THcQn5c8nBkrNDl4s9PaFjS+j1I6g9WKNKk
         AIt90eg9oaV1EgKUwMKqT6KK+6qZm0ycbC3hNp4m6EMABEfx09alAUON+kWaoxtIKcLc
         KpF0R66j9mNHBxgK3gVzHPFVU3zoE/wqhAbjqow81uQxg+cfY447RdnKngepHdBwkEoA
         erkhwbWUhLFkvzceqJ0cHWv3nN9vR0F3ZV9QQRRlcAkjmr2yRwkjT/VoCkPEvvC4uya0
         +4NGqWis8xoTuzKwFm7oiFKXthN/Lw8UdUwMqdkbwyOEA+arjT+4IL8OlrccbhJhMKY1
         F5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751493669; x=1752098469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKgWS7/qdk7+Eg50DbHdDl8mGYC2JyCvr3ER8bCDhe0=;
        b=CDgaGmIlqto5XAKu9+N/jAs5WRiJ750NU69E1PIIN1WLpY5MkqMXR4OrXJO57N1glp
         m1SsgzNTj6TqukyYfhY79Dn527Ovoj6iICp0oLGHLj2tqJvxZRbicrH/vbRVpLk1UFPo
         i3NlVFA69QtCMa9sOOZb2xdeL54byuGU/IAjOZxMYf1Uwmb9q+3Kp9A2L4lk1ozm9FH5
         Zw71h2B9p4gnEtGzwq6RHNYwW8cDNRnkdIvi/wgNB3iuR5M4jn2LgrhT0Zn8qQXM810p
         o5uMEv/8Arfjyy4cZs312f5OAf0uUt7/6zxyWHyGsHYNRlZ8fJ2tfJ/YbgIFFLBiibe6
         wcdg==
X-Forwarded-Encrypted: i=1; AJvYcCWa1yIOoWN9dgLz7WK1V+EHraNr+GpOvKXpLFapCQA1YpXn7emXTCX6z41DIk9fy6LPLtA2NQXcumY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8l6m0xw0v+FFGKP8/y1VTCXCEEh5079p6BwMebYYKkSQa6/e
	1XX8Fp57zUIwebcJpZCmAnYMzhnv7q2hGA3ETtUmQRU9mVv1YoiXUBXF/wUD6J7oqpI=
X-Gm-Gg: ASbGncuECzKjmCZaE5JhyEi3Tpgu+dxZL/W8d9z1XSJZS41n5BnavczCKWf5/1pUULB
	ODWxoYeovPnPpKX+IHE0+FOPF6N8RCFPdv2lePnF/UtS5upKcRlERRgbPddF3ZevujOEhH8n4B9
	AUzhCPcu+4yVaMN2V7VDlTtGlALfkJxlZ9+bAyi7mKbFKwQJs+j03Skwx5v3hq7cU16HoJBen4t
	9d5isMJ//SCH8b5nBH+n/rD3cbb5SwI016/HG77ey1fwEEQeKXn0LL9x/oZXCYZxZ5y28VEMecu
	9nUFr7IhR4t9NZfOy1AUOsI1fks+I5vQsUDdfySYuEhkJI7ia3XEEK7KlgverbrBLvhl5AAofB2
	0/d3lXTGPVah6CVBWlIsXufM+xq1r9QUvzxiN46g=
X-Google-Smtp-Source: AGHT+IHKZNhePlF0+T6dWuoOeOIoDbpvywH95ABuicUB05Dmc1aVoalsdNueqPirXs97Btv0KkGWcg==
X-Received: by 2002:a05:6808:e8a:b0:403:3673:65f0 with SMTP id 5614622812f47-40b88b25dc6mr3169424b6e.31.1751493668851;
        Wed, 02 Jul 2025 15:01:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5c00:24f0:997b:5458? ([2600:8803:e7e4:1d00:5c00:24f0:997b:5458])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b32420c83sm2747613b6e.36.2025.07.02.15.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 15:01:08 -0700 (PDT)
Message-ID: <a30cbe3a-7d1b-4072-880e-99688657a093@baylibre.com>
Date: Wed, 2 Jul 2025 17:01:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add support for MT7981
To: Aleksander Jan Bajkowski <olek2@wp.pl>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, zhiyong.tao@mediatek.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250702214830.255898-1-olek2@wp.pl>
 <20250702214830.255898-2-olek2@wp.pl>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250702214830.255898-2-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 4:48 PM, Aleksander Jan Bajkowski wrote:
> The temperature sensor in the MT7981 is same as in the MT7986.
> Add compatible string for mt7981.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> index b489c984c1bb..ceb914dde15b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> @@ -26,6 +26,7 @@ properties:
>            - mediatek,mt2712-auxadc
>            - mediatek,mt6765-auxadc
>            - mediatek,mt7622-auxadc
> +          - mediatek,mt7981-auxadc
>            - mediatek,mt7986-auxadc
>            - mediatek,mt8173-auxadc
>        - items:

The new compatible with fallback should look like this:

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
index b489c984c1bb..14363389f30a 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
@@ -32,6 +32,10 @@ properties:
           - enum:
               - mediatek,mt7623-auxadc
           - const: mediatek,mt2701-auxadc
+      - items:
+          - enum:
+              - mediatek,mt7981-auxadc
+          - const: mediatek,mt7986-auxadc
       - items:
           - enum:
               - mediatek,mt6893-auxadc
---

Then you can validate that the next patch matches the bindings with
`make CHECK_DTBS=1`. I would expect it to fail currently since the
binding is specifying a compatible without a fallback but the .dts
uses a fallback.

