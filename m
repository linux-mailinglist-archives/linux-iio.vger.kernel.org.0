Return-Path: <linux-iio+bounces-27109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A90FCC0585
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 01:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF89301396F
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 00:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E582309B9;
	Tue, 16 Dec 2025 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2CAdvhF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402215E97
	for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844585; cv=none; b=uMqmpdOjw0WZ7W3szlCOMx/mjlyMHMmJl1Y6QMPuGdmTbdpeP2MIsLu+4cmm/oX4Rniit9ennJYH/abw0xp0V55Xq7+zJvHCGrIhjVphgVt2ydYc8Y3zzXT/HJZrFLeUw4uDIX0dN0VKNZ7cz1qyVJOqcqZseCCYToG+6UqlmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844585; c=relaxed/simple;
	bh=p9c38O+ZzwcCwCko1W9Erys+leH1B1bgjOYAbZU/TgQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNc3NskzZKHUDOu10lCJKew40drrg2dMwHW7EXbo5yFx4ATqPriLjm+Jz093w910nDmlDMJ7gnrDTUPEXp2134FG205lJsvO9UwGh5y19YRJI7naQmicP1mLeHjP4gJNqAna68QQOcoIjpm8IxAFfqeHm4Frn3ZCPo9L8lR7PWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2CAdvhF; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64306a32ed2so3810174d50.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 16:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765844583; x=1766449383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTxqZCzT0UvzKw9dCcrvmpbxlfqmuHmyHFmqYVWd8jA=;
        b=a2CAdvhFjry9QO3KTNbi8RjRGxXHxSbethMZOYtn+sfNTxM7/lJStq2Rfz0imFdpK0
         YGUEgWgnNGjOuA9C8GTG+ZPEMHRevzHfmvVqP/Kq3SjKs/Gx+bE2b8T7wm9KCeHlTUv9
         mqGMpqOIzC8ndOrBu6Js1Q01LyrlH62A+QZCvzveL5mEPrZ5JZxUep9F99FLT5GHQ9to
         KvYzEzCkvii1NZMw+p26CRyd9fXqFLDBMOUuD4ri5qBj7hvkc0EBjjL5U3fQxHhOWMLY
         vfXN9X3/iULJ34l05BL3SsAvQsgzAQQJ/ToeYwdB2cWLXg8E0vb5vR/fsLDJ2YshjMNq
         d/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765844583; x=1766449383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mTxqZCzT0UvzKw9dCcrvmpbxlfqmuHmyHFmqYVWd8jA=;
        b=Ja7cuCanNIxRXZxv0Uku3+CDcp4acoGYBrZs3aD5lcUVlThFvaWLoWGI924yqmbttY
         PpjF9Y1BC47qkW6ulxR5O4eSEBlqMGtntC6eBk4AwmxjM0H7vuDjC6MzCQFjuHE1GzFA
         Y/78n/LLIEeKvcRozuQ6LhZkpnTynIYYKHsZsvN7RAYa8SwsK0J0GGFqsGkSom6WB7QD
         b/K8BNu47ib8jxDIkKNC5Eu1D2PNqjaTqZckltcCJ6FYaudUILhkl9NKyt2/cMF0q8JB
         4Ubtj12Ky/uDCrtcNKWuWdAAsX5uXNZxOqvaxmc2/+Pav5LawG8TWzeMH17mzAktau1c
         CEyg==
X-Forwarded-Encrypted: i=1; AJvYcCVScaHRnZGiPrXKSCJoicVacZq10tb812psWd4eAxUW2Xeo+6IivkCR3UXRRi8YdOdAh9BGBrrX8Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbIVqIKQQAFwL5rAjen+20/zLVVhSJsPpFezoaFD/N+pacg0vp
	S4hHshHNNvj3yT1A7UzSM2xJXCp+RCBwH08TG/y8cK9u/TCDW02vy1rEP2iXxg==
X-Gm-Gg: AY/fxX5BT2O3hvdI9IH/5mfmJIwnGl8b/Qap5SzNvwmcRCGUVO7tn+Cj3vOPzlRBzGZ
	dmBf+re8Ij9HAPvR8ei+gNCKDZ7UECeU5KHDFmk4JAwZ0I1Xu+7PnoqCt8CU+vvKXM/2rOtpalP
	autig74vYetJvk5PCmLmQXWpO33j3XFH82JTYglAR0/mQRj+R+28s9ig14gkBDv8fEQef+ft6sV
	zdNgmYPS+ONyIlxQxvTpDunIbm6KIEqzLqvul0qilhfhtvEEh3hKMeqYpYoEJCGERY/l63uKH1O
	WiPFrEsusf9/B78wkOWIXD+JnPMbQqPaDSmNxgCDUcAvlQUIB3hilR2+PLOJRnhyKD5mAd6zsJv
	pZSW7h07xW4TQUzJUlchpIbH2laLE9jUX7ttDBXy0J0rZvbGgAyqvr5zgyWh4u1bR2FRsZV5F0m
	9zTrn/GA==
X-Google-Smtp-Source: AGHT+IElwuJ+Kc7oSIcguUHOwDg3yTr/Hr6n5BIFbziQ3BcagWQ4NV+UAcCv4fPA1bVGgRR+Tqb+dw==
X-Received: by 2002:a05:690e:1187:b0:644:60d9:8678 with SMTP id 956f58d0204a3-6455567deb0mr9120011d50.93.1765844583125;
        Mon, 15 Dec 2025 16:23:03 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:6b0:1f10:bc87:9bd7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e74a28c67sm33231597b3.47.2025.12.15.16.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:23:02 -0800 (PST)
Date: Mon, 15 Dec 2025 19:23:02 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606_spi: use bitmap_full() in
 ad7606_spi_update_scan_mode()
Message-ID: <aUCmZk0S_tq3SOOY@yury>
References: <20251216001808.333053-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216001808.333053-1-yury.norov@gmail.com>

On Mon, Dec 15, 2025 at 07:18:06PM -0500, Yury Norov (NVIDIA) wrote:
> bitmap_empty() is more verbose and efficient, as it stops traversing
> scan_mask as soon as the 1st set bit found.
 
Ah, please read this as:

bitmap_full() is more verbose and efficient, as it stops traversing
scan_mask as soon as the 1st unset bit found.

Sorry for miswording the commit message.

> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  drivers/iio/adc/ad7606_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index f28e4ca37707..7e17ccbcedd0 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -345,7 +345,7 @@ static int ad7606_spi_update_scan_mode(struct iio_dev *indio_dev,
>  		 * has no way of demuxing the data to filter out unwanted
>  		 * channels.
>  		 */
> -		if (bitmap_weight(scan_mask, num_adc_ch) != num_adc_ch)
> +		if (!bitmap_full(scan_mask, num_adc_ch))
>  			return -EINVAL;
>  	}
>  
> -- 
> 2.43.0

