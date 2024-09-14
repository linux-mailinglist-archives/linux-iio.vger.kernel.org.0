Return-Path: <linux-iio+bounces-9552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D03C97911F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F7C282871
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C2A13A88D;
	Sat, 14 Sep 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYkyj2vP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66871482F3;
	Sat, 14 Sep 2024 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321621; cv=none; b=ix+fbPmPXVonLi9SM1fz6h1kKlqZ01OaY5IJSeCIt6xGwBzQMC+0VBkh/gTok1MXxwno5hM0+Tztgy2ctEjvQ3ZhPX0Kij5KDI9rj+pmo/iLBEksqP6EmXnEPYzOugz1SRoLyqO0/CAG0YZ5Xek8H9rVOh8x/CM40JPvALF1pL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321621; c=relaxed/simple;
	bh=JlaTXOVECQQ9y1PotkfF87dKSJP2/jZWokoKjc9Uuz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aphZX15kR14tgdYXWGRo+VILBqEGAndTTUX6BYWRGrkjA70TLzLJrRsAhAfesOHOP7cRyKQjBMFIMY+msBpo6SzWC6B+Wa2mklYxwfMtJzhCfemMrAd7tqvYY5KpcXBx6aYat8WL0cmbmkNG7EIG6ALjKJCC+9OGZSHJtmX9u70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYkyj2vP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598EAC4CEC0;
	Sat, 14 Sep 2024 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726321620;
	bh=JlaTXOVECQQ9y1PotkfF87dKSJP2/jZWokoKjc9Uuz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QYkyj2vPUOBk2prvjwM3TwuZa2n1FSZrXfRNKRRQZdxByMrOCnIx0O3ZfLlPpUOh7
	 Vm6wc40uAp1ka1Psi4UqzQcBrLlcCpodkA8YFmzTrKCtb4wtwGh3leYdDOTZv24rHt
	 p1K9BfM9X96umnWy7xL1ytL5rdCSOsYnxLn7ytMrj/XisXDLX8XeS3mlVLbZ7kpx95
	 aguLTLpXeg9I3lImS8eFcvB8GXa6aYGUOQlfGCs4K1ND8Q4+GeM7Zno25Y1hVXo2iP
	 fyxM9he5XKtsfnphsOVPVomsU+Yakx4V9lIvxu5h2D9SWcDXx8AspKpNyBno3PC4zI
	 S6x8ZD8QwvPnw==
Date: Sat, 14 Sep 2024 14:46:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: light: ltr390: Suspend and Resume support
Message-ID: <20240914144653.3839bab3@jic23-huawei>
In-Reply-To: <20240910045030.266946-3-abhashkumarjha123@gmail.com>
References: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
	<20240910045030.266946-3-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 10:20:27 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Added support for suspend and resume PM ops.
> We suspend the sensor by clearing the ALS_UVS_EN bit in the MAIN CONTROL
> register. And we resume it by setting that bit.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
> ---
>  drivers/iio/light/ltr390.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 73ef4a5a0..c4ff26d68 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -432,6 +432,24 @@ static int ltr390_probe(struct i2c_client *client)
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> +static int ltr390_suspend(struct device *dev)
> +{
> +	struct ltr390_data *data = iio_priv(i2c_get_clientdata(
> +						to_i2c_client(dev)));
That's somewhat ugly.  I'd jsut have another local variable.
Can also use the access directly from the dev, not via the i2c_client
(it's the same data either way and common practice to get it directly from
dev).

	struct iio_dev *indio_dev = dev_get_drvdata(dev);

> +
> +	return regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);

Lines is a little long: wrap after CTRL,

> +}
> +
> +static int ltr390_resume(struct device *dev)
> +{
> +	struct ltr390_data *data = iio_priv(i2c_get_clientdata(
> +						to_i2c_client(dev)));
As above.
> +
> +	return regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(ltr390_pm_ops, ltr390_suspend, ltr390_resume);
> +
>  static const struct i2c_device_id ltr390_id[] = {
>  	{ "ltr390" },
>  	{ /* Sentinel */ }
> @@ -448,6 +466,7 @@ static struct i2c_driver ltr390_driver = {
>  	.driver = {
>  		.name = "ltr390",
>  		.of_match_table = ltr390_of_table,
> +		.pm	= pm_sleep_ptr(&ltr390_pm_ops),
>  	},
>  	.probe = ltr390_probe,
>  	.id_table = ltr390_id,


