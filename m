Return-Path: <linux-iio+bounces-16428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD33A502C8
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 15:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E8E3B06BC
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE802500AA;
	Wed,  5 Mar 2025 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q62lxyjL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9424E4A8;
	Wed,  5 Mar 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186179; cv=none; b=h6lsvewqd68Bke7EJM0+ZbghcaHxMXKNqaOOzn/M/sytgtGDI+i2WQ5N3Ntf+JhbFYgkTGYFtVaTwQZCJrEeTw1FWAVXWsBYPFguYTghnWPvT8aGPvMB0IA2SIwmSbHkIajRg19up165c5hOqIxBb6sL9WCrDtbBHq2fAltTj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186179; c=relaxed/simple;
	bh=/2pS9LLpebWQnwTRaJg4p33HB1TGSur25XxkFxt08JU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfwLS4tNv2EvXBVy/NkMbkNnJcY0v+V8EPShuLKNwzVGH7SrlAXhaxSipP5KCsh2U2FviWOr9DZYRg1A8cDvU34WZ+stWUUDkqnl0UfwS5pRYzoVPhCvuM5cC4NfaIF4mkU9RoXu/QqWqr+Lt7TgouFspcT/0kkFiVv/u6uN3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q62lxyjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62E4C4CEEA;
	Wed,  5 Mar 2025 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186179;
	bh=/2pS9LLpebWQnwTRaJg4p33HB1TGSur25XxkFxt08JU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q62lxyjLA1eLIapx51hFTFib1eVwaU7CWiAJ1BLS30Lc1vC9oOOC8Bv2PZfat/YM4
	 250nIGaagro9AJT8v+0E++7578mwBPWjiKoiWr4D+jItE7Pu5xDt+myStTB8RFFmlq
	 b9eRLxoqOSp2tcnf23cURKKubUMh08uPpVmCFxbsavD4MWfdhqYuM+bNOWhEaPDa6f
	 cn122JhqnUoXpNfmezRWbo8vXRNfXH3tGq8WZycvyATevaAQ3aEC6SzeXYwv3hhjTc
	 gNe12LYwdJz9+A9r9ZPuKN3tfAyZ75vTpxfsOC0v0y3MqCSf8xv7ibgiK72ujlDIVI
	 pFnUHLFB5U9tQ==
Date: Wed, 5 Mar 2025 14:49:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix initial sampling frequency
 configuration
Message-ID: <20250305144928.1b9b483a@jic23-huawei>
In-Reply-To: <20250304-bmi270-odr-fix-v1-1-384dbcd699fb@gmail.com>
References: <20250304-bmi270-odr-fix-v1-1-384dbcd699fb@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Mar 2025 15:01:02 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> In the bmi270_configure_imu() function, the accelerometer and gyroscope
> configuration registers are incorrectly written with the mask
> BMI270_PWR_CONF_ADV_PWR_SAVE_MSK, which is unrelated to these registers.
> 
> As a result, the accelerometer's sampling frequency is set to 200 Hz
> instead of the intended 100 Hz.
> 
> Remove the mask to ensure the correct bits are set in the configuration
> registers.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>

Hi Gustavo,

Please reply to this thread with a suitable fixes tag.

Thanks,

Jonathan


> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index a86be5af5ccb1f010f2282ee31c47f284c1bcc86..2e4469f30d538ca3e9eb9ef8bbc6eaa8b6a144b8 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -918,8 +918,7 @@ static int bmi270_configure_imu(struct bmi270_data *data)
>  			      FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
>  					 BMI270_ACC_CONF_ODR_100HZ) |
>  			      FIELD_PREP(BMI270_ACC_CONF_BWP_MSK,
> -					 BMI270_ACC_CONF_BWP_NORMAL_MODE) |
> -			      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
> +					 BMI270_ACC_CONF_BWP_NORMAL_MODE));
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to configure accelerometer");
>  
> @@ -927,8 +926,7 @@ static int bmi270_configure_imu(struct bmi270_data *data)
>  			      FIELD_PREP(BMI270_GYR_CONF_ODR_MSK,
>  					 BMI270_GYR_CONF_ODR_200HZ) |
>  			      FIELD_PREP(BMI270_GYR_CONF_BWP_MSK,
> -					 BMI270_GYR_CONF_BWP_NORMAL_MODE) |
> -			      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
> +					 BMI270_GYR_CONF_BWP_NORMAL_MODE));
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to configure gyroscope");
>  
> 
> ---
> base-commit: 8cca9edca867350e5f8dc65b71e7a6ef4157981e
> change-id: 20250304-bmi270-odr-fix-620e7f8daa7a
> 
> Best regards,


