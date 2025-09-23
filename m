Return-Path: <linux-iio+bounces-24370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5A1B96935
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CCC179B5A
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B6259C83;
	Tue, 23 Sep 2025 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0hRix8m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9F1805E
	for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641209; cv=none; b=hzaKPa9HJJ6CSSD0+1R6L6OAXrowPXwRhJXJfj15WVnh6i3qdzNfYhsmmtG7/r9mvSKcN+A1ZnmrZsHmTPF4Uy1MnLNXd+AkkWh3L/ZF5IgHSEN5lkgtXxpp3890TxCT0V2MqNuSvTofrY9/CNHbMpFWFB+7OsTZpg3GQlvsUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641209; c=relaxed/simple;
	bh=kaKJnwuEkzZmdkmDiRMNrFo/E/FqZSWxp73K52uXOY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwo2K69H4j8XHiBm1jcMB56yvYegWI9T8CwP4ST8Rxhcfyszcw3eHtAkafd99++tngtxB5VZYRxD6PLxDkuvgCAcwN3VirMMgT2sD0KdW58PUGvvvJEE2kPk10eR6wdy5AgqKl6QN9YMskL4+y5aGcjjgVaBOQh1AgblhR+Ps3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0hRix8m; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f3405c38aso2165782b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758641207; x=1759246007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtLLJPUyvnbUDs0ep8FNq7qhKgC6O8fsZCUGkck74jg=;
        b=F0hRix8mFCj6SdW1bsK0MYkDJ6uVqvYPFTfuXpDL/BkBO65CVxogfh3bcd82yrF0NR
         5jOavuRK0DrYIxsYBb7ecqsjnOwUvWUfzcIwA0KDAapXjammQFN9ZTOn40Mfzwb4snQX
         z0an61zzuUpyMJKOPq44t5cgw4y7zlHuGkZK8ZwHZFnHQmB90vAqo9dhX5BXAL2aqI0q
         KC9EDm/Xx8iQdVcGxJqunfaMd1N++hTdQuxO8Y2OqqOqc821iCO+uvfo2edBKMJlyNIY
         GzCy7JcJ8nhmNBZPPMlkigDNJnwPsF3Ep146Sa9ZQkN1wjD2mrDVoUXq4bwhbDD+vzZS
         BHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641207; x=1759246007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtLLJPUyvnbUDs0ep8FNq7qhKgC6O8fsZCUGkck74jg=;
        b=hB2XqvfVX7x7gxahL7C08APdBQ3O1jPhvnlz8SKXmtvrVa1pbcDrEk1yzfEjrAd4Bq
         UFOjh8M8DOp4x0w9Pep3ClV1j9gkkNGUHNq6m6Exsh4XubhepJraHBs7MXlnwQljy1w2
         oa/ibBiGQTGdXKNsrXOeghWdeJnm/j2MRvd4AQsUivtWTSGmbv5idTlolpGZr1+j3zFz
         e73sUlOHvioM3KO5ApbvJhJZPzjqHUvutIhbzANhJc0fim5IIohpcA6eslK2TsT8DnFq
         LdrDFP5Y/qAgz75CiD7XsyDaRTGhTb7f+hLz2cSpHeff3sUo9RYUzgArhVLioPpdaduZ
         pLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKzUaEfTpCEFeIIlR5VpYPwvGCyA82lF/ZH2Dcbfk2aiG7MWHDblXGEWfCDyawLrmcD6zbJiLIfpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAnV11sixrLFT69qUzxML0vdoMpky9+500KD8qqloW8qmIGdQ
	lwBLKmcaJ70kNJd0ER18C9VQKL/a64ffq319AyKRwD+9lAvyJTpsJtKl
X-Gm-Gg: ASbGncuLwQekh5zg79HqtmeNFD51ZSbarNElqHj/1OLMAxA6yG1Di1LeNDvlcHNuAT1
	qSELMq5dK+H4h1QXtLcx48/xA7s3q8hxTKS4E/llgciRESvHyrbyHioAnxwTNZg7MkhPN2r+YU+
	GG0QkH/Eaoe22FJ1p7Phz5a4S+b8Mm78bG6LPptdoFT3W+rnAoLaxR5dOxqwVv8V5h0FCzdbJ8A
	0UgpNtooVlpG0hZwITSKZwmBWvqhitfEtjgPqcGT/RqEaPDF5+8+FeP85k0m+mUYUyVnwmE90PY
	ESzsy6TJzQwz4cEPA19abnE5DyYJaD3rEm2maNzIjfj43kI0X5y3uhMoUJjzTeW8pT8ED3KjjIq
	gaGSD2gA709NdCAXf4r4TRnpDPhXdUkXszn4wG5SeeQ==
