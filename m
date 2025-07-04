Return-Path: <linux-iio+bounces-21344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D993AF8E15
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 11:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773A51CA7658
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66022F5321;
	Fri,  4 Jul 2025 09:12:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2392F50AD;
	Fri,  4 Jul 2025 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620325; cv=none; b=Ewf+wAulE7waQZ2c+IkIwJzGP7LYwBKsSOX/s5HvmDQ3EOHCbprTnyPns3ChOW8dthF7d2HP+Ns4tEt5xBUrnLi1Ug9pX6s+LaozKnbOS3gpAKOWgtyorC9ICnKYcCF3Jo5AEGlf+2V8Gc5C4XwpWwE2WGuHjjBBhUrYU6539VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620325; c=relaxed/simple;
	bh=RNKT2fX9yOVVpWHgCAMPOtfP5J0v5bEcgERwxXq1XXo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juwODa67QWqxZuuh0vrHS0Y5U36CVW5cuMnUtKT5d0qjpzuyhNFsKnIY9toNPvyPUQqaMuapbdtpsxfsm4JFHOwmaQcGsbjDYh2MmFKeebkviIDwojX5w3kJcNDdcWzdsdkQj/hPP3hQHFc9jOJwBCw4rrXUDBNvw9Wu3NjFKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYSVk6gbHz6L5K0;
	Fri,  4 Jul 2025 17:09:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B2D01402F1;
	Fri,  4 Jul 2025 17:12:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 11:12:00 +0200
