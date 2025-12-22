Return-Path: <linux-iio+bounces-27310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FECBCD568B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 10:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9551B30E88F1
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B601301002;
	Mon, 22 Dec 2025 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idDSo/A+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8168239E81
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396744; cv=none; b=jPyAG5snsJAWd7XcqlKgatWeikFLcpuReTdYOtF1elr0wsd85F3URhC0nI/t3JHj5nSt1RXyLskeCESkz2refFq4djbryqBf7GmcZ5UTN/2n61CA6nRmUolw4P5D1h3WlztzSwX5xkzv4ueq0cvS1BUiINUp8dldj+k0M8paETk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396744; c=relaxed/simple;
	bh=khNqtDXWF/I4I8GzqBETDiNu4xtQVQV/ka2Gs49imCU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Atlg2rHR6c6aXZhuzkInns2jFCIRRacQgb2GH4xGyTQezZkJavmOcN22CIqClEnpYWDNjd7yJsgCzJAjFIl8xUSrdpG066axRJYWDFvt0qTcdqTKVfSAoxUtufabdQEX2oQW3gID4NyD3tGey9PPknqkRR7Rv6chX+efBhQKFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idDSo/A+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a3d2f3299so45373646d6.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 01:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766396741; x=1767001541; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mFlYYjEvni55+oD+vrH71wH7CT0ntEqLI/qNJpwkars=;
        b=idDSo/A+vhMUxYBYffb+rKFReAT2kCqKEa6qfC9Z7FUuMNkB4sCEoSDaqAWTMc5dJX
         NOn6Kd4fq1OnSzuj1gejrSzaFVPghmPTy63yKlifDH5pqebax0dQrAsrxtFQKVVnj0JS
         wRjBeN0IIL7oZBHaUN1zh70QHu9jFNyasj6FLJU4iZpbLHeawQBoKfkTEKtNivyAr8Ky
         Gp1DSXghHkBF8sLMxUu2YX8VK/eKG5p1WgNjUQUkBzRlqpaaycYtGFJX4ER/1I2LmBKz
         zq4vCAwaOuJV29XX7er9XtJTTgbVGXTfdc8FD/psCqutNE5e5yM9ukoGDKO5huwkjtpY
         Ax9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766396741; x=1767001541;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFlYYjEvni55+oD+vrH71wH7CT0ntEqLI/qNJpwkars=;
        b=fIchcxx+75N2HQlh2PJLOfjzjKjgb3+kextUqmDxiiC+nfwlWjzBk4olQAlJp9bm/5
         IfvNPWCPvQqAYtjnViayCBoJAySJQxsDo+EAKRO15Ed3bG8PFaegSUoNPihKfyc996Jr
         1xkEUhav+EYKEPlWH4/vvZ227yAz+C+KBQwrZnYe2T6Ht8CT3MhIyOWX5/StuL6tO8VR
         OyZ3ZI6RAhNjOI79ckB8+4TTwnfCuFOy/u7qDBBNS4MTqauTSVUb+ddDc04MhH8BOHWj
         3JD44APE1OqRb/XRd/NMQ2ggf5xXKMcJfnkyHrj8Hoq9Wa2hHepQEIMEZxYEVOHRYXac
         Uxtw==
X-Forwarded-Encrypted: i=1; AJvYcCU7DYu/TlvTEQhZx+1QLqpffLmeZQtqQ+iNsY+uHiu8mNTNQI2McK0ti6e+HEl+5t8gKzFlweXHLoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgAQ/KHZFj8PTEijfsbr73HDX+ZFdT0tfI1p2AH609JACVhmWn
	DY7x0v2T2Pxa3NR2fIAtfZXENCUWKmQMTgB2HURX4QwM209HbbKw1HqO
X-Gm-Gg: AY/fxX5PTUfj32ttb7gH78yRvR7TfpPFfENxDIVH8XYes9k0xOqOaVRaYMQpCeoyBP/
	jgZcRdyxxdf9Ini6bi/GHlDa81T87JtOAWanrm2M5xpx/2gG3rbPOvQApEH6n9ftR1cLzY9V3gz
	efb6Tv4m8/7h8H8MO/til6Pb0TTmloj5bU8boODcp2slaEIzTx2wsDiEjsZmXr433eY+kYHnYPQ
	rxdZtP6KXVt8Bx03c+4aXS6xAe4KSU9nBDN+QFUl5lUxVazCdb53ZWql0zP9CCi8opORm8Rq/O7
	lHaVlbVhcKvbTtdIOXi2tADbG4La6w5fRXbzOzbQyN9PXCCslCMLDz73yy4w6lBiTP/zMU0n6jW
	sOc5RdNvld594qm0mukuOwq4TvQUUr7Fr948DtT7hCy9W/GA6fjSn96mm89xQAhdc32EVcdiJvV
	vGp+fGYsBu1kf4sYQ3WyuqbBzAtLpm1MuxjNjVmGV49BJQGCTOI0FpLnpx+5VvC6oLSB90tf4Sa
	HN7
