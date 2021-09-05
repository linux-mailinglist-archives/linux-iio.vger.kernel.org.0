Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D60400F6C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbhIEL7B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 07:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhIEL7B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 07:59:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED22660E94;
        Sun,  5 Sep 2021 11:57:51 +0000 (UTC)
Date:   Sun, 5 Sep 2021 13:01:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v2 06/46] dt-bindings: mfd: ti,am3359-tscadc: Describe
 am4372 MFD compatible
Message-ID: <20210905130114.64726e0d@jic23-huawei>
In-Reply-To: <20210902215144.507243-7-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-7-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:04 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> A more recent version of the am3359 ADC/Touchscreen controller is
> available on certain SoCs of the am437x family. This IP has evolved a
> little bit and deserves its own compatible.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
This makes sense given the changes in the precursors from v1.
FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> index b2bff85f2329..34bf6a01436f 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> @@ -16,6 +16,7 @@ properties:
>        - items:
>            - const: ti,am654-tscadc
>            - const: ti,am3359-tscadc
> +      - const: ti,am4372-magadc
>  
>    reg:
>      maxItems: 1
> @@ -47,6 +48,10 @@ properties:
>      type: object
>      description: Touchscreen controller child
>  
> +  mag:
> +    type: object
> +    description: Magnetic reader
> +
>  required:
>    - compatible
>    - reg

