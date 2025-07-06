Return-Path: <linux-iio+bounces-21403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5A6AFA656
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 18:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934DC17A9F8
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1C28850A;
	Sun,  6 Jul 2025 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iutQM//x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B22874FF;
	Sun,  6 Jul 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818288; cv=none; b=MqflLLbVU/jStF3eXhsA/UUVk4FHzEfr8YgD/gTpkAJhulb9mcid1nd8uhcitd8zfQ5BwBsV04UjL2BXqXCO/Y5fD1mlPhq5K4WPRZ+hM9UYlseNH7SdR8kNr8JDSpAQvJbAjd/ydEk0x9VkMW6XznS7u7mpHfBdZKEmwfzPcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818288; c=relaxed/simple;
	bh=7jU92AnpfZj64PrwM7NKYl5HyZCvxQF5Go8pK+xOnUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k45XVG/bN7LLq8jtrXDhrN5N1SRXWYYAJ324pvh9vm0XTGFjXLtZurqFXYkamdNyqNu4oTgVJk+wZBXLZwdb6ntAZYGwvtVaMX15ecBjc1jSqcIWiYkQc44LmXo/XBWjwdiT2rg/W+jXJwswcuWtcoYNqGvfY/3xM1fnT2RhqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iutQM//x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45700C4CEED;
	Sun,  6 Jul 2025 16:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751818287;
	bh=7jU92AnpfZj64PrwM7NKYl5HyZCvxQF5Go8pK+xOnUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iutQM//xnXHZ0QeH6Sftz3cYZOiasJMY+xdGgfkiEN5LTDYSyB5V8nQ89UYzi3zzW
	 qE9f/ON8QiVv2ApId9BJODaB0o03tMc9h2mkWxCG5KGEXgS0dMIimwWXCCWxMWXtdI
	 0hadBvB+f0S/2XFCG7P+br/LrJQyNaC0J70p08GBkhWaxnVzzPqFVN/8MMjQsmJlnM
	 XCK3BXC0bebMh+RXg90OBHaSuD1x3y3hXcrCFiZyycyWTAoPm/JMdTkJcmEHSgd9bo
	 vSkYA2KmkWo5NkAuADIZQ7BvTCCpx34+oiJ8YB3itL5gUOfd975d+L4FMrQS/mLLPC
	 CYnh922nvxuZg==
Date: Sun, 6 Jul 2025 17:11:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v11 2/8] iio: accel: adxl345: simplify reading the FIFO
Message-ID: <20250706171114.240334cf@jic23-huawei>
In-Reply-To: <20250702230315.19297-3-l.rubusch@gmail.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
	<20250702230315.19297-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 23:03:09 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Bulk FIFO reading can be streamlined by eliminating redundant variables and
> simplifying the process of reading x-, y-, and z-axis measurement sets.
> 
> This is a refactoring change with no expected impact on functionality.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied.
> ---
>  drivers/iio/accel/adxl345_core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 6c437d7a59ed..b7dfd0007aa0 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -885,15 +885,12 @@ static int adxl345_get_samples(struct adxl345_state *st)
>   */
>  static int adxl345_fifo_transfer(struct adxl345_state *st, int samples)
>  {
> -	size_t count;
>  	int i, ret = 0;
>  
> -	/* count is the 3x the fifo_buf element size, hence 6B */
> -	count = sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
>  	for (i = 0; i < samples; i++) {
> -		/* read 3x 2 byte elements from base address into next fifo_buf position */
>  		ret = regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BASE,
> -				       st->fifo_buf + (i * count / 2), count);
> +				       st->fifo_buf + (i * ADXL345_DIRS),
> +				       sizeof(st->fifo_buf[0]) * ADXL345_DIRS);
>  		if (ret)
>  			return ret;
>  


