Return-Path: <linux-iio+bounces-23328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62CB3843C
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 15:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE07B365FBF
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F335690B;
	Wed, 27 Aug 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YptpW1Nr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48223321425
	for <linux-iio@vger.kernel.org>; Wed, 27 Aug 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303172; cv=none; b=fd05dOFP2Va+01YdOpZJ7YOc5nt+FXh5ClHQNdjwsOPjX85tlJFUzcM+/yjdluraVK6a5t9sJnqoelezmk4Lxzlc1nUJg4bNhY4bk7iPnpWuxusykGYnUEoFc/kMeBq8SGYotsZiSNT7gYn+kWaDVT3svos7K2zcZ/XLfWF0Ks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303172; c=relaxed/simple;
	bh=IpRMFO2MeMkQytb9AR0N8Z1FemuJAxPT/DZPEjNV+I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ki3O/ORan69rzzktPt0lrzxg2X/xIdt2ewKxDaMi732U9kz3thkpQdfSpADwTuUmMbMz2lxn+odBbxJJFjvCc4I3dfQ4IOZmPWY7MNK9MlCM2ysYJJ7xEZOJq0ZLR5jcBBSL0WbnB2D6F9yHwfnwlduVMnTocIBXI0BbGEUDeiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YptpW1Nr; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7451ee5e750so1900107a34.2
        for <linux-iio@vger.kernel.org>; Wed, 27 Aug 2025 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756303169; x=1756907969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DEQfVOF90gg0nQ2w58ay9TgS+NK/WWzZloFFYDQxeI=;
        b=YptpW1NrPYQJUtxCJxZlAK41GASCaGI4T10wdA5OdawvHzTMqRmt7uiQjYF8J304o9
         mabZ2XbXzBbEWnpbb+zDacrcII40gVXfhuen1Gf5ldgZlce2154Bx2G6XWlYC9t7JIrO
         O513s0gDl53nAk3Tb38MmHFZmCdMd+gzOYiTVUX3k2PpaiiZOcvO0aHamUsZgr6+ncAc
         RIMQwABckeBrY7pwYLhy3PESwrXI5M2GMQVww+kFDIqw8Q1SZLRAbklJXAN0v+pSFGoz
         dEzdIWevFM7Cqg1UX5RE3MSFfVXUocnfAHyUrwrsU7FHZL1LJPFNwQW2/kClsnKWTANk
         cpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756303169; x=1756907969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DEQfVOF90gg0nQ2w58ay9TgS+NK/WWzZloFFYDQxeI=;
        b=ax2z9c7u52r2JYVGJv0wdhVSxtZHSROl4COU5qRl+SIQVGDnXYAQD71ZOf1hpQPzd+
         9zXLP6Fwf4UTAu+N1c8ALOIlDR+Z8F3OQn2qh6yLhIUK2gKJJwsK+Jwcaz76nGQVfXGy
         AjDpWy8s0xOCnwD+KQ7LAAduZO1sw8Buz7X7M3plEoViiVUmvxfwx0JyEh348OCDqFDp
         V4/C0SRdK41B0NVUqaEa37ZWjHBsis5rHTeY1Icn5SYjYMuFew0tJM6TFEnm2+J12TGK
         eXx4cvp+q+0b5MeuJpNFib0Bmr0nQ/cDS+GqOI1FrHdK8x6Wtvj+jo9kq29soG5HaCvT
         mSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8eY6NuyH4x6OF23wHDI62AgFIGo2uWLRwaDAjxyjQK39Vy6pMz0yqFqx9ixqhHdrv3ZDOEz49TdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxcgttrGo6HLude0MRfJ6vx/WKs0O4SWp9w8cwGqrVFJnqE8A
	vmtHS63816MOGIjs52DbTTVCOF6Pgna82aKEOZQoUbqlffLqp+hu9sZvcBHdnD+3Bzg=
X-Gm-Gg: ASbGnctBNLguxNginOjHPvXhyau35mbh9pK9C4Wba4e1wNF8uMBFZ8woRcRFaBlJ1VH
	K+8fM5MP26Suil/HqU+/Mn5xHWx5bfME857LbIkWXKRjviQLe+EBLHsUgsylc6O7o/8/35bPMpt
	pp5FqnXYAQi124eEWNH9Q2cKJgXKbBKSCRkvrntwTY8+2qm+mA+jiHN90lxkWMmvPPN0tgdAaGK
	RZTkJ8dfO21h9ML1iGHVGm9OkAnb646yVncoOMCpCXAEDGWqhJBs08oUXxFzcnwfpTgb1ij5WQN
	rOCK21MqesrdpdHZvGKjhogW/tFU44SG827eqw7y2yoXlTh9ZnXoexM2Q7UTEV8KJsOP5hs+WBN
	t+zd/wefFqEeud/skJWqdBnVagcP6kUMi3G9KbaelSQKY16okbcgKIzNqHif+08fKzRxGNSsm5j
	kl0OoQfFmxdg==
