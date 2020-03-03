Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F12177C72
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 17:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgCCQxZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 11:53:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35583 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgCCQxZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Mar 2020 11:53:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id v10so3710640otp.2;
        Tue, 03 Mar 2020 08:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UO6q1WI8Phcj/IcENQphH46oCI8xjrDVJnO/bSc3SAQ=;
        b=kCEdUlbhCpPtJb+l4oFaYiHSf1rYOALarqCy6SaiFPxdX8cL5csWVim6Borz+1ft5V
         wjoLWbs+RMf4e3LQ25+1cOkf+cn+n8ax0WNs6fNf5lhgx77ye98DI417U/6YBtV8hMnl
         2pPABnr7ttBdB3KHb+s+Xfti4P5e0CHbWXeiLM18ZRs/3LDOwCx0SsHgxJjwFKU+9+na
         2NcfVunjlx43EsQzDUs+q9MJTWUnbtHr2i1sHNArmzoNgqaBfbGnZ7dGrZbk+JKV7r3D
         bRQpuQQSESlydTaD0z2GSxrUI2RIBgmvM8bvqluF1XUWT9bUWkB+U9myeoXAk/pP37Ye
         w46Q==
X-Gm-Message-State: ANhLgQ3huxz+sl6atuBglhZeEuED9Oro2DiRJ4kVu6QgRJYMQ3o55aBv
        QuKaAyLyoPMcKq86FOTsug==
X-Google-Smtp-Source: ADFU+vtKffzJaK+qHxe336nH4kj7mS752gyMBxM59RExFd9VPTCue7HZNBWX4B5GOdQr+y6Kuficsg==
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr4179326otj.65.1583254404567;
        Tue, 03 Mar 2020 08:53:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c18sm467608otr.0.2020.03.03.08.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:53:24 -0800 (PST)
Received: (nullmailer pid 25933 invoked by uid 1000);
        Tue, 03 Mar 2020 16:53:23 -0000
Date:   Tue, 3 Mar 2020 10:53:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v3 6/8] dt-bindings: iio: adc: add bindings doc for AXI
 ADC driver
Message-ID: <20200303165323.GA32472@bogus>
References: <20200227082719.6343-1-alexandru.ardelean@analog.com>
 <20200227082719.6343-7-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227082719.6343-7-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 27, 2020 at 10:27:17AM +0200, Alexandru Ardelean wrote:
> This change adds the bindings documentation for the AXI ADC driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/adc/adi-axi-adc.yaml         | 69 +++++++++++++++++++

Follow the compatible string: adi,axi-adc.yaml 

>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi-axi-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi-axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi-axi-adc.yaml
> new file mode 100644
> index 000000000000..d45d41f4f08e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi-axi-adc.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi-axi-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AXI ADC IP core
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Alexandru Ardelean <alexandru.ardelean@analog.com>
> +
> +description: |
> +  Analog Devices Generic AXI ADC IP core for interfacing an ADC device
> +  with a high speed serial (JESD204B/C) or source synchronous parallel
> +  interface (LVDS/CMOS).
> +  Usually, some other interface type (i.e SPI) is used as a control
> +  interface for the actual ADC, while this IP core will interface
> +  to the data-lines of the ADC and handle the streaming of data into
> +  memory via DMA.
> +
> +  https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,axi-adc-10.0.a
> +
> +  reg:
> +    maxItems: 1
> +
> +  dmas:
> +    minItems: 1
> +    maxItems: 1

Just maxItems is enough.

> +
> +  dma-names:
> +    maxItems: 1
> +    items:
> +      - const: rx
> +
> +  adi-axi-adc-client:

adi,axi-adc-client

Though I think 'adi,adc-dev' would be better name.

> +    description:
> +      A reference to a the actual ADC to which this FPGA ADC interfaces to.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - dmas
> +  - reg
> +  - adi-axi-adc-client
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    fpga_axi {

You can drop this node.

> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        axi-adc@44a00000 {
> +          compatible = "adi,axi-adc-10.0.a";
> +          reg = <0x44a00000 0x10000>;
> +          dmas = <&rx_dma 0>;
> +          dma-names = "rx";
> +
> +          adi-axi-adc-client = <&spi_adc>;
> +        };
> +    };
> +...
> -- 
> 2.20.1
> 
