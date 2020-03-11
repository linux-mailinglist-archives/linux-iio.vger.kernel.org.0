Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96811181912
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 14:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgCKNEL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 09:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgCKNEL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Mar 2020 09:04:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 079BF2146E;
        Wed, 11 Mar 2020 13:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583931850;
        bh=QFRhILCiCGG3avV6Jc+u/kxAhX4OE+gglVu9ganNukg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vVbsQazdpgVdbHiRjB68WWjcED+r87OGu8CapyVosLm0EakwV9gmvVAoZEgbWxL+q
         h7cbYnay7viQNx1BmaO5z4GgPXEBhr0/D3VMiJUG5Zc931sZNpXQU0twEFq7Oxe6E3
         lT75IqkhoTHScL7rRDwXPHR9ruTFE1DmbrUCgyD0=
Date:   Wed, 11 Mar 2020 14:04:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Enrique Vargas <jevargas@seas.upenn.edu>
Cc:     Chas Williams <3chas3@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] remove unnecessary newline for brace
Message-ID: <20200311130407.GA3823904@kroah.com>
References: <20200311125222.GA9239@evX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311125222.GA9239@evX1>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 11, 2020 at 06:52:22AM -0600, Enrique Vargas wrote:
> put brace at the end of line following coding conventions
> 
> Signed-off-by: Enrique Vargas <jevargas@seas.upenn.edu>
> ---
>  drivers/atm/adummy.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/atm/adummy.c b/drivers/atm/adummy.c
> index 8157925af824..6eeaa1b21f3b 100644
> --- a/drivers/atm/adummy.c
> +++ b/drivers/atm/adummy.c
> @@ -131,8 +131,7 @@ adummy_proc_read(struct atm_dev *dev, loff_t *pos, char *page)
>  	return 0;
>  }
>  
> -static const struct atmdev_ops adummy_ops =
> -{
> +static const struct atmdev_ops adummy_ops = {
>  	.open =		adummy_open,
>  	.close =	adummy_close,	
>  	.send =		adummy_send,
> -- 
> 2.17.1
> 

$ ./scripts/get_maintainer.pl --file drivers/atm/adummy.c
Chas Williams <3chas3@gmail.com> (maintainer:ATM)
linux-atm-general@lists.sourceforge.net (moderated list:ATM)
netdev@vger.kernel.org (open list:ATM)
linux-kernel@vger.kernel.org (open list)

