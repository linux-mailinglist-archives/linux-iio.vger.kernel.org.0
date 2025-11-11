Return-Path: <linux-iio+bounces-26178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF847C4FD21
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 22:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD8D3A1712
	for <lists+linux-iio@lfdr.de>; Tue, 11 Nov 2025 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2682459C9;
	Tue, 11 Nov 2025 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej4+SPqC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA135CBB9;
	Tue, 11 Nov 2025 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895517; cv=none; b=DgPDrNGfbyq4eFe4Jzg4nhi+BLvXzTGhzxVNLvJC8PLrvcyeG+Py8BBGIi4pOupBhkIWqaRy8Wtb18DS+vC8kTX7has6m4OkuIgaHLOBFHh0Yjmd4HI3rRf2cKpKJhHnE4P1hd4eZ90QSrkclAYmDXwRFRY+WjoxYOlXDr3wgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895517; c=relaxed/simple;
	bh=3lyHQk+0PzRgbds35eaJRyIdDSi1lVrFMz7RE1ZSqws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmQc+OPnQl+btDTSSxo0H4uGO/oaXpIj+7yRGwnZFco61i6ExDFEHxaYietAzv/TVna0NXzCsxkdWWko5Y6qJF4lAaVqx5LMIT4aAkuM+JFi3W00bnzXjtzdJxDaVNDNqOgp+Bq0WTazDhq021M0fKukmnABgcTfyikvgZ64Nkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej4+SPqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C80FC4CEF5;
	Tue, 11 Nov 2025 21:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762895517;
	bh=3lyHQk+0PzRgbds35eaJRyIdDSi1lVrFMz7RE1ZSqws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ej4+SPqCnxQFqkrgxlg+EOX/GriEHMHKiEQGTqk0VlHEBdp4MpgObRj0Br9mGmslR
	 TZ2JwH91cvp/LgqtNKWSJtPziiqWygeuczj+PV+8qBERpepo9vKssbDG3BcHwZHvso
	 bNOsgoV/rTtLJzHljjUpJQ57q4jUKOXsQmLcR4VbnQsvZ2VrIaC7ZNTAVv0DyFV6vc
	 x73jcH+hoKtPMTfpEADif4X8+SmFVfHcEJfrGX+F0Nzsz6HLCQ4EuvBXAVqZESLQdW
	 4zJGzfcPhJSmsHuPCJd7LFl3zUCOH10SL3S7NwbfLLC7tyaGr0xDI13W8hmONZN9+W
	 dljQp0vn1hbtQ==
Date: Tue, 11 Nov 2025 21:11:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nuno.sa@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <cosmin.tanislav@analog.com>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v1 2/3] iio: adc: Initial support for AD4134
Message-ID: <20251111211148.322e5aaf@jic23-huawei>
In-Reply-To: <86f532ae3a9b3f122b9d5dbada9c131a0c048ca7.1762777931.git.marcelo.schmitt@analog.com>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
	<86f532ae3a9b3f122b9d5dbada9c131a0c048ca7.1762777931.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 09:45:40 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> AD4134 is a 24-bit, 4-channel, simultaneous sampling, precision
> analog-to-digital converter (ADC). The device can be managed through SPI or
> direct control of pin logical levels (pin control mode). The AD4134 design
> also features a dedicated bus for ADC sample data output. Though, this
> initial driver for AD4134 only supports usual SPI connections.
> 
> The different wiring configurations will likely require distinct software
> to handle. So, the code specific to SPI is enclosed in ad4134-spi.c, while
> functionality that may be useful to all wiring configuration is set into
> ad4134-common.h and ad4134-common.c.

'maybe' isn't usually a justification for a split.  If that code
was on list even as an RFC before merging  I'd be fine with this, but if it is
something we might never see upstream, then squash the abstractions for
now. Those then end up being introduced as a precursor part of the patch
set that gives them a reason to exist.

> 
> Add basic support for AD4134 that allows single-shot ADC sample read.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
A few other comments inline,

Thanks, J
> diff --git a/drivers/iio/adc/ad4134-common.c b/drivers/iio/adc/ad4134-common.c
> new file mode 100644
> index 000000000000..05332a640926
> --- /dev/null
> +++ b/drivers/iio/adc/ad4134-common.c

> +
> +static const char *const ad4134_clk_sel[] = {
> +	"xtal1-xtal2", "clkin"
> +};
> +
> +static int ad4134_clock_select(struct ad4134_state *st)
> +{
> +	struct device *dev = st->dev;
> +	struct clk *sys_clk;
> +	int ret;
> +
> +	ret = device_property_match_property_string(dev, "clock-names",
> +						    ad4134_clk_sel,
> +						    ARRAY_SIZE(ad4134_clk_sel));
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to find external clock\n");
> +
> +	sys_clk = devm_clk_get_enabled(dev, ad4134_clk_sel[ret]);
> +	if (IS_ERR(sys_clk))
> +		return dev_err_probe(dev, PTR_ERR(sys_clk),
> +				     "failed to get %s external clock\n",
> +				     ad4134_clk_sel[ret]);
This is a somewhat unusual approach. More common to just trying getting
an optional clock and if that fails try the other one.

devm_clk_get_optional_enabled()


> +
> +	st->sys_clk_rate = clk_get_rate(sys_clk);
> +	if (st->sys_clk_rate != AD4134_EXT_CLOCK_MHZ)
> +		dev_warn(dev, "invalid external clock frequency %lu\n",
> +			 st->sys_clk_rate);
> +
> +	return 0;
> +}

