Return-Path: <linux-iio+bounces-15965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDBA40A1C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33FE19C0AC3
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B629200105;
	Sat, 22 Feb 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu/AgNWd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB613C81B;
	Sat, 22 Feb 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242420; cv=none; b=irwozb664e/1tZ7ukvIxo3/YOmJ3barshpVlXyZB7YnwGCrTKQzM7fu3AyjHY4TJkzriG7MP4CtHLdAcYiV+EWAMBcoFFcClpKUwmSty/AKh1jvuBU+flBKUjrZT/6GktJ11nP8OfnLT3U87JU+rk5m8ded6mm0T0aM4Oz29ahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242420; c=relaxed/simple;
	bh=uEQXhWxZBNt34aLREac7tfLn3c4EABbPDnqMxyt6qvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKLBzYgyM91OY2JN12JcrpNmY1H9SYQW68pSdaQGKGOGEew4HFYJf1RlT3IshdzBJWZTruwgXJ6j4UowzLise5nbJGYD71rlceTcN5zjkt11s28Z18FmhIBpFwukFN8O9a/TRqiv4RMDhYKad//E8U/x159O1cPBjHoee6pghQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu/AgNWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382F7C4CED1;
	Sat, 22 Feb 2025 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740242419;
	bh=uEQXhWxZBNt34aLREac7tfLn3c4EABbPDnqMxyt6qvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cu/AgNWdXdKzf8CWTbX32DcIYQjAVc7qXkOJAQ3dDivYf2zu252fgwWpBaw0v1N6x
	 D1C3jrD9aA7anZR8xbOhZK6ctCxwGFL9XWZYq6Gj3MCSBuehYYndPVKzlbKBhrldV/
	 +h2xJQheotwig3KG/t6He3X8VWiTmcfcJgCdNxszRz+C5wZ3w19HL+bno/3T691hCE
	 P50Np8JfwcPT3qDOgrfoIEwayyanHXY5vPHHRs9A1QD3C/UAVCSR3P0nEtX2hUPW6S
	 hKoN5pM4tDABuTmrO1HIzZ7uwjUWTx5+DzPZuWodFyHch5hjEzrMOXoHq5KDKRwMLC
	 NnG1S+AAy7Imw==
Date: Sat, 22 Feb 2025 16:40:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: gyro: bmg160_i2c: add BMI088 to
 of_match_table
Message-ID: <20250222164013.0a5aae07@jic23-huawei>
In-Reply-To: <20250220165001.273325-3-jerrysteve1101@gmail.com>
References: <20250220165001.273325-1-jerrysteve1101@gmail.com>
	<20250220165001.273325-3-jerrysteve1101@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 00:50:01 +0800
Jun Yan <jerrysteve1101@gmail.com> wrote:

> BMI088 is missing from the of_match_table. Let's complete it.
> 
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Applied this patch. I'll initially push out as testing for 0-day to
see if it can find any problems.

Thanks,

Jonathan
> ---
>  drivers/iio/gyro/bmg160_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
> index 9c5d7e8ee99c..e6caab49f98a 100644
> --- a/drivers/iio/gyro/bmg160_i2c.c
> +++ b/drivers/iio/gyro/bmg160_i2c.c
> @@ -58,6 +58,7 @@ MODULE_DEVICE_TABLE(i2c, bmg160_i2c_id);
>  static const struct of_device_id bmg160_of_match[] = {
>  	{ .compatible = "bosch,bmg160" },
>  	{ .compatible = "bosch,bmi055_gyro" },
> +	{ .compatible = "bosch,bmi088_gyro" },
>  	{ }
>  };
>  


