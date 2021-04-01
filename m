Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C349D351D3F
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhDAS1q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 14:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbhDASQj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 14:16:39 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBA8C02FEA5;
        Thu,  1 Apr 2021 09:09:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id z15so2261216oic.8;
        Thu, 01 Apr 2021 09:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FLBIDyYd3J/QtsHCQ3avUSdZOaQsAsWhMC43OlTTZSw=;
        b=Iqtud0triEWyazPJmzlGRQ6Ocgrzhq5cXJjODDFqG+EbWlylLqxW5JEZ4Oqs3oVxjr
         +/+UM+k/6eFJf0uYAophB0CwPJxJL2Veo6w2nrdTymgpR4O5w7bMNMA19bg0u+vz86xY
         QA1+dqkdHKtOWypgr+6YeIDynkJadusJchIuTxvEmhlq6O3TraCUc9nywbgxd2NQ9aex
         TyxGonDCQrcQdmBvi25wKwcyO0L86aURZX/6EoviSR+SgqdHDyi61sTlOh3BDX16H3hD
         hGVr5OwgDDKXHQ0P9pWd5tEV9jGgOKo+vivBDmsNIgXhhZpmn35StNc1sszWGDGbEtSR
         e6/g==
X-Gm-Message-State: AOAM530z/9WHrfqFjQVEwDp41uxX8vPJMrqFiexuEeBbc2ImFMt86Pyq
        uvQOdzoMPeYmSRVIl/i02Q==
X-Google-Smtp-Source: ABdhPJzuyvMJcuMo9cj5QfUbMgNUWOVcunNaqBnqvwFCm8lZfeH3oWw+mP/behHNWR56hqSEeRKiIA==
X-Received: by 2002:a54:4492:: with SMTP id v18mr6593685oiv.49.1617293393485;
        Thu, 01 Apr 2021 09:09:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b12sm1259828oti.17.2021.04.01.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 09:09:53 -0700 (PDT)
Received: (nullmailer pid 524765 invoked by uid 1000);
        Thu, 01 Apr 2021 16:09:51 -0000
Date:   Thu, 1 Apr 2021 11:09:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add DT bindings
 for TMP117
Message-ID: <20210401160951.GA522095@robh.at.kernel.org>
References: <20210401091648.87421-1-puranjay12@gmail.com>
 <20210401091648.87421-2-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401091648.87421-2-puranjay12@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 01, 2021 at 02:46:47PM +0530, Puranjay Mohan wrote:
> Add devicetree binding document for TMP117, a digital temperature sensor.

Please run checkpatch.pl and fix trailing WS.

> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/temperature/ti,tmp117.yaml   | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> new file mode 100644
> index 000000000..1ead22317
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/temperature/ti,tmp117.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
> +
> +description: |
> +    TI TMP117 - Digital temperature sensor with integrated NV memory that supports
> +    I2C interface.
> +      https://www.ti.com/lit/gpn/tmp1
> +
> +maintainers: 
> +  - "Puranjay Mohan <puranjay12@gmail.com>"

Don't need quotes.

> +
> +properties: 
> +  compatible: 
> +    enum: 
> +      - "ti,tmp117"

Don't need quotes.

Blank line here.

> +  reg: 
> +    maxItems: 1

blank line here.

> +required: 
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - | 
> +    tmp117@48 {
> +        compatible = "ti,tmp117";
> +        reg = <0x48>;

You could just add to trivial-devices.yaml.

> +      };  
> -- 
> 2.30.1
> 
