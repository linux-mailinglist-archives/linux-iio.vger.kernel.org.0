Return-Path: <linux-iio+bounces-22049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99514B12FCF
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 16:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099B33B546F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCAB216E26;
	Sun, 27 Jul 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMHsvcVR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3413C3F6;
	Sun, 27 Jul 2025 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753625411; cv=none; b=ONSo9NuSMZyc4qn5GgUMvaOZW3HnW6pMusKhgAaZhcp03RJrCSkMtbtKN4JNyGjhYiR0AL4jSGjFmprNnzhv2KcOjJJ7V+4sJ86q/72z4ShAzcRstX2kJLbsNX/aqoIJbKvH7LZgiBzkbCnaSwsQW/5zpjHPKNx0ov55D+lQ/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753625411; c=relaxed/simple;
	bh=hA59d9plSnl4PbbsambLLE9yX8RGSSsD6Nh2CyG1UpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYYQuZtQQ+QP0W6V6MIKE1/PwPNCZ+d9fFTs8Tl0FikcQ2+I7Wa4G01TqgKm9juagfSkb5+aP9nhRbV5puXLYF/jY7EqlRiWb31o8sKWAN58Q5S08QdvjCwAo91g9oanqgfgzK4Xd5fcxXWZIQIIwtSluhEQ8pndsd2TJ/B3AEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMHsvcVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98221C4CEEB;
	Sun, 27 Jul 2025 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753625410;
	bh=hA59d9plSnl4PbbsambLLE9yX8RGSSsD6Nh2CyG1UpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DMHsvcVRaLzVSQAtn4DRSOcPGOuyqhSIIX+/k9vhnw1WAtqQRWhD1ykFtpxY3H3Q7
	 4R5TXMdiNFltKDGYXu0VYSirJv5W8yO1SNwfKpZlD7qWiGFrckmMnxL2H5S8Kvq1IX
	 BXvcJ/isKhRVjevwZzuSBqzZzfNvRUNT7iebkSf+nC89PH15SrZyMq3CYyX8BZY4bC
	 iiFiy72A4OkvAzhEbTy9Krolrkf0oho9Wi4eWEGp4TBBMsYusDGf/G3qsbhuGEndAW
	 /6Qx+Y/RpxorBxxcZ9VjhJkRdX21TO9qBPKOss+70oWpdVNt0D6JyrLiLaxyKCSPfX
	 cxKvFg4Bhf3PA==
Date: Sun, 27 Jul 2025 15:10:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] iio: adc: add ade9000 support
Message-ID: <20250727151003.1d257cf1@jic23-huawei>
In-Reply-To: <20250721112455.23948-3-antoniu.miclaus@analog.com>
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
	<20250721112455.23948-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 14:24:43 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

Hi Antoniu,

> Add driver support for the ade9000. highly accurate,
> fully integrated, multiphase energy and power quality
> monitoring device.
wrap at 75 chars.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

This remains too large to be properly reviewed. Split out some features
from initial version. Based on the docs (that I reviewed first) the
waveform buffer support would be a good thing to drop for now.
Similar for events.

I'll take a quick look only for now (for reference this took me 40 mins and
was not at all thorough).

Jonathan

> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> new file mode 100644
> index 000000000000..aa4f0f635434
> --- /dev/null
> +++ b/drivers/iio/adc/ade9000.c
> @@ -0,0 +1,2290 @@

> +struct ade9000_state {
> +	bool rst_done;
> +	u8 wf_mode;
> +	u8 wf_src;
> +	u32 wfb_trg;
> +	u8 wfb_nr_activ_chan;
> +	u32 wfb_nr_samples;
> +	struct spi_device *spi;
> +	u8 *tx;
> +	u8 *rx;
As later, add these to the buffers you used force alignment on
and don't bother with separate allocations.

> +	struct spi_transfer xfer[2];
> +	struct spi_message spi_msg;
> +	struct regmap *regmap;
> +	union{
> +		u8 byte[ADE9000_WFB_FULL_BUFF_SIZE];
> +		__be32 word[ADE9000_WFB_FULL_BUFF_NR_SAMPLES];
> +	} rx_buff __aligned(IIO_DMA_MINALIGN);
> +	u8 tx_buff[2] __aligned(IIO_DMA_MINALIGN);
Do you access tx_buff whilst rx_buff is being used for DMA?
If not, having them all in one __aligned(IIO_DMA_MINALIGN) should
be fine.  That is, just mark the first one.

> +};
> +
> +static const struct iio_event_spec ade9000_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_NONE,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_CHANGE,
> +		.dir = IIO_EV_DIR_NONE,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_NONE,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING, // For swell
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING, // For dip
/* for dip */

