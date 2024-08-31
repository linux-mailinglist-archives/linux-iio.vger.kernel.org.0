Return-Path: <linux-iio+bounces-8902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354789670F2
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 12:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E849B283A06
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8117317B4FE;
	Sat, 31 Aug 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgzVdVw5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44C1BC39;
	Sat, 31 Aug 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725101284; cv=none; b=QxI0pnapUQEjUx3IPRXWFXZ2wP6xu3n0RKdCK4zeY3q+T/fuB79GdBoSsl4H4O6t3euAC3ulJWoyQFYBJGFoS7rHhsHSPu9QuLVHUjlbMKDqxYGPHCeai3abLXw32DNrtw39UiswaO/fu7G4et0qtF5N1pGfhBIy03NyJ+GoqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725101284; c=relaxed/simple;
	bh=MwKI1qrtYyusKDZItQQkb1WHRX+8VmcA0TRf8mRwo+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0tgTNx6wqr4xqVr7X3jq5egwJNxo63y6wv37sTBgGr1BKluS4jpKwI2CsjB5iSNCkVkhSn145EjdP3WnCEvcVbcgxA5jLqLiblibXKSDE154VqMbB0ZR9JcSVQL9hxxi7HBJ49GRnLB/0bN4AUna8xuV7joCk1x9zuK+sJdQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgzVdVw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD4DC4CEC0;
	Sat, 31 Aug 2024 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725101283;
	bh=MwKI1qrtYyusKDZItQQkb1WHRX+8VmcA0TRf8mRwo+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CgzVdVw52qUXL8Es/YDJh9RTmk+fUHyD5cmGHPUQ6thmRylRmYx8QmBPWk9jBsg3i
	 m+7ymJ3+33qJxQnJq6fteelitnmm6IQPGQXPFK/qKzBYJ4JX2v6KuLbFJklzyWNvSB
	 OL32Hf3k4+Y02Nx/fGbf6ukRzpWrQVsCqnxpfQ5VK8RdOV+aLJWL7wufRMquSlh1kR
	 mrIYLJXKT8z0xW44gvhoh2O+cfpW7t7OA9ntpkjWO/Q7ASUaTXHGEBXAbdhIUiwCOT
	 NTDrIuQelBcqWcv56nUGGZg+TEnyF3dsosS0qazzEyKXa/RCjUnG4o2FY6TYVFFsyW
	 cquhugPRdapuQ==
Date: Sat, 31 Aug 2024 11:47:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp320x: Drop vendorless compatible strings
Message-ID: <20240831114756.38b459a1@jic23-huawei>
In-Reply-To: <20240826191728.1415189-1-robh@kernel.org>
References: <20240826191728.1415189-1-robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 14:17:28 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> The vendorless compatible strings are deprecated and weren't retained
> when the binding was converted to schema. As a result, they are listed
> as undocumented when running "make dt_compatible_check". Rather than add
> them back to the schema, let's just drop them as they are unnecessary.
> Furthermore, they are unnecessary as the SPI matching will strip the
> vendor prefix on compatible string and match that against the
> spi_device_id table.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Applied.

Thanks,

> ---
>  drivers/iio/adc/mcp320x.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index da1421bd7b62..57cff3772ebe 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -459,16 +459,6 @@ static int mcp320x_probe(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id mcp320x_dt_ids[] = {
> -	/* NOTE: The use of compatibles with no vendor prefix is deprecated. */
> -	{ .compatible = "mcp3001" },
> -	{ .compatible = "mcp3002" },
> -	{ .compatible = "mcp3004" },
> -	{ .compatible = "mcp3008" },
> -	{ .compatible = "mcp3201" },
> -	{ .compatible = "mcp3202" },
> -	{ .compatible = "mcp3204" },
> -	{ .compatible = "mcp3208" },
> -	{ .compatible = "mcp3301" },
>  	{ .compatible = "microchip,mcp3001" },
>  	{ .compatible = "microchip,mcp3002" },
>  	{ .compatible = "microchip,mcp3004" },


