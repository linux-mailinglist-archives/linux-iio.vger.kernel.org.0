Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F926AD3B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgIOTMx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:12:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41686 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgIOTMe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:12:34 -0400
Received: by mail-io1-f65.google.com with SMTP id z13so5352405iom.8;
        Tue, 15 Sep 2020 12:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dIoLLlcqqfkrVdKCgu2dDh09wIBNAgAZpMC84Uk6ARE=;
        b=Q3pRNS24LuOFsh/kXS/V656r5oi2sOXICL0K7hv0Eb6GUCH7omVYrlXT2e0ml6oyCv
         dAsL+Wpd4kKFnihWZiZsF8XuD3nKhyLcB3qoiIoYekePgZhFEHUGH9uQmnqI0XmVgXcK
         xIDjclBwOZMonR41lYoff410y7eomuRiNguqS1i4iTCgjaklF0RLhBdt/WLomuYqdu5t
         iGTgonvMGYwtnMhrKDBf8hTki8fG8h+A5oInsJ6/FfvaCHDAJYAwc1Yd6QSurZ0hVV6U
         bfJhoME5my1tHTOAvKElFqUZ/lcvNH5enm95JjlPAbpEdTGi06kUO5TbqaYMxICTPQ8R
         p9gg==
X-Gm-Message-State: AOAM531Trk8aE9HhAZD2W2jz/2RBZtY9wwd9wQh6m0zzOb0ZrXMIQ4P8
        01u9KZvp5E96T/7GtLdqrcNhA78yGaowWIY=
X-Google-Smtp-Source: ABdhPJxpi65URW7bw4MtaO89VaKU8CSom+vBLYeZUcnebS8wwyuXFrF5GBb3g7ghspILO2HMAM93sg==
X-Received: by 2002:a6b:2b45:: with SMTP id r66mr16400898ior.159.1600197153556;
        Tue, 15 Sep 2020 12:12:33 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z10sm7943121ioi.13.2020.09.15.12.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:12:32 -0700 (PDT)
Received: (nullmailer pid 2332251 invoked by uid 1000);
        Tue, 15 Sep 2020 19:12:30 -0000
Date:   Tue, 15 Sep 2020 13:12:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH v2 12/20] dt-bindings:iio:adc:dlg,da9150-gpadc yaml
 conversion
Message-ID: <20200915191230.GA2330650@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-13-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-13-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 09, 2020 at 06:59:38PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This is a small part of an MFD so perhaps ultimately it makes more
> sense to document it with that MFD binding rather than separately.
> 
> In the meantime it's a straightforward conversion from txt to yaml.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  .../bindings/iio/adc/da9150-gpadc.txt         | 16 ---------
>  .../bindings/iio/adc/dlg,da9150-gpadc.yaml    | 33 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
> deleted file mode 100644
> index c07228da92ac..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -Dialog Semiconductor DA9150 IIO GPADC bindings
> -
> -Required properties:
> -- compatible: "dlg,da9150-gpadc" for DA9150 IIO GPADC
> -- #io-channel-cells: Should be set to <1>
> -  (See Documentation/devicetree/bindings/iio/iio-bindings.txt for further info)
> -
> -For further information on GPADC channels, see device datasheet.
> -
> -
> -Example:
> -
> -	gpadc: da9150-gpadc {
> -		compatible = "dlg,da9150-gpadc";
> -		#io-channel-cells = <1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
> new file mode 100644
> index 000000000000..15c51d337108
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/dlg,da9150-gpadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dialog Semiconductor DA9150 IIO GPADC
> +
> +maintainers:
> +  - Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> +
> +description:
> +  This patch adds support for general purpose ADC within the
> +  DA9150 Charger & Fuel-Gauge IC.
> +
> +properties:
> +  compatible:
> +    const: dlg,da9150-gpadc
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - "#io-channel-cells"

additionalProperties...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +examples:
> +  - |
> +    adc {
> +        compatible = "dlg,da9150-gpadc";
> +        #io-channel-cells = <1>;
> +    };
> +...
> -- 
> 2.28.0
> 
