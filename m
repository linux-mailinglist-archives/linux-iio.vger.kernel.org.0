Return-Path: <linux-iio+bounces-11323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B3E9B177B
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59F11F226E1
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577B41D3565;
	Sat, 26 Oct 2024 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMusbsVm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BE81FC3;
	Sat, 26 Oct 2024 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729942698; cv=none; b=eGkE4Ty0UT5VzTEszp1WG7FKhEFV1tSFdidNu4qYecTu6x7Sl5Eqfh5mp3eVHBcb7PG5N7K4TrgtJ0wK388dlqis080VrqpwdV0dUZHqC+B1iZU7AnwZLjcQHPG6xir00667ZHIY3MR6dJeDgaqrCRnl8k95M3S3sdU3lG/gxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729942698; c=relaxed/simple;
	bh=6YCfCTqzCqc4f+nIBzd0GlvTLXYbFWt8C/4e1kUAtwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Onm57jMG+RS21d6xEQMWTGaKFpL60zmenxpji2zOZRWWnbO0/hfAwV/endNw/Ut/dJ2+uIGrzIcuhO6hsDb5ln2I5mwOqKXtj1qzwS2iiN5D0ZjzZJWY/enmZSlaiV6dlqaNoRiJ0swvRlz5pLsEXe8wowXRLJfLpPZIRNgYnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMusbsVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E844C4CEE4;
	Sat, 26 Oct 2024 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729942697;
	bh=6YCfCTqzCqc4f+nIBzd0GlvTLXYbFWt8C/4e1kUAtwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CMusbsVmw8VM2jrgUh4qoq7qXLx70ZZ7AZhtIW+Z8ymOr4pfiYKSYE/Jikl623JiV
	 WA1ecTbKUKJgO4KWKUNlwheKNrHmPDPYisSBmyghqZy++7NhDhk2VFeLx3uBCSjKq/
	 ESJhiBciBe2+OY9/l3ZSFq91bBB2VI+zEsa6LH18eSb1LmPGDn4vfDUZfBGEjg1rOq
	 5+Od8o68v7ScIHhbyodRHzgbnXzibzenySKoRCkL2KyOrNDNTyX+73L6PeQzrx6uK2
	 w/F5WHSoWO0ukZ2g+lSH9x8rdM9ePrkl5aA/EXNZ7V06fX2nbTKl24BRleveRV55K0
	 J4SztYKKychTw==
Date: Sat, 26 Oct 2024 12:37:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 14/24] iio: accel: kxcjk-1013: Get rid of enum
 kx_chipset
Message-ID: <20241026123736.5714fadd@jic23-huawei>
In-Reply-To: <20241024191200.229894-15-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-15-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:03 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Instead of using enum, out of which only a couple of values
> are being actully used, make a comparisons against pointer
> to the respective chip_info structures.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Hmm. Maybe worth a revisit longer term to use callbacks for the
decisions instead of matching at all as this stuff tends not to end
up being specific to one version of a chip as more parts are added.

