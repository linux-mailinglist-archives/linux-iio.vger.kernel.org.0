Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5B1185BA1
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 10:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgCOJqJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 05:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgCOJqJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 05:46:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCDE2205C9;
        Sun, 15 Mar 2020 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584265568;
        bh=biUlpyrXNvCOiK31I4zc/E3yxuZCzo2qiuxd+IZSWAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NqUIdla21Wyb2/wkO+hupZvA3i4r2MrUH5+52i5fAChTQMy5pbR+ZmWjlZPW2fclo
         YHcOxaC9G7ydMGE4FSk1lv5B7YQ2DkVJ9USKze+M//+CZ58eKDNbbBuFAjy8pXXBkC
         FniQ9c3DkmfrcdF0OnVZRqFOP8sv/L83wN56mv6E=
Date:   Sun, 15 Mar 2020 09:46:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        matt.ranostay@konsulko.com
Subject: Re: [PATCH] iio: health: max30100: remove mlock usage
Message-ID: <20200315094604.62dc96be@archlinux>
In-Reply-To: <5e668b89.1c69fb81.d7e4f.0f61@mx.google.com>
References: <5e668b89.1c69fb81.d7e4f.0f61@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Mar 2020 00:01:28 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> Use local lock instead of indio_dev's mlock.
> The mlock was being used to protect local driver state thus using the
> local lock is a better option here.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>

Matt.  Definitely need your input on this.

> ---
>  drivers/iio/health/max30100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> index 84010501762d..8ddc4649547d 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -388,7 +388,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
>  		 * Temperature reading can only be acquired while engine
>  		 * is running
>  		 */
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&data->lock);

Hmm.. It's another complex one.  What is actually being protected here is
the buffer state, but not to take it exclusively like claim_direct does.

Here we need the inverse, we want to ensure we are 'not' in the direct
mode because this hardware requires the buffer to be running to read the
temperature. 

That is the sort of interface that is going to get userspace very 
confused.

Matt, normally what I'd suggest here is that the temperature read should:

1) Claim direct mode, if it fails then do the dance you have here
(with more comments to explain why you are taking an internal lock)
2) Start up capture as if we were in buffered mode
3) Grab that temp
4) stop capture to return to non buffered mode.
5) Release direct mode.

I guess we decided it wasn't worth the hassle.  

So Rohit.  This one probably needs a comment rather than any change.
We 'could' add a 'hold_buffered_mode' function that takes the mlock,
verifies we are in buffered mode and continues to hold the lock 
until the 'release_buffered_mode'.  However, I'm not sure any other
drivers do this particular dance, so clear commenting in the driver
might be enough.   Should we ever change how mlock is used in the
core, we'd have to fix this driver up as well.

Hmm.  This is really hammering home that perhaps all the remaining
mlock cases are 'hard'.

Thanks,

Jonathan

>  
>  		if (!iio_buffer_enabled(indio_dev))
>  			ret = -EAGAIN;
> @@ -399,7 +399,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
>  
>  		}
>  
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&data->lock);
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 1;  /* 0.0625 */

