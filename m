Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591151E87CF
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgE2TaZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 15:30:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40578 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2TaZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2020 15:30:25 -0400
Received: by mail-io1-f66.google.com with SMTP id q8so553249iow.7;
        Fri, 29 May 2020 12:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfaDXY2um+sxHha+SiROBPgi9RgI7khtKYrJysqehQg=;
        b=jn7ibgg5KeFHFP34ztuqFtZTcPoZ2Y2f7Pw7rDa8epc4W8lcZPJjdMeXt+OQq/tFAg
         VGJnNyvkbBCrbochSujUlmVUM3tj/XmWdnb0xeubnTb3HJieEBLrgkGDMSfqdFfW+hk1
         cMUqeRbpbzxEHboYIDbZ1buJiCEp0I7HOSExBOPS2jNrREn5vebuCas6lytrsnHMrEOS
         0nmmIun7sc6kDg2bETYQjpDAFOtPFDwZetNOq808Wl9/QLv30jF0xedcs8wN8JojRVzX
         6e2NcbAVpofAe2EgsfeJtQJVoukj/fWv6lr/mKmjbwo/O2uIOJBDKPgnePEGMC+G5O5n
         Sk6Q==
X-Gm-Message-State: AOAM530pMa6p/WfAd+U+u60jkayDkKOIka+ppgtgdf3BJRaGtHRHZIRq
        +0xnc1g/gSF5YqQY2h+baQ==
X-Google-Smtp-Source: ABdhPJwLZq65HhVx00Z+kBjdLPPoK/F+LZNbbmDQnuIslYL0/WZPL5e8iAkGE7yBF8Ro91M82EaELg==
X-Received: by 2002:a6b:bc85:: with SMTP id m127mr7797275iof.89.1590780622785;
        Fri, 29 May 2020 12:30:22 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s15sm5231607iln.49.2020.05.29.12.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:30:21 -0700 (PDT)
Received: (nullmailer pid 2804702 invoked by uid 1000);
        Fri, 29 May 2020 19:30:20 -0000
Date:   Fri, 29 May 2020 13:30:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 2/5] dt-bindings: iio: magnetometer: ak8975: convert
 format to yaml, add maintainer
Message-ID: <20200529193020.GA2800479@bogus>
References: <20200528145851.11791-1-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528145851.11791-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 28, 2020 at 04:58:47PM +0200, Jonathan Albrieux wrote:
> Converts documentation from txt format to yaml.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../bindings/iio/magnetometer/ak8975.txt      | 37 ---------
>  .../iio/magnetometer/asahi-kasei,ak8975.yaml  | 77 +++++++++++++++++++
>  2 files changed, 77 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> deleted file mode 100644
> index 0576b9df0bf2..000000000000
> --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -* AsahiKASEI AK8975 magnetometer sensor
> -
> -Required properties:
> -
> -  - compatible : should be "asahi-kasei,ak8975".
> -  - reg : the I2C address of the magnetometer.
> -
> -Optional properties:
> -
> -  - gpios : AK8975 has a "Data ready" pin (DRDY) which informs that data
> -      is ready to be read and is possible to listen on it. If used,
> -      this should be active high. Prefer interrupt over this.
> -
> -  - interrupts : interrupt for DRDY pin. Triggered on rising edge.
> -
> -  - vdd-supply: an optional regulator that needs to be on to provide VDD.
> -
> -  - mount-matrix: an optional 3x3 mounting rotation matrix.
> -
> -Example:
> -
> -ak8975@c {
> -        compatible = "asahi-kasei,ak8975";
> -        reg = <0x0c>;
> -        interrupt-parent = <&gpio6>;
> -        interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> -        vdd-supply = <&ldo_3v3_gnss>;
> -        mount-matrix = "-0.984807753012208",  /* x0 */
> -                       "0",                   /* y0 */
> -                       "-0.173648177666930",  /* z0 */
> -                       "0",                   /* x1 */
> -                       "-1",                  /* y1 */
> -                       "0",                   /* z1 */
> -                       "-0.173648177666930",  /* x2 */
> -                       "0",                   /* y2 */
> -                       "0.984807753012208";   /* z2 */
> -};
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> new file mode 100644
> index 000000000000..55b18784e503
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/asahi-kasei,ak8975.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AsahiKASEI AK8975 magnetometer sensor
> +
> +maintainers:
> +  - Jonathan Albrieux <jonathan.albrieux@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +        - asahi-kasei,ak8975
> +        - asahi-kasei,ak8963
> +        - asahi-kasei,ak09911
> +        - asahi-kasei,ak09912
> +      - enum:
> +        - ak8975
> +        - ak8963
> +        - ak09911
> +        - ak09912
> +        deprecated: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpios:
> +    maxItems: 1
> +    description: |
> +      AK8975 has a "Data ready" pin (DRDY) which informs that data
> +      is ready to be read and is possible to listen on it. If used,
> +      this should be active high. Prefer interrupt over this.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt for DRDY pin. Triggered on rising edge.
> +
> +  vdd-supply:
> +    maxItems: 1

Drop this. -supply is always 1.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
