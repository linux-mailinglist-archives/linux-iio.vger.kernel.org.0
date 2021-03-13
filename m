Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFEA339ED9
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 16:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhCMPP5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 10:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:32844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhCMPPY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 10:15:24 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A9864F16;
        Sat, 13 Mar 2021 15:15:21 +0000 (UTC)
Date:   Sat, 13 Mar 2021 15:15:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings:iio:adc: add generic
 settling-time-us and average-samples channel properties
Message-ID: <20210313151518.2681a59a@archlinux>
In-Reply-To: <20210312105515.32055-2-o.rempel@pengutronix.de>
References: <20210312105515.32055-1-o.rempel@pengutronix.de>
        <20210312105515.32055-2-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Mar 2021 11:55:13 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Settling time and over sampling is a typical challenge for different IIO ADC
> devices. So, introduce channel specific settling-time-us and average-samples
> properties to cover this use case.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index 912a7635edc4..c748f6573027 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -39,4 +39,13 @@ properties:
>        The first value specifies the positive input pin, the second
>        specifies the negative input pin.
>  
> +  settling-time-us:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Time between enabling the channel and firs stable readings.

first

> +
> +  average-samples:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Number of data samples which are averaged for each read.

So in IIO at least, we tend to refer to this as oversampling.  Perhaps we
should use that term here as well?  It would also be good to give some hint
as to why this might be a DT property rather than a userspace control.

Thanks,

Jonathan

> +
>  additionalProperties: true