No C++ style comments (except for SPDX related ones)

> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
>
> +
> +static const char * const ade9000_filter_type_items[] = {
> +	"sinc4", "sinc4+iir", "dsp"

Is dsp a documented type?

> +};
> +
> +static const int ade9000_filter_type_values[] = {
> +	0, 2, 3
Trailing comma. It's not 'terminated' so we always treat these as potentially
extended in future.

> +};

> +static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
> +	{
> +		.name = "wf_cap_en",
> +		.read = ade9000_wf_cap_en_show,
> +		.write = ade9000_wf_cap_en_store,
> +		.shared = IIO_SHARED_BY_ALL,
> +	},
> +	{
> +		.name = "wf_mode",
> +		.read = ade9000_wf_mode_show,
> +		.write = ade9000_wf_mode_store,
> +		.shared = IIO_SHARED_BY_ALL,
> +	},
> +	{
> +		.name = "wf_in_en",
> +		.read = ade9000_wf_in_en_show,
> +		.write = ade9000_wf_in_en_store,
> +		.shared = IIO_SHARED_BY_ALL,
> +	},
> +	{
> +		.name = "egy_time",
> +		.read = ade9000_egy_time_show,
> +		.write = ade9000_egy_time_store,
> +		.shared = IIO_SHARED_BY_ALL,
> +	},
> +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ade9000_filter_type_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL, &ade9000_filter_type_enum),
> +	{},
No comma.

Some discussion of these in the docs patch, but in general I'd not try to merge
new custom ABI in an initial driver series.  Get the basic standard stuff in first
and we can have a better discussion of these.

> +};
> +
> +#define ADE9000_CURRENT_CHANNEL(num) {				\
> +	.type = IIO_CURRENT,						\
> +	.channel = num,							\
> +	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AI_PCF, num),	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
> +	.event_spec = &ade9000_events[0],				\
> +	.num_event_specs = 1,						\
> +	.scan_index = num,						\
> +	.indexed = 1,							\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 32,						\
> +		.storagebits = 32,					\
> +		.shift = 0,						\
> +		.endianness = IIO_BE,					\
> +	},								\
> +}
> +
> +#define ADE9000_VOLTAGE_CHANNEL(num) {				\
> +	.type = IIO_VOLTAGE,						\
> +	.channel = num,							\
> +	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AV_PCF, num),	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN) |	\
> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.event_spec = ade9000_events,					\
> +	.num_event_specs = ARRAY_SIZE(ade9000_events),			\
> +	.scan_index = num + 1,						\
> +	.indexed = 1,							\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 32,						\
> +		.storagebits = 32,					\
> +		.shift = 0,						\
Shift of 0 is default, so don't set it explicitly.

