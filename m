Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE647C0B1
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 14:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhLUNUm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Dec 2021 08:20:42 -0500
Received: from out0.migadu.com ([94.23.1.103]:17122 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234517AbhLUNUl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Dec 2021 08:20:41 -0500
Date:   Tue, 21 Dec 2021 21:20:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640092838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twaNG892K9y8e8rzCfGiHag1faP2p2akd8FKCMT4vm8=;
        b=Z2K9jyZh76mwG1LPNYvd6x+4KRPLS28SE3DHl5Dn0pqKxbNSb+XryhG22aMYBXzNjYWf0G
        3MiHUlD0L8K7RifWXIPcoi1ps8ou5cIpVGNQjHgrF3y1tnwGT5OswftA/+npE0eOIbKkjT
        OxK7ZN6Vi9TIS2c34L/D5C8heT/3RdA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH] iio:addac:ad74413r: Fix uninitialized ret in a path that
 won't be hit.
Message-ID: <20211221132014.GA27963@chq-T47>
References: <20211220164726.3136307-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211220164726.3136307-1-jic23@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20 12月 21 16:47:26, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I don't believe it's possible to hit this, because we drop
> out of __iio_update_buffers() earlier in the event of an empty
> list.  However, that is not visible to the compiler so lets
> return an error if we do hit the loop with an empty bitmask.
> 
> Fixes: 5d97d9e9a703 ("iio: addac: ad74413r: fix off by one in ad74413r_parse_channel_config()")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  drivers/iio/addac/ad74413r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 289d254943e1..5271073bb74e 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -843,7 +843,7 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
>  	u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 * AD74413R_FRAME_SIZE];
>  	u8 *tx_buf = st->adc_samples_tx_buf;
>  	unsigned int channel;
> -	int ret;
> +	int ret = -EINVAL;
Reviewed-by: Cai Huoqing <cai.huoqing@linux.dev>
>  
>  	mutex_lock(&st->lock);
>  
> -- 
> 2.34.1
> 
