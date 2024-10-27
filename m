Return-Path: <linux-iio+bounces-11385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562499B1D09
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C1DB20FFE
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549A78C9D;
	Sun, 27 Oct 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obE7Np2r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A86029CE8;
	Sun, 27 Oct 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730023276; cv=none; b=TJnXaMAJD8qdZclPu2s2uPn1XBfxulP+U0tJ8mGONweshCjxSmsZv7Dhif7Q94nlPBuz3kYZ4BL+8Zrn55SJx12Bz/MgM6gTmJGHcmmIR0PJ4WFYCtM0Iu5JNWbY5ABSesAUcWDB2BkcsuIs2B5anldltU0jIWLfX/umxt1CSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730023276; c=relaxed/simple;
	bh=aH/G0HyyJs7XC/tWOKHsQCDORW67U2EB/82+ZBzGeVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ai19HWnlELNdCimPKcS1i3vLApXIcLQ615kYZF9BRDlHGQItSn7Qo3yUaK3U3O93FquGpj5RUAGqqQf46WGfYfzJCN/3Mh/x5BBdTDOUWc38g8yZm4hKlSEA8/vWjtaztXgjtaIbpG4l6S8bwt51tTQyBDNKbTORqjZF2AXySmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obE7Np2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268B4C4CEC3;
	Sun, 27 Oct 2024 10:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730023276;
	bh=aH/G0HyyJs7XC/tWOKHsQCDORW67U2EB/82+ZBzGeVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obE7Np2rfF+bk8SYiAlys/FconhybGsPHFDTDpOz9zQyd9XFMkOpf9QgC8SoYb/Ep
	 OncH7eYb24NXOfHgw99hULGENsocyvZVfAkNa/dSx5ZytzmSOxRwlkpS9p3PwE5KPA
	 8F9T+dzOojnUvodEJgPeEqY94af4Z4BBBF23Vrbr+9BTkQHUNb4o+TFcQcmp4mlA20
	 jRgeSQZ3L8aVfx+qo0IKCB6GWFVq7Liw9ivhwcVSzvDVQ+a7MQaRDME/vibbo88QRu
	 3ZWSvh2tE0VQRzfvDJERhlx+CurwZlez7BX7TmwS4LuRySQ+HSOzUA4POmVQq1MqMa
	 5c3WEieLQq5UQ==
Date: Sun, 27 Oct 2024 10:01:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] iio: chemical: bme680: move to fsleep()
Message-ID: <20241027100108.061c9074@jic23-huawei>
In-Reply-To: <20241021195316.58911-6-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-6-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 21:53:08 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Use the new fsleep() function in the remaining driver instances.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied. Note I'm applying these having skipped patch 4, so at somepoint I may
hit a conflict with that and stop even if this code in the later patches is fine.

Jonathan

> ---
>  drivers/iio/chemical/bme680_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 9002519d2c33..2ff85e29bfc1 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -544,7 +544,7 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
>  			   data->oversampling_humid) * 1936) + (477 * 4) +
>  			   (477 * 5) + 1000 + (data->heater_dur * 1000);
>  
> -	usleep_range(wait_eoc_us, wait_eoc_us + 100);
> +	fsleep(wait_eoc_us);
>  
>  	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &data->check);
>  	if (ret) {
> @@ -890,7 +890,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to reset chip\n");
>  
> -	usleep_range(BME680_STARTUP_TIME_US, BME680_STARTUP_TIME_US + 1000);
> +	fsleep(BME680_STARTUP_TIME_US);
>  
>  	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
>  	if (ret < 0)


