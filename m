Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273AC417BB
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 23:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407801AbfFKV7g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 17:59:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37190 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407784AbfFKV7g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2019 17:59:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so16511272qtk.4;
        Tue, 11 Jun 2019 14:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9t9Vw0XEPOw1ExmC4itvtXz4j0VSyI9TB0ZduDmVfKg=;
        b=k9xTZNuDxHyekx1VmkknmfkoF8Rk8oefcA6t/PPUcYbPWrLp8Z1Goro9k15p6H4RCU
         vRfvHCZowGcBZMWLWUjS0A08xk+Dn1EJL7fFnt5OPBn6XPWncHWqaWDxae0oYBuvBStj
         uiQidIda2sdotCaChtj0pzFapxThXMjWsmbeOtbWZ6QxOH+M7nw1/bJBjeZojnevwFTz
         oE+3/1aIH5EDF7/qkX8VJbtJiksJOXbWg3yL8siwFmtc33kEoW+XFRDXKfOMuo891PVW
         MiGEc1j7YtSp0homyFxtOzhcIWWj1vjYhHjZX/H08mkVV0kNC5ecB95Vhz22GHs3mQsm
         vN/Q==
X-Gm-Message-State: APjAAAUVBbbGLeDlYYUz16CB8L6dw/qPh6E/x7/rRq9WCn8WmEaqT/zH
        GC5w26jyuYqXGyj2lHCbDQ==
X-Google-Smtp-Source: APXvYqyIqRZqiK1I29XxC6NLMQr2bU+3gkPzHwvqDBu0rSDHFe74k+Yow++SW13x5pKikO39nlsEXg==
X-Received: by 2002:ac8:2906:: with SMTP id y6mr44917551qty.138.1560290375293;
        Tue, 11 Jun 2019 14:59:35 -0700 (PDT)
Received: from localhost ([64.188.179.199])
        by smtp.gmail.com with ESMTPSA id k40sm9524080qta.50.2019.06.11.14.59.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:59:34 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:59:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: frequency: Add docs for ADF4371
 PLL
Message-ID: <20190611215932.GA24974@bogus>
References: <1559653697-2760-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559653697-2760-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 04, 2019 at 04:08:17PM +0300, Stefan Popa wrote:
> Document support for Analog Devices ADF4371 SPI Wideband Synthesizer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v2:
> 	- Nothing changed.
> Changes in v3:
> 	- Nothing changed.
> Changes in v4:
> 	- Nothing changed.
> Changes in v5:
> 	- Nothing changed.

Please add acks/reviewed-bys when posting new versions.

But something else I noticed:

> 
>  .../devicetree/bindings/iio/frequency/adf4371.yaml | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> new file mode 100644
> index 0000000..d7adf074
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adf4371.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADF4371 Wideband Synthesizer
> +
> +maintainers:
> +  - Popa Stefan <stefan.popa@analog.com>
> +
> +description: |
> +  Analog Devices ADF4371 SPI Wideband Synthesizer
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adf4371.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adf4371
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Definition of the external clock (see clock/clock-bindings.txt)
> +    maxItems: 1
> +
> +  clock-names:
> +    description:
> +      Must be "clkin"

This can be a schema:

clock-names:
  items:
    - clkin

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        frequency@0 {
> +                compatible = "adi,adf4371";
> +                reg = <0>;
> +                spi-max-frequency = <1000000>;
> +                clocks = <&adf4371_clkin>;
> +                clock-names = "clkin";
> +        };
> +    };
> +...
> -- 
> 2.7.4
> 
