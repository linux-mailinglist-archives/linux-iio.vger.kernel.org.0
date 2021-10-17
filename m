Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FC6430860
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245527AbhJQLfr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 07:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245494AbhJQLfq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:35:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7370560F56;
        Sun, 17 Oct 2021 11:33:35 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:37:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: Fix uninitialized variable ret
Message-ID: <20211017123749.5e6c3bde@jic23-huawei>
In-Reply-To: <20211015153254.33783-1-colin.king@canonical.com>
References: <20211015153254.33783-1-colin.king@canonical.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Oct 2021 16:32:54 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> When !iio_buffer_space_available(rb) is true and signal_pending(current)
> is false the end of the do-while loop is reached and the uninitialized
> variable ret is zero checked. Fix this by initializing variable ret to
> zero.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: ffabbffd40f2 ("iio: Add output buffer support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks like the correct fix to me. If anyone disagrees shout soon!

Applied to the iio-togreg branch of iio.git and pushed out as testing for 0-day
to poke at it.

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b884d78657cb..c97fb8462395 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -179,7 +179,7 @@ static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
>  	struct iio_buffer *rb = ib->buffer;
>  	struct iio_dev *indio_dev = ib->indio_dev;
>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> -	int ret;
> +	int ret = 0;
>  	size_t written;
>  
>  	if (!indio_dev->info)

