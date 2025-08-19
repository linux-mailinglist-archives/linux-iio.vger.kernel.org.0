Return-Path: <linux-iio+bounces-22995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D069B2C7F4
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6347E1C250FE
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544C225D21A;
	Tue, 19 Aug 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvpOL58W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E7B2253FC
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615729; cv=none; b=GlLfqRKojJbODuoe2hpvQnfR0n3aVrbbdZewz+1fFqY9USfuk0KQCOIwdSSUHQxpODUxFNS694yfwEO9y3uxr1rqdMfssi6IE2WDs/SkIC1/rQpTD7pZM8imLBxbAwceGDY//nPI7sCRWUkTF6M6Sk2Rz1u/QSAcnkR/on38i98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615729; c=relaxed/simple;
	bh=wgptnB2H9qnTUUT6jPDhuUrrnXCFncKWtJShnB5mGLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9EczOYqVJ0vZpZGyj2FbzQh1GHNZIqtXJN+RmENEDC2xwtlNIa/sM5n1GW/83siWJlpJuOQ5fWypg4FUYdjYYKlGyldcjOIdp3gVxhFlT/M4jSxKphNkKr4uqS8ZyHmuRHoL4V9Da/cEYJ+Idw3qqwLalvP6tS/RFDjJoV4SaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pvpOL58W; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so3632659f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755615725; x=1756220525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT1w+5e0mD/OXT08jYsZeNEMDZKcQ/cmvsGpsw6JbVE=;
        b=pvpOL58W5jyjhruSBvaShxDnGH8GtmPvGyBUs5b4HjH7QVW+9QtlFmAuO3pkKPPRtb
         DMB8rTDdxPuI9VmoAFB1Id43ur6cge27aR7koNCvpx5Z7oNUTIgZYWvu04z7VVuof8Vs
         B8qRPS0gxxnXRDofPCsvvJTqwdlkLsb1yjGdoYM0ffzGoO2VSJCLExPrW1AzQ9AP24N/
         mrIYEvWA0DMb4qfw0KiD3S7UwnKg7XyYsLKu+v5NGu6FilTdyaD8m7ikqEX5RX0M0pOM
         g4trL/V/XmWU3hrTp6i8wlVGDj4+zlL+FbHL0RrMozycPfCBkmHKpuMz11v0TYgk/HeG
         CW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615725; x=1756220525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nT1w+5e0mD/OXT08jYsZeNEMDZKcQ/cmvsGpsw6JbVE=;
        b=XDEa/6U25coVFbt28JXfakPJh8/UWuMpST8ULe0h1dLjRot4c7nK3Pke86w9CBxlqS
         Pr2Arl9LjY4QWNUlsH5nqD0xiGuDq7YkPS2dnbdKwl3mEx246N6/2+ILdceEFkzkRz/d
         ArIYUScvWReQjkZB1ywjt1lcXv1XKeTNv8Xi184CQNvypj+Dm8hncWi63SzSqCqoIHAQ
         FB1a/jpH9w4NGKiJi8BlAlRtCfj+GTUMfLJatNGpSna1UnmL7Nmfms+Bj4ScE0b2K2EL
         +rInfoPjJevtVFPGtQZJY1NSWQn4ftsW4N2ssBfZLRUF6HKVaTR3HxLjV7m0ojeJf6pH
         kLbw==
X-Forwarded-Encrypted: i=1; AJvYcCU/eIv9KISdCvOgKIz3xaBIjTMCQkiM6949FYJDRSlJIsE5rdBEsXnvYPNOI8kevw/ISD5OgaJ5Qn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVUkxJnIemZ8pU93yRZNyGhy0PWxLOUgv37hpsqrKCsQZkhMA
	UfARjTl+jZqawPl70VHrxFYiQucme/ojsgHsb1YKOvfpXw37gb+rnNjrB+O3P6X2hxE=
X-Gm-Gg: ASbGncuiMdO4mlv0IzfFPHf4A+bkTwMEvRUmgVzcaCDc8cO1x4RuIXw6wqUZlULVdTE
	upQyKr1tvvgjLldXElR/lHoeU0I+P9IlQKSDlL8zYYIftfkUPoLSQBscJsLHwTVbIu4pLmRWCqr
	bdFTrI2kDqS+BhG5XEReTNtiPBN8k/mmNtYLbDOJssizpK9ftWl6XKoXRdDZ9861a2vn+Ql3qsq
	ENehsfbLFnKzyiY2yfs7XJuNnd6RtdV5r+E3Xh1F2LQO4GGcCN3nyrJA0NRgq2tX0PRFDAM5ov+
	JkMCeIDAbnjslxjxRXx5lw8En34bR/QtqkxLp9ims4sa7M4B4Jp3AAq5IFk7L2kLlK6tCedrc4x
	foY31J5BybCQjlvq9ZDdNclOefal8G4WwrqN85z0GAEs=
X-Google-Smtp-Source: AGHT+IG9xBgfwY4xXs1ZR1sBwj23DK6i912COuTKguLY6aIpRkqXOcV+ILsGwy15iv1BwlYbHystyg==
X-Received: by 2002:a5d:64ed:0:b0:3b7:84fc:ef4c with SMTP id ffacd0b85a97d-3c0e00a27c2mr2292475f8f.6.1755615724584;
        Tue, 19 Aug 2025 08:02:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077789106sm4085293f8f.51.2025.08.19.08.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:02:04 -0700 (PDT)
Date: Tue, 19 Aug 2025 18:02:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Waqar Hameed <waqar.hameed@axis.com>,
	Song Qiang <songqiang1304521@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] io: proximity: vl53l0x-i2c: Fix error code in
 probe()
Message-ID: <aKSR6MMr9aKWw9ff@stanley.mountain>
References: <aKRGXFJxf2bdQE-Q@stanley.mountain>
 <CAHp75VeTL7mJ-Ttgpkjd5A04DgHqkkPY90LtJriQjoaUZ0TbhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeTL7mJ-Ttgpkjd5A04DgHqkkPY90LtJriQjoaUZ0TbhQ@mail.gmail.com>

On Tue, Aug 19, 2025 at 01:18:35PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 19, 2025 at 12:39 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Commit 65e8202f0322 ("iio: Remove error prints for
> > devm_add_action_or_reset()") accidentally introduce a bug where we
> 
> introduced
> 
> > returned "ret" but the error code was stored in "error" if
> > devm_add_action_or_reset() failed.  Using two variables to store error
> > codes is unnecessary and confusing.  Delete the "error" variable and use
> > "ret" everywhere instead.
> 
> Agree, this is a good catch!
> But please, fix the Subject to start with "iio:".
> 
> With the above comments being addressed
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Yeah.  :(  Thanks.  Will do.

regards,
dan carpenter


