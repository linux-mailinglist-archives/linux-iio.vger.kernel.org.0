Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9635F64180C
	for <lists+linux-iio@lfdr.de>; Sat,  3 Dec 2022 18:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLCRVd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Dec 2022 12:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLCRVc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Dec 2022 12:21:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E566408
        for <linux-iio@vger.kernel.org>; Sat,  3 Dec 2022 09:21:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35645B8070E
        for <linux-iio@vger.kernel.org>; Sat,  3 Dec 2022 17:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DD2C433D6;
        Sat,  3 Dec 2022 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670088088;
        bh=DTJtKCWsX9tUKBNpEU8s7JKCYV67y4lhCPWQKWMp+eY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rH1AUU1M49KCbP9azNsk5RBvYsDo4Z3udDSRLd8C8MmWkMvKWyjKSqcww9Y4O8xxC
         SdlPi9ZtGtxXXy7u/0n8Wnvx9sJfoF2W9jggtz0Bij7MFXpha5rE1XmfGn5Ab0pEbD
         JF7K5lqL7nx1yQFuXmVPnu9Zy1qa7NnKvOjdgRNUZjcGP5vzvEFXj6XuNWXgZh2n4E
         Fw/c85p4ug18UJr7mUxFGNIlgmGU1bJjRAexcTAQTqGxCagobD51Ah45K8Cdq+xXPX
         uPX+TeAsmY754gjXs2+uqY91NPoma4j8WBUPKxsvYGW7zd4sFyvF+/l3UGHa7GUYOn
         4mopC8zX7xKIw==
Date:   Sat, 3 Dec 2022 17:34:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: atlas-ezo-sensor: refactor
 IIO_CHAN_INFO_SCALE checks
Message-ID: <20221203173413.356b6f89@jic23-huawei>
In-Reply-To: <20221202222305.8828-1-matt.ranostay@konsulko.com>
References: <20221202222305.8828-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  2 Dec 2022 14:23:05 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Additional modifiers in IIO_CHAN_INFO_SCALE check will mostly have a ppm
> unit and the switch statement is more confusing, and adds unneeded code.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Hi Matt,

Is this a precursor to more support where it doesn't just make sense to match on
the modifier, but rather have a default path?

Also, can we avoid the oddity of this code being reached by the fact
that only one case in the switch statement above doesn't return.
The code would be more readable to just do this stuff in 
case IIO_CONCENTRATION: 
and have slightly long lines.

> ---
>  drivers/iio/chemical/atlas-ezo-sensor.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> index 307c3488f4bd..5fae1c4087ee 100644
> --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> @@ -165,17 +165,19 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  
> -		/* IIO_CONCENTRATION modifiers */
> -		switch (chan->channel2) {
> -		case IIO_MOD_CO2:
> -			*val = 0;
> -			*val2 = 100; /* 0.0001 */
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		case IIO_MOD_O2:
> +		if (chan->channel2 == IIO_NO_MOD)
> +			return -EINVAL;

This relies rather more on what values we actually have than the original
code.  Given we can't get to this code at all unless we have
a modifier (only applies to concentration channels which always do)
there isn't a lot of point in this check.

A sanity check on what we do have as a modifier and return -EINVAL
if none match would be better.

> +
> +		// IIO_CONCENTRATION modifier for percent
/* ... */
style preferred for IIO comments.

> +		if (chan->channel2 == IIO_MOD_O2) {
>  			*val = 100;
>  			return IIO_VAL_INT;
>  		}
> -		return -EINVAL;
> +
> +		// IIO_CONCENTRATION modifier for PPM - 0.0001
> +		*val = 0;
> +		*val2 = 100;
> +		return IIO_VAL_INT_PLUS_MICRO;
So this matches the IIO_MOD_
>  	}
>  
>  	return 0;

