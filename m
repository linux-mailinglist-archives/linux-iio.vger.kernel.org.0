Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3040B382D46
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 15:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhEQNWY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 09:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234106AbhEQNWY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 09:22:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AFC661059;
        Mon, 17 May 2021 13:21:06 +0000 (UTC)
Date:   Mon, 17 May 2021 14:22:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: Remove redundant assignment to in_loc
Message-ID: <20210517142221.60680f3f@jic23-huawei>
In-Reply-To: <1621246317-62725-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1621246317-62725-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 May 2021 18:11:57 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Variable in_loc is being assigned a value from a calculation
> however the assignment is never read, so this redundant assignment
> can be removed.
> 
> Clean up the following clang-analyzer warning:
> 
> drivers/iio/industrialio-buffer.c:929:3: warning: Value stored to
> 'in_loc' is never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 10923b4..fdd6234 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -926,7 +926,6 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>  		if (ret)
>  			goto error_clear_mux_table;
>  		out_loc += length;
> -		in_loc += length;
>  	}
>  	buffer->demux_bounce = kzalloc(out_loc, GFP_KERNEL);
>  	if (buffer->demux_bounce == NULL) {

