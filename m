Return-Path: <linux-iio+bounces-19200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349BCAAC88B
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 16:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F43AB11F
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB3F283152;
	Tue,  6 May 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lyBTH5As"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C128137F
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542870; cv=none; b=FGZxGPdvGsBahVUvNSq6hMivVXtsFMzy3G/BfF0CO4A/70ikEgxB7+ILrWtM9cIYw/FIGCp+W0ltoG6FfPwPiSey7iqZNLPkYsjVTOUWmVyi9CsZpVI50btkWP22Zint82uyyhtTuz5G1LdPHyK9ur+darmayjIbYNx7sH2N6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542870; c=relaxed/simple;
	bh=MDJBuL1RzWn4HeHi6fe1HfBITOzG68lYUGph30mhD9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHE8D4jg1jScFja/TF3Ac1v1yhP6nBqPq8UHqMY7+VWU0brYKmCp1Bq35MQk7WQdSchGvJJwS4pNYCtKBjmZB8DHAPTJW7PtBizRhr3v5eDetkXkr1mEFqLlYGNN09EJwox115ctVwmhhSa0a1HFe4+UKYjmETKylOfVTJiuSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lyBTH5As; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso26477865e9.3
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746542866; x=1747147666; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tdn9b7Ao6LumL2AK75QMki8Vnby7kIyvCLDKsENV0Ws=;
        b=lyBTH5AsDIe9AHIQ8aaX3fd8SjspDaDIHrJg6sDLbiWRFAvUGgBqR6pWRi4UTf/Oc5
         Nc/FLBXB8ThrKgVdnHp06RpZuytcUKfmx0+DaHkmeu7BCxvXEhctUUW9esj+ulVorPIl
         j0ad0yGKEXOVw+9fIbK+gJtWKCvUN9mkDAfvUjFOkyqUB+JQ/V1nvOgHlyQ5lgkpFlCJ
         B//ccqWyc5aFppL1pXqtg7hmbJusmybOXubALdpi89B6s9+a5GeKZqY4Vmzl5+IYIiVQ
         NX4aIxFvXPMWsHBcFArapgoXJi3QvXeyOZx9KW+ATnCx97aQ+tRhekFOYusXhebgKvgT
         QWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746542866; x=1747147666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdn9b7Ao6LumL2AK75QMki8Vnby7kIyvCLDKsENV0Ws=;
        b=LcOxw613G0rE481HX9lOaGg19lMM4dLmhCFEW0AA4aIDd+FItxgr8MaXoSXVRNRzZ8
         9RsMQq6O6ZaoD2ecZxzE2uRaSUDsgXgoDzy5FdwZy44kaG4tpPQ4GiCqlNcEXYeGhots
         qtsF0biaq5dqYtZf8ZEoX0gxMmYY7foEPyWVdfrAWQVJg0agCHfdHwDk8fjPk6cxE3Jb
         DdCB8comOfAJZmR7tyRTmgwzwwJTTj5yUcAIoFJgeSEyCgIoc6tTpvwuDktOhY7TewQ/
         8ad15MFIUJ2WMzsXJcA9y7nrhWl9eO6yz17vGkvIO0UOfCOaT0ZF1Otli4RGBDJokScH
         guMA==
X-Forwarded-Encrypted: i=1; AJvYcCUDx08Pvo4C3XEtfgOsMhRK8raRNA4U/q7FrCiFdKROAppeNOxFA8uxxTdInHBPvevYHug1N6mNV2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLmIuQgukZw0KP1MBr8XSocfGxvv2ZR5rd22dmkULw4133Yho
	lAmKBDiS+zcVnSfD65xNuojmwpGCMiAFq6zR2RrkwXkSWqaQ/KbxBtazBgbmQRE=
X-Gm-Gg: ASbGncvwTToKEViY3cWQRkrZ01hNg7M/PcfJdOolSISQl5DG83lhXj7aHM2DsAopIh5
	odoYo2gZBnTwIXUH9N/a9WB6zthWM4HCLQZW/hMNsBjaTs3TXT0daNfIk40oXHo9jfuvPbreYVs
	GLbKE2zWHTMl/7PEBpjRcS4v17Lfo8WUEg0UhOUaFwpruYLUlH6zkJuZZWtx/Q8ok8KsC1CkP79
	O3fzCY8UDikVmgvSxgwzwA5aiH6t4NzPS4AJholVBQuUYXrykpzbnFcUPpZskvHFgDroaIHuZdH
	B0W/IsQPKSH5a2bli39koiPVdylpkMynqrOdXL3gO9IvI6pZYiaBMi6xnT35W6PdwPyP/z/eRrP
	OVJDE4ig=
