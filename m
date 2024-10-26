Return-Path: <linux-iio+bounces-11322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7915A9B177A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B03B21F5E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42341D3565;
	Sat, 26 Oct 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzNnDyxn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AD1FC3;
	Sat, 26 Oct 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729942533; cv=none; b=Mu/IytQttZnOvtSMEROyEW3BSMtUEOvl5RgvnBWxWKPPPCfJdQaox87qb4D5fziomEnP8IjNSzchEyRy3PA1oMyNJ9602rKgAVUjAOyTXhk6dNc4IojzdU9jDlXhY/ocqHlqRjqK5GHhtYnExL95WPTBOAZIhat6pM0ud7gsjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729942533; c=relaxed/simple;
	bh=zVh+3anI9MBJR0dPj+be+KfT4tO4kN/P6zdXTj9c0uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqyTb8z3KtKpPK8IOxOm99Hmi8Ss1lW8qS3zsrjvCbEjV8N5vw4TtG/+F8ZMcR8RmNkVEeXwDJ/kem8wWKR4XCySTaq/bgyVFgCdGGpoy2ut02FJuogghMxeFwBqbFWMAsuYRdfTpdsev9iaP16PUUJQMDWMn68diTVIVqW0HgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzNnDyxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8200C4CEC6;
	Sat, 26 Oct 2024 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729942533;
	bh=zVh+3anI9MBJR0dPj+be+KfT4tO4kN/P6zdXTj9c0uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CzNnDyxn1uydYtjtrDUzKH4M/p3Kt6jyuKJtXrVQcJyDLYUqkFe7XiFFWPBxOaFX3
	 gU9CADtBlXHuYQthliM5oAo47cknBQk6iqCqk0Nan3CQ6vjWiG4s+eHCvDxdOAUz++
	 G4nYFuGB/eCMW2N2IHDNCmqvxG6sPR1cLUz6GMbBNNL5gL996y8JnmMtZaYOVoYrv9
	 Zh+6V8f5sAus0xgBXBe/6BS8t5kht8q1/esKN7tVwEH0KUHT3PMUniLbKqbs+LR0pJ
	 lCjkXVSyVjN2hJP4fLjP6/sksmvKe+Cckz6MKJsyY3OIxnCt6F98FBErwjZrvIOiOD
	 EOVuQ00rQiePg==
Date: Sat, 26 Oct 2024 12:34:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 13/24] iio: accel: kxcjk-1013: Convert ODR times
 array to variable in chip_info
Message-ID: <20241026123450.4164f348@jic23-huawei>
In-Reply-To: <20241024191200.229894-14-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-14-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:02 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert odr_start_up_times array to the variable in chip_info.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Actually scratch the white space changes in previous. I'll do them here
instead and avoid the merge fun the earlier change would make.

