Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C823537D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 18:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHAQqk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgHAQqk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Aug 2020 12:46:40 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3740C06174A
        for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2020 09:46:39 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 089DF9E0058;
        Sat,  1 Aug 2020 17:46:36 +0100 (BST)
Date:   Sat, 1 Aug 2020 17:46:33 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: Re: [PATCH] iio: adc: mcp3422: fix locking scope
Message-ID: <20200801174633.08cee9d1@archlinux>
In-Reply-To: <20200801135511.342869-1-angelo@amarulasolutions.com>
References: <20200801135511.342869-1-angelo@amarulasolutions.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 Aug 2020 15:55:11 +0200
Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:

> Locking should be held for the entire reading sequence involving setting
> the channel, waiting for the channel switch and reading from the
> channel.
> If not, reading from a channel can result mixing with the reading from
> another channel.
> 
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>

Looks like we should be backporting this.  Fixes tag please.

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

