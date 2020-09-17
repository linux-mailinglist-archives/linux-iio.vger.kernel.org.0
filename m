Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7126E2C0
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 19:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgIQRod (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 13:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgIQRnZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 13:43:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C5E5208E4;
        Thu, 17 Sep 2020 17:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600364583;
        bh=bi6TmqYi2rgk/B1f4FxQaiZqBpH7FUeVuFmqBR3sG9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nsg/QuUfuwuQSZssMC9S7zpn1F9Tedcy1flb1AOphcnmFIQd6pBJnjjd4hh58vLa6
         q0jW6lytqDQPixY3l2OxJWzCbPVJvHQfpe2tCCbaMJTT1Z4MN+F4bdYVW1RXrUe2Zu
         Vt1X7KJcaUN+dqNrzdGLIyp8oQjRAhtchTDnRzS0=
Date:   Thu, 17 Sep 2020 18:42:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com, Cristian Pop <cristian.pop@analog.com>
Subject: Re: [PATCH v4 2/3] Documentation: ABI: testing: mt6360: Add ADC
 sysfs guideline
Message-ID: <20200917184256.71328701@archlinux>
In-Reply-To: <1600191369-28040-3-git-send-email-gene.chen.richtek@gmail.com>
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
        <1600191369-28040-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 01:36:08 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add ABI documentation for mt6360 ADC sysfs interfaces.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
Would you consider using the proposed label attribute for channels?

https://lore.kernel.org/linux-iio/20200916132115.81795-1-cristian.pop@analog.com/T/#u

I'm hoping that will remove the need to have ext name used in the majority of
cases and would like to know if it would work for you?
It may not work for this particular case of course.

Other comments inline.

> ---
>  Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> new file mode 100644
> index 0000000..4b1c270
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> @@ -0,0 +1,83 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_USBID_input


The mixture of case is a bit ugly.  Could we do 
in_voltage_usbin_input?

> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 USBID ADC which connected to connector ID pin.
> +		Reading returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_VBUSDIV5_input

> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VBUS ADC with high accuracy
> +		Reading returns voltage in uV

Why would we ever read the low accuracy version?  

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_VBUSDIV2_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VBUS ADC with low accuracy
> +		Reading returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_VSYS_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VSYS ADC
> +		Reading returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_VBAT_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VBAT ADC
> +		Reading returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current_IBUS_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 IBUS ADC
> +		Reading returns current in uA
Given voltage and current are already clear from the channel type,
could we avoid the repetition?

in_current_bus_input perhaps?

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current_IBAT_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 IBAT ADC
> +		Reading returns current in uA
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_CHG_VDDP_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 CHG_VDDP ADC
> +		Reading returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_temp_TEMP_JC_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 IC junction temperature
> +		Reading returns temperature in degree
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_VREF_TS_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VREF_TS ADC
> +		Reading returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_TS_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 TS ADC
> +		Reading returns voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/timestamp
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 timestamp
> +		Reading returns current timestamp in ms

That's an odd bit of ABI.  Why would we want to read the current timestamp from
sysfs?  Timestamps in IIO also tend to be in nano seconds.




