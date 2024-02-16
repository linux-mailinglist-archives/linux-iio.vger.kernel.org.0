Return-Path: <linux-iio+bounces-2610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3F2857BE4
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 12:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B201F272A8
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B806377A18;
	Fri, 16 Feb 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKTiAw8K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65B59B5F
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083696; cv=none; b=qCQDh8CBSB0oVMJ/Jr5PGt69rw0Qlycy2H2SmoliPBehm6ZP3ml4RbSO5+abyOWEmuFyP+cyV3/1ccvp6zkxTVlCxb2fC5G6aSjo2p8wrTHuxz/pgNbe5sojXLqdyJpgHd4h/YXUmCbo1KZHiESaKi0MJgge9swRDvUsEfwQdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083696; c=relaxed/simple;
	bh=ktF7Rsq7YPMIUh1zNqCsVAbFfXEYHshsKyu9YGlfvJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6XoWzS5L//mNCqF9sXQKxl+oKTtTvyP81wh+JIXdxN9aDuxyDFj8pjw5jiHVljSbAyfTMq+ivzN/LlrXwZ1Tje1euh+ue7kHIE4noE0KR6fHm7v0hEHkelUOVI6BifKGTWCMCBLAiSqmh8nudu95XyJ538DaxV/ujDKU1jber4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKTiAw8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691C6C433C7;
	Fri, 16 Feb 2024 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708083695;
	bh=ktF7Rsq7YPMIUh1zNqCsVAbFfXEYHshsKyu9YGlfvJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AKTiAw8K4tHHJ8HoZoQNlNwJDz3EcJGDcBTZLuoyqBMUBINign3WKRuZe8wnMAeBK
	 eCF6hs3L0bZ8dgkCAwwqiHBdMSz5Lyy+gQGDu/q2owbkj4IzaUmFYCr7RNraoUGTBg
	 ZU0ZSMmMaNbSxDfIIHWOTVAg+CvH1Xioz3mzTOOejtL+5jZABwDSgZz7c1fuWrCQwq
	 Y8Aiw2ZuMHaCS8xOLFENZt4mb4VmcSsOa+BpS/2feg0IOKfAtupQjeC9NtbCguOl33
	 AYMhnOAvql5HBV4ixx9tcNwHhxx1pBQNQiep/kmEhK3SD2yuS1C1hbwu0f2t8Ctq6Y
	 bqJsRzTVRt4Zg==
Date: Fri, 16 Feb 2024 11:41:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH v5 2/2] iio: imu: bmi323: Add and enable ACPI Match
 Table
Message-ID: <20240216114123.7db07a2a@jic23-huawei>
In-Reply-To: <20240215182441.57391-1-jlobue10@gmail.com>
References: <CAF6rpDwtj-mtpfFntf8XtTnF2vQMw4rtg1eV-kFGYj6r9hWvKA@mail.gmail.com>
	<20240215182441.57391-1-jlobue10@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 10:24:41 -0800
Jonathan LoBue <jlobue10@gmail.com> wrote:

Add ACPI Match Table

is enough - would be odd if we didn't use it ;)

This looks fine to me, but I'm not the expert in work arounds for this
sort of ACPI issue. 

I'm too used to the nice world of servers where we fix wrong firmware
(and this sort of change is always rejected by upstream). 

> This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi323
> driver with an ACPI match of "BOSC0200", and a comment about duplicate
> ACPI identifiers between devices using the bmc150 and bmi323 chips.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Co-developed-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> ---
>  drivers/iio/imu/bmi323/bmi323_i2c.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
> index 20a8001b9956..f7550503e47e 100644
> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> @@ -93,6 +93,25 @@ static int bmi323_i2c_probe(struct i2c_client *i2c)
>  	return bmi323_core_probe(dev);
>  }
>  
> +static const struct acpi_device_id bmi323_acpi_match[] = {
> +	/*
> + 	 * The "BOSC0200" identifier used here is not unique to bmi323 devices.
> + 	 * The same "BOSC0200" identifier is found in the ACPI tables of devices
> + 	 * using the bmc150 chip. This creates a conflict with duplicate ACPI
> + 	 * identifiers which multiple drivers want to use. If a non-bmi323 device
> + 	 * starts to load with this "BOSC0200" ACPI match here, then the chip
> + 	 * ID check portion should fail because the chip IDs received (via i2c) are
> + 	 * unique between bmc150 and bmi323 and the driver should relinquish the
> + 	 * device. If and when a different driver (such as bmc150) starts to load
> + 	 * with the "BOSC0200" ACPI match, a short reset should ensure that the
> + 	 * device is not in a bad state during that driver initialization. This
> + 	 * device reset does occur in both the bmi323 and bmc150 init sequences.
> + 	 */
> +	{ "BOSC0200" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, bmi323_acpi_match);
> +
>  static const struct i2c_device_id bmi323_i2c_ids[] = {
>  	{ "bmi323" },
>  	{ }
> @@ -109,6 +128,7 @@ static struct i2c_driver bmi323_i2c_driver = {
>  	.driver = {
>  		.name = "bmi323",
>  		.of_match_table = bmi323_of_i2c_match,
> +		.acpi_match_table = bmi323_acpi_match,
>  	},
>  	.probe = bmi323_i2c_probe,
>  	.id_table = bmi323_i2c_ids,


