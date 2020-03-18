Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A055918957B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 07:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCRGAH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 02:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgCRGAH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Mar 2020 02:00:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6142820663;
        Wed, 18 Mar 2020 06:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584511206;
        bh=LiiC0hJRBqCby/UhdJHICZhXIqqhTkN7s3GPqfZIqgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=stAnY+Cs1wUIw0on4u4WWcgBEcrn19jZyu11TFasGSR6zeZWRsPTbZytON+f+8bsg
         pZ+TnhvpOcxxVxVX/XcakqTJBU1Xd6MeHma/koZ6UO9wwhKLMJlNopNavB8T8JdsBs
         H6kKZpOheMBNlC+VOOlo5R68W9QpnjtV6hkZQxl4=
Date:   Wed, 18 Mar 2020 07:00:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, daniel.baluta@gmail.com,
        kieran.bingham@ideasonboard.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: Reformat lines crossing
 80 columns
Message-ID: <20200318060004.GA1594471@kroah.com>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 09:56:59AM +0530, Deepak R Varma wrote:
> Macro arguments are computed at the time of macro invocation. This makes
> the lines cross 80 column width. Add variables to perform the
> calculations before hand and use these new variable in the macro calls
> instead.
> 
> Also re-indent enum members to address checkpatch warning / check messages.

When you say "also" in a changelog description, that's a huge hint the
patch needs to be broken up.

And that is what needs to happen here.

> 
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7192.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index bf3e2a9cc07f..0265f6607d75 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -156,8 +156,8 @@
>   */
>  
>  enum {
> -   AD7192_SYSCALIB_ZERO_SCALE,
> -   AD7192_SYSCALIB_FULL_SCALE,
> +	AD7192_SYSCALIB_ZERO_SCALE,
> +	AD7192_SYSCALIB_FULL_SCALE,

Because this has nothing to do with the subject, please make it a
separate patch.

thanks,

greg k-h
