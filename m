Return-Path: <linux-iio+bounces-8214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C2946A6C
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 17:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFC91F2178F
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E215380B;
	Sat,  3 Aug 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sivnrIAW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D611ABEA7;
	Sat,  3 Aug 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722699874; cv=none; b=A8ruieZ/U3NoCkrHw/336UzV75CL7T7EgBMzK0V11lneN848Lxp5YS5dDnR9wxn7e+lpPjTGjntQ1n9s4vpO60XV6cQlwwTzVjn/rK13UVEP19reuctMB/Le+8wF+brZSN2E4HnFXH/NP2yLc45ltpup9ebdAX9APbOnGHBZaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722699874; c=relaxed/simple;
	bh=lWkmJmT+AROZeHMK80q1BxL+4k7khsevbM7kqr7lEps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJPl+4Tk61my0AgjGEdYzAnwXLHz0qoKaN1zUp92vnn57T1SOKDPiMuOOzXm3KOGNxZfS2xs/n4geYbxPTGJUz0hyCCq4vab9hjZZkiI45/4HCuAd3j7OsPx8aTnLKEcnr7xM0eLA1t57T6Ho9jv0xxkbW8mgtqeF8UltK5IDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sivnrIAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFB5C116B1;
	Sat,  3 Aug 2024 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722699874;
	bh=lWkmJmT+AROZeHMK80q1BxL+4k7khsevbM7kqr7lEps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sivnrIAWa6+mFNJ9zNmzLMHweW2DkU/kQHGZPkglfhBIpWT8h1Ghud+jvHlGizxa7
	 ScsqcSk+dpc27Jo3crQQkax9hyghqgJLV9XP4wQrvwBSZySLTdGBx+tuXaE9MUVrmv
	 HheSZ4M7n0DDUZt1uHyOd8lKCqpvtHvEMRu2G2ntb1wIRNCKWwTFnbWpA5iQZkLHes
	 MN4ziAGVhfyWA3s3Xc5Sj/G3LpO/EkzrV4VVUthVmWk1NmnW1UmQHeYN3yG2bSRQO/
	 x9ofTvdMpSy76u2p+4oPJQXTd/sI9uEtOW44JRZOwg4XlBU56nCgKVEAh1BBhjrJb6
	 CUhL73xp0eSZQ==
Date: Sat, 3 Aug 2024 16:44:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jagath Jog J
 <jagathjog1996@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Luke D . Jones" <luke@ljones.dev>, Jonathan
 LoBue <jlobue10@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: bmi323: suspend and resume triggering on
 relevant pm operations
Message-ID: <20240803164428.50fdd15c@jic23-huawei>
In-Reply-To: <20240727123034.5541-3-benato.denis96@gmail.com>
References: <20240727123034.5541-1-benato.denis96@gmail.com>
	<20240727123034.5541-3-benato.denis96@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jul 2024 14:30:34 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> Prevent triggers from stop working after the device has entered sleep:
> use iio_device_suspend_triggering and iio_device_resume_triggering helpers.

Hi Denis,

I'd got it into my head this was about main suspend / resume, but
it's runtime PM. I assume the s2idle uses only that level which is
interesting.

Anyhow, solution seems safe. We might be able to do something nicer
in the long run as potentially we could have the trigger driver
notified when all consumers have entered this state at which point it
could stop generating triggers at all.

Anyhow, that's a job for when we actually care about it.

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to poke at it.

For now I'm not keen to see this pushed into drivers where we don't
know if anyone is running into this particular situation.  We can
reevaluate that if we start getting lots of reports of this.

I'm also not going to rush this in as a fix. We can consider backporting
it once it's been in mainline for a bit and no side effects have
shown up.

Thanks,

Jonathan

> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> ---
>  drivers/iio/imu/bmi323/bmi323.h      |  1 +
>  drivers/iio/imu/bmi323/bmi323_core.c | 23 +++++++++++++++++++++++
>  drivers/iio/imu/bmi323/bmi323_i2c.c  |  1 +
>  drivers/iio/imu/bmi323/bmi323_spi.c  |  1 +
>  4 files changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323.h b/drivers/iio/imu/bmi323/bmi323.h
> index dff126d41658..209bccb1f335 100644
> --- a/drivers/iio/imu/bmi323/bmi323.h
> +++ b/drivers/iio/imu/bmi323/bmi323.h
> @@ -205,5 +205,6 @@
>  struct device;
>  int bmi323_core_probe(struct device *dev);
>  extern const struct regmap_config bmi323_regmap_config;
> +extern const struct dev_pm_ops bmi323_core_pm_ops;
>  
>  #endif
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index d708d1fe3e42..4b2b211a3e88 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -2121,6 +2121,29 @@ int bmi323_core_probe(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
>  
> +#if defined(CONFIG_PM)
> +static int bmi323_core_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +	return iio_device_suspend_triggering(indio_dev);
> +}
> +
> +static int bmi323_core_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +
> +	return iio_device_resume_triggering(indio_dev);
> +}
> +
> +#endif
> +
> +const struct dev_pm_ops bmi323_core_pm_ops = {
> +	SET_RUNTIME_PM_OPS(bmi323_core_runtime_suspend,
> +			   bmi323_core_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL_NS_GPL(bmi323_core_pm_ops, IIO_BMI323);
> +
>  MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
>  MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
> index 52140bf05765..057342f4f816 100644
> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> @@ -128,6 +128,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_i2c_match);
>  static struct i2c_driver bmi323_i2c_driver = {
>  	.driver = {
>  		.name = "bmi323",
> +		.pm = pm_ptr(&bmi323_core_pm_ops),
>  		.of_match_table = bmi323_of_i2c_match,
>  		.acpi_match_table = bmi323_acpi_match,
>  	},
> diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
> index 7b1e8127d0dd..487d4ee05246 100644
> --- a/drivers/iio/imu/bmi323/bmi323_spi.c
> +++ b/drivers/iio/imu/bmi323/bmi323_spi.c
> @@ -79,6 +79,7 @@ MODULE_DEVICE_TABLE(of, bmi323_of_spi_match);
>  static struct spi_driver bmi323_spi_driver = {
>  	.driver = {
>  		.name = "bmi323",
> +		.pm = pm_ptr(&bmi323_core_pm_ops),
>  		.of_match_table = bmi323_of_spi_match,
>  	},
>  	.probe = bmi323_spi_probe,


