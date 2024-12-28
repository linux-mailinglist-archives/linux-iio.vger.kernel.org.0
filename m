Return-Path: <linux-iio+bounces-13843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52D9FDB85
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 16:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7309160F00
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A05166F07;
	Sat, 28 Dec 2024 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXaKakPA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3BB67F;
	Sat, 28 Dec 2024 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735400530; cv=none; b=s3FTtSXIa5WVoai+XEx6TY4DCs7IeadyUFRthXpnUrER7wURlJjOsLLKYaU/VhJS/34ak4kw1n+B2Wdkmwqz94BsbuoMJ5yrQnecY1S0GNQwZIeoeXUOzVv/Z5QkNQ83JsFXKTeCO3yETK6NfKLv38jns5obAHjnmChavUjroIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735400530; c=relaxed/simple;
	bh=f3/OuU2DMTF+FFmb1cQB/7Uo3sJpoxGWs1FuPYVZB3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxrdBbSErfSE4kiEzhG5RwohnZyyuoUI8PiWcVe/NxTNmBgr1iYBGW3jgIdlO4c2t46Kfmm9mk/Gnvw3fOq+of8VgwYLSVhd6GbfBivW5+Fp2pqyX/5ylKPNC4QmeGMc2wlCps+5IxYyYy2ETt4GE7eaTfS1hKRUHbWldpks7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXaKakPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B32BC4CECD;
	Sat, 28 Dec 2024 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735400530;
	bh=f3/OuU2DMTF+FFmb1cQB/7Uo3sJpoxGWs1FuPYVZB3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aXaKakPAGaMNy0ex+5YQYB8S0Jv/eF3+P3PqnvzXPSN+0+89YrKxwsfc948Tq0+6e
	 CReIekoG0t2O9U9suaO7c1wYZccjZCc0ODP0rZErMqxG8PiKIdJUdiRFlv37/Ig3Gj
	 ObgA5aGwZ5ePOEFXk9wKo7Cten9C1EdNztAFsHzCb0VRI4UM1mH4G4/uFY/EPdn/XA
	 VVggM4urkaQuyQvLSqJSUcUBsF71Hmk/DCnlRk94CNyl5HDED1j0Wl9qZbBHhtIInj
	 d/jznMYAjTop/39Km3h4Z/yPyXegl/EKC9c1RvC3FKTEa9zJBQGjJLGOJxSKZGquGf
	 2si4Nl4wJptvw==
Date: Sat, 28 Dec 2024 15:42:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/4] iio: light: veml3235: fix code style
Message-ID: <20241228154204.43f1b416@jic23-huawei>
In-Reply-To: <20241224-veml3235_scale-v2-2-2e1286846c77@gmail.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
	<20241224-veml3235_scale-v2-2-2e1286846c77@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 11:59:01 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Trivial fixes to drop double spacings.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
This stands fine on it's own.

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to take a look.

Thanks,

Jonathan

> ---
>  drivers/iio/light/veml3235.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
> index 66361c3012a3d9f30a79630d51f329dacfb141bc..fa5c7e7dfbfaec1b96428612b1dcba91ea51603f 100644
> --- a/drivers/iio/light/veml3235.c
> +++ b/drivers/iio/light/veml3235.c
> @@ -321,7 +321,7 @@ static void veml3235_read_id(struct veml3235_data *data)
>  {
>  	int ret, reg;
>  
> -	ret = regmap_field_read(data->rf.id,  &reg);
> +	ret = regmap_field_read(data->rf.id, &reg);
>  	if (ret) {
>  		dev_info(data->dev, "failed to read ID\n");
>  		return;
> @@ -389,8 +389,8 @@ static int veml3235_hw_init(struct iio_dev *indio_dev)
>  }
>  
>  static const struct iio_info veml3235_info = {
> -	.read_raw  = veml3235_read_raw,
> -	.read_avail  = veml3235_read_avail,
> +	.read_raw = veml3235_read_raw,
> +	.read_avail = veml3235_read_avail,
>  	.write_raw = veml3235_write_raw,
>  };
>  
> 


