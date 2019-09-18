Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D45B6437
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfIRNRt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 09:17:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34118 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfIRNRt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 09:17:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so6928673wrx.1;
        Wed, 18 Sep 2019 06:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6a38RN6FN8dThc0RVo5hV5uWnsoTfPqGl5eeZaZimE=;
        b=pWD5SV5m2YY+DlcWFFBxBnlVgpTdi535GmGMT+3c29ByJPJU1H+uPaXxPtFssiu578
         iVLYJnAj8HEalXRfcUTYFRtL/HcENGdZwNAITZ85nAeDI1/Jzlss9XmGiZLihNs7YaX5
         OF+8+4ayb1SzagUfoY5FQMtSGOZSdYxEimmurLj+Qjv6zA8v6Md+7bHKdXwo1mQLhc/H
         MUpXpGx+6WtxbgID2+BtqGQpKSzeLNPa8AOXV1nXbhGbDjBhjUiLat9bWM8qSQpkDGP6
         DfK8I+UE+DrclI22hj1Ipzum4w7FRfK/ZdKg7frdEoDAk8emYu1Zj/qX1C11d+1DUnn5
         wOiw==
X-Gm-Message-State: APjAAAU0hwIUhIf3OxpCEfRVKskUOSiV+c8w65S8WTkjsmmF1omhhgGz
        Mu8UqML3yJn+8GMGeiBD6vE=
X-Google-Smtp-Source: APXvYqxWVPjcF1VpJfpk6Lp6k4HOBxolAT7MHjlWITs7v+8tF1+4yScFg1b7sFVdBQuKIhoXHhpLuA==
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr3158989wrm.157.1568812665355;
        Wed, 18 Sep 2019 06:17:45 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id 207sm4243477wme.17.2019.09.18.06.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 06:17:43 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:17:40 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 07/11] dt-bindings: arm: samsung: Convert Exynos PMU
 bindings to json-schema
Message-ID: <20190918131740.GA668@pi3>
References: <20190907092007.9946-1-krzk@kernel.org>
 <20190907092007.9946-7-krzk@kernel.org>
 <20190918124306.GB318@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190918124306.GB318@bogus>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 18, 2019 at 07:43:06AM -0500, Rob Herring wrote:
> On Sat, Sep 07, 2019 at 11:20:03AM +0200, Krzysztof Kozlowski wrote:
> > Convert Samsung Exynos Power Management Unit (PMU) bindings to DT schema
> > format using json-schema.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. Fix clock-names to match all elements against schema (any number of
> >    any clkoutN values).
> >    This currently fails:
> >        properties:clock-names:items: {'enum': ['clkout0', 'clkout1', 'clkout2',
> >        'clkout3', 'clkout4', 'clkout5', 'clkout6', 'clkout7', 'clkout8',
> >        'clkout9', 'clkout10', 'clkout11', 'clkout12', 'clkout13', 'clkout14',
> >        'clkout15', 'clkout16']} is not of type 'array
> > 
> > 2. Add syscon reboot and poweroff nodes.
> > ---
> >  .../devicetree/bindings/arm/samsung/pmu.txt   |  72 -----------
> >  .../devicetree/bindings/arm/samsung/pmu.yaml  | 117 ++++++++++++++++++
> >  2 files changed, 117 insertions(+), 72 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> > deleted file mode 100644
> > index 433bfd7593ac..000000000000
> > --- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> > +++ /dev/null
> > @@ -1,72 +0,0 @@
> > -SAMSUNG Exynos SoC series PMU Registers
> > -
> > -Properties:
> > - - compatible : should contain two values. First value must be one from following list:
> > -		   - "samsung,exynos3250-pmu" - for Exynos3250 SoC,
> > -		   - "samsung,exynos4210-pmu" - for Exynos4210 SoC,
> > -		   - "samsung,exynos4412-pmu" - for Exynos4412 SoC,
> > -		   - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
> > -		   - "samsung,exynos5260-pmu" - for Exynos5260 SoC.
> > -		   - "samsung,exynos5410-pmu" - for Exynos5410 SoC,
> > -		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
> > -		   - "samsung,exynos5433-pmu" - for Exynos5433 SoC.
> > -		   - "samsung,exynos7-pmu" - for Exynos7 SoC.
> > -		second value must be always "syscon".
> > -
> > - - reg : offset and length of the register set.
> > -
> > - - #clock-cells : must be <1>, since PMU requires once cell as clock specifier.
> > -		The single specifier cell is used as index to list of clocks
> > -		provided by PMU, which is currently:
> > -			0 : SoC clock output (CLKOUT pin)
> > -
> > - - clock-names : list of clock names for particular CLKOUT mux inputs in
> > -		following format:
> > -			"clkoutN", where N is a decimal number corresponding to
> > -			CLKOUT mux control bits value for given input, e.g.
> > -				"clkout0", "clkout7", "clkout15".
> > -
> > - - clocks : list of phandles and specifiers to all input clocks listed in
> > -		clock-names property.
> > -
> > -Optional properties:
> > -
> > -Some PMUs are capable of behaving as an interrupt controller (mostly
> > -to wake up a suspended PMU). In which case, they can have the
> > -following properties:
> > -
> > -- interrupt-controller: indicate that said PMU is an interrupt controller
> > -
> > -- #interrupt-cells: must be identical to the that of the parent interrupt
> > -  controller.
> > -
> > -
> > -Optional nodes:
> > -
> > -- nodes defining the restart and poweroff syscon children
> > -
> > -
> > -Example :
> > -pmu_system_controller: system-controller@10040000 {
> > -	compatible = "samsung,exynos5250-pmu", "syscon";
> > -	reg = <0x10040000 0x5000>;
> > -	interrupt-controller;
> > -	#interrupt-cells = <3>;
> > -	interrupt-parent = <&gic>;
> > -	#clock-cells = <1>;
> > -	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
> > -			"clkout4", "clkout8", "clkout9";
> > -	clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
> > -		<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
> > -		<&clock CLK_OUT_CPU>, <&clock CLK_XXTI>,
> > -		<&clock CLK_XUSBXTI>;
> > -};
> > -
> > -Example of clock consumer :
> > -
> > -usb3503: usb3503@8 {
> > -	/* ... */
> > -	clock-names = "refclk";
> > -	clocks = <&pmu_system_controller 0>;
> > -	/* ... */
> > -};
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > new file mode 100644
> > index 000000000000..a5a02f8237fb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > @@ -0,0 +1,117 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/samsung/pmu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung Exynos SoC series Power Management Unit (PMU)
> > +
> > +maintainers:
> > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - samsung,exynos3250-pmu
> > +          - samsung,exynos4210-pmu
> > +          - samsung,exynos4412-pmu
> > +          - samsung,exynos5250-pmu
> > +          - samsung,exynos5260-pmu
> > +          - samsung,exynos5410-pmu
> > +          - samsung,exynos5420-pmu
> > +          - samsung,exynos5433-pmu
> > +          - samsung,exynos7-pmu
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  clock-names:
> > +    description:
> > +      List of clock names for particular CLKOUT mux inputs
> > +    minItems: 1
> > +    maxItems: 32
> > +    items:
> > +      enum:
> > +        - clkout0
> > +        - clkout1
> 
> Looking at this again, instead of enum, we can just do:
> 
> pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'

Indeed looks better.

Best regards,
Krzysztof

