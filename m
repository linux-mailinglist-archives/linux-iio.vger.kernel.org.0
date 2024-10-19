Return-Path: <linux-iio+bounces-10768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C129A4D1B
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B86283C2F
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE71DFD84;
	Sat, 19 Oct 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM/4Ogvw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7661DE8AE;
	Sat, 19 Oct 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729337415; cv=none; b=hYRrOLBGb9sJeM4oVowrObe3Evmn96a+fSR3oQTHU1/1PKF8t/qeFIfUegTtc2wPj70/0zfblrr8AnPvMxEecZ1QlAz6B0fVxziPFvISYFYA5N3n5GwT2WAJoD3j5km5MBKuZsFl+IGFRc4nSVgYBs6nukAwSZFoOoSkH6N2aCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729337415; c=relaxed/simple;
	bh=f4hvk3RHnG/3sXHIgPWKeaVEnM6TqEIkzeccwqLYhfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsB+oFj7jqHh7jRaKwPoe/ZkI65wV4LvVohiSDLYmpJ5PgqKHQHOeKfdBMRty5JXdxqw2ZnCoEmo4ZdemyfUd7ZUZIuGnDWxvYBiCYOiGFC3ljkwgvMmhlo6bRw7ddaUTllGTr1rHzCTHZgUunFoiclQFqBYnc5uFnW7O/aho4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM/4Ogvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A602FC4CEC5;
	Sat, 19 Oct 2024 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729337414;
	bh=f4hvk3RHnG/3sXHIgPWKeaVEnM6TqEIkzeccwqLYhfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gM/4OgvwrIq/erzS+1h/Qu+aQVNwfHrvFnkyUf3hWWMNxTT/jCemSaA04f/vYs9LY
	 AWdk4INN18PzqVdHh8nF87FOlZzhURCtGok2qc6YTvqNdYdHi9Z3C8BD+Qf7VZr83X
	 6DIBjDwluzWwGBxnrIXeItGRh7GzreZJHFV/Y/PfAXBIE67bB5EpEx8DGDX20ZTmN5
	 6GlQFhDAEe9/rpEoZwu0LfPLOM7UXPdDhqOS4tV2mMEP7GInkqvvFWvixW6mb1R1Kj
	 J3gxrlXihw330OuA4YQbAMZI0Sg5n6/tBRtjJemX6ZzFugNYhV0Qx3g3e143B/TNmJ
	 DTmk9iwv0AgCQ==
Date: Sat, 19 Oct 2024 12:30:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 1/6] iio: imu: bmi270: Use INFO_SAMP_FREQ instead of
 INFO_FREQUENCY
Message-ID: <20241019123005.096f03c3@jic23-huawei>
In-Reply-To: <20241018233723.28757-2-justin@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-2-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 16:36:07 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Use IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY
> to match the BMI160 / BMI323 drivers.
> 
> Fixes: 3ea51548d6b2 ("iio: imu: Add i2c driver for bmi270 imu")
> Signed-off-by: Justin Weiss <justin@justinweiss.com>

Whilst this gets rid of the wrong attributes, they still aren't
wired up to anything either way so a read will always return an error.

For now, the fix is drop the bit and bring it back in a patch
that adds the read_raw handling for the sampling frequency
(patch 6 I think).

> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index aeda7c4228df..87036f352698 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -122,7 +122,7 @@ static const struct iio_info bmi270_info = {
>  	.channel2 = IIO_MOD_##_axis,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> -		BIT(IIO_CHAN_INFO_FREQUENCY),			\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
>  }
>  
>  #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
> @@ -131,7 +131,7 @@ static const struct iio_info bmi270_info = {
>  	.channel2 = IIO_MOD_##_axis,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> -		BIT(IIO_CHAN_INFO_FREQUENCY),			\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
>  }
>  
>  static const struct iio_chan_spec bmi270_channels[] = {


