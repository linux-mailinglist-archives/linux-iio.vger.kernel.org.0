Return-Path: <linux-iio+bounces-18849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F001AA1003
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C05F3A6467
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657CD21CA1F;
	Tue, 29 Apr 2025 15:07:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74121ABD3
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939241; cv=none; b=n8XJPbMCSxk30UlnU8O3m/U98WlZSpheHzg738zeCr4PK5bJnvyDOiLDAhdS+eCwdFVRsU+Ru6UNfYqyGJlvPvlkNt9Mls2/03q5xHk7z66DiHGbJf4Qc9LW0y8W0rv1d7qcKQTudTkQ3b5uTO4up3LEeYv+PLJAM+QpuUiqeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939241; c=relaxed/simple;
	bh=xqyya+f/kX/1H9jaWUVWJJ3ZcX3s+CpXXP5uGAruSnc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+FrRPip/wizxhB91HNzvy29LDbjPOzDQZev+t5lo0A2yFTrjLuJTMkqp4yCyEG6x9hlp2V6raOh0m8jyukWv2hgbSQm3yUdHucgcGe8L5lyIU7dKzHAsUFV+b1dI4D7s0RJ7svoZdJYePeV1pPnwfBuv2tgWI8n0x+CiTGgRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zn3TT2vNKz6M4Y1;
	Tue, 29 Apr 2025 23:02:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B6FD140447;
	Tue, 29 Apr 2025 23:07:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Apr
 2025 17:07:11 +0200
Date: Tue, 29 Apr 2025 16:07:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mikhael Abdallah de Oliveira Pinto <mikhael_abdallah@usp.br>
CC: <jic23@kernel.org>, Augusto Bernarde <augustomb@usp.br>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: proximity: sx9500: Deduplicate buffer managing
 functions
Message-ID: <20250429160710.00004a1b@huawei.com>
In-Reply-To: <20250429093923.347370-1-mikhael_abdallah@usp.br>
References: <20250429093923.347370-1-mikhael_abdallah@usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Apr 2025 06:39:23 -0300
Mikhael Abdallah de Oliveira Pinto <mikhael_abdallah@usp.br> wrote:

> Refactor to share logic between buffer enable/disable handlers.
> 
> Signed-off-by: Mikhael Abdallah de Oliveira Pinto <mikhael_abdallah@usp.br>
> Co-developed-by: Augusto Bernarde <augustomb@usp.br>
> Signed-off-by: Augusto Bernarde <augustomb@usp.br>
> ---
>  drivers/iio/proximity/sx9500.c | 50 ++++++++++++++++------------------

In my view this isn't a significant enough reduction to justify the more complex code.
Particularly in the error paths.

Jonathan


>  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index c4e94d0fb163..75459c85116b 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -674,52 +674,48 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -static int sx9500_buffer_postenable(struct iio_dev *indio_dev)
> +static int sx9500_buffer_manage_chan_users(struct iio_dev *indio_dev, bool enable_channels)
>  {
>  	struct sx9500_data *data = iio_priv(indio_dev);
>  	int ret = 0, i;
>  
>  	mutex_lock(&data->mutex);
>  
> -	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
> +	for (i = 0; i < SX9500_NUM_CHANNELS; i++) {
>  		if (test_bit(i, indio_dev->active_scan_mask)) {
> -			ret = sx9500_inc_chan_users(data, i);
> +			if (enable_channels)
> +				ret = sx9500_inc_chan_users(data, i);
> +			else
> +				ret = sx9500_dec_chan_users(data, i);
>  			if (ret)
>  				break;
>  		}
> +	}
>  
> -	if (ret)
> -		for (i = i - 1; i >= 0; i--)
> -			if (test_bit(i, indio_dev->active_scan_mask))
> -				sx9500_dec_chan_users(data, i);
> +	if (ret) {
> +		for (i = i - 1; i >= 0; i--) {
> +			if (test_bit(i, indio_dev->active_scan_mask)) {
> +				if (enable_channels)
> +					sx9500_dec_chan_users(data, i);
> +				else
> +					sx9500_inc_chan_users(data, i);
> +			}
> +		}
> +	}
>  
>  	mutex_unlock(&data->mutex);
>  
>  	return ret;
>  }
>  
> -static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
> +static int sx9500_buffer_postenable(struct iio_dev *indio_dev)
>  {
> -	struct sx9500_data *data = iio_priv(indio_dev);
> -	int ret = 0, i;
> -
> -	mutex_lock(&data->mutex);
> -
> -	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
> -		if (test_bit(i, indio_dev->active_scan_mask)) {
> -			ret = sx9500_dec_chan_users(data, i);
> -			if (ret)
> -				break;
> -		}
> -
> -	if (ret)
> -		for (i = i - 1; i >= 0; i--)
> -			if (test_bit(i, indio_dev->active_scan_mask))
> -				sx9500_inc_chan_users(data, i);
> -
> -	mutex_unlock(&data->mutex);
> +	return sx9500_buffer_manage_chan_users(indio_dev, true);
> +}
>  
> -	return ret;
> +static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	return sx9500_buffer_manage_chan_users(indio_dev, false);
>  }
>  
>  static const struct iio_buffer_setup_ops sx9500_buffer_setup_ops = {


