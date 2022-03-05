Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B9E4CE5AF
	for <lists+linux-iio@lfdr.de>; Sat,  5 Mar 2022 17:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiCEQAw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Mar 2022 11:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCEQAv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2022 11:00:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A4140C2;
        Sat,  5 Mar 2022 08:00:01 -0800 (PST)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K9qDG6LY7z67p52;
        Sat,  5 Mar 2022 23:59:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Mar 2022 16:59:59 +0100
Received: from localhost (10.47.66.18) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 15:59:58 +0000
Date:   Sat, 5 Mar 2022 15:59:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Support LIS302DL in st_accel
Message-ID: <20220305155955.000075eb@Huawei.com>
In-Reply-To: <20220301225432.60844-1-absicsz@gmail.com>
References: <20220301225432.60844-1-absicsz@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.66.18]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Mar 2022 00:54:29 +0200
"Sicelo A. Mhlongo" <absicsz@gmail.com> wrote:

> Hi,
> 
> The ST Microelectronics LIS302DL is currently only supported in the
> evdev framework driver in drivers/misc/lis3lv02d. This series enables
> support for it in the iio framework.
> 
Other the the issues Andy raised around the tag and also
adding SPI support this looks good to me. 

We are very late in this cycle, so it is now material for 5.19.
Plenty of time to make those final little tidy ups and get this
queued early in the next cycle.

Thanks,

Jonathan

> Regards,
> Sicelo
> 
> 
> Sicelo A. Mhlongo (3):
>   dt-bindings: iio: st,st-sensors add LIS302DL
>   iio: accel: Remove unused enum in st_accel
>   iio: accel: add support for LIS302DL variant
> 
>  .../bindings/iio/st,st-sensors.yaml           |  1 +
>  drivers/iio/accel/st_accel.h                  | 26 +------------------
>  drivers/iio/accel/st_accel_core.c             |  1 +
>  drivers/iio/accel/st_accel_i2c.c              |  5 ++++
>  4 files changed, 8 insertions(+), 25 deletions(-)
> 