X-Google-Smtp-Source: AGHT+IGWnyz90KvTmiIQWpZLqETqxFIeIRkLJUcNIerHzLwaG535iH8yJPYvWsNSlo1qXQYSnksCtw==
X-Received: by 2002:a05:600c:34c7:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-441c491fcb6mr89623205e9.22.1746542865994;
        Tue, 06 May 2025 07:47:45 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28045sm216060085e9.35.2025.05.06.07.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 07:47:45 -0700 (PDT)
Date: Tue, 6 May 2025 16:46:35 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: adc: ad7606: add offset and phase
 calibration support
Message-ID: <wvflf3rmqaonm6gt45gqtxndprkqbhgvce5z7c4z7c7jgdg4tm@kofkvcbvnaav>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
 <20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
 <aBTLBvw_88hQBbns@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBTLBvw_88hQBbns@smile.fi.intel.com>

On 02.05.2025 16:39, Andy Shevchenko wrote:
> On Fri, May 02, 2025 at 03:27:00PM +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add support for offset and phase calibration, only for
> > devices that support software mode, that are:
> > 
> > ad7606b
> > ad7606c-16
> > ad7606c-18
> 
> ...
> 
> > +static int ad7606_get_calib_offset(struct ad7606_state *st, int ch, int *val)
> > +{
> > +	int ret;
> > +
> > +	ret = st->bops->reg_read(st, AD7606_CALIB_OFFSET(ch));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = st->chip_info->calib_offset_avail[0] +
> > +		ret * st->chip_info->calib_offset_avail[1];
> 
> Something wrong with the indentation.

Can eventually adjust to:

	*val = st->chip_info->calib_offset_avail[0] + ret *
		st->chip_info->calib_offset_avail[1];

this is genrelly ok.

> 
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int ad7606_set_calib_offset(struct ad7606_state *st, int ch, int val)
> > +{
> > +	int start_val, step_val, stop_val;
> 
> All need to be signed?
> 

would keep them all as int, to avoid different type comparison later. 


> > +	start_val = st->chip_info->calib_offset_avail[0];
> > +	step_val = st->chip_info->calib_offset_avail[1];
> > +	stop_val = st->chip_info->calib_offset_avail[2];
> > +
> > +	if (val < start_val || val > stop_val)
> > +		return -EINVAL;
> > +
> > +	val -= start_val;
> > +	val /= step_val;
> > +
> > +	return st->bops->reg_write(st, AD7606_CALIB_OFFSET(ch), val);
> > +}
> 
> ...
> 
> > +static int ad7606_set_calib_phase(struct ad7606_state *st, int ch, int val,
> > +				  int val2)
> > +{
> > +	int wreg, start_ns, step_ns, stop_ns;
> 
> Ditto.
>
here too, val and val2 comes in as int, and subsequent operations
are int, so would stay as int.
 
> > +	if (val != 0)
> > +		return -EINVAL;
> > +
> > +	start_ns = st->chip_info->calib_phase_avail[0][1];
> > +	step_ns = st->chip_info->calib_phase_avail[1][1];
> > +	stop_ns = st->chip_info->calib_phase_avail[2][1];
> > +
> > +	/*
> > +	 * ad7606b: phase dielay from 0 to 318.75 μs in steps of 1.25 μs.
> > +	 * ad7606c-16/18: phase delay from 0 µs to 255 µs in steps of 1 µs.
> > +	 */
> > +	if (val2 < start_ns || val2 > stop_ns)
> > +			return -EINVAL;
> 
> Wrong indentation. Please fix in all places where it happens.
> 
rechecked better now, tabs in this place was wrong. Fixed, thanks.

> > +	wreg = val2 / step_ns;
> > +
> > +	return st->bops->reg_write(st, AD7606_CALIB_PHASE(ch), wreg);
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
regards,
angelo

