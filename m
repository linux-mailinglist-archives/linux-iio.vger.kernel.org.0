Return-Path: <linux-iio+bounces-26003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C62C3E2A5
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 02:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EAB1887757
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104482F9C3E;
	Fri,  7 Nov 2025 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+3wDGWh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45797548EE
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480429; cv=none; b=Q7mCL4O2L/Bi+B2uYJ8NLCI90rnOCJY4s3TN+B+yqL7n8JTwGPnXS52z5jA95uAZWWperSoyEILwl469LGd4qPiIwHeoKha/YfBwxmH43qtycXwCbNT4AlSPGWcymoDv4pq4KaBqHHuPh/RiP6opuU3kwbppt/KWOcpDKpNS4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480429; c=relaxed/simple;
	bh=q87xcR0fF564ia62mdHYwusdWAN6B+KzP9Ns05as0mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ4Z4mc5iM7faUiwqx7s0tNp0GRFTa7nx6fozx7scV/MVZk5vnv3DnJEqZ8isK03t7k62dHxyZGL61n/KAQ+FqybGhzyz7q4dXt2VKXG1rtwY/m4R0EgMlT4tj8y5odQ5UbKDSlmIDRsEg1YEnPuBNB+nwGum4Wlgz0bEPEfp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+3wDGWh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo238036b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 17:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762480428; x=1763085228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDOKCxMylV7jhy3wGWnM3j+qZQ6bCToNFKqiv9ib6xM=;
        b=D+3wDGWh349cFx4pbS2qLuNnr/fVsT/HPgMvk60H9JXiylKe8Qjo1MrIlJlV7qby2A
         oXuEezBvq45RVUf3a/rJH1NcBd1kV7o1Za4VnbhhKBZ+T0em2P3bPWl0p1uHmd088fVI
         K5Hj7qNAg3o9+7rS63eAA7ktRH837exf8DjpR9qwMkrWVONdiDRbuLWTpzn4bEmJNc0e
         SgnO97bk7U77KClmYF996Ls5C1hU5+ny5mpEAdBJfR2R9dF4iInts7UEt2SM6nrs+KBW
         NVTC3FXOeUTDoacQof91BRnPdQMH8uxWO9rFaOSeuneLFlIMQKp5JAayrEswgZ8MCDVN
         l8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762480428; x=1763085228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDOKCxMylV7jhy3wGWnM3j+qZQ6bCToNFKqiv9ib6xM=;
        b=VyieKxKWx4OKYVTo1seGpgYXnEAyHSw2bzEC4EA4azZjgd7U30bbwbOAkmy7LU5ioa
         H8wE2BijwfOO+xbGMBU+XdV8IVOXUeO+GZ9V4KBE1h+Ulx8C2rDw/19JJ0q5PI5wZrBK
         s/jTPSjh7A+k4OWcT8+2pZ/ShcP+rm9U9pgH/SP8JC8Nrxixtn/xZW0E5W0CfxnYpy18
         mDPQ/c0Xv/6BkUMSKTPTHnNJhwGbOjjwdokVoHSzwRIcrYmlkW0oKnG2et6nAnp9oGM2
         vNV63TNf4L59w7MXmd57apy4R7MgZmiFzeCqaf0L3Yoll3cBo84kmFO4xBLYEKK/BpXs
         xT1w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6R/4paWp1sdRpf67JzpZbRAd5rtO6muq4iM6vzQnicFh0wgjtHpxICsTFwC2t/EX+lme4fmgbII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAs8AUuUx3NR0FSfRRj7idP7crYdQKxg9t5OYXIBblF4rc4OoR
	bpmNX5BSctWDEsW32q1vCp35UQGFIFeZSGUA8NMAC9jjJ/GCWEoAPSc3
X-Gm-Gg: ASbGnctYb4Tv/i+93QIeVcS+VyQwYjxSUKPLQlP/vjgneUJo2hC0Ed23RAwM3JA22qF
	kuRTHPaWANrQO6dGvZb37s9+1DniOxC+FeHBxSvJsVS4UtWWUzyEjnHuVw+4Wsv9aiUC9ZHaoAZ
	bHsaoK2Mw/aq6ZTc/N4IkHjUQCnoqhyaAvgFNzfvlH3ukL4A4SlHgNXynRv9m9dievg24jN5yB3
	4p/qC3QQ85hn+kPAdx8F0hMhUGjQQRMNEhQV+emsq5oFFBXd7bTCB3vKs0i0G1Bsf9BiNfkcIU8
	vzhGa3lH5xTFUmXC9Mi149vAYH/xB2M+yXFMtrTafsOTOA+ykz+yS2V5uJgMirr9oxS/YlDQVqy
	ROSVeyguqb+KKX3pHWBvCc/cnNEXzZEMve3rNlZLYSiSZBi3Vl5cMKgzth9oANnPDpr4qcxr5zQ
	NFVCPl95KwNQ==
X-Google-Smtp-Source: AGHT+IFB+Zl6zjqWsS0NOUSlCSS78ppjsDoqoEr+nv9M952CWuF2yyz0SdKRbGPURZsPlphRY2wjWg==
X-Received: by 2002:a05:6a20:6a13:b0:342:6c97:3693 with SMTP id adf61e73a8af0-3522a772f7dmr2127084637.47.1762480427616;
        Thu, 06 Nov 2025 17:53:47 -0800 (PST)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7b0cc179e7esm974255b3a.46.2025.11.06.17.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:53:46 -0800 (PST)
Date: Thu, 6 Nov 2025 22:55:01 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: mpl3115: add threshold events support
Message-ID: <aQ1Rdcbi3e8lzOvM@debian-BULLSEYE-live-builder-AMD64>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-3-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105095615.4310-3-apokusinski01@gmail.com>

Hi Antoni,

v3 looks mostly good to me.
A couple of minor suggestions in addition to Andy's.

On 11/05, Antoni Pokusinski wrote:
> Add support for pressure and temperature rising threshold events. For
> both channels *_en and *_value (in raw units) attributes are exposed.
> 
> Since in write_event_config() the ctrl_reg1.active and ctrl_reg4
> are modified, accessing the data->ctrl_reg{1,4} in set_trigger_state()
> and write_event_config() needs to be now guarded by data->lock.
> Otherwise, it would be possible that 2 concurrent threads executing
> these functions would access the data->ctrl_reg{1,4} at the same time
> and then one would overwrite the other's result.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
...
> +
> +static int mpl3115_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	__be16 tmp;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		val >>= 1;
> +
> +		if (val < 0 || val > U16_MAX)
Alternatively, could use in_range() for the check.

> +			return -EINVAL;
> +
> +		tmp = cpu_to_be16(val);
> +
> +		return i2c_smbus_write_i2c_block_data(data->client,
> +						      MPL3115_PRESS_TGT,
> +						      sizeof(tmp), (u8 *)&tmp);
> +	case IIO_TEMP:
> +		if (val < S8_MIN || val > S8_MAX)
this could also use in_range().

If you opt for the macro,
#include <linux/minmax.h>

> +			return -EINVAL;
> +
> +		return i2c_smbus_write_byte_data(data->client,
> +						 MPL3115_TEMP_TGT, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

