Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C547B190
	for <lists+linux-iio@lfdr.de>; Mon, 20 Dec 2021 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhLTQp4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Dec 2021 11:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbhLTQpz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Dec 2021 11:45:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D8BC061574
        for <linux-iio@vger.kernel.org>; Mon, 20 Dec 2021 08:45:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B6BBB80F96
        for <linux-iio@vger.kernel.org>; Mon, 20 Dec 2021 16:45:54 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 564C0C36AE2;
        Mon, 20 Dec 2021 16:45:51 +0000 (UTC)
Date:   Mon, 20 Dec 2021 16:51:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH] iio:addac:ad74413r: Fix uninitialized ret in a path
 that won't be hit.
Message-ID: <20211220165114.7e7af8b9@jic23-huawei>
In-Reply-To: <20211220164726.3136307-1-jic23@kernel.org>
References: <20211220164726.3136307-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Dec 2021 16:47:26 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

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
Given this is 'hopefully' entirely safe and I'd like to get a pull
request out later in the week I'm going to apply this immediately.

Note I'd have just fixed it up in the original patch normally but for
some reason didn't see the warning until the tree was in a non rebasing
state + we have some other fixes in there for this driver.

Applied to the togreg branch of iio.git.  Pushed out directly rather than
normal testing.  I'll sneak a rebase in if anyone gives me a tag
before I apply much on top of it.

Thanks,

Jonathan

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
>  
>  	mutex_lock(&st->lock);
>  

