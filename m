Return-Path: <linux-iio+bounces-10772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2EA9A4D31
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75318B214A4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225181E0098;
	Sat, 19 Oct 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3r6kcwn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CA1DE4D8;
	Sat, 19 Oct 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338116; cv=none; b=IhOX8a49qosknWJAhLf4v29BydXtgmkl5Pz1w9voWBQTHwD4oLi7gdHr63JEuLyufKx9yLDHQYr5it/u428lSBm98rQHoFgruC6L/7C2IoACl9vWbxqjv2ZoyuxXddkOv1uCWcQI4r9uF+dTutWElVEtsFCFJd9IiAOqa/pNZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338116; c=relaxed/simple;
	bh=AZ2BY4cZIm4tnBEWKiFtaf6XDvbuK4DwpCP0Gmd1mMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDq85LvdqOGb6fE1yYt7HuycHW2sOr/cUf2fvTRG9+eFthj5TFLhL8sxu6xE8rawAhPKlh2i6I+3CNSaNogMe6wG/VS6RLuAeAAv4rZ+pXuPn+aFDU+yisa2O7rIZP47WmetzRcrSyph8nGqMMBcFVAApewLRmvkfTK+Cdfzd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3r6kcwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6F0C4CEC5;
	Sat, 19 Oct 2024 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729338116;
	bh=AZ2BY4cZIm4tnBEWKiFtaf6XDvbuK4DwpCP0Gmd1mMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g3r6kcwn28oMm41nVi5HlxkE/xYcsDzhxP7POlTqLKeZREXyyaQSAwyIIkRJHRqrb
	 vRv6oEm7lCaqeqMjvB20o+cKSsCSUJC2JahOVBmsBaMa4BLdbOBkvbkBVZ0rqBG2vA
	 cBRZwHeyBUduuAzmcGqm9yvDEI0IynaXs+LRmzFBRsUie2hdLaLmckSTsTjZzULZ61
	 lB0nomfRwNcG0ZmG8PLIUF4q6Y/J5aVehuI0cE05Pqt1JKJEdX7e6s1td6PaSWn5/h
	 mklJHmEuBRcAxt/3avVeqv/hFnogUi+flTa2TOj6fN5osXBpiGrkiRk8FnBTnn2nWE
	 rLFTlG3gV/hlw==
Date: Sat, 19 Oct 2024 12:41:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 5/6] iio: imu: bmi270: Add triggered buffer for Bosch
 BMI270 IMU
Message-ID: <20241019124151.54ecaf2a@jic23-huawei>
In-Reply-To: <20241018233723.28757-6-justin@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-6-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 16:36:11 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Set up a triggered buffer for the accel and angl_vel values.
> 
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
Looks good. One trivial comment inline.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi270/Kconfig       |  1 +
>  drivers/iio/imu/bmi270/bmi270.h      |  9 +++++
>  drivers/iio/imu/bmi270/bmi270_core.c | 56 ++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi270/Kconfig b/drivers/iio/imu/bmi270/Kconfig
> index 0ffd29794fda..6362acc706da 100644
> --- a/drivers/iio/imu/bmi270/Kconfig
> +++ b/drivers/iio/imu/bmi270/Kconfig
> @@ -6,6 +6,7 @@
>  config BMI270
>  	tristate
>  	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  
>  config BMI270_I2C
>  	tristate "Bosch BMI270 I2C driver"
> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> index 51e374fd4290..844d70a7d32e 100644
> --- a/drivers/iio/imu/bmi270/bmi270.h
> +++ b/drivers/iio/imu/bmi270/bmi270.h
> @@ -11,6 +11,15 @@ struct bmi270_data {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	const struct bmi270_chip_info *chip_info;
> +
> +	/*
> +	 * Where IIO_DMA_MINALIGN is larger than 8 bytes, align to that

maybe larger than 8 bytes
on x86_64 I think it is 8 bytes exactly, though I could be remembering that wrong.

> +	 * to ensure a DMA safe buffer.
> +	 */
> +	struct {
> +		__le16 channels[6];
> +		aligned_s64 timestamp;
> +	} data __aligned(IIO_DMA_MINALIGN);
>  };
>  

