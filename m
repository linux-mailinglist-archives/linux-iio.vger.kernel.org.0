Return-Path: <linux-iio+bounces-25925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF3C377EF
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 20:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209B618C7822
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CCF340DA0;
	Wed,  5 Nov 2025 19:34:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72B34217C;
	Wed,  5 Nov 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371254; cv=none; b=AqQvu8RaFRmYg0MpFbtmM1RV1Y6ulJr8Dl3vqFbn5ho90RBnm40zru/I6OPJmeXL8x68pe2MUSJRedVLqzCPvbLGNzt3CvVUcEbRifs7Ai6RfqtWBBbJ38p6wLBt7m9DADBmQ0QCA6r09cdHboqSIMHE+Ibkptv8C0avxTdTKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371254; c=relaxed/simple;
	bh=J/KAxoGK17iIaiAlXrD98N4ca3o6DuDjfIxl6h49p1I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9Vr5n6RhulohjyuBrulTyzgE82MiyCC/qyNZYSXZVd/sQ2DYW4aXpWRcYgcO+PpxkyP4XVvraHxukOcVv5rHwQ/viqvzHR87jx3Cq/3yZbKyZdxc6C+Tb01SyOGPsOlXjEPr82GPBp0FimxrXGf2fIqHGjF11l7y3/qGiYWaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1wVc17V2zHnGh0;
	Thu,  6 Nov 2025 03:34:00 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 03D02140370;
	Thu,  6 Nov 2025 03:34:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 19:34:05 +0000
Date: Wed, 5 Nov 2025 19:34:03 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	David Jander <david@protonic.nl>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <20251105193403.000026fe@huawei.com>
In-Reply-To: <20251105143814.1807444-3-o.rempel@pengutronix.de>
References: <20251105143814.1807444-1-o.rempel@pengutronix.de>
	<20251105143814.1807444-3-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 5 Nov 2025 15:38:14 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> From: David Jander <david@protonic.nl>
> 
> Add a new IIO ADC driver for Texas Instruments ADS131M0x devices
> (ADS131M02/03/04/06/08). These are 24-bit, up to 64 kSPS, simultaneous-
> sampling delta-sigma ADCs accessed via SPI.
> 
> Highlights:
> - Supports 2/3/4/6/8-channel variants with per-channel RAW and SCALE.
> - Implements device-required full-duplex fixed-frame transfers.
> - Handles both input and output CRC; uses a non-reflected CCITT (0x1021)
>   implementation because the generic crc_ccitt helper is incompatible.
> 
> Note: Despite the almost identical name, this hardware is not
> compatible with the ADS131E0x series handled by
> drivers/iio/adc/ti-ads131e08.c.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Hi Oleksij, David,

Various comments inline.

Jonathan

> diff --git a/drivers/iio/adc/ti-ads131m0x.c b/drivers/iio/adc/ti-ads131m0x.c
> new file mode 100644
> index 000000000000..d40aacc129ba
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads131m0x.c
> @@ -0,0 +1,886 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Texas Instruments ADS131M0x family ADC chips.
> + *
> + * Copyright (C) 2024 Protonic Holland
> + * Copyright (C) 2025 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> + *
> + * Primary Datasheet Reference (used for citations):
> + * ADS131M08 8-Channel, Simultaneously-Sampling, 24-Bit, Delta-Sigma ADC
> + * Document SBAS950B, Revised February 2021
> + * https://www.ti.com/lit/ds/symlink/ads131m08.pdf
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

I guess here for of_match_ptr() which I suggest you drop. Then this include
isn't needed.

> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +
> +/* Max channels supported by the largest variant in the family (ADS131M08) */
> +#define ADS131M_MAX_CHANNELS		8
> +
> +/* ADS131M08 tolerates up to 25 MHz SCLK.
> + */
> +#define ADS131M_MAX_SCLK_HZ		25000000
> +
> +/* Section 6.7, t_REGACQ (min time after reset) is 5us */
> +#define ADS131M_RESET_DELAY_US		10
> +
> +/*
> + * SPI Frame word count calculation.
> + * Frame = N channel words + 1 response word + 1 CRC word.
> + * Word size depends on WLENGTH bits in MODE register (Default 24-bit).
> + */
> +#define ADS131M_FRAME_WSIZE(nch)	(nch + 2)
Similar to case below ((nch) + 2) prefererd.

