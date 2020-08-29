Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D95256953
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgH2RVO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgH2RVN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:21:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6BC20714;
        Sat, 29 Aug 2020 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598721673;
        bh=NHbY0w0UR2W4ETrL5nAGEY5PwPI7WBUqpn0LVmJpGs0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uKoLqhVV7eVgBbKuAnl4Njeh58UZmJzWP2y/eNWx8WvNTDEX31EgbqpexnGTXnqEP
         GvRZvQ2z8AyBdnne7vr9JZEsy2skb/uPsCaS0IfLNek8TnfDiyNOPc4mYw01ixiB1h
         6BxvOH8x27agTSZbYrSZBE1wuLtC1KqiMdVLp8GI=
Date:   Sat, 29 Aug 2020 18:21:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     angelo.compagnucci@gmail.com
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: mcp3422: fix locking scope
Message-ID: <20200829182109.59a5ed0a@archlinux>
In-Reply-To: <20200819075525.1395248-1-angelo.compagnucci@gmail.com>
References: <20200819075525.1395248-1-angelo.compagnucci@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Aug 2020 09:55:25 +0200
angelo.compagnucci@gmail.com wrote:

> From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> 
> Locking should be held for the entire reading sequence involving setting
> the channel, waiting for the channel switch and reading from the
> channel.
> If not, reading from a channel can result mixing with the reading from
> another channel.
> 
> Fixes: 07914c84ba30 ("iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC")
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mcp3422.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index d86c0b5d80a3..02a60fb164cd 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -96,16 +96,12 @@ static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
>  {
>  	int ret;
>  
> -	mutex_lock(&adc->lock);
> -
>  	ret = i2c_master_send(adc->i2c, &newconfig, 1);
>  	if (ret > 0) {
>  		adc->config = newconfig;
>  		ret = 0;
>  	}
>  
> -	mutex_unlock(&adc->lock);
> -
>  	return ret;
>  }
>  
> @@ -138,6 +134,8 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
>  	u8 config;
>  	u8 req_channel = channel->channel;
>  
> +	mutex_lock(&adc->lock);
> +
>  	if (req_channel != MCP3422_CHANNEL(adc->config)) {
>  		config = adc->config;
>  		config &= ~MCP3422_CHANNEL_MASK;
> @@ -150,7 +148,11 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
>  		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
>  	}
>  
> -	return mcp3422_read(adc, value, &config);
> +	ret = mcp3422_read(adc, value, &config);
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
>  }
>  
>  static int mcp3422_read_raw(struct iio_dev *iio,