> +		.endianness = IIO_BE,					\
> +	},								\
> +	.ext_info = ade9000_ext_info,					\
> +}
> +
> +#define ADE9000_CURRENT_RMS_CHANNEL(num) {			\
> +	.type = IIO_CURRENT,						\
> +	.channel = num,							\
> +	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AIRMS, num),		\
> +	.channel2 = IIO_MOD_RMS,					\
> +	.modified = 1,							\
> +	.indexed = 1,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.scan_index = -1						\
> +}
> +
> +#define ADE9000_ALTVOLTAGE_RMS_CHANNEL(num) {			\
> +	.type = IIO_ALTVOLTAGE,						\
> +	.channel = num,							\
> +	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AVRMS, num),		\
> +	.channel2 = IIO_MOD_RMS,					\
> +	.modified = 1,							\
> +	.indexed = 1,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.scan_index = -1						\
> +}
> +
> +#define ADE9000_POWER_ACTIVE_CHANNEL(num) {			\
> +	.type = IIO_POWER,						\
> +	.channel = num,							\
> +	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT, num),		\
> +	.channel2 = IIO_MOD_ACTIVE,					\
> +	.modified = 1,							\
> +	.indexed = 1,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN) |		\
> +			      BIT(IIO_CHAN_INFO_POWER_FACTOR),		\
> +	.scan_index = -1						\
> +}
> +
> +#define ADE9000_POWER_REACTIVE_CHANNEL(num) {			\
> +	.type = IIO_POWER,						\
> +	.channel = num,							\
> +	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AVAR, num),		\
> +	.channel2 = IIO_MOD_REACTIVE,					\
> +	.modified = 1,							\
> +	.indexed = 1,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET) |		\
> +			      BIT(IIO_CHAN_INFO_POWER_FACTOR),		\
> +	.scan_index = -1						\
> +}
> +
> +#define ADE9000_POWER_APPARENT_CHANNEL(num) {			\
> +	.type = IIO_POWER,						\
> +	.channel = num,							\
> +	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AVA, num),		\
> +	.channel2 = IIO_MOD_APPARENT,					\
> +	.modified = 1,							\
> +	.indexed = 1,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_POWER_FACTOR),		\
> +	.scan_index = -1						\
> +}
> +
> + #define ADE9000_ENERGY_ACTIVE_CHANNEL(num, addr) {     \
> +	.type = IIO_ENERGY,                                          \
> +	.channel = num,                                              \
> +	.address = addr,                                             \
Tidyup the tabs and space here.  Tabs is the way to go.
> +	.channel2 = IIO_MOD_ACTIVE,				\
> +	.modified = 1,						\
> +	.indexed = 1,                                                \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),          \
> +	.scan_index = -1                                             \
> +}
> +
> +#define ADE9000_ENERGY_APPARENT_CHANNEL(num, addr) {     \
> +	.type = IIO_ENERGY,                                          \
> +	.channel = num,                                              \
> +	.address = addr,                                             \
> +	.channel2 = IIO_MOD_APPARENT,				\
> +	.modified = 1,						\
> +	.indexed = 1,                                                \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),          \
> +	.scan_index = -1                                             \
> +}
> +
> +#define ADE9000_ENERGY_REACTIVE_CHANNEL(num, addr) {     \
> +	.type = IIO_ENERGY,                                          \
> +	.channel = num,                                              \
> +	.address = addr,                                             \
> +	.channel2 = IIO_MOD_REACTIVE,				\
> +	.modified = 1,						\
> +	.indexed = 1,                                                \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),          \
> +	.scan_index = -1                                             \
> +}
> +
> +#define ADE9000_ALTVOLTAGE_ACCMODE_CHANNEL() {			\
> +	.type = IIO_ALTVOLTAGE,						\
> +	.channel = 0,							\
> +	.address = ADE9000_REG_ACCMODE,					\
> +	.indexed = 1,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = -1						\
> +}
> +
> +/* IIO channels of the ade9000 for each phase individually */
> +static const struct iio_chan_spec ade9000_a_channels[] = {

Eyeballing the A B C sets here, can you use a macro that just takes, A etc
as as parameter to generate the whole lot. It would be useful to see that
they are effectively the same other than that.

Having done that, consider if it makes sense have have the macros used
here now, or whether it would be clearer to have the chan spec for one phase
clearly laid out.

> +	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_CURRENT_RMS_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AWATTHR_LO),
> +	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AVAHR_LO),
> +	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AFVARHR_LO),
> +};

> +static int ade9000_spi_write_reg(void *context,
> +				 unsigned int reg,
> +				 unsigned int val)
Same as next function.

> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct ade9000_state *st = spi_get_drvdata(spi);
> +
> +	u16 addr;
> +	int ret = 0;
> +	struct spi_transfer xfer[] = {
> +		{
> +			.tx_buf = st->tx,
> +		},
> +	};
> +
> +	addr = FIELD_PREP(ADE9000_REG_ADDR_MASK, reg);
> +
> +	put_unaligned_be16(addr, st->tx);
> +	put_unaligned_be32(val, &st->tx[2]);
> +
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION) {
> +		put_unaligned_be16(val, &st->tx[2]);
> +		xfer[0].len = 4;
> +	} else {
> +		xfer[0].len = 6;
> +	}
> +
> +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "problem when writing register 0x%x",
> +			reg);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ade9000_spi_read_reg(void *context,
> +				unsigned int reg,
> +				unsigned int *val)
wrap closer to 80 chars.

> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct ade9000_state *st = spi_get_drvdata(spi);
> +
> +	u16 addr;
> +	int ret = 0;
> +	struct spi_transfer xfer[] = {
> +		{
> +			.tx_buf = st->tx,
> +			.len = 2,
> +		},
> +		{
> +			.rx_buf = st->rx,
> +		},
> +	};
> +
> +	addr = FIELD_PREP(ADE9000_REG_ADDR_MASK, reg) |
> +	       ADE9000_REG_READ_BIT_MASK;
> +
> +	put_unaligned_be16(addr, st->tx);
> +
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION)
> +		xfer[1].len = 4;
> +	else
> +		xfer[1].len = 6;
> +
> +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "error reading register 0x%x",
> +			reg);
> +		goto err_ret;
> +	}
> +
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION)
> +		*val = get_unaligned_be16(st->rx);
> +	else
> +		*val = get_unaligned_be32(st->rx);
> +
> +err_ret:

Just return in error paths.

> +	return ret;
> +}
>

> +static irqreturn_t ade9000_irq0_thread(int irq, void *data)

> +static irqreturn_t ade9000_irq1_thread(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	unsigned int bit = ADE9000_ST1_CROSSING_FIRST;
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	u32 handled_irq = 0;
> +	u32 interrupts;
> +	u32 result;
> +	u32 status;
> +	u32 tmp;
> +	int ret;
> +
> +	if (!st->rst_done) {
> +		ret = regmap_read(st->regmap, ADE9000_REG_STATUS1, &result);
> +		if (ret)
> +			return ret;
> +
> +		if (result & ADE9000_ST1_RSTDONE_BIT)
> +			st->rst_done = true;
> +		else
> +			dev_err(&st->spi->dev, "Error testing reset done");
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_STATUS1, &status);
> +	if (ret)
> +		return IRQ_HANDLED;
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ1 read status fail");
> +		return IRQ_HANDLED;
> +	}
> +
> +	for_each_set_bit_from(bit, (unsigned long *)&interrupts,

Store interrupts into an unsigned long before using this helper.

> +			      ADE9000_ST1_CROSSING_DEPTH){
> +		tmp = status & BIT(bit);
> +
> +		switch (tmp) {
> +		case ADE9000_ST1_ZXVA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXVA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXTOVA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXIA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXVB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXVB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXTOVB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXIB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXVC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXVC_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXTOVC_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_ZXIC_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLA_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SWELLA_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLB_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SWELLB_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLC_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SWELLC_BIT;
> +			break;
> +		case ADE9000_ST1_DIPA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPA_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_DIPA_BIT;
> +			break;
> +		case ADE9000_ST1_DIPB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPB_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_DIPB_BIT;
> +			break;
> +		case ADE9000_ST1_DIPC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPC_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_DIPC_BIT;
> +			break;
> +		case ADE9000_ST1_SEQERR_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SEQERR_BIT >> 12,
> +							    IIO_EV_TYPE_CHANGE,
> +							    IIO_EV_DIR_NONE),
> +				       timestamp);
> +			handled_irq |= ADE9000_ST1_SEQERR_BIT;
> +			break;
> +		default:
> +			return IRQ_HANDLED;
> +		}
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, handled_irq);
> +	if (ret)
> +		return ret;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ade9000_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
...

> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_ENERGY) {
> +			s64 val64;
> +			u32 data[2];
> +			u16 lo_reg = chan->address;
> +
> +			ret = regmap_bulk_read(st->regmap, lo_reg, data, 2);
> +			if (ret)
> +				return ret;
> +
> +			val64 = ((u64)data[1] << 32) | data[0];
> +			*(s64 *)val = val64;

That won't work got 64 bit values and better still will corrupt
a random bit of the stack.

> +			return IIO_VAL_INT;
> +		}
> +
> +		ret = iio_device_claim_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(st->regmap, chan->address, &measured);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		*val = measured;
> +
> +		return IIO_VAL_INT;
...

> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret = regmap_read(st->regmap, ADE9000_REG_PGA_GAIN, &reg);
> +		if (ret)
> +			return ret;
> +		*val = 1 << ((reg >> (8 + chan->channel)) & 0x3);
> +		if (*val > 4)
> +			*val = 4;
		*val = min(val, 4);

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ade9000_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 addr;
> +	u32 tmp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val != 50 && val != 60)
> +			return -EINVAL;
> +		return regmap_write(st->regmap, ADE9000_REG_ACCMODE,
> +				    (val == 60) ? ADE9000_ACCMODE_60HZ : ADE9000_ACCMODE);
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_CURRENT:
> +			addr = ADE9000_ADDR_ADJUST(ADE9000_REG_AIRMSOS,
> +						   chan->channel);

Do the regmap writes here and return.  A little more duplication for more
readable code.  Same for all the other cases.