X-Google-Smtp-Source: AGHT+IF3IQzctelwt6QED/lVfPI8J15a2FqB0oJ/xmEvDqfE+VEGFk89FOsvI3j+XpDLzUaWQAhfXA==
X-Received: by 2002:a17:903:1590:b0:26b:7a8b:32cc with SMTP id d9443c01a7336-27cc3d05a95mr38529245ad.17.1758641206875;
        Tue, 23 Sep 2025 08:26:46 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27a9eecd148sm49330535ad.122.2025.09.23.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:26:45 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:27:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v2 6/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <aNK8ZZu74mK0_ygB@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <da55c0ed6fe895dc84e79c8b64e5923a4851e58f.1758214628.git.marcelo.schmitt@analog.com>
 <30659b16-290d-4ae5-a644-214c106bbe87@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30659b16-290d-4ae5-a644-214c106bbe87@baylibre.com>

Hi David, thanks for the insightful review.

On 09/22, David Lechner wrote:
> On 9/18/25 12:39 PM, Marcelo Schmitt wrote:
> > AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> > samples per second (MSPS). Not all SPI controllers are able to achieve such
> > high throughputs and even when the controller is fast enough to run
> > transfers at the required speed, it may be costly to the CPU to handle
> > transfer data at such high sample rates. Add SPI offload support for AD4030
> > and similar ADCs to enable data capture at maximum sample rates.
> 
> I tried testing this with AD4630-24 but didn't have luck in actually
> capturing data. I'm 100% sure the problem is with the FPGA. And the
> evaluation board doesn't have any place to attach a logic analyzer for
> debugging. That means that I wasn't able to reliabably test this code
> yet. But I don't expect my problems to be solved any time soon, so I
> don't want to let that hold up progress. I would have really liked to
> have been able to see the actual timings over the wire to make sure
> we got all of that correct.
> 
Even if you hook up probes to the SPI lines, you might not be able to logic
analyze the transfers at frequencies like 100 MHz or even at 80 MHz unless you
have a very fast logic analyzer or oscilloscope. To debug these signals we
usually change the HDL verilog to add ILA debug cores to record the signals on
the FPGA. I'll see if I can get or build the project with those ILA cores set.
Another thing is getting the correct combination of HDL + device tree because
we have a few possible HDL build configurations (for number of lanes, clock mode,
DDR/DTR, and capture zone) and the device tree must be coherent with what runs
on the FPGA. I'll send you some of boot files I was using during my tests.

> > ---
...
> > [IIO]
> >> Why using slower speed for offload?
> > Looks like it's the same max speed for both register access and data sample.
> > So, just reusing the existing define for the max transfer speed.
> 
> I don't follow. The "REG" in AD4030_SPI_MAX_REG_XFER_SPEED stands for
> "register". The actual max speed for reading sample data should be coming
> from the devicetree since it is faster and depends on the wiring and VIO
> voltage. It could be as much as 102 MHz.
> 
I have finally I noticed the SPI compatible mode timings. Sure, will adapt to
use faster sample rate when possible.


> Unrelated to this series, I still think 80 MHz is faster that it needs
> to be for AD4030_SPI_MAX_REG_XFER_SPEED. It is fine to do them slower,
> e.g. at 10 MHz to reduce the risk of errors and also makes it easier to
> debug using a logic analyzer.

Sure, will do that.

> 
> > 
> >  drivers/iio/adc/Kconfig  |   3 +
> >  drivers/iio/adc/ad4030.c | 485 +++++++++++++++++++++++++++++++++++----
> >  2 files changed, 445 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 58a14e6833f6..2a44fcaccf54 100644
...
> > +	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
> > +	/*
> > +	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
> > +	 * rounded PWM's value is less than 10, increase the target value by 10
> > +	 * and attempt to round the waveform again, until the value is at least
> > +	 * 10 ns. Use a separate variable to represent the target in case the
> > +	 * rounding is severe enough to keep putting the first few results under
> > +	 * the minimum 10ns condition checked by the while loop.
> > +	 */
> > +	do {
> > +		cnv_wf.duty_length_ns = target;
> > +		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
> > +		if (ret)
> > +			return ret;
> > +		target += AD4030_TCNVH_NS;
> > +	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
> > +
> > +	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
> > +		return -EINVAL;
> 
> I hit this error during testing with the default max_sample_rate_hz assigned
> in probe. We could have a loop for this too to try to get the closest valid
> period rather than erroring if the exact value isn't available.
> 
Yes, this makes sense. Though, looping to try to get a suitable period wouldn't
potentially also change the duty_length we settled above?

> > +
> > +	offload_period_ns = cnv_wf.period_length_ns;
> > +	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
> 
...
> > +static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, int freq)
> > +{
> > +	struct ad4030_state *st = iio_priv(indio_dev);
> > +
> > +	/*
> > +	 * We have no control over the sampling frequency without SPI offload
> > +	 * triggering.
> > +	 */
> > +	if (!st->offload_trigger)
> > +		return -ENODEV;
> > +
> > +	if (!in_range(freq, 1, st->chip->max_sample_rate_hz))
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&st->lock);
> 
> Why not iio_device_claim_direct() instead of a new lock? We wouldn't
> want to change the sampling frequency during a buffered read anyway.
> This driver already uses iio_device_claim_direct() to protect other
> register access.

