Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC6A49D266
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jan 2022 20:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244385AbiAZTQP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jan 2022 14:16:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4520 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiAZTQO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jan 2022 14:16:14 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JkYJW4JDTz67JwR;
        Thu, 27 Jan 2022 03:12:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 26 Jan 2022 20:16:11 +0100
Received: from localhost (10.47.31.55) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 26 Jan
 2022 19:16:11 +0000
Date:   Wed, 26 Jan 2022 19:16:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio_trigger_poll from IRQ thread
Message-ID: <20220126191606.00003f37@Huawei.com>
In-Reply-To: <BYAPR03MB46473D8DDED835EDBDB20A8297209@BYAPR03MB4647.namprd03.prod.outlook.com>
References: <BYAPR03MB46473D8DDED835EDBDB20A8297209@BYAPR03MB4647.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.55]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Jan 2022 14:43:45 +0000
"Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com> wrote:

> Hi, 
> 
> I'm currently trying to call iio_trigger_poll from the bottom-half of an interrupt handler and get the following waring;
> 
> [  101.814234] WARNING: CPU: 0 PID: 1204 at kernel/irq/handle.c:152 __handle_irq_event_percpu+0x234/0x238
> [  101.814255] irq 60 handler irq_default_primary_handler+0x0/0x1c enabled interrupts
> [  101.814268] Modules linked in: ade9078 cmac rfcomm bnep hci_uart btbcm bluetooth ecdh_generic ecc fuse 8021q garp brcmfmac brcmutil cfg80211 v3d rfkill spi_bcm2835 gpu_sched raspberrypi_hwmon bcm2835_codec(C) snd_bcm2835(C) bcm2835_v4l2(C) bcm2835_isp(C) v4l2_mem2mem bcm2835_mmal_vchiq(C) vc_sm_cma(C) rpivid_mem vc4 uio_pdrv_genirq uio i2c_dev ip_tables x_tables
> [  101.814452] CPU: 0 PID: 1204 Comm: irq/58-ade9078 Tainted: G         C        5.4.83-v7l+ #7
> 
> This warning occurs only once, the first time it goes through this scenario, on a second passing through it I get no warning.
> After reading online about it, the problem is related to disabling the interrupts prior to entering the IIO Handler. 
> By doing this manually I don't get any Warnings, but it has been pointed out to me that this might not be a good solution.
> 
> I'm using the bottom-half of the handler because the interrupt requires reading the status register of the IC, which can be slow.
> Unfortunately there is no way to insert the iio_trigger_poll in the top-half because all the checks are done in the bottom-half.
> 
> The trigger_handler reads the samples from an internal FIFO in the IC, I'm not sure if this detail is relevant or not. 

If in bottom half, call iio_trigger_poll_chained().

It's a bit of a hack in the sense that it will only run the bottom half
of the pollfuncs which isn't always what is wanted (can miss timestamps
being stored for example) but mostly works.

Not well named either which I've been meaning to fix for a very
long time :(

However, if there is a fifo involved, is it useful to use the trigger
framework at all?  That only normally makes sense if there is one
'trigger' per 'scan'.  If your fifo is working on the basis of
a watermark interrupt for when the buffer has N scans of data in it
then it's normally better to just not use a trigger at all and fill
the buffer directly from the interrupt bottom half.
Things can get a bit fiddly if you also want to support other triggers
but there are drivers that do that.  No trigger means fill directly,
trigger means grabbing data via a path not using the fifo (or with
fifo depth set to 1 scan)

Jonathan

> 
> Regards,
> Ciprian

