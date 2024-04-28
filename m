Return-Path: <linux-iio+bounces-4564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BD18B4B87
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471F51C209D7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A4F55C22;
	Sun, 28 Apr 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZnD5/HD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838EE573
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714304363; cv=none; b=pHeiKel3J1+n9Rwe6F0mX6Mzl8CH32yBjGeJ6LQpkrWR1relXwdMgbGpwZdJKaCkNq55EUFKDyXO6anuh2NgawyU+J8aVMdUHxBdW5wLywoK5nfaDY2lzMLuxjftw7+CvXXXqF9A5tHaCAA73dCZ+Mkor3aa80DVB1TtDBdMOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714304363; c=relaxed/simple;
	bh=47tUTpddw4PXl4fZTvHxf0pOUWqZgUEwCurY3C3rXmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uY0XuFUnMNzhNJjnxWdfnFJHMifKa3xoCgcYFK11fhckGKJqAElkZrreVkX/LKENC9UtUhOTUbiVboFxVPnSNMTHhzW/Stk1EJ5Hhrh6MW7Dm39sSIEfYuHdVn0tZaS7zjWzfWzEb/K25nek/twzNPSBQgo8SpNsH+ZkjfaAWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZnD5/HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD1BC2BBFC;
	Sun, 28 Apr 2024 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714304362;
	bh=47tUTpddw4PXl4fZTvHxf0pOUWqZgUEwCurY3C3rXmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BZnD5/HD/n0Ahy5lhN5Srb4tXnoRHiBQgyg6RMmtjgu98cpKSNLfTnL1axDjjtoLT
	 MrndMvKu1gNPbE1QAUMv9ts2ifOJyz1zFsFu7GO+P67IFNUcrXSDVkqA55PkvYogzx
	 iTFuJ2q7SMJTTzlrGGqyQF/R+AtzoMwT7nr07vZ6fmS7NFBiANKcbDiFCsvTIY/4mo
	 RSzRDdrt3K2ZkR59KuZgawkS0yPFQTiWETyJ6nVDwRME0LGKLke114BUPwSxEzyFvk
	 FFUsDYntgrQXEm92SJdGm1xkppHkCOfK0eTFqyhoYNBy/L8ev42QbBT2YiVVlW3yTT
	 MZHvcJZDIvbPA==
Date: Sun, 28 Apr 2024 12:39:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lincoln Yuji <lincolnyuji@usp.br>
Cc: Luiza Soezima <lbrsoezima@usp.br>, Sabrina Araujo
 <sabrinaaraujo@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1015: use
 device_for_each_child_node_scoped()
Message-ID: <20240428123911.73f54c08@jic23-huawei>
In-Reply-To: <20240427121055.5639-1-lincolnyuji@usp.br>
References: <20240427121055.5639-1-lincolnyuji@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Apr 2024 09:10:55 -0300
Lincoln Yuji <lincolnyuji@usp.br> wrote:

> This loop definition removes the need for manual releasing of the
> fwnode_handle in early exit paths (here an error path) allow
> simplification of the code and reducing the chance of future
> modifications not releasing fwnode_handle correctly.
> 
> Co-developed-by: Luiza Soezima <lbrsoezima@usp.br>
> Signed-off-by: Luiza Soezima <lbrsoezima@usp.br>
> Co-developed-by: Sabrina Araujo <sabrinaaraujo@usp.br>
> Signed-off-by: Sabrina Araujo <sabrinaaraujo@usp.br>
> Signed-off-by: Lincoln Yuji <lincolnyuji@usp.br>
> ---
I think this is a response to Marcelo's review of v1.
If so, a couple of process things you have gotten wrong.
1) You should pick up tags, assuming you've made the changes
suggested.   So should include
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
in the block above.
2) It should be clearly marked as v2. Pass -v2 to git format
patch is the easiest way to do this, or edit the patch title
so it says something like
[PATCH V2] ...

Otherwise the patch looks fine. 
Please do a v3, correcting the above.

Thanks,

Jonathan

>  drivers/iio/adc/ti-ads1015.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 6ae967e4d..d3363d02f 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -902,10 +902,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct ads1015_data *data = iio_priv(indio_dev);
>  	struct device *dev = &client->dev;
> -	struct fwnode_handle *node;
>  	int i = -1;
>  
> -	device_for_each_child_node(dev, node) {
> +	device_for_each_child_node_scoped(dev, node) {
>  		u32 pval;
>  		unsigned int channel;
>  		unsigned int pga = ADS1015_DEFAULT_PGA;
> @@ -927,7 +926,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
>  			pga = pval;
>  			if (pga > 5) {
>  				dev_err(dev, "invalid gain on %pfw\n", node);
> -				fwnode_handle_put(node);
>  				return -EINVAL;
>  			}
>  		}
> @@ -936,7 +934,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
>  			data_rate = pval;
>  			if (data_rate > 7) {
>  				dev_err(dev, "invalid data_rate on %pfw\n", node);
> -				fwnode_handle_put(node);
>  				return -EINVAL;
>  			}
>  		}


