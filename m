Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF224471B80
	for <lists+linux-iio@lfdr.de>; Sun, 12 Dec 2021 17:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhLLQOr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Dec 2021 11:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhLLQOq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Dec 2021 11:14:46 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902CBC061714
        for <linux-iio@vger.kernel.org>; Sun, 12 Dec 2021 08:14:46 -0800 (PST)
Received: from [81.101.6.87] (port=48018 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mwRUm-00089K-SC; Sun, 12 Dec 2021 16:14:45 +0000
Date:   Sun, 12 Dec 2021 16:19:58 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 00/12] IIO: More of to generic fw conversions.
Message-ID: <20211212161935.49d2414c@jic23-huawei>
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 Dec 2021 17:01:28 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> v3: Thanks to Andy Shevchenko for review + added tags.
> 
> patch 1: Moved the dev_fwnode() check into the ad5755_parse_fw() function
> which simplifies the handling where it is calls. Also added blank line.
> patch 8: Dropped the struct device pointer being passed to mcp3911_config()
> as it is available as adc->spi->dev.
> patch 9: drop the of_match_pttr()
> patch 12: Clarify that the OF dependencies being removed in this patch
> were never needed for these drivers.
> 
> v2: Drop platform data from ad5755 as suggested by Lars.
>     Collect tags.
> 
> I'm being naughty because I have a busy week ahead and not sure
> when I'll get back to this series.  So whilst I'd normally say leave
> a series for other reviews for at least a few days here they are, one
> day later :)
> 
> Nothing particularly special about this series, just a few
> more drifvers converted and related header and Kconfig
> dependency cleanups.
> 
> For now I'm focussing mostly on standalone parts rather than
> those integrated in SoCs.
> 
> Any feedback welcome.
Series applied to the togreg branch of iio.git.

I'll add a follow up to patch 1 as per discussion with Andy to my
todo list if no one else gets to it.

Thanks,

Jonathan

> 
> 
> 
> Jonathan Cameron (12):
>   iio:dac:ad5755: Switch to generic firmware properties and drop pdata
>   iio:dac:ad5758: Drop unused of specific headers.
>   iio:dac:dpot-dac: Swap of.h for mod_devicetable.h
>   iio:dac:lpc18xx_dac: Swap from of* to mod_devicetable.h
>   iio:pot:mcp41010: Switch to generic firmware properties.
>   iio:light:cm3605: Switch to generic firmware properties.
>   iio:adc:max9611: Switch to generic firmware properties.
>   iio:adc:mcp3911: Switch to generic firmware properties.
>   iio:adc:ti-adc12138: Switch to generic firmware properties and drop
>     of_match_ptr
>   iio:adc:envelope-detector: Switch from of headers to mod_devicetable.h
>   iio:adc:ti-ads124s08: Drop dependency on OF.
>   iio:adc/dac:Kconfig: Update to drop OF dependencies.
> 
>  drivers/iio/adc/Kconfig              |   6 +-
>  drivers/iio/adc/envelope-detector.c  |   3 +-
>  drivers/iio/adc/max9611.c            |  20 ++--
>  drivers/iio/adc/mcp3911.c            |   9 +-
>  drivers/iio/adc/ti-adc12138.c        |  11 +-
>  drivers/iio/adc/ti-ads124s08.c       |   3 +-
>  drivers/iio/dac/Kconfig              |   1 -
>  drivers/iio/dac/ad5755.c             | 152 ++++++++++++++++++++-------
>  drivers/iio/dac/ad5758.c             |   3 +-
>  drivers/iio/dac/dpot-dac.c           |   2 +-
>  drivers/iio/dac/lpc18xx_dac.c        |   3 +-
>  drivers/iio/light/cm3605.c           |   6 +-
>  drivers/iio/potentiometer/mcp41010.c |   6 +-
>  include/linux/platform_data/ad5755.h | 102 ------------------
>  14 files changed, 149 insertions(+), 178 deletions(-)
>  delete mode 100644 include/linux/platform_data/ad5755.h
> 

