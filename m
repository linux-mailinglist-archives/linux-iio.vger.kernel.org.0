Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6474D1A6A9B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 18:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbgDMQyy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 12:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731989AbgDMQx1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 12:53:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 297EB20739;
        Mon, 13 Apr 2020 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796807;
        bh=9aCew5Em0TLlBtgwNkxdemTfwApurfab/CKuSXy17DA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QFYoiIUJOsJoJ1b0IsZ3K2fwQ6oxstALKCknujolFwdEWElKhfUMEfn2qTXoSiqW5
         wrongT7Dh6Mjr2YxCydedo2LCfTy0AksKfH0rlm7xp6HBqNlZcgBBmYRT3E2rmj53z
         dMKbAOO4PwyI1hRrBX86tCi82uP11ok/aVXJCiWQ=
Date:   Mon, 13 Apr 2020 17:53:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     mani@kernel.org
Cc:     robh+dt@kernel.org, narcisaanamaria12@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: chemical: Add binding for CCS811
 VOC sensor
Message-ID: <20200413175323.7f41b766@archlinux>
In-Reply-To: <20200412183658.6755-2-mani@kernel.org>
References: <20200412183658.6755-1-mani@kernel.org>
        <20200412183658.6755-2-mani@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 00:06:56 +0530
mani@kernel.org wrote:

> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> This commit adds devicetree binding for AMS CCS811 VOC sensor.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Great to see this driver getting some more attention.

A few things inline

Thanks,

Jonathan

> ---
>  .../bindings/iio/chemical/ams,ccs811.yaml     | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> new file mode 100644
> index 000000000000..564208af7b2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0

Preferred that all new binding docs are dual licensed with BSD as well
to allow there use by things other than the kernel.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/ams,ccs811.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS CCS811 VOC Sensor
> +
> +maintainers:
> +  - Narcisa Vasile <narcisaanamaria12@gmail.com>
> +
> +description: |
> +  Ultra-Low Power Digital Gas Sensor for Monitoring Indoor Air Quality.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ams,ccs811
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO connected to the nRESET line. This is an active low
> +                 input to CCS811.
> +    maxItems: 1
> +
> +  wakeup-gpios:
> +    description: GPIO connected to the nWAKE line. This is an active low
> +                 input to CCS811.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ccs811@5b {
Hmm. Not sure we have a generic name in the dt spec for voc sensor.
Even so we should try for something appropriate.

Could go with voc@5b?

> +        compatible = "ams,ccs811";
> +        reg = <0x5b>;
> +        reset-gpios = <&gpioa 11 GPIO_ACTIVE_LOW>;
> +        wakeup-gpios = <&gpioa 12 GPIO_ACTIVE_LOW>;
> +      };
> +    };
> +
> +...

