Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97162418959
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhIZON6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 10:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231806AbhIZON5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 10:13:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A30660FC2;
        Sun, 26 Sep 2021 14:12:18 +0000 (UTC)
Date:   Sun, 26 Sep 2021 15:16:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/3] iio: imx8qxp-adc: Add driver support for NXP
 IMX8QXP ADC
Message-ID: <20210926151607.0c78736f@jic23-huawei>
In-Reply-To: <20210925020555.129-1-caihuoqing@baidu.com>
References: <20210925020555.129-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Sep 2021 10:05:44 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> The NXP i.MX 8QuadXPlus SOC has a new ADC IP. These patches add
> driver support for this ADC.

Hi Cai Huoqing,

Series applies with the changes discussed in replies to patch 1.

Applied to the togreg branch of iio.git which will be initially pushed out as
testing to let 0-day see if it can find anything we missed.

Thanks,

Jonathan

> 
> dt-bindings: iio: adc:
> v1->v2:
>         *Fix some indentation issues.
>         *Mark status as okay.
>         *Change clock2 source.
> v3->v4:
>         *Remove 'status' from examples.
>         *Remove unused 'state'.
>         *Remove interrupts-parent.
>         *Change num of address/size-cells from 1 to 2.
> v4->v5:
>         *Remove unused properties.
> 
> iio: imx8qxp-adc:
> v1->v2:
> 	*Squash patches 1, 2, 3, and 5 into a single patch.
> 	*Add device specific prefix.
> 	*Remove the brackets around individual numbers.
> 	*Make use of FIELD_PREP() and FIELD_GET().
> 	*Remove a lot of cache values.
> 	*Replace mlock with adc->lock.
> 	*Move adc->value read from isr to the completion.
> 	*Set pm_runtime_disable/_put_noidle() before adc_disable.
> 	*Add error handler-err_disable_reg/err_unprepare_clk.
> v2->v3:
> 	*Add "return 0" to adc_runtime_resume().
> v3->v4:
> 	*Sort header file declarations in alphabetical order.
> 	*Remove explicitly cast from "void *".
> 	*Make use of dev_err_probe().
> 	*Add some blank lines to help readability.
> v4->v5:
> 	*Update commit message.
> 	*Remove unused headers.
> 	*Wrap imx8qxp_adc_read_raw() at a shorter line length that helps readability.
> 	*Deal with clock/regulator in probe/remove().
> 	*Use ADC_DRIVER_NAME instead of dev_name(dev).
> 	*Don't use dev_error_probe() without returning -PROBE_DEFER.
> v5->v6:
> 	*Rename the error path labels to indicate the action that will be performed.
> 
> v1 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-4-caihuoqing@baidu.com/
> v3 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210907015724.1377-1-caihuoqing@baidu.com/
> v4 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210912071334.1745-1-caihuoqing@baidu.com/
> v5 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210921052821.91-1-caihuoqing@baidu.com/
> 
> Cai Huoqing (3):
>   iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC
>   iio: imx8qxp-adc: dt-bindings: iio: adc: Add binding documentation for
>      NXP IMX8QXP ADC
>   MAINTAINERS: Add the driver info of the NXP IMX8QXP
> 
>  .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     |  78 +++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/imx8qxp-adc.c                 | 492 ++++++++++++++++++
>  5 files changed, 588 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
>  create mode 100644 drivers/iio/adc/imx8qxp-adc.c
> 