> +			break;
> +		case IIO_VOLTAGE:
> +		case IIO_ALTVOLTAGE:
> +			addr = ADE9000_ADDR_ADJUST(ADE9000_REG_AVRMSOS,
> +						   chan->channel);
> +			break;
> +		case IIO_POWER:
> +			tmp = chan->address;
> +			tmp &= ~ADE9000_PHASE_B_POS_BIT;
> +			tmp &= ~ADE9000_PHASE_C_POS_BIT;
> +
> +			switch (tmp) {
> +			case ADE9000_REG_AWATTOS:
> +				addr = ADE9000_ADDR_ADJUST(ADE9000_REG_AWATTOS,
> +							   chan->channel);
> +				break;
> +			case ADE9000_REG_AVAR:
> +				addr = ADE9000_ADDR_ADJUST(ADE9000_REG_AVAROS,
> +							   chan->channel);
> +				break;
> +			case ADE9000_REG_AFVAR:
> +				addr = ADE9000_ADDR_ADJUST(ADE9000_REG_AFVAROS,
> +							   chan->channel);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		switch (chan->type) {
> +		case IIO_CURRENT:
> +			addr = ADE9000_ADDR_ADJUST(ADE9000_REG_AIGAIN,
> +						   chan->channel);
> +			break;
> +		case IIO_VOLTAGE:
> +			addr = ADE9000_ADDR_ADJUST(ADE9000_REG_AVGAIN,
> +						   chan->channel);
> +			break;
> +		case IIO_POWER:
> +			addr = ADE9000_ADDR_ADJUST(ADE9000_REG_APGAIN,
> +						   chan->channel);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val > 4 || val < 1 || val == 3)
> +			return -EINVAL;
> +		addr = ADE9000_REG_PGA_GAIN;
> +		val = ilog2(val) << (chan->channel * 2 + 8);
> +		tmp = 0x3 << (chan->channel * 2 + 8);
> +		return regmap_update_bits(st->regmap, addr, tmp, val);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_write(st->regmap, addr, val);

> +}

> +
> +static int ade9000_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 interrupts, tmp;
> +	int ret;
> +	struct irq_wfb_trig {
> +		u32 irq;
> +		u32 wfb_trg;
> +	};
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS1, GENMASK(31, 0));
> +	if (ret)
> +		return ret;
> +
> +	if (type == IIO_EV_TYPE_MAG) {
> +		ret = regmap_update_bits(st->regmap, ADE9000_REG_STATUS0,
> +					 ADE9000_ST0_EGYRDY, ADE9000_ST0_EGYRDY);
> +		if (ret)
> +			return ret;
> +		return regmap_update_bits(st->regmap, ADE9000_REG_MASK0,
> +					 ADE9000_ST0_EGYRDY,
> +					 state ? ADE9000_ST1_SEQERR_BIT : 0);
> +	}
> +
> +	if (type == IIO_EV_TYPE_CHANGE)
> +		return regmap_update_bits(st->regmap, ADE9000_REG_MASK1,
> +					 ADE9000_ST1_SEQERR_BIT,
> +					 state ? ADE9000_ST1_SEQERR_BIT : 0);
> +
> +	struct irq_wfb_trig trig_arr[6] = {
> +		{.irq = ADE9000_ST1_ZXVA_BIT,

		{
			.irq = ...
		}, {


> +		 .wfb_trg = ADE9000_WFB_TRG_ZXVA_BIT
> +		},
> +		{.irq = ADE9000_ST1_ZXIA_BIT,
> +		 .wfb_trg = ADE9000_WFB_TRG_ZXIA_BIT
> +		},
> +		{.irq = ADE9000_ST1_ZXVB_BIT,
> +		 .wfb_trg = ADE9000_WFB_TRG_ZXVB_BIT
> +		},
> +		{.irq = ADE9000_ST1_ZXIB_BIT,
> +		 .wfb_trg = ADE9000_WFB_TRG_ZXIB_BIT
> +		},
> +		{.irq = ADE9000_ST1_ZXVC_BIT,
> +		 .wfb_trg = ADE9000_WFB_TRG_ZXVC_BIT
> +		},
> +		{.irq = ADE9000_ST1_ZXIC_BIT,
> +		 .wfb_trg = ADE9000_WFB_TRG_ZXIC_BIT
> +		},
> +	};
> +
> +	if (dir == IIO_EV_DIR_EITHER) {
> +		if (state) {
> +			interrupts |= trig_arr[chan->channel * 2 + chan->type].irq;
> +			st->wfb_trg |= trig_arr[chan->channel * 2 + chan->type].wfb_trg;
> +		} else {
> +			interrupts &= ~trig_arr[chan->channel * 2 + chan->type].irq;
> +			st->wfb_trg &= ~trig_arr[chan->channel * 2 + chan->type].wfb_trg;
> +		}
> +	if (dir == IIO_EV_DIR_NONE) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			interrupts |= ADE9000_ST1_ZXTOVA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			interrupts |= ADE9000_ST1_ZXTOVB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			interrupts |= ADE9000_ST1_ZXTOVC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state)
> +			interrupts |= tmp;
> +		else
> +			interrupts &= ~tmp;
> +	}
> +	} else if (dir == IIO_EV_DIR_RISING) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			tmp |= ADE9000_ST1_SWELLA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			tmp |= ADE9000_ST1_SWELLB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			tmp |= ADE9000_ST1_SWELLC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state) {
> +			interrupts |= tmp;
> +			st->wfb_trg |= ADE9000_WFB_TRG_SWELL_BIT;
> +		} else {
> +			interrupts &= ~tmp;
> +			st->wfb_trg &= ~ADE9000_WFB_TRG_SWELL_BIT;
> +		}
> +
> +	} else if (dir == IIO_EV_DIR_FALLING) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			tmp |= ADE9000_ST1_DIPA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			tmp |= ADE9000_ST1_DIPB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			tmp |= ADE9000_ST1_DIPC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state) {
> +			interrupts |= tmp;
> +			st->wfb_trg |= ADE9000_WFB_TRG_DIP_BIT;
> +		} else {
> +			interrupts &= ~tmp;
> +			st->wfb_trg &= ~ADE9000_WFB_TRG_DIP_BIT;
> +		}
> +	}
> +	return regmap_update_bits(st->regmap, ADE9000_REG_MASK1, interrupts,
> +				  interrupts);
> +}

