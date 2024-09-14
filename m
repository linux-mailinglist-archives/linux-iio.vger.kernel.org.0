Return-Path: <linux-iio+bounces-9569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4898A97919E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F16C284582
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467161D0167;
	Sat, 14 Sep 2024 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSnvvWhK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2531CE6E9;
	Sat, 14 Sep 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726325500; cv=none; b=qx+Y3J1ZaGYxlcAN8F5nKo4Ql7EoRKgvg7c5N9cX0Qj/GR4Vxf9ulxxOVkR6Fu5BP2qaVNKysNSxrheE73xI7WK2QOmoeOWbUk9i2aQhqk2OeQtN9RJUj8z13O/6+YKG/blxy4x6QWYGh+nLEZ09WiaBjZzcHvaAtd1F5cDFhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726325500; c=relaxed/simple;
	bh=mFhu7DLeiP0inPX7LRw4dG6RsHNLyjH6HXWdUV07AwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdGCLznnyrE3TMEDO9Soc6s9hx4INQt+jmpl/7/mTs17SNySVyYo1iRmqizSzNn+E8EC45lAkCfiVsA3xsjaVfDw2k4S3EosMoyWRQnsetELfFox8W8xXFlB9GGkXgg7XQyh2db6SRoSLu+NmTqQ/ulPzAuTha9oP32u1MMOK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSnvvWhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0728C4CEC0;
	Sat, 14 Sep 2024 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726325499;
	bh=mFhu7DLeiP0inPX7LRw4dG6RsHNLyjH6HXWdUV07AwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SSnvvWhK7EzibuVZEBceZdAQ1Tsktpj7sm+KM3XOnufQvJz8L7FBlSYlU+WTECU1M
	 Eu+RaYpumtlcGVoSXXRYIo3qIxHbxszJPJ7YACEQof5zVtEgZuwK76kQ5spFZpfMvH
	 eDVkqpiDcDcWNzY05h0OrlJu8ZbedF+l9n93qp0SWq+ciKTlFeQa54eSvBIh9ALOG/
	 3JBG4wlZvkSuHWB37uHWSPy5LaMZTaKb7uz1TQdM+xIQldhpJDm8n9OF8YXhH0V/8E
	 nc8Y3VMskiPnp1VsoBIQPbf6F5B5v61cuwpmiVUNG536L/aliflevRd8OB6CdOR75q
	 cdkP8lL2iFuJQ==
Date: Sat, 14 Sep 2024 15:51:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: light: veml6030: fix IIO device retrieval from
 embedded device
Message-ID: <20240914155130.2a3d0368@jic23-huawei>
In-Reply-To: <20240913-veml6035-v1-3-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
	<20240913-veml6035-v1-3-0b09c0c90418@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 15:18:58 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The dev pointer that is received as an argument in the
> in_illuminance_period_available_show function references the device
> embedded in the IIO device, not in the i2c client.
> 
> dev_to_iio_dev() must be used to accessthe right data. The current
> implementation leads to a segmentation fault on every attempt to read
> the attribute because indio_dev gets a NULL assignment.
> 
> This bug has been present since the first appearance of the driver,
> apparently since the last version (V6) before getting applied. A
> constant attribute was used until then, and the last modifications might
> have not been tested again.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,
Jonathan

> ---
>  drivers/iio/light/veml6030.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 2e86d310952e..df2ba3078b91 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -99,9 +99,8 @@ static const char * const period_values[] = {
>  static ssize_t in_illuminance_period_available_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> +	struct veml6030_data *data = iio_priv(dev_to_iio_dev(dev));
>  	int ret, reg, x;
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -	struct veml6030_data *data = iio_priv(indio_dev);
>  
>  	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
>  	if (ret) {
> 


