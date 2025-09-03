Return-Path: <linux-iio+bounces-23682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E05FB41DA2
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 13:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C331BA71D9
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08152FD1BA;
	Wed,  3 Sep 2025 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWYWIwwh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977F2FD1AA;
	Wed,  3 Sep 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900132; cv=none; b=aKk7zSQqHR9F1qbFF932eOLZtOkLeivoZeH9dMGoRjE6ntyEu7CneBBDxZGvD2Tap7CcEQ9nOtOJ6iRW6e3lMe3Rvkf46HZkH5QErp0v7Db5MlCkrac1Wqp67jUBBlWQeOBpw9oEWxw5QPYpOfY0mQ4ivsB0CiSoy6Ra39ghQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900132; c=relaxed/simple;
	bh=3pdvQb6H/hBtoU8Gd4AdARm+k9e70ENFwotPWbuuKac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/ViJBnAtF2ly0EQ2HCLQazxnmGlb17gllczrxj30j4KonHIfMwMyFFqxswgVhS7kPM+vynXAbVjQRMtNiiM61yYXAOU/T7F+EJf9qTzhT2wVjx34fwHhs/uiTzzaVwMUOMiEgKgkc8S4hjvfDaE0cPBTL20FbUkQ7zYPZ+bpoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWYWIwwh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756900131; x=1788436131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3pdvQb6H/hBtoU8Gd4AdARm+k9e70ENFwotPWbuuKac=;
  b=lWYWIwwhuh8HldSJHSO5UtMx5X2BIQls03OmFWBTPbu0k7CaESRfi5qb
   ePJqq7/s8yskEZ+lggw7isbtdAjdF0Clb71zJVwzrnmEAnn5AsGiaWgTx
   2JQbCf+pRb3xwOafZ/BCeGfErSa2aJR9qOcI9fld+00LqEiVgJTcuKO1O
   s+BKoGEdc8RSISj7E1umMtbue53uI3IcSRhZXV66ubA2jyXU42MlI9+Or
   csXjqOY+FOZAou8oxifi4F5RvEbtgWFBcejr4Ev2rUk8I9TTx9Z8Xwdmz
   i7/fX8hZeUgD5Pe/2yoGSI6+T3Nuwq4Ge47SYHwNzIyqZPCJgV7zrW09V
   w==;
X-CSE-ConnectionGUID: EpJ4SNWBRUKWQLqvISTOog==
X-CSE-MsgGUID: oFjDkuJdSqa55jJwndsb6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58240999"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="58240999"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:48:50 -0700
X-CSE-ConnectionGUID: 71n3ljLIRpC4+guR2MleAQ==
X-CSE-MsgGUID: 1d7GwVueTECpWdn+exyKSA==
X-ExtLoop1: 1
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:48:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utlyl-0000000AyOW-0xRU;
	Wed, 03 Sep 2025 14:48:43 +0300
Date: Wed, 3 Sep 2025 14:48:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, linux-iio@vger.kernel.org, s32@nxp.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <aLgrGlpNrDTC5LAd@smile.fi.intel.com>
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903102756.1748596-3-daniel.lezcano@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 12:27:56PM +0200, Daniel Lezcano wrote:
> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> 
> The NXP S32G2 and S32G3 platforms integrate a successive approximation
> register (SAR) ADC. Two instances are available, each providing 8
> multiplexed input channels with 12-bit resolution. The conversion rate
> is up to 1 Msps depending on the configuration and sampling window.
> 
> The SAR ADC supports raw, buffer, and trigger modes. It can operate
> in both single-shot and continuous conversion modes, with optional
> hardware triggering through the cross-trigger unit (CTU) or external
> events. An internal prescaler allows adjusting the sampling clock,
> while per-channel programmable sampling times provide fine-grained
> trade-offs between accuracy and latency. Automatic calibration is
> performed at probe time to minimize offset and gain errors.
> 
> The driver is derived from the BSP implementation and has been partly
> rewritten to comply with upstream requirements. For this reason, all
> contributors are listed as co-developers, while the author refers to
> the initial BSP driver file creator.
> 
> All modes have been validated on the S32G274-RDB2 platform using an
> externally generated square wave captured by the ADC. Tests covered
> buffered streaming via IIO, trigger synchronization, and accuracy
> verification against a precision laboratory signal source.

...

> +#include <linux/circ_buf.h>

Why not kfifo?

> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>

+ match.h and more are missing...

> +#include <linux/module.h>

> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>

Misuse of headers, and please make driver agnostic. There is none OF specifics
in the code AFAICT.

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

...

