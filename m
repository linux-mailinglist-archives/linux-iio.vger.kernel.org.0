Return-Path: <linux-iio+bounces-17003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB48A66886
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 05:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A9C3B0AD2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 04:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED5B1B85D1;
	Tue, 18 Mar 2025 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hohUh51p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD41B3937;
	Tue, 18 Mar 2025 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272934; cv=none; b=n4CiZh4kIa5IYBqwXuzLbSCJ5Yfzssc3/ZLBcbNLkDyqMKkuKHKBWLYG7nOMBbaNa1Owgx9bxFp3y2R64vyi9BQW6yUnVrbeiXIUO1xWv7uuqsFFR4jOvWhOPUcldcsDRYhw9UyApeWmzPPElyihfCcvQDvA0OoJyZi3E80zEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272934; c=relaxed/simple;
	bh=iQeGbfmACJygU63Z8hCYAaLR8JTprex+qf/AS3eC/XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2JG+Im3PCzeItoPdhtg1AXNVdWs5QCe+K2KQWS4tMEnmC011rtKCGMRgUArLjkriObQbi4cdlDzJAtnuwlM13Qli+wc7N19MVN9gTKzgbI90oK8Gou0oHnhnTHkFZ5MVQdalFGRZdHSepTKL+e/V05LuTmW3lqOlWh8Yd8iXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hohUh51p; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso421659a91.1;
        Mon, 17 Mar 2025 21:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742272932; x=1742877732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sAkJtd4zJibaWCNnF3jCBBXYULTrH5ymd8dXqKbHixc=;
        b=hohUh51ptPA8ikzRen9fIUtUbOh7oAW10tr+K7RjJ59jqnQ7UtB0nxPnT64DDybAOU
         w6nt22VbwYC0qFdm/F8KaXCZxYnjUZj8ROUNuSGboooCgc7Ju/nnpMdcdI/gjr1byH7F
         p0thWzrybIQCpHvGlOt12cZUciuqgfQsgUKqyD7YNZ8QuTtkGODipzttztF4jK+0x7Dt
         G67SNOqp7hulFvIJiOWBNHm8168T9DP1VyIJ4F3blWpHIR5MfsBLkY8qlohMnzoS4zUs
         9MSIzl7CLEYb0M2my6Kpsbbsc2Qds8iyzb8m22ADCTh1SvP86cW3ur6mGcUzZvwnxdcm
         WFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742272932; x=1742877732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAkJtd4zJibaWCNnF3jCBBXYULTrH5ymd8dXqKbHixc=;
        b=ty12AGGfy6Lsyo7lCBuppdXo+mgRk7k5VibZ2DqNYq7bC+t3go+MU+KvBQwgDb0gzp
         kqHLa1oU1oGX0IqbI4DDg81stzUl/6FFkL35kZ7hxFaBBank0JZjsY/tQjaJQM44jXTN
         mvFUo5guBScaZZCpsT/VTd5D4mkEsVbxiZFWS1kq6WwOdmFBdEyWWJt95VKwq5NWOBKw
         B2//MOg7cok597ckikxu4T8/fLAjNBe96mpdOM7xmb0yvpopLpIqb+DNVUMe1m4irtdR
         e711xZFc1C5BPv69RTsj+mXHMxv86ChshGFs0Sou2eMqN2R+K3E8Tqsp4E37uzqy0K/W
         VE7w==
X-Forwarded-Encrypted: i=1; AJvYcCXxn3pIXHCTuOLvT7nuElRM6/cMizi0zNsvfn6jagEZ32YnjcwPGwKORH78gNMDvKx7MveSvYvdQ+h5/bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEqD5NDkLppQBy6L1fMnKUg5EWKl7oHAySPzCLGuADBLOCmyw
	kPHKacfkDfq6N/51G2BxXfyTLR7l9iStPwvhOIkF0WP26VeYORur
