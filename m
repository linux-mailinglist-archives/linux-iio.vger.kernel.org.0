Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F42189743
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 09:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCRIcW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 04:32:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37664 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbgCRIcV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 04:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584520340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z79lHSDt0noyr40g8ID42S9HyUErCw79rl+KttIKyYI=;
        b=jK4WaIscRq/arW9G6TJeiTYgTLTPiyETG0EHfm1wvXjXqo1lt2fkLMcJEaoRckfzDcJL4R
        P5rddVaDhmDrIBzd3USISyf+IMWi483L9vyeNGfbWysUV+yKAqndehUa/InRb+8FsyDW7k
        u9r5culGn2lNp3/o5JfbL7Q6i3OvwPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-G_93vxqiN8eWaDwSbmwjbA-1; Wed, 18 Mar 2020 04:32:18 -0400
X-MC-Unique: G_93vxqiN8eWaDwSbmwjbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 566D21857BE4;
        Wed, 18 Mar 2020 08:32:16 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7F857E301;
        Wed, 18 Mar 2020 08:32:11 +0000 (UTC)
Date:   Wed, 18 Mar 2020 09:31:58 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: iio: adc: ad7192:
 Reformat lines crossing 80 columns
Message-ID: <20200318093158.192a27ce@elisabeth>
In-Reply-To: <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
        <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Mar 2020 09:56:59 +0530
Deepak R Varma <mh12gx2825@gmail.com> wrote:

> Macro arguments are computed at the time of macro invocation. This makes
> the lines cross 80 column width. Add variables to perform the
> calculations before hand and use these new variable in the macro calls
> instead.
> 
> Also re-indent enum members to address checkpatch warning / check messages.
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
>  };
>  
>  struct ad7192_state {
> @@ -477,17 +477,18 @@ static ssize_t ad7192_set(struct device *dev,
>  }
>  
>  static void ad7192_get_available_filter_freq(struct ad7192_state *st,
> -						    int *freq)
> +					     int *freq)
>  {
>  	unsigned int fadc;
> +	unsigned int sync3_filter, sync4_filter;
>  
>  	/* Formulas for filter at page 25 of the datasheet */
> -	fadc = DIV_ROUND_CLOSEST(st->fclk,
> -				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
> +	sync4_filter = AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode);

Have you read page 25 of the datasheet? Why is this called
sync4_filter, with a 'y'?

-- 
Stefano

