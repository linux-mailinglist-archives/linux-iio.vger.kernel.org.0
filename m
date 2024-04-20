Return-Path: <linux-iio+bounces-4405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3F8ABC37
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 17:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A602028172D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD4F28DDF;
	Sat, 20 Apr 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEY1Mgxp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E47F;
	Sat, 20 Apr 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713627258; cv=none; b=D2K5rvcuoWYR+sGhFHJrWgZ1MBKXeA0FMbhBweikMOUjaG5tAzj/kWH1Ot/VFqEiyf5w+Ar+A2eC2xppLylOM3q0I2VWiEnuxFl4G6ab8DTAYGhrmRjLmjkFhx+eTppMakvuVAPyA9H7Z812JzobNU7tPSqq9OYiPcprvIUklc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713627258; c=relaxed/simple;
	bh=kU9vY1riYEmT4bSzAjudG1GDTXrNljQFD7zMC7TPRdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8JPPYhRHeu+N6eYH14R7snjW0K5LSG6YaiXcldbD2S87aofaCZFBaTirYAmp7GdpQemDkP2i+JHTh4/h5ZtU4Do38V3esEr/lqvnwecBPLrbJs/jr1BPeq/YxhngU2h0j2Nqc89UErK60erThWu45jdnUHpS4i1LM/VtvXxvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEY1Mgxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5092C072AA;
	Sat, 20 Apr 2024 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713627258;
	bh=kU9vY1riYEmT4bSzAjudG1GDTXrNljQFD7zMC7TPRdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EEY1Mgxpcfq1qnRGNgYJBE4oSX28Yj/HOsoV2uToS3xIcC0U7xS2yFnwUbBnGecgb
	 nt6P02geDrtj23Z2hMK3szz/RN73Us20r37A41bbhkLjPwdUCJJ3vEMOWrMEGnJD3G
	 JOb9uwi92f2rgyqtKnH5s462FBqoJIbcRkTf6W0rfapDy9/xrGohkLTGcMyhOVWVpy
	 qOUsloZsf7Vlmiby4CwKAFUN2wb/lg/hKw1Olhh/61rpcaJPqVsWR4t3nyUJcs5agh
	 9V8XcBiZV9rXg1XTu6vh4IoEsVib0/PuACoUfLP+6YUKYxRVB8XBjLOGVtExy/K/BO
	 zygW5MakTqRZQ==
Date: Sat, 20 Apr 2024 16:34:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 8/8] iio: adc: ad9467: support digital interface
 calibration
Message-ID: <20240420163404.0fc01ed5@jic23-huawei>
In-Reply-To: <20240419-ad9467-new-features-v1-8-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-8-3e7628ff6d5e@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 17:36:51 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> To make sure that we have the best timings on the serial data interface
> we should calibrate it. This means going through the device supported
> values and see for which ones we get a successful result. To do that, we
> use a prbs test pattern both in the IIO backend and in the frontend
> devices. Then for each of the test points we see if there are any
> errors. Note that the backend is responsible to look for those errors.
> 
> As calibrating the interface also requires that the data format is disabled
> (the one thing being done in ad9467_setup()), ad9467_setup() was removed
> and configuring the data fomat is now part of the calibration process.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Trivial comments inline.

Jonathan