> +/* Main Configuration Register */
> +#define REG_ADC_MCR(__base)		(__base)

Useless macro. Perhaps (looking the others) this should be
((__base) + 0x00) which makes much more sense.

...

> +#define REG_ADC_MCR_NRSMPL_32		BIT(11)
> +#define REG_ADC_MCR_NRSMPL_128		BIT(12)
> +#define REG_ADC_MCR_NRSMPL_512		(BIT(11) | BIT(12))

These are not bits, please use them in a form of 0, 1, 2, 3 and why not using
bitfield.h?

...

> +#define NXP_SAR_ADC_CONV_TIMEOUT_MS	100
> +#define NXP_SAR_ADC_CAL_TIMEOUT_US	100000

(100 * USEC_PER_MSEC)

> +#define NXP_SAR_ADC_WAIT_US		2000

(2 * USEC_PER_MSEC)

...

> +#define NXP_SAR_ADC_DMA_BUFF_SZ		(PAGE_SIZE * NXP_SAR_ADC_DMA_SAMPLE_SZ)

Oh, PAGE_SIZE is not good to use. I believe this HW is not tolerant to any page size.
(Note, we made similar mistake in Intel IPU3 camera driver, which is now fixed)

...

> +	/* Protect circular buffers access. */
> +	spinlock_t lock;

+ spinlock.h

> +	/*
> +	 * Save and restore context
> +	 */
> +	u32 inpsamp;
> +	u32 pwdn;

+ types.h

...

> +		ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk) * 3U));

+ delay.h

Actually + math64.h (no need to include math.h which I mentioned elsewhere).

...

> +static inline int nxp_sar_adc_calibration_wait(void __iomem *base)
> +{
> +	u32 msr, ret;
> +
> +	ret = read_poll_timeout(readl, msr, !(msr & REG_ADC_MSR_CALBUSY),

Why not readl_poll_timeout()?

> +				NXP_SAR_ADC_WAIT_US,
> +				NXP_SAR_ADC_CAL_TIMEOUT_US,
> +				true, REG_ADC_MSR(base));
> +	if (ret)
> +		return ret;

> +	if (!(msr & REG_ADC_MSR_CALFAIL))
> +		return 0;

I would expect standard pattern — "errors first", but here either works.

> +	/*
> +	 * If the calibration fails, the status register bit must be
> +	 * cleared
> +	 */
> +	msr &= ~REG_ADC_MSR_CALFAIL;
> +
> +	writel(msr, REG_ADC_MSR(base));
> +
> +	return -EAGAIN;
> +}

...

> +{
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +	int i, ret;

Why is 'i' signed?

> +
> +	for (i = 0; i < info->channels_used; i++) {
> +		ret = nxp_sar_adc_read_data(info, info->buffered_chan[i]);
> +		if (ret < 0) {
> +			nxp_sar_adc_read_notify(info);
> +			return;
> +		}
> +
> +		info->buffer[i] = ret;
> +	}
> +
> +	nxp_sar_adc_read_notify(info);
> +	iio_push_to_buffers_with_timestamp(indio_dev,
> +					   info->buffer,
> +					   iio_get_time_ns(indio_dev));
> +	iio_trigger_notify_done(indio_dev->trig);
> +}

...

> +	/*
> +	 * On disable, we have to wait for the transaction to finish.
> +	 * ADC does not abort the transaction if a chain conversion
> +	 * is in progress.
> +	 * Wait for the worst case scenario - 80 ADC clk cycles.
> +	 */
> +	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80U);

Could it possible go wrong and with low rate clocks (kHz:ish) this will go into
lo-o-o-o-ng *atomic* delay?

> +}

...

> +		nxp_sar_adc_channels_enable(info, 1 >> chan->channel);

1 >> ?!? Did you want BIT(channel)? Or simply channel != 0?

...

> +static int sar_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			 int val, int val2, long mask)
> +{
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +	u32 inpsamp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		/*
> +		 * Configures the sample period duration in terms of
> +		 * the SAR controller clock. The minimum acceptable
> +		 * value is 8. Configuring to a value lower than 8
> +		 * sets the sample period to 8 cycles.  We read the
> +		 * clock value and divide by the sampling timing which
> +		 * gives us the number of cycles expected. The value
> +		 * is 8 bits wide, consequently the max value is 0xFF
> +		 */
> +		inpsamp = clk_get_rate(info->clk) / val - NXP_SAR_ADC_CONV_TIME;
> +		nxp_sar_adc_conversion_timing_set(info, inpsamp);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

> +	return 0;

Return directly from switch-case.

> +}

...

