Return-Path: <linux-iio+bounces-22513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DECCB1FAB6
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 17:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921221897922
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3626239E6F;
	Sun, 10 Aug 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alXJWsza"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AD29CEB;
	Sun, 10 Aug 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754839119; cv=none; b=SNUrk4cSUvDtW4xNCPK68xTokqZP36Kd8b7RfzJhHJUsSwv79MFzJP1rwVg4U+G+TtxrQkQIBCLvuqKjhOElLVk7RAe7Zx5C7PrMlezlXg2rsGv2zXBlSd6cLZWGukw5CIIrfg1UWsT+HUojwX9Wod58xn/yJ77YD0OhyC9LAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754839119; c=relaxed/simple;
	bh=bAi6fqyvmtf+Qk+ny+MBAVSOWromnh9HLGoIUghJp3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXqzrOberacDE9h7FhLL4CCTS7SK7CWJT2IiiVRHORk4jKvO7shhOrTcIXJxpuPwwVSXBuLahH9eOfuhotUeQyYmKqgfpnDTuNw0tp74kXfBqQTXwOWMTAGxm/ThqBW8pESAOrHkEPRFy5+LLmFnZesdo3B+KLMnyr3+LA2d56c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alXJWsza; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2400f746440so29759315ad.2;
        Sun, 10 Aug 2025 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754839117; x=1755443917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/mzFFa7LIdL1kbelEVj2RxK7XsJ6E5WDtdZJbqzJsac=;
        b=alXJWsza8BVAXe5iSkos9EVmx8ipXevG3UoL260r8+2fPXnLWVDSdee12Nsj54Arua
         UvLHr1GjoInxsoPmHGJxxRSF8SdKlYmPb6USmzfoZVHqH7OOw3uZEpamPo9jP5fP+Mr3
         ZlZBAdRfqltre1ebZ/a89tLZL4Ih/c4viUweFn/f880JVHn6Pjcax5c+lVVIMlxjw4Lo
         6zC0TNDcLTl4sNHyJxxxZU9bTVmc3FvnuKx903ueQi6pkRgrXHKVHzwlV5z4z1LRcL6t
         ixLyij80PMzJGATU1MaV+HVVeUj6GjwL0C3Cvi9Jh0CV4XYWbwmxFpP/42D5qnfYxkxs
         cPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754839117; x=1755443917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mzFFa7LIdL1kbelEVj2RxK7XsJ6E5WDtdZJbqzJsac=;
        b=c4brOyou1TmjxLbaN1l3w2/Si+1W8fgd8VXcc96NE8r4JBP+doXg4HInMfePIQxpFr
         7yFY0Y7kxocV3nJZ/9uO4dgHhKUWOixxJA5wWuBHR0wA7CfAk2LgJ9ta8RKQ9vGWEHVa
         WCDd9dJ8zFujuj9Gx++E5gtPPZntHnqQkFCBwFVRTpPBe6WezfnFHRSK7ftmJROlnc/x
         9Ti9KpHGdKzKopWlnNZd5rHr87jEASCl/zyNKE1p8nIpNt8MilKrSAjtIBzse03R5YtP
         okz49VgxxG5F4AUeLMLjn81bCTcmM3q+oM1nXm7bg9YQFhx/NMlHd6wjIeOPFQnzMlU8
         wPZg==
X-Forwarded-Encrypted: i=1; AJvYcCUd8kd/r7pyKwPADX9vLfoxlG0gjrn+7LZwJ3aGJz96e/YJqhKiEsaHvBnkgYX1HM6KoJ8jMwSNERWP@vger.kernel.org, AJvYcCV1IwXp3U/ESbcQGZPSn+3q2hkpc+BEbUcv2Oq2L3+0zt+rbB/YJkbTRWcracOjz+jpuEKTHtdc6vsig3tE@vger.kernel.org, AJvYcCVCfXPWWFnnaOxFkfFL0vjYEaxz32g2c4hccdyjctPpt6T37PN3wvjGBXkp9ZXAn12ItSbjYynAi3hb@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPSr/SXxSzAJMMdbuDoHEEeu6vOKDT5NNfFy16xla0BmVSFgb
	/Aj+3bu3lhb21Vb/XpKNPjUP5fyT+jngWQ+EVTqOEGPzrIGQI2fAtpKB
X-Gm-Gg: ASbGncsTvKv14HEcMt+pQaC08Z9QdmIVzjIICMdHD5VlIJT7ZGZMMuIpYyV6Ff4SjG7
	4nZDu6vmgZ8FGIWCZth+XkCH9ijw3vVEit7/7EIgtJ85Ejth+WlIlQNcfXv/NlAJ3PACIgvOF7z
	o+xGjPPiUVmF/Hthmru35WPMYteYOLFU9ZugqSoL6Yd3DZAugPet4vP9uvUGNdDxRRmxluN41rW
	55maJYznjtXXISMIrp2aKTxh9B8I6QsRMd2FAgnXERu0sQP19MKwsS3eOVlBla2A/eeXxGGWeje
	4TevgX5YKTSs3WcEce0t3/GsZ7mFd1u+bVC4GX6bRg8fQ92dJiVYQRBH8eqpDXS6NjP79IUgDAR
	U9HW/dz8Cwm/Fq5McwN7bxQfElspcezw=
X-Google-Smtp-Source: AGHT+IHgQ53sypUQVBCdjpA9anQ7FU845PK3h0r8M83B00RT2r21DveF6cG7GeUKs1au9UI/CPXXjQ==
X-Received: by 2002:a17:902:d2c9:b0:240:1953:f9a with SMTP id d9443c01a7336-242c20703d5mr166416305ad.2.1754839117245;
        Sun, 10 Aug 2025 08:18:37 -0700 (PDT)
Received: from localhost ([2804:30c:1f50:da00:c6fb:5400:5af6:282f])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1ef59b2sm254168645ad.7.2025.08.10.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 08:18:35 -0700 (PDT)
Date: Sun, 10 Aug 2025 12:18:50 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: adc: add ade9000
Message-ID: <aJi4Woh3XzeeNlcJ@debian-BULLSEYE-live-builder-AMD64>
References: <20250808141020.4384-1-antoniu.miclaus@analog.com>
 <20250808141020.4384-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808141020.4384-3-antoniu.miclaus@analog.com>

Hi Antoniu,

Didn't manage to a full review of the bindings as this has many features.
Though, I've noticed one small nit below.

On 08/08, Antoniu Miclaus wrote:
> Add devicetree bindings support for ade9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - fix $id schema URL format
>  - remove address/size-cells and channel subnodes
>  - add dready interrupt support
>  - add clock input/output support
>  - simplify device tree structure
>  .../bindings/iio/adc/adi,ade9000.yaml         | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> new file mode 100644
> index 000000000000..07bc49acc920
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADE9000 High Performance, Polyphase Energy Metering driver
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADE9000 s a highly accurate, fully integrated, multiphase energy and power
> +  quality monitoring device. Superior analog performance and a digital signal
> +  processing (DSP) core enable accurate energy monitoring over a wide dynamic
> +  range. An integrated high end reference ensures low drift over temperature
> +  with a combined drift of less than ±25 ppm/°C maximum for the entire channel
> +  including a programmable gain amplifier (PGA) and an analog-to- digital
> +  converter (ADC).
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
...
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - interrupts
> +  - interrupt-names
> +  - vdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
spi-peripheral-props is alread referenced right after the dt-binding general
description. Is it needed to also reference it here?

