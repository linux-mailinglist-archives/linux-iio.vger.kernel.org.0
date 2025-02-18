Return-Path: <linux-iio+bounces-15749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A94A3A7BF
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 20:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3A9189231F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906E91ACEDA;
	Tue, 18 Feb 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CvQizWyD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354B21B9F6
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907472; cv=none; b=U5exnow4lL6MNtoRYXL3wpm5/vGKU5YnIpQpER0pVTTi08noeKXPzTtkBnVcjHfJshKNLs4R7p3+NccOftKx+SND1yWdxkHRt6llUiYOZelhZRSFIGclKpHEGCr3Li4uIJGrDh6J/cokVjJD3WFHWyNvLIXZgswlO9EEu/owEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907472; c=relaxed/simple;
	bh=rab/4CJFsZGIgKZm2YRPeladbdgsXOqYCH6zmWrUMOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwfx8VpJZGYcooeGvFJQAFJI55ZLMG4s5GSbKvIGWwbGJWO85hrf55+9OGOL6Q7G8zZCfmUbfpaIKtkM5zf2ghKvmH476umow0fheC6LYoakPFoySQ13ki1ohLQKv+kC28T/iWHY9pe+/VUrgm3OwzvSqrKAgVXaOVyJbJeqffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CvQizWyD; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2bcc0c6c149so2009271fac.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 11:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739907469; x=1740512269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJb/dVR3sqrosCubgiLYmAku6jMx5E+NQvAjxhQhiM8=;
        b=CvQizWyDVXhnTxSdgglzaj5Mi4ToUqfL4SmxdjN7oT5In8osNxSeaH5Ihq0vjDXyQH
         2cVRdCtBJxdrRcoyqalVYGoa1B1GP4T5I1kpGn3E78Y+oPLPwoqssOAIYDgafm1072PA
         9j+Dwkbq/2Bl+KAEYrJIkpfccb2C0x6JIR1IEi27hSx+ZCGr3l3mxFQHPJGi80xjJs1A
         n1WoCRqLF3SFEylewGyLDubQC5sT5zyBjRvidPw5XUzulBbKVLI5HoYlalsBEnPK4cVi
         2cERC2f7WYM4bQoD+ouWWW52wHyqf4XrlrRjfBcJueZmKch+xORd8RP57pFEdvpEPLBn
         +4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907469; x=1740512269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJb/dVR3sqrosCubgiLYmAku6jMx5E+NQvAjxhQhiM8=;
        b=MyDIORlYxkrsFlvjCAreyHTlxGrM5NYkW22XLE99lyXmijA0guxORuF5+9B2rlLA24
         OonZF/bQQciIwE3R20vTAEePpEFyr4U4PmfMkkocDFxhmoZLi4Gx7/7DW6n2yv85fury
         PSpNGP4HSm/eUZGtk6ymlSXIFOQ21M5XS5G5weVz5FnHFbKVNrakkDxtUBFHjPGjRbMF
         4Rq3b4mMsg5c6kBegYCFQ6LqPcmVzzZA0Um7bLP197QE6k/iUibqrBDN71L31j3D+Jd8
         a+Kf7fs0GUmDNtwJdCh0PCat1NlFlnKTGuR+w3+r626D3VGCkRzDHN4sIAJDhKXBQZJr
         eJYA==
X-Gm-Message-State: AOJu0Yx93p0q08MJY6RrvGOQ9KVEkpyl5Xem0/wfzzRWQJaNC0RrTMkC
	qDHRerJW45aN9sEPsuOAyhde14r3QZM1VgeMAuLRmIbKk0v9v34kQ8km2IoZASo=
X-Gm-Gg: ASbGncuZz1trUE+rB1b2Jrny5Jbpu+oyAtqRHvgVSR2MAuOoLEutYhPJa2Jv189YvC3
	AwJzdst2EaIeDreAsCbM5w5f1s3SFT9G99OJiNKG3pHnRLW/6dolLHokEt5ZMuyWPBqg8p7osE3
	lSd4WzSA592fA9YgNzbnIc+24rA7z4vkkf8/FA2PPmU8T/eiBCIwAvgNtbESrPSkuQ/AY+Zzu8T
	sN7G0qkhXGiQNNoehq3He7Dce9U0zWJF4F9UurnAoXHzpGnjKUXOEs59HjTVp/Rmr2VplMRe+/M
	1X2LCV5T9rIz/WyG0MGIJonqfbat5pRWgRHJwIwXH3YcR5qWctA6
X-Google-Smtp-Source: AGHT+IEHGJFc/zoAcyK6Za2xZrAbpEF7mAjRfvbRDlMrOlZgNoAO0ZvUewWdla/UBgsPRDzIdar8bA==
X-Received: by 2002:a05:6870:fbac:b0:2bc:61b3:b0ec with SMTP id 586e51a60fabf-2bd10231f20mr830950fac.9.1739907468553;
        Tue, 18 Feb 2025 11:37:48 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b93742989dsm5132071fac.0.2025.02.18.11.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 11:37:47 -0800 (PST)
Message-ID: <f3f074fb-312c-4f40-818a-05de28b229eb@baylibre.com>
Date: Tue, 18 Feb 2025 13:37:45 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] iio: adc: ad7124: Implement system calibration
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
 <5ee955a72e6f5226233053a883e8897ae325b568.1739902968.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5ee955a72e6f5226233053a883e8897ae325b568.1739902968.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/18/25 12:31 PM, Uwe Kleine-König wrote:
> Allow triggering both zero-scale and full-scale calibration via sysfs in
> the same way as it's done for ad7173.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

...

> +static ssize_t ad7124_write_syscalib(struct iio_dev *indio_dev,
> +				     uintptr_t private,
> +				     const struct iio_chan_spec *chan,
> +				     const char *buf, size_t len)
> +{
> +	struct ad7124_state *st = iio_priv(indio_dev);
> +	struct ad7124_channel *ch = &st->channels[chan->channel];
> +	struct device *dev = &st->sd.spi->dev;
> +	bool sys_calib;
> +	int ret, mode;
> +
> +	ret = kstrtobool(buf, &sys_calib);
> +	if (ret)
> +		return ret;
> +
> +	mode = ch->syscalib_mode;
> +	if (sys_calib) {

Could save some indent by inverting the if and doing early return.

> +		if (mode == AD7124_SYSCALIB_ZERO_SCALE) {

Probably should claim direct mode here to prevent calibration during
a buffered read or other operation (this seems to be missing from
other ad_sigma_delta driver calibrations functions as well).

> +			ch->cfg.calibration_offset = 0x800000;
> +
> +			ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_ZERO,
> +					      chan->address);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(ch->cfg.cfg_slot), 3,
> +					     &ch->cfg.calibration_offset);
> +			if (ret < 0)
> +				return ret;
> +
> +			dev_dbg(dev, "offset for channel %d after zero-scale calibration: 0x%x\n",
> +				chan->channel, ch->cfg.calibration_offset);
> +		} else {
> +			ch->cfg.calibration_gain = st->gain_default;
> +
> +			ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_FULL,
> +					      chan->address);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(ch->cfg.cfg_slot), 3,
> +					     &ch->cfg.calibration_gain);
> +			if (ret < 0)
> +				return ret;
> +
> +			dev_dbg(dev, "gain for channel %d after full-scale calibration: 0x%x\n",
> +				chan->channel, ch->cfg.calibration_gain);
> +		}
> +	}
> +
> +	return len;
> +}
> +

