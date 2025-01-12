Return-Path: <linux-iio+bounces-14206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E9A0A97D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237131886546
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2281B4134;
	Sun, 12 Jan 2025 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnqKvgg6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87815278E;
	Sun, 12 Jan 2025 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736687934; cv=none; b=pcWhb3RTqfGE9WyvRHkABlTsmH9UR5+bzyEhYLTM/7vCpA3ITd+8etbPQAJeAAYwOfcnJ6BzyDqHoVaJrxEf/geoSZPO4AhgFCUBGqiv3cgkReKaRrHTmil6uo2djQnwrqGoI7NzYkZkTRHccbkLNF4xPLageiONkUCJkIvLIsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736687934; c=relaxed/simple;
	bh=3EZipdaCtN8SR7n678FBxi9oJC2hlQZ4fitrFNBsq64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGorPVjg6arttLKC7wIhxncpmPRM6+1ZNaddt5PX/IEMAktTQGC3+z60oS8ZW/SqHXE22v+ou4ykyUfhoc1Gu13XmE51Nrpu7NncJk73SbgbfoBqX08d+uTb/8JZQpfnKyy9DT4IeyPweysXccAQnJLX68J0iwOQvVSvg+DkMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnqKvgg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FE0C4CEDF;
	Sun, 12 Jan 2025 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736687933;
	bh=3EZipdaCtN8SR7n678FBxi9oJC2hlQZ4fitrFNBsq64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rnqKvgg6cJKPcFTJ7oKP24e9Sij8nvW/LNAdYFTIDTPdlHlHA95Uiyl2zEsCEPm80
	 jEXSRkWHr42crU/eMCaFuwzRDOKUBCgm93C6TYZK08oL7qTkGtd6tppTALVh2PwNp7
	 UR+k+GUX6+6B1xA4jDoS/6URVEcYllxJ3xeB4ZizKtfWDcInHlyTZoBx8anBfapCuc
	 wzXVqtOl8VmjKGiK4YKoP+ROJdbmcII5LEGrFmpJmD+2AyRHP9dvJNpjPKqAa73zlC
	 GGQtbPt5Dw/S9hk2UEYVjStq1NuIVjAftcdk0YvgqkhE1xpXT/pQQx1arjj3fy7I3z
	 GlFd1zNwIqtGQ==
Date: Sun, 12 Jan 2025 13:18:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] iio: light: veml6030: extend regmap to support
 regfields and caching
Message-ID: <20250112131845.539ecc7c@jic23-huawei>
In-Reply-To: <20250107-veml6030-scale-v1-1-1281e3ad012c@gmail.com>
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
	<20250107-veml6030-scale-v1-1-1281e3ad012c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Jan 2025 21:50:21 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The configuration registers are not volatile and are not affected
> by read operations (i.e. not precious), making them suitable to be
> cached in order to reduce the number of accesses to the device.
> 
> Add support for regfields as well to simplify register operations,
> taking into account the different fields for the veml6030/veml7700 and
> veml6035.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/veml6030.c | 141 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 116 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 9b71825eea9bee2146be17ed2f30f5a8f7ad37e3..a6385c6d3fba59a6b22845a3c5e252b619faed65 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -65,6 +65,11 @@ enum veml6030_scan {
>  	VEML6030_SCAN_TIMESTAMP,
>  };
>  
> +struct veml6030_rf {
> +	struct regmap_field *it;
> +	struct regmap_field *gain;
> +};
> +
>  struct veml603x_chip {
>  	const char *name;
>  	const int(*scale_vals)[][2];
> @@ -75,6 +80,7 @@ struct veml603x_chip {
>  	int (*set_info)(struct iio_dev *indio_dev);
>  	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
>  	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
> +	int (*regfield_init)(struct iio_dev *indio_dev);

With only two fields, why use a callback rather than just adding the two
const struct reg_field into this structure directly?

I'd also be tempted to do the caching and regfield changes as separate patches.

Jonathan




