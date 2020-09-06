Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF9025EE71
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgIFPCQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 11:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbgIFPB5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:01:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 538E320714;
        Sun,  6 Sep 2020 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599404516;
        bh=B4hJH2Exj10eov4vlPb/9VaNEbHGmeM6Q+hdPmf5u1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tzP/88p3dT49e/Xz6wpcBVsfHumavYXE1fNkqD47ygYOemZmeELltPxPuKxL32xru
         BN9i9EndetOxyBWZHLtBkLAhRRIjbXvZPrhGdRRU+FnTnowSQc6J7a87tiqQHZm7/v
         Tzpxf5iRpvb30nH7gO+95/Ez9a4nRIPGdnkPNGEY=
Date:   Sun, 6 Sep 2020 16:01:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     robh+dt@kernel.org, dragos.bogdan@analog.com,
        darius.berghe@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: gyro: adxrs290: Add interrupts
 support
Message-ID: <20200906160152.552d42bb@archlinux>
In-Reply-To: <20200903130950.6274-3-nish.malpani25@gmail.com>
References: <20200903130950.6274-1-nish.malpani25@gmail.com>
        <20200903130950.6274-3-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Sep 2020 18:39:49 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Include 'interrupts' property and provide a suitable example for using
> a GPIO interrupt line.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>

One little point inline.  Otherwise looks fine to me

Thanks,

Jonathan

> ---
> 
> Changes in v2:
> 
>   - remove 'interrupts' property from the required properties list
>   - rewrite commit message
> ---
>  .../devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml    | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> index 61adb2c2454b..a5f209e8bbef 100644
> --- a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> @@ -28,6 +28,9 @@ properties:
>  
>    spi-cpha: true
>  
> +  interrupts:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -39,6 +42,8 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>

Shouldn't need that header.  I don't see anything being used that
is defined in gpio.h

> +    #include <dt-bindings/interrupt-controller/irq.h>
>      spi {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -48,6 +53,8 @@ examples:
>                     spi-max-frequency = <5000000>;
>                     spi-cpol;
>                     spi-cpha;
> +                   interrupt-parent = <&gpio>;
> +                   interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>          };
>      };
>  ...

