Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12D718334D
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 15:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgCLOie (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 10:38:34 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:20035
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbgCLOie (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 10:38:34 -0400
X-IronPort-AV: E=Sophos;i="5.70,545,1574118000"; 
   d="scan'208";a="342154099"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 15:38:32 +0100
Date:   Thu, 12 Mar 2020 15:38:31 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Enrique Vargas <jevargas@seas.upenn.edu>
cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] Staging: iio: adc: align multi-line
 function argument with open parenthesis
In-Reply-To: <20200312142721.GA2748@evX1>
Message-ID: <alpine.DEB.2.21.2003121536280.2418@hadrien>
References: <20200312142721.GA2748@evX1>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Thu, 12 Mar 2020, Enrique Vargas wrote:

> Eliminate WARNING found with checkpatch.pl for argument split in two
> lines not matching coding conventions identation.

The message seems a bit obscure.  There is no argument that is split in
two lines, although it is the case that the argument list is split in two
lines.

For the subject line, maybe "reduce parameter indentation"

And then for the log message:

"Align function parameter with the right side of the open parenthesis
starting the parameter list, to follow kernel coding style.  Problem found
using checkpatch."

julia


>
> Signed-off-by: Enrique Vargas <jevargas@seas.upenn.edu>
> ---
>  drivers/staging/iio/adc/ad7192.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 51b1cd3ad1de..5f65d084e320 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -477,7 +477,7 @@ static ssize_t ad7192_set(struct device *dev,
>  }
>
>  static void ad7192_get_available_filter_freq(struct ad7192_state *st,
> -						    int *freq)
> +					     int *freq)
>  {
>  	unsigned int fadc;
>
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20200312142721.GA2748%40evX1.
>
