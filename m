Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3518D645
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 18:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCTRxo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 13:53:44 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35077 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTRxo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 13:53:44 -0400
Received: by mail-il1-f193.google.com with SMTP id o16so3808125ilm.2;
        Fri, 20 Mar 2020 10:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LhB293HQjykdpFMkVYZkXztlpDsUi5BcHgzQ1QDOWa8=;
        b=IsFU5JWIfqe3otbAsRF8oj6oQb4fk/FXGxHM60fa/iJpVQ6LbhXKAu+40fptJa4T4B
         1dCX63DGed7QW1ewT2K8yDCbJzR1qdbckTnuUiGrchTl4tVnjXZXpDPCSbsqZkUidCTY
         18/AhLK533mQE9QXDTjptM7qTyD2UzgU140pYW0Di3XZseiSuNmGNWMEGM8sbxnqlHtD
         rO9OdAVB5CiQVgh/ZNkOx9kpoeEBm3KXs/1EMpCtAqEk/fciUV2Vp9G+6SjifBoKClIz
         GQd/6t/VaoCj4Snsmc5GuOec7bOgt/pTFtfAvS3qJtcPQoZbfNpVDGe9/ifgd0kWUpXZ
         zzsg==
X-Gm-Message-State: ANhLgQ2Ud/KXy/sJb2BSmOxlMYkut52f2ydch/g7xqZgDNslMEuH5p84
        K7bOn9KMNM1Z7IAKWp0Wrg==
X-Google-Smtp-Source: ADFU+vsUCM8kq3aVkV1fztHvKh0xPIyxaYIKw+n73UMjSIdvQY91wgcqhbhDJ42CO+ued3HzkO9sPQ==
X-Received: by 2002:a92:6c0e:: with SMTP id h14mr9996526ilc.81.1584726823697;
        Fri, 20 Mar 2020 10:53:43 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id 10sm2259019ilb.45.2020.03.20.10.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 10:53:42 -0700 (PDT)
Received: (nullmailer pid 28110 invoked by uid 1000);
        Fri, 20 Mar 2020 17:53:39 -0000
Date:   Fri, 20 Mar 2020 11:53:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org,
        Laszlo.Nagy@analog.com, Andrei.Grozav@analog.com,
        Michael.Hennerich@analog.com, Istvan.Csomortani@analog.com,
        Adrian.Costina@analog.com, Dragos.Bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v10 6/8] dt-bindings: iio: adc: add bindings doc for AXI
 ADC driver
Message-ID: <20200320175339.GA24239@bogus>
References: <20200316155035.25500-1-alexandru.ardelean@analog.com>
 <20200316155035.25500-7-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316155035.25500-7-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 16, 2020 at 05:50:33PM +0200, Alexandru Ardelean wrote:
> This change adds the bindings documentation for the AXI ADC driver.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Your author and S-o-b emails don't match.

> ---
>  .../bindings/iio/adc/adi,axi-adc.yaml         | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> new file mode 100644
> index 000000000000..6bd80e241f40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,axi-adc.yaml#
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
> +    maxItems: 1
> +
> +  dma-names:
> +    maxItems: 1

Drop this. Implied by 'items' length.

With those 2 things fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    items:
> +      - const: rx
> +
> +  adi,adc-dev:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A reference to a the actual ADC to which this FPGA ADC interfaces to.
> +
> +required:
> +  - compatible
> +  - dmas
> +  - reg
> +  - adi,adc-dev
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    axi-adc@44a00000 {
> +          compatible = "adi,axi-adc-10.0.a";
> +          reg = <0x44a00000 0x10000>;
> +          dmas = <&rx_dma 0>;
> +          dma-names = "rx";
> +
> +          adi,adc-dev = <&spi_adc>;
> +    };
> +...
> -- 
> 2.20.1
> 
