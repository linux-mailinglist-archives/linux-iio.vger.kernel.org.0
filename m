Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06368256948
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgH2RP3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgH2RP2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:15:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 574E620707;
        Sat, 29 Aug 2020 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598721327;
        bh=yFdlUpmzfpHPN+BckagMXN8w6ogeGfkv5WdcU0OccqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2qANvniKoV3Er+jHPqIWm0EcDFQ7XsexKbjnKGVFLx+lRNNeO47vTGlslo6entWl2
         aMZi6C4GPtkR8N9Zarg3mT0CVUMjb3lMHzLWXvQcy97F3buTwxt3PHZ2sRaDPvOufA
         GO3uXjzCoHl0zN4joJD4a+je7x3JzkOCpEqltdgw=
Date:   Sat, 29 Aug 2020 18:15:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v3 2/2] Documentation: ABI: testing: mt6360: Add ADC
 sysfs guideline
Message-ID: <20200829181522.3664e1ce@archlinux>
In-Reply-To: <1598259985-12517-3-git-send-email-gene.chen.richtek@gmail.com>
References: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
        <1598259985-12517-3-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Aug 2020 17:06:25 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add ABI documentation for mt6360 ADC sysfs interfaces.

Please check this.  The actual filenames don't look correct
to me.

> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> new file mode 100644
> index 0000000..9dab17e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> @@ -0,0 +1,83 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/usbid_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 USBID ADC
Can we give a bit of text saying what that is?

It's nice if people writing userspace software looking at this don't have
to go find the datasheet just to give a human readable description of the
channel.

> +		Reading returns current voltage in uV
drop _current_ as that's a bit confusing :)

Reading returns voltage in uV

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/vbusdiv5_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VBUS ADC with high accuracy
> +		Reading returns current voltage in uV

Is this measuring output of a regulator which has taken vbus and divided
it by 5?  I'm rather confused.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/vbusdiv2_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VBUS ADC with low accuracy
> +		Reading returns current voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/vsys_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VSYS ADC
> +		Reading returns current voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/vbat_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VBAT ADC
> +		Reading returns current voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/ibus_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 IBUS ADC
> +		Reading returns current in uA
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/ibat_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 IBAT ADC
> +		Reading returns current in uA
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/chg_vddp_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 CHG_VDDP ADC
> +		Reading returns current voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/temp_jc_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 IC junction temperature
> +		Reading returns current temperature in degree
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/vref_ts_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 VREF_TS ADC
> +		Reading returns current voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/ts_input
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 TS ADC
> +		Reading returns current voltage in uV
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/timestamp
> +KernelVersion:	5.8.0
> +Contact:	gene_chen@richtek.com
> +Description:
> +		Indicated MT6360 timestamp
> +		Reading returns current timestamp in ms

