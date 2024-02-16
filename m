Return-Path: <linux-iio+bounces-2609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0013C857BCF
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 12:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16BE28186B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C962477F11;
	Fri, 16 Feb 2024 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofmGUb1s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E36F59B54
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083439; cv=none; b=ciLMq1HtP2RnMU0LZAINpHu6i7edfCBOOzzOLuTN/PtONbv2gTxB5INCUJmcH0j4D1z9LwDxMz2K/lePL5Rxck4chKCtJM8w72bpN1FU0IYGwj5GswwUdZgJ86hfToflJ7y/omR+FCUXspwp92kjPB6rR0F1Eo2BeyYaT887Eto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083439; c=relaxed/simple;
	bh=zK5dRruKEoOSOyZbibQL7pBd8bxhI7zAbTEXZ9V7e+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dltSdF5bfY3K4EA8yhFpPxf68plmsZCWD9TbpgXUBthpO/VlBShPiMvH+LZrZYQwuwHyWfSMRBlfTil7VYAxFVAQEMfdRu3ZxJsWjD+HeBTfRbx0WEWAbB9MskuI1oZA+JvaUtV61a6uZHeWNUIqYGWPjlBVgYrKNo3xv/NZtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofmGUb1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDDBC433C7;
	Fri, 16 Feb 2024 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708083439;
	bh=zK5dRruKEoOSOyZbibQL7pBd8bxhI7zAbTEXZ9V7e+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ofmGUb1sBGOYOonpR78P+vB5yUVAPlZ5QLZHdfpU563VEqjelWvq8L7rqEqwScnII
	 H7V0enEyZy0EnwWgrb/RyovHEoliGYPh4rtxk16hwT4YY4W7bIKV5nt3YF1rN4xMaG
	 MkYNrBRYtn+RZfjUrH0HV4+YvIrJJjVmE4g7n0KQ34vTVBu2Ok6X8jNODSNVMKFT54
	 Tfijo6eewO6P09EZEWu04DH6w19+DvXfAHINTEDCo2RRnnsdQ8cjwCFGLoLRPcaeHL
	 tgsv/vjfCa8r+1r3NDWLcSwm2F2KJZUAqnGiXIlOUr1sdYZsR7WhUQeNKbPhUoPBJq
	 gi63wAhFiCgYA==
Date: Fri, 16 Feb 2024 11:37:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH v5 1/2] iio: accel: bmc150: Duplicate ACPI entries
Message-ID: <20240216113706.695b22fc@jic23-huawei>
In-Reply-To: <20240215182425.57334-1-jlobue10@gmail.com>
References: <CAF6rpDwtj-mtpfFntf8XtTnF2vQMw4rtg1eV-kFGYj6r9hWvKA@mail.gmail.com>
	<20240215182425.57334-1-jlobue10@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 10:24:25 -0800
Jonathan LoBue <jlobue10@gmail.com> wrote:

> This patch adds a description of the duplicate ACPI identifier issue
> between devices using bmc150 and bmi323.
Title of patch doesn't reflect what is going on.

If there are no other changes needed I can tweak that whilst applying
to

iio: accel: bmc150: Document duplicate ACPI entries with bmi323 driver

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
>  drivers/iio/accel/bmc150-accel-i2c.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index ee1ba134ad42..353271e23235 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -224,6 +224,19 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>  	{"BMA250E"},
>  	{"BMC150A"},
>  	{"BMI055A"},
> +	/*
> + 	 * The "BOSC0200" identifier used here is not unique to devices using
> + 	 * bmc150. The same "BOSC0200" identifier is found in the ACPI tables of
> + 	 * the ASUS ROG ALLY and Ayaneo AIR Plus which both use a Bosch BMI323
> + 	 * chip. This creates a conflict with duplicate ACPI identifiers which
> + 	 * multiple drivers want to use. Fortunately, when the bmc150 driver
> + 	 * starts to load on the ASUS ROG ALLY, the chip ID check portion fails
> + 	 * (correctly) because the chip IDs received (via i2c) are unique between
> + 	 * bmc150 and bmi323 and a dmesg output similar to this:
> + 	 * "bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0" can be seen.
> + 	 * This allows the bmi323 driver to take over for ASUS ROG ALLY, and
> + 	 * other devices using the bmi323 chip.
> + 	 */
>  	{"BOSC0200"},
>  	{"BSBA0150"},
>  	{"DUAL250E"},


