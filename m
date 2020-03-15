Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B12185BC7
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 10:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgCOJ6i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 05:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgCOJ6i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 05:58:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C59B206EB;
        Sun, 15 Mar 2020 09:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584266318;
        bh=LXoOgaIkPVI3f8PQb+rlf/V4OSSV9ouSZtcI704916c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jJzTYNSIscTVRRWqoV+cHWiB0IRYcq13AzygnFyUgZNmCBHwkoAbe3VwDvawdS4t1
         k3mHhY31IVFzLy/8lXftxXOrYIwU3br61AlOG5MiOLdDbXq4zuBWz8mvP68efXtOJb
         xmwFjNfQTEwnO8nYAG2MNzWPGWrjzp2/7NgAoqsI=
Date:   Sun, 15 Mar 2020 09:58:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-iio@vger.kernel.org, Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 2/2] iio: tsl2772: Use scnprintf() for avoiding
 potential buffer overflow
Message-ID: <20200315095834.76f50454@archlinux>
In-Reply-To: <20200311074325.7922-3-tiwai@suse.de>
References: <20200311074325.7922-1-tiwai@suse.de>
        <20200311074325.7922-3-tiwai@suse.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Mar 2020 08:43:25 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

This one is printing a short well defined list of values.  No way they go
anywhere near the smallest possible PAGE_SIZE buffer that it's printing
into.

Which is handy given the remaining space isn't adjusted as we add items
to the string.  Hence even with scnprintf it would overflow.

Brian, can you take a look at this when you get a moment?

Thanks,

Jonathan

> ---
>  drivers/iio/light/tsl2772.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index be37fcbd4654..44a0b56a558c 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -986,7 +986,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
>  	int offset = 0;
>  
>  	while (i < TSL2772_MAX_LUX_TABLE_SIZE) {
> -		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,",
> +		offset += scnprintf(buf + offset, PAGE_SIZE, "%u,%u,",
>  			chip->tsl2772_device_lux[i].ch0,
>  			chip->tsl2772_device_lux[i].ch1);
>  		if (chip->tsl2772_device_lux[i].ch0 == 0) {
> @@ -1000,7 +1000,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
>  		i++;
>  	}
>  
> -	offset += snprintf(buf + offset, PAGE_SIZE, "\n");
> +	offset += scnprintf(buf + offset, PAGE_SIZE, "\n");
>  	return offset;
>  }
>  