X-Google-Smtp-Source: AGHT+IE0pR7NolVRBzrzvjbJ6kGL+UmeJdM/kLMcypeJ+f+ezJiCE3YsZEfuN6B4IgPgbjRV1tRRPA==
X-Received: by 2002:a05:6214:5d06:b0:88a:4391:59d4 with SMTP id 6a1803df08f44-88d86961f7bmr144963136d6.51.1766396740467;
        Mon, 22 Dec 2025 01:45:40 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a44c880sm77890056d6.46.2025.12.22.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 01:45:40 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 22 Dec 2025 09:45:30 +0000
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 2/6] iio: frequency: adf41513: driver implementation
Message-ID: <3agb73fmwhcoho4uowhwh3tchux5wb5amgzrmr2fj66uiw4grg@oddcbaeqmneu>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
 <20251219-adf41513-iio-driver-v2-2-be29a83d5793@analog.com>
 <20251221174902.7ebb9e74@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251221174902.7ebb9e74@jic23-huawei>

On 25/12/21 05:49PM, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 12:34:49 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > The driver is based on existing PLL drivers in the IIO subsystem and
> > implements the following key features:
> > 
> > - Integer-N and fractional-N (fixed/variable modulus) synthesis modes
> > - High-resolution frequency calculations using microhertz (µHz) precision
> >   to handle sub-Hz resolution across multi-GHz frequency ranges
> > - IIO debugfs interface for direct register access
> > - FW property parsing from devicetree including charge pump settings,
> >   reference path configuration and muxout options
> > - Power management support with suspend/resume callbacks
> > - Lock detect GPIO monitoring
> > 
> > The driver uses 64-bit microhertz values throughout PLL calculations to
> > maintain precision when working with frequencies that exceed 32-bit Hz
> > representation while requiring fractional Hz resolution.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> Hi Rodrigo,
> 
> Various comments inline.
> 
> Thanks,
> 
> Jonathan

Hi Jonathan,

valuable review, thanks!

kind regards,

Rodrigo Alencar
 
> > diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
> > new file mode 100644
> > index 000000000000..a967dc4479e7
> > --- /dev/null
> > +++ b/drivers/iio/frequency/adf41513.c
> 
> 
> > +
> > +static int adf41513_sync_config(struct adf41513_state *st, u16 sync_mask)
> > +{
> > +	int ret;
> > +	int i;
> > +
> > +	/* write registers in reverse order (R13 to R0)*/
> > +	for (i = ADF41513_REG13; i >= ADF41513_REG0; i--) {
> > +		if (st->regs_hw[i] != st->regs[i] || sync_mask & BIT(i)) {
> For code cases like this where you want to only do something if a condition is matched
> it can be neater to invert the condition.  e.g.
> 
> 		if (st->regs_hw[i] == st->regs[i] && !(sync_mask & BIT(i)))
> 			continue;
> 
> 		st->buf = cpu...
> 
> > +			st->buf = cpu_to_be32(st->regs[i] | i);
> > +			ret = spi_write(st->spi, &st->buf, sizeof(st->buf));
> > +			if (ret < 0)
> > +				return ret;
> > +			st->regs_hw[i] = st->regs[i];
> > +			dev_dbg(&st->spi->dev, "REG%d <= 0x%08X\n", i, st->regs[i] | i);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static u64 adf41513_pll_get_rate(struct adf41513_state *st)
> > +{
> > +	struct adf41513_pll_settings *cfg = &st->settings;
> > +
> > +	if (cfg->mode != ADF41513_MODE_INVALID)
> > +		return cfg->actual_frequency_uhz;
> > +
> > +	/* get pll settings from regs_hw */
> > +	cfg->int_value = FIELD_GET(ADF41513_REG0_INT_MSK,
> > +				   st->regs_hw[ADF41513_REG0]);
> > +	cfg->frac1 = FIELD_GET(ADF41513_REG1_FRAC1_MSK,
> > +			       st->regs_hw[ADF41513_REG1]);
> > +	cfg->frac2 = FIELD_GET(ADF41513_REG3_FRAC2_MSK,
> > +			       st->regs_hw[ADF41513_REG3]);
> > +	cfg->mod2 = FIELD_GET(ADF41513_REG4_MOD2_MSK,
> > +			      st->regs_hw[ADF41513_REG4]);
> > +	cfg->r_counter = FIELD_GET(ADF41513_REG5_R_CNT_MSK,
> > +				   st->regs_hw[ADF41513_REG5]);
> > +	cfg->ref_doubler = FIELD_GET(ADF41513_REG5_REF_DOUBLER_MSK,
> > +				     st->regs_hw[ADF41513_REG5]);
> > +	cfg->ref_div2 = FIELD_GET(ADF41513_REG5_RDIV2_MSK,
> > +				  st->regs_hw[ADF41513_REG5]);
> > +	cfg->prescaler = FIELD_GET(ADF41513_REG5_PRESCALER_MSK,
> > +				   st->regs_hw[ADF41513_REG5]);
> For cases like this I think keeping to 80 chars is hurting readability
> and so it is fine to go a little higher. 
> 	cfg->int_value = FIELD_GET(ADF41513_REG0_INT_MSK, st->regs_hw[ADF41513_REG0]);
> 	cfg->frac1 = FIELD_GET(ADF41513_REG1_FRAC1_MSK, st->regs_hw[ADF41513_REG1]);
> 	cfg->frac2 = FIELD_GET(ADF41513_REG3_FRAC2_MSK, st->regs_hw[ADF41513_REG3]);
> 	cfg->mod2 = FIELD_GET(ADF41513_REG4_MOD2_MSK, st->regs_hw[ADF41513_REG4]);
> 	cfg->r_counter = FIELD_GET(ADF41513_REG5_R_CNT_MSK, st->regs_hw[ADF41513_REG5]);
> 	cfg->ref_doubler = FIELD_GET(ADF41513_REG5_REF_DOUBLER_MSK, st->regs_hw[ADF41513_REG5]);
> 	cfg->ref_div2 = FIELD_GET(ADF41513_REG5_RDIV2_MSK, st->regs_hw[ADF41513_REG5]);
> 	cfg->prescaler = FIELD_GET(ADF41513_REG5_PRESCALER_MSK,st->regs_hw[ADF41513_REG5]);
> Is fine here. I'd also be fine with wrapping the ref_doubler line as it's rather
> longer than the others.

ack
 
> > +
> > +	/* calculate pfd frequency */
> > +	cfg->pfd_frequency_uhz = st->ref_freq_hz * MICROHZ_PER_HZ;
> > +	if (cfg->ref_doubler)
> > +		cfg->pfd_frequency_uhz <<= 1;
> > +	if (cfg->ref_div2)
> > +		cfg->pfd_frequency_uhz >>= 1;
> > +	cfg->pfd_frequency_uhz = div_u64(cfg->pfd_frequency_uhz,
> > +					 cfg->r_counter);
> > +	cfg->actual_frequency_uhz = (u64)cfg->int_value * cfg->pfd_frequency_uhz;
> > +
> > +	/* check if int mode is selected */
> > +	if (FIELD_GET(ADF41513_REG6_INT_MODE_MSK, st->regs_hw[ADF41513_REG6])) {
> > +		cfg->mode = ADF41513_MODE_INTEGER_N;
> > +	} else {
> > +		cfg->actual_frequency_uhz += mul_u64_u64_div_u64(cfg->frac1,
> > +								 cfg->pfd_frequency_uhz,
> > +								 ADF41513_FIXED_MODULUS);
> > +
> > +		/* check if variable modulus is selected */
> > +		if (FIELD_GET(ADF41513_REG0_VAR_MOD_MSK, st->regs_hw[ADF41513_REG0])) {
> > +			cfg->actual_frequency_uhz +=
> > +				mul_u64_u64_div_u64(cfg->frac2,
> > +						    cfg->pfd_frequency_uhz,
> > +						    ADF41513_FIXED_MODULUS * cfg->mod2);
> > +
> > +			cfg->mode = ADF41513_MODE_VARIABLE_MODULUS;
> > +		} else {
> > +			/* LSB_P1 offset */
> > +			if (!FIELD_GET(ADF41513_REG5_LSB_P1_MSK, st->regs_hw[ADF41513_REG5]))
> > +				cfg->actual_frequency_uhz +=
> > +					div_u64(cfg->pfd_frequency_uhz,
> > +						ADF41513_FIXED_MODULUS * 2);
> > +			cfg->mode = ADF41513_MODE_FIXED_MODULUS;
> > +		}
> > +	}
> > +
> > +	cfg->target_frequency_uhz = cfg->actual_frequency_uhz;
> > +
> > +	return cfg->actual_frequency_uhz;
> > +}
> 
> 
> > +static int adf41513_calc_pll_settings(struct adf41513_state *st,
> > +				      struct adf41513_pll_settings *result,
> > +				      u64 rf_out_uhz)
> > +{
> > +	u64 max_rf_freq_uhz = st->chip_info->max_rf_freq_hz * MICROHZ_PER_HZ;
> > +	u64 min_rf_freq_uhz = ADF41513_MIN_RF_FREQ * MICROHZ_PER_HZ;
> > +	u64 pfd_freq_limit_uhz;
> > +	int ret;
> > +
> > +	/* input validation */
> 
> That's obvious.  No need to have the comment.

ack

> > +	if (rf_out_uhz < min_rf_freq_uhz || rf_out_uhz > max_rf_freq_uhz) {
> > +		dev_err(&st->spi->dev, "RF frequency %llu uHz out of range [%llu, %llu] uHz\n",
> > +			rf_out_uhz, min_rf_freq_uhz, max_rf_freq_uhz);
> > +		return -EINVAL;
> > +	}
> > +
> > +	result->target_frequency_uhz = rf_out_uhz;
> > +
> > +	/* try integer-N first (best phase noise performance) */
> > +	pfd_freq_limit_uhz = min(div_u64(rf_out_uhz, ADF41513_MIN_INT_4_5),
> > +				 ADF41513_MAX_PFD_FREQ_INT_N_UHZ);
> > +	ret = adf41513_calc_pfd_frequency(st, result, pfd_freq_limit_uhz);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = adf41513_calc_integer_n(st, result);
> > +	if (ret < 0) {
> > +		/* try fractional-N: recompute pfd frequency if necessary */
> > +		pfd_freq_limit_uhz = min(div_u64(rf_out_uhz, ADF41513_MIN_INT_FRAC_4_5),
> > +					 ADF41513_MAX_PFD_FREQ_FRAC_N_UHZ);
> > +		if (pfd_freq_limit_uhz < result->pfd_frequency_uhz) {
> > +			ret = adf41513_calc_pfd_frequency(st, result, pfd_freq_limit_uhz);
> > +			if (ret < 0)
> > +				return ret;
> > +		}
> > +
> > +		/* fixed-modulus attempt */
> > +		ret = adf41513_calc_fixed_mod(st, result);
> > +		if (ret < 0) {
> > +			/* variable-modulus attempt */
> > +			ret = adf41513_calc_variable_mod(st, result);
> > +			if (ret < 0) {
> > +				dev_err(&st->spi->dev,
> > +					"no valid PLL configuration found for %llu uHz\n",
> > +					rf_out_uhz);
> > +				return -EINVAL;
> > +			}
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 sync_mask)
> > +{
> > +	struct adf41513_pll_settings result;
> > +	int ret;
> > +
> > +	/* calculate pll settings candidate */
> > +	ret = adf41513_calc_pll_settings(st, &result, freq_uhz);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* apply computed results to pll settings */
> > +	memcpy(&st->settings, &result, sizeof(struct adf41513_pll_settings));
> 
> sizeof(st->settings)
> 
> > +
> > +	dev_dbg(&st->spi->dev,
> > +		"%s mode: int=%u, frac1=%u, frac2=%u, mod2=%u, fpdf=%llu Hz, prescaler=%s\n",
> > +		(result.mode == ADF41513_MODE_INTEGER_N) ? "integer-n" :
> > +		(result.mode == ADF41513_MODE_FIXED_MODULUS) ? "fixed-modulus" : "variable-modulus",
> > +		result.int_value, result.frac1, result.frac2, result.mod2,
> > +		div64_u64(result.pfd_frequency_uhz, MICROHZ_PER_HZ),
> > +		result.prescaler ? "8/9" : "4/5");
> > +
> > +	/* int */
> > +	st->regs[ADF41513_REG0] = FIELD_PREP(ADF41513_REG0_INT_MSK,
> > +					     st->settings.int_value);
> > +	if (st->settings.mode == ADF41513_MODE_VARIABLE_MODULUS)
> > +		st->regs[ADF41513_REG0] |= ADF41513_REG0_VAR_MOD_MSK;
> > +	/* frac1 */
> > +	st->regs[ADF41513_REG1] = FIELD_PREP(ADF41513_REG1_FRAC1_MSK,
> > +					     st->settings.frac1);
> > +	if (st->settings.mode != ADF41513_MODE_INTEGER_N)
> > +		st->regs[ADF41513_REG1] |= ADF41513_REG1_DITHER2_MSK;
> > +
> > +	/* frac2 */
> 
> Where the field name makes it obvious there is little point in
> adding a comment to say the same thing. I'd clear out most if not all
> of these. Stick to comments that add significant value.

ack

> > +	st->regs[ADF41513_REG3] = FIELD_PREP(ADF41513_REG3_FRAC2_MSK,
> > +					     st->settings.frac2);
> > +	/* mod2 */
> > +	st->regs[ADF41513_REG4] &= ADF41513_REG4_MOD2_MSK;
> > +	st->regs[ADF41513_REG4] |= FIELD_PREP(ADF41513_REG4_MOD2_MSK,
> > +					      st->settings.mod2);
> > +
> > +	/* r-cnt | doubler | rdiv2 | prescaler */
> > +	st->regs[ADF41513_REG5] &= ~(ADF41513_REG5_R_CNT_MSK |
> > +				     ADF41513_REG5_REF_DOUBLER_MSK |
> > +				     ADF41513_REG5_RDIV2_MSK |
> > +				     ADF41513_REG5_PRESCALER_MSK);
> > +	st->regs[ADF41513_REG5] |= FIELD_PREP(ADF41513_REG5_R_CNT_MSK,
> > +					      st->settings.r_counter);
> > +	st->regs[ADF41513_REG5] |= FIELD_PREP(ADF41513_REG5_REF_DOUBLER_MSK,
> > +					      st->settings.ref_doubler);
> > +	st->regs[ADF41513_REG5] |= FIELD_PREP(ADF41513_REG5_RDIV2_MSK,
> > +					      st->settings.ref_div2);
> > +	st->regs[ADF41513_REG5] |= FIELD_PREP(ADF41513_REG5_PRESCALER_MSK,
> > +					      st->settings.prescaler);
> 
> Probably better to use FIELD_MODIFY for all of these and let the compiler
> figure out it can mask them all in one go.

ack

> > +
> > +	if (st->settings.mode == ADF41513_MODE_INTEGER_N) {
> > +		st->regs[ADF41513_REG6] |= ADF41513_REG6_INT_MODE_MSK;
> > +		st->regs[ADF41513_REG6] &= ~ADF41513_REG6_BLEED_ENABLE_MSK;
> > +	} else {
> > +		st->regs[ADF41513_REG6] &= ~ADF41513_REG6_INT_MODE_MSK;
> > +		st->regs[ADF41513_REG6] |= ADF41513_REG6_BLEED_ENABLE_MSK;
> > +	}
> > +
> > +	return adf41513_sync_config(st, sync_mask | ADF41513_SYNC_REG0);
> > +}
> 
> > +static ssize_t adf41513_read_uhz(struct iio_dev *indio_dev,
> > +				 uintptr_t private,
> > +				 const struct iio_chan_spec *chan,
> > +				 char *buf)
> > +{
> > +	struct adf41513_state *st = iio_priv(indio_dev);
> > +	u64 freq_uhz;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch ((u32)private) {
> > +	case ADF41513_FREQ:
> > +		freq_uhz = adf41513_pll_get_rate(st);
> > +		if (st->lock_detect)
> > +			if (!gpiod_get_value_cansleep(st->lock_detect)) {
> > +				dev_dbg(&st->spi->dev, "PLL un-locked\n");
> > +				return -EBUSY;
> > +			}
> > +		break;
> > +	case ADF41513_FREQ_RESOLUTION:
> > +		freq_uhz = st->data.freq_resolution_uhz;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return adf41513_uhz_to_str(freq_uhz, buf);
> This is a more marginal case than the ones below wrt to a common
> function making sense as there is more overlap. I''m not sure it
> is worth doing even so (rather than separate callbacks).

ack. will split them.

> > +}
> > +
> > +static ssize_t adf41513_read(struct iio_dev *indio_dev,
> > +			     uintptr_t private,
> > +			     const struct iio_chan_spec *chan,
> > +			     char *buf)
> > +{
> > +	struct adf41513_state *st = iio_priv(indio_dev);
> > +	u32 val;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch ((u32)private) {
> > +	case ADF41513_FREQ_REFIN:
> > +		st->ref_freq_hz = clk_get_rate(st->ref_clk);
> > +		return sysfs_emit(buf, "%llu\n", st->ref_freq_hz);
> 
> Not much sharing here either (see below). I'd be tempted to just spit this
> into specific callbacks.

ack.

> > +	case ADF41513_POWER_DOWN:
> > +		val = FIELD_GET(ADF41513_REG6_POWER_DOWN_MSK,
> > +				st->regs_hw[ADF41513_REG6]);
> > +		return sysfs_emit(buf, "%u\n", val);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> > +
> > +static ssize_t adf41513_write(struct iio_dev *indio_dev,
> > +			      uintptr_t private,
> > +			      const struct iio_chan_spec *chan,
> > +			      const char *buf, size_t len)
> > +{
> > +	struct adf41513_state *st = iio_priv(indio_dev);
> > +	unsigned long readin, tmp;
> > +	int ret;
> > +
> > +	ret = kstrtoul(buf, 10, &readin);
> > +	if (ret)
> > +		return ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch ((u32)private) {
> > +	case ADF41513_FREQ_REFIN:
> 
> There isn't a lot of shared code between different calls of this.
> Perhaps just have separate callbacks for each one.

ack.

> > +		if (readin < ADF41513_MIN_REF_FREQ || readin > ADF41513_MAX_REF_FREQ)
> > +			return -EINVAL;
> > +
> > +		tmp = clk_round_rate(st->ref_clk, readin);
> > +		if (tmp != readin)
> > +			return -EINVAL;
> > +
> > +		ret = clk_set_rate(st->ref_clk, tmp);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		st->ref_freq_hz = readin;
> > +		ret = adf41513_set_frequency(st, st->settings.target_frequency_uhz,
> > +					     ADF41513_SYNC_DIFF);
> > +		break;
> > +	case ADF41513_POWER_DOWN:
> > +		if (readin)
> > +			ret = adf41513_suspend(st);
> > +		else
> > +			ret = adf41513_resume(st);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return ret ? ret : len;
> > +}
> > +
> > +#define _ADF41513_EXT_INFO(_name, _ident) { \
> > +	.name = _name, \
> > +	.read = adf41513_read, \
> > +	.write = adf41513_write, \
> > +	.private = _ident, \
> > +	.shared = IIO_SEPARATE, \
> > +}
> > +
> > +#define _ADF41513_EXT_UHZ_INFO(_name, _ident) { \
> > +	.name = _name, \
> > +	.read = adf41513_read_uhz, \
> > +	.write = adf41513_write_uhz, \
> > +	.private = _ident, \
> > +	.shared = IIO_SEPARATE, \
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info adf41513_ext_info[] = {
> > +	/*
> > +	 * Ideally we would use IIO_CHAN_INFO_FREQUENCY, but the device supports
> > +	 * frequency values greater 2^32 with sub-Hz resolution, i.e. 64-bit
> > +	 * fixed point with 6 decimal places values are used to represent
> > +	 * frequencies.
> > +	 */
> > +	_ADF41513_EXT_UHZ_INFO("frequency", ADF41513_FREQ),
> > +	_ADF41513_EXT_UHZ_INFO("frequency_resolution", ADF41513_FREQ_RESOLUTION),
> > +	_ADF41513_EXT_INFO("refin_frequency", ADF41513_FREQ_REFIN),
> Some of these are not things I recall as being standard ABI.
> This one is in one other driver but to make it generic you need to promote
> the ABI documentation to a shared file.

ack. will create the shared ABI file.

> > +	_ADF41513_EXT_INFO("powerdown", ADF41513_POWER_DOWN),
> > +	{ },
> 
> No comma on terminating entries like this.

ack

> > +};
> > +
> > +static const struct iio_chan_spec adf41513_chan = {
> > +	.type = IIO_ALTVOLTAGE,
> > +	.indexed = 1,
> > +	.output = 1,
> > +	.channel = 0,
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE),
> > +	.ext_info = adf41513_ext_info,
> > +};
> > +
> > +static int adf41513_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val, int *val2, long info)
> > +{
> > +	struct adf41513_state *st = iio_priv(indio_dev);
> > +	u32 phase_mdeg;
> > +	u16 phase_val;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_PHASE:
> > +		phase_val = FIELD_GET(ADF41513_REG2_PHASE_VAL_MSK,
> > +				      st->regs_hw[ADF41513_REG2]);
> > +		phase_mdeg = DIV_ROUND_CLOSEST(360 * MILLI * phase_val, BIT(12));
> > +		*val = phase_mdeg / MILLI;
> > +		*val2 = (phase_mdeg % MILLI) * 1000;
> 
> This sounds like it is in degrees. Note _phase attributes are in the documented
> ABI Documentation/ABI/testing/sysfs-bus-iio as in radians.

ack. will use radians conversion.

> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int adf41513_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long info)
> > +{
> > +	struct adf41513_state *st = iio_priv(indio_dev);
> > +	u32 phase_mdeg;
> > +	u16 phase_val;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_PHASE:
> > +		val %= 360;
> > +		if (val < 0)
> > +			val += 360;
> > +		phase_mdeg = val * MILLI + val2 / 1000;
> > +		phase_val = DIV_ROUND_CLOSEST(phase_mdeg << 12, 360 * MILLI);
> > +
> > +		st->regs[ADF41513_REG2] |= ADF41513_REG2_PHASE_ADJ_MSK;
> > +		st->regs[ADF41513_REG2] &= ~ADF41513_REG2_PHASE_VAL_MSK;
> 
> FIELD_MODIFY() can save doing the clear and fill as separate calls.

ack.

> > +		st->regs[ADF41513_REG2] |= FIELD_PREP(ADF41513_REG2_PHASE_VAL_MSK, phase_val);
> > +		return adf41513_sync_config(st, ADF41513_SYNC_REG0);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> 
> > +static int adf41513_parse_fw(struct adf41513_state *st)
> > +{
> > +	struct device *dev = &st->spi->dev;
> > +	int ret;
> > +	u32 tmp;
> > +	u32 cp_resistance;
> > +	u32 cp_current;
> Where you have set of variables of same type and grouping doesn't hurt
> readability, declare them all on one line.
> 
> 	u32 tmp, cp_resistance, cp_current;

ack

> I'll not repeat comments I made on the dt-binding in here but I'd expect
> this code to change somewhat in response to those.

understood. for now, will use -mhz for the power-up frequency, but I will
see how the discussion follows.

> > +
> 
> ...
> 
> 
> > +static int adf41513_setup(struct adf41513_state *st)
> > +{
> > +	u32 tmp;
> > +
> > +	memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
> > +
> > +	/* assume DLD pin is used for digital lock detect */
> > +	st->regs[ADF41513_REG5] = FIELD_PREP(ADF41513_REG5_DLD_MODES_MSK,
> > +					     ADF41513_DLD_DIG_LD);
> > +
> > +	/* configure charge pump current settings */
> > +	tmp = DIV_ROUND_CLOSEST(st->data.charge_pump_voltage_mv, ADF41513_MIN_CP_VOLTAGE_mV);
> > +	st->regs[ADF41513_REG5] |= FIELD_PREP(ADF41513_REG5_CP_CURRENT_MSK, tmp - 1);
> > +
> > +	/* narrow ABP | loss of lock detect enable | SD reset | LDP from data */
> 
> I'm not sure what LPD from data means. Can't correlate that with the datasheet.
> Perhaps add more info or reword.

will remove, this is not applicable anymore.

> > +	st->regs[ADF41513_REG6] = ADF41513_REG6_ABP_MSK |
> > +				  ADF41513_REG6_LOL_ENABLE_MSK |
> > +				  ADF41513_REG6_SD_RESET_MSK;
> > +	if (st->data.phase_detector_polarity)
> > +		st->regs[ADF41513_REG6] |= ADF41513_REG6_PD_POLARITY_MSK;
> > +
> > +	/* PS bias | lock detect count */
> Confusing comment as covering multiple bits of code. I'd just drop
> it on basis the field names in the code are less confusing than the comment.

ack. will drop.

> > +	st->regs[ADF41513_REG7] = FIELD_PREP(ADF41513_REG7_PS_BIAS_MSK, 2);
> 
> That magic 2 is interesting as it is truely magic with no explanation on
> the datasheet beyond 'program this value'. Even better, on the datasheet I'm
> looking at the Prescaler (PS) bias section says set it to 3 and figure 30
> say set it to 2.  Maybe add a commeon on this.

understood. 2 should be the correct vallue, but I will ask around.

> > +	tmp = ilog2(st->data.lock_detect_count);
> > +	if (st->data.lock_detect_count < ADF41513_LD_COUNT_FAST_LIMIT) {
> > +		tmp -= const_ilog2(ADF41513_LD_COUNT_FAST_MIN);
> > +		st->regs[ADF41513_REG7] |= ADF41513_REG7_LD_CLK_SEL_MSK;
> > +	} else {
> > +		tmp -= const_ilog2(ADF41513_LD_COUNT_MIN);
> > +	}
> > +	st->regs[ADF41513_REG7] |= FIELD_PREP(ADF41513_REG7_LD_COUNT_MSK, tmp);
> > +
> > +	/* power down select */
> > +	st->regs[ADF41513_REG11] = ADF41513_REG11_POWER_DOWN_SEL_MSK;
> > +
> > +	/* muxout */
> > +	st->regs[ADF41513_REG12] = FIELD_PREP(ADF41513_REG12_MUXOUT_MSK,
> > +					      st->data.muxout_select);
> > +	st->regs[ADF41513_REG12] |= FIELD_PREP(ADF41513_REG12_LOGIC_LEVEL_MSK,
> > +					       st->data.muxout_1v8_en ? 0 : 1);
> > +
> > +	/* perform initialization sequence with power-up frequency */
> > +	return adf41513_set_frequency(st, (u64)st->data.power_up_frequency_hz * MICROHZ_PER_HZ,
> > +				      ADF41513_SYNC_ALL);
> > +}
> 
> ...
> 
> > +
> > +static int adf41513_pm_suspend(struct device *dev)
> > +{
> > +	struct adf41513_state *st = dev_get_drvdata(dev);
> > +
> > +	return adf41513_suspend(st);
> 
> Not at lot in point in the local variable
> 
> 	return adf41513_suspend(dev_get_drvdata(dev));

ack

> > +}
> > +
> > +static int adf41513_pm_resume(struct device *dev)
> > +{
> > +	struct adf41513_state *st = dev_get_drvdata(dev);
> > +
> > +	return adf41513_resume(st);
> As above.
> > +}
> > +
> > +static const struct adf41513_chip_info adf41513_chip_info = {
> > +	.name = "adf41513",
> > +	.has_prescaler_8_9 = true,
> > +	.max_rf_freq_hz = ADF41513_MAX_RF_FREQ,
> > +};
> > +
> > +static const struct adf41513_chip_info adf41510_chip_info = {
> 
> Just for long term organization when many devices are supported:
> keep these structures in alphanumeric order.

ack

> > +	.name = "adf41510",
> > +	.has_prescaler_8_9 = false,
> > +	.max_rf_freq_hz = ADF41510_MAX_RF_FREQ,
> > +};
> > +
> > +static int adf41513_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct adf41513_state *st;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> 
> I'd use a 
> 	struct device *dev = &spi->dev;
> so that you can shorten all the lines where spi->dev is used in here.

ack

> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	st->spi = spi;
> > +	st->chip_info = spi_get_device_match_data(spi);
> > +	if (!st->chip_info)
> > +		return -EINVAL;
> > +
> > +	spi_set_drvdata(spi, st);
> > +
> > +	st->ref_clk = devm_clk_get_enabled(&spi->dev, NULL);
> > +	if (IS_ERR(st->ref_clk))
> > +		return PTR_ERR(st->ref_clk);
> > +
> > +	st->ref_freq_hz = clk_get_rate(st->ref_clk);
> > +	if (st->ref_freq_hz < ADF41513_MIN_REF_FREQ || st->ref_freq_hz > ADF41513_MAX_REF_FREQ)
> > +		return dev_err_probe(&spi->dev, -ERANGE,
> > +				     "reference frequency %llu Hz out of range\n",
> > +				     st->ref_freq_hz);
> > +
> > +	ret = adf41513_parse_fw(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_regulator_bulk_get_enable(&spi->dev,
> > +					     ARRAY_SIZE(adf41513_power_supplies),
> > +					     adf41513_power_supplies);
> > +	if (ret)
> > +		return dev_err_probe(&spi->dev, ret,
> > +				     "failed to get and enable regulators\n");
> > +
> > +	st->chip_enable = devm_gpiod_get_optional(&spi->dev, "enable", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(st->chip_enable))
> > +		return dev_err_probe(&spi->dev, PTR_ERR(st->chip_enable),
> > +				     "fail to request chip enable GPIO\n");
> > +
> > +	st->lock_detect = devm_gpiod_get_optional(&spi->dev, "lock-detect", GPIOD_IN);
> > +	if (IS_ERR(st->lock_detect))
> > +		return dev_err_probe(&spi->dev, PTR_ERR(st->lock_detect),
> > +				     "fail to request lock detect GPIO\n");
> > +
> > +	ret = devm_mutex_init(&spi->dev, &st->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->name = st->chip_info->name;
> > +	indio_dev->info = &adf41513_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = &adf41513_chan;
> > +	indio_dev->num_channels = 1;
> > +
> > +	ret = adf41513_setup(st);
> > +	if (ret < 0)
> > +		return dev_err_probe(&spi->dev, ret, "failed to setup device: %d\n", ret);
> Look at what dev_err_probe() prints.  (short answer, it includes a much nicer print
> of the error value than the one you have here).  So dev_err_probe() should never
> include the error value itself as that is duplicating the info.

yes, that looks bad. will adjust.

> > +
> > +	ret = devm_add_action_or_reset(&spi->dev, adf41513_power_down, st);
> > +	if (ret)
> > +		return dev_err_probe(&spi->dev, ret, "Failed to add power down action: %d\n", ret);
> 
> As above.  No printing ret by hand in dev_err_probe() calls.

ack

> > +
> > +	return devm_iio_device_register(&spi->dev, indio_dev);
> > +}

