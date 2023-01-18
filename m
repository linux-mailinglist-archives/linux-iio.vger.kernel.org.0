Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED996722D4
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 17:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjARQUf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 11:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjARQUE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 11:20:04 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F0450853;
        Wed, 18 Jan 2023 08:15:46 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NxrP02FgWz6J7G3;
        Thu, 19 Jan 2023 00:11:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 16:15:43 +0000
Date:   Wed, 18 Jan 2023 16:15:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bough Chen <haibo.chen@nxp.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] add imx93 adc support
Message-ID: <20230118161542.00002476@Huawei.com>
In-Reply-To: <DB7PR04MB40106A96C5ABF81CA6613C8790C69@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230103114359.2663262-1-haibo.chen@nxp.com>
        <20230108131505.0a51fe46@jic23-huawei>
        <DB7PR04MB40106A96C5ABF81CA6613C8790C69@DB7PR04MB4010.eurprd04.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Jan 2023 09:00:50 +0000
Bough Chen <haibo.chen@nxp.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: 2023Äê1ÔÂ8ÈÕ 21:15
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: lars@metafoo.de; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> > linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: Re: [PATCH v5 0/3] add imx93 adc support
> > 
> > On Tue,  3 Jan 2023 19:43:55 +0800
> > haibo.chen@nxp.com wrote:
> >   
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > V5:
> > >   -For ADC driver, use dev_err_probe() to replace dev_err() in  
> > dev_err_probe().  
> > >   -Add imx93_adc_power_down() in the probe error path.
> > >   -Re-order the function in imx93_adc_remove(), make them inverse in  
> > probe().  
> > >   -Remove the pm_runtime_get_sync(dev) in imx93_adc_remove(), because  
> > this driver  
> > >    enable the pm_runtime autosuspend feature, and config the delay as  
> > 50ms. So when  
> > >    called imx93_adc_remove(), this device still in runtime resume state, no  
> > need to  
> > >    force resume the device back.  
> > I don't follow this point.  Perhaps talk me through in more detail on why the
> > device will be in a runtime resumed state when ever we hit remove?  
> 
> Hi Jonathan,
> 
> Sorry for delay.
> 
> This driver use module_platform_driver, so when do rmmod or unbind operation
> The function call steps are as belowing:
> platform_driver_unregister
>   --> driver_unregister
>      --> bus_remove_driver
>         --> driver_detach
>            --> device_release_driver_internal
>               --> __device_release_driver  
> 
> In __device_release_driver {
>         pm_runtime_get_sync(dev);
>         ...
>         pm_runtime_put_sync(dev);
>         device_remove(dev);     -> call imx93_adc_remove()
>         ...
> }
> 
> Since in this imx93 adc driver, we use 50ms auto suspend dealy,
>       pm_runtime_set_autosuspend_delay(dev, 50);
> 
> and here is the description of this API  (Documentation/power/runtime_pm.rst):
>   `void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);`
>     - set the power.autosuspend_delay value to 'delay' (expressed in
>       milliseconds); if 'delay' is negative then runtime suspends are
>       prevented; if power.use_autosuspend is set, pm_runtime_get_sync may be
>       called or the device's usage counter may be decremented and
>       pm_runtime_idle called depending on if power.autosuspend_delay is
>       changed to or from a negative value; if power.use_autosuspend is clear,
>       pm_runtime_idle is called
> 
> and the description of pm_runtime_put_sync.
> /**
>  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
>  * @dev: Target device.
>  *
>  * Decrement the runtime PM usage counter of @dev and if it turns out to be
>  * equal to 0, invoke the "idle check" callback of @dev and, depending on its
>  * return value, set up autosuspend of @dev or suspend it (depending on whether
>  * or not autosuspend has been enabled for it).
>  *
>  * The possible return values of this function are the same as for
>  * pm_runtime_idle() and the runtime PM usage counter of @dev remains
>  * decremented in all cases, even if it returns an error code.
>  */
> static inline int pm_runtime_put_sync(struct device *dev)
> {
>         return __pm_runtime_idle(dev, RPM_GET_PUT);
> }
> 
> This means after call the pm_runtime_put_sync in __device_release_driver(), imx93_adc will not call imx93_adc_runtime_suspend() immediately, will do it after 50ms, but just then, call the imx93_adc_remove(), so this means when imx93_adc_remove() execute, the ADC related clocks keep on.

If I follow correctly, that means we are relying on a race?
I don't think it is valid to assume that device_remove will be called within the 50 msec
window even though it is extremely likely.  We should be incrementing the reference
counter appropriately to ensure autosuspend doesn't happen.

Jonathan

> 
> Best Regards
> Haibo Chen
> >   
> > >   -no changes for binding doc and dts.
> > >
> > > V4:
> > >   For ADC driver, re-define the ADC status show the relation to specific  
> > register bit.  
> > >   Redo the imx93_adc_remove(), change the return error sequence in  
> > imx93_adc_read_raw(),  
> > >   and use a direct string for indio_dev->name.
> > >   For dt-bings, change the commit title and add maintainer's reviewed by  
> > tag  
> > >   For dts, no change.
> > >
> > > V3:
> > >   For dt-bings, add some change according to review comments, and pass  
> > dt_binding_check.  
> > >   For dts, add #io-channel-cells = <1>; to pass dtbs_check
> > >   For ADC driver, no change.
> > >
> > > V2:
> > >   For ADC driver, add change according to matainer's commets.
> > >
> > > Haibo Chen (3):
> > >   iio: adc: add imx93 adc support
> > >   dt-bindings: iio: adc: Add NXP IMX93 ADC
> > >   arm64: dts: imx93: add ADC support
> > >
> > >  .../bindings/iio/adc/nxp,imx93-adc.yaml       |  81 +++
> > >  MAINTAINERS                                   |   4 +-
> > >  .../boot/dts/freescale/imx93-11x11-evk.dts    |  12 +
> > >  arch/arm64/boot/dts/freescale/imx93.dtsi      |  13 +
> > >  drivers/iio/adc/Kconfig                       |  10 +
> > >  drivers/iio/adc/Makefile                      |   1 +
> > >  drivers/iio/adc/imx93_adc.c                   | 477  
> > ++++++++++++++++++  
> > >  7 files changed, 597 insertions(+), 1 deletion(-)  create mode 100644
> > > Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > >  create mode 100644 drivers/iio/adc/imx93_adc.c
> > >  
> 

