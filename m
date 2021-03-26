Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B595A34A67A
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhCZLbh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 07:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCZLbX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 07:31:23 -0400
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Mar 2021 04:31:23 PDT
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7EDC0613AA
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 04:31:23 -0700 (PDT)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id F07319E004A;
        Fri, 26 Mar 2021 11:31:20 +0000 (GMT)
Date:   Fri, 26 Mar 2021 11:31:25 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Swen Kalski <kalski.swen@gmail.com>
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] Add early return to Method because the else can be
 ignored.
Message-ID: <20210326113125.4b3e68ed@jic23-huawei>
In-Reply-To: <20210324122050.GA28987@kernel-dev>
References: <20210324122050.GA28987@kernel-dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Mar 2021 13:20:50 +0100
Swen Kalski <kalski.swen@gmail.com> wrote:

IIO isn't the right list for comedi related patches.
Take a look at MAINTAINERS

However it is marked odd fixes only so I'm not sure on how receptive
they will be to tidying up like this.

+ all the stuff in Greg's 'bot' response :)

Jonathan



> ---
>  drivers/staging/comedi/comedi_buf.c | 56 ++++++++++++++---------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi_buf.c b/drivers/staging/comedi/comedi_buf.c
> index 3ef3ddabf139..05927fb321ba 100644
> --- a/drivers/staging/comedi/comedi_buf.c
> +++ b/drivers/staging/comedi/comedi_buf.c
> @@ -366,42 +366,42 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
>  				     unsigned int num_bytes)
>  {
>  	struct comedi_async *async = s->async;
> -	unsigned int count = 0;
>  	const unsigned int num_sample_bytes = comedi_bytes_per_sample(s);
> +	unsigned int count = 0;
>  
>  	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA)) {
>  		async->munge_count += num_bytes;
> -		count = num_bytes;
> -	} else {
> -		/* don't munge partial samples */
> -		num_bytes -= num_bytes % num_sample_bytes;
> -		while (count < num_bytes) {
> -			int block_size = num_bytes - count;
> -			unsigned int buf_end;
> +		return num_bytes;
> +	}
>  
> -			buf_end = async->prealloc_bufsz - async->munge_ptr;
> -			if (block_size > buf_end)
> -				block_size = buf_end;
> +	/* don't munge partial samples */
> +	num_bytes -= num_bytes % num_sample_bytes;
> +	while (count < num_bytes) {
> +		int block_size = num_bytes - count;
> +		unsigned int buf_end;
>  
> -			s->munge(s->device, s,
> -				 async->prealloc_buf + async->munge_ptr,
> -				 block_size, async->munge_chan);
> +		buf_end = async->prealloc_bufsz - async->munge_ptr;
> +		if (block_size > buf_end)
> +			block_size = buf_end;
>  
> -			/*
> -			 * ensure data is munged in buffer before the
> -			 * async buffer munge_count is incremented
> -			 */
> -			smp_wmb();
> -
> -			async->munge_chan += block_size / num_sample_bytes;
> -			async->munge_chan %= async->cmd.chanlist_len;
> -			async->munge_count += block_size;
> -			async->munge_ptr += block_size;
> -			async->munge_ptr %= async->prealloc_bufsz;
> -			count += block_size;
> -		}
> -	}
> +		s->munge(s->device, s,
> +			 async->prealloc_buf + async->munge_ptr,
> +			 block_size, async->munge_chan);
>  
> +		/*
> +		 * ensure data is munged in buffer before the
> +		 * async buffer munge_count is incremented
> +		 */
> +		smp_wmb();
> +
> +		async->munge_chan += block_size / num_sample_bytes;
> +		async->munge_chan %= async->cmd.chanlist_len;
> +		async->munge_count += block_size;
> +		async->munge_ptr += block_size;
> +		async->munge_ptr %= async->prealloc_bufsz;
> +		count += block_size;
> +	}
> +	
>  	return count;
>  }
>  

