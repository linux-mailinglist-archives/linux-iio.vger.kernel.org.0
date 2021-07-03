Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E0F3BA953
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhGCQCz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 12:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhGCQCy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 12:02:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CA961935;
        Sat,  3 Jul 2021 16:00:19 +0000 (UTC)
Date:   Sat, 3 Jul 2021 17:02:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lars@metafoo.de,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/4] dt-bindings: mfd: ricoh,rn5t618: ADC related nodes
 and properties
Message-ID: <20210703170245.1d310342@jic23-huawei>
In-Reply-To: <20210703084224.31623-2-andreas@kemnade.info>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703084224.31623-2-andreas@kemnade.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  3 Jul 2021 10:42:21 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Add ADC related nodes and properties. This will allow to wire
> up ADC channels to consumers, especially to measure input voltages
> by the power subdevice.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../bindings/mfd/ricoh,rn5t618.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> index 032a7fb0b4a7..185f87a14a54 100644
> --- a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> @@ -73,6 +73,48 @@ properties:
>      description: |
>        See Documentation/devicetree/bindings/power/power-controller.txt
>  
> +  adc:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - ricoh,rn5t618-adc
> +          - ricoh,rc5t619-adc
> +
> +      "#io-channel-cells":
> +        const: 1
> +
> +    additionalProperties: false
> +
> +    required:
> +      - compatible
> +      - "#io-channel-cells"

Strictly required?  If not used below (where it is optional)
then why do we require the ADC driver to provided the services?

I don't mind you leave it as it is though if you prefer - it doesn't
do any harm!

> +
> +  power:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - ricoh,rn5t618-power
> +          - ricoh,rc5t619-power
> +
> +      io-channels:
> +        items:
> +          - description: ADP Voltage Channel
> +          - description: USB Voltage Channel
> +
> +      io-channel-names:
> +        items:
> +          - const: vadp
> +          - const: vusb
> +
> +    additionalProperties: false
> +
> +    required:
> +      - compatible
> +
>    regulators:
>      type: object
>  
> @@ -96,6 +138,17 @@ examples:
>          interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
>          system-power-controller;
>  
> +        rn5t618_adc: adc {
> +          compatible = "ricoh,rn5t618-adc";
> +          #io-channel-cells = <1>;
> +        };
> +
> +        power {
> +          compatible = "ricoh,rn5t618-power";
> +          io-channels = <&rn5t618_adc 2>, <&rn5t618_adc 3>;
> +          io-channel-names = "vadp", "vusb";
> +        };
> +
>          regulators {
>            DCDC1 {
>              regulator-min-microvolt = <1050000>;

