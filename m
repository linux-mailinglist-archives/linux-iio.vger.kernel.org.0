Return-Path: <linux-iio+bounces-9871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED2498951F
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 13:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B668281E02
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 11:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5372915FCE5;
	Sun, 29 Sep 2024 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY+1SxiO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F9184D;
	Sun, 29 Sep 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727609333; cv=none; b=qSaXF+uxTQOl1j4SYKmbXX9kWLIhlGs7WGeqq062xUiX1ulpkDfUVfl6hrvu1K4zUFWvK2sMy9jpevvKWb8rBEv02kMpAJddvlWPXvgzBJmn1eOMcTB7QV44vKLKh8RQoBNtV87V3W0AG5dX6ZAt4wkzePobECkn8AeOtITYqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727609333; c=relaxed/simple;
	bh=y5JanSpKZz4So7sw8LV6nvw8kOVzoOmWON/EnkSGdXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mhl7b//5n8umq9IL1wjnZbs+lkEMq20NpXaXvO819r9SeAdK9vQmdcUguHd+wqP7qTbW1dtZ165Nggjo1nVVG/bC20QIjpa/MEa0/kXYPc6k+EImDfNJffswyoXmHdgmpqOc5ElMQ2K4lBWjabrXJkt6Or2Bzw2sUR7pD9Jc1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY+1SxiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74CBC4CEC5;
	Sun, 29 Sep 2024 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727609332;
	bh=y5JanSpKZz4So7sw8LV6nvw8kOVzoOmWON/EnkSGdXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eY+1SxiOy3PVBjppi3KGafM9LT7B5oZS9hedn+dxvFiAsrDNexvk4MrSgsP9BF6Bj
	 93v9mxmMywu03+38kkklr+t1CnKrbiUM7i/O5vGADnrYI8nUOqE9wpWwbGphAjdVtF
	 LN/GhVd1eZxzpTpkIi0QZUlMhcBT/k0/HusumJifgJgBVlhC43+fcsr+mhaU75y88N
	 gBtu3XD+qgmgYFVST2SdC0Ve7vcvsjzhd6RkTE+DUC6Z8p8CYTdDO/3Dlx38Z7wpzC
	 BUOUkXiNQZL0C4LAZGpwhbeeUv9nNkr95FQcxruhccdr3cXBpQyU7bUla2kTa3mI9S
	 NaGb68yUnSeuA==
Date: Sun, 29 Sep 2024 12:28:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 06/10] iio: backend: adi-axi-dac: extend features
Message-ID: <20240929122842.21ffc59e@jic23-huawei>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-6-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-6-a17b9b3d05d9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 11:20:02 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Extend AXI-DAC backend with new features required to interface
> to the ad3552r DAC. Mainly, a new compatible string is added to
> support the ad3552r-axi DAC IP, very similar to the generic DAC
> IP but with some customizations to work with the ad3552r.
> 
> Then, a serie of generic functions has been added to match with
> ad3552r needs. Function names has been kept generic as much as
> possible, to allow re-utilization from other frontend drivers.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Hi Angelo,

A few things in addition to Nuno's review.

> ---
>  drivers/iio/dac/adi-axi-dac.c | 274 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 265 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index b8b4171b8043..3ca3a14c575b 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -44,11 +44,34 @@
>  #define   AXI_DAC_RSTN_MMCM_RSTN	BIT(1)
>  #define   AXI_DAC_RSTN_RSTN		BIT(0)
>  #define AXI_DAC_REG_CNTRL_1		0x0044
> +#define   AXI_DAC_EXT_SYNC_ARM		BIT(1)
> +#define   AXI_DAC_EXT_SYNC_DISARM	BIT(2)

Probably want some sort of order in here!  Either do highest
to lowest bit or the other way around. Not a mixture.
I should probably have moaned about this earlier, but naming these
defines to make it clear what is the register address and which
fields belong to that register.  Right now that's not easy to tell
for most of these and means that more effort is needed in review
to check values are written to the relevant register and not some
other one.

Perhaps a precursor patch to clean that up would be a good idea.
(or do it right for the new stuff and chase this with a patch tidying
up the existing registers).

The exisint defines seem to have _REG_ in the middle which sort
of does this role but then the fields are not associated with the
register.

E.g. this one should be something like
#define    AXI_DAC_FIELD_CNTRL_1_EXT_SYNC_ARM	BIT(1)

More common would be to move _REG_ to the end and then just
have fields as the ones that aren't _REG

>  #define   AXI_DAC_SYNC			BIT(0)
>  #define AXI_DAC_REG_CNTRL_2		0x0048
> +#define   AXI_DAC_SDR_DDR_N		BIT(16)
> +#define   AXI_DAC_SYMB_8B		BIT(14)
>  #define	  ADI_DAC_R1_MODE		BIT(5)

Oddity of tabs vs spaces here that should be consistent.

> +#define   AXI_DAC_UNSIGNED_DATA		BIT(4)
> +#define AXI_DAC_REG_STATUS_1		0x54
> +#define AXI_DAC_REG_STATUS_2		0x58
>  #define AXI_DAC_DRP_STATUS		0x0074
>  #define   AXI_DAC_DRP_LOCKED		BIT(17)
> +#define AXI_DAC_CNTRL_DATA_RD		0x0080

Prior cases have _REG_ for the registers, this one doesn't.

> +#define   AXI_DAC_DATA_RD_8		GENMASK(7, 0)
> +#define   AXI_DAC_DATA_RD_16		GENMASK(15, 0)
> +#define AXI_DAC_CNTRL_DATA_WR		0x0084
> +#define   AXI_DAC_DATA_WR_8		GENMASK(23, 16)
> +#define   AXI_DAC_DATA_WR_16		GENMASK(23, 8)

Huh. interesting IP, it's aligned one way for read path and the opposite
for write. I bet that never introduces any bugs :)
I'd started commenting the DATA_RD cases seemed obvious enough not
to need defines before I read on a few lines!

> +#define AXI_DAC_UI_STATUS		0x0088
> +#define   AXI_DAC_BUSY			BIT(4)
> +#define AXI_DAC_REG_CUSTOM_CTRL		0x008C
> +#define   AXI_DAC_ADDRESS		GENMASK(31, 24)
> +#define   AXI_DAC_SYNCED_TRANSFER	BIT(2)
> +#define   AXI_DAC_STREAM		BIT(1)
> +#define   AXI_DAC_TRANSFER_DATA		BIT(0)


> +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg,
> +				 unsigned int val, size_t data_size)
> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +
> +	switch (st->info->bus_type) {
> +	case AXI_DAC_BUS_TYPE_DDR_QSPI: {
> +		int ret;
> +		u32 ival;
> +
> +		if (data_size == 2)
> +			ival = FIELD_PREP(AXI_DAC_DATA_WR_16, val);
> +		else
> +			ival = FIELD_PREP(AXI_DAC_DATA_WR_8, val);
> +
> +		ret = regmap_write(st->regmap, AXI_DAC_CNTRL_DATA_WR, ival);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
> +		 * the data size. So keeping data size control here only,
> +		 * since data size is mandatory for the current transfer.
> +		 * DDR state handled separately by specific backend calls,
> +		 * generally all raw register writes are SDR.
> +		 */
> +		if (data_size == 1)
> +			ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +					      AXI_DAC_SYMB_8B);
> +		else
> +			ret = regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
> +						AXI_DAC_SYMB_8B);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +					 AXI_DAC_ADDRESS,
> +					 FIELD_PREP(AXI_DAC_ADDRESS, reg));
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +					 AXI_DAC_TRANSFER_DATA,
> +					 AXI_DAC_TRANSFER_DATA);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(st->regmap,
> +					       AXI_DAC_REG_CUSTOM_CTRL, ival,
> +					       ival & AXI_DAC_TRANSFER_DATA,
> +					       10, 100 * KILO);
> +		if (ret)
> +			return ret;
> +
> +		return regmap_clear_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> +					  AXI_DAC_TRANSFER_DATA);
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg,
> +				unsigned int *val, size_t data_size)
> +{
> +	struct axi_dac_state *st = iio_backend_get_priv(back);
> +
> +	switch (st->info->bus_type) {
> +	case AXI_DAC_BUS_TYPE_DDR_QSPI: {
> +		int ret;
> +		u32 bval;
> +
> +		ret = axi_dac_bus_reg_write(back, AXI_DAC_RD_ADDR(reg), 0,
> +					    data_size);
> +		if (ret)

So the data size is in the write of the register not the read. That seems odd.
I guess this is about setting the bit that says how bit the read is going to be?
Maybe a comment would help here.


> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS,
> +					       bval, bval != AXI_DAC_BUSY,
> +					       10, 100);
> +		if (ret)
> +			return ret;
> +
> +		return regmap_read(st->regmap, AXI_DAC_CNTRL_DATA_RD, val);
I supposed datasize doesn't strictly matter here, but for ease of readability
I'd do FIELD_GET() to pull out only what was requested.

> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static const struct iio_backend_ops axi_dac_generic_ops = {
>  	.enable = axi_dac_enable,
>  	.disable = axi_dac_disable,
> +	.read_raw = axi_dac_read_raw,
>  	.request_buffer = axi_dac_request_buffer,
>  	.free_buffer = axi_dac_free_buffer,
>  	.extend_chan_spec = axi_dac_extend_chan,
> @@ -528,6 +768,14 @@ static const struct iio_backend_ops axi_dac_generic_ops = {
>  	.ext_info_get = axi_dac_ext_info_get,
>  	.data_source_set = axi_dac_data_source_set,
>  	.set_sample_rate = axi_dac_set_sample_rate,
> +	.ext_sync_enable = axi_dac_ext_sync_enable,
> +	.ext_sync_disable = axi_dac_ext_sync_disable,
> +	.ddr_enable = axi_dac_ddr_enable,
> +	.ddr_disable = axi_dac_ddr_disable,
> +	.buffer_enable = axi_dac_buffer_enable,
> +	.buffer_disable = axi_dac_buffer_disable,
> +	.data_format_set = axi_dac_data_format_set,
> +	.data_transfer_addr = axi_dac_data_transfer_addr,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_dac_reg_access),
>  };
>  
> @@ -545,7 +793,6 @@ static const struct regmap_config axi_dac_regmap_config = {
>  
>  static int axi_dac_probe(struct platform_device *pdev)
>  {
> -	const unsigned int *expected_ver;
>  	struct axi_dac_state *st;
>  	void __iomem *base;
>  	unsigned int ver;
> @@ -556,8 +803,8 @@ static int axi_dac_probe(struct platform_device *pdev)
>  	if (!st)
>  		return -ENOMEM;
>  
> -	expected_ver = device_get_match_data(&pdev->dev);
> -	if (!expected_ver)
> +	st->info = device_get_match_data(&pdev->dev);
> +	if (!st->info)
>  		return -ENODEV;
>  
>  	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> @@ -588,12 +835,13 @@ static int axi_dac_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
> +	if (ADI_AXI_PCORE_VER_MAJOR(ver) !=
> +		ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
>  		dev_err(&pdev->dev,
>  			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
> -			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
> -			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
> -			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
> +			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
> +			ADI_AXI_PCORE_VER_MINOR(st->info->version),
> +			ADI_AXI_PCORE_VER_PATCH(st->info->version),
>  			ADI_AXI_PCORE_VER_MAJOR(ver),
>  			ADI_AXI_PCORE_VER_MINOR(ver),
>  			ADI_AXI_PCORE_VER_PATCH(ver));
> @@ -631,10 +879,18 @@ static int axi_dac_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static unsigned int axi_dac_9_1_b_info = ADI_AXI_PCORE_VER(9, 1, 'b');
> +static const struct axi_dac_info dac_generic = {
> +	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
> +};
> +
> +static const struct axi_dac_info dac_ad3552r = {
> +	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
> +	.bus_type = AXI_DAC_BUS_TYPE_DDR_QSPI,
> +};
>  
>  static const struct of_device_id axi_dac_of_match[] = {
> -	{ .compatible = "adi,axi-dac-9.1.b", .data = &axi_dac_9_1_b_info },
> +	{ .compatible = "adi,axi-dac-9.1.b", .data = &dac_generic },
> +	{ .compatible = "adi,axi-ad3552r", .data = &dac_ad3552r },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, axi_dac_of_match);
> 


