Return-Path: <linux-iio+bounces-9844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 945B0989064
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C2D1F21E75
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C481422D8;
	Sat, 28 Sep 2024 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0GBP3f0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE0136352;
	Sat, 28 Sep 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540574; cv=none; b=lclOsI57EWP1x3BMX88W0UxYncw40ROqwv9mVQqYYBgzgviqo75dKoWnu/UxmYfkzL56wvG8wjhewGQ0vr6RQwJLFjkDri/B4MUfb/AGX9r46aC0xHKFsmA2GZNAr7PDxEaiptrAaM1S5lixID1eo6pzf/rqWsmPtbfUzVkeryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540574; c=relaxed/simple;
	bh=tYeOKHlDiKu0z5v6DidPPsubsR0OVQ0GU5gDTr8O0nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCVkn+xJB5WxqUKwf5HnjzHiPKxNVA0g4v/db9PJiuWn7d2fjDKONF9WvJqyv0XyEFWexFvQ+LmVcjeMP3+L/G3TX/8CtuSu5m3t9Udza25nFxxUermYQEmtUr28ZrN1ZYem+TrGvnPhBgLw16YuPOT3KHje3P4P+U0Kq76tJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0GBP3f0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865A4C4CEC3;
	Sat, 28 Sep 2024 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727540574;
	bh=tYeOKHlDiKu0z5v6DidPPsubsR0OVQ0GU5gDTr8O0nQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e0GBP3f0GU+s4bnpUqOa2FJT+cItvuVWfcVilmpgUZV/iuuj6PFTdNOdwcgVXR9Ya
	 qVgfEzsgZrvYXc3G4vokXMc9DxYHELEF+bwzYgisGf107iH4Jdr3hFy/HSsoxkCc2g
	 S4IW6ENI6UNEVBX8mzW+QnsxWzmvHWCvYOHPJVXJDPpqbINyRboe2nxncwGmj6Dcl7
	 1fDRVWPGZ/ZJD6yCNZG2siOk+EzS2KCMR4uwpJnAlU8TZelqmP6fGL6PemrUdawcP/
	 6hu93QivKR/Xwe5uPtB52wHdzoQ/wSCpHkL0FvX+o13uTD30Yk3WFrDghFkQW+EtiB
	 TqUiCjZzp/Wpw==
Date: Sat, 28 Sep 2024 17:22:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 08/10] iio: light: veml6030: power off device in
 probe error paths
Message-ID: <20240928172245.6d69df95@jic23-huawei>
In-Reply-To: <20240923-veml6035-v2-8-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
	<20240923-veml6035-v2-8-58c72a0df31c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 00:17:56 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Move devm_add_action_or_reset() with a device shut down action above the
> hardware initialization function to ensure that any error path after
> powering on the device leads to a power off.
> 
> The power off action is carried out by setting the VEML6030_ALS_SD bit
> of the VEML6030_REG_ALS_CONF, which is harmless in error paths were the
> device is already off. On the other hand, making use of the registered
> action in all error paths makes them more homogeneous by avoiding
> special action depending on the current power state of the device.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
As per my very late reply, I'd move the devm_add_action_or_reset()
into the hw_init function so it's closely coupled with the thing
it is undoing rather than with a function that does lots of other
things.

You'll want to pass dev into the init function though so it is
easy to see what device the devm_ call is against.
Don't use the parent of the IIO dev as that's an implementation
detail!

Jonathan
> ---
>  drivers/iio/light/veml6030.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 861bdf2edd4d..19c69bfad8cb 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -853,12 +853,12 @@ static int veml6030_probe(struct i2c_client *client)
>  		indio_dev->info = &veml6030_info_no_irq;
>  	}
>  
> -	ret = veml6030_hw_init(indio_dev);
> +	ret = devm_add_action_or_reset(&client->dev,
> +				       veml6030_als_shut_down_action, data);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = devm_add_action_or_reset(&client->dev,
> -					veml6030_als_shut_down_action, data);
> +	ret = veml6030_hw_init(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> 