> +static void nxp_sar_adc_dma_cb(void *data)
> +{
> +	struct nxp_sar_adc *info = iio_priv((struct iio_dev *)data);
> +	struct iio_dev *indio_dev = data;
> +	struct dma_tx_state state;
> +	struct circ_buf *dma_buf;
> +	struct device *dev_dma;
> +	unsigned long flags;
> +	u32 *dma_samples;
> +	s64 timestamp;
> +	int idx, ret;
> +
> +	dma_buf = &info->dma_buf;
> +	dma_samples = (u32 *)dma_buf->buf;
> +	dev_dma = info->dma_chan->device->dev;

> +	spin_lock_irqsave(&info->lock, flags);

Why not guard()() from cleanup.h?

> +	dmaengine_tx_status(info->dma_chan,
> +			    info->cookie, &state);

Perfectly one line. No return check?

> +	dma_sync_single_for_cpu(dev_dma, info->rx_dma_buf,
> +				NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
> +	/* Current head position */
> +	dma_buf->head = (NXP_SAR_ADC_DMA_BUFF_SZ - state.residue) /
> +			NXP_SAR_ADC_DMA_SAMPLE_SZ;
> +
> +	/* If everything transferred, avoid an off by one error. */
> +	if (!state.residue)
> +		dma_buf->head--;
> +
> +	/* Something went wrong and nothing transferred. */
> +	if (state.residue == NXP_SAR_ADC_DMA_BUFF_SZ)
> +		goto out;
> +
> +	/* Make sure that head is multiple of info->channels_used */
> +	dma_buf->head -= dma_buf->head % info->channels_used;
> +
> +	/* dma_buf->tail != dma_buf->head condition will become false
> +	 * because dma_buf->tail will be incremented with 1.
> +	 */
> +	while (dma_buf->tail != dma_buf->head) {
> +		idx = dma_buf->tail % info->channels_used;
> +		info->buffer[idx] = dma_samples[dma_buf->tail];
> +		dma_buf->tail = (dma_buf->tail + 1) % NXP_SAR_ADC_DMA_SAMPLE_CNT;
> +		if (idx != info->channels_used - 1)
> +			continue;
> +
> +		/* iio_push_to_buffers_with_timestamp should not be called
> +		 * with dma_samples as parameter. The samples will be smashed
> +		 * if timestamp is enabled.
> +		 */
> +		timestamp = iio_get_time_ns(indio_dev);
> +		ret = iio_push_to_buffers_with_timestamp(indio_dev,
> +							 info->buffer,
> +							 timestamp);
> +		if (ret < 0 && ret != -EBUSY)
> +			dev_err_ratelimited(&indio_dev->dev,
> +					    "failed to push iio buffer: %d",
> +					    ret);
> +	}
> +
> +	dma_buf->tail = dma_buf->head;
> +out:
> +	dma_sync_single_for_device(dev_dma, info->rx_dma_buf,
> +				   NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
> +	spin_unlock_irqrestore(&info->lock, flags);
> +}

...

> +	/*
> +	 * The SAR-ADC has two groups of channels.
> +	 *
> +	 *	- Group #0:
> +	 *	* bit 0-7  : channel 0 -> channel 7
> +	 *	* bit 8-31 : reserved
> +	 *
> +	 *	- Group #32:
> +	 *	* bit 0-7  : Internal
> +	 *	* bit 8-31 : reserved
> +	 *
> +	 * The 8 channels from group #0 are used in this driver for
> +	 * ADC as described when declaring the IIO device and the
> +	 * mapping is the same. That means the active_scan_mask can be
> +	 * used directly to write the channel interrupt mask.
> +	 */
> +	nxp_sar_adc_channels_enable(info, *indio_dev->active_scan_mask);
> +
> +	for_each_set_bit(channel, indio_dev->active_scan_mask, NXP_SAR_ADC_NR_CHANNELS) {

+ bitops.h

> +		info->buffered_chan[info->channels_used++] = channel;
> +	}

{} are redundant.

...

> +static int nxp_sar_adc_dma_probe(struct device *dev, struct nxp_sar_adc *info)
> +{
> +	struct device *dev_dma;
> +	int ret;
> +	u8 *rx_buf;
> +
> +	info->dma_chan = devm_dma_request_chan(dev, "rx");
> +	if (IS_ERR(info->dma_chan))
> +		return PTR_ERR(info->dma_chan);
> +
> +	dev_dma = info->dma_chan->device->dev;
> +	rx_buf = dma_alloc_coherent(dev_dma, NXP_SAR_ADC_DMA_BUFF_SZ,
> +				    &info->rx_dma_buf, GFP_KERNEL);
> +	if (!rx_buf)
> +		return -ENOMEM;
> +
> +	info->dma_buf.buf = rx_buf;
> +
> +	info->dma_config.direction = DMA_DEV_TO_MEM;
> +	info->dma_config.src_addr_width = NXP_SAR_ADC_DMA_SAMPLE_SZ;
> +	info->dma_config.src_maxburst = 1;
> +
> +	ret = devm_add_action_or_reset(dev, nxp_sar_adc_dma_remove, info);
> +	if (ret) {
> +		nxp_sar_adc_dma_remove(info);

> +		return ret;
> +	}
> +
> +	return 0;

	return ret;

> +}

...

> +/*
> + * The documentation describes the reset values for the
> + * registers. However some registers do not have these values after a
> + * reset. It is a not desirable situation. In some other SoC family
> + * documentation NXP recommend to not assume the default values are
> + * set and to initialize the registers conforming to the documentation
> + * reset information to prevent this situation. Assume the same rule
> + * applies here as there is a discrepancy between what is read from
> + * the registers at reset time and the documentation.
> + */
> +static void nxp_sar_adc_set_default_values(struct nxp_sar_adc *info)
> +{
> +	const u32 mcr_default	= 0x00003901;
> +	const u32 msr_default	= 0x00000001;
> +	const u32 ctr_default	= 0x00000014;
> +	const u32 cimr_default	= 0x00000000;
> +	const u32 ncmr_default	= 0x00000000;

What is the purpose of having these constant to be temporary variables in the
code?

> +	writel(mcr_default, REG_ADC_MCR(info->regs));
> +	writel(msr_default, REG_ADC_MSR(info->regs));
> +	writel(ctr_default, REG_ADC_CTR0(info->regs));
> +	writel(ctr_default, REG_ADC_CTR1(info->regs));
> +	writel(cimr_default, REG_ADC_CIMR0(info->regs));
> +	writel(cimr_default, REG_ADC_CIMR1(info->regs));
> +	writel(ncmr_default, REG_ADC_NCMR0(info->regs));
> +	writel(ncmr_default, REG_ADC_NCMR1(info->regs));
> +}

...

> +static int nxp_sar_adc_probe(struct platform_device *pdev)
> +{
> +	const struct nxp_sar_adc_data *data;
> +	struct nxp_sar_adc *info;
> +	struct iio_dev *indio_dev;
> +	struct resource *mem;
> +	struct device *dev = &pdev->dev;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct nxp_sar_adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);

> +	data = of_device_get_match_data(dev);

We have an agnostic alternative in property.h.

> +	info->vref = data->vref;

vref_uV / vref_mV in both cases?

> +	info->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
> +	if (IS_ERR(info->regs))
> +		return dev_err_probe(dev, PTR_ERR(info->regs),
> +				     "failed to get and remap resource");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)

> +		return dev_err_probe(dev, irq, "no irq resource\n");

No need, it prints message if fails.

> +	ret = devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
> +			       dev_name(dev), indio_dev);
> +	if (ret < 0)
> +		dev_err_probe(dev, ret, "failed requesting irq, irq = %d\n", irq);
> +
> +	info->regs_phys = mem->start;
> +	spin_lock_init(&info->lock);
> +
> +	info->clk = devm_clk_get_enabled(dev, "adc");
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(dev, PTR_ERR(info->clk),
> +				     "failed to get the clock\n");

> +	platform_set_drvdata(pdev, indio_dev);

> +	init_completion(&info->completion);
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->info = &nxp_sar_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->channels = nxp_sar_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(nxp_sar_adc_iio_channels);
> +
> +	nxp_sar_adc_set_default_values(info);
> +
> +	ret = nxp_sar_adc_calibration(info);
> +	if (ret) {
> +		dev_err(dev, "Calibration failed: %d\n", ret);
> +		return ret;

Be consistent. It looks like driver is written by 2+ people who do not
communicate with each other.

		return dev_err_probe(...);

> +	}
> +
> +	ret = nxp_sar_adc_dma_probe(dev, info);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize the dma\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &nxp_sar_adc_trigger_handler,
> +					      &iio_triggered_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(dev, "Couldn't initialise the buffer\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "Couldn't register the device.\n");
> +		return ret;
> +	}

> +	dev_info(dev, "Device initialized successfully.\n");

Noise. This should be dropped.

> +	return 0;
> +}

> +};

...

> +

Redundant blank line.

> +module_platform_driver(nxp_sar_adc_driver);

-- 
With Best Regards,
Andy Shevchenko