> +/*
> + * Index calculation for the start byte of channel 'x' data within the RX buffer.
> + * Assumes 24-bit words (3 bytes per word).
> + * The received frame starts with the response word (e.g., STATUS register
> + * content when NULL command was sent), followed by data for channels 0 to N-1,
> + * and finally the output CRC word.
> + * Response = index 0..2, Chan0 = index 3..5, Chan1 = index 6..8, ...
> + * Index for ChanX = 3 (response) + x * 3 (channel data size).
> + */
> +#define ADS131M_CHANNEL_INDEX(x)	(x * 3 + 3)
((x) * 3 + 3)
to avoid having to check carefully for odd things being passed as x and
precedence issues that might result.



> +enum ads131m_device_id {
> +	ADS131M08_ID,
> +	ADS131M06_ID,
> +	ADS131M04_ID,
> +	ADS131M03_ID,
> +	ADS131M02_ID,
reverse order.
> +};
> +
> +struct ads131m_priv {
> +	struct spi_device *spi;
> +	struct clk *clk;
> +	struct mutex lock;

Lock should have a commment describing what data it protects.
Looks like internal state during rmw sequences. Maybe other stuff?

> +	u8 num_channels;
> +	const struct ads131m_configuration *config;
> +	u8 tx_buffer[ADS131M_FRAME_BSIZE(ADS131M_MAX_CHANNELS)]
> +		__aligned(IIO_DMA_MINALIGN);
> +	u8 rx_buffer[ADS131M_FRAME_BSIZE(ADS131M_MAX_CHANNELS)]
> +		__aligned(IIO_DMA_MINALIGN);
> +	struct spi_transfer xfer[1];
> +	struct spi_message msg;
> +	unsigned int gain[ADS131M_MAX_CHANNELS];
> +};

