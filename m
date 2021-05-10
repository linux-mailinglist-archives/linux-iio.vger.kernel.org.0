Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A05B379674
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 19:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhEJRwR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 13:52:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3057 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbhEJRwQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 13:52:16 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff7k155mbz6rnT8;
        Tue, 11 May 2021 01:45:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 19:51:10 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 18:51:09 +0100
Date:   Mon, 10 May 2021 18:49:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <alexandru.tachici@analog.com>,
        <linux@deviqon.com>
Subject: Re: [PATCH 00/11] ad_sigma_delta: convert all drivers to
 device-managed
Message-ID: <20210510184927.00000e6d@Huawei.com>
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 May 2021 15:55:12 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> Well, for lack of a better title that's what this series does.
> It merges Jonathan's patches from:
>   * https://lore.kernel.org/linux-iio/20210508182319.488551-1-jic23@kernel.org/
>     Patch 3/3 was a polished a bit with my comments from that review and also
>     to use the devm_ad_sd_setup_buffer_and_trigger() function.
>   * https://lore.kernel.org/linux-iio/20210509114118.660422-1-jic23@kernel.org/
>     Added only to base the conversion to devm_
> 
> The AD Sigma Delta family of ADC drivers share a lot of the logic in the
> ad_sigma_delta lib-driver.
> 
> This set introduces a devm_ad_sd_setup_buffer_and_trigger() call, which
> aims to replace the 'ad_sd_{setup,cleanup}_buffer_and_trigger()' pair.
> 
> This helps with converting the AD7780, AD7791, AD7793 and AD7192
> drivers use be fully converted to device-managed functions.

Almost perfect code wise (just the one bug that predates this series I think).

Couple of notes on series from process point of view.

1) Fixes at the front. Makes for uglier series but nicer backporting.
2) Sign-off on everything - even the ones from me that you didn't change. From DCO
   point of view you handled them (passed them back to me ;) so need your
   sign off.  I have occasionally wondered if I should sign off again when this
   happens :)

If you don't do a v2, just reply to say you are fine with me fixing the sign offs
and I can do it whilst applying.

Thanks,

Jonathan

> 
> Alexandru Ardelean (7):
>   iio: adc: ad_sigma_delta: introduct
>     devm_ad_sd_setup_buffer_and_trigger()
>   iio: adc: ad7793: convert to device-managed functions
>   iio: adc: ad7791: convert to device-managed functions
>   iio: adc: ad7780: convert to device-managed functions
>   iio: adc: ad7192: use devm_clk_get_optional() for mclk
>   iio: adc: ad7192: convert to device-managed functions
>   iio: adc: ad_sigma_delta: remove
>     ad_sd_{setup,cleanup}_buffer_and_trigger()
> 
> Jonathan Cameron (4):
>   iio: adc: ad7192: Avoid disabling a clock that was never enabled.
>   iio: adc: ad7124: Fix missbalanced regulator enable / disable on
>     error.
>   iio: adc: ad7124: Fix potential overflow due to non sequential channel
>     numbers
>   iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop
>     remove()
> 
>  drivers/iio/adc/ad7124.c               | 84 ++++++++++--------------
>  drivers/iio/adc/ad7192.c               | 90 +++++++++++---------------
>  drivers/iio/adc/ad7780.c               | 38 +++--------
>  drivers/iio/adc/ad7791.c               | 44 ++++---------
>  drivers/iio/adc/ad7793.c               | 53 +++++----------
>  drivers/iio/adc/ad_sigma_delta.c       | 82 ++++++++---------------
>  include/linux/iio/adc/ad_sigma_delta.h |  4 +-
>  7 files changed, 141 insertions(+), 254 deletions(-)
> 

