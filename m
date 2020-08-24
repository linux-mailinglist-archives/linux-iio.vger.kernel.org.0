Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE20250BA3
	for <lists+linux-iio@lfdr.de>; Tue, 25 Aug 2020 00:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgHXW2Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Aug 2020 18:28:24 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42727 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHXW2W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2020 18:28:22 -0400
Received: by mail-il1-f193.google.com with SMTP id t13so8718159ile.9;
        Mon, 24 Aug 2020 15:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMtzY08cZ8u+FHK8W3N8sHuEUgQPT0fIhJ9j+SFDNCA=;
        b=H83NCtLdjkthrpA3Yq9K5YWHnx3wGyNUqlyMA2HoRrqRcDudBDANUrUcDlIvS2ZVm6
         YDp8Qao2isk6W2+RZAFXkL0eY80otff9piju1YkfABB/P/gQoAbU1OvNsEq9GOyz2HTV
         lec5L5MXL0EhANQh2AsZ+8mgmeGhR2SU54gI5QfuuNl9WxmLjCnBgb3+DvdYVi/lUsBK
         j6y84UzlT2xs5aZonfb3ezRql6kMqXA8k9m3g0mXVDX03XKJ94fj3ZPgihkildvcUWJp
         WPcNBYQxVYddbEjQCGdIBgC6edjpEWuRE9GAYgNulcW/YZlZaBhNIktCWalpFoeugu4S
         Urbg==
X-Gm-Message-State: AOAM531fH8RiDHh1CwtE3KrIUzttWn1bN43cHTOiirY9r4pw5OfTI3ah
        DnhuSoNI86dFkUkwr1JZnH0yAESl4w==
X-Google-Smtp-Source: ABdhPJxmCCVaj9T3lP3FEGGaMcCEKAGS/5tWTSyEVXOogJZe1FJzjsij/zLHT4Wq3W4J1N+ULowdlg==
X-Received: by 2002:a92:c74e:: with SMTP id y14mr6915239ilp.251.1598308100532;
        Mon, 24 Aug 2020 15:28:20 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id f128sm7938824ilh.71.2020.08.24.15.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:28:19 -0700 (PDT)
Received: (nullmailer pid 3433283 invoked by uid 1000);
        Mon, 24 Aug 2020 22:28:15 -0000
Date:   Mon, 24 Aug 2020 16:28:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Chris Ruehl <chris.ruehl@gtsys.com.hk>, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio/dac: convert ltc2632.txt to lltc,ltc2632.yaml
Message-ID: <20200824222815.GA3430564@bogus>
References: <20200810033806.15503-1-chris.ruehl@gtsys.com.hk>
 <20200816102733.7fa1d3ce@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200816102733.7fa1d3ce@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 16, 2020 at 10:27:33AM +0100, Jonathan Cameron wrote:
> On Mon, 10 Aug 2020 11:37:52 +0800
> Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
> 
> Hi Chris,
> 
> This will need a dt-binding maintainer review, but in the meantime...
> 
> Look at the title for dt-bindings patches and match that format.
> 
> One question for Rob inline.   A quick grep suggests we are
> very inconsistent on whether we use the multiline block
> thing for description fields or not.
> 
> Is it needed?
> 
> > Conversion of the ltc2632 to yaml format and name the file to
> > 'lltc,ltc2632.yaml'.
> > 
> > Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> > ---
> > v6:
> > Remove tab and drop unused label
> > Related patches already in linux-next.
> > [PATCH v5 1/3] iio: documentation ltc2632_chip_info add num_channels
> > linux-next commit: 6f1c9e0da9aae51177457731357ae8a2c8af27cd
> > PATCH v5 2/3] iio: DAC extension for ltc2634-12/10/8
> > linux-next commit: aefa5bc87c808dd08db2fc79ebdbf19ed4af7be2
> > 
> >  .../bindings/iio/dac/lltc,ltc2632.yaml        | 77 +++++++++++++++++++
> >  .../devicetree/bindings/iio/dac/ltc2632.txt   | 49 ------------
> >  2 files changed, 77 insertions(+), 49 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> > new file mode 100644
> > index 000000000000..edf804d0aca2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Linear Technology LTC263x 12-/10-/8-Bit Rail-to-Rail DAC
> > +
> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +
> > +description: |
> > +  Bindings for the Linear Technology LTC2632/2634/2636 DAC
> > +  Datasheet can be found here: https://www.analog.com/media/en/technical-documentation/data-sheets/LTC263[246].pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - lltc,ltc2632-l12
> > +      - lltc,ltc2632-l10
> > +      - lltc,ltc2632-l8
> > +      - lltc,ltc2632-h12
> > +      - lltc,ltc2632-h10
> > +      - lltc,ltc2632-h8
> > +      - lltc,ltc2634-l12
> > +      - lltc,ltc2634-l10
> > +      - lltc,ltc2634-l8
> > +      - lltc,ltc2634-h12
> > +      - lltc,ltc2634-h10
> > +      - lltc,ltc2634-h8
> > +      - lltc,ltc2636-l12
> > +      - lltc,ltc2636-l10
> > +      - lltc,ltc2636-l8
> > +      - lltc,ltc2636-h12
> > +      - lltc,ltc2636-h10
> > +      - lltc,ltc2636-h8
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 2000000
> > +
> > +  vref-supply:
> > +    description:
> Does this need a | ?

