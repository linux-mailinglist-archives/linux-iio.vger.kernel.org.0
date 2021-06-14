Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C463A5CA3
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 07:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhFNF7Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 01:59:25 -0400
Received: from first.geanix.com ([116.203.34.67]:48554 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhFNF7Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 01:59:25 -0400
Received: from skn-laptop (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id D69214C243E;
        Mon, 14 Jun 2021 05:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1623650240; bh=GVQ17txVyp1XatiX0bVNk3xO9ZBTR3YXqbKfy3qnRsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QrocGVzWP4hfrBxb6L5EQGRuHcZY5vOtSP9uDfen2MMTfYwFZKSweObycY0FSsWHF
         AWloTDbusg36kPYhgjpg7qlVJCacaXCYkJypHOYb/6gT1MEiEUglgEolCgWkQwRQNB
         OKKdgNU4yrZd6f2Ttim/hbd5jHjnqTE+7DRRQFVe8IiLTr5wPULe14USwkpISEkk0t
         VaT+NFlq/cIWbTYNWlwzyGvF6cPbos7jhCxFrBbC0y/SWD2EEKSHNIpkJD9NrqUMfh
         p3tSNnopEhIjAqOyJvwJToPTuQGjZDmEgejkmiaknMZp/W3PdULyad+l6ltj0E+AHa
         B1h4KwcefEYig==
Date:   Mon, 14 Jun 2021 07:57:19 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/12] iio:accel:fxls8962af: Add a few missing includes.
Message-ID: <20210614055719.iee2wyhlt4awbyxr@skn-laptop>
References: <20210611171355.202903-1-jic23@kernel.org>
 <20210611171355.202903-7-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210611171355.202903-7-jic23@kernel.org>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 06:13:48PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Based on consideration of the output of the include-what-you-use tool.
> Note that in this driver the main reason to do this is to ensure
> consistency across IIO.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean@geanix.com>

Reviewed-by: Sean Nyekjaer <sean@geanix.com>

> ---
>  drivers/iio/accel/fxls8962af-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 078d87865fde..6882f082d581 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -15,16 +15,17 @@
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_irq.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/regmap.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
> -#include <linux/iio/sysfs.h>
>  
>  #include "fxls8962af.h"
>  
> -- 
> 2.31.1
> 