> +
> +/**
> + * ads131m_tx_frame_unlocked - Sends a command frame with Input CRC
> + * @priv: Device private data structure.
> + * @command: The 16-bit command to send (e.g., NULL, RREG, RESET).
> + *
> + * Assumes the mutex lock is held.
> + * This function sends a command in Word 0, and its calculated 16-bit
> + * CRC in Word 1, as required when Input CRC is enabled.
> + *
> + * Return: 0 on success, or a negative error code from spi_sync.
> + */
> +static int ads131m_tx_frame_unlocked(struct ads131m_priv *priv, u32 command)
> +{
> +	int ret;
> +	u16 crc;
> +
> +	/*
> +	 * Zero the entire TX buffer to send a valid frame.

Single line comments where it fits give shorter overall driver
and more on a screen at time (important for those of us who have
less than perfect eyesight!)

> +	 */
> +	memset(priv->tx_buffer, 0, ADS131M_FRAME_BSIZE(priv->num_channels));
> +
> +	/*
> +	 * Word 0: 16-bit command, MSB-aligned in 24-bit word.
> +	 */
> +	put_unaligned_be24(command << 8, &priv->tx_buffer[0]);
Similar to below. Smells like it should be a 16bit write to the correct location.

> +
> +	/*
> +	 * Word 1: Input CRC
> +	 * Calculated over the 3 bytes of Word 0.
> +	 */
> +	crc = ads131m_crc_calculate(priv->tx_buffer, 3);
> +	put_unaligned_be24(crc << 8, &priv->tx_buffer[3]);
likewise.

> +
> +	return spi_sync(priv->spi, &priv->msg);
> +}
> +
> +/**
> + * ads131m_rx_frame_unlocked - Receives a full SPI data frame.
> + * @priv: Device private data structure.
> + *
> + * This function sends a NULL command (with its CRC) to clock out a
> + * full SPI frame from the device (e.g., response + channel data + CRC).
> + *
> + * Assumes the mutex lock is held.

Can use a lockdep assert to make this explicit in code and drop
the comment.

> + *
> + * Return: 0 on success, or a negative error code from spi_sync.
> + */
> +static int ads131m_rx_frame_unlocked(struct ads131m_priv *priv)
> +{
> +	return ads131m_tx_frame_unlocked(priv, ADS131M_CMD_NULL);
> +}
> +
> +/**
> + * ads131m_check_status_crc_err - Checks for an Input CRC error.
> + * @priv: Device private data structure.
> + *
> + * Sends a NULL command to fetch the STATUS register and checks the
> + * CRC_ERR bit. This is used to verify the integrity of the previous
> + * command (like RREG or WREG).
> + *
> + * Context: This function assumes the mutex 'lock' is held.
> + * Return: 0 on success, -EIO if CRC_ERR bit is set.
> + */
> +static int ads131m_check_status_crc_err(struct ads131m_priv *priv)
> +{
> +	int ret;
> +	u16 status;
> +
> +	ret = ads131m_rx_frame_unlocked(priv);
> +	if (ret < 0) {
> +		dev_err(&priv->spi->dev, "SPI error on STATUS read for CRC check\n");

Local dev variable useful here.

> +		return ret;
> +	}
> +
> +	status = get_unaligned_be16(&priv->rx_buffer[0]);
> +	if (status & ADS131M_STATUS_CRC_ERR) {
> +		dev_err(&priv->spi->dev, "Previous input CRC error, STATUS=0x%04x\n",
> +			status);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ads131m_write_reg_unlocked - Writes a single register and verifies the ACK.
> + * @priv: Device private data structure.
> + * @reg: The 8-bit register address.
> + * @val: The 16-bit value to write.
> + *
> + * This function performs the full 3-cycle WREG operation with Input CRC:
> + * 1. (Cycle 1) Sends WREG command, data, and its calculated CRC.
> + * 2. (Cycle 2) Sends NULL+CRC to retrieve the response from Cycle 1.
> + * 3. Verifies the response is the correct ACK for the WREG.
> + * 4. (Cycle 3) Sends NULL+CRC to retrieve STATUS and check for CRC_ERR.
> + *
> + * Assumes the mutex lock is held.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_write_reg_unlocked(struct ads131m_priv *priv, u8 reg,
> +				      u16 val)
> +{
> +	u16 command, expected_ack, response, crc;
> +	int ret;
> +
> +	command = ADS131M_CMD_WREG(reg, 0); /* n=0 for 1 register */
n = 0
> +	/*
> +	 * Per Table 8-11, WREG response is: 010a aaaa ammm mmmm
> +	 * For 1 reg (n=0 -> m=0): 010a aaaa a000 0000 = 0x4000 | (reg << 7)

n = 0 -> m = 0
Slightly long line is fine.
I'd format all these comments along those lines.


> +	 */
> +	expected_ack = 0x4000 | (reg << 7);
> +
> +	/*
> +	 * Cycle 1: Send WREG Command + Data + Input CRC
> +	 */
> +
> +	/* Zero the entire TX buffer */
> +	memset(priv->tx_buffer, 0, ADS131M_FRAME_BSIZE(priv->num_channels));
> +
> +	/* Word 0: WREG command, 1 reg (n=0), MSB-aligned */
> +	put_unaligned_be24(command << 8, &priv->tx_buffer[0]);
That shift makes me thing this is better represented as
	put_unaligned_be16(command, &priv->tx_buffer[0]);
	//gap but it's zero so no problem.
	put_unaligned_be16(val, &priv->tx_buffer[3]);
	//gap here as well, also zero currently.
> +
> +	/* Word 1: Data, MSB-aligned */
The msb aligned seems obvious.
> +	put_unaligned_be24(val << 8, &priv->tx_buffer[3]);
> +
> +	/*
> +	 * Word 2: Input CRC
> +	 * Calculated over Word 0 (Cmd) and Word 1 (Data).
> +	 */
> +	crc = ads131m_crc_calculate(priv->tx_buffer, 6);
> +	put_unaligned_be24(crc << 8, &priv->tx_buffer[6]);
	put_unaligned_be16(crc, &priv->tx_buffer[6]);
and another gap after this.

> +
> +	/* We ignore the RX buffer (it's from the *previous* command) */
Prefer imperative for documentation.
	/* Ignore the RX buffer  ...

> +	ret = spi_sync(priv->spi, &priv->msg);
> +

Drop this blank line.

> +	if (ret < 0) {
> +		dev_err(&priv->spi->dev, "SPI error on WREG (cycle 1)\n");

Worth a local variable for this function.
	struct device *dev = &priv->spi->dev;

> +		goto write_err;
> +	}
> +
> +	/*
> +	 * Cycle 2: Send NULL Command to get the WREG response
> +	 */
> +	ret = ads131m_rx_frame_unlocked(priv);
> +	if (ret < 0) {
> +		dev_err(&priv->spi->dev, "SPI error on WREG ACK (cycle 2)\n");
> +		goto write_err;
> +	}
> +
> +	/*
> +	 * Response is in the first 2 bytes of the RX buffer
> +	 * (MSB-aligned 16-bit response)
> +	 */
> +	response = get_unaligned_be16(&priv->rx_buffer[0]);
> +
> +	if (response != expected_ack) {
> +		dev_err(&priv->spi->dev,
> +			"WREG(0x%02x) failed, expected ACK 0x%04x, got 0x%04x\n",
> +			reg, expected_ack, response);
> +		ret = -EIO;
> +		/*
> +		 * Don't unlock yet, still need to do Cycle 3 to clear
> +		 * any potential CRC_ERR flag from this failed command.
> +		 */
> +	} else {
> +		dev_dbg(&priv->spi->dev, "WREG(0x%02x) ACK 0x%04x OK\n",
> +			reg, response);
> +	}
> +
> +	/*
> +	 * Cycle 3: Check STATUS for Input CRC error.
> +	 * This is necessary even if ACK was wrong, to clear the CRC_ERR flag.
> +	 */
> +	if (ads131m_check_status_crc_err(priv) < 0)
> +		ret = -EIO;
> +
> +write_err:
As below. Early return preferred. It's easier to read in simple functions like
this as we can immediately see no cleanup is happening in those error paths
(so nothing to check!)

> +	return ret;
> +}
> +
> +/**
> + * ads131m_read_reg_unlocked - Reads a single register from the device.
> + * @priv: Device private data structure.
> + * @reg: The 8-bit register address.
> + * @val: Pointer to store the 16-bit register value.
> + *
> + * This function performs the full 3-cycle RREG operation with Input CRC:
> + * 1. (Cycle 1) Sends the RREG command + Input CRC.
> + * 2. (Cycle 2) Sends NULL+CRC to retrieve the register data.
> + * 3. (Cycle 3) Sends NULL+CRC to retrieve STATUS and check for CRC_ERR.
> + *
> + * Assumes the mutex lock is held.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_read_reg_unlocked(struct ads131m_priv *priv, u8 reg, u16 *val)
> +{
> +	u16 command;
> +	int ret;
> +
> +	command = ADS131M_CMD_RREG(reg, 0); /* n=0 for 1 register */
n = 0
Might as well keep comments to kernel coding style too as helps readability.

> +
> +	/*
> +	 * Cycle 1: Send RREG Command + Input CRC
> +	 * We ignore the RX buffer (it's from the previous command).
> +	 */
> +	ret = ads131m_tx_frame_unlocked(priv, command);
> +	if (ret < 0) {
> +		dev_err(&priv->spi->dev, "SPI error on RREG (cycle 1)\n");
> +		goto read_err;
> +	}
> +
> +	/*
> +	 * Cycle 2: Send NULL Command to get the register data
> +	 */
> +	ret = ads131m_rx_frame_unlocked(priv);
> +	if (ret < 0) {
> +		dev_err(&priv->spi->dev, "SPI error on RREG data (cycle 2)\n");
> +		goto read_err;
> +	}
> +
> +	/*
> +	 * Per datasheet, for a single reg read, the response is the data.
> +	 * It's in the first 2 bytes of the RX buffer (MSB-aligned 16-bit).
> +	 */
> +	*val = get_unaligned_be16(&priv->rx_buffer[0]);
> +
> +	dev_dbg(&priv->spi->dev, "RREG(0x%02x) = 0x%04x\n", reg, *val);
> +
> +	/*
> +	 * Cycle 3: Check STATUS for Input CRC error.
> +	 * The RREG command does not execute if CRC is bad, but we read
> +	 * STATUS anyway to clear the flag in case it was set.
> +	 */
> +	if (ads131m_check_status_crc_err(priv) < 0)
> +		ret = -EIO;
> +
> +read_err:
> +	return ret;

Return early on error and drop this (or at least make it return 0 always)

> +}
> +
> +/**
> + * ads131m_rmw_reg - Reads, modifies, and writes a single register.
> + * @priv: Device private data structure.
> + * @reg: The 8-bit register address.
> + * @clear: Bitmask of bits to clear.
> + * @set: Bitmask of bits to set.
> + *
> + * This function performs an atomic read-modify-write operation on a register.
> + * It reads the register, applies the clear and set masks, and writes
> + * the new value back if it has changed.
> + *
> + * Context: This function handles its own mutex locking
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_rmw_reg(struct ads131m_priv *priv, u8 reg, u16 clear,
> +			   u16 set)
> +{
> +	u16 old_val, new_val;
> +	int ret = 0;
Always set before use - don't init.
> +
> +	mutex_lock(&priv->lock);

As below. Use guard() and early returns on error.


> +
> +	ret = ads131m_read_reg_unlocked(priv, reg, &old_val);
> +	if (ret < 0)
> +		goto rmw_unlock;
> +
> +	new_val = (old_val & ~clear) | set;
> +
> +	if (new_val == old_val)
> +		goto rmw_unlock;
> +
> +	ret = ads131m_write_reg_unlocked(priv, reg, new_val);
> +
> +rmw_unlock:
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}

> +
> +/**
> + * ads131m_adc_read - Reads channel data, checks input and output CRCs.
> + * @priv: Device private data structure.
> + * @channel: The channel number to read.
> + * @val: Pointer to store the raw 24-bit value.
> + *
> + * This function sends a NULL command (with Input CRC) to retrieve data.
> + * It checks the received STATUS word for any Input CRC errors from the
> + * previous command, and then verifies the Output CRC of the current
> + * data frame.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_adc_read(struct ads131m_priv *priv, u8 channel, s32 *val)
> +{
> +	int ret;
> +	u8 *buf;
> +	u16 status;
> +
> +	mutex_lock(&priv->lock);

guard(mutex)(&priv->lock); Then no need to unlock in any paths.

> +
> +	/* Send NULL command + Input CRC, and receive data frame */
> +	ret = ads131m_rx_frame_unlocked(priv);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Check STATUS word (Word 0) for an Input CRC Error from the
> +	 * previous SPI frame.
> +	 */
> +	status = get_unaligned_be16(&priv->rx_buffer[0]);
> +	if (status & ADS131M_STATUS_CRC_ERR) {
> +		dev_err_ratelimited(&priv->spi->dev,
> +				    "Previous input CRC Error reported in STATUS (0x%04x)\n",
> +				    status);
> +	}
> +
> +	/*
> +	 * Validate the output CRC on the current data frame to ensure
> +	 * data integrity.
> +	 */
> +	ret = ads131m_verify_output_crc(priv);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +
> +	buf = &priv->rx_buffer[ADS131M_CHANNEL_INDEX(channel)];
> +	*val = sign_extend32(get_unaligned_be24(buf), 23);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}