> ---
>  drivers/iio/adc/ad9467.c | 337 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 296 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 7db87ccc1ea4..44552dd6f4c6 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -4,6 +4,9 @@
>   *
>   * Copyright 2012-2020 Analog Devices Inc.
>   */
> +
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
>  #include <linux/cleanup.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -100,6 +103,8 @@
>  #define AD9467_DEF_OUTPUT_MODE		0x08
>  #define AD9467_REG_VREF_MASK		0x0F
>  
> +#define AD9647_MAX_TEST_POINTS		32
> +
>  struct ad9467_chip_info {
>  	const char		*name;
>  	unsigned int		id;
> @@ -110,6 +115,8 @@ struct ad9467_chip_info {
>  	unsigned long		max_rate;
>  	unsigned int		default_output_mode;
>  	unsigned int		vref_mask;
> +	unsigned int		num_lanes;
> +	bool			has_dco;

What is dco?  Perhaps a comment, or expand the naming somewhat.

>  };

>  
> +static void ad9467_dump_table(const unsigned long *err_map, unsigned int size,
> +			      bool invert)
> +{
> +#ifdef DEBUG
> +	unsigned int bit;
> +
> +	pr_debug("Dump calibration table:\n");

If it's useful, poke it in debugfs, otherwise, drop this code.

> +	for (bit = 0; bit < size; bit++) {
> +		if (bit == size / 2) {
> +			if (!invert)
> +				break;
> +			pr_cont("\n");
> +		}
> +
> +		pr_cont("%c", test_bit(bit, err_map) ? 'x' : 'o');
> +	}
> +#endif
> +}
> +

> +static int ad9467_calibrate_apply(const struct ad9467_state *st,
> +				  unsigned int val)
> +{
> +	unsigned int lane;
> +	int ret;
> +
> +	if (st->info->has_dco) {
> +		int ret;
Shadowing ret above.

> +
> +		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_OUTPUT_DELAY,
> +				       val);
> +		if (ret)
> +			return ret;
> +
> +		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
> +					AN877_ADC_TRANSFER_SYNC);
> +	}
> +
> +	for (lane = 0; lane < st->info->num_lanes; lane++) {
> +		ret = iio_backend_iodelay_set(st->back, lane, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

> +
> +static int ad9467_calibrate(const struct ad9467_state *st)

Some docs on the sequence or a reference would be good.

> +{
> +	DECLARE_BITMAP(err_map, AD9647_MAX_TEST_POINTS * 2);
> +	unsigned int point, val, inv_val, cnt, inv_cnt = 0;
> +	/*
> +	 * Half of the bitmap is for the inverted signal. The number of test
> +	 * points is the same though...
> +	 */
> +	unsigned int test_points = AD9647_MAX_TEST_POINTS;
> +	unsigned long sample_rate = clk_get_rate(st->clk);
> +	struct device *dev = &st->spi->dev;
> +	bool invert = false, stat;
> +	int ret;
> +
> +	ret = ad9647_calibrate_prepare(st);
> +	if (ret)
> +		return ret;
> +retune:
> +	ret = ad9647_calibrate_polarity_set(st, invert);
> +	if (ret)
> +		return ret;
> +
> +	for (point = 0; point < test_points; point++) {
> +		ret = ad9467_calibrate_apply(st, point);
> +		if (ret)
> +			return ret;
> +
> +		ret = ad9467_calibrate_status_check(st, &stat);
> +		if (ret < 0)
> +			return ret;
> +
> +		__assign_bit(point + invert * test_points, err_map, stat);
> +	}
> +
> +	if (!invert) {
> +		cnt = ad9467_find_optimal_point(err_map, 0, test_points, &val);
> +		/*
> +		 * We're happy if we find, at least, three good test points in
> +		 * a row.
> +		 */
> +		if (cnt < 3) {
> +			invert = true;
> +			goto retune;
> +		}
> +	} else {
> +		inv_cnt = ad9467_find_optimal_point(err_map, test_points,
> +						    test_points, &inv_val);
> +		if (!inv_cnt && !cnt)
> +			return -EIO;
> +	}
> +
> +	ad9467_dump_table(err_map, BITS_PER_TYPE(err_map), invert);
> +
> +	if (inv_cnt < cnt) {
> +		ret = ad9647_calibrate_polarity_set(st, false);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/*
> +		 * polarity inverted is the last test to run. Hence, there's no
> +		 * need to re-do any configuration. We just need to "normalize"
> +		 * the selected value.
> +		 */
> +		val = inv_val - test_points;
> +	}
> +
> +	if (st->info->has_dco)
> +		dev_dbg(dev, "%sDCO 0x%X CLK %lu Hz\n", inv_cnt >= cnt ? "INVERT " : "",
> +			val, sample_rate);
> +	else
> +		dev_dbg(dev, "%sIDELAY 0x%x\n", inv_cnt >= cnt ? "INVERT " : "",
> +			val);
> +
> +	ret = ad9467_calibrate_apply(st, val);
> +	if (ret)
> +		return ret;
> +
> +	/* finally apply the optimal value */
> +	return ad9647_calibrate_stop(st);
> +}
> +



