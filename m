Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5651C25EE0B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 16:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgIFOGu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 10:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgIFOGp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 10:06:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738EE20714;
        Sun,  6 Sep 2020 14:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599401204;
        bh=rng+NuRPujUaWXAY59vmPkfS7pvUhDwfWyJ3A9Yj8j8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QgnNNWIKMeaEYMb9w1/Lx0ZROYZUqq14DNlM395WAKaQ29NtQ868Ov0Lo9kQsbNIH
         9iUsUlev6FXrdl6elE6KBWwmopVo37d61nHUUtJHvjny9L+degc3VkgLSZizPaYmHh
         MumKfYonEz8HIzZVkahClWPiViw2xnQkJCmobbHU=
Date:   Sun, 6 Sep 2020 15:06:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Consolidate Analog Devices IIO
 entries and remove Beniamin Bia
Message-ID: <20200906150640.5ffe7e0f@archlinux>
In-Reply-To: <20200903181926.5606-1-krzk@kernel.org>
References: <20200903181926.5606-1-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Sep 2020 20:19:25 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Emails to Beniamin Bia bounce with no such address so remove him from
> maintainers.  After this removal, many entries for Analog Devices Inc
> IIO drivers look exactly the same so consolidate them.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio <linux-iio@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

As I'd assume a more specific binding always overrides a catch all,
this has the effect of giving Lars and Michael responsibility
for a few things they didn't previously cover.  If the two
of them are fine with it, than that's good, but I'd ideally
like an Ack from Lars.

(we have an indirect one from Michael via Alexandru).

Jonathan


> 
> ---
> 
> Changes since v2:
> 1. Use wildcard for dt-bindings,
> 2. Add Andy's review.
> 
> Changes since v1:
> 1. Consolidate IIO entries
> ---
>  MAINTAINERS | 55 +++--------------------------------------------------
>  1 file changed, 3 insertions(+), 52 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8107b3d5d6df..4a120aec90a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -950,38 +950,6 @@ S:	Supported
>  F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
>  F:	drivers/net/ethernet/amd/xgbe/
>  
> -ANALOG DEVICES INC AD5686 DRIVER
> -M:	Michael Hennerich <Michael.Hennerich@analog.com>
> -L:	linux-pm@vger.kernel.org
> -S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> -F:	drivers/iio/dac/ad5686*
> -F:	drivers/iio/dac/ad5696*
> -
> -ANALOG DEVICES INC AD5758 DRIVER
> -M:	Michael Hennerich <Michael.Hennerich@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> -F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
> -F:	drivers/iio/dac/ad5758.c
> -
> -ANALOG DEVICES INC AD7091R5 DRIVER
> -M:	Beniamin Bia <beniamin.bia@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> -F:	drivers/iio/adc/ad7091r5.c
> -
> -ANALOG DEVICES INC AD7124 DRIVER
> -M:	Michael Hennerich <Michael.Hennerich@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> -F:	drivers/iio/adc/ad7124.c
> -
>  ANALOG DEVICES INC AD7192 DRIVER
>  M:	Alexandru Tachici <alexandru.tachici@analog.com>
>  L:	linux-iio@vger.kernel.org
> @@ -998,15 +966,6 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
>  F:	drivers/iio/adc/ad7292.c
>  
> -ANALOG DEVICES INC AD7606 DRIVER
> -M:	Michael Hennerich <Michael.Hennerich@analog.com>
> -M:	Beniamin Bia <beniamin.bia@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> -F:	drivers/iio/adc/ad7606.c
> -
>  ANALOG DEVICES INC AD7768-1 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-iio@vger.kernel.org
> @@ -1068,7 +1027,6 @@ F:	drivers/iio/imu/adis16475.c
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>  
>  ANALOG DEVICES INC ADM1177 DRIVER
> -M:	Beniamin Bia <beniamin.bia@analog.com>
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Supported
> @@ -1135,15 +1093,6 @@ S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
>  F:	drivers/dma/dma-axi-dmac.c
>  
> -ANALOG DEVICES INC HMC425A DRIVER
> -M:	Beniamin Bia <beniamin.bia@analog.com>
> -M:	Michael Hennerich <michael.hennerich@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> -F:	Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> -F:	drivers/iio/amplifiers/hmc425a.c
> -
>  ANALOG DEVICES INC IIO DRIVERS
>  M:	Lars-Peter Clausen <lars@metafoo.de>
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> @@ -1152,8 +1101,11 @@ W:	http://wiki.analog.com/
>  W:	http://ez.analog.com/community/linux-device-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> +F:	Documentation/devicetree/bindings/iio/*/adi,*
> +F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
>  F:	drivers/iio/*/ad*
>  F:	drivers/iio/adc/ltc249*
> +F:	drivers/iio/amplifiers/hmc425a.c
>  F:	drivers/staging/iio/*/ad*
>  X:	drivers/iio/*/adjd*
>  
> @@ -16537,7 +16489,6 @@ F:	drivers/staging/rtl8712/
>  
>  STAGING - SEPS525 LCD CONTROLLER DRIVERS
>  M:	Michael Hennerich <michael.hennerich@analog.com>
> -M:	Beniamin Bia <beniamin.bia@analog.com>
>  L:	linux-fbdev@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml

