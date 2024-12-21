Return-Path: <linux-iio+bounces-13737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398069FA06C
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 12:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A020F168AE9
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 11:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D651F2384;
	Sat, 21 Dec 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MazHfRXc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA71EC01C
	for <linux-iio@vger.kernel.org>; Sat, 21 Dec 2024 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779858; cv=none; b=ma2aEkCMdXk+tWioSBiKo7VP4U5svI8hto95nvoTyRhAUPke5/QCJfTxyben4TB6fvsz8TQ3Vkdd8KOFSpaxKwX2lhiHKnionB/ivomLMk6pFT2hpdp86NLMmGDZqNWwS8GwuilD+veWa4yL99KMkNajBnhTPAJZD/85892+4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779858; c=relaxed/simple;
	bh=djRn6+jhm3QPilq2RV5F0tnhXYpRAyBEP8d92QcEX0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2w8MaaNitVpfc6a/oAaRyFk9vyKkku58+AlAR+elkVGcX1o8/fpcnGrCNLRRENSpb0CibLW3u662ANv63dMS9jIgX2r8Adyvuhig9Qe07lpPJQn46LyOfnjn8cy8+y4dGo9j6AI3MxeevwU49DZEz9jiLWh4XG3IIe1PCmoWqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MazHfRXc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso1834736a91.0
        for <linux-iio@vger.kernel.org>; Sat, 21 Dec 2024 03:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734779856; x=1735384656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FIuCyo9J10+5hIwwKULHisV5edzEIPoCg5cLPqUf2WM=;
        b=MazHfRXcxGiRH4HLGSF6qzCTK4IkIewHXNyV+gFBPtRzXU2RXHtu9Ao0OZXn5QwOYr
         Ktjtowc0mIIFtnQUoUXuhtj9biZMwDw0srxl4ulqFweffMClALC1sbE2wmUZx9RrAJpG
         uZzhdzuwRODmiWT8tZU2kaBsKbl5iwgBf37e3m2AGHEYlT7HwSt9fIJXDUQbeYVRfogC
         an2XoYbWyw0WWVgcGDvjEg+za2hf09YAPeU3B+NUzC17mMOLHjAE+bwHUvmhpMgm7KBV
         bFY/LA/CrFPmDa0LRlkQsAyu59b9xr6Kj8EQX4Q33H0JKcP01JvDcNX6RktCYWhVWutJ
         5ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734779856; x=1735384656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIuCyo9J10+5hIwwKULHisV5edzEIPoCg5cLPqUf2WM=;
        b=PYKgp2591j1amRvxab6JDQltnW5949Pt9Qg9Ivqslv8O99TL8KYCeaU6/BnFLngFh7
         cagETUiXN62X8IMqhCEjM7wIgPfuHVTaIjFUDsPticJnHoFhZFjDCJ3gLb1PfbwBTwfB
         a1JW+O4OZcCOm2LtTEKBYtvO9zSZBD5RcSqptcukLcNYsZHm2RbYO5MUNa9a4N00fIwM
         jy57JusmobbjN+Lgfw7v1TrMaVsWBxnYsYmkH39OppYBLYfgKQ0SLvpqrcv7k8ewxL3z
         vbdRM64cIbXK2NHu9VJd3M3cp0YmaMjupW6uITkGE+jzVLts2iI27/8cZ0S4LcNiXqWu
         t0Yw==
X-Gm-Message-State: AOJu0Yx4hsexwhGUZ3FTM9bM0BcSdLt4FiC4xil1QNZDMXWkkeHiSau5
	v+tpIS2icIkvp8ZqeDgqnIYqQKDbF7r/WWWHK4rTinv1Pef1uDwftBmV4Q==
X-Gm-Gg: ASbGncte9YQ3dtJMEZ64RgiHTPW179Rp3uxk3BffYG3btBnqedohOvCaWV9NOcxsxx1
	OICwzUciOr2D8UzKFSAPjmWw3WydCIvgyU3bo/uw8+ksk30BKbkUv4yPRlyf85+Tj3FxXmDEbA/
	kNOwt+ywHZPF4tTzD/DohxQRNnm+7+BTYeVaj71Cbm1YfEUlkdaZXrXB5lICSIrT6D8ZzYkq/4z
	jB53ctETaxqJxUEt3/IjA3qnNxUGJQNaDCthFXUZ9UC34EeUCvVp1vKMlnme8mTmQ==
X-Google-Smtp-Source: AGHT+IE9Vbd+1YfkxMAjKccI89jCDiW67jLsIeQUIfRUCX5cKxnrqiXIJr2fPH6X0LOvshdpFgQE1w==
X-Received: by 2002:a17:90a:e706:b0:2ee:cd83:8fd3 with SMTP id 98e67ed59e1d1-2f452ee931amr9653468a91.33.1734779856170;
        Sat, 21 Dec 2024 03:17:36 -0800 (PST)
Received: from localhost ([2804:30c:4057:c200:dfe2:5075:a83a:1a44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964e60sm42741195ad.16.2024.12.21.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 03:17:34 -0800 (PST)
Date: Sat, 21 Dec 2024 08:18:08 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 13/20] iio: adc: Use aligned_s64 instead of open coding
 alignment.
Message-ID: <Z2aj8BgtmUyKGLl5@debian-BULLSEYE-live-builder-AMD64>
References: <20241215182912.481706-1-jic23@kernel.org>
 <20241215182912.481706-14-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215182912.481706-14-jic23@kernel.org>

On 12/15, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use this new type to both slightly simplify the code and avoid
> confusing static analysis tools. Mostly this series is about consistency
> to avoid this code pattern getting copied into more drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Thanks

Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

