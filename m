Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F2B434533
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 08:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTGgB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 02:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhJTGgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Oct 2021 02:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62F3A6113D;
        Wed, 20 Oct 2021 06:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634711626;
        bh=TqEhTY9SGdNuwM4vGWlDt8DbKph99TsAe7fkBvXA1v8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQ4yiaqktnvykMG8rwXM4txdGFqJ58FzWeiGvWIefvkH/Sa8C1LnsKH2F95KExfbh
         bX0AFufQ5W14LHINEOs9heeG2x9JOdVieNoMLsc2Dwxim8Ep0EMTz3BYzbV/JX3KN4
         gbFq6qb4A2+2Cf8KV1XuvWx8nvwnmMlT1HSlp9VQ=
Date:   Wed, 20 Oct 2021 08:33:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sesankm <sesank.mallikarjuna@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        sesankm <26676400+sesankm@users.noreply.github.com>
Subject: Re: [PATCH] Staging: iio: adc: ad7280a: fixed coding style
Message-ID: <YW+4SPoI9HZZg8x2@kroah.com>
References: <20211020061027.34148-1-26676400+sesankm@users.noreply.github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020061027.34148-1-26676400+sesankm@users.noreply.github.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 20, 2021 at 01:10:27AM -0500, sesankm wrote:
> fixed issue with coding style
> 
> Signed-off-by: sesankm <26676400+sesankm@users.noreply.github.com>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index fef0055b8990..473f95118214 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -829,14 +829,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>   * The function argument is stringified and doesn't need a fix
>   */
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -			     in_voltage-voltage_thresh_low_value,
> +			     in_voltage - voltage_thresh_low_value,
>  			     0644,
>  			     ad7280_read_channel_config,
>  			     ad7280_write_channel_config,
>  			     AD7280A_CELL_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> -			     in_voltage-voltage_thresh_high_value,
> +			     in_voltage - voltage_thresh_high_value,
>  			     0644,
>  			     ad7280_read_channel_config,
>  			     ad7280_write_channel_config,
> -- 
> 2.33.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch breaks the build.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
