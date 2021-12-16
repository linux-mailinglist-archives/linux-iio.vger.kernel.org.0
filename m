Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C8F477663
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 16:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhLPPyE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 10:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhLPPyE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 10:54:04 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30C1C061574;
        Thu, 16 Dec 2021 07:54:03 -0800 (PST)
Received: from [81.101.6.87] (port=48030 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxt4r-0003CW-P1; Thu, 16 Dec 2021 15:53:58 +0000
Date:   Thu, 16 Dec 2021 15:59:18 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: add IIO_MOD_REFERENCE modifier
Message-ID: <20211216155905.1fac607c@jic23-huawei>
In-Reply-To: <20211213024057.3824985-2-gwendal@chromium.org>
References: <20211213024057.3824985-1-gwendal@chromium.org>
        <20211213024057.3824985-2-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Dec 2021 18:40:54 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add modifier IIO_MOD_REFERENCE for reporting sx9360 reference
> proximity measurement.
> All modifier must be defined for libiio to recognize
> |in_proximity_reference| as a channel.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Hmm. So the question is whether this is a valid modifier.

I'm not totally convinced, because I can see we might well
get stacking cases say

iio_concentration_o2_reference

However we do have precedence with 'ambient' which applies
to temperature sensors.

The alternative here would be to have it as a normal indexed
channel but with a label saying it is the reference.

Would that work for this case?  If I were doing the ambient
case again I'd use label for that as well, but label is a more
recent addition to the ABI.

> ---
> New in v3.
> 
>  drivers/iio/industrialio-core.c | 1 +
>  include/uapi/linux/iio/types.h  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 20d5178ca0739a..2b272f54de8ae9 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -134,6 +134,7 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_ETHANOL] = "ethanol",
>  	[IIO_MOD_H2] = "h2",
>  	[IIO_MOD_O2] = "o2",
> +	[IIO_MOD_REFERENCE] = "reference",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 48c13147c0a870..aa83a9b578502a 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -95,6 +95,7 @@ enum iio_modifier {
>  	IIO_MOD_ETHANOL,
>  	IIO_MOD_H2,
>  	IIO_MOD_O2,
> +	IIO_MOD_REFERENCE,
>  };
>  
>  enum iio_event_type {

