Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FCE3A1523
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhFINLe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 09:11:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3188 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFINLd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 09:11:33 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0RzP4wZ1z6K5dW;
        Wed,  9 Jun 2021 21:00:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 15:09:37 +0200
Received: from localhost (10.52.124.126) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 14:09:37 +0100
Date:   Wed, 9 Jun 2021 14:09:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 0/4] iio: Drop use of %hhx and %hx format strings
Message-ID: <20210609140934.00002f44@Huawei.com>
In-Reply-To: <20210603180612.3635250-1-jic23@kernel.org>
References: <20210603180612.3635250-1-jic23@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.126]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

Not quite sure how I managed to cc Nathan on the patches, but not the
cover letter.  Anyhow +Cc Nathan.

@Nathan. I dropped the tags you gave to v1 as described below, but
it's not a huge change. Very much appreciated if you could take a quick look.

Input from others also appreciated!

Thanks,

Jonathan


On Thu,  3 Jun 2021 19:06:08 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A wrong use of one of these in
> https://lore.kernel.org/linux-iio/20210514135927.2926482-1-arnd@kernel.org/
> included a reference from Nathan to a patch discouraging the use of
> these strings in general:
> https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
> 
> I did a quick grep and established we only have a few instances of these in
> IIO anyway, so in the interests of avoiding those existing cases getting
> cut and paste into new drivers, let's just clear them out now.
> 
> Note that patch from Arnd is now also part of this series, due to the
> length specifier related issue Joe raised.
> 
> I have chosen to go with 0x%02x rather than %#04x as I find it more readable.
> 
> V2:
> Use 0x%02x (Joe Perches)
> Include Arnd's original patch, modified for the above.
> 
> Arnd Bergmann (1):
>   iio: si1133: fix format string warnings
> 
> Jonathan Cameron (3):
>   iio: light: si1133: Drop remaining uses of %hhx format string.
>   iio: imu: inv_mpu6050: Drop use of %hhx format string.
>   iio: light: si1145: Drop use of %hhx format specifier.
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  5 ++---
>  drivers/iio/light/si1133.c                 | 18 +++++++++---------
>  drivers/iio/light/si1145.c                 | 10 +++++-----
>  3 files changed, 16 insertions(+), 17 deletions(-)
> 