> +static int ade9000_config_wfb(struct iio_dev *indio_dev)

Maybe expand wfb. It's not a particularly common acronym.

> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 wfg_cfg_val = 0;
> +	u32 active_scans;
> +
> +	bitmap_to_arr32(&active_scans, indio_dev->active_scan_mask,
> +			indio_dev->masklength);
> +
> +	switch (active_scans) {
> +	case ADE9000_SCAN_POS_IA | ADE9000_SCAN_POS_VA:
> +		wfg_cfg_val = 0x1;
> +		st->wfb_nr_activ_chan = 2;
> +		break;
> +	case ADE9000_SCAN_POS_IB | ADE9000_SCAN_POS_VB:
> +		wfg_cfg_val = 0x2;
> +		st->wfb_nr_activ_chan = 2;
> +		break;
> +	case ADE9000_SCAN_POS_IC | ADE9000_SCAN_POS_VC:
> +		wfg_cfg_val = 0x3;
> +		st->wfb_nr_activ_chan = 2;
> +		break;
> +	case ADE9000_SCAN_POS_IA:
> +		wfg_cfg_val = 0x8;
> +		st->wfb_nr_activ_chan = 1;
> +		break;
> +	case ADE9000_SCAN_POS_VA:
> +		wfg_cfg_val = 0x9;
> +		st->wfb_nr_activ_chan = 1;
> +		break;
> +	case ADE9000_SCAN_POS_IB:
> +		wfg_cfg_val = 0xA;
> +		st->wfb_nr_activ_chan = 1;
> +		break;
> +	case ADE9000_SCAN_POS_VB:
> +		wfg_cfg_val = 0xB;
> +		st->wfb_nr_activ_chan = 1;
> +		break;
> +	case ADE9000_SCAN_POS_IC:
> +		wfg_cfg_val = 0xC;
> +		st->wfb_nr_activ_chan = 1;
> +		break;
> +	case ADE9000_SCAN_POS_VC:
> +		wfg_cfg_val = 0xD;
Feels like an enum is probably appropriate for these settings.

> +		st->wfb_nr_activ_chan = 1;
> +		break;
> +	case ADE9000_SCAN_POS_ALL:
> +		wfg_cfg_val = 0x0;
> +		st->wfb_nr_activ_chan = 6;
> +		break;
> +	default:
> +		dev_err(&st->spi->dev, "Unsupported combination of scans");
> +		return -EINVAL;
> +	}
> +
> +	wfg_cfg_val |= FIELD_PREP(ADE9000_WF_SRC_MASK, st->wf_src);
> +
> +	return regmap_write(st->regmap, ADE9000_REG_WFB_CFG, wfg_cfg_val);
> +}

