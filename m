Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1461818DD
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 13:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgCKM44 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 08:56:56 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35254 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729232AbgCKM44 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Mar 2020 08:56:56 -0400
X-IronPort-AV: E=Sophos;i="5.70,540,1574118000"; 
   d="scan'208";a="439836582"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 13:56:54 +0100
Date:   Wed, 11 Mar 2020 13:56:54 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Enrique Vargas <jevargas@seas.upenn.edu>
cc:     Chas Williams <3chas3@gmail.com>, linux-iio@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] remove unnecessary newline for
 brace
In-Reply-To: <20200311125507.GA9347@evX1>
Message-ID: <alpine.DEB.2.21.2003111355390.2999@hadrien>
References: <20200311125507.GA9347@evX1>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The subject line should give information about what part of the kernel is
being changed.  See other patches or the tutorial for examples.

On Wed, 11 Mar 2020, Enrique Vargas wrote:

> put brace at the end of line following coding conventions
>
> Signed-off-by: Enrique Vargas <jevargas@seas.upenn.edu>
> ---
>  drivers/atm/adummy.c | 3 +--

Is there a reason why you are working on drivers/atm?  Normally for the
application period you should only do cleanups on drivers/staging.

julia


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
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20200311125507.GA9347%40evX1.
>