The new lock is to protect concurrent updates of the oversampling and sampling
frequency. Since, oversampling and the sampling frequency properties are
mutually dependent one from another, a simultaneous write to those attributes
could lead to an invalid oversamp + samp freq configuration.

> 
> > +	return __ad4030_set_sampling_freq(st, freq, st->avg_log2);
> > +}
> > +
...
> > +static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4030_state *st = iio_priv(indio_dev);
> > +	u8 offload_bpw;
> > +
> > +	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
> > +		offload_bpw = 32;
> > +	else
> > +		offload_bpw = st->chip->precision_bits;
> > +
> 
> > +	st->offload_xfer.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;
> 
> As mentioned at the beginning, drop this line and let it use the max
> speed from the devicetree.
> 
> > +	st->offload_xfer.bits_per_word = roundup_pow_of_two(offload_bpw);
> 
> Why roundup_pow_of_two()? The SPI controller can do 24 bits per word.
> And if we are reading both a 24-bit value and the common mode voltage,
> this would cause both to be read in 1 word.
> 
> Speaking of which, I think this will need a possible second xfer with
> bpw=8 if we want to read the common mode voltage.
> 
> Or, if the intention was to not allow it, we need different scan masks.
> But I don't see a reason why we could not allow it.
> 
Nothing says we couldn't support offloading transfers with
differential + common-mode data, at least in theory. So, I didn't felt like it
should be prevented. Though, offloading differential + common-mode data is
a configuration I couldn't really test with ADAQ4216 because the HDL is ... peculiar.


> Or, if this is making a assumptions about extra hardware being present
> to move bits around between reading them over the SPI bus and pushing the
> values to DMA, then there should be some comments about that. More on that
> below.
> 
> > +	st->offload_xfer.len = spi_bpw_to_bytes(offload_bpw);
> > +	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> > +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> > +}
> > +
...
> > +static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
> > +				    struct ad4030_state *st)
> > +{
> > +	struct device *dev = &st->spi->dev;
> > +	struct dma_chan *rx_dma;
> > +
> > +	indio_dev->setup_ops = &ad4030_offload_buffer_setup_ops;
> > +
> > +	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
> > +							   SPI_OFFLOAD_TRIGGER_PERIODIC);
> > +	if (IS_ERR(st->offload_trigger))
> > +		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
> > +				     "failed to get offload trigger\n");
> > +
> > +	st->offload_trigger_config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
> 
> If we want to be really strict/generic here, we should not be allowing
> chips with num_voltage_inputs == 2 and a single SPI bus/deserializer (i.e.
> channel data is interleaved). In this case, extra hardware is required
> to do the de-interleaving (i.e. the spi_axis_reorder IP block).

By channel data is interleaved you mean data from both channels going out on
SDO0 (LANE_MD == 0b11)? In that case, yes, I think so. Only the ADC driver would
know about data being interleaved and it would not be able to descramble it when
data gets pushed up through DMA.

> 
> We could take the easy way out and just always assume that is there.
> In that case, we should makes some comments here about such assumptions.
> 
> Or we could actually describe it properly in the devicetree and check
> for that here. This came up during the discussions when I was upstreaming
> SPI offload support. It would look something like this...
> 
> In the devicetree, instead of having the DMA connected to the SPI controller,
> we now have a separate IP block with it's own node between them.
> 
> /* spi_axis_reorder IP block */
> reorder: offload-stream-sink@4000000 {
> 	compatible = "adi,axi-spi-reorder";
> 	reg = <0x4000000 0x1000>;
> 	clocks = <&spi_clk>;
> 	dmas = <&adc_dma>;
> };
> 
> spi@5000000 {
> 	compatible = "adi,axi-spi-engine-1.00.a
> 	reg = <0x4000000 0x1000>;
> 	clocks = <&clkc 15>, <&spi_clk>;
> 	clock-name "s_axi_aclk", "spi_clk";
> 
> 	trigger-sources = <&pwm_trigger>;
> 	offload-streams = <&reorder>;
> 	offload-stream-names = "offload0-rx";
> 
> 	...
> };
> 
> Then here in the driver, we would need a different (non-existing)
> API to get the DMA from this offload-stream rather than calling
> devm_spi_offload_rx_stream_request_dma_chan(). Or extend the SPI
> controller to handle that.
> 
> Or 3rd option: If easy way is not acceptable and "right way" is too much
> work, we could just return error here for num_voltage_inputs == 2 until
> we add support for SPI controllers with two buses/deserializers.
> 
3rd option sounds more reasonable for the moment.
I think this might, alternatively, be supported as something associated with
spi-rx/tx-bus-width dt property. The question we seem to be trying to answer is,
how data coming from a multi-line bus is expected to be delivered?


> > +
> > +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> > +	if (IS_ERR(rx_dma))
> > +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> > +				     "failed to get offload RX DMA\n");
> > +
> > +	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
> > +							   IIO_BUFFER_DIRECTION_IN);
> > +}
> > +

Thanks,
Marcelo

