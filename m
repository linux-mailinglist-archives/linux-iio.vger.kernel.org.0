Return-Path: <linux-iio+bounces-9829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0614898901A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B6FB20E21
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C76C2261D;
	Sat, 28 Sep 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZof2b5T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763F1B299;
	Sat, 28 Sep 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727537800; cv=none; b=sx4NNHe3ra+kFz1p0D82hqfUdmC1gp/qHmAiuLF9k9nN/4cZdhkmXz8927qXv7VgOwALtqQhQBBOIC9mbFQTgAU0EgHs8p2nw2w4QYScKAyhCqZIbUtvNFD+r39jmRTKD5LyUOxAMsZv4gR+ll/g1gG9TFQRFRenVvqyfkrX2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727537800; c=relaxed/simple;
	bh=Ru/ELRIfllqCBraFIMscj6mlLudwcl3rFTYcSY28sW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q59g1MpOhZk/7iGbcSDhvK44BBpKJw4HSCBoBfnW8j3z1Uc/X8SV0EMV9/OfND6VihCW0N+D75fy5BI4evAtGFXl1raZxKFDgjeDofIPHj1OQ9bpcL6deqL8NKrICGleL+KmS+eZDHJ4sAgwb2O8I5ithy0zj/dLtKq+0KPX/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZof2b5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698F5C4CEC3;
	Sat, 28 Sep 2024 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727537799;
	bh=Ru/ELRIfllqCBraFIMscj6mlLudwcl3rFTYcSY28sW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QZof2b5TbYYZMx3ao/w/J0aSKQDGQzeVPTFEIPa+h/eegbYkuLQx0wFfwK/pXEsci
	 Ix7xMwz6cn8Kx02Wpzx5Q4NzPXJjkjmdA18x5RsOkGmeVPWiJLp7HOHuXvcNK1G1Ec
	 DbatnGJWrczc21B/CMG3LmsBWKFclHAg1bmJRjE1hhU69fWXZNvdcm4mFP81DgdZ7r
	 bRbuioq0jEsSLPhjUQSeXosa7U1YhIrSj5tu1BsdZ+k8pRXn8FqVjJ/F2OOYPHwZpv
	 cmC87Cy1s2GXOe0mlvpp7I0xqzsA7LSPSezuaUrvBgR8mmpvwYz0RnOWT4t4wJEBBu
	 QU5yQ2O9hn9rQ==
Date: Sat, 28 Sep 2024 16:36:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: light: ltr390: Suspend and Resume support
Message-ID: <20240928163631.04e11191@jic23-huawei>
In-Reply-To: <20240914181246.504450-3-abhashkumarjha123@gmail.com>
References: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
	<20240914181246.504450-3-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 23:42:44 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Added support for suspend and resume PM ops.
> We suspend the sensor by clearing the ALS_UVS_EN bit in the MAIN CONTROL
> register. And we resume it by setting that bit.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
I made a few tweaks whilst applying.
> ---
>  drivers/iio/light/ltr390.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index c50ea31e2..e152009b5 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -24,6 +24,7 @@
>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
> +#include <linux/device.h>
This is already out of order, but moving the new include to the top
means only bitfield.h is misplaced.

>  
>  #include <linux/iio/iio.h>
>  
> @@ -430,6 +431,26 @@ static int ltr390_probe(struct i2c_client *client)
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> +static int ltr390_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +
> +	return regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
> +				LTR390_SENSOR_ENABLE);
> +}
> +
> +static int ltr390_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +
> +	return regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
> +				LTR390_SENSOR_ENABLE);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(ltr390_pm_ops, ltr390_suspend, ltr390_resume);
> +
>  static const struct i2c_device_id ltr390_id[] = {
>  	{ "ltr390" },
>  	{ /* Sentinel */ }
> @@ -446,6 +467,7 @@ static struct i2c_driver ltr390_driver = {
>  	.driver = {
>  		.name = "ltr390",
>  		.of_match_table = ltr390_of_table,
> +		.pm	= pm_sleep_ptr(&ltr390_pm_ops),
Tabs for aligning these go wrong so often by creating noise
in future patches + this code doesn't use them. So I dropped that
to be a space.

Thanks,

Jonathan

>  	},
>  	.probe = ltr390_probe,
>  	.id_table = ltr390_id,