Applied with 0x00 instead of 0 and spaces after { and before }.

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 166 ++++++++++++++++++---------------
>  1 file changed, 89 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index f384969a922d..91f890275a18 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -179,80 +179,84 @@ enum kx_chipset {
>  };
>  
>  /* Refer to section 4 of the specification */
> -static const struct {
> +struct kx_odr_start_up_time {
>  	int odr_bits;
>  	int usec;
> -} odr_start_up_times[KX_MAX_CHIPS][12] = {
> -	/* KXCJK-1013 */
> -	[KXCJK1013] = {
> -		{0x08, 100000},
> -		{0x09, 100000},
> -		{0x0A, 100000},
> -		{0x0B, 100000},
> -		{0, 80000},
> -		{0x01, 41000},
> -		{0x02, 21000},
> -		{0x03, 11000},
> -		{0x04, 6400},
> -		{0x05, 3900},
> -		{0x06, 2700},
> -		{0x07, 2100},
> -	},
> -	/* KXCJ9-1008 */
> -	[KXCJ91008] = {
> -		{0x08, 100000},
> -		{0x09, 100000},
> -		{0x0A, 100000},
> -		{0x0B, 100000},
> -		{0, 80000},
> -		{0x01, 41000},
> -		{0x02, 21000},
> -		{0x03, 11000},
> -		{0x04, 6400},
> -		{0x05, 3900},
> -		{0x06, 2700},
> -		{0x07, 2100},
> -	},
> -	/* KXCTJ2-1009 */
> -	[KXTJ21009] = {
> -		{0x08, 1240000},
> -		{0x09, 621000},
> -		{0x0A, 309000},
> -		{0x0B, 151000},
> -		{0, 80000},
> -		{0x01, 41000},
> -		{0x02, 21000},
> -		{0x03, 11000},
> -		{0x04, 6000},
> -		{0x05, 4000},
> -		{0x06, 3000},
> -		{0x07, 2000},
> -	},
> -	/* KXTF9 */
> -	[KXTF9] = {
> -		{0x01, 81000},
> -		{0x02, 41000},
> -		{0x03, 21000},
> -		{0x04, 11000},
> -		{0x05, 5100},
> -		{0x06, 2700},
> -	},
> -	/* KX023-1025 */
> -	[KX0231025] = {
> -		/* First 4 are not in datasheet, taken from KXCTJ2-1009 */
> -		{0x08, 1240000},
> -		{0x09, 621000},
> -		{0x0A, 309000},
> -		{0x0B, 151000},
> -		{0, 81000},
> -		{0x01, 40000},
> -		{0x02, 22000},
> -		{0x03, 12000},
> -		{0x04, 7000},
> -		{0x05, 4400},
> -		{0x06, 3000},
> -		{0x07, 3000},
> -	},
> +};
> +
> +/* KXCJK-1013 */
> +static const struct kx_odr_start_up_time kxcjk1013_odr_start_up_times[] = {
> +	{0x08, 100000},
> +	{0x09, 100000},
> +	{0x0A, 100000},
> +	{0x0B, 100000},
> +	{0, 80000},
> +	{0x01, 41000},
> +	{0x02, 21000},
> +	{0x03, 11000},
> +	{0x04, 6400},
> +	{0x05, 3900},
> +	{0x06, 2700},
> +	{0x07, 2100},
> +};
> +
> +/* KXCJ9-1008 */
> +static const struct kx_odr_start_up_time kxcj91008_odr_start_up_times[] = {
> +	{0x08, 100000},
> +	{0x09, 100000},
> +	{0x0A, 100000},
> +	{0x0B, 100000},
> +	{0, 80000},
> +	{0x01, 41000},
> +	{0x02, 21000},
> +	{0x03, 11000},
> +	{0x04, 6400},
> +	{0x05, 3900},
> +	{0x06, 2700},
> +	{0x07, 2100},
> +};
> +
> +/* KXCTJ2-1009 */
> +static const struct kx_odr_start_up_time kxtj21009_odr_start_up_times[] = {
> +	{0x08, 1240000},
> +	{0x09, 621000},
> +	{0x0A, 309000},
> +	{0x0B, 151000},
> +	{0, 80000},
> +	{0x01, 41000},
> +	{0x02, 21000},
> +	{0x03, 11000},
> +	{0x04, 6000},
> +	{0x05, 4000},
> +	{0x06, 3000},
> +	{0x07, 2000},
> +};
> +
> +/* KXTF9 */
> +static const struct kx_odr_start_up_time kxtf9_odr_start_up_times[] = {
> +	{0x01, 81000},
> +	{0x02, 41000},
> +	{0x03, 21000},
> +	{0x04, 11000},
> +	{0x05, 5100},
> +	{0x06, 2700},
> +};
> +
> +/* KX023-1025 */
> +static const struct kx_odr_start_up_time kx0231025_odr_start_up_times[] = {
> +	/* First 4 are not in datasheet, taken from KXCTJ2-1009 */
> +	{0x08, 1240000},
> +	{0x09, 621000},
> +	{0x0A, 309000},
> +	{0x0B, 151000},
> +	{0, 81000},
> +	{0x01, 40000},
> +	{0x02, 22000},
> +	{0x03, 12000},
> +	{0x04, 7000},
> +	{0x05, 4400},
> +	{0x06, 3000},
> +	{0x07, 3000},
>  };
>  
>  enum kx_acpi_type {
> @@ -313,50 +317,59 @@ static const struct kx_chipset_regs kx0231025_regs = {
>  
>  struct kx_chipset_info {
>  	const struct kx_chipset_regs *regs;
> +	const struct kx_odr_start_up_time *times;
>  	enum kx_chipset chipset;
>  	enum kx_acpi_type acpi_type;
>  };
>  
>  static const struct kx_chipset_info kxcjk1013_info = {
>  	.regs = &kxcjk1013_regs,
> +	.times = pm_ptr(kxcjk1013_odr_start_up_times),
>  	.chipset = KXCJK1013,
>  };
>  
>  static const struct kx_chipset_info kxcj91008_info = {
>  	.regs = &kxcjk1013_regs,
> +	.times = pm_ptr(kxcj91008_odr_start_up_times),
>  	.chipset = KXCJ91008,
>  };
>  
>  static const struct kx_chipset_info kxcj91008_kiox010a_info = {
>  	.regs = &kxcjk1013_regs,
> +	.times = pm_ptr(kxcj91008_odr_start_up_times),
>  	.chipset = KXCJ91008,
>  	.acpi_type = ACPI_KIOX010A,
>  };
>  
>  static const struct kx_chipset_info kxcj91008_kiox020a_info = {
>  	.regs = &kxcjk1013_regs,
> +	.times = pm_ptr(kxcj91008_odr_start_up_times),
>  	.chipset = KXCJ91008,
>  	.acpi_type = ACPI_GENERIC,
>  };
>  
>  static const struct kx_chipset_info kxcj91008_smo8500_info = {
>  	.regs = &kxcjk1013_regs,
> +	.times = pm_ptr(kxcj91008_odr_start_up_times),
>  	.chipset = KXCJ91008,
>  	.acpi_type = ACPI_SMO8500,
>  };
>  
>  static const struct kx_chipset_info kxtj21009_info = {
>  	.regs = &kxcjk1013_regs,
> +	.times = pm_ptr(kxtj21009_odr_start_up_times),
>  	.chipset = KXTJ21009,
>  };
>  
>  static const struct kx_chipset_info kxtf9_info = {
>  	.regs = &kxtf9_regs,
> +	.times = pm_ptr(kxtf9_odr_start_up_times),
>  	.chipset = KXTF9,
>  };
>  
>  static const struct kx_chipset_info kx0231025_info = {
>  	.regs = &kx0231025_regs,
> +	.times = pm_ptr(kx0231025_odr_start_up_times),
>  	.chipset = KX0231025,
>  };
>  
> @@ -655,12 +668,11 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>  
>  static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
>  {
> -	int idx = data->info->chipset;
> -	int i;
> +	const struct kx_odr_start_up_time *times;
>  
> -	for (i = 0; i < ARRAY_SIZE(odr_start_up_times[idx]); ++i) {
> -		if (odr_start_up_times[idx][i].odr_bits == data->odr_bits)
> -			return odr_start_up_times[idx][i].usec;
> +	for (times = data->info->times; times->usec; times++) {
> +		if (times->odr_bits == data->odr_bits)
> +			return times->usec;
>  	}
>  
>  	return KXCJK1013_MAX_STARTUP_TIME_US;