> +
> +static const struct ads131m_configuration ads131m_config[] = {
> +	[ADS131M08_ID] = {
We used to do this enum and array approach a lot, but it doesn't scale
particularly well and leaves an enum around people tend to abuse to
do thing sin code that belong as data.

As such, modern preference in IIO is separate named structures
static const struct ads131m_configuration ads131m08_config = {
};

etc

> +		.channels = ads131m08_channels,
> +		.num_channels = ARRAY_SIZE(ads131m08_channels),
> +		.reset_ack = 0xFF28,
> +	},
> +	[ADS131M06_ID] = {
> +		.channels = ads131m06_channels,
> +		.num_channels = ARRAY_SIZE(ads131m06_channels),
> +		.reset_ack = 0xFF26,
> +	},
> +	[ADS131M04_ID] = {
> +		.channels = ads131m04_channels,
> +		.num_channels = ARRAY_SIZE(ads131m04_channels),
> +		.reset_ack = 0xFF24,
> +	},
> +	[ADS131M03_ID] = {
> +		.channels = ads131m03_channels,
> +		.num_channels = ARRAY_SIZE(ads131m03_channels),
> +		.reset_ack = 0xFF23,
> +	},
> +	[ADS131M02_ID] = {
> +		.channels = ads131m02_channels,
> +		.num_channels = ARRAY_SIZE(ads131m02_channels),
> +		.reset_ack = 0xFF22,
> +	},
> +};

