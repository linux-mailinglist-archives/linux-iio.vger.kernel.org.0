Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08347792E4
	for <lists+linux-iio@lfdr.de>; Fri, 11 Aug 2023 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjHKPVU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Aug 2023 11:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjHKPUt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2023 11:20:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3081A3A8C
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 08:20:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RMnSg6T1fz6J6Zf;
        Fri, 11 Aug 2023 23:16:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 11 Aug
 2023 16:20:23 +0100
Date:   Fri, 11 Aug 2023 16:20:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Phil Elwell <phil@raspberrypi.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: BMP180 (no) interrupt problem
Message-ID: <20230811162022.00002e20@Huawei.com>
In-Reply-To: <CAMEGJJ3aiKUtTsHzVgbVEfiRUL+VV1zfc9-FoCRTjfWp4-=5ug@mail.gmail.com>
References: <CAMEGJJ3aiKUtTsHzVgbVEfiRUL+VV1zfc9-FoCRTjfWp4-=5ug@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Aug 2023 10:08:00 +0100
Phil Elwell <phil@raspberrypi.com> wrote:

> Hi Jonathan and linux-iio,
> 
> I've run into a problem running a BMP180 over I2C - it's on a
> Raspberry Pi, but I don't think that's particularly relevant. As it's
> a BMP180 it has no interrupt signal, but it apparently shares an ID
> with the BMP085 which does. As a result, the driver and bindings
> sensibly treat the IRQ as optional.
> 
> The function bmp280_common_probe contains the following fragment:
> 
> /*
> * Attempt to grab an optional EOC IRQ - only the BMP085 has this
> * however as it happens, the BMP085 shares the chip ID of BMP180
> * so we look for an IRQ if we have that.
> */
> if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
>     ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
>     if (ret)
>         return ret;
> }
> 
> where the irq is passed in from the I2C or SPI framework. Inside
> bmp085_fetch_eoc_irq it immediately does:
> 
>     irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
> 
> irq_get_irq_data converts irq to an irqd, returning either a pointer
> to the irq_data or a NULL. irq_get_trigger_type essentially just
> indirects through the pointer to retrieve the irq_common_data pointer.
> 
> There is nothing to prevent irq from being 0, and in the case of a
> BMP180 that is the expected value. This is where it gets strange: on
> an ARCH=arm build I'm getting a valid-looking irq_data pointer back
> for IRQ 0, but on ARCH=arm64 I get the more obvious NULL pointer,
> leading to an exception.
> 
> I'm hesitant to suggest there's a bug in such old code, but I don't
> understand why the condition in the probe function isn't:
> 
>     if (irq > 0 && (chip_id  == BMP180_CHIP_ID))

Agreed. That was my thought as well when I read the comment you quote
above.  Worst that happens is we don't provide an optional interrupt,
so this is a fairly safe fix even if the intent was something different.

Mind you, it's also odd if someone provides an irq to a BMP180.

Jonathan

> 
> Do you have any thoughts?
> 
> Many thanks,
> 
> Phil Elwell

