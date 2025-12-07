Return-Path: <linux-iio+bounces-26914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 843A5CAB955
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 20:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B5D3016CD8
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A829B8E0;
	Sun,  7 Dec 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQAd/hFO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D481D90DD;
	Sun,  7 Dec 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765135315; cv=none; b=lqlAZmtrxIlpbbPADB5qHyRfX23jaIrAa6ICQPkfyyoLy3/nTnkGiBFNuj/gT6zP3AS/cLKlMhJH6IB2cEBsAgRQ3CaKPn5jUbaN3TeTrCssCpmqwpK9n9QJXw9sKhMtue8B4DrxBG/ZO3sxodyKJ18bUNm3yxA0ucNOkKeZUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765135315; c=relaxed/simple;
	bh=Y8uX2NB9R7BEetXh6OX5/itsa/c1bJMyd0J7HZw6nqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtsPJbc3MKlBZioV7uUha7VChpqb838bT1og87CPXmnvyTNVBV3i5IMjf+K2hYvBvBmPnFBAgkDMlo/u7YKImketNLScKRAnhSQmVB0cHsDxujEAsoQ5rPaYf4nEpeU5aDlchJaBF375cigEakORgsdY0WaWBgjGl1nl+QTMTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQAd/hFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A987DC4CEFB;
	Sun,  7 Dec 2025 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765135315;
	bh=Y8uX2NB9R7BEetXh6OX5/itsa/c1bJMyd0J7HZw6nqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZQAd/hFOdBh9kjcO0ylLdBCnJAfes5IOT+YtXlFJayQfFCRbwXzK3/Lj2avUuSR66
	 J0zAaBgbqU73fG0xqjjmigxpGt2AtsowGR72rISkFtv1YxxtLRraTdn9VNtlMkinUu
	 7eXTKr03tnbH+IT+D2tleiO9wmzfn0oyIj3nKUis1nmHPGrHdYOYVlL5TIbnEfO5Q+
	 H2hxxlzVXaNKtgsGLEURMYu7OgxG0UtK/6dCrJecye+/HYA/DYtsdLXaJHb7Bs663k
	 9VxQAyb6h8nIMQ5mI63yiegiadLPhdgBpjtN+YeajHB2spMBffkf6ZvDtn5EYt7ew8
	 xm4bXL/2EvoNQ==
