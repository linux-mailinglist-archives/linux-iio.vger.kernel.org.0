Return-Path: <linux-iio+bounces-10410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15303998F88
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F061F24A78
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F9A1C9B64;
	Thu, 10 Oct 2024 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/MvHNRR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE6198831;
	Thu, 10 Oct 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584031; cv=none; b=Hottj3L1TVTd8yy9+wjwbGk6qXJL2ZwGaSTQOm3YW4VRCg+OvEdJfEsa1GnH/wgJGfKpL/HWMQrxESy8oMCj7RXDlV74Ie5EXulS8D9C1gY+X3hiC88skgNoY6YSujMlIcpXd8iE6oDIx09Mo/ohOuNdNhr4ZCdmcHFl4pyRnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584031; c=relaxed/simple;
	bh=jpr9buFT7NlA1GqSd4pkyNy9vIKUIND+QOAsYNG3+h8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1nuLK6R3rK1jfRoqNvBp/mEuAvhcYTg+YwJfeAShDDJwVcBA065Oz/Pwj6UeRvTeYGg6MJOBK05zIYeDDcrHKebskMg9Z54cz5SKx/54QjwgeZDq1zsUAYimHRBZI2QVsGWVCL4QVHFYLFyww60OpQ1EpqH1DvhAgLsW7A4+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/MvHNRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F03DC4CEC5;
	Thu, 10 Oct 2024 18:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728584030;
	bh=jpr9buFT7NlA1GqSd4pkyNy9vIKUIND+QOAsYNG3+h8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/MvHNRRigE3LMZo594vknMwHoOY908W61JiHLfUva4bEy5kqq9ZJNI3KGfzcC924
	 yez/3xoTIvaIdC0I3MHdlHreG3WVYz5TmmDqVAkhkQPEKfrwoy5EzuA5+YymcSuK9v
	 7z1y4QQ/5Djw8OLxewtFgvPeM417c5lT271mzp3yH4i23qHiMAoH4wyqYHv4/4f9ag
	 TYIKg/29hJYqjS8oGaWQXdkgAuFebGzWyB2Az/aZ6Indoyrg7o7tJKVqOh1sfkRXeo
	 K3FPOhZ/AFfXUCS+lGGwMxw1ZrDmAEMti9dP6dcasljlhuq/7pAlHb+EVh1eIH6NAk
	 fp1aNDwu9QbYw==
Date: Thu, 10 Oct 2024 19:13:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: jagathjog1996@gmail.com, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi323: remove redundant register definition
Message-ID: <20241010191343.3b298812@jic23-huawei>
In-Reply-To: <20241009111828.43371-1-tarang.raval@siliconsignals.io>
References: <20241009111828.43371-1-tarang.raval@siliconsignals.io>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 16:47:51 +0530
Tarang Raval <tarang.raval@siliconsignals.io> wrote:

> BMI323_STEP_SC1_REG was defined twice.
> 
> Redundant definition has been removed
> 
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
Applied. Thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi323/bmi323.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323.h b/drivers/iio/imu/bmi323/bmi323.h
> index 209bccb1f335..b4cfe92600a4 100644
> --- a/drivers/iio/imu/bmi323/bmi323.h
> +++ b/drivers/iio/imu/bmi323/bmi323.h
> @@ -141,7 +141,6 @@
>  #define BMI323_STEP_SC1_REG			0x10
>  #define BMI323_STEP_SC1_WTRMRK_MSK		GENMASK(9, 0)
>  #define BMI323_STEP_SC1_RST_CNT_MSK		BIT(10)
> -#define BMI323_STEP_SC1_REG			0x10
>  #define BMI323_STEP_LEN				2
>  
>  /* Tap gesture config registers */


