Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9703267F09
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgIMJyz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 05:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgIMJyx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 05:54:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA44C208E4;
        Sun, 13 Sep 2020 09:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599990893;
        bh=VswA9JFe++tL2MaxJVyC85+0l1cdxeIVvqkxRaDh/vM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=am+nwgemtcwFheh6fa8FWwt+muzdubSnxDiZlrlxyPEoPx7oX3C2Xii77M1rMoejc
         XQ6yOqesUGdXEhZYQG5JI2aKqEkRhAb1eSOvic82vWzSRzTeTZua/77avbIBT8Lz2a
         Q18/3TYgItBPLB3kHxwHKb7LOf0xtqB1NQa8hKnY=
Date:   Sun, 13 Sep 2020 10:54:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [RESEND PATCH v3 2/3] dt-bindings: iio: gyro: adxrs290: Add
 interrupts support
Message-ID: <20200913105448.25574254@archlinux>
In-Reply-To: <20200910180450.29696-3-nish.malpani25@gmail.com>
References: <20200910180450.29696-1-nish.malpani25@gmail.com>
        <20200910180450.29696-3-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 23:34:49 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Include 'interrupts' property and provide a suitable example for using
> a GPIO interrupt line.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
This one is 'so trivial' (famous last words) that I'm not going
to wait for Rob H to get to it.  Obviously anything Rob wants to add
will be most welcome and might beat me pushing this out as non rebasing.

Applied to the togreg branch of iio.git.

Thanks,
Jonathan

> ---
> 
> Changes in v3:
>   - remove gpio.h header since unused
> 
> Changes in v2:
> 
>   - remove 'interrupts' property from the required properties list
>   - rewrite commit message
> ---
>  .../devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> index 61adb2c2454b..662ec59ca0af 100644
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
> @@ -39,6 +42,7 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      spi {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -48,6 +52,8 @@ examples:
>                     spi-max-frequency = <5000000>;
>                     spi-cpol;
>                     spi-cpha;
> +                   interrupt-parent = <&gpio>;
> +                   interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>          };
>      };
>  ...

