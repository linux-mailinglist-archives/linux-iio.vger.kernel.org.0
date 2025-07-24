Return-Path: <linux-iio+bounces-21967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC724B10A6E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 14:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609961CE0435
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685A2D3728;
	Thu, 24 Jul 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7HAxVTw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221A2D322E;
	Thu, 24 Jul 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360855; cv=none; b=MzEQcMun4Nr+u6I2UIAP1rMyhDuvR7EUNGwcjU2/8A3vPpBKmUZzSjYJxrfr69Rq13cXxKGUgskSNkq11Ng9idciypPHnwm+hyiD7PrEZByCK6TNBsAHKfo4GM6JzqnGYUSwiwxi2R6y40Vl8T/1m8nvGcVwWg4lqNE0QPol0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360855; c=relaxed/simple;
	bh=JTrgCNG2AIavu8ljdySPizsp1xTGwLhimgzpQM7kLX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTx4zxXGJ2ksCHXcKPLUdzC8vyUtHrAzFY0vHv+/jk7OSW5WxvLLCpKdeBT2pL5phcf+fNHxJOhEtCWKV4uvlKetJW5YbFCpJNOUOJzdePysoN8CHhGkzKAck1K2UMLUnq6Dhj/qMiPad9QbI6RXfsZoscapxRZ6xb0Fs0d48/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7HAxVTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48129C4CEED;
	Thu, 24 Jul 2025 12:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753360854;
	bh=JTrgCNG2AIavu8ljdySPizsp1xTGwLhimgzpQM7kLX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O7HAxVTwMZGbStBh44uKrlVia70Bv1Mgu1ASZsflVhpkR3uCurDxzI1os7IwaXhyM
	 TdCvcVKy8FmJq+stXe0U0nARy9In6CU84/n+Z86UCgF3vLCJw2UhWGq9wqY2nZ6bCC
	 GAsEmn09Lg4RLvtqtAXqN9JURrdfQQbvnUdzJkxTou7RUug2TS6/DfiRFtPIJE0H5H
	 kPRUI8ObniR+IZMv/9JE72CV1WfQQq8gTz5XXVgqYacmSY54PlA1tMc3ISt5uU4XyT
	 BwjBXcJiZNHqRrph5CKE+wRd2GcA1wYDCZwldWXzFwSto2dpXbO5VcNfHbU9NmjBTn
	 Orj7Valit9dEA==
Date: Thu, 24 Jul 2025 13:40:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Abhash Jha
 <abhashkumarjha123@gmail.com>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: light: vl6180: remove space before \n
 newline
Message-ID: <20250724134046.6521d38a@jic23-huawei>
In-Reply-To: <20250721150310.2601679-1-colin.i.king@gmail.com>
References: <20250721150310.2601679-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 16:03:09 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is an extraneous space before a newline in a dev_err_probe message.
> Remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Applied.

Thanks,
> ---
>  drivers/iio/light/vl6180.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index cc4f2e5404aa..38706424089c 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -722,7 +722,7 @@ static int vl6180_probe(struct i2c_client *client)
>  						IRQF_ONESHOT,
>  						indio_dev->name, indio_dev);
>  		if (ret)
> -			return dev_err_probe(&client->dev, ret, "devm_request_irq error \n");
> +			return dev_err_probe(&client->dev, ret, "devm_request_irq error\n");
>  
>  		init_completion(&data->completion);
>  


