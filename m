Return-Path: <linux-iio+bounces-10950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793889AB608
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 20:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2537D1F241E2
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 18:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58C61C9EA5;
	Tue, 22 Oct 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc9gwNn8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D317C98;
	Tue, 22 Oct 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622517; cv=none; b=EZmvGorAkyR+GOGhZ4jsSzoNu1Cjqc/8ZU1ugFKVjk/t83Zd2P6NryQn/F+90hNHRmxbgEV3wIK5hRDUavfoB1jG0D3/rQPrIOs2I/zVfmR27rHFROqKjrjF3YVi6rffiQafKGMXxTJqt1GxNEIhHQf6aT58bm4KJeSoE8DnLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622517; c=relaxed/simple;
	bh=TCyl5AKf9LmyUHnDP9SRdonItfqEcEZ/MjKK0kQ2Zh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSxbxaxbY7y5HPhf4gQFtKIpSl+n/emDlx31rJV+xKrJ5X8AzCY0Z/ANL97glvEWyui/DMHMtE8kukT2IdygrSQ1GydD41DfItDd8SdwdiMurVIFjj6bQgccrJHf8BNWKyxjFkRDyETzg8wK+pddYS5DDggW48WaLFI5iMY86AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc9gwNn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FDEC4CEC3;
	Tue, 22 Oct 2024 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729622517;
	bh=TCyl5AKf9LmyUHnDP9SRdonItfqEcEZ/MjKK0kQ2Zh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bc9gwNn8M3luIvQCXbAHWuurUdK9u0aHjyYG/6h8eRIKhJrHTD+8L5JTXQi2ZFsZm
	 KOKHnAcGkAuDPDtfFiA25KygHYaeT4I/zQJZ0HImHkZfNIoxkeZd3YhBB6AS8BO53P
	 5jAYhurS/S8bMDzaXyTxxB5d8WPfqHaDeh8LwN1U9Dr3Hjt3cH7WFlavfMtOnMeVvl
	 U7Ve5o16wsdzoMIfZBpYS0EBB/uZlV2hgDrjlMxw8LmJAoXn+RXVeI07Pk2/DulBzt
	 u1TNzz/PmelT8COsWX9Wib6j8Te8tqC51qIPxjwoi3i8R6Gemq6W5Bfzv6FxQYMn6O
	 ab6RqXyOqetBA==
Date: Tue, 22 Oct 2024 19:41:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v3 1/6] iio: imu: bmi270: Remove unused FREQUENCY /
 SCALE attributes
Message-ID: <20241022194149.758f48be@jic23-huawei>
In-Reply-To: <20241020220011.212395-2-justin@justinweiss.com>
References: <20241020220011.212395-1-justin@justinweiss.com>
	<20241020220011.212395-2-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Oct 2024 15:00:05 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> These attributes are not currently wired up, and will always return
> EINVAL.
> 
> Fixes: 3ea51548d6b2 ("iio: imu: Add i2c driver for bmi270 imu")
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
Applied this one to the togreg branch of iio.git and pushed out as
testing.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index aeda7c4228df..e598c642178f 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -121,8 +121,6 @@ static const struct iio_info bmi270_info = {
>  	.modified = 1,						\
>  	.channel2 = IIO_MOD_##_axis,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> -		BIT(IIO_CHAN_INFO_FREQUENCY),			\
>  }
>  
>  #define BMI270_ANG_VEL_CHANNEL(_axis) {				\
> @@ -130,8 +128,6 @@ static const struct iio_info bmi270_info = {
>  	.modified = 1,						\
>  	.channel2 = IIO_MOD_##_axis,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> -		BIT(IIO_CHAN_INFO_FREQUENCY),			\
>  }
>  
>  static const struct iio_chan_spec bmi270_channels[] = {