No. Only needed if you want to preserve line breaks and other 
formatting.

> > +      Phandle to the external reference voltage supply. This should
> > +      only be set if there is an external reference voltage connected to the VREF
> > +      pin. If the property is not set the internal reference is used.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    vref: regulator-vref {
> > +        compatible = "regulator-fixed";
> > +        regulator-name = "vref-ltc2632";
> > +        regulator-min-microvolt = <1250000>;
> > +        regulator-max-microvolt = <1250000>;
> > +        regulator-always-on;
> > +    };
> > +
> > +    spi {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      dac@0 {
> > +        compatible = "lltc,ltc2632";
> > +        reg = <0>;    /* CS0 */
> > +        spi-max-frequency = <1000000>;
> > +        vref-supply = <&vref>;
> > +      };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > deleted file mode 100644
> > index 1ab9570cf219..000000000000
> > --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > +++ /dev/null
> > @@ -1,49 +0,0 @@
> > -Linear Technology LTC2632/2634/2636 DAC
> > -
> > -Required properties:
> > - - compatible: Has to contain one of the following:
> > -	lltc,ltc2632-l12
> > -	lltc,ltc2632-l10
> > -	lltc,ltc2632-l8
> > -	lltc,ltc2632-h12
> > -	lltc,ltc2632-h10
> > -	lltc,ltc2632-h8
> > -	lltc,ltc2634-l12
> > -	lltc,ltc2634-l10
> > -	lltc,ltc2634-l8
> > -	lltc,ltc2634-h12
> > -	lltc,ltc2634-h10
> > -	lltc,ltc2634-h8
> > -	lltc,ltc2636-l12
> > -	lltc,ltc2636-l10
> > -	lltc,ltc2636-l8
> > -	lltc,ltc2636-h12
> > -	lltc,ltc2636-h10
> > -	lltc,ltc2636-h8
> > -
> > -Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
> > -apply. In particular, "reg" and "spi-max-frequency" properties must be given.
> > -
> > -Optional properties:
> > -	- vref-supply: Phandle to the external reference voltage supply. This should
> > -	  only be set if there is an external reference voltage connected to the VREF
> > -	  pin. If the property is not set the internal reference is used.
> > -
> > -Example:
> > -
> > -	vref: regulator-vref {
> > -		compatible = "regulator-fixed";
> > -		regulator-name = "vref-ltc2632";
> > -		regulator-min-microvolt = <1250000>;
> > -		regulator-max-microvolt = <1250000>;
> > -		regulator-always-on;
> > -	};
> > -
> > -	spi_master {
> > -		dac: ltc2632@0 {
> > -			compatible = "lltc,ltc2632-l12";
> > -			reg = <0>; /* CS0 */
> > -			spi-max-frequency = <1000000>;
> > -			vref-supply = <&vref>; /* optional */
> > -		};
> > -	};
> 
