Return-Path: <linux-iio+bounces-24706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ADCBB8DD6
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 15:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A95519C07FC
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6B4272E6D;
	Sat,  4 Oct 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEN/svc+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5B25A642;
	Sat,  4 Oct 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759583896; cv=none; b=MtMVlQ6Bpq4YIpSUGYXYx/1iJoPUlWc0QZ/NY/QlexU6Np32XBxMzqf9rJGwDFBRG/qyGN4HrFXrgHPeDGBpkd/qn6EZVkgSHmAu6VXzClikm5sed+6wh8TWacLps+S8qIHqXHWfRkwW1cQ51oV0zvunW3UhO2wWHN4JU+rGp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759583896; c=relaxed/simple;
	bh=JC9Inc0aBqr5Q+O3ERojfxV/0Wn2FD3fVhL7NKr+cxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jydGxf14/24SnM6tGvzoS1Gwc4eZbLMW6lk+EBodwJc4Hezqi77L6zaPoA+DCaP1sISMB7UyWlz2uLop3nTXchVvELvn/cPyee/SpPLh7eGmqpUG3MChmhdX1gAg+oZnKqVcjeNN5y3lynpmGvFRgS6RfuyvGbRcimZN3zybOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEN/svc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC7AC4CEF1;
	Sat,  4 Oct 2025 13:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759583896;
	bh=JC9Inc0aBqr5Q+O3ERojfxV/0Wn2FD3fVhL7NKr+cxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aEN/svc+tC3ycK6uVXWK61T2S7TsR3YRcZwW/7VJVIQME+YaMev4AT1+Mfm2+ZKSa
	 4WsZ8DJ3T1SvO+YZ7pYB1mp4CikJzg+BoNIMw243GWGqiVIJyK9oT0WiBglEiA9xBI
	 sPik7jhewWw2YsjeAjrtMQHUSBGiIzQuCZL8MOORDvLJdRftvnxJKHUnYUyoo+b3IK
	 lbODviW71WFqro6vWo/CBlDruEd7PVLyzEZsZlWlzYze/qdzLHJKxhQSvboomd3RvX
	 fonRDQOL2XNy/cy2pAActnJ/WoI0SHT2bgLbNPuRS0wE+xzH9/yXmR8QYG18t7CMKi
	 9bqezu3YCMGZQ==
Date: Sat, 4 Oct 2025 14:18:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sameeksha Sankpal <sameekshasankpal@gmail.com>
Cc: anshulusr@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: Fix typo in variable name
Message-ID: <20251004141808.0a531d1e@jic23-huawei>
In-Reply-To: <20251003174425.9135-1-sameekshasankpal@gmail.com>
References: <20251003174425.9135-1-sameekshasankpal@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Oct 2025 23:14:25 +0530
Sameeksha Sankpal <sameekshasankpal@gmail.com> wrote:

> Corrected a spelling mistake in the ltr390 driver:
> 'recieve_buffer' was renamed to 'receive_buffer'.
> 
> This improves code readibility without changing functionality.
> 
> Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>

Applied with patch title amended to include the driver name.

Thanks,

Jonathan


> ---
>  drivers/iio/light/ltr390.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index df664f360903..277f40879932 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -121,16 +121,16 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
>  {
>  	struct device *dev = &data->client->dev;
>  	int ret;
> -	u8 recieve_buffer[3];
> +	u8 receive_buffer[3];
>  
> -	ret = regmap_bulk_read(data->regmap, register_address, recieve_buffer,
> -			       sizeof(recieve_buffer));
> +	ret = regmap_bulk_read(data->regmap, register_address, receive_buffer,
> +			       sizeof(receive_buffer));
>  	if (ret) {
>  		dev_err(dev, "failed to read measurement data");
>  		return ret;
>  	}
>  
> -	return get_unaligned_le24(recieve_buffer);
> +	return get_unaligned_le24(receive_buffer);
>  }
>  
>  static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)


