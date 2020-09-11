Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9931D265B46
	for <lists+linux-iio@lfdr.de>; Fri, 11 Sep 2020 10:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgIKIPp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Sep 2020 04:15:45 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2807 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbgIKIPp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Sep 2020 04:15:45 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 318BCCFEBCCD1D074D5B;
        Fri, 11 Sep 2020 09:15:43 +0100 (IST)
Received: from localhost (10.52.125.200) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Fri, 11 Sep
 2020 09:15:42 +0100
Date:   Fri, 11 Sep 2020 09:14:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nishant Malpani <nish.malpani25@gmail.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] iio: gyro: adxrs290: Add triggered buffer
 & debugfs support
Message-ID: <20200911091407.000057e7@Huawei.com>
In-Reply-To: <20200910180450.29696-1-nish.malpani25@gmail.com>
References: <20200910180450.29696-1-nish.malpani25@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.200]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 23:34:47 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Introduce DATA_RDY trigger for triggered buffer setup; this enables continuous
> data capture. Additionally, add support for direct register access using the debugfs 
> iio interface. 
> 
> The device-tree bindings documentation illustrates an example of using a GPIO irq
> line to trigger a data capture.
> 
> Nishant Malpani (3):
>   iio: gyro: adxrs290: Add triggered buffer support
>   dt-bindings: iio: gyro: adxrs290: Add interrupts support
>   iio: gyro: adxrs290: Add debugfs register access support
> 
>  .../bindings/iio/gyroscope/adi,adxrs290.yaml  |   6 +
>  drivers/iio/gyro/Kconfig                      |   2 +
>  drivers/iio/gyro/adxrs290.c                   | 237 ++++++++++++++++--
>  3 files changed, 231 insertions(+), 14 deletions(-)
> 

Odd. The original patch one eventually made it (I'd checked it hadn't
gotten to me or to lore.kernel.org yesterday :(

Ah well, one of those quirks of life and resend does no harm.

Will catch up with this tomorrow probably.

Jonathan

