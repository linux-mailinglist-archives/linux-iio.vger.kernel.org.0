Return-Path: <linux-iio+bounces-20655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E52AD9D08
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091B8189B455
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95322D131D;
	Sat, 14 Jun 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEAMIvVE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54B235066;
	Sat, 14 Jun 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908878; cv=none; b=HoMKCTjW7+yDu6Az4Zd4L5xe+/PQxs3MtgcC0C18GPDbQZeBh3Qx0xDUdIyIFfs8KmA8PUhcB4tngImfO8d486b7/e564t9hwVT48o1J8qW2tZqnkA0ZTV+MrEN/uBTCt1jqvxSdcrSpZkGc/mHcVgjlPjzU81OmtbxRdkPnWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908878; c=relaxed/simple;
	bh=m9LN/GSJ7PSEf4OUq7aveqLE8CmcKJegnx4AXwSf5mY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6SnQ7I2xGdTBypjkWZ/Kv86rBDUgd4WXze0o8hjYwXSJ3FnN7Fqy2N0qFR2bsGrZMdB+r6/GnGOtHKsh2q4mpyqusrRNb9Z08dPQkZ7tCmMWNUc+jQ23xAGe2ZJGmjXlUoMDns6P8CY2ZocjoLo/URmOuQtrqwztB0yikAVgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEAMIvVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5772C4CEEB;
	Sat, 14 Jun 2025 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908878;
	bh=m9LN/GSJ7PSEf4OUq7aveqLE8CmcKJegnx4AXwSf5mY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cEAMIvVE0qCtS6th98pl6K1gD7gY84MBuKguKlJAlrV8Pgwqc/ReOWRDP9G8p1eVk
	 +7O0OMETGGsWT0+fjlqYcIjvliyOzUlkNIE0MeNfJOz3TZTyxjI4tqjvrXkf2NpG5S
	 9V8WWjtIZH1MbJx22euooy4jr2/VTRjf2eRp4OmcibpbKw4zX1BgvWvJl6Qg/qZW/2
	 v8BIlcpBBzpd9WtjWRhGNVTWdHBxiA1LkrtQKGqHtTnzf38WXicbe82/uGOtzUvT+1
	 7lpD9Y2m1hX/qTy01BFJTvq0X3Kvd9V1zQrMMRmGtoMqxxlqZqRIk4kZxiioK/FbVp
	 0L7h2xULy4haA==
Date: Sat, 14 Jun 2025 14:47:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 05/11] iio: accel: adxl345: simplify reading the FIFO
Message-ID: <20250614144750.1f1a7a0f@jic23-huawei>
In-Reply-To: <20250610215933.84795-6-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 21:59:27 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Bulk reading from the FIFO can be simplified. Remove unnecessary
> variables and simplify reading sets of x-, y- and z-axis measurements.
> 
> This is a refactoring change and should not impact functionality.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 18c625d323ba..dcfbfe4cac0f 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -884,15 +884,13 @@ static int adxl345_get_samples(struct adxl345_state *st)
>   */
>  static int adxl345_fifo_transfer(struct adxl345_state *st, int samples)
>  {
> -	size_t count;
>  	int i, ret = 0;
>  
> -	/* count is the 3x the fifo_buf element size, hence 6B */
> -	count = sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
>  	for (i = 0; i < samples; i++) {
>  		/* read 3x 2 byte elements from base address into next fifo_buf position */
>  		ret = regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BASE,
> -				       st->fifo_buf + (i * count / 2), count);
> +				       st->fifo_buf + (i * ADXL345_DIRS),
> +				       2 * ADXL345_DIRS);
				       sizeof(st->fifo_buf[0]) * ADXL345_DIRS);

As it's not locally obvious where that 2 comes from.

>  		if (ret)
>  			return ret;
>  


