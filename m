Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55B9114939
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2019 23:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfLEW12 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Dec 2019 17:27:28 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41126 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfLEW11 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Dec 2019 17:27:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so4073284otc.8;
        Thu, 05 Dec 2019 14:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=651QbfFxHbn+gIg6TglJPaA7sVi2egQeAs/aiyii6jY=;
        b=syRlrXzudyJkSG4wXS1Nmz0qb679dLeZHPbzCfWHBIj76SIBorwJLjxTS08pXRuBws
         nXoAUWHjKy4C2qxW16fWPRnr/3I3ftg1QE0xnuAPOn9Y5GaAmXl0lN37d6eKpLdM9lLp
         JUvwZuO3VItaZNAZ2r5TlgEg66VAr4gDZKpM5OaadqxqzU5njN8NJ4fjl9eHwxLD7uMY
         LIuHHffxK0bfem7bgJKxPUo9FjvMRtm/f6cTDuwIvqenFT/ZNEvM/BVwBVWqBke/y13i
         xXrHn11DP2KZROWwMb33OWr67oYOca72IZNix+UoEcPyj+KlG4I+KnlKMOCea0xZLYe5
         a2XA==
X-Gm-Message-State: APjAAAVw/m3eGhUlcdjKJKSV0c1VZMZ2ZPKWDndQMIeXQgCjDxy3vWh4
        D/r8GjAH7j16iRReao0z0g==
X-Google-Smtp-Source: APXvYqw/PZNA3vwmc6UK37QzPywxm/gn6jJclg5Apod62JI2XI7Q9MTrj8/GmqtdSYdOOs7l2iZ8IQ==
X-Received: by 2002:a05:6830:16c6:: with SMTP id l6mr8879987otr.186.1575584846734;
        Thu, 05 Dec 2019 14:27:26 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w203sm2009701oia.12.2019.12.05.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 14:27:25 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:27:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     jic23@kernel.org, mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        lars@metafoo.de, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, fabrice.gasnier@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: adc: convert sd modulator to
 json-schema
Message-ID: <20191205222725.GA7547@bogus>
References: <20191127171642.6014-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127171642.6014-1-olivier.moysan@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 27, 2019 at 06:16:42PM +0100, Olivier Moysan wrote:
> Convert the sigma delta modulator bindings
> to DT schema format using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  .../iio/adc/sigma-delta-modulator.txt         | 13 -------
>  .../iio/adc/sigma-delta-modulator.yaml        | 35 +++++++++++++++++++
>  2 files changed, 35 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> deleted file mode 100644
> index 59b92cd32552..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -Device-Tree bindings for sigma delta modulator
> -
> -Required properties:
> -- compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
> -	as a generic SD modulator if modulator not specified in compatible list.
> -- #io-channel-cells = <0>: See the IIO bindings section "IIO consumers".
> -
> -Example node:
> -
> -	ads1202: adc {
> -		compatible = "sd-modulator";
> -		#io-channel-cells = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> new file mode 100644
> index 000000000000..8967c6f06d9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/sigma-delta-modulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device-Tree bindings for sigma delta modulator
> +
> +maintainers:
> +  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
> +
> +properties:
> +  compatible:
> +    description: |
> +      "sd-modulator" can be used as a generic SD modulator,
> +      if the modulator is not specified in the compatible list.
> +    enum:
> +      - sd-modulator
> +      - ads1201
> +
> +  '#io-channel-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - '#io-channel-cells'

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    ads1202: adc@0 {

No reg, so drop the unit-address.

> +      compatible = "sd-modulator";
> +      #io-channel-cells = <0>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
