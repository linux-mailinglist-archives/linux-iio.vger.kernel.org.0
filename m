Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CA2258A8D
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 10:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIAImB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 04:42:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgIAImA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Sep 2020 04:42:00 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A4D08DF3B0C74C98974F;
        Tue,  1 Sep 2020 09:41:58 +0100 (IST)
Received: from localhost (10.52.122.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 1 Sep 2020
 09:41:58 +0100
Date:   Tue, 1 Sep 2020 09:40:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: aarch64 iio build error [PATCH]
Message-ID: <20200901094021.000068b2@Huawei.com>
In-Reply-To: <380f1b70-6575-5869-edf4-28842e818732@infradead.org>
References: <CAPM=9txbCfEB0x+uxw9qWH24-ziY5BK25r-S-HWYhe+UCW_rKQ@mail.gmail.com>
        <380f1b70-6575-5869-edf4-28842e818732@infradead.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.233]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Aug 2020 23:56:09 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 8/24/20 12:39 PM, Dave Airlie wrote:
> > Hi Jonahtan,
> > 
> > Since rc1 my aarch64 builds have been failing
> > 
> >   MODPOST Module.symvers
> > ERROR: modpost: "devm_iio_triggered_buffer_setup"
> > [drivers/iio/adc/rockchip_saradc.ko] undefined!
> > ERROR: modpost: "iio_trigger_notify_done"
> > [drivers/iio/adc/rockchip_saradc.ko] undefined!
> > ERROR: modpost: "iio_push_to_buffers"
> > [drivers/iio/adc/rockchip_saradc.ko] undefined!
> > make[2]: *** [/home/airlied/devel/kernel/dim/src/scripts/Makefile.modpost:111:
> > Module.symvers] Error
> > 
> > Attached config.
> > 
> > Dave.  
> 
> I haven't see any fixes for this, although I could have easily
> missed a patch.
> 
> The patch below should fix these build errors.

Sorry. Badly timed vacation + waiting for end of merge window
due to some other stuff in the same pull request.

We had a number of fixes come in for this as a result.

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=e3ea4192d82480e1215280267746f51ce21db283

Is on it's way..

Jonathan

> 
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors in iio/rockchip_saradc by adding selects
> to drivers/iio/adc/Kconfig.
> 
> Fixes these build errors:
> 
> ERROR: modpost: "devm_iio_triggered_buffer_setup"
> [drivers/iio/adc/rockchip_saradc.ko] undefined!
> ERROR: modpost: "iio_trigger_notify_done"
> [drivers/iio/adc/rockchip_saradc.ko] undefined!
> ERROR: modpost: "iio_push_to_buffers"
> [drivers/iio/adc/rockchip_saradc.ko] undefined!
> 
> Reported-by: Dave Airlie <airlied@gmail.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: jonathan.cameron@huawei.com
> ---
>  drivers/iio/adc/Kconfig |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- linux-next-20200825.orig/drivers/iio/adc/Kconfig
> +++ linux-next-20200825/drivers/iio/adc/Kconfig
> @@ -865,6 +865,10 @@ config ROCKCHIP_SARADC
>  	tristate "Rockchip SARADC driver"
>  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
>  	depends on RESET_CONTROLLER
> +	select IIO_BUFFER
> +	select IIO_TRIGGER
> +	select IIO_TRIGGERED_BUFFER
> +	select IIO_TRIGGERED_EVENT
>  	help
>  	  Say yes here to build support for the SARADC found in SoCs from
>  	  Rockchip.