> +
> +static int ade9000_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	u32 interrupts = 0;
> +	int ret;
> +
> +	ret = ade9000_en_wfb(st, false);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Post-disable wfb disable fail");
> +		return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_WFB_TRG_CFG, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	interrupts |= ADE9000_ST0_WFB_TRIG_BIT;

interrupts = ADE9000_ST0_WFB_TRIG_BIT | ADE9000_ST0_PAGE_FULL_BIT;
and drop the initialization to zero above.

> +	interrupts |= ADE9000_ST0_PAGE_FULL_BIT;
> +
> +	return regmap_update_bits(st->regmap, ADE9000_REG_MASK0, interrupts, 0);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Post-disable update maks0 fail");
> +		return ret;
> +	}
> +
> +	return regmap_write(st->regmap, ADE9000_REG_STATUS0, GENMASK(31, 0));
> +}
> +
> +static int ade9000_setup_iio_channels(struct iio_dev *indio_dev)
> +{
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct fwnode_handle *phase_node = NULL;
> +	struct iio_chan_spec *chan;
> +	u32 phase_nr;
> +	int ret;
> +
> +	chan = devm_kcalloc(dev,
> +			    (ADE9000_MAX_PHASE_NR *
> +			     ARRAY_SIZE(ade9000_a_channels)) + 1,
> +			    sizeof(*chan), GFP_KERNEL);
> +	if (!chan) {
> +		dev_err(dev, "Unable to allocate ADE9000 channels");
> +		return -ENOMEM;
> +	}
> +	indio_dev->num_channels = 0;
> +	indio_dev->channels = chan;
> +
> +	struct iio_chan_spec *chan_ptr = chan;

only declare local variables inline if doing cleanup.h stuff.

> +
> +	fwnode_for_each_available_child_node(dev_fwnode(dev), phase_node) {
> +		ret = fwnode_property_read_u32(phase_node, "reg", &phase_nr);
As per binding review, i'm doubtful anyone buys a 3 phase chip and wants
only some phases.  Simpler if we just assume everything on and make all this
stuff const.

> +		if (ret) {
> +			dev_err(dev, "Could not read channel reg : %d\n", ret);
> +			return ret;
> +		}
> +
> +		switch (phase_nr) {
> +		case ADE9000_PHASE_A_NR:
> +			memcpy(chan_ptr, ade9000_a_channels,
> +			       sizeof(ade9000_a_channels));
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			memcpy(chan_ptr, ade9000_b_channels,
> +			       sizeof(ade9000_b_channels));
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			memcpy(chan_ptr, ade9000_c_channels,
> +			       sizeof(ade9000_c_channels));
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		chan_ptr += AD9000_CHANNELS_PER_PHASE;
> +		indio_dev->num_channels += AD9000_CHANNELS_PER_PHASE;
> +	}
> +
> +	*chan_ptr = (struct iio_chan_spec)ADE9000_ALTVOLTAGE_ACCMODE_CHANNEL();
> +	indio_dev->num_channels++;
> +
> +	return 0;
> +}
> +
> +static int ade9000_reset(struct ade9000_state *st)
> +{
> +	struct gpio_desc *gpio_reset;
> +	int ret;
> +
> +	st->rst_done = false;
> +
> +	gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
> +					     GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio_reset))
> +		return PTR_ERR(gpio_reset);
> +
> +	if (gpio_reset) {
> +		gpiod_set_value_cansleep(gpio_reset, 1);

You got it high - so I think this isn't needed.

> +		usleep_range(1, 100);

That's an odd range.  fsleep() for expected necessary value perhaps more appropriate.


> +		gpiod_set_value_cansleep(gpio_reset, 0);
> +		msleep_interruptible(50);
flseep for this too.

> +	} else {
> +		ret = regmap_update_bits(st->regmap, ADE9000_REG_CONFIG1,
> +					 ADE9000_SWRST_BIT, ADE9000_SWRST_BIT);
> +		if (ret)
> +			return ret;
> +		usleep_range(80, 100);
fsleep() for all these.

> +	}
> +
> +	if (!st->rst_done)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int ade9000_setup(struct ade9000_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_multi_reg_write(st->regmap, ade9000_reg_sequence,
> +				     ARRAY_SIZE(ade9000_reg_sequence));
> +	if (ret)
> +		return ret;
> +
> +	msleep_interruptible(2);
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS0, GENMASK(31, 0));

