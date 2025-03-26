Return-Path: <linux-iio+bounces-17273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CE6A71E7D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 19:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4471B7A5B75
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABADB24E4A8;
	Wed, 26 Mar 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfkTqqNS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0BA19CD19
	for <linux-iio@vger.kernel.org>; Wed, 26 Mar 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014045; cv=none; b=hHc1IXz0POoTR/OJQrzg6BHftb8kEKp1VKjouHVdgEMe8MLYmJXbFnPikDgwQ52UElooXz/9L6bnrSfOhR0RLXAWt7NozPR1zSIPHcIN1w/T7We+NplBnMjX5E/903/PZFJDqws5PbrEcW/hhbP8P/RGMeMXcVCnWD4CFAat8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014045; c=relaxed/simple;
	bh=b19NmzBCw2sWuSkqxyqzPi0ZMKXN4351HMMlhnZscOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITLsdKJyPFlI65quAbW8zwHrrUpR4DFQcvMS7b6XhdmyGUKCXXO3ggyvfX59XyE9GQih3iJBCIOwrci37ssOIUkwvT4iAXtbp1XGDTMIlJnyw9hgwBOoIqRF9ANXSwmYn1O8cMqFtdBLrr0uCu98fD4OTDRAI+iccsgzhjClAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfkTqqNS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301302a328bso181434a91.2
        for <linux-iio@vger.kernel.org>; Wed, 26 Mar 2025 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743014043; x=1743618843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0E+JmJenVs3c64xRcG6d2WAS6Pyqy4NPev4BtX7WkU0=;
        b=lfkTqqNSFUw0xOIUJSWtGUqoNopNSylu7GloOAygbNk1CZyJBAWE+GRH+xDzGhYmbx
         kMEioU4kMEHRdQAgwnjyQS/L47GTgLoKywazrWNoQ0+AKJJL+8m+srj0DjJnKEzW49lt
         uCxReTwHM7wmel1RJuLkx4CDqWNbX8+AI0qmU7g8k2Fg3zT3SxRAVNHOKOmSG1BhIsEg
         YRVNJtvDLtO2UtBiyrVqjelLTewV7wyiUHd/50fefMO8eN7uRHXtFZlRnmLIluQIUmN2
         JuNYrm7Gni0F0MTAC2J4wUCPPokVIWkA7qmDuv9FTq4tXf1psdXbOqQf1kjIIqK8dg4Z
         2AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743014043; x=1743618843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0E+JmJenVs3c64xRcG6d2WAS6Pyqy4NPev4BtX7WkU0=;
        b=fvfbDbH/SNIzsaLt+bvlCdoJOndGgCIMwWLFcZhyhJiLQ0D5ZnWTc2numQgRlGxZkX
         8JUVvyM1fGJOBpcOry5oJQZ0/y/SL1iznMbUTrjaTLXW5wsWHONjEypO8oax5gYEl4Ye
         XAa/9M8LCjKAYOBnB3LH8UTd27LdjSwWNARwYvJ6ur/Zq+9beYPqQo56EKBcwMWk7zV3
         OKiVtH3OM10kobzWTvToN6qO/aPhdSIgfRDT7ye8x4n97eNh3hF0vONQbISDCShA2TIO
         UpfirBGqyoxHTceg1jW8+fd5RlKXM+Oqc9mRaGQHNkVOtUE0cf60RYx/P4Ta+zsWnvuh
         PtvA==
X-Forwarded-Encrypted: i=1; AJvYcCUxB6O6M4LcUBnrf2eiCjFirR+GIH/fd5ox+tYedR9cONE+ADfZT8zMyuIJa8wIGN8uEkcE2+DspXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUj9wJyAleki+fNHRo76jXyUy+hy8ouv2DYtU2Owaog1q9g0bT
	Z/3yJN9RtIwsdjlHtAuw7+Cx6xGEFFAzYFmt2357HB4SqS/EkhW3
X-Gm-Gg: ASbGncvQLnnHZj7gu/PI6Zp2a/sXm8RLSUcWLc06jIvjWiL5OiKcI6VuZxBIjyenR+u
	rzXVTgLBDHxPsm3uQMMMfPUGnF7K+zMlYUi1bcm4pRD0svsFNC4BZwbvw6mJJVfWoJ20t0AoiG1
	7zVTgJZj0fy7aEIKZEy7LtAo5lZ9Rtfme83UZbpkcUxPkooKZJyqB5bWIzC7PGIZ9ufylQbKSLW
	9CSUi/vE9nR5oHYbIMHHGahDfsZ13A6/dd12LQZi1ilaasHLmQPg0YyHZHCZDE6xAacZaXQm2cQ
	iQ+bk0BhtFlBnx1EObp+eFxKsuoSIM4ywiYV9sXXC6re26Vy/YrwvGQ=
X-Google-Smtp-Source: AGHT+IEwgEyZ3JFn6MBd1FWzAU3VVPomLEiHDfvEgQDpUN0VG5PFEwCPJCGkdeEUKyINxr8f71yRpQ==
X-Received: by 2002:a17:90b:514b:b0:2fc:b40:339a with SMTP id 98e67ed59e1d1-303a7d6f80fmr1214507a91.10.1743014043039;
        Wed, 26 Mar 2025 11:34:03 -0700 (PDT)
Received: from localhost ([2804:30c:1f10:1900:2580:2d5b:b16d:c55b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3037c8ecaf8sm1767673a91.0.2025.03.26.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:34:02 -0700 (PDT)
Date: Wed, 26 Mar 2025 15:35:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: ad7124: Remove ability to write
 filter_low_pass_3db_frequency
Message-ID: <Z-RI2JsbK9l2aMnY@debian-BULLSEYE-live-builder-AMD64>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
 <20250317115247.3735016-7-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317115247.3735016-7-u.kleine-koenig@baylibre.com>

On 03/17, Uwe Kleine-König wrote:
> There are several issues with the function that implements writing to
> the filter_low_pass_3db_frequency property:
> 
>  - The sinc3 factor should be 0.272 not 0.262 (this is fixed for the
>    reading side in the previous patch).
>  - For freq > 1 the if condition is always true so the sinc4 filter is
>    hardly ever chosen.
>  - In the nearly always taken if branch the filter is set to sinc3, but
>    the frequency is set for sinc4. (And vice versa in the else branch.)
> 
> This is broken enough to justify the claim that there isn't any serious
> user. Also it it counter-intuitive that setting the 3db frequency
> modifies the sample frequency and the filter type.

Not from engineering background but, as a Linux developer, I agree changing 3dB
frequency to set the ODR (sampling frequency) is counter-intuitive and uncommon
among other IIO sigma-delta ADC drivers.

> 
> So drop the ability to write that property.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

