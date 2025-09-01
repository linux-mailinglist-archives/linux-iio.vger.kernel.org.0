Return-Path: <linux-iio+bounces-23571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCE8B3E007
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 12:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62B53A9E34
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5C30DEAF;
	Mon,  1 Sep 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5gUYk4F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108A717C203
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722227; cv=none; b=Q03h3+157JXYbPvmhlfvz64EHHg2lu+JoW9QWB9mW342NuCBPp6nFmfjmsGR+PrrM6OTm1E/VUF+Kc74VJ0H4tm79+gQPyW8zIV3wGBrzdL9glObbsY8oDjlGCx4lk+KRHgtqdxRyT0MPXDIKHuxW0lX2QDZfkjGjVLXE7wh1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722227; c=relaxed/simple;
	bh=iN7KWIHWLryomzRy86DkhEHpxBZtcIx3XkEBd/1FjSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN7ilEPgvnou6alHRxxuGL32VgwopqPECAVtbHB/4eJogDSqhWgmtdLWVLfVp1A25lwizVtl2nAkASROY8b1UykBkYuaT9cm28OD2PQw9SXh0Y6NQDjNqw6p1/umVCrUdexi0l08x9tJ+iM3lz+gWmoHPNd3GcZ4jGpyUQzbpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5gUYk4F; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2750010f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Sep 2025 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756722224; x=1757327024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FupNSd4N71G5RaqRUXbWr5mmoLboe7U184QjCzCsDcw=;
        b=a5gUYk4FN/Cc6f6d5FGj5fp+8JLAKSprkaYVD+MA4lTXnQeusO2dSl8Qse6CivjXvP
         MxnAkBgwlDwpS2LOUSNrV8nMLOxa9/B5QMR6Rv0dnmr2emX+dytnZSaywWiIzs74/scl
         abXnmJfwMlxxP9Y1BJaxh4rDhSGv5FVaUUCpZlKEieIchf269kzI7njHxumWrS2V1JA/
         q2djFxpuw1+G0fwIcisBl0bFtlx1YfcPzSetDyAGNEM8+2zGxDz7wm3G6F3QaaA4ja6w
         7cH3rt/BezXGtgxC3EW+pXi/rnHnW8lsndGW5pLThBu1pOdpPIpKAOwA5lRaV/jQgPUr
         Ojhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756722224; x=1757327024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FupNSd4N71G5RaqRUXbWr5mmoLboe7U184QjCzCsDcw=;
        b=Yi62tR/7RUAws5heFJy0MjSHN1fJJ1kV557KOLGd4Dxt469ddj1P6/eQkiYhlbca7S
         yajyP3lSl4Xq5pk8YvIWsbxbdv7XlJl1QYaS4s6jb0IqYoGDKFMETvWXrIQaOhD3c8F1
         7EGqvnfBS9sdnBBD1cnue/OE/QR+WrGEutH49N5RXoL+1D3/pcE+MlqPuDf/PjiuN6Da
         mt/WZjA6BDzRwbEezNpKUXfhBLPi4ttYBEkUKxeWcY4jwp+gZPy+uEil0kCFnNhR7DF6
         GBLdPdcjRm5MGCxsY+Qg5L1LpbKL/lXM4/xjrgW9sHlS0NtHVmTQ9al0a5Bx0F3yLiJB
         UkWA==
X-Gm-Message-State: AOJu0YyGy77N5WfqfHh3pEmYcchBkJ/aUrdEqDH3OlqBM4DqCglJlhBV
	uCkgQiIfx2bVXEXVyAKG8bjk9ckhODk0S3r3ASre63c6aKnfvPBg7UAmrExfGGrqNlM=
X-Gm-Gg: ASbGncsXgJ8AqB37P/BeZTDmQyuM7egbS5L6A+tuXxjA252+zQplTJdorUPDC3VRH+F
	RtX+hdrQons3gugt1K0vOuak4xdfoBOBJ63uNIcbnEfBWsv6q6FM7+98SeVzA7N28Monuo+szRF
	KEsYSvptpMIVZ3LgGmbI8Jdf8PI+43j2rOUxCkbjlA28vVnHB+O/O1azrQI19ji1vzNOi1O7QZc
	do2GLLsRDwOkWEEqoj+od30YwrU66pAF55pgxnYBYJUvge++qphO1g1ZND/br4cKpd6jWpJ1H7S
	aZv4swGcBoL9uUCDnwNn9meHCNSWQvOeXyWu9ODqRuKWHO5nyGU5G1ZLNnhKDndYNev6cPfQHXp
	Xp9gUaTpYfrrzRRLSNhQ5Dvwcdo8=
X-Google-Smtp-Source: AGHT+IEv84aTwWbs3yO63r/JRI24Eo/yePwO1sRQK5IAZ7R3Bl3405JKkyTVYcyfa6amc+95TrXJqw==
X-Received: by 2002:a05:6000:65b:b0:3d4:a64:6754 with SMTP id ffacd0b85a97d-3d40a646bc2mr3954157f8f.62.1756722224384;
        Mon, 01 Sep 2025 03:23:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e7d141esm155678035e9.2.2025.09.01.03.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 03:23:43 -0700 (PDT)
Date: Mon, 1 Sep 2025 13:23:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <aLV0LBxD0KIHPSmo@stanley.mountain>
References: <20250901065445.8787-1-moahmmad.hosseinii@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901065445.8787-1-moahmmad.hosseinii@gmail.com>

On Mon, Sep 01, 2025 at 10:24:45AM +0330, Mohammad Amin Hosseini wrote:
> From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
> 
> The ad7816 driver was accessing SPI and GPIO lines without
> synchronization, which could lead to race conditions when accessed
> concurrently from multiple contexts. This might result in corrupted
> readings or inconsistent GPIO states.
> 
> Introduce an io_lock mutex in the driver structure to serialize:
> - SPI transactions in ad7816_spi_read() and ad7816_spi_write()
> - GPIO pin toggling sequences
> - Updates to device state via sysfs store functions (mode, channel, oti)
> 
> The mutex ensures proper mutual exclusion and prevents race
> conditions under concurrent access.
> 

The commit message says "might result", which basically implies this
is from reviewing the code and that we don't have a stack trace?  Is
that correct?

Are you using some kind of static checker to find racy code?  What
kind of heuristic is it using to find buggy code?

> Changes in v2:
> - Fixed mismatch between From: and Signed-off-by lines
> 
> Signed-off-by: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>

Please add a Fixes tag.

> @@ -200,7 +204,9 @@ static ssize_t ad7816_store_channel(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	mutex_lock(&chip->io_lock);
>  	chip->channel_id = data;
> +	mutex_unlock(&chip->io_lock);
>  
>  	return len;
>  }
> @@ -322,7 +328,9 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
>  	if (ret)
>  		return -EIO;
>  
> +	mutex_lock(&chip->io_lock);
>  	chip->oti_data[chip->channel_id] = data;
> +	mutex_unlock(&chip->io_lock);
>  
>  	return len;
>  }

I'm not really knowledgeable to review the others, if they are
required or how the locking is supposed to work.  But these aren't
correct because we're only locking around the writers and not the
readers so it could still race.

regards,
dan carpenter

