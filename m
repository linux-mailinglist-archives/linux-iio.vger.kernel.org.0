Return-Path: <linux-iio+bounces-10575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D099D697
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D060284747
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3621CACD9;
	Mon, 14 Oct 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3ykNKlJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD734231C95;
	Mon, 14 Oct 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930839; cv=none; b=LENdcHjRp3frccPQHHVRmkIq3iqlrL0Oi2Ib2pE9q6q4md5drX+Dqc0rgRlpg1/bOHqRxuat7SsxVHgIuPpo5eJWTYYF6rmeIE6MqxrH8TPIN+OAHrAAtVcq7uME7u4P3BFHu87/DA5ZVIIeqZ6Mwfr8qhLRkiOrZLht8/CvkNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930839; c=relaxed/simple;
	bh=orlkwQXM2I3OU3tc6CiGdUbLmNgwRmnnKgD6e4DJPq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrbNU4/gEUBCfSL61OKil/49BncQUh+x4d0VL2+yS7JZ3xqKGgAgLXvQ47RVJPsT4F/pkNOk8lcEG8YyBYlHeiRa0yb3yvhkX1yaT98tKi2LlCNGFG2h9sG+KIQ1yi5PWIU5FfXqN5XMwpHfqRzW1SKTG/4EUxx0lGx3CuE8TaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3ykNKlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E91C4CED0;
	Mon, 14 Oct 2024 18:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728930839;
	bh=orlkwQXM2I3OU3tc6CiGdUbLmNgwRmnnKgD6e4DJPq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X3ykNKlJX2SA0FuyhVHBkDs0cQTNz0wWsHe5Oc+0ls2NlDxbW6OyTRbH2cKs8s6/e
	 Egar6nR9ccgfzfIzMaaasZFLbfWUntYoYaYsBH67wvF11CbRWQVFE9Asnmdssepb2i
	 iyTHS/wT89f2Xusxq4GH1FRBCxa8Dw7+Up+wmYzCBIprLSbEEyziVPT+n38DhoyASu
	 B1b0r2fkxIaadspQXPcbqpErdqMpBW3ubxXRevJe87ycFRtsjclUDXyD8YeP6hDtaQ
	 V/bXXGcBGwhsx0ihyYewI00DBOZhz1U6aAlBcXZPzG8lKJNjZby5DieqKlPGvpMPDQ
	 334CmIq+revOQ==
Date: Mon, 14 Oct 2024 19:33:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: adc: ad7625: add driver
Message-ID: <20241014193348.6f228be6@jic23-huawei>
In-Reply-To: <20240909-ad7625_r1-v5-2-60a397768b25@baylibre.com>
References: <20240909-ad7625_r1-v5-0-60a397768b25@baylibre.com>
	<20240909-ad7625_r1-v5-2-60a397768b25@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Sep 2024 10:30:48 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add a driver for the AD762x and AD796x family of ADCs. These are
> pin-compatible devices using an LVDS interface for data transfer,
> capable of sampling at rates of 6 (AD7625), 10 (AD7626), and 5
> (AD7960/AD7961) MSPS, respectively. They also feature multiple voltage
> reference options based on the configuration of the EN1/EN0 pins, which
> can be set in the devicetree.
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
0-day found an issue. I've fixed up as:
diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index 19c15002d96c..ddd1e4a26429 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -452,9 +452,10 @@ static const struct iio_buffer_setup_ops ad7625_buffer_setup_ops = {
        .postdisable = &ad7625_buffer_postdisable,
 };
 
-static int devm_ad7625_pwm_get(struct device *dev, struct clk *ref_clk,
+static int devm_ad7625_pwm_get(struct device *dev,
                               struct ad7625_state *st)
 {
+       struct clk *ref_clk;
        u32 ref_clk_rate_hz;
 
        st->cnv_pwm = devm_pwm_get(dev, "cnv");
@@ -556,7 +557,6 @@ static int ad7625_probe(struct platform_device *pdev)
        struct device *dev = &pdev->dev;
        struct iio_dev *indio_dev;
        struct ad7625_state *st;
-       struct clk *ref_clk;
        int ret;
        u32 default_sample_freq;
 
@@ -610,7 +610,7 @@ static int ad7625_probe(struct platform_device *pdev)
                                             "failed to set EN pins\n");
        }
 
-       ret = devm_ad7625_pwm_get(dev, ref_clk, st);
+       ret = devm_ad7625_pwm_get(dev, st);
        if (ret)
               return ret;


Let me know if I've missed something.
I'd guess this is a case of code evolving into a dead end ;)
The bots win again.


Jonathan

> +static int devm_ad7625_pwm_get(struct device *dev, struct clk *ref_clk,
> +			       struct ad7625_state *st)

Here ref_clk is passed in but then overwritten in here.

> +{
> +	u32 ref_clk_rate_hz;
> +
> +	st->cnv_pwm = devm_pwm_get(dev, "cnv");
> +	if (IS_ERR(st->cnv_pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm),
> +				     "failed to get cnv pwm\n");
> +
> +	/* Preemptively disable the PWM in case it was enabled at boot */
> +	pwm_disable(st->cnv_pwm);
> +
> +	st->clk_gate_pwm = devm_pwm_get(dev, "clk_gate");
> +	if (IS_ERR(st->clk_gate_pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->clk_gate_pwm),
> +				     "failed to get clk_gate pwm\n");
> +
> +	/* Preemptively disable the PWM in case it was enabled at boot */
> +	pwm_disable(st->clk_gate_pwm);
> +
> +	ref_clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(ref_clk))
> +		return dev_err_probe(dev, PTR_ERR(ref_clk),
> +				     "failed to get ref_clk");
> +
> +	ref_clk_rate_hz = clk_get_rate(ref_clk);
> +	if (!ref_clk_rate_hz)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "failed to get ref_clk rate");
> +
> +	st->ref_clk_rate_hz = ref_clk_rate_hz;
> +
> +	return 0;
> +}

> +
> +static int ad7625_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7625_state *st;
> +	struct clk *ref_clk;
> +	int ret;
> +	u32 default_sample_freq;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->info = device_get_match_data(dev);
> +	if (!st->info)
> +		return dev_err_probe(dev, -EINVAL, "no chip info\n");
> +
> +	if (device_property_read_bool(dev, "adi,no-dco"))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "self-clocked mode not supported\n");
> +
> +	if (st->info->has_bandwidth_control)
> +		ret = ad7625_parse_mode(dev, st, 4);
> +	else
> +		ret = ad7625_parse_mode(dev, st, 2);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_ad7625_regulator_setup(dev, st);
> +	if (ret)
> +		return ret;
> +
> +	/* Set the device mode based on detected EN configuration. */
> +	if (!st->info->has_bandwidth_control) {
> +		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mv);
> +	} else {
> +		/*
> +		 * If neither sampling mode is available, then report an error,
> +		 * since the other modes are not useful defaults.
> +		 */
> +		if (st->can_wide_bandwidth) {
> +			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
> +					      st->have_refin, st->vref_mv);
> +		} else if (st->can_narrow_bandwidth) {
> +			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
> +					      st->have_refin, st->vref_mv);
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +				"couldn't set device to wide or narrow bandwidth modes\n");
> +		}
> +
> +		if (ret)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "failed to set EN pins\n");
> +	}
> +
> +	ret = devm_ad7625_pwm_get(dev, ref_clk, st);
We pass ref_clk in but don't update the underlying pointer (just a copy of
it) and don't need it out here anyway.

I've dropped the parameter and moved the definition into pwm_get()

> +	if (ret)
> +		return ret;
> +

