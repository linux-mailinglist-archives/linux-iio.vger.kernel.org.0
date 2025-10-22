Return-Path: <linux-iio+bounces-25356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10676BFD85E
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 19:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B077534553C
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6EA2566F5;
	Wed, 22 Oct 2025 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJpXCiIu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4283F35B15A
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153530; cv=none; b=BcIHRSxdMuQMbfsrKpMSxCKtkVAIN8o+OhIM70Z88THBXzGiRKZ4QZWw8PxsaPyC/b2u03Qb0MgvzyHzyxRAOBhRZjOyM2aw417AKrNtjVPk2kWVFi24Mjojzr2levwAytCq3uzqs0veIYkAY8gs+/2063ncfsGR30ly7ZpMSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153530; c=relaxed/simple;
	bh=9nDv38hCGbawjqulRgNJdaybqnPPjLmt1oHyNKm03DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYDpnt3X07AmLta0IBJUX2c57iTww7GXPQl0rLCrDOTjzusNo21jgNyicrO9gAkHZZMEFnYhxMFnuafSq0ibQ6oLjR2AELISmYJRCjfTDoPyAVKCLe7EEfh6r6nd/S2q9JgtTXedNMUVWNkmQYq5UiNfJihdoRpF/Dzeja9VGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJpXCiIu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso6962395f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761153526; x=1761758326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZd7NXk0kvOiCANiny7CPaVuKiR6qb7JU5QnvdLSwI4=;
        b=IJpXCiIuwGLquPR66mO3rqLU6wRoWvaCBrp0PYqwIMGOWBCEMaP26aTpmAligg/ZID
         shcPxnvCC10FNeGvdRE6E5DqPbs9YEPIyna3hlVKv4ObtF+n3TwmO+1kvBdVPDby/qZW
         6lfU8FV92aEsJK/I2btdiGlFwOWNCg93rlI78yQ0MFg9A7cN+xdmNBQOI9eUQFEGbVSO
         +dMr/vwTM3bHVrFkKjVHxSh4A6duvVU55fyyZtoTYXbcfUIr9yX/9Nybag1xPzBvKEZw
         yJ8MXKsExDNEZkeKKEjEjD9JtEPC/tpzwMNuXDC3VTn8xaWXHqB+cFAsRQlBYuxDr4HV
         w4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153526; x=1761758326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZd7NXk0kvOiCANiny7CPaVuKiR6qb7JU5QnvdLSwI4=;
        b=jkCl9/Xt78Csf612zqemYI0to5tuEXzoEyBpNs24z+tyXQO09teNrT+3/m3DJLBFrL
         BtGO59MpN4kCZUIijWjGIYFlYdEaZu0FNVZquDGLrnaFiVAOEXRjRkFfB3aaTz7L/OpX
         sLCplv18rq/AByGBzVcC47fIf+wuK0gOur90bNqWpCtqGROtCrA8F5Nx+BZhWdeFErtb
         1t7PXz57VIZEFJZokpUEf0uV39XdLXQ9tDq91vnE0L/T4opm10nDwYnmfMnGZcC/pxGy
         w6r89gnkUyy+w9K+c19+RCvYn0FCW5PtaScI2tx626On2CKD3BAFEh8HABhCKaIj5K69
         uo0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyZ9d5XcnVZStm4QA0jSHB6Oke1NajUat2DyNoSuaQv2MDLIBy0WvCR0Hdd+mipgsVFlNi5Wfngrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83diqp8k8GehCdHH5bke5znec8cH+swux8H7fuqsN1X5DcyJy
	xTWvBHi5XDjoB+Wytifky2v2rtgUHQYmU+X7JNs83tmbpsPzd13OfynrY+XMVa1J4is=
X-Gm-Gg: ASbGncvpUBIvVE0RuzhSfpK3NbfiZrPUvfDQqT4oodNsSiz7tCLmMDBuD2rOWsn15Ld
	hCbajQx84CcOvKn1JmO3Ma+wW904Xz8fROzbfu0hx5k3BQzVNBCltDfBLtlGAWcFgrl1ixdfUM9
	ixyh1mBFWCxBlK5WcR/UWh9xnrKeJ1zqbj0+tQ6l1jRLuj4S3wxXYDGxSk7GrB46iEj/oXV9q24
	8DvV0cPv/8v4Jfcm3bJcyN9cspmFjE5zZjjhSe6ho4c8FsULASZotr6XJv+bnlf00yotQtkmx7F
	a2ffe+hw9Mlw8lqwqeLSvGYMcm1+0yMjAsO08RvTLtvDWpHftYV3Olx6R11PclyledTBUd8rxit
	ind/ItVuQPummz1mrwOFu0Qg9p3FnKmzGDl1C4J8Xts66uz0EU3D5JxcWTFBllQcl3kRmT8ZLyp
	/pZzyOVEBQUh0c/JAC
X-Google-Smtp-Source: AGHT+IF/18UTLbuAPy5mzziER/Bg1lMDCNNls6lTgLx/+erLteq4Yb3HlU/Bpe27lriZCde9I0QYvg==
X-Received: by 2002:a05:6000:605:b0:3ea:c893:95c6 with SMTP id ffacd0b85a97d-42704d86b82mr13969661f8f.18.1761153526491;
        Wed, 22 Oct 2025 10:18:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f009a96asm26486677f8f.31.2025.10.22.10.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:18:46 -0700 (PDT)
Date: Wed, 22 Oct 2025 20:18:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix possible OOB array access
Message-ID: <aPkR8imukdrZLdfk@stanley.mountain>
References: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>

On Wed, Oct 22, 2025 at 10:15:05AM -0500, David Lechner wrote:
> Reorder the channel bounds check before using it to index into the
> channels array in ad7124_release_config_slot(). This prevents reading
> past the end of the array.
> 
> The value read from invalid memory was not used, so this was mostly
> harmless,

I didn't spend a lot of time looking at the callers, but an out of bounds
read will cause a KASAN warning at runtime (hopefully) and if the page
we're reading from isn't mapped then it can cause a crash.

So, it's not like we can exploit this to get root but it potentially
could be annoying.

> but we still should not be reading out of bounds in the first place.

Thanks!

regards,
dan carpenter


