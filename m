Return-Path: <linux-iio+bounces-1792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46B3835694
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7BA1C21075
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC71437705;
	Sun, 21 Jan 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh7PvQ48"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78614F7F
	for <linux-iio@vger.kernel.org>; Sun, 21 Jan 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705853736; cv=none; b=ROli6LAleiirCrRs+NOAqSmO3+L3g2wzEYMXxpDQ7y1makqzuqb0k4IhlZ1vscAHzE4PyArWsu7bKtHqUCpcgqFjzsWkczK8w0ArMWrWjcmac9S7MzdbBGQLz8DnLZQTJY7os7H8OGk/pUTIQFPfsQAS9VGeHhR+BUiV/ota/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705853736; c=relaxed/simple;
	bh=04TxS7FUUhFBEp7E+n6kVvAVh5f7GSiNnRRQ/z+B/qI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOLu4N1XTkBBgIgrDpwcPO6ZpWxCg6dZD9DCeCMG60Kq3M05C2Q+1jKz0cx2+J/bWp7Eh/GPJLrjKe606nOUptgade9gOc57ZcgromdwiJjVGxZpRSlplhwbocGZ+lZ8e7c3hpNgcKN2N7YCRsTKBb94JfMYgGvzsEaw/kOZVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh7PvQ48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EFBC433F1;
	Sun, 21 Jan 2024 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705853735;
	bh=04TxS7FUUhFBEp7E+n6kVvAVh5f7GSiNnRRQ/z+B/qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gh7PvQ48+yo4A3Ch7QrgvQIo7to4ZeYH05LyF/KNofbPYBH6ZtxbqJBb5JvvjYeXV
	 WcFvRFCbTbljVTfpU6A0op+TmRDdfuuospMX/FeJ7nqfjkwie3a4KdPHSzDbPJFFpx
	 DPKVtWAE3RenXdn1BbTOclSPHDBGq8clxaAdcQ4xa1M+PWg+jQ2ftA5qAY5PWAWz7m
	 0rGuOeiAc1NHwJH5jNIJ1w7is7F7TbjjW+msXktRxolPlrtkO2SD8RIS0fs75LiYKJ
	 +rPdPoAnNXbHx6MAvD0LoaQ3j3THWEaOOmjbtN32++JpyJYhYnlNP4MpSHN+uLBu+4
	 iMVsvTHYeEhHQ==
Date: Sun, 21 Jan 2024 16:15:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] iio: imu: adis16480: make use of
 irq_get_trigger_type()
Message-ID: <20240121161523.629f5e78@jic23-huawei>
In-Reply-To: <20240117-adis-improv-v1-3-7f90e9fad200@analog.com>
References: <20240117-adis-improv-v1-0-7f90e9fad200@analog.com>
	<20240117-adis-improv-v1-3-7f90e9fad200@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 14:10:51 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> There's no need to call both irq_get_irq_data() and
> irqd_get_trigger_type() as we already have an helper for that. This
> allows for code simplification.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied 2 and 3 to the togreg branch of iio.git and pushed out as testing until
I can rebase it on rc1.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index fe520194a837..b40a55bba30c 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -1246,18 +1246,11 @@ static int adis16480_config_irq_pin(struct adis16480 *st)
>  {
>  	struct device *dev = &st->adis.spi->dev;
>  	struct fwnode_handle *fwnode = dev_fwnode(dev);
> -	struct irq_data *desc;
>  	enum adis16480_int_pin pin;
>  	unsigned int irq_type;
>  	uint16_t val;
>  	int i, irq = 0;
>  
> -	desc = irq_get_irq_data(st->adis.spi->irq);
> -	if (!desc) {
> -		dev_err(dev, "Could not find IRQ %d\n", irq);
> -		return -EINVAL;
> -	}
> -
>  	/* Disable data ready since the default after reset is on */
>  	val = ADIS16480_DRDY_EN(0);
>  
> @@ -1285,7 +1278,7 @@ static int adis16480_config_irq_pin(struct adis16480 *st)
>  	 * configured as positive or negative, corresponding to
>  	 * IRQ_TYPE_EDGE_RISING or IRQ_TYPE_EDGE_FALLING respectively.
>  	 */
> -	irq_type = irqd_get_trigger_type(desc);
> +	irq_type = irq_get_trigger_type(st->adis.spi->irq);
>  	if (irq_type == IRQ_TYPE_EDGE_RISING) { /* Default */
>  		val |= ADIS16480_DRDY_POL(1);
>  	} else if (irq_type == IRQ_TYPE_EDGE_FALLING) {
> 


