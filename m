Return-Path: <linux-iio+bounces-7268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369A8926621
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 18:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DE91C218DE
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED82183098;
	Wed,  3 Jul 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2uYEEO9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5FD18308F
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024189; cv=none; b=V2yzprzpAEy+JRazme8Sq4gG39skg8mYvzqr5q0Te+sUEoB3tqkS2ogl148i+6AQxjwVz8gu1tden6vHe/IVg+lfhaIZkjNsF+PrCwN2nWdTy/uwd/uYMgABESt5Hw920Q8BkqpC5dwWwFfscX+5OAUWBBWQm8XOUx6BOwCC/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024189; c=relaxed/simple;
	bh=aNIR/KnDS/D87sfRG4FlVLnAx/6qwlwcseVvnzirxcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU9CqKu1Q8u5VARmfbJlstTvwMVSuQKIYK51xholbNkIXLaNXAljPooQEDEHDgNO06nfVRXfeGzLXRAg7dh4oklgX2A5AlKXcJLj204HGVL4oUOrTTpXYjARJhlO2i5cCdB2T3W7Spa6ycyJq2vXwReBklcbNRoCNnFU6zp5Kd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I2uYEEO9; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c405dad8b6so2702254eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jul 2024 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720024187; x=1720628987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5O6q9Z7NTtFmEDBkDLtJJ7YaO922XTE0oE8J7a41lQ=;
        b=I2uYEEO9rcyqhZ4co9AqcX57zQ0nq81P+3QsAUiC0+I0n0cuwUYM5kccQ4N7SkcYmv
         PhzjPp7VR9WVoiK1Z1tK+7dgWb4UXFjIatBjnoBcMizpaUTrurk5MlbLyFx0PZpcxQK8
         Hlo2KT9wLLLEB3y4pNL9AEr6Kbkqi+pMB3wNqbpGqHGqBWOD1l+31Fb6LPJXyPHNDpwr
         jY6YKJ+zzjo5OcJjTd9zFTdQcCugYk5lIfQ0i1bhsex1L38svd/Xa2/nbKlKYTDqMp1c
         HgJK0Ti96O6U6k3fXXI7EtwSJrlspjIqXxDDbsw70dApK1EVdhwkFjLHLw4nQ4rCJBG6
         0TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720024187; x=1720628987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5O6q9Z7NTtFmEDBkDLtJJ7YaO922XTE0oE8J7a41lQ=;
        b=QQGsl9zz/VmOetpyyGtJHGJ9PP6tGk2IVJHMnCHKt4L5GzwAHsrVCTiWPuCz0cMSXu
         JZDpaW39fq3lsWcSL6BMiZBtBTbGGdPp+ye+2IzAb9qP8ZxdUT+oolWD7rMTJ9Ak9z6Y
         atFh6O7k60idWn3nOt9x5KWZiHWUH/12O1j2PTfvP98f2Cnihl7zjeJw8Yy2UXX5ik3Z
         9Skxjeqw959I8LN2tIl31NcmAx3OBvN/eZbxihPo+khGFw8OWcCIe2MRlJ0TQUMfyrwS
         lKrkRrSa1p2QyErkPaoQCHBxhyXgjQ/8+M/y/aUDGHHRxhgr1YdwqfLvFNkL7a9T7sSy
         BxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8n4n/SmP5kC1nfedVfliQrjaaQ4JDFVm8uSCaCOeqy0rhPHBZW/v8n2unidq/tDCMP+hhyF5vJ05totl8JYJQlb1vhfX58ZYa
X-Gm-Message-State: AOJu0YwcikwPX+8Z3nL6hbWaVr294FzRFdnJLGG1bhHBpoK9ddHHzy6E
	nTXmJJlVzmpNiN9vWpeOFbI27Jv0uzM7/ULVbUctl/tiLyFyVtIQA6Q5QrQvWoo=
X-Google-Smtp-Source: AGHT+IFnI1l9XwT1ZvBLQOIlT5uXSniB7GOrgNmzGE2z+XTz39WZu8FlxPvNO7AijOn9ZpJCHUmshg==
X-Received: by 2002:a4a:5b43:0:b0:5c2:2a09:86fc with SMTP id 006d021491bc7-5c43905bd7fmr13341957eaf.5.1720024186912;
        Wed, 03 Jul 2024 09:29:46 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:f98c:6a49:dd6f:a36d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c414833f9dsm1542775eaf.15.2024.07.03.09.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:29:46 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:29:43 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Datta Shubhrajyoti <shubhrajyoti@ti.com>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] staging: iio: frequency: ad9834: Validate frequency
 parameter value
Message-ID: <59cc60a1-f6d6-4f9f-bc36-6b06315eaee4@suswa.mountain>
References: <20240703104734.12034-1-amishin@t-argos.ru>
 <20240703154506.25584-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703154506.25584-1-amishin@t-argos.ru>

On Wed, Jul 03, 2024 at 06:45:06PM +0300, Aleksandr Mishin wrote:
> In ad9834_write_frequency() clk_get_rate() can return 0. In such case
> ad9834_calc_freqreg() call will lead to division by zero. Checking
> 'if (fout > (clk_freq / 2))' doesn't protect in case of 'fout' is 0.
> ad9834_write_frequency() is called from ad9834_write(), where fout is
> taken from text buffer, which can contain any value.
> 
> Modify parameters checking.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v1->v2: Check if clk_freq == 0 directly instead of fout == 0
>  as suggested by Dan


Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