Date: Fri, 4 Jul 2025 10:11:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7173: fix num_slots on most chips
Message-ID: <20250704101159.000013fd@huawei.com>
In-Reply-To: <20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com>
References: <20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 03 Jul 2025 17:16:31 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix the num_slots value for most chips in the ad7173 driver. The number
> of slots corresponds to the number of CHANNEL registers on each chip.
> 
> Fixes: 4310e15b3140 ("iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Perhaps worth calling out that for many chips it seems to be falsely limiting
the number of slots which is a functionality limitation I think rather
than a bug.  The ones going the other way are more of a problem though!

Jonathan

> ---
> FYI, the bug actually existed before the commit I used for Fixes:, but
> that commit did major refactoring involving multiple drivers that would
> be too complicated to try to backport to older kernels.
> 
> I will try to send a separate fix to stable@ to fix the bug in it's
> original form on older kernels as that is just a one-liner.
> ---
>  drivers/iio/adc/ad7173.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..9c197cea11eb955becf4b9b97246379fa9c5da13 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -771,10 +771,27 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
>  	.num_slots = 8,
>  };
>  
> +static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
> +	.set_channel = ad7173_set_channel,
> +	.append_status = ad7173_append_status,
> +	.disable_all = ad7173_disable_all,
> +	.disable_one = ad7173_disable_one,
> +	.set_mode = ad7173_set_mode,
> +	.has_registers = true,
> +	.has_named_irqs = true,
> +	.supports_spi_offload = true,
> +	.addr_shift = 0,
> +	.read_mask = BIT(6),
> +	.status_ch_mask = GENMASK(3, 0),
> +	.data_reg = AD7173_REG_DATA,
> +	.num_resetclks = 64,
> +	.num_slots = 16,
> +};
> +
>  static const struct ad7173_device_info ad4111_device_info = {
>  	.name = "ad4111",
>  	.id = AD4111_ID,
> -	.sd_info = &ad7173_sigma_delta_info_8_slots,
> +	.sd_info = &ad7173_sigma_delta_info_16_slots,
>  	.num_voltage_in_div = 8,
>  	.num_channels = 16,
>  	.num_configs = 8,
> @@ -796,7 +813,7 @@ static const struct ad7173_device_info ad4111_device_info = {
>  static const struct ad7173_device_info ad4112_device_info = {
>  	.name = "ad4112",
>  	.id = AD4112_ID,
> -	.sd_info = &ad7173_sigma_delta_info_8_slots,
> +	.sd_info = &ad7173_sigma_delta_info_16_slots,
>  	.num_voltage_in_div = 8,
>  	.num_channels = 16,
>  	.num_configs = 8,
> @@ -817,7 +834,7 @@ static const struct ad7173_device_info ad4112_device_info = {
>  static const struct ad7173_device_info ad4113_device_info = {
>  	.name = "ad4113",
>  	.id = AD4113_ID,
> -	.sd_info = &ad7173_sigma_delta_info_8_slots,
> +	.sd_info = &ad7173_sigma_delta_info_16_slots,
>  	.num_voltage_in_div = 8,
>  	.num_channels = 16,
>  	.num_configs = 8,
> @@ -836,7 +853,7 @@ static const struct ad7173_device_info ad4113_device_info = {
>  static const struct ad7173_device_info ad4114_device_info = {
>  	.name = "ad4114",
>  	.id = AD4114_ID,
> -	.sd_info = &ad7173_sigma_delta_info_8_slots,
> +	.sd_info = &ad7173_sigma_delta_info_16_slots,
>  	.num_voltage_in_div = 16,
>  	.num_channels = 16,
>  	.num_configs = 8,
> @@ -855,7 +872,7 @@ static const struct ad7173_device_info ad4114_device_info = {
>  static const struct ad7173_device_info ad4115_device_info = {
>  	.name = "ad4115",
>  	.id = AD4115_ID,
> -	.sd_info = &ad7173_sigma_delta_info_8_slots,
> +	.sd_info = &ad7173_sigma_delta_info_16_slots,
>  	.num_voltage_in_div = 16,
>  	.num_channels = 16,
>  	.num_configs = 8,
> @@ -874,7 +891,7 @@ static const struct ad7173_device_info ad4115_device_info = {
>  static const struct ad7173_device_info ad4116_device_info = {
>  	.name = "ad4116",
>  	.id = AD4116_ID,
> -	.sd_info = &ad7173_sigma_delta_info_8_slots,
> +	.sd_info = &ad7173_sigma_delta_info_16_slots,
>  	.num_voltage_in_div = 11,
>  	.num_channels = 16,
>  	.num_configs = 8,
> @@ -893,7 +910,7 @@ static const struct ad7173_device_info ad4116_device_info = {
>  static const struct ad7173_device_info ad7172_2_device_info = {
>  	.name = "ad7172-2",
>  	.id = AD7172_2_ID,
> -	.sd_info = &ad7173_sigma_delta_info_8_slots,
> +	.sd_info = &ad7173_sigma_delta_info_4_slots,
>  	.num_voltage_in = 5,
>  	.num_channels = 4,
>  	.num_configs = 4,
> @@ -926,7 +943,7 @@ static const struct ad7173_device_info ad7172_4_device_info = {
>  static const struct ad7173_device_info ad7173_8_device_info = {
>  	.name = "ad7173-8",
>  	.id = AD7173_ID,
> -	.sd_info = &ad7173_sigma_delta_info_8_slots,
> +	.sd_info = &ad7173_sigma_delta_info_16_slots,
>  	.num_voltage_in = 17,
>  	.num_channels = 16,
>  	.num_configs = 8,
> @@ -943,7 +960,7 @@ static const struct ad7173_device_info ad7173_8_device_info = {
>  static const struct ad7173_device_info ad7175_2_device_info = {
>  	.name = "ad7175-2",
>  	.id = AD7175_2_ID,
> -	.sd_info = &ad7173_sigma_delta_info_8_slots,
> +	.sd_info = &ad7173_sigma_delta_info_4_slots,
>  	.num_voltage_in = 5,
>  	.num_channels = 4,
>  	.num_configs = 4,
> @@ -960,7 +977,7 @@ static const struct ad7173_device_info ad7175_2_device_info = {
>  static const struct ad7173_device_info ad7175_8_device_info = {
>  	.name = "ad7175-8",
>  	.id = AD7175_8_ID,
> -	.sd_info = &ad7173_sigma_delta_info_8_slots,
> +	.sd_info = &ad7173_sigma_delta_info_16_slots,
>  	.num_voltage_in = 17,
>  	.num_channels = 16,
>  	.num_configs = 8,
> 
> ---
> base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
> change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1
> 
> Best regards,


