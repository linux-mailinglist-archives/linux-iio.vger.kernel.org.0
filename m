Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4240318E2F8
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 17:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgCUQqs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 12:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgCUQqr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 12:46:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97A320739;
        Sat, 21 Mar 2020 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584809206;
        bh=vYbULo9CJnfDockLM5jOYJkQXCKXQwm4lW58TnsCHkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dqr1PSFbTbdzXalDyEChhdhgE571QWeyNHXtVVjRnlsigvbJxKX6JjvCpHkreYCvm
         Jvjl7cU86vKwg1iltPQe2t6vhIOza96XlrETuJBbo7gzKM1U/Cbxxk/hjp3OtEUxnt
         0882HyZ67WFOQnX+5njqMB30S/rxIIMlO6ZAtuFY=
Date:   Sat, 21 Mar 2020 16:46:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v2] MAINTAINERS: remove Stefan Popa's email
Message-ID: <20200321164642.0cad6b9d@archlinux>
In-Reply-To: <20200321090442.11383-1-alexandru.ardelean@analog.com>
References: <20200317143336.6098-1-alexandru.ardelean@analog.com>
        <20200321090442.11383-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 11:04:42 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The email is no longer active. This change removes Stefan's email from the
> MAINTAINERS list and replaces it with Michael Hennerich's.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.  Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * re-send + change author @analog.com; GMail messed it up
> 
>  MAINTAINERS | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fa40c3eb72a..72e8960c4f4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -552,7 +552,7 @@ F:	drivers/input/misc/adxl34x.c
>  F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
>  
>  ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> -M:	Stefan Popa <stefan.popa@analog.com>
> +M:	Michael Hennerich <michael.hennerich@analog.com>
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/accel/adxl372.c
> @@ -900,7 +900,7 @@ F:	drivers/net/ethernet/amd/xgbe/
>  F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
>  
>  ANALOG DEVICES INC AD5686 DRIVER
> -M:	Stefan Popa <stefan.popa@analog.com>
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-pm@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
> @@ -908,7 +908,7 @@ F:	drivers/iio/dac/ad5686*
>  F:	drivers/iio/dac/ad5696*
>  
>  ANALOG DEVICES INC AD5758 DRIVER
> -M:	Stefan Popa <stefan.popa@analog.com>
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
> @@ -924,7 +924,7 @@ F:	drivers/iio/adc/ad7091r5.c
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
>  
>  ANALOG DEVICES INC AD7124 DRIVER
> -M:	Stefan Popa <stefan.popa@analog.com>
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
> @@ -948,7 +948,7 @@ F:	drivers/iio/adc/ad7292.c
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
>  
>  ANALOG DEVICES INC AD7606 DRIVER
> -M:	Stefan Popa <stefan.popa@analog.com>
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  M:	Beniamin Bia <beniamin.bia@analog.com>
>  L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
> @@ -957,7 +957,7 @@ F:	drivers/iio/adc/ad7606.c
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
>  
>  ANALOG DEVICES INC AD7768-1 DRIVER
> -M:	Stefan Popa <stefan.popa@analog.com>
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
> @@ -1018,7 +1018,7 @@ F:	drivers/hwmon/adm1177.c
>  F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
>  
>  ANALOG DEVICES INC ADP5061 DRIVER
> -M:	Stefan Popa <stefan.popa@analog.com>
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-pm@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
> @@ -1078,7 +1078,6 @@ F:	drivers/dma/dma-axi-dmac.c
>  ANALOG DEVICES INC IIO DRIVERS
>  M:	Lars-Peter Clausen <lars@metafoo.de>
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> -M:	Stefan Popa <stefan.popa@analog.com>
>  W:	http://wiki.analog.com/
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported

