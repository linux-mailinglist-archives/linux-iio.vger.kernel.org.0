Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33021632EA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 21:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgBRUTW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 15:19:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39869 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgBRUTW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 15:19:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so21445688oih.6;
        Tue, 18 Feb 2020 12:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :content-id:user-agent;
        bh=/oH+eSV6HonFGoyf1c7VOyN9K2wepQ+JN8XlQu5VFGQ=;
        b=oddWER9MgP4CPGtyyZyPDIgiYPM4W+kIZjyTmTbEAgSoWCHBnJV/rBPVFnXFxdtL7F
         Zppep8/4v3R8iDMYxNI1f/tpPlpcUTwW2TU0QN9VxNNMUSf6FlrNzpy9lTFC4fccdq2P
         RrjUhX8HMUdUBY/696t2uo3KMgqSi+6f+fdqln0Gu4HZPdYEqTBgOSTlHQoHq23x2qox
         hZQV1XkrfzsECnyTe6RJupWri/HvudYCksYUNZpvDIuvM8LA7fasXqIc+1uza45G/PoN
         SST0IrotH+GrMXAG6lx0Nwd6UbfEQF9xEZQTAgaIlELNkATH/hb3dq2vegWomd/C25zL
         25uQ==
X-Gm-Message-State: APjAAAWCweYqJ9B6K5/MjVWDR5cevAkG9FnX4lAgw93oHRD1HUJ+L3XQ
        z4zpsFd97cBph4vgPJpHSw==
X-Google-Smtp-Source: APXvYqxbC09hZJmpCbOQiakXKMqr3SJqmjEG05VISMsBCbMdawmAIIsQlXS9RVG/WrW/lxEciCX1Cw==
X-Received: by 2002:aca:d0a:: with SMTP id 10mr2313431oin.50.1582057161228;
        Tue, 18 Feb 2020 12:19:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm1677015otq.19.2020.02.18.12.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 12:19:20 -0800 (PST)
Received: (nullmailer pid 30683 invoked by uid 1000);
        Tue, 18 Feb 2020 20:19:19 -0000
Date:   Tue, 18 Feb 2020 14:19:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] Device tree bindings for TI HDC20x0 humidity and
  temperature sensors
Message-ID: <20200218201919.GA28712@bogus>
References: <CF7736B3-95D6-43E4-BC69-DDB0DFE2A86A@norphonic.com>
 <90EF52F7-82A2-4617-95FF-CCF37E3FEAC6@norphonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90EF52F7-82A2-4617-95FF-CCF37E3FEAC6@norphonic.com>
Content-Language: en-US
Content-ID: <3CCF2D6C85D1FC408616909C9D0D1D39@eurprd06.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Feb 2020 22:18:13 +0000, Eugene Zalkonnikov wrote:
> 
> Amended device tree bindings for the driver.
> 
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
> 
> diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> --- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	2020-02-12 14:28:42.562903814 +0100
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/hdc2010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDC2010/HDC2080 humidity and temperature iio sensors
> +
> +maintainers:
> +  - Eugene Zaikonnikov <eugene.zaikonnikov@norophonic.com>
> +
> +description: |
> +  Relative humidity and tempereature sensors on I2C bus
> +
> +  Datasheets are available at:
> +    http://www.ti.com/product/HDC2010/datasheet
> +    http://www.ti.com/product/HDC2080/datasheet
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,hdc2010
> +      - ti,hdc2080
> +
> +  vddd-supply:
> +    description:
> +      digital voltage regulator (see regulator/regulator.txt)
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      hdc200x@40 {
> +          compatible = "ti,hdc2010";
> +          reg = <0x40>;
> +      };
> +    };
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml: $id: path/filename 'iio/humidity/hdc2010.yaml' doesn't match actual filename
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1237780
Please check and re-submit.
