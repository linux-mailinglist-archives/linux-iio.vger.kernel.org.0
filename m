Return-Path: <linux-iio+bounces-15164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA604A2D651
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 14:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6D1169CC8
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D8246345;
	Sat,  8 Feb 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttae+IXu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007914293;
	Sat,  8 Feb 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739021467; cv=none; b=Bw4RtV97SzbA8GSRCx6dubWGrYC+8KnUYO5VwVLDYqRtirE1C76eWm6FlT/fkMEVtkQdKNqOFyn88xgJfIpmTJgeveKg4lBXXa9W7a+2g1cZGG2mGMDnvCL5pfFCxGaXXkdg1zvUgaOy0H1mesH5+ZuRdgJ89mmnaH1yllIvyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739021467; c=relaxed/simple;
	bh=LKDMaWLCIF+uCJKuTbg25hpkAhLvwwOs5aqoFMw5njA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdlINCs3w88jEDxvst/d/4PUhJwjM1b6Sb2mXs2vC1x0MjkXiJjo8LDW36WRXAYVnHyqqopDGRBcSMn9YqFplvsAd5iMw1QLuRJqrndIw3LYmS8pm4OMHROkVaPkzehQ3tIOTdu/4xpknenz4644IySl6vGUmPDjziEZl2XbkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttae+IXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33F7C4CED6;
	Sat,  8 Feb 2025 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739021466;
	bh=LKDMaWLCIF+uCJKuTbg25hpkAhLvwwOs5aqoFMw5njA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ttae+IXuHTUCJC8xZvrN4lbEBG9+S6cMwLyHfSotKHnkHo7UvHdcyBcvl06PV3qfb
	 rjp2KmCExLtVN4Hu+EUv/f9pElV9DwzxmrkoIgvZSg8abyWD+Csodvs4pGe4a8zPG7
	 4RJ2vKq5tEP5SiTtw+J+7y7qC4uflO+uO4wWL/9p7bVSQfnprZtQ8t9b9gUSnn9leX
	 0s37jloxPp/72Y98TxAoG+46dei3+1pZ9Sn+xoIjc5DNhWpyYmH2cWnrn+NLji+PxQ
	 /8N8Ukuh9scaei3ihZEt7V4HmQpNE0dXt6SGOL2tZ03eFZJ8/7swsTN5WQ0/P4idW6
	 0h9Q+gh8tva2Q==
Date: Sat, 8 Feb 2025 13:30:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Cc: Cryolitia@gmail.com, Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter
 Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD
 firmware
Message-ID: <20250208133058.3e5cb597@jic23-huawei>
In-Reply-To: <20250206-bmi270-gpd-acpi-v1-1-db638cfb9a3c@gmail.com>
References: <20250206-bmi270-gpd-acpi-v1-1-db638cfb9a3c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Feb 2025 15:09:42 +0800
Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org> wrote:

> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> 
> Some GPD devices ship a buggy firmware that describes on-device BMI260 with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1], let's match the correct ID to detect the device. The buggy ID "BMI0160" is kept as well to maintain compatibility with older firmwares.
> 
> ---

This --- will break git picking up this patch as the
sign off etc will be misgin.

> Some GPD devices ship a buggy firmware that describes on-device BMI260 with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1], let's match the correct ID to detect the device. The buggy ID "BMI0160" is kept as well to maintain compatibility with older firmwares.
Please wrap commit message at 75 chars
> 
> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip
Link is an official tag so move down to the line above (no blank line) the
Sign off and if you want to refer to it use
Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip # [1]
or similar (so a comment after the tag).


If you have any means to tell the manufacturer that this is not a complaint ID
please do. They need to allocate them from their own ID space. 
They are unlikely to be the Benson Medical Instruments company.
https://uefi.org/PNP_ID_List?pnp_search=BMI

So either GPD need to get their on PNP ID  (or ACPI ID) or they need
to ask Bosch (BSG) to issue an ID for this sensor.

It would really help if Windows stopped accepting drivers that made up these
IDs, but I guess that ship long sailed.

Jonathan

> 
> [1]. See the update nodes in the archive file above
> 
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
> ---
>  drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index 44699ab589097eaa0eec5f2172245496ed031185..f66ae01e301df24f1e563e059da8cc531fc173eb 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -40,6 +40,8 @@ static const struct i2c_device_id bmi270_i2c_id[] = {
>  static const struct acpi_device_id bmi270_acpi_match[] = {
>  	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
>  	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
> +	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */

since

> +	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
>  	{ }
>  };
>  
> 
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250206-bmi270-gpd-acpi-de4d12bce567
> 
> Best regards,