Date: Sun, 7 Dec 2025 19:21:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com, vkoul@kernel.org
Subject: Re: [PATCH v8 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20251207192145.646e3d2d@jic23-huawei>
In-Reply-To: <20251119223905.107065-3-daniel.lezcano@linaro.org>
References: <20251119223905.107065-1-daniel.lezcano@linaro.org>
	<20251119223905.107065-3-daniel.lezcano@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Nov 2025 23:39:05 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> The NXP S32G2 and S32G3 platforms integrate a successive approximation
> register (SAR) ADC. Two instances are available, each providing 8
> multiplexed input channels with 12-bit resolution. The conversion rate
> is up to 1 Msps depending on the configuration and sampling window.
>=20
> The SAR ADC supports raw, buffer, and trigger modes. It can operate
> in both single-shot and continuous conversion modes, with optional
> hardware triggering through the cross-trigger unit (CTU) or external
> events. An internal prescaler allows adjusting the sampling clock,
> while per-channel programmable sampling times provide fine-grained
> trade-offs between accuracy and latency. Automatic calibration is
> performed at probe time to minimize offset and gain errors.
>=20
> All modes have been validated on the S32G274-RDB2 platform using an
> externally generated square wave captured by the ADC. Tests covered
> buffered streaming via IIO, trigger synchronization, and accuracy
> verification against a precision laboratory signal source.
>=20
> One potential scenario, not detected during testing, is that in some
> corner cases the DMA may already have been armed for the next
> transfer, which can lead dmaengine_tx_status() to return an incorrect
> residue.  The callback_result() operation=E2=80=94intended to supply the
> residue directly and eliminate the need to call
> dmaengine_tx_status()=E2=80=94also does not work.  Attempting to use
> dmaengine_pause() and dmaengine_resume() to prevent the residue from
> being updated does not work either.
>=20
> This potential scenario should apply to any driver using cyclic DMA.
> However, no current driver actually handles this case, and they all rely
> on the same acquisition routine (e.g., the STM32 implementation).
> The NXP SAR acquisition routine has been used in production for several
> years, which is a good indication of its robustness.
>=20
> As the IIO is implementing the cyclic DMA support API, it is not worth
> to do more spins to the current routine as it will go away when the
> new API will be available.
>=20
> The driver is derived from the BSP implementation and has been partly
> rewritten to comply with upstream requirements. For this reason, all
> contributors to the original code are listed as co-developers.
>=20
> Originally-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.c=
om>
> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Hi Daniel,

Sorry for delay - I had to send the pull a tiny bit early to increase chance
of it landing before I went offline for 10 days. This would have been very
marginal anyway to make it with 1 week before merge window (which is my nor=
mal
cut off +- a day or two). In practice that means near final code on list be=
fore
rc6 so that I'm sure others have had time to review.  I do sympathise though
as I'm often the one trying to sneak code into the kernel very late in cycl=
es.

On a final read I noticed one thing (see below).  I'm fine making that chan=
ge
whilst applying the series if you don't mind me doing so.  It is just above
the level that I'd tweak without asking first!

Jonathan


> +++ b/drivers/iio/adc/nxp-sar-adc.c


> +static inline int nxp_sar_adc_calibration_wait(void __iomem *base)
> +{
> +	u32 msr, ret;
> +
> +	ret =3D readl_poll_timeout(NXP_SAR_ADC_MSR(base), msr,
> +				 !FIELD_GET(NXP_SAR_ADC_MSR_CALBUSY, msr),
> +				 NXP_SAR_ADC_WAIT_US,
> +				 NXP_SAR_ADC_CAL_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(NXP_SAR_ADC_MSR_CALFAIL, msr)) {
> +		/*
> +		 * If the calibration fails, the status register bit
> +		 * must be cleared.

Really trivial but slightly short wrap for standard 80 chars.
So trivial I might no bother changing it.
> +		 */
> +		FIELD_MODIFY(NXP_SAR_ADC_MSR_CALFAIL, &msr, 0x0);
> +		writel(msr, NXP_SAR_ADC_MSR(base));
> +
> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +}

> +static void nxp_sar_adc_dma_cb(void *data)
> +{
> +	struct iio_dev *indio_dev =3D data;
> +	struct nxp_sar_adc *info =3D iio_priv(indio_dev);
> +	struct dma_tx_state state;
> +	struct circ_buf *dma_buf;
> +	struct device *dev_dma;
> +	u32 *dma_samples;
> +	s64 timestamp;
> +	int idx, ret;
> +
> +	guard(spinlock_irqsave)(&info->lock);
> +
> +	dma_buf =3D &info->dma_buf;
> +	dma_samples =3D (u32 *)dma_buf->buf;
> +	dev_dma =3D info->dma_chan->device->dev;
> +
> +	/*
> +	 * DMA in some corner cases might have already be charged for
> +	 * the next transfer. Potentially there can be a race where
> +	 * the residue changes while the dma engine updates the
> +	 * buffer. That could be handled by using the
> +	 * callback_result() instead of callback() because the residue
> +	 * will be passed as a parameter to the function. However this
> +	 * new callback is pretty new and the backend does not update
> +	 * the residue. So let's stick to the version other drivers do
> +	 * which has proven running well in production since several
> +	 * years.
> +	 */
> +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
> +
> +	dma_sync_single_for_cpu(dev_dma, info->rx_dma_buf,
> +				NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
> +
> +	/* Current head position. */
> +	dma_buf->head =3D (NXP_SAR_ADC_DMA_BUFF_SZ - state.residue) /
> +			NXP_SAR_ADC_DMA_SAMPLE_SZ;
> +
> +	/* If everything was transferred, avoid an off by one error. */
> +	if (!state.residue)
> +		dma_buf->head--;
> +
> +	/* Something went wrong and nothing transferred. */
> +	if (state.residue =3D=3D NXP_SAR_ADC_DMA_BUFF_SZ)
> +		goto out;

This doesn't align with the guidance in cleanup.h about not mixing
stuff from there with goto style error handling.  However
that guidance is just an easy way to describe how to avoid issues
that can occur around gotos that cross the definition of new stuff
buried in guard() etc.  So this is (I believe anyway) not actually a bug
just something considered bad practice because it leaves a footgun that
someone may encounter in later refactoring of this driver.

Easiest route here is just cope with the extra indent and do

	/* Transfer occurred as expected */
	if (state.residue !=3D NXP_SAR_ADC_DMA_BUF_SZ) {
		/* Make sure that head is multiple of info->channels_used. */
		dma_buf->head -=3D dma_buf->head % info->channels_used;

		/*
		 * dma_buf->tail !=3D dma_buf->head condition will become false
		 * because dma_buf->tail will be incremented with 1.
		 */
		while (dma_buf->tail !=3D dma_buf->head) {
			idx =3D dma_buf->tail % info->channels_used;
			info->buffer[idx] =3D dma_samples[dma_buf->tail];
			dma_buf->tail =3D (dma_buf->tail + 1) % NXP_SAR_ADC_DMA_SAMPLE_CNT;
			if (idx !=3D info->channels_used - 1)
				continue;
=09
			/*
			 * iio_push_to_buffers_with_ts() should not be
			 * called with dma_samples as parameter. The samples
			 * will be smashed if timestamp is enabled.
			 */
			timestamp =3D iio_get_time_ns(indio_dev);
			ret =3D iio_push_to_buffers_with_ts(indio_dev,
							  info->buffer,
							  sizeof(info->buffer),
							  timestamp);
			if (ret < 0 && ret !=3D -EBUSY)
				dev_err_ratelimited(&indio_dev->dev,
						    "failed to push iio buffer: %d",
						    ret);
		}
	}
	dma_sync_single_for_device(dev_dma, info->rx_dma_buf,
				   NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);

Not that bad, and avoids potential grumpy Linus (he contributed that partic=
ular
statement in cleanup.h IIRC)

> +
> +	/* Make sure that head is multiple of info->channels_used. */
> +	dma_buf->head -=3D dma_buf->head % info->channels_used;
> +
> +	/*
> +	 * dma_buf->tail !=3D dma_buf->head condition will become false
> +	 * because dma_buf->tail will be incremented with 1.
> +	 */
> +	while (dma_buf->tail !=3D dma_buf->head) {
> +		idx =3D dma_buf->tail % info->channels_used;
> +		info->buffer[idx] =3D dma_samples[dma_buf->tail];
> +		dma_buf->tail =3D (dma_buf->tail + 1) % NXP_SAR_ADC_DMA_SAMPLE_CNT;
> +		if (idx !=3D info->channels_used - 1)
> +			continue;
> +
> +		/*
> +		 * iio_push_to_buffers_with_ts() should not be
> +		 * called with dma_samples as parameter. The samples
> +		 * will be smashed if timestamp is enabled.
> +		 */
> +		timestamp =3D iio_get_time_ns(indio_dev);
> +		ret =3D iio_push_to_buffers_with_ts(indio_dev, info->buffer,
> +						  sizeof(info->buffer),
> +						  timestamp);
> +		if (ret < 0 && ret !=3D -EBUSY)
> +			dev_err_ratelimited(&indio_dev->dev,
> +					    "failed to push iio buffer: %d",
> +					    ret);
> +	}
> +
> +	dma_buf->tail =3D dma_buf->head;
> +out:
> +	dma_sync_single_for_device(dev_dma, info->rx_dma_buf,
> +				   NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
> +}

