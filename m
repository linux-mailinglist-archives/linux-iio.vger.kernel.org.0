Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3962E3FB60F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 14:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhH3McV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 08:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231550AbhH3McR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 08:32:17 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B7F60C40;
        Mon, 30 Aug 2021 12:31:17 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:34:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 06/40] dt-bindings: mfd: ti,am3359-tscadc: Describe
 am4372 MFD compatible
Message-ID: <20210830133429.06261fcd@jic23-huawei>
In-Reply-To: <20210825152518.379386-7-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-7-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:44 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> A more recent version of the am3359 ADC/Touchscreen controller is
> available on certain SoCs of the am437x family. This IP has evolved a
> little bit and deserves its own compatible.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/mfd/ti,am3359-tscadc.yaml          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> index 96b329508d8a..2240299dcf2f 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> @@ -11,7 +11,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: ti,am3359-tscadc
> +    oneOf:
> +      - const: ti,am3359-tscadc
> +      - const: ti,am4372-magadc
       enum:
         - ti,am3359-tscadc
         - ti,am4372-magadc

is a little bit cleaner and means the same thing.
>  
>    reg:
>      maxItems: 1
> @@ -42,6 +44,9 @@ patternProperties:
>    "^tsc$":
>      description: Touchscreen controller
>  
> +  "^mag$":
> +    description: Magnetic reader
> +
>  required:
>    - compatible
>    - reg

