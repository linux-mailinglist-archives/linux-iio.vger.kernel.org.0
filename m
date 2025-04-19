Return-Path: <linux-iio+bounces-18350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307A7A94581
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 23:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444BC1789C4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 21:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F6C1E5710;
	Sat, 19 Apr 2025 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVpF5eMB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9201B0F20;
	Sat, 19 Apr 2025 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745099114; cv=none; b=NloY9ctX7Gh9XPluC74emHvvYbhCxlmPjZmu/3dQlwBc3uyJpFKOMQC9I76XKEycrzAIlxa5zu1eH/Qm3BezqUglrfEC+8q2BzwCRKSiJGEAB/6Cnom+xqFG1f+kBlXIGjX4lf02g+7KvD/XUNaQcbWa2jJRxsI+A3T+J8LoMGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745099114; c=relaxed/simple;
	bh=INlnN5WJZfb9/Dkj+fX69QLzu8VLQMwo3bg9bkWj6ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou3IQp6uyoe03W+uVM96tGgnQNuSTnwkHZebVf29moNq1ze9CUik4n2Hn6BfAQ+eNY5/bE9Z3YdU9IKXVDUar5qTTiJXYR5UcKG+w2wPiyfBNmUpKAuibjyytX+RcVNP5yJCUi5J2wkXMoFbiRdtbY6lwgiypZDxJjaAQqHFxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVpF5eMB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22409077c06so40084815ad.1;
        Sat, 19 Apr 2025 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745099112; x=1745703912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6dedMB2aZL7JuxKdXCBVhen/b9c/wwkdTjJKn9OdME=;
        b=YVpF5eMBmafko/HehqkqQSwGbZ756rnF2me5Hw3jVp5B9g3S29w656OkQlH6zh7KjT
         7gVRwGDFXgNUH4FHswoAy840dsqCblJWJF3q8u0/I6Bl8W0kMqdqRnCi1rD72umuyZaq
         48ApuuqkLwWmlmwuBFz3anF+JjOh+8kWjjh54ug0qSUw5tzReV3Wf4zEuCgMtWgD+xQC
         AsyG4s6t0DEJ8Wwe9a6Cv47QobVaG1bRFEhxcjT94uhqjUiPiZFfIAyNkXp5su7onuwV
         /OUIy7kgyxThCrxzUZcZQxtN91ZPLE/hmphXemoEnLia2bYtb4wPENEn76i7AqzBdinF
         3WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745099112; x=1745703912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6dedMB2aZL7JuxKdXCBVhen/b9c/wwkdTjJKn9OdME=;
        b=DHhedLRh823zO1Kbw/Ql/6wqO0DI3+QT+mF3T2rp8VrvxbBjwGOA8tcoGjvg56rSZ3
         6VnfeCTYUOIfAR6PFdth5FDa5uY5GJFmxCv5mbcW5fwW9ga535buQVJrpBFSctkowuCN
         WQB3Fc3xR1GhAvIS1YwrF0t4NR3rAxL86Jr+L9gq0Fkld7u8QdwxO+CCHtuh8Yg+7iXs
         TJwH4GQ52bW1zqoLZ1jmFETwW73AxEmMqKcUgpSSfF/rbrT+DTZ5W2WeScSgvRRxR8MI
         GDYHh603hxGNrLEOZzyOIrhuVtZ8u2dIhOPGAa9TU1gI5Y5n/LfYvDouLqMkqMVKdrz4
         UxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAa/nTvXkIPcZ4sCuGl2NQn2KEO/nrMKm3GgiKYefrP3Lxix0XtSU/gasTWxgowR1vCp+zsRKJmPk=@vger.kernel.org, AJvYcCW25lzMaA6RUjKS08ozvTd083Scl7NltGrBHlLcRn/zA3mTE0293OGyKyohmf2efcN66GovEvVM@vger.kernel.org, AJvYcCWAAKrXT908+U2ZA5/su247+s+oc4yCbLX4rYX+doNdVkrzA3YlNR1ssgtsGJrdKAnoB5L4Ekb/xOR84r9Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzoWagaKQP0TMMG90URyZKK2wBIL4V9PW6LQMwUgYWrT6y/zlbC
	VNYK0arNUqD/Xaf7+97M6SbE2mDLMsIPKxd6zJ6DSYDm/N9oBqRw
X-Gm-Gg: ASbGncsy+rpxqMwz2JZ2iy1HMpG5WoFdaiUtZCzCJUsygzQy17euuPnCQSv8WU7RP+p
	2R5epB6ZWw6PTixfl0y5t+Ho07QqcReOiM3KjUjM1VI8/dtkNJA2ZdvqrDq8O+qs7kCYmVEDeC2
	/Dw7s4V+Xh79lyf0/rJdix2OEgHPPoANinz4nWtUY8Zrdkr3VkBPxcBN5owVURsdRjwg/YrxK2D
	5Hc8n3Vr4hTV8IbR2wx8LMl3W01iuHRojxY705KWEbKBuM5k2G4O5sxS+noG1sJQ6aFDT7UoL3n
	QipWgJb+0VM8prO8MBv+XqZIM/XNJfqBbCI07fhVDDcw/sQ=
X-Google-Smtp-Source: AGHT+IHRl6n/PcvFmVqTKcKkKTKXFlF0vBC9rAGLMcXBhHukm2ZXzJDlZ8iPMEeKDYk4scJUsge3Ew==
X-Received: by 2002:a17:902:f78f:b0:227:ac2a:2472 with SMTP id d9443c01a7336-22c535acabcmr115757225ad.28.1745099112451;
        Sat, 19 Apr 2025 14:45:12 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50fe0679sm38044845ad.249.2025.04.19.14.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 14:45:11 -0700 (PDT)
Date: Sat, 19 Apr 2025 18:46:22 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: Use SLEEP bit instead of RESET to
 disable output
Message-ID: <aAQZrhBLQCa0TjOJ@debian-BULLSEYE-live-builder-AMD64>
References: <20250417135434.568007-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417135434.568007-1-gshahrouzi@gmail.com>

On 04/17, Gabriel Shahrouzi wrote:
> According to the AD9832 datasheet (Table 10, D12 description), setting
> the RESET bit forces the phase accumulator to zero, which corresponds to
> a full-scale DC output, rather than disabling the output signal.
> 
> The correct way to disable the output and enter a low-power state is to
> set the AD9832_SLEEP bit (Table 10, D13 description), which powers down
> the internal DAC current sources and disables internal clocks.
> 
> Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
Looks okay.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Unrelated to this patch but, if anybody be looking to work on getting this out
of staging, I think maybe this driver could use out_altvoltage_powerdown ABI
instead of this custom out_altvoltageX_out_enable.
Crazy thing this driver doesn't declare a single IIO channel.
Seems to be somewhat ancient IIO driver.

Regards,
Marcelo

