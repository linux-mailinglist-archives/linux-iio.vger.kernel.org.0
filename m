Return-Path: <linux-iio+bounces-20980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDC1AEA74E
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 21:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4254E10CC
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2951F4176;
	Thu, 26 Jun 2025 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSXAvR5r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21617741
	for <linux-iio@vger.kernel.org>; Thu, 26 Jun 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967297; cv=none; b=AnSiqf4Y6P6DtL666Xc2qLFHDt9sZVtn85ZRUYgw6wMleXVUFjD2VKyxBS5/OMWvZAmlhUQjviNTBxNE+ratPTko5m1Kzn3h094x1XjALNLMJ0Mzri02cvnFH7I+ngPdtgW+cCEIgk8Yi/jOUtcQO/UH+n0CYagUx5hOVY4lYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967297; c=relaxed/simple;
	bh=23BP8b5tGpuQBzAkycWie604k3cXGeyTDeQHKVzqB8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEIRU3RYltXnRLHlJoHhHTE8lbavaBO3uoR69nGok6J2ZW/qpXim5sPzSy/xEDzrNeEmES39LbfNLDI8BYCJbkbvzsA+A2LNjhqdAYC8kNyBO8RXxJTOjk17O0PgRsDW7FOrBWjiJcbAWvvMqSLv5gIXWeenNutg9KMH4Hro4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSXAvR5r; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2efdd5c22dfso499449fac.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Jun 2025 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750967295; x=1751572095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEoJVyuljlGp3xPTpAgnwiJGOKNLLEr7nGdVkY/IvZU=;
        b=sSXAvR5rwl2X5JGjfyIi8X/eM1w9UIyXeUrVRR1ZBkj6/tsqAFrpD/heE1jZGgG3L/
         okok0jRAwS71EdIUNl1NKDMcIv9XsH120ZgNZUPAoG5lr6JwFnVCKRGvLW6sSW6N67I4
         romCT4799WkKUdzvZaqTmzf1rVIGdzSfaew7kgCN1l5UpP9YxwmNhd/6/IBIU4SpCir5
         irWaxC5RF6AtO4FnGM+YJVGWsLFhZQ/X3Ujqh0VVBi3jg5bpNkwWVXIh5EWwZowGUeCl
         b/OzayWn14XDDeF9r/aWy9Bfnf3u9NZjMhbg3548TUSus7O8G5sviNKZK3/eJStH6+bw
         hyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750967295; x=1751572095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEoJVyuljlGp3xPTpAgnwiJGOKNLLEr7nGdVkY/IvZU=;
        b=IIqFyoSphM2dq/GOzsjkFQlSZJhgC8o4eENWrGHeKvnAWmzJjO5s9lc5o/JqjY4mmP
         6HUvUA0q1hpwnscwiOhvUuQOaxskggVpOJ2M/hQggvfqcG6dx5mMi4RxcOzOQuGyAQeS
         3sPZjizKm++PAX3JEi7rcbGw60WacJyQHbOHjs5V1h3orpCsFGaiVfZ1mIHd5oX2GRQ8
         pQf0hb4tIfPgb+IuDHM1VYAVilau6+x//eLmiU0Wu79X4S3NG3lRHlagFQkdt1iW1n/3
         NPX/2dzO0TR3GI8+NpsBknSUNd21Ac3RREa7Hz6s5HlnqbndySRVTz9e1EcYJEVE2gyk
         y8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXz5EFQCKVTfbEBUDiePnBNmklbPR691k26538kU+ASNqk8UC6QOBQi55uReurq3CkbHnRatiotNAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTwleFfal2UO6nBiqO+uW7vGPQZuijpGDdn8LP0BFpuIe6fDu
	p+bpE5zieRSwg64XLatobbdTF3PC41AfYZdLO/qPxOf6Sj72Y+07GPiZdu2rN7e7mbk=
X-Gm-Gg: ASbGncvtwFAcZvvGzU9g3TLEwLUNzsIvQVaLWbGP31mn5ALZ8E5G1cnjcy/AlAecEg0
	4fd5XtsB+tk4dKeYGCrmlEQhh0nNz4oji9MrCzVe+LdxhSPX/lEJSZio/afngNnkPlNm7SnB/Z/
	SspRb+s2KCSNYi7kZI9f8uZJ2e/9crQ1IanBo21KdcJTi/H1J/H1rtSBKYAAOm4wpVMyvK1Tfcg
	Fgh7wvFOVHtNuQYRdVG1IE1tvS17krU05bCYYNJvEYH+0mMu7Oj/Z4iurX2x3ANAXLeOy3eWG8U
	juktXwSqK0M6g31s2ni3A5fcWxoIAq6ZVzGG+vn2bi0I6CCyNYaE4Uj27vK8uTMqfw6bGQ==
X-Google-Smtp-Source: AGHT+IEnNpH+fA2FaExMXdqmQHiMaFUEVchLMsWsoDgpD4qZht7Hb1j3IRi8L1uvBA45hKMs5bxgDg==
X-Received: by 2002:a05:6871:78a:b0:2cc:3523:9cd5 with SMTP id 586e51a60fabf-2efed52d228mr218104fac.17.1750967294850;
        Thu, 26 Jun 2025 12:48:14 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2146:7e21:238a:e0ed])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd50b0cf0sm495757fac.29.2025.06.26.12.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:48:13 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:48:10 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, jean-baptiste.maneyrol@tdk.com,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5 2/3] iio: imu: inv_icm42600: add WoM support
Message-ID: <dcf86acc-567e-48e3-ad15-fd9522b46180@sabinyo.mountain>
References: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
 <20250623-losd-3-inv-icm42600-add-wom-support-v5-2-4b3b33e028fe@tdk.com>
 <CAMknhBHaSBF-a9nLZ0ZxB2-9HzYkPMBqUr4Aa4TthNnJMwtFgg@mail.gmail.com>
 <20250626195323.6336820c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626195323.6336820c@jic23-huawei>

On Thu, Jun 26, 2025 at 07:53:23PM +0100, Jonathan Cameron wrote:
> > > +static int inv_icm42600_accel_disable_wom(struct iio_dev *indio_dev)
> > > +{
> > > +       struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> > > +       struct device *pdev = regmap_get_device(st->map);
> > > +       struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> > > +       unsigned int sleep_ms = 0;
> > > +       int ret;
> > > +
> > > +       scoped_guard(mutex, &st->lock) {
> > > +               /*
> > > +                * Consider that turning off WoM is always working to avoid
> > > +                * blocking the chip in on mode and prevent going back to sleep.
> > > +                * If there is an error, the chip will anyway go back to sleep
> > > +                * and the feature will not work anymore.
> > > +                */
> > > +               st->apex.wom.enable = false;
> > > +               st->apex.on--;
> > > +               ret = inv_icm42600_disable_wom(st);
> > > +               if (ret)
> > > +                       break;  
> > 
> > The fact that scoped_guard() uses a for loop is an implementation
> > detail so using break here makes this look like improper C code. I
> > think this would be better to split out the protected section to a
> > separate function and just use the regular guard() macro.
> 
> Good catch.  This feels like something we should have some static analysis
> around as we definitely don't want code assuming that implementation.
> 
> +CC Dan / Julia to see if they agree.
> 

I feel like the scoped_guard() macro is so complicated because they
wanted break statements to work as expected...  (As opposed to how I write
half my loop macros using nested for loops so that when I break it only
breaks from the inner loop and corrupts memory).

regards,
dan carpenter


