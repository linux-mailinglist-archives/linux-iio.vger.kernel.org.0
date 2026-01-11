Return-Path: <linux-iio+bounces-27617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D7CD0F042
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45174300C280
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754F533D6DA;
	Sun, 11 Jan 2026 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2M1hH1j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761A1400C;
	Sun, 11 Jan 2026 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768139920; cv=none; b=UX3fjsiye+D2w7C128HulyRfWRq0xm/7y3M68gStmEN6xBWlGAnGL0yZaJ5pTPvom87RyL8i7QoVXIxSmUBe+Qig531HOj1ME60NQLRiHcQwM7k4Gm4U+akvrKNOsXi3aLLOB/MwTO7mEimrlhX6Vg2b0lTkez5R95nSTD6xAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768139920; c=relaxed/simple;
	bh=zpjSLUV9dl663leV7eYgN3rzZuWBkrmUlqRFtMElxyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjRUu3LWz6IJAos5GHHf/3Oi7uo1/SsxcJmDZGzY9kERwsmws6yKnYPzhBGDxQ4GGcgJCnit7cdoE3ilvav3gnNw1f1alUF8mezBvBNXeef7ZFQkwnaN/K+VsRYQcyShRqqaL+AWcsdBxrW0l9QZcpSpMD54ZMw6DjPqrtZRyX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2M1hH1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F20C4CEF7;
	Sun, 11 Jan 2026 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768139919;
	bh=zpjSLUV9dl663leV7eYgN3rzZuWBkrmUlqRFtMElxyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2M1hH1jrH+iwVEHWHNlKJZKUCHA4WJeirhBskdE+173S2hRcU9GPstQ0i7FZLW5H
	 u3UcsTbFhPYJqR9hLaa3TbGPqy+QYBhIDsMCisaKCrncnRwyzrNDHEEgO/cY6WlZyA
	 5vTNxrP4BaJcXmyOOrb+01ZCLlXaraJMzMUgve/89+vtQQBT/U26t/uES+QXRoqOkS
	 B+ihrJkMAEpCvXzAzU9V8UK1yCsvyPmwUwTjeft/PdtHJPc/4JmDrUvk6pbTTAygEb
	 kOx9fLjgM1hSbRne/Mh6rQqzhul1Hkx7zhCyOPgxcCf3+g+Y1hrYq8jDxnhxQmOor/
	 J6ugJ5Dn1SGtg==
Date: Sun, 11 Jan 2026 13:58:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 3/6] iio: frequency: adf41513: handle LE
 synchronization feature
Message-ID: <20260111135829.3863cf1c@jic23-huawei>
In-Reply-To: <20260108-adf41513-iio-driver-v3-3-23d1371aef48@analog.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
	<20260108-adf41513-iio-driver-v3-3-23d1371aef48@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 08 Jan 2026 12:14:52 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> When LE sync is enabled, it is must be set after powering up and must be
> disabled when powering down. It is recommended when using the PLL as
> a frequency synthesizer, where reference signal will always be present
> while the device is being configured.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo,

A few comments inline.

> ---
>  drivers/iio/frequency/adf41513.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
> index 69dcbbc1f393..0cdf24989c93 100644
> --- a/drivers/iio/frequency/adf41513.c
> +++ b/drivers/iio/frequency/adf41513.c
> @@ -220,6 +220,7 @@ struct adf41513_data {
>  	bool phase_detector_polarity;
>  
>  	bool logic_lvl_1v8_en;
> +	bool le_sync_en;
>  };
>  
>  struct adf41513_pll_settings {
> @@ -697,13 +698,25 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
>  static int adf41513_suspend(struct adf41513_state *st)
>  {
>  	st->regs[ADF41513_REG6] |= FIELD_PREP(ADF41513_REG6_POWER_DOWN_MSK, 1);
> +	st->regs[ADF41513_REG12] &= ~ADF41513_REG12_LE_SELECT_MSK;
>  	return adf41513_sync_config(st, ADF41513_SYNC_DIFF);
>  }
>  
>  static int adf41513_resume(struct adf41513_state *st)
>  {
> +	int ret;
> +
>  	st->regs[ADF41513_REG6] &= ~ADF41513_REG6_POWER_DOWN_MSK;
> -	return adf41513_sync_config(st, ADF41513_SYNC_DIFF);
> +	ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
> +	if (ret < 0)
If you know it is either 0 for good or less than zero, prefer
	if (ret) (for reason that follows)

> +		return ret;
> +
> +	if (st->data.le_sync_en) {
> +		st->regs[ADF41513_REG12] |= ADF41513_REG12_LE_SELECT_MSK;
> +		ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
Similar to below - I'd like to see 	
		if (ret)
			return ret;
here to avoid returning stale parameter from above (which might be postive
based on local code).

> +	}
> +
> +	return ret;
>  }
>  
>  static ssize_t adf41513_read_uhz(struct iio_dev *indio_dev,
> @@ -994,6 +1007,8 @@ static int adf41513_parse_fw(struct adf41513_state *st)
>  		st->data.lock_detect_count = tmp;
>  	}
>  
> +	/* load enable sync */
> +	st->data.le_sync_en = device_property_read_bool(dev, "adi,le-sync-enable");
>  	st->data.freq_resolution_uhz = MICROHZ_PER_HZ;
>  
>  	return 0;
> @@ -1001,6 +1016,7 @@ static int adf41513_parse_fw(struct adf41513_state *st)
>  
>  static int adf41513_setup(struct adf41513_state *st)
>  {
> +	int ret;
>  	u32 tmp;
>  
>  	memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
> @@ -1034,8 +1050,18 @@ static int adf41513_setup(struct adf41513_state *st)
>  					      st->data.logic_lvl_1v8_en ? 0 : 1);
>  
>  	/* perform initialization sequence with power-up frequency */
> -	return adf41513_set_frequency(st, st->data.power_up_frequency_hz * MICROHZ_PER_HZ,
> -				      ADF41513_SYNC_ALL);
> +	ret = adf41513_set_frequency(st,
> +				     st->data.power_up_frequency_hz * MICROHZ_PER_HZ,
> +				     ADF41513_SYNC_ALL);
> +	if (ret < 0)
	if (ret)
		assuming set_frequency never returns a positive.

> +		return ret;
> +
> +	if (st->data.le_sync_en) {
> +		st->regs[ADF41513_REG12] |= ADF41513_REG12_LE_SELECT_MSK;
> +		ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
Slightly preference for
		if (ret)
			return ret;
	}

	return 0;

Because otherwise a 'stale' (though it is zero) return value is used and that sort
of code pattern tends to be a little fragile and hard to read.

> +	}
> +
> +	return ret;
>  }
>  
>  static void adf41513_power_down(void *data)
> 


