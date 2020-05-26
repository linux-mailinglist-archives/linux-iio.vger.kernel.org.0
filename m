Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662671E32EF
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 00:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390948AbgEZWuD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 18:50:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36673 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389755AbgEZWuD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 18:50:03 -0400
Received: by mail-io1-f67.google.com with SMTP id y18so3465266iow.3;
        Tue, 26 May 2020 15:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NowR2VxXBJJY+YKg7TxmwwaS7VUkrEccmijyqAKtla4=;
        b=Fbv+3RZOqWaZ+6bMUgIvWwyLOUMbrYu7bQDU4Muwfiuj6Uj1Z/vc27ujXbYn++MOnf
         7hVU0yPGukdMnSMpJ5yeH32bT9EZkUiL4JfG78cOoD5lNJ9PW/ZE/N6D9Q4jipA+yaQw
         r1oWctUnWrEHQx5cpcv3KPI0JtPf6LMTF1uba1hlh0yE8ssb79Yxl9Kxu81s/mUsD3dH
         B5yngAojhnoRAomJSM6a6a9SXn3hyNbqGsiPIuCsg8WkzjWhElyeN0dhc6oognNZHq3k
         EdEGD2ZsQns9kmU9Q5YCp7Vxc6x4HEqm5vcCYVyPYUEGIPebJB4I0Qjmr71JRohDSN1J
         /Z0Q==
X-Gm-Message-State: AOAM530j7jQBAv9oumbw98hB6oAk7w6U6OUAhZ65T7HTpdutzHJ0bJvS
        WV/qCE4TQxR/C5uv1RAF7bm+FSY=
X-Google-Smtp-Source: ABdhPJzJoX8wrcTaH6PSQ5/aBE9vcXyT0n09AII+im73/ZenSqybDj7QYOIEAwCHXLaRLhtBB4vHhw==
X-Received: by 2002:a02:6984:: with SMTP id e126mr3140865jac.62.1590533400360;
        Tue, 26 May 2020 15:50:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i15sm545709ils.74.2020.05.26.15.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:49:59 -0700 (PDT)
Received: (nullmailer pid 533373 invoked by uid 1000);
        Tue, 26 May 2020 22:49:58 -0000
Date:   Tue, 26 May 2020 16:49:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/5] dt-bindings: atmel-tcb: convert bindings to
 json-schema
Message-ID: <20200526224958.GA513053@bogus>
References: <20200519083716.938384-1-kamel.bouhara@bootlin.com>
 <20200519083716.938384-3-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519083716.938384-3-kamel.bouhara@bootlin.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 10:37:13AM +0200, Kamel Bouhara wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Convert Atmel Timer Counter Blocks bindings to DT schema format using
> json-schema.
> 
> Also move it out of mfd as it is not and has never been related to mfd.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

This should have your Sob too.

> ---
>  .../devicetree/bindings/mfd/atmel-tcb.txt     |  56 --------
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 126 ++++++++++++++++++
>  2 files changed, 126 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> deleted file mode 100644
> index c4a83e364cb6..000000000000
> --- a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -* Device tree bindings for Atmel Timer Counter Blocks
> -- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
> -  <chip> can be "at91rm9200" or "at91sam9x5"
> -- reg: Should contain registers location and length
> -- #address-cells: has to be 1
> -- #size-cells: has to be 0
> -- interrupts: Should contain all interrupts for the TC block
> -  Note that you can specify several interrupt cells if the TC
> -  block has one interrupt per channel.
> -- clock-names: tuple listing input clock names.
> -	Required elements: "t0_clk", "slow_clk"
> -	Optional elements: "t1_clk", "t2_clk"
> -- clocks: phandles to input clocks.
> -
> -The TCB can expose multiple subdevices:
> - * a timer
> -   - compatible: Should be "atmel,tcb-timer"
> -   - reg: Should contain the TCB channels to be used. If the
> -     counter width is 16 bits (at91rm9200-tcb), two consecutive
> -     channels are needed. Else, only one channel will be used.
> -
> -Examples:
> -
> -One interrupt per TC block:
> -	tcb0: timer@fff7c000 {
> -		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0xfff7c000 0x100>;
> -		interrupts = <18 4>;
> -		clocks = <&tcb0_clk>, <&clk32k>;
> -		clock-names = "t0_clk", "slow_clk";
> -
> -		timer@0 {
> -			compatible = "atmel,tcb-timer";
> -			reg = <0>, <1>;
> -		};
> -
> -		timer@2 {
> -			compatible = "atmel,tcb-timer";
> -			reg = <2>;
> -		};
> -	};
> -
> -One interrupt per TC channel in a TC block:
> -	tcb1: timer@fffdc000 {
> -		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0xfffdc000 0x100>;
> -		interrupts = <26 4>, <27 4>, <28 4>;
> -		clocks = <&tcb1_clk>, <&clk32k>;
> -		clock-names = "t0_clk", "slow_clk";
> -	};
> -
> -
> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> new file mode 100644
> index 000000000000..4b683151265e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/microchip/atmel,at91rm9200-tcb.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Atmel Timer Counter Block
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +description: |
> +  The Atmel (now Microchip) SoCs have timers named Timer Counter Block. Each
> +  timer has three channels with two counters each.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - atmel,at91rm9200-tcb
> +          - atmel,at91sam9x5-tcb
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      List of interrupts. One interrupt per TCB channel if available or one
> +      interrupt for the TC block
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    description:
> +      List of clock names. Always includes t0_clk and slow clk. Also includes
> +      t1_clk and t2_clk if a clock per channel is available.

This can express the 2nd sentence:

allOf:
  - contains:
      const: t0_clk
  - contains:
      const: slow_clk

> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      enum:
> +        - t0_clk
> +        - t1_clk
> +        - t2_clk
> +        - slow_clk
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 4
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^timer@[0-2]$":
> +    description: The timer block channels that are used as timers.
> +    type: object
> +    properties:
> +      compatible:
> +        const: atmel,tcb-timer
> +      reg:
> +        description:
> +          List of channels to use for this particular timer.
> +        minItems: 1
> +        maxItems: 3
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +examples:
> +  - |
> +    /* One interrupt per TC block: */
> +        tcb0: timer@fff7c000 {
> +                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0xfff7c000 0x100>;
> +                interrupts = <18 4>;
> +                clocks = <&tcb0_clk>, <&clk32k>;
> +                clock-names = "t0_clk", "slow_clk";
> +
> +                timer@0 {
> +                        compatible = "atmel,tcb-timer";
> +                        reg = <0>, <1>;
> +                };
> +
> +                timer@2 {
> +                        compatible = "atmel,tcb-timer";
> +                        reg = <2>;
> +                };
> +        };
> +
> +    /* One interrupt per TC channel in a TC block: */
> +        tcb1: timer@fffdc000 {
> +                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0xfffdc000 0x100>;
> +                interrupts = <26 4>, <27 4>, <28 4>;
> +                clocks = <&tcb1_clk>, <&clk32k>;
> +                clock-names = "t0_clk", "slow_clk";
> +
> +                timer@0 {
> +                        compatible = "atmel,tcb-timer";
> +                        reg = <0>;
> +                };
> +
> +                timer@1 {
> +                        compatible = "atmel,tcb-timer";
> +                        reg = <1>;
> +                };
> +        };
> -- 
> 2.25.0
> 
