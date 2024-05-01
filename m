Return-Path: <linux-iio+bounces-4710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7FC8B8641
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 09:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8581A2820C6
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D6A4D58A;
	Wed,  1 May 2024 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxGT+4QD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4C4AEF0
	for <linux-iio@vger.kernel.org>; Wed,  1 May 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549531; cv=none; b=ZfqkNkDgpFpBM+/E8SEIvh4+vN0gCiOF222s3BAWgjKt7U5J3JcWsMSaR4V0d3zzzyB+5g2BLODseL5tUNxcvxXChnzGMDprFJizKg/QF1O0yjofnC6kznGkbuAch5Nc1do8V4spS7OcVi6u5688sl6mC3F84mGA1TSzI6SUT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549531; c=relaxed/simple;
	bh=DqPG21dC3p9teEwV5kqyUbCAjND7//mFPaOPAD+78Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ii5bKp74zw5fAXYrZfRRlO8q45a2KTPMei1zsBuhMERAN6EwAJeUKpEqPYXxE4n+sLB0Up3epfWoZ0IX9ZGZB6uQtlj50oatKGboGx2ZFyKptlTY8sJzmn88nWHnjmo7iwGF2StsHZ0g37RRzVb+Z2E3IMmWBFLhNPuygcqkjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxGT+4QD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2FEC113CC;
	Wed,  1 May 2024 07:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714549530;
	bh=DqPG21dC3p9teEwV5kqyUbCAjND7//mFPaOPAD+78Eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rxGT+4QDg3pnJ2cLwnUW4d/mRNGZMnbtC900lrZX3OkYQFzrzymurdCeNkycAguXz
	 Q9w1EVHyacu/0RPXmmKAHu745pU6tmP17OmaxSIZbt3biHxro0rfwuqY4UZWK1xPwY
	 0bV0QCtC7uRr3p41kLGGaSq7g9dOy/Vxg2Au0EDxo/QhiPwCkF5a1h8wB9EPlUOLXI
	 iTxnhtar2b9pY545uE2Z0vtnUJma3XSalr+3zMEhSbmAhHzyle0+T7WePMnQ7o31Rg
	 Uii+1tqahXooq9cKM+uyakXxemkOi+NXr1ONxiFuYEqlXx1oglZ3Iu3I+vskHjF6xc
	 VGGNbNz8y0UwQ==
Date: Wed, 1 May 2024 08:45:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lincoln Yuji <lincolnyuji@usp.br>
Cc: Luiza Soezima <lbrsoezima@usp.br>, Sabrina Araujo
 <sabrinaaraujo@usp.br>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ti-ads1015: use
 device_for_each_child_node_scoped()
Message-ID: <20240501084519.7fc7f982@jic23-huawei>
In-Reply-To: <20240429132233.6266-1-lincolnyuji@usp.br>
References: <20240429132233.6266-1-lincolnyuji@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 10:22:33 -0300
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
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Meh. If I take this one I don't need to wait for review on the version
everyone ignored :(

Applied.

> ---
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