> diff --git a/drivers/iio/adc/ad4134-common.h b/drivers/iio/adc/ad4134-common.h
> new file mode 100644
> index 000000000000..c0a553d827c9
> --- /dev/null
> +++ b/drivers/iio/adc/ad4134-common.h

> +
> +#define AD4134_CH_VREG(x)			((x) + 0x50) /* chanX virtual register */
> +#define AD4134_VREG_CH(x)			((x) - 0x50) /* chan of virtual reg X */

Add a comment or two on what virtual registers are for.

> +struct iio_scan_type ad4134_scan_types[] = {
> +	AD4134_SCAN_TYPE(16, 16),
> +	AD4134_SCAN_TYPE(16, 24),

There are no buffer in here so can type ends up meaning little.
If this eventually doesn't become useful, storage bits must be a power of 2 * 8
So can't be 24.  

> +	AD4134_SCAN_TYPE(24, 24),
> +	AD4134_SCAN_TYPE(24, 32),
> +};
> +
> +#define AD4134_CHANNEL(_index) {						\
> +	.type = IIO_VOLTAGE,							\
> +	.indexed = 1,								\
> +	.channel = (_index),							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
> +	.scan_index = (_index),							\
> +	.has_ext_scan_type = 1,							\
> +	.ext_scan_type = ad4134_scan_types,					\
> +	.num_ext_scan_type = ARRAY_SIZE(ad4134_scan_types)			\
> +}

> diff --git a/drivers/iio/adc/ad4134-spi.c b/drivers/iio/adc/ad4134-spi.c
> new file mode 100644
> index 000000000000..7d0749e5c084
> --- /dev/null
> +++ b/drivers/iio/adc/ad4134-spi.c
> @@ -0,0 +1,287 @@

> +
> +#include "ad4134-common.h"

> +static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct ad4134_state *st = context;
> +	struct spi_device *spi = to_spi_device(st->dev);
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.rx_buf = st->rx_buf,
> +		.len = AD4134_SPI_MAX_XFER_LEN,
> +	};
> +	int ret;
> +
> +	ad4134_prepare_spi_tx_buf(reg, val, st->tx_buf);
> +
> +	ret = spi_sync_transfer(spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (st->rx_buf[2] != st->tx_buf[2])
> +		dev_dbg(st->dev, "reg write CRC check failed\n");
> +
> +	return 0;
> +}
> +
> +static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
> +			    unsigned int *val)
> +{
> +	struct spi_device *spi = to_spi_device(st->dev);
> +	struct iio_scan_type *scan_type = &ad4134_scan_types[st->current_scan_type];
> +	unsigned int i;
> +	int ret;
> +
> +	/*
> +	 * Data from all four channels is serialized and output on SDO. Read
> +	 * them all but keep only the requested data.

I'm failing to spot this mode described on the datasheet.  Could you
provide a reference section?

> +	 */
> +	for (i = 0; i < ARRAY_SIZE(ad4134_chan_set); i++) {
> +		ret = spi_write_then_read(spi, NULL, 0, st->rx_buf,
> +					  BITS_TO_BYTES(scan_type->storagebits));
> +		if (ret)
> +			return ret;
> +
> +		if (i != AD4134_VREG_CH(reg))
> +			continue;
> +
> +		if (scan_type->realbits == 16)
> +			*val = get_unaligned_be16(st->rx_buf);
> +		else
> +			*val = get_unaligned_be24(st->rx_buf);
> +
> +		*val >>= scan_type->shift;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4134_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct ad4134_state *st = context;
> +	struct spi_device *spi = to_spi_device(st->dev);
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.rx_buf = st->rx_buf,
> +		.len = AD4134_SPI_MAX_XFER_LEN,
> +	};
> +	unsigned int inst;
> +	int ret;
> +
> +	if (reg >= AD4134_CH_VREG(0))
> +		return ad4134_data_read(st, reg, val);

If you are going down this path the xfer isn't used.  To avoid that being
a little confusing I'd factor out the rest of this function into a helper

> +
> +	inst = AD4134_REG_READ_MASK | reg;
> +	ad4134_prepare_spi_tx_buf(inst, 0, st->tx_buf);
> +
> +	ret = spi_sync_transfer(spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val = st->rx_buf[1];
> +
> +	/* Check CRC */
> +	if (st->rx_buf[2] != st->tx_buf[2])
> +		dev_dbg(st->dev, "reg read CRC check failed\n");
> +
> +	return 0;
> +}


> +
> +static const struct ad4134_bus_info ad4134_min_io_bus_info = {

given it's a mix of bus specific and other stuff, I'm not sure 
that calling this bus_info makes sense.  Maybe just ad4134_info?

> +	.chip_info = &ad4134_chip_info,
> +	.bops = &ad4134_min_io_bops,
> +};



