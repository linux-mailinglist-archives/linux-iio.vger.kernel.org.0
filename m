Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1928B1E6C15
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 22:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406918AbgE1UNJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 16:13:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44971 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406917AbgE1UNJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 16:13:09 -0400
Received: by mail-io1-f68.google.com with SMTP id p20so18147627iop.11;
        Thu, 28 May 2020 13:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1oMkqoersnFFwgywd3WN+uq5VZO3agXx7VdT97nuswE=;
        b=alTOlr0MOeHLZrQI7t6KiUUzl7xroqHHnFrB87T/9v/tIMEnr7d9Xe7QbJYd+nCbXq
         ZHqozsJoKqKhuTJqlpHR2bP3yKacmYdtNRploQKApseuLYFDDsQwwww59fcmUa1Jzoyd
         ziw6lk62fbCCsgRQ/Nrwhlt4pLgEMuMnuT8MnhcSdE6fOfw3tWGmvkzead5chDRPjsK4
         s+rCiwOtxmjjuNqfaS79AuRGweH15L21dkjeQcsAPEc3UxGSmzShpkduImSG6tMC7mqs
         XWmk6q1kA+k7YhrBLELJfYq62pJXzn9Vq5Xzbt3ECmUF9egZBuMs8sWNRXQIV0T+W/My
         czpw==
X-Gm-Message-State: AOAM533OWO3ul/KDwyzekSZei8b9XAmTbYJLVlZg90gZx8jq5A388u1K
        e6r+np+XHD3EqidGg742ag==
X-Google-Smtp-Source: ABdhPJwMmV4QCCuHOJ6KHY4KnxIF7p1ZXD6CHCaXRvZ6Vu7Xde/UspNzAIHI81yEGeFNzrjvoOcMhg==
X-Received: by 2002:a02:665c:: with SMTP id l28mr4024811jaf.1.1590696787916;
        Thu, 28 May 2020 13:13:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h71sm3860082ili.43.2020.05.28.13.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:13:07 -0700 (PDT)
Received: (nullmailer pid 602641 invoked by uid 1000);
        Thu, 28 May 2020 20:13:06 -0000
Date:   Thu, 28 May 2020 14:13:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding for
 current-from-voltage
Message-ID: <20200528201306.GA594238@bogus>
References: <20200516022619.30779-1-xc-racer2@live.ca>
 <BN6PR04MB06600A3AFE160C6E07BF5B2CA3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06600A3AFE160C6E07BF5B2CA3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 15, 2020 at 07:26:18PM -0700, Jonathan Bakker wrote:
> Some devices may require a current adc, but only have a voltage
> ADC onboard.  In order to read the current, they have a resistor
> connected to the ADC.  Add bindings for this possibility.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  .../iio/adc/linux,current-from-voltage.yaml   | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml b/Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml
> new file mode 100644
> index 000000000000..385d317607c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/linux,current-from-voltage.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Current ADC from voltage ADC and resistor
> +
> +maintainers:
> +  - Jonathan Bakker <xc-racer2@live.ca>
> +
> +properties:
> +  compatible:
> +    const: linux,current-from-voltage

How is an ADC with a resistor attached a Linux thing? So you don't need 
'linux', but then 'current-from-voltage' isn't the best naming. I don't 
have a suggestion ATM.

> +
> +  io-channel-names:
> +    const: adc
> +
> +  io-channels:
> +    maxItems: 1
> +    description: Voltage ADC channel
> +
> +  linux,resistor-ohms:
> +    description: Strength of resistor connected to voltage ADC

Wouldn't you need this to be micro-ohms? Otherwise, there'd be too much 
voltage drop?

Rob
