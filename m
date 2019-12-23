Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0281C1295C7
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 13:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLWMBp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 07:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfLWMBo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 07:01:44 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B3F20709;
        Mon, 23 Dec 2019 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577102504;
        bh=d1XHN84mIpC2WXkedmTZRyzHrAdPTzEjVBsv9ilL3eQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AWSgqV1tfgltZkoaQo7tvfGClXEg/YBvCCIwImwZXzCgnC4OYTFGLi3U81XZZ914f
         0FTZnPBCXhQGVSXh1Eq+ViGhQTAGedHaUdu+JB4pR848N/WxNtQVETImFl7GfnAAR8
         nJ/qLxlRL/hO9leeHauXQTjqTQOh4mALTyOwYLGw=
Date:   Mon, 23 Dec 2019 12:01:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 03/10] dt-bindings: iio: trigger: at91-rtc-trigger: add
 bindings
Message-ID: <20191223120139.557416b8@archlinux>
In-Reply-To: <1576686157-11939-4-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
        <1576686157-11939-4-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Dec 2019 16:23:59 +0000
<Eugen.Hristev@microchip.com> wrote:

> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Add bindings for AT91 RTC ADC Trigger hardware node.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
If this does make sense (under discussion) I think it should be in
the rtc binding doc.  This doesn't make it explicit that this particular
block is a child node of that block as far as I can see...

Jonathan

> ---
>  .../bindings/iio/trigger/at91-rtc-trigger.yaml     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 040000 Documentation/devicetree/bindings/iio/trigger
>  create mode 100644 Documentation/devicetree/bindings/iio/trigger/at91-rtc-trigger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/trigger/at91-rtc-trigger.yaml b/Documentation/devicetree/bindings/iio/trigger/at91-rtc-trigger.yaml
> new file mode 100644
> index 0000000..c8c5886
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/trigger/at91-rtc-trigger.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2019 Eugen Hristev <eugen.hristev@gmail.com>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/bindings/iio/trigger/microchip,rtc-adc-trigger.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Microchip AT91 RTC ADC Trigger (Real Time Clock to Analog to Digital Converter)
> +
> +maintainers:
> +  - Eugen Hristev <eugen.hristev@microchip.com>
> +
> +description: |
> +  Bindings for the Microchip AT91 RTC ADC Trigger.
> +  The Real Time Clock block inside AT91 SoCs can be connected with a direct
> +  hardware line to the ADC. This line can be raised at a specific time
> +  interval in order to trigger the ADC to perform conversions.
> +  Datasheet can be found here: http://ww1.microchip.com/downloads/en/devicedoc/ds60001476b.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,rtc-adc-trigger
> +
> +  reg:
> +    description: |
> +      Register map address (start address, size).
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    {
> +      #address_cells = <1>;
> +      #size-cells = <1>;
> +
> +      rtc_adc_trigger: rtc-adc-trigger {
> +        reg = <0x0 0x10>;
> +        compatible = "microchip,rtc-adc-trigger";
> +      };
> +    };

