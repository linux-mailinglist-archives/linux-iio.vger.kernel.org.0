Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55492320BBC
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBUQcI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:32:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhBUQcI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 11:32:08 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5874C60241;
        Sun, 21 Feb 2021 16:31:25 +0000 (UTC)
Date:   Sun, 21 Feb 2021 16:31:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC PATCH 9/9] iio: inkern: Drop io-channel-ranges dt property
 support
Message-ID: <20210221163121.102e3edf@archlinux>
In-Reply-To: <20201115192951.1073632-10-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
        <20201115192951.1073632-10-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Nov 2020 19:29:51 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This property has been almost exclusively missused in mainline and
> we don't actually have any instances of it being necessary.
> 
> As such Rob Herring suggested we just drop it and I can't immediately
> see any reason to disagree.
> 
> If anyone has an out of tree dts file that makes use of this then let
> me know.  I'm not against keeping the code, but documenting it as a
> deprecated property not to be used in new dts files.
> 
> Note build tested only. If someone could give it a sanity check
> on a platform that uses this interface that would be great.
> If not I'll mock something up before applying this.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Hi all,

I plan to apply this given no one has mentioned using it in out of tree
dts files.  If someone has time to sanity check I didn't actually mess
up the patch below that would be great!

Thanks,

Jonathan

> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/inkern.c | 49 +++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index ede99e0d5371..85a6f6103ee9 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -184,40 +184,25 @@ static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
>  						      const char *name)
>  {
>  	struct iio_channel *chan = NULL;
> -
> -	/* Walk up the tree of devices looking for a matching iio channel */
> -	while (np) {
> -		int index = 0;
> -
> -		/*
> -		 * For named iio channels, first look up the name in the
> -		 * "io-channel-names" property.  If it cannot be found, the
> -		 * index will be an error code, and of_iio_channel_get()
> -		 * will fail.
> -		 */
> -		if (name)
> -			index = of_property_match_string(np, "io-channel-names",
> +	int index = 0;
> +
> +	/*
> +	 * For named iio channels, first look up the name in the
> +	 * "io-channel-names" property.  If it cannot be found, the
> +	 * index will be an error code, and of_iio_channel_get()
> +	 * will fail.
> +	 */
> +	if (name)
> +		index = of_property_match_string(np, "io-channel-names",
>  							 name);
> -		chan = of_iio_channel_get(np, index);
> -		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
> -			break;
> -		else if (name && index >= 0) {
> -			pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> -				np, name ? name : "", index);
> -			return NULL;
> -		}
> +	chan = of_iio_channel_get(np, index);
> +	if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
> +		return chan;
> +	else if (name && index >= 0)
> +		pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> +		       np, name ? name : "", index);
>  
> -		/*
> -		 * No matching IIO channel found on this node.
> -		 * If the parent node has a "io-channel-ranges" property,
> -		 * then we can try one of its channels.
> -		 */
> -		np = np->parent;
> -		if (np && !of_get_property(np, "io-channel-ranges", NULL))
> -			return NULL;
> -	}
> -
> -	return chan;
> +	return NULL;
>  }
>  
>  static struct iio_channel *of_iio_channel_get_all(struct device *dev)

