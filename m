Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027AF25AE5D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgIBPHT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 11:07:19 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbgIBPHP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Sep 2020 11:07:15 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C3B94761A13BA2A600AB;
        Wed,  2 Sep 2020 16:07:09 +0100 (IST)
Received: from localhost (10.52.121.91) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 2 Sep 2020
 16:07:09 +0100
Date:   Wed, 2 Sep 2020 16:05:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] MAINTAINERS: Consolidate Analog Devices IIO
 entries and remove Beniamin Bia
Message-ID: <20200902160536.00000cfe@Huawei.com>
In-Reply-To: <20200902145957.13861-1-krzk@kernel.org>
References: <20200902145957.13861-1-krzk@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.91]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Sep 2020 16:59:56 +0200
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
> 

I'll need acks from Michael and Lars to do this.

Jonathan

> ---
> 
> Changes since v1:
> 1. Consolidate IIO entries
> ---
>  MAINTAINERS | 56 ++++-------------------------------------------------
>  1 file changed, 4 insertions(+), 52 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8107b3d5d6df..facffcf7b1d1 100644
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
> @@ -1152,8 +1101,12 @@ W:	http://wiki.analog.com/
>  W:	http://ez.analog.com/community/linux-device-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> +F:	Documentation/devicetree/bindings/iio/adc/adi*
> +F:	Documentation/devicetree/bindings/iio/amplifiers/adi*
> +F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
>  F:	drivers/iio/*/ad*
>  F:	drivers/iio/adc/ltc249*
> +F:	drivers/iio/amplifiers/hmc425a.c
>  F:	drivers/staging/iio/*/ad*
>  X:	drivers/iio/*/adjd*
>  
> @@ -16537,7 +16490,6 @@ F:	drivers/staging/rtl8712/
>  
>  STAGING - SEPS525 LCD CONTROLLER DRIVERS
>  M:	Michael Hennerich <michael.hennerich@analog.com>
> -M:	Beniamin Bia <beniamin.bia@analog.com>
>  L:	linux-fbdev@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml


