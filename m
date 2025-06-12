Return-Path: <linux-iio+bounces-20576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7391CAD7F3D
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 01:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50873B9DFF
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 23:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8C2E3386;
	Thu, 12 Jun 2025 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rh4BNFVB"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24792E2F1D
	for <linux-iio@vger.kernel.org>; Thu, 12 Jun 2025 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749771869; cv=none; b=sUHnossfBtZWLSSyLwQL5BAoqRGTM0WadhygDlGBin8SjIUubMiuJaXqk4vOgeOVIB+Vj47LP1bc7Pff6Q1419/f8D+MoEhUyqpqP3PcdK2Bd2K0Y/VQ+27OhteoBoz3mdXyJfsbLRvabaNqKcduJiGNb4yNXrwk/4gKworfeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749771869; c=relaxed/simple;
	bh=5JzILznrMxvVRQxf8Hqsu5zni/A7Rt4O3iDHv8KHbJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ak0G/2/S2mERPQE98georLLiFMD6xY1xolXI8Hi7B1KJvh9skk8q9FZynOwMRnxpabGV64hHpbzkBLNLrWk2wKnY3y+YLYSfox0TPqVFlZiDBiJSGtjtUxhr1W17Q0kZ7dr37jrOYzGHWJci1/NkMLSUtLuFfdDWAYOwQ4+BRj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rh4BNFVB; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dbe26b36-a10c-4afb-88ad-a6f7f9bff440@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749771854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8t46q3qqq58O3Iozg3ZVMZkLga+rVEXppYIQU8pZTR0=;
	b=Rh4BNFVBqPKyzkGEg0VtlBVcGVma+gqZgIWAUmqAsAdlmzUPABYeGR+rU4K4DFugaPTDCH
	DTvJ0F/BqKuCcM4tgryjopxwu4S87qgFaOcDxAPnhq/TXQ/UAx21rrv7j0uKhy9+F+HcWa
	havTzu7j2MGZIk2vEYr+o91l1q0qADY=
Date: Thu, 12 Jun 2025 19:44:09 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] dt-bindings: spi: zynqmp-qspi: Split the bus
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
 <20250116232118.2694169-2-sean.anderson@linux.dev>
 <9f40295b-484a-48e8-b053-ff8550e589d7@baylibre.com>
 <46a7eba6-a705-4543-b967-e83ccc89e7d4@linux.dev>
 <6afc379a-2f9f-4462-ae30-ef6945a83236@baylibre.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <6afc379a-2f9f-4462-ae30-ef6945a83236@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi David,

I am (finally!) getting around to doing v2 of this series, and I ran
into a small problem with your proposed solution.

On 1/23/25 16:59, David Lechner wrote:
> ---
> From: David Lechner <dlechner@baylibre.com>
> Date: Thu, 23 Jan 2025 15:35:19 -0600
> Subject: [PATCH 2/2] spi: add support for multi-bus controllers
> 
> Add support for SPI controllers with multiple physical SPI buses.
> 
> This is common in the type of controller that can be used with parallel
> flash memories, but can be used for general purpose SPI as well.
> 
> To indicate support, a controller just needs to set ctlr->num_buses to
> something greater than 1. Peripherals indicate which bus they are
> connected to via device tree (ACPI support can be added if needed).
> 
> In the future, this can be extended to support peripherals that also
> have multiple SPI buses to use those buses at the same time by adding
> a similar bus flags field to struct spi_transfer.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/spi/spi.c       | 26 +++++++++++++++++++++++++-
>  include/linux/spi/spi.h | 13 +++++++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 10c365e9100a..f7722e5e906d 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2364,7 +2364,7 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
>  static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  			   struct device_node *nc)
>  {
> -	u32 value, cs[SPI_CS_CNT_MAX];
> +	u32 value, buses[8], cs[SPI_CS_CNT_MAX];
>  	int rc, idx;
>  
>  	/* Mode (clock phase/polarity/etc.) */
> @@ -2379,6 +2379,29 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  	if (of_property_read_bool(nc, "spi-cs-high"))
>  		spi->mode |= SPI_CS_HIGH;
>  
> +	rc = of_property_read_variable_u32_array(nc, "spi-buses", buses, 1,
> +						 ARRAY_SIZE(buses));
> +	if (rc < 0 && rc != -EINVAL) {
> +		dev_err(&ctlr->dev, "%pOF has invalid 'spi-buses' property (%d)\n",
> +			nc, rc);
> +		return rc;
> +	}
> +
> +	if (rc == -EINVAL) {
> +		/* Default when property is omitted. */
> +		spi->buses = BIT(0);

For backwards compatibility, the default bus for CS 1 on gqspi must be 1
and not 0. Ideally there would be some hook for the master to fix things
up when the slaves are probed, but that doesn't seem to exist. I was
thinking about doing this with OF changesets. Do you have any better
ideas?

--Sean

> +	} else {
> +		for (idx = 0; idx < rc; idx++) {
> +			if (buses[idx] >= ctlr->num_buses) {
> +				dev_err(&ctlr->dev,
> +					"%pOF has out of range 'spi-buses' property (%d)\n",
> +					nc, buses[idx]);
> +				return -EINVAL;
> +			}
> +			spi->buses |= BIT(buses[idx]);
> +		}
> +	}
> +
>  	/* Device DUAL/QUAD mode */
>  	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
>  		switch (value) {
> @@ -3072,6 +3095,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
>  	mutex_init(&ctlr->add_lock);
>  	ctlr->bus_num = -1;
>  	ctlr->num_chipselect = 1;
> +	ctlr->num_buses = 1;
>  	ctlr->slave = slave;
>  	if (IS_ENABLED(CONFIG_SPI_SLAVE) && slave)
>  		ctlr->dev.class = &spi_slave_class;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 4c087009cf97..bc45d70e8c45 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -187,6 +187,11 @@ struct spi_device {
>  	struct device		dev;
>  	struct spi_controller	*controller;
>  	u32			max_speed_hz;
> +	/*
> +	 * Bit flags indicating which buses this device is connected to. Only
> +	 * applicable to multi-bus controllers.
> +	 */
> +	u8 			buses;
>  	u8			chip_select[SPI_CS_CNT_MAX];
>  	u8			bits_per_word;
>  	bool			rt;
> @@ -570,6 +575,14 @@ struct spi_controller {
>  	 */
>  	u16			num_chipselect;
>  
> +	/*
> +	 * Some specialized SPI controllers can have more than one physical
> +	 * bus interface per controller. This specifies the number of buses
> +	 * in that case. Other controllers do not need to set this (defaults
> +	 * to 1).
> +	 */
> +	u16			num_buses;
> +
>  	/* Some SPI controllers pose alignment requirements on DMAable
>  	 * buffers; let protocol drivers know about these requirements.
>  	 */
> -- 
> 2.43.0
> 
> 
> 

