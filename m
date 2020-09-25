Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361B92786CA
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 14:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgIYMP5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 08:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYMP5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 08:15:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 989BA21D7A;
        Fri, 25 Sep 2020 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601036156;
        bh=kwR9lgq75oem2SESbbdu8Dipj1Q8zTQ+UnnWezcapFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=no4C+nJyV2mcqN2CwSdvw/0kwskREmHydE8VA5s7AbOR06GF2CsyHrzSHOMM0Z3/t
         emMPgDLX9SOBleJLLUfsVNObhQW1CVUljmp3BccgSxyS2FIa8fje8dvxvlCpzo4SP5
         a6kO5w+gcFyndNxj5dH1yqRhVVV3CbXU4mcHjskI=
Date:   Fri, 25 Sep 2020 13:15:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v5 2/3] Documentation: ABI: testing: mt6360: Add ADC
 sysfs guideline
Message-ID: <20200925131550.10717161@archlinux>
In-Reply-To: <1600687442-23658-3-git-send-email-gene.chen.richtek@gmail.com>
References: <1600687442-23658-1-git-send-email-gene.chen.richtek@gmail.com>
        <1600687442-23658-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Sep 2020 19:24:01 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add ABI documentation for mt6360 ADC sysfs interfaces.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
Hi Gene,

My first thought was we don't need this now we are dealing with
standard ABI only, but there is some useful additional documentation
in here which is good to have.

Looks good to me!

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> new file mode 100644
> index 0000000..e5a7b1c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> @@ -0,0 +1,78 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 USBID ADC which connected to connector ID pin.
> +		Calculating with scale and offset returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage1_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VBUS ADC with lower accuracy(+-75mA)
> +		higher measure range(1~22mV)
> +		Calculating with scale and offset returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VBUS ADC with higher accuracy(+-30mA)
> +		lower measure range(1~9.76V)
> +		Calculating with scale and offset returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage3_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VSYS ADC
> +		Calculating with scale and offset returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage4_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VBAT ADC
> +		Calculating with scale and offset returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current5_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 IBUS ADC
> +		Calculating with scale and offset returns voltage in uA
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current6_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 IBAT ADC
> +		Calculating with scale and offset returns voltage in uA
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current7_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 CHG_VDDP ADC
> +		Calculating with scale and offset returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_temp8_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 IC junction temperature
> +		Calculating with scale and offset returns temperature in degree
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage9_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VREF_TS ADC
> +		Calculating with scale and offset returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage10_raw
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 TS ADC
> +		Calculating with scale and offset returns voltage in uV