Not obvious why you'd write all 1s to status registers on setup(). Maybe worth
adding a comment.

> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, ADE9000_REG_STATUS1, GENMASK(31, 0));
> +}

> +
> +static int ade9000_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ade9000_state *st;
> +	struct regmap *regmap;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev) {
> +		dev_err(&spi->dev, "Unable to allocate ADE9000 IIO");
as below. dev_err_probe() for all errors in probe.
Also, lot of spi->dev, so use a local
	struct device *dev = &spi->dev;
in the interests of slightly shorter lines.

> +		return -ENOMEM;
> +	}
> +	st = iio_priv(indio_dev);
> +
> +	st->rx = devm_kcalloc(&spi->dev, ADE9000_RX_DEPTH, sizeof(*st->rx),

These are small.  So Embed them in st with __aligned(IIO_DMA_MINALIGN)

> +			      GFP_KERNEL);
> +	if (!st->rx)
> +		return -ENOMEM;
> +
> +	st->tx = devm_kcalloc(&spi->dev, ADE9000_TX_DEPTH, sizeof(*st->tx),
> +			      GFP_KERNEL);
> +	if (!st->tx)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init(&spi->dev, NULL, spi, &ade9000_regmap_config);
> +	if (IS_ERR(regmap))	{

Odd spacing. Check for stuff like this throughout.

> +		dev_err(&spi->dev, "Unable to allocate ADE9000 regmap");
> +		return PTR_ERR(regmap);
> +	}
> +	spi_set_drvdata(spi, st);
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(&spi->dev), "irq0");
> +	if (irq < 0) {
> +		dev_err(&spi->dev, "Unable to find irq0");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_request_threaded_irq(&spi->dev, irq, NULL,
> +					ade9000_irq0_thread,
> +					IRQF_ONESHOT,
> +					KBUILD_MODNAME, indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to request threaded irq: %d\n", ret);
> +		return ret;
> +	}
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(&spi->dev), "irq1");
> +	if (irq < 0) {
> +		dev_err(&spi->dev, "Unable to find irq1");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_request_threaded_irq(&spi->dev, irq, NULL,
> +					ade9000_irq1_thread,
> +					IRQF_ONESHOT,
> +					KBUILD_MODNAME, indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to request threaded irq: %d\n", ret);
> +		return ret;
> +	}
> +
> +	st->spi = spi;
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = &st->spi->dev;
> +	indio_dev->info = &ade9000_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->setup_ops = &ade9000_buffer_ops;
> +
> +	st->regmap = regmap;
> +
> +	ret = devm_regulator_get_enable(&spi->dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get and enable vdd regulator\n");
> +
> +	ret = devm_regulator_get_enable_optional(&spi->dev, "vref");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get and enable vref regulator\n");
> +
> +	/* Configure reference selection based on vref regulator availability */
> +	if (ret != -ENODEV) {
> +		ret = regmap_update_bits(st->regmap, ADE9000_REG_CONFIG1,
> +					 ADE9000_EXT_REF_MASK,
> +					 ADE9000_EXT_REF_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ade9000_setup_iio_channels(indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to set up IIO channels");

return dev_err_probe() for all errors in probe() and things only called from probe.

> +		return ret;
> +	}
> +	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
> +					  &ade9000_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = ade9000_reset(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "ADE9000 reset failed");
> +		return ret;
> +	}
> +
> +	ret = ade9000_setup(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Unable to setup ADE9000");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Unable to register IIO device");
> +		return ret;
> +	}
> +
> +	return 0;
> +};
> +
> +static const struct spi_device_id ade9000_id[] = {
> +		{"ade9000", 0},
> +		{}
	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ade9000_id);
> +
> +static const struct of_device_id ade9000_of_match[] = {
> +	{ .compatible = "adi,ade9000" },
> +	{}
	{ }
is the convention we've fixed on for IIO.  It was a random choice, but
better to be consistent that not

> +};
> +MODULE_DEVICE_TABLE(of, ade9000_of_match);
> +
> +static struct spi_driver ade9000_driver = {
> +		.driver = {
1 tab only.

> +			.name = "ade9000",
> +			.of_match_table = ade9000_of_match,
> +		},
> +		.probe = ade9000_probe,
> +		.id_table = ade9000_id,
> +};
> +module_spi_driver(ade9000_driver);
> +
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADE9000");
> +MODULE_LICENSE("GPL");


