Return-Path: <linux-iio+bounces-21781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D30EB0B1A7
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 21:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DD61707AA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 19:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548EF1E520B;
	Sat, 19 Jul 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Toiuy2fH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C409E84A2B
	for <linux-iio@vger.kernel.org>; Sat, 19 Jul 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752954329; cv=none; b=a1e6K9QbmSTFw88l/LoBwUqs+yTP0DfIL84sUzutgdyiDLHLFXH91WJvftt7s83U5HG6Q+aGAcFYvGAhzYeb43t3Qjn4BjofYwNg4XlkZR7ufM8pELtnQ0hqV2p5THiOlraEebYJu5fUQCGY1etJfD+pt2CdwylbnBuEd9yVDZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752954329; c=relaxed/simple;
	bh=AN2b6BQuocjE9x5tw1wI8h+nxEosHescELJRFiMmvNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ulxvrqfg8c+fAyok5qZFdY9u+nyvLxRzWg/DINa6pjyP/1bNVsvrFqzapGeVm1EwktgLkiXpJXQkGgOHjN9tqfR+2Aay+CxzMz/OESaD+Qu64ByJMKVaDgbH9ZSK3LpQiClJ5LPFymF+prCEWzcuzB/0oOgtgRls1HH15nm/sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Toiuy2fH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23c703c471dso44477355ad.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Jul 2025 12:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752954327; x=1753559127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0OHn8KQ12Gdebl0tLkn/OQhtqK2uHFAQyh5Xl6vrBQ=;
        b=Toiuy2fH9vpYpNq+R/VqufmMzQWKvDhH2SwXUe049SivpXyfV0k+ywImclneJ6Z9CH
         QK4C68YhhwgIszoMciqtfrWre7m5AIw8AbehAx5WjDlkzRd1WW/E2bKmwYQVsjQRCNha
         Ad7JKSgkuVdkW3x8fUElrlGUghnN/i1DR7s26RsZZEJQ+yfTnAoGsPmZkhhhVJooix4K
         TslOes6w7h8OoVHxAqKgw3ru0qZUHCZVhLMmztWmzBvpgVPFXNJFoNq8tyCk28S0ApxZ
         lYKBn7aLvmXuMsiHUsKpyuKvIFMmKZSyhEzoq012UYB4dJHMpx+dMwfBsCREXPB77mlG
         1s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752954327; x=1753559127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0OHn8KQ12Gdebl0tLkn/OQhtqK2uHFAQyh5Xl6vrBQ=;
        b=GIyKq3ZilQ5HFzDNJCCBJi3osv5gVALVnMT3n35+e7cg1BKVZBl43tStr5YqNsrmaq
         Ykbarb/JXK2SMHVDz3F5J6Pa2u1N9B7b1gkuaDwXXRrY8Ti3h6vWHX8zz05Qb9Au2gjH
         3O34C7Yl8NisUCL0xMQRbxurHZaHi2hePUlmb1zwxiD05kG3nzNRisuReXIOFnNHEIG/
         EZsp5DheTk/MxQ/lf2pDP+YDrhkb7s9sjs+Csrt6B1v4v/ZEH929rPg327Ms7kAoMk4e
         5CNsGgU9n24DP8jjIGbgM5ZZO+1UXzby30z1Nc+SleMgPrKO5P+GuxBfekM07KUw0xab
         qvtw==
X-Forwarded-Encrypted: i=1; AJvYcCVJPsPc0dlSnfJDhefvvZeOcX7VwEK2PPrZQzEHH2XL5kU77WVSQrtz0nbfkhSykCeQKBNA+RQ/6M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8AyNVCDQpBG+ulSI5XL73ORnZU+X+o5Y6X6bWtUZHAf7yBXW
	orI7NrUTV44fZaZkgtAh+0GVlOXJyvZ2cz0TlfkSEj21CfrkFRT0gGc5
