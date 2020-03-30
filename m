Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863BA19886B
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 01:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgC3Xjb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 19:39:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34346 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3Xja (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 19:39:30 -0400
Received: by mail-io1-f67.google.com with SMTP id h131so19790859iof.1;
        Mon, 30 Mar 2020 16:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=suf5eKi2PlYuysyfvfSpAVKSO1upbbS/OhGRgy7bca0=;
        b=MWUc67ROIaGjjfBBb0ABd3VJH2Kqiz+0b4BWGuCb1RrmMPqyjniF8jS0ygRJ4eY9bv
         56JybXQyZaUowb0S7ajBo2ahjnu7gwRtstc/BP3djxjbCh1vnYDI8tRDROKljlUeZS0l
         TRkqSuUPv6lmLFxW7J0/hfS6ssiw1P2NTc5uMuegBUy95sn8z7+OgByM5b0mYZ3hSbzD
         IWOV9zaw6ACuDn/jA1qJGYWpkzOOCs8SXQUtoNLdMWlMpy8kOno3KSYuGk71qYKgWcf1
         quJG/If50PUA3tIqe1XIn1S/JeGiimaXTFWDpq9E3wgoCCjDbblg4OpwDttVDBl603SZ
         uw+g==
X-Gm-Message-State: ANhLgQ13MVPJ41X+F5vC9giHttWyvyJFLxF+0UHchFX9+2T0ydSn1xJi
        7tQ+acmECwAlkl77zR7xnNDJNG7UAw==
X-Google-Smtp-Source: ADFU+vvQ2i8mdVUrsIlSYIE3hKLY1HQqdWExg0USOIYKG+exGgZY+bRoj7VDw92vWLp2qb219hVOtw==
X-Received: by 2002:a6b:5c0d:: with SMTP id z13mr12178128ioh.96.1585611570040;
        Mon, 30 Mar 2020 16:39:30 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b62sm5388520ilb.1.2020.03.30.16.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:39:29 -0700 (PDT)
Received: (nullmailer pid 11087 invoked by uid 1000);
        Mon, 30 Mar 2020 23:39:28 -0000
Date:   Mon, 30 Mar 2020 17:39:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Message-ID: <20200330233928.GA7566@bogus>
References: <20200320150114.9297-1-alazar@startmail.com>
 <20200320150114.9297-2-alazar@startmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320150114.9297-2-alazar@startmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 20, 2020 at 05:01:14PM +0200, Alexandru Lazar wrote:
> Add device-tree bindings documentation for the MAX1241 device driver.
> 
> Signed-off-by: Alexandru Lazar <alazar@startmail.com>
> ---
>  .../bindings/iio/adc/maxim,max1241.yaml       | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> new file mode 100644
> index 000000000000..de41d422ce3b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +# Copyright 2020 Ioan-Alexandru Lazar
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max1241.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX1241 12-bit, single-channel analog to digital converter
> +
> +maintainers:
> +  - Ioan-Alexandru Lazar <alazar@startmail.com>
> +
> +description: |
> +  Bindings for the max1241 12-bit, single-channel ADC device. This
> +  driver supports voltage reading and can optionally be configured for
> +  power-down mode operation. The datasheet can be found at:
> +    https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max1241
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      Device tree identifier of the regulator that provides the external
> +      reference voltage.
> +    maxItems: 1

Drop this. Supplies are always 1 item.

> +
> +  shdn-gpios:

shutdown-gpios is the semi standard name.

> +    description:
> +      GPIO spec for the GPIO pin connected to the ADC's /SHDN pin. If
> +      specified, the /SHDN pin will be asserted between conversions,
> +      thus enabling power-down mode.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi0 {

Just 'spi'

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "maxim,max1241";
> +            reg = <0>;
> +            vref-supply = <&vdd_3v3_reg>;
> +            spi-max-frequency = <1000000>;
> +            shdn-gpios = <&gpio 26 1>;
> +        };
> +    };
> +
> +
> -- 
> 2.25.2
> 
