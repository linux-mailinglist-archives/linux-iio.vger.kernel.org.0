Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F85F173EA6
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2020 18:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgB1RgT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Feb 2020 12:36:19 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2483 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbgB1RgS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Feb 2020 12:36:18 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 71FECD0A9F0577C54A08;
        Fri, 28 Feb 2020 17:36:17 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 28 Feb 2020 17:36:16 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 28 Feb
 2020 17:36:16 +0000
Date:   Fri, 28 Feb 2020 17:36:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
Subject: Re: [PATCH v2] staging: iio: update TODO
Message-ID: <20200228173615.00003c16@Huawei.com>
In-Reply-To: <20200225144933.19876-1-rohitsarkar5398@gmail.com>
References: <20200224195915.GA8371@SARKAR>
        <20200225144933.19876-1-rohitsarkar5398@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 20:19:33 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> since there are no uses of the old GPIO API, remove the item from the
> TODO and some new items.
> 
> Changes from v1:
> Add work item mentioned by Alexandru in https://marc.info/?l=linux-iio&m=158261515624212&w=2

My main issue here is we are adding to the "staging" todo,
a list of tasks that are relevant to all drivers, not those
in staging alone.

Please break this into a simple patch removing the gpio stuff
that is no longer relevant and a second patch to propose additions.
That way I can pick up the uncontroversial part and we can talk
further about whether it makes sense to put system wide TODO entries
in here.

Thanks,

Jonathan

> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> ---
>  drivers/staging/iio/TODO | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
> index 1b8ebf2c1b69..e54510c2ef5f 100644
> --- a/drivers/staging/iio/TODO
> +++ b/drivers/staging/iio/TODO
> @@ -1,11 +1,17 @@
> -2018-04-15
> +2020-02-25
>  
> -All affected drivers:
> -Convert all uses of the old GPIO API from <linux/gpio.h> to the
> -GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
> -lines from device tree, ACPI or board files, board files should
> -use <linux/gpio/machine.h>.
> +- Documentation
> +  - Binding docs for devices that are obviously used via device tree
> +  - Yaml conversions for abandoned drivers
> +  - ABI Documentation
> +  - Audit driviers/iio/staging/Documentation
>  
> +- Replace iio_dev->mlock by either a local lock or use iio_claim_direct.
> +  (Requires analysis of the purpose of the lock.)
> +
> +- Converting drivers from device tree centric to more generic property handlers
> +  Refactor old platform_data constructs from drivers and convert it to state
> +  struct and using property handlers and readers.
>  
>  ADI Drivers:
>  CC the device-drivers-devel@blackfin.uclinux.org mailing list when