X-Gm-Gg: ASbGncutesXLw5UvRmDxlgWqEADpQ+RY0+TApA2LjLn8Nm2lpw1u/IMqfO+eNWB+RYc
	2cW8ot3ukUXAnx5m9K/IU9I7YqE8dJ5x/OE1EHNZqgRk5THRSDaCdPLmVq3PnRhLI7JSefY4oY7
	9jU1XD5ppE+ej1FtQ4n2dC835fQ44XlUy7qUt1+H73p1GbUGfP59RcQDgegWCSjEQpjK+tOHlOd
	KLXR8xqN+9AP3sQ0QcIoQ4tAXlxSTm5JgZBV5rlKJjE5imrIJE/PyNDJSanmVR4vEsJa8IkNFKE
	S9X3SJPawJQeNAkawJF4u/s4KTGi1jPp5VrFXrQUTzbqQXXALnd8Uo3D/Dz8TEocXVRTT+okaCv
	Nfe0p/ccEW3a27QdAiMEjAyEKVLblgdempUUyRgou
X-Google-Smtp-Source: AGHT+IHLHhwEi7GS5AyGp5sLChIyGx7+N+QSJpXjaLBcTTckMIYgHbzMDo7NngTcK8FE6bJNhSI+/A==
X-Received: by 2002:a17:903:4505:b0:231:9817:6ec1 with SMTP id d9443c01a7336-23e2f72dcd2mr152665355ad.17.1752954326869;
        Sat, 19 Jul 2025 12:45:26 -0700 (PDT)
Received: from localhost ([2804:30c:b15:b200:425a:de22:1d7f:2d4b])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6ef4b8sm32487745ad.194.2025.07.19.12.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 12:45:25 -0700 (PDT)
Date: Sat, 19 Jul 2025 16:47:37 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: adc: ad4170-4: Add digital filter and sample
 frequency config support
Message-ID: <aHv2WbZ5DhdCui4g@debian-BULLSEYE-live-builder-AMD64>
References: <c6e54942-5b42-484b-be53-9d4606fd25c4@sabinyo.mountain>
 <20250719131556.1ecbdf5a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719131556.1ecbdf5a@jic23-huawei>

Hi Dan,

Thanks for the bug report. The filter_fs update was indeed buggy.
I've prepared a patch to fix that.

On 07/19, Jonathan Cameron wrote:
> On Tue, 15 Jul 2025 18:00:03 -0500
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > Hello Marcelo Schmitt,
> > 
> > Commit 6b648c49d491 ("iio: adc: ad4170-4: Add digital filter and
> > sample frequency config support") from Jul 7, 2025 (linux-next),
> > leads to the following (unpublished) Smatch static checker warning:
> > 
...
> >     881 
> >     882                 if (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
> >                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > So "val" can either be 0 or 2.
> > 
> > --> 883                         setup->filter_fs = clamp(val, AD4170_SINC3_MIN_FS,  
> >                                                               ^^^^^^^^^^^^^^^^^^^
> >     884                                                  AD4170_SINC3_MAX_FS);
> >                                                          ^^^^^^^^^^^^^^^^^^^
> > and we clamp it to 4-65532.  Since filter_fs is always 4 in the end, why
> > not just say "setup->filter_fs = AD4170_SINC3_MIN_FS;"?
> 
> Code is weird.  My 'guess' from comments is intent is actually trying to tweak
> setup->filter_fs in event of the previous value now being impossible for the new
> filter type.
> 
> 				setup->filter_fs = clamp(setup->filter_fs, AD4170_SINC_MIN_FS,
> 							 AD4170_SINC3_MAX_FS)
> 
> etc.
> 
> Marcelo?

Hi Jonathan,

That's correct, the idea there is just to update filter_fs to a value that's
actually supported by the newly selected filter type. Thanks for your suggestion.
Hope I may come up with fixes earlier on next bug reports.

Best regards,
Marcelo 