Anyhow, this is still an improvement so applied.

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 91f890275a18..a8c73e401f95 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -169,15 +169,6 @@
>  
>  #define KXCJK1013_DEFAULT_WAKE_THRES	1
>  
> -enum kx_chipset {
> -	KXCJK1013,
> -	KXCJ91008,
> -	KXTJ21009,
> -	KXTF9,
> -	KX0231025,
> -	KX_MAX_CHIPS /* this must be last */
> -};
> -
>  /* Refer to section 4 of the specification */
>  struct kx_odr_start_up_time {
>  	int odr_bits;
> @@ -318,59 +309,50 @@ static const struct kx_chipset_regs kx0231025_regs = {
>  struct kx_chipset_info {
>  	const struct kx_chipset_regs *regs;
>  	const struct kx_odr_start_up_time *times;
> -	enum kx_chipset chipset;
>  	enum kx_acpi_type acpi_type;
>  };
>  
>  static const struct kx_chipset_info kxcjk1013_info = {
>  	.regs = &kxcjk1013_regs,
>  	.times = pm_ptr(kxcjk1013_odr_start_up_times),
> -	.chipset = KXCJK1013,
>  };
>  
>  static const struct kx_chipset_info kxcj91008_info = {
>  	.regs = &kxcjk1013_regs,
>  	.times = pm_ptr(kxcj91008_odr_start_up_times),
> -	.chipset = KXCJ91008,
>  };
>  
>  static const struct kx_chipset_info kxcj91008_kiox010a_info = {
>  	.regs = &kxcjk1013_regs,
>  	.times = pm_ptr(kxcj91008_odr_start_up_times),
> -	.chipset = KXCJ91008,
>  	.acpi_type = ACPI_KIOX010A,
>  };
>  
>  static const struct kx_chipset_info kxcj91008_kiox020a_info = {
>  	.regs = &kxcjk1013_regs,
>  	.times = pm_ptr(kxcj91008_odr_start_up_times),
> -	.chipset = KXCJ91008,
>  	.acpi_type = ACPI_GENERIC,
>  };
>  
>  static const struct kx_chipset_info kxcj91008_smo8500_info = {
>  	.regs = &kxcjk1013_regs,
>  	.times = pm_ptr(kxcj91008_odr_start_up_times),
> -	.chipset = KXCJ91008,
>  	.acpi_type = ACPI_SMO8500,
>  };
>  
>  static const struct kx_chipset_info kxtj21009_info = {
>  	.regs = &kxcjk1013_regs,
>  	.times = pm_ptr(kxtj21009_odr_start_up_times),
> -	.chipset = KXTJ21009,
>  };
>  
>  static const struct kx_chipset_info kxtf9_info = {
>  	.regs = &kxtf9_regs,
>  	.times = pm_ptr(kxtf9_odr_start_up_times),
> -	.chipset = KXTF9,
>  };
>  
>  static const struct kx_chipset_info kx0231025_info = {
>  	.regs = &kx0231025_regs,
>  	.times = pm_ptr(kx0231025_odr_start_up_times),
> -	.chipset = KX0231025,
>  };
>  
>  enum kxcjk1013_axis {
> @@ -647,7 +629,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>  	}
>  
>  	/* On KX023, route all used interrupts to INT1 for now */
> -	if (data->info->chipset == KX0231025 && data->client->irq > 0) {
> +	if (data->info == &kx0231025_info && data->client->irq > 0) {
>  		ret = i2c_smbus_write_byte_data(data->client, KX023_REG_INC4,
>  						KX023_REG_INC4_DRDY1 |
>  						KX023_REG_INC4_WUFI1);
> @@ -883,7 +865,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (data->info->chipset == KXTF9)
> +	if (data->info == &kxtf9_info)
>  		odr_setting = kxcjk1013_find_odr_value(kxtf9_samp_freq_table,
>  						       ARRAY_SIZE(kxtf9_samp_freq_table),
>  						       val, val2);
> @@ -927,7 +909,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
>  
>  static int kxcjk1013_get_odr(struct kxcjk1013_data *data, int *val, int *val2)
>  {
> -	if (data->info->chipset == KXTF9)
> +	if (data->info == &kxtf9_info)
>  		return kxcjk1013_convert_odr_value(kxtf9_samp_freq_table,
>  						   ARRAY_SIZE(kxtf9_samp_freq_table),
>  						   data->odr_bits, val, val2);
> @@ -1194,7 +1176,7 @@ static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
>  	struct kxcjk1013_data *data = iio_priv(indio_dev);
>  	const char *str;
>  
> -	if (data->info->chipset == KXTF9)
> +	if (data->info == &kxtf9_info)
>  		str = kxtf9_samp_freq_avail;
>  	else
>  		str = kxcjk1013_samp_freq_avail;
> @@ -1443,7 +1425,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
>  	}
>  
>  	if (ret & KXCJK1013_REG_INT_SRC1_BIT_WUFS) {
> -		if (data->info->chipset == KXTF9)
> +		if (data->info == &kxtf9_info)
>  			iio_push_event(indio_dev,
>  				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  				       0,