X-Gm-Gg: ASbGnctKQqc+Avq6LHgrQlK3YB3sNeAWygiuM3Apaa4GlQFP7Lki2Corm3QCjy9gxRe
	Wjb4BZ8iOPOHUEyVn9egfKRSiKClk7KFKz3hQk6GdA5ELZempVH+qtZJwVcjFSMOxyA3mi3SL8e
	h2ijIRfkP3jiAFy8abG6t2GPgDgzelnkUlt9io8XDMfoMXGucIs4mOTsO5NbX4RewTaSQjOkjmd
	Ytd8x0K1RVkh3lzft3SgrzHEys1qFwp+jT/YDrQDbA+Q9tVYPjHs3mHSdnzUBvB3woNR0HKdXDY
	rpq98j3cNfo2FhebJQAl1kgFVQnzwyyoYy4elQ8NtWNxkojl3KNc
X-Google-Smtp-Source: AGHT+IHG0lDZteyiS6GX2wkjRHSUTe5QCL1t9du2A1xR4Hh+C+W5xwrolvvu2OvrsG/ELvUYNeMnEg==
X-Received: by 2002:a17:90b:1b12:b0:2ff:6608:78e2 with SMTP id 98e67ed59e1d1-301a5b1c837mr1342298a91.16.1742272931801;
        Mon, 17 Mar 2025 21:42:11 -0700 (PDT)
Received: from localhost ([2804:30c:b31:2d00:277c:5cbe:7f44:752b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3015353462asm7054423a91.27.2025.03.17.21.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 21:42:10 -0700 (PDT)
Date: Tue, 18 Mar 2025 01:43:06 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <Z9j52jGqft2jvT2O@debian-BULLSEYE-live-builder-AMD64>
References: <20250317173355.157536-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317173355.157536-1-simeddon@gmail.com>

Hi Siddharth,

On 03/17, Siddharth Menon wrote:
> Refactor code to use the FIELD_PREP macro for setting bit fields
> instead of manual bit manipulation.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
...
> +#define CMD_MASK_2   GENMASK(15, 12)
> +#define ADD_MASK_2   GENMASK(11, 8)
> +#define DATA_MASK_2  GENMASK(7, 0)

DATA_MASK_2? Did we already have a data mask?
What about adding the device prefix to the mask name (e.g. AD9832_CMD_MASK)?
Also, this patch fails to compile. Please, apply your patches and build the
kernel before sending the patches to the mailing list. Also, run checkpatch on them.
E.g. 
./scripts/checkpatch.pl --terse --codespell --color=always -strict my_patch.patch

>  
>  /**
>   * struct ad9832_state - driver instance specific data
> @@ -131,6 +134,7 @@ static int ad9832_write_frequency(struct ad9832_state *st,
>  {
>  	unsigned long clk_freq;
>  	unsigned long regval;
> +	u8 regval_bytes[4];
>  
>  	clk_freq = clk_get_rate(st->mclk);
>  
> @@ -138,19 +142,14 @@ static int ad9832_write_frequency(struct ad9832_state *st,
>  		return -EINVAL;
>  
>  	regval = ad9832_calc_freqreg(clk_freq, fout);
> +	put_unaligned_be32(regval, regval_bytes);
>  
> -	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
> -					(addr << ADD_SHIFT) |
> -					((regval >> 24) & 0xFF));
> -	st->freq_data[1] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
> -					((addr - 1) << ADD_SHIFT) |
> -					((regval >> 16) & 0xFF));
> -	st->freq_data[2] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
> -					((addr - 2) << ADD_SHIFT) |
> -					((regval >> 8) & 0xFF));
> -	st->freq_data[3] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
> -					((addr - 3) << ADD_SHIFT) |
> -					((regval >> 0) & 0xFF));
> +	for (int i = 0; i < 4; i++) {
> +		st->freq_data[i] = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK,
> +				(i % 2 == 0) ? AD9832_CMD_FRE8BITSW : AD9832_CMD_FRE16BITSW) |
Hmm, I mentioned using ternary operator and gave an example usage but wasn't
expecting that particular example to really be used. IMHO, the above doesn't
look very good.
Can you try come up with something that, (1) avoids the bit shifting we had
before, (2) uses sound macro/mask/variable naming, and (3) fits into 80 columns?
Might not be an easy task so probably not worth sending much more time on this
if unable to find a good refactoring for the above.

Regards,
Marcelo