> +/*
> + * Prepares the reusable SPI message structure for a full-duplex transfer.
> + * The ADS131M requires sending a command frame while simultaneously
> + * receiving the response/data frame from the previous command cycle.
> + *
> + * This message is optimized for the primary data acquisition workflow:
> + * sending a single-word command (like NULL) and receiving a full data
> + * frame (Response + N*Channels + CRC).
> + *
> + * This pre-configured message is NOT suitable for variable-length SPI
> + * transactions (e.g., multi-word WREG or multi-response RREG),
> + * which would require a separate, dynamically-sized spi_message.
> + */
> +static void ads131m_prepare_message(struct ads131m_priv *priv)
> +{
> +	priv->xfer[0].tx_buf = &priv->tx_buffer[0];
> +	priv->xfer[0].rx_buf = &priv->rx_buffer[0];
> +	priv->xfer[0].len = ADS131M_FRAME_BSIZE(priv->num_channels);
> +	spi_message_init_with_transfers(&priv->msg, &priv->xfer[0], 1);

Consider doing devm_spi_optimize_message() to reduce the overheads of
this particular message further.

> +}

> +
> +/**
> + * ads131m_soft_reset - Issues a software RESET and verifies ACK.
> + * @priv: Device private data structure.
> + *
> + * This function sends a RESET command (with Input CRC), waits t_REGACQ,
> + * reads back the RESET ACK, and then sends a final NULL to check for
> + * any input CRC errors.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_soft_reset(struct ads131m_priv *priv)
> +{
> +	struct spi_device *spi = priv->spi;
> +	u16 response;
> +	int ret;
> +	u16 expected_ack = priv->config->reset_ack;
Pick a consistent ordering for declarations when there is no dependency
between them. I'm not spotting one here. Something like reverse xmas tree
is easy to follow.

> +
> +	mutex_lock(&priv->lock);

Include cleanup.h and
	guard(mutex)(&priv->lock);
then no need for got he got err_unlock or any manual unlocking.

> +	dev_dbg(&spi->dev, "Sending RESET command\n");

Probably not appropriate to keep this level of debug print in a
production driver.

> +	ret = ads131m_tx_frame_unlocked(priv, ADS131M_CMD_RESET);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed to send RESET command\n");
> +		goto err_unlock;

Only in probe so
		return dev_err_probe() is appropriate even in here.
same for all other cases in this function.

> +	}
> +
> +	/* Wait t_REGACQ (5us) for device to be ready after reset */
> +	usleep_range(ADS131M_RESET_DELAY_US, ADS131M_RESET_DELAY_US + 5);

