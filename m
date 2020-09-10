Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA380264BC4
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgIJRsn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:48:43 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2805 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbgIJRsH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:48:07 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6A65C7EC37958B00689B;
        Thu, 10 Sep 2020 18:47:55 +0100 (IST)
Received: from localhost (10.52.121.43) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 10 Sep
 2020 18:47:55 +0100
Date:   Thu, 10 Sep 2020 18:46:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nishant Malpani <nish.malpani25@gmail.com>
CC:     <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 0/3] iio: gyro: adxrs290: Add triggered buffer &
 debugfs support
Message-ID: <20200910184618.00001b86@Huawei.com>
In-Reply-To: <20200910123000.16860-1-nish.malpani25@gmail.com>
References: <20200910123000.16860-1-nish.malpani25@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.43]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 17:59:57 +0530
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

Hi Nishant,

Something odd went on with this version.  It's not come across threaded
and patch 1 is missing.  Please resend.

Thanks,

Jonathan

