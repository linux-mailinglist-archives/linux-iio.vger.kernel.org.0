Return-Path: <linux-iio+bounces-24425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA47B9D528
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 05:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785B61895E22
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 03:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6762DECA7;
	Thu, 25 Sep 2025 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avZiLHJm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F842C9D
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758771559; cv=none; b=pWupi+HskPTRYRqYn4mDcPmFn9l9vMpqx0jmPsqaeQPztfmCZ0/YAKC5FTcPrNuN4ext35yyT/9lWkNzza/Yu3O/cEfqCndD2uCQkZu696sfLhMqKVTlXjxDsdK3ioOcCXDAssYV+9AibLfXeoWQvpz0rgHFPd5hV5nuez2sK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758771559; c=relaxed/simple;
	bh=gBPWkNFjdMQE8rx2St2Cxhve3tgGKE50NAP2JhU7zkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kc/kLPvgIEt+p3jo8x+I4z4vSsBWCyDNx6BPpXIYAXIi9eKT4Un2LNC3Dhowjk4X9tHhMx+jO8pIN38fHPQd9JlVv7ubwjI2Ie7MQd4ruRIKNVgL4ifJDoI4znAYoepc0Q6rUlRC/f/6gI9OrHDfjvQVfVIUrN2YX4oKz8EZOU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avZiLHJm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78100be28easo327050b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 20:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758771557; x=1759376357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQlHV/LeA8zP8BB0iU6hiP/ahF2MMcZ9HvPXMFvYOqo=;
        b=avZiLHJm79MbudNol9kHinWx3c+L/msP1MrGBZGtf2WjWwvrXgUEuvabYFAbZjPSj4
         MVlAIMzYdPJH3om999VmM74brZy7LTmDmx/Ma5J6dclCs11ByNmxqGvxRTSyzdeFqfek
         ejk8oJHbyJkWCWmEKHqEVK7k/qnOC4gy8f2Scct3PkRuBcmOrC9ZPoa5ygEs6VeeQpfs
         JF2NiK7sLzhRk6KR25JruGgOfDQtAVYGerjO9+de7KD4plfL7dfTvPNaftzPMv5+hRVH
         91HgxBBMEnw/mU0L3v/G3pt7nDlAjz2bUu449UJ5Bk1jKdY4hiKDDdMwzcq5XJPZR5Ad
         5Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758771557; x=1759376357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQlHV/LeA8zP8BB0iU6hiP/ahF2MMcZ9HvPXMFvYOqo=;
        b=dBPCqPb3O4igkooONTXGipzP+2Nn1ugKJ7842m6LOP+UmwzNB+FPdknA6UmZqdSo8H
         DgZ9sr0r8S6TsIlgLsyCv/2nmearq48lnmXOLtZnCroLzrb5gQHN5f+eKtNjadfkHPs6
         ZQAfJKa+LRqJ6Hvms9v5dilVUcLok5Ung5gPkT8nbpr9ybkZI+q+oMJCJYNDkTvO7ZFL
         CGG/jUSuE/uC20Vi/3iWZhI10s3nbmqJS4xPl5HP4ivAVqqAZZ+SnC2Wa98glsStwrhr
         TIlt94B8/LxFud8ji2biz/gK3UsKIQX5e6ZCnDBHXjjuHAJ6n3a91Dre/rvTz31j96yW
         gf/g==
X-Forwarded-Encrypted: i=1; AJvYcCVE0YuFYXyYcTkueg7WgVw5Ham83XTJoiakCeAPUnNQshL3y+jDl6dxjzmWjrCeruyqRwGckm0gzpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8HZMv3UDfswifOcoBt+4c0afnK5QUETTBKt/uljs99HOv4RL
	e+zsGmXDRNBmlIyMieTTlpTTk5qfrp1jeNKRxOLPemXtQPm0U+gHBVXZ
X-Gm-Gg: ASbGnctEhxB+68YGaeyWcMhMK5tQzPsxW3THquXctjjLKkXRRII9LOC0ejx+tDq1QpY
	jgL46Wtsz6ZN1SG5nXUfJGT8GUkyN+vnTO8+/ZapBRLtSh6bpbXF8YOBXAzOw5aK7jMYoP2Q/Xb
	/77dCnSOT1uXvyilRZzrkTHy4HixnNNCUTmhiM96m2j4oDj0raYpjOUbuuLOEmyn/D/DgXfELYV
	ctEDxMwJa+0CU1QmXdW1CBmaldymUC3Mox6BcaRd/mtDZuerBpZlklBwkIkUZRpPmmLcGtlU9YG
	KaXUjhQNIiEauaX3pc8RYX1F6oIXdQ82aVeq8IPKiN+4hytRWLg/sMuutRp93eCt2mnwrUpzVpw
	oL+dbL79YBc2OnR660FiHH4CvXQw8TTrOqwI1YobOXQ==
X-Google-Smtp-Source: AGHT+IEdkFvVbxoA7GFliYOsJ4pCAsy6bdrcfcexouLuoLDLtxCPYRQvWRRpt1KbJ7IscFaYe+dvwg==
X-Received: by 2002:a05:6a21:99aa:b0:2b7:949d:63e9 with SMTP id adf61e73a8af0-2e7be809954mr2350343637.7.1758771557487;
        Wed, 24 Sep 2025 20:39:17 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3341bda12eesm3952578a91.7.2025.09.24.20.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:39:16 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:40:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux@roeck-us.net, rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com, michal.simek@amd.com,
	grantpeltier93@gmail.com, farouk.bouabid@cherry.de
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: add binding for mpl3115
Message-ID: <aNS5lGpv6ezZ8HpZ@debian-BULLSEYE-live-builder-AMD64>
References: <20250921133327.123726-1-apokusinski01@gmail.com>
 <20250921133327.123726-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921133327.123726-2-apokusinski01@gmail.com>

Hi Antoni,

Some inline suggestions for making this binding better comply with the
'attempt to make bindings complete' guideline.

On 09/21, Antoni Pokusinski wrote:
> MPL3115 is an I2C pressure and temperature sensor. It features 2
> interrupt lines which can be configured to indicate events such as data
> ready or pressure/temperature threshold reached.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
...
> +description: |
> +  MPL3115 is a pressure/altitude and temperature sensor with I2C interface.
> +  It features two programmable interrupt lines which indicate events such as
> +  data ready or pressure/temperature threshold reached.
> +  https://www.nxp.com/docs/en/data-sheet/MPL3115A2.pdf
> +
> +properties:
> +  compatible:
> +    const: fsl,mpl3115
> +
> +  reg:
> +    maxItems: 1

For completeness, could also add the power supplies.

  vdd-supply: true

  vddio-supply: true

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
> +  drive-open-drain:
> +    type: boolean
> +    description:
> +      set if the specified interrupt pins should be configured as
> +      open drain. If not set, defaults to push-pull.
> +
> +required:
> +  - compatible
> +  - reg
  - vdd-supply
  - vddio-supply

and also add the supplies to the example below.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pressure@60 {
> +            compatible = "fsl,mpl3115";
> +            reg = <0x60>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "INT2";
> +        };
> +    };

Best regards,
Marcelo