fsleep(). That provides a standard 'slack' on a sleep like this.

> +
> +	/* Cycle 2: Send NULL+CRC to retrieve the response to the RESET */
> +	dev_dbg(&spi->dev, "Reading RESET ACK\n");
> +	ret = ads131m_rx_frame_unlocked(priv);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed to read RESET ACK\n");
> +		goto err_unlock;
> +	}
> +
> +	response = get_unaligned_be16(&priv->rx_buffer[0]);
> +
> +	/* Check against the device-specific ACK value */
> +	if (response != expected_ack) {
> +		dev_warn(&spi->dev, "RESET ACK mismatch, got 0x%04x, expected 0x%04x\n",
> +			 response, expected_ack);
> +		ret = -EIO;
> +		goto err_unlock;
> +	}
> +
> +	/* Cycle 3: Check STATUS for Input CRC error on the RESET command. */
> +	if (ads131m_check_status_crc_err(priv) < 0)
> +		ret = -EIO;
> +
> +err_unlock:
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
> +/**
> + * ads131m_hw_init - Initialize the ADC hardware.
> + * @priv: Device private data structure.
> + *
> + * This function performs the hardware-specific initialization sequence:
> + * 1. Enables the main clock.
> + * 2. Issues a software RESET command to clear FIFOs and defaults.
> + * 3. Configures the MODE register to clear RESET, set CCITT CRC,
> + * and enable Input CRC checking.
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +static int ads131m_hw_init(struct ads131m_priv *priv)
> +{
> +	struct spi_device *spi = priv->spi;
> +	u16 clear_mask, set_mask;
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret) {
> +		dev_err(&spi->dev, "clk enable failed: %d\n", ret);
> +		return ret;
> +	}
> +	ret = devm_add_action_or_reset(&spi->dev, ads131m_clk_disable_unprepare,
> +				       priv->clk);

As Marc pointed out just use the enabled form when getting the clock
in the first place.

> +	if (ret) {
> +		clk_disable_unprepare(priv->clk);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Issue a software RESET to ensure device is in a known state.
> +	 * This clears the 2-deep FIFO and resets all registers to default.
> +	 */
> +	ret = ads131m_soft_reset(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The RESET command sets all registers to default, which means:
> +	 * 1. The RESET bit (Bit 10) in MODE is set to '1'.
> +	 * 2. The CRC_TYPE bit (Bit 11) in MODE is '0' (CCITT).
> +	 * 3. The RX_CRC_EN bit (Bit 12) in MODE is '0' (Disabled).
> +	 *
> +	 * We must:
> +	 * 1. Clear the RESET bit.
> +	 * 2. Enable Input CRC (RX_CRC_EN).
> +	 * 3. Explicitly clear the ANSI CRC bit (for certainty).
> +	 */
> +	clear_mask = ADS131M_MODE_CRC_TYPE_ANSI | ADS131M_MODE_RESET_FLAG;
> +	set_mask = ADS131M_MODE_RX_CRC_EN;
> +
> +	ret = ads131m_rmw_reg(priv, ADS131M_REG_MODE, clear_mask, set_mask);

As below - I'd pass the iio_dev around to avoid need to duplicate any data
that is in there in priv.

> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed to configure MODE register\n");
> +		return ret;
Only called in probe, so 
		return dev_err_probe()

> +	}
> +
> +	return 0;
> +}
> +
> +static int ads131m_probe(struct spi_device *spi)
> +{
> +	const struct ads131m_configuration *config;
> +	struct iio_dev *indio_dev;
> +	struct ads131m_priv *priv;
> +	int ret;
> +
> +	spi->mode = SPI_MODE_1;

Should come from the firmware, not be specified in driver.
cpha should be set in the dt binding.

> +	spi->bits_per_word = 8;
IIRC that's the default.

> +
> +	if (!spi->max_speed_hz || spi->max_speed_hz > ADS131M_MAX_SCLK_HZ)
> +		spi->max_speed_hz = ADS131M_MAX_SCLK_HZ;

If this isn't variable, normal assumption is it is a problem for firmware
so drivers tend to not enforce max frequencies.
> +
> +	ret = spi_setup(spi);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Error in spi setup\n");
> +		return ret;

return dev_err_probe();

> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->spi = spi;
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;

Put the string in your config structure.  This path tends to end up
fragile as it depends on exactly how the firmware match was done.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ads131m_info;
> +
> +	config = device_get_match_data(&spi->dev);
> +	if (!config) {
> +		const struct spi_device_id *id;
> +
> +		id = spi_get_device_id(spi);
> +		if (!id)
> +			return -ENODEV;
> +
> +		config = (const void *)id->driver_data;

spi_get_device_match_data()

> +	}
> +	priv->config = config;
> +
> +	indio_dev->channels = config->channels;
> +	indio_dev->num_channels = config->num_channels;
> +	priv->num_channels = config->num_channels;

Why do you need another copy?  I'd just pass indio_dev
into the functions that need this and use iio_priv() to get to
the prv structure.

> +
> +	/* Get the external clock source connected to the CLKIN pin */
> +	priv->clk = devm_clk_get(&spi->dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		ret = PTR_ERR(priv->clk);
> +		dev_err(&spi->dev, "clk get failed: %d\n", ret);
> +		return ret;

		return dev_err_probe();

For all error reporting in probe.  Pretty prints the error value and
gives shorter code.  Also possible this particular call might defer
if the clock chip driver hasn't probed yet.


> +	}
> +
> +	mutex_init(&priv->lock);
	ret = devm_mutex_init(&priv->lock);
	if (ret)
		return ret;

Very small advantage for debug, but also now easy to do so we might as well.

> +	/* Setup the reusable SPI message structure */
Seems fairly obvious from function name. Probably drop this comment.

> +	ads131m_prepare_message(priv);
> +
> +	/*
> +	 * Perform all hardware-specific initialization.
> +	 */

The function name feels sufficient to convey that it is hardware init
so drop the comment.

> +	ret = ads131m_hw_init(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct of_device_id ads131m_of_match[] = {
> +	{ .compatible = "ti,ads131m08", .data = &ads131m_config[ADS131M08_ID] },
As below, reverse the ordering.

> +	{ .compatible = "ti,ads131m06", .data = &ads131m_config[ADS131M06_ID] },
> +	{ .compatible = "ti,ads131m04", .data = &ads131m_config[ADS131M04_ID] },
> +	{ .compatible = "ti,ads131m03", .data = &ads131m_config[ADS131M03_ID] },
> +	{ .compatible = "ti,ads131m02", .data = &ads131m_config[ADS131M02_ID] },
> +	{ /* sentinel */ },
	{ }
So no comma the sentinel.
> +};
> +MODULE_DEVICE_TABLE(of, ads131m_of_match);
> +
> +static const struct spi_device_id ads131m_id[] = {
> +	{ "ads131m08", (kernel_ulong_t)&ads131m_config[ADS131M08_ID] },

Normally do these in opposite order. Doesn't really matter but nice to have
a universal style so I'd prefer it that way up.

> +	{ "ads131m06", (kernel_ulong_t)&ads131m_config[ADS131M06_ID] },
> +	{ "ads131m04", (kernel_ulong_t)&ads131m_config[ADS131M04_ID] },
> +	{ "ads131m03", (kernel_ulong_t)&ads131m_config[ADS131M03_ID] },
> +	{ "ads131m02", (kernel_ulong_t)&ads131m_config[ADS131M02_ID] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ads131m_id);
> +
> +static struct spi_driver ads131m_driver = {
> +	.driver = {
> +		.name = "ads131m0x",
> +		.of_match_table = of_match_ptr(ads131m_of_match),

Drop of_match_ptr(). It prevents other types of firmware - e.g. the
magic ACPI ID that says use the dt binding, from working and provide
no real benefit.

> +	},
> +	.probe = ads131m_probe,
> +	.id_table = ads131m_id,
> +};
> +module_spi_driver(ads131m_driver);
> +
> +MODULE_AUTHOR("David Jander <david@protonic.nl>");
> +MODULE_DESCRIPTION("Texas Instruments ADS131M0x ADC driver");
> +MODULE_LICENSE("GPL");