X-Google-Smtp-Source: AGHT+IHSftKprg4A6uiJZsbpSHa4sPR9ZXxfCmFTDjOuRBFTS34c1PezHWubSzt7gTo1cYwVIRJIbw==
X-Received: by 2002:a05:6830:2b07:b0:72b:992b:e41 with SMTP id 46e09a7af769-74500a5c79amr8967488a34.23.1756303169172;
        Wed, 27 Aug 2025 06:59:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e474c76sm3019432a34.24.2025.08.27.06.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 06:59:28 -0700 (PDT)
Message-ID: <ca078446-7cdf-4922-b550-6dd671d39589@baylibre.com>
Date: Wed, 27 Aug 2025 08:59:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add NXP P3T175x
 support
To: Lakshay Piplani <lakshay.piplani@nxp.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, marcelo.schmitt1@gmail.com, gregkh@linuxfoundation.org,
 viro@zeniv.linux.org.uk, peterz@infradead.org, jstephan@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 jonathan.cameron@huawei.com, akpm@linux-foundation.org, chao@kernel.org,
 jaegeuk@kernel.org
Cc: vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
References: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/25 5:31 AM, Lakshay Piplani wrote:
> Add bindings for the NXP P3T175x (P3T1750/P3T1755) temperature
> sensor, supporting both I2C & I3C interfaces.
> 
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> ---
> Changes in v2 (addressed review comments from Krzysztof Kozlowski):
>  - Dropped nxp,alert-active-high: unnecessary as polarity handling is implicit in driver.

>  - Retained nxp,interrupt-mode: required to program TM(thermostat mode) bit; enables interrupt
>    (latched) mode. If not present in DT entry comparator mode is set as default.
>  - Retained nxp,fault-queue: This needs to be configured during device initialization.
>    This property configures the hardware fault queue length. Defines how many consecutive faults
>    are required before ALERT/IBI is asserted, preventing false triggers in noisy environments.

These are not very convincing reasons that these to properties should
be in the devicetree. The devicetree describes how things are wired
up, not how they are used in the driver. For the first one, we already
have the parent node to tell us if we are using I2C or I3C, so the
property is redundant. For the second one, the whole system could be
moved from a less noisy to a more noisy environment and we should not
have to change the devicetree to handle that.

>  - The `reg` property remains required to satisfy `dt_binding_check`.
>  - Fixed YAML formatting, line wrapping, and examples.
>  - Changed compatibles from nxp,p3t1755 to nxp,p3t1755-iio and nxp,p3t1750 to nxp,p3t1750-iio
>    as reported by kernel test robot.
> 
>  .../bindings/iio/temperature/nxp,p3t1755.yaml | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> new file mode 100644
> index 000000000000..4eb6fc5cb247
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/nxp,p3t1755.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP P3T175x Temperature Sensor
> +
> +maintainers:
> +  - Lakshay Piplani <lakshay.piplani@nxp.com>
> +
> +description: |
> +  Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1755.pdf
> +
> +  P3T175x (P3T1750/P3T1755) is a digital temperature sensor with a range of -40°C to
> +  +125°C and a 12-bit resolution. It supports communication over
> +  both I2C and I3C interfaces.
> +
> +  The I2C interface supports up to 32 static addresses and provides
> +  an ALERT output to signal when temperature thresholds are crossed.
> +
> +  The I3C interface supports In-Band interrupts (IBI) in interrupt mode,
> +  allowing the device to notify the controller of threshold events without
> +  dedicated alert pin.
> +
> +  The device supports configurable thermostat modes (interrupt or comparator),
> +  fault queue length etc.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,p3t1750-iio
> +      - nxp,p3t1755-iio
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      In I2C mode, the device supports up to 32 static addresses.
> +      In I3C mode, the 'reg' property encodes a triplet of
> +      <static-address BCR PID> used for device matching.
> +      Static address is optional if matching is done via PID.
> +
> +  nxp,interrupt-mode:
> +    type: boolean
> +    description: |
> +      Enables interrupt mode (TM = 1), where alerts are latched until
> +      cleared by a register read.

As mentioned above, the driver should know best which mode makes the
most sense without having a property to restrict it.

> +      Required for IBI support over I3C. On I2C, both interrupt and
> +      comparator mode support events.
> +
> +  nxp,fault-queue:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 6]
> +    description: |
> +      Number of consecutive temperature limit
> +      violations required before an alert is triggered.
> +      valid values:- 1, 2, 4 or 6.
> +      If unspecified, hardware default (2) is used.

If we kept this, it should have `default: 2`. But as mentioned above,
this doesn't seem like something that would be known when writing
the device tree since it could depend on variable environmental
conditions.

We already have IIO_EV_INFO_RUNNING_COUNT that sounds similar to this
type of control that would allow it to be set at runtime instead.

> +
> +  assigned-address:
> +    true
> +

Missing `vcc-supply: true`, which should also be required.

> +required:
> +  - compatible
> +  - reg
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
> +        temp-sensor@48 {
> +            compatible = "nxp,p3t1755-iio";
> +            reg = <0x48>;
> +            nxp,interrupt-mode;
> +            nxp,fault-queue = <6>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> +
> +  - |
> +    i3c {
> +      #address-cells = <3>;
> +      #size-cells = <0>;
> +      temp-sensor@48,236152a00 {
> +        reg = <0x48 0x236 0x152a00>;
> +        assigned-address = <0x50>;
> +      };
> +    };


