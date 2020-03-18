Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5876B18A886
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 23:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCRWp1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 18:45:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58913 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726776AbgCRWp1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 18:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584571526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6z7HylxLPrJpHhQIeQIueH85+08lJiwZcM5DyPzkLl0=;
        b=dBVwH9rB59BZFWaHgEE/0ngcxfzWhjrstCNVljCNBZPftHkk4XIoVKh/OpdpJijR0Cbl5z
        6tbOJMfKtSywRqN5jJm2F7lneqORVumFFd9nAk+Vfp8L3PActGF8PSjY8DvE+OrHvPZW61
        iK91/WfKfXURei4VjP3WaqMT66A3NDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-SnMl5GA3OPidNGs0AGmG-A-1; Wed, 18 Mar 2020 18:45:22 -0400
X-MC-Unique: SnMl5GA3OPidNGs0AGmG-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A99A800D4E;
        Wed, 18 Mar 2020 22:45:21 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD2D61001938;
        Wed, 18 Mar 2020 22:45:16 +0000 (UTC)
Date:   Wed, 18 Mar 2020 23:45:10 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 3/3] staging: iio: adc: ad7192:
 Reformat lines crossing 80 columns
Message-ID: <20200318234510.28b08a0d@elisabeth>
In-Reply-To: <89282ed6f355553eb1e81ae9b5f991eae4cd96ba.1584557481.git.mh12gx2825@gmail.com>
References: <cover.1584557481.git.mh12gx2825@gmail.com>
        <89282ed6f355553eb1e81ae9b5f991eae4cd96ba.1584557481.git.mh12gx2825@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Mar 2020 00:40:02 +0530
Deepak R Varma <mh12gx2825@gmail.com> wrote:

> Macro arguments are computed at the time of calling the macro. This
> makes the lines cross 80 column width. Add variables to perform the
> calculations before hand and use these variable in the macro calls instead.
> 
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7192.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index a5b6cc1fc375..2a9c68aa8260 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -480,14 +480,15 @@ static void ad7192_get_available_filter_freq(struct ad7192_state *st,
>  						    int *freq)
>  {
>  	unsigned int fadc;
> +	unsigned int sinc3_filter, sinc4_filter;
>  
>  	/* Formulas for filter at page 25 of the datasheet */
> -	fadc = DIV_ROUND_CLOSEST(st->fclk,
> -				 AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode));
> +	sinc4_filter = AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode);
> +	fadc = DIV_ROUND_CLOSEST(st->fclk, sinc4_filter);

The name sinc4_filter is at least not derived from another typo anymore,
but it still doesn't make sense to me. Is it a filtering... factor,
as the name would suggest? No. It comes from a "mode" register and it
becomes a divisor of the output data rate.

Besides, you don't need separate variables (why two, even?). As I
already mentioned to you offline, DIV_ROUND_CLOSEST() is used. If '/'
is the DIV_ROUND_CLOSEST() operation, then, I guess:

	a = b / (x * y) <=> a = b / x / y

-- 
Stefano

