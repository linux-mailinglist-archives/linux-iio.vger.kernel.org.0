Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D40720FE5
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jun 2023 13:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjFCLT6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jun 2023 07:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbjFCLT6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jun 2023 07:19:58 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2582E180
        for <linux-iio@vger.kernel.org>; Sat,  3 Jun 2023 04:19:57 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 90b147f0-0200-11ee-b3cf-005056bd6ce9;
        Sat, 03 Jun 2023 14:19:54 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 14:19:54 +0300
To:     inv.git-commit@tdk.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 3/4] iio: make invensense timestamp module generic
Message-ID: <ZHsh2npPOzPyFuAC@surfacebook>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
 <20230531142513.48507-4-inv.git-commit@tdk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531142513.48507-4-inv.git-commit@tdk.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Wed, May 31, 2023 at 02:25:12PM +0000, inv.git-commit@tdk.com kirjoitti:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Rename common module to inv_sensors_timestamp, add configuration
> at init (chip internal clock, acceptable jitter, ...) and update
> inv_icm42600 driver integration.

...

>  	/* check that period is acceptable */
> -	period_min = INV_ICM42600_TIMESTAMP_MIN_PERIOD(chip_period) * mult;
> -	period_max = INV_ICM42600_TIMESTAMP_MAX_PERIOD(chip_period) * mult;
> +	period_min = ts->min_period * mult;
> +	period_max = ts->max_period * mult;

Side note: wondering if linear_range.h APIs can somehow help with this.

>  	if (period > period_min && period < period_max)
>  		return true;
>  	else
>  		return false;

Another side note: this can be simplified in a follow up at some point.

...

> -	/* if interrupt interval is valid, sync with interrupt timestamp */
> +	/* if interrupt interval is valid, align with interrupt timestamp */

Not sure why this change, but probably it's inline with the rest of the
changes.

...

> --- /dev/null
> +++ b/include/linux/iio/common/inv_sensors_timestamp.h

Have you used -M -C for `git-format-patch`?

...

> +#ifndef INV_SENSORS_TIMESTAMP_H_
> +#define INV_SENSORS_TIMESTAMP_H_

> +#include <linux/kernel.h>

While I see this in the original code, I have found no evidence this header
is used here in any possible way.

Actually kernel.h in the _headers_ is quite discouraged.

> +#endif

-- 
With Best Regards,
Andy Shevchenko


