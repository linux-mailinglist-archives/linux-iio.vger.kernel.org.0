Return-Path: <linux-iio+bounces-25010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827A3BD0A54
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368F73BB486
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197EA2ED16C;
	Sun, 12 Oct 2025 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIXOgDSG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75661A275;
	Sun, 12 Oct 2025 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760295920; cv=none; b=bAUfdHY0rfvV54c2IPxBbFIOBNyvsUthVWD7HnhS8FN3bkFkrqVGZoxdA+heqx2zdewqtay5zEC/Jv2V65gUw1i4KNvTnob5wXYkE2n6eMgZ/mljm0he3uLWl1AP40MFacIVz7lFHVzoPovw6ZIOj2Plh5392kqY0yPV1qVji5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760295920; c=relaxed/simple;
	bh=cDrMWNtk5yJUv7e601R2iazOPWEXAHlkDtfs9dDAh2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBHVFyIvIPArnDlV24wvNiooWtTbkcQ5hwgFIi1uHfuxDdJLf4UciBDfWZfj4xURA/l2DvA2RtFODdq8I6mNhOUAAsE8gH9+WrVBDf+zKQGRj0y4EdpSPADOK4tgY1kk6hKSKLAtFWV3U/t4KPtz0WtZFYBxufWQ6EED6sWu10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIXOgDSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F38FC4CEE7;
	Sun, 12 Oct 2025 19:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760295920;
	bh=cDrMWNtk5yJUv7e601R2iazOPWEXAHlkDtfs9dDAh2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IIXOgDSGlMuzFfohRKdv9U+TarOuK64YSi6JTZBl1ET7rzr7QkJvJhg/1a/IFgwsr
	 qa4jQfTklT6LiQwHDsj1AzHAXkoRYdiCqw2iR723mkiFjZn6MSH7/s9CSklxYbZzHg
	 iytz5Q7N5QGpFCBEBqxc/2m4UM87PGMvZYeS5nIIHDFXpa9geHYuEsEbf/OUv9C0UO
	 agRNov93ZouX1K96dU37R1Htd5Gwbw/gK6cWge+PYc9ylw/xAkraS4vy7sMAiLJDt1
	 mt2gPl2L74ezOIUvOUyArJrb3COQSzwFsTgIRKQ6EgcKm8g738+Zrro4r/Q7l9JeST
	 10cDbxvIbvJ5w==
Date: Sun, 12 Oct 2025 20:05:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: lanzano.alex@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix dev_err_probe error msg
Message-ID: <20251012200511.0a622220@jic23-huawei>
In-Reply-To: <20251010191055.28708-1-rodrigo.gobbi.7@gmail.com>
References: <20251010191055.28708-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Oct 2025 16:06:46 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> The bmi270 can be connected to I2C or a SPI interface. If it is a SPI,
> during probe, if devm_regmap_init() fails, it should print the "spi"
> term rather "i2c".
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Just fixing this little "typo", definitely it was copied from the bmi270_i2c.c [1],
> which has the same dev_err_probe logic.
> Tks and regards.
> 
> [1] https://github.com/torvalds/linux/blob/master/drivers/iio/imu/bmi270/bmi270_i2c.c#L30

Given the confusion this could cause I'm thinking this should go to stable.
It needs a fixes tag.

thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi270/bmi270_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
> index 19dd7734f9d0..5e625586681d 100644
> --- a/drivers/iio/imu/bmi270/bmi270_spi.c
> +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
> @@ -60,7 +60,7 @@ static int bmi270_spi_probe(struct spi_device *spi)
>  				  &bmi270_spi_regmap_config);
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(dev, PTR_ERR(regmap),
> -				     "Failed to init i2c regmap");
> +				     "Failed to init spi regmap");
>  
>  	return bmi270_core_probe(dev, regmap, chip_info);
>  }


