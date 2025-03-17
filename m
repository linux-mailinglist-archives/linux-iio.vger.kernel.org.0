Return-Path: <linux-iio+bounces-16988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C72A65A95
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 18:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D41218835A7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468061953BB;
	Mon, 17 Mar 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmLG4a0J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB71553A3;
	Mon, 17 Mar 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232019; cv=none; b=JFTYu7hDPxJEor1h8jhu0feHAk0qDhNgdgfFJbThb2+hdEEUBI6oYSlasqSWpg1UE4acettrV1/wZx2W5QfRRtfPyiG1o1XrhbxKc6jCZ2oJb9kGbeFDq/vcehz4gcvSrfbWL8aaaFaPO2s+flMY/mTMYeSNf0OFpTtBRwczjHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232019; c=relaxed/simple;
	bh=r8Jjyg4N4bX0jkWi1/kQS+nKK6mUoA5S9Z59aKSMcw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqFQDEaH2EE9oNhmxNWnga5MAh5V+rmEH3SWbsyZ6Ssg1VuARatmgKzUp/t2G96wQooidgbnWlRZxbs2OkOSudjCv/cI/4QGACOLcShsbF+hPYiOmf84fwRYSNVaQbFvX2WcRlqR/w6mjTD3EX+Zw6Da1CIK75DaoUZjAtHZQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmLG4a0J; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso3889692a91.1;
        Mon, 17 Mar 2025 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742232017; x=1742836817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiIzpFKizdM9xv+6JVtSJnmseZQ1sm302MUd2poCzvo=;
        b=YmLG4a0JiNua1vfIdxPPzi0VsUW/trevjvQ/i5XQmj1jvFWz5BDuRMfoIZrdfLQAz0
         LiXifUKo4xMMIHxe4akhFG+rGFFeEhdFgpmXhoEJa3+4YRuZCMARnLcW1WM+rAWNv5br
         EEsW1XUFZdaoL54FsEBZasj79gA5JR31F9YZI2CK2JWD2uZS8qiHnC3Bv+YwPeqn3RjR
         ig5/XK+v203dDqm06s+CvCK0gUyTfYGH6JT7QZXOTCv8fSCV2rCcRzI0/EnJCi1Is7BO
         bknMeF9hC8W+Zhds5ujf5UXfpSWAMOS1G2ODxulQVZqFWtrLQQTAWRw5V70k0fZ+r8YC
         tATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232017; x=1742836817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiIzpFKizdM9xv+6JVtSJnmseZQ1sm302MUd2poCzvo=;
        b=DP/ew8gpz8wiINJYMGOwrOdgU+e9/bSzB293W1zS7i2xAWGjPZcQvUvxV824wAK3BO
         DGpXxV8vMHSEBtf3rjskSRDJd3j2keRTEd4Ao+hvfcbFcr3lWmnd2wXU1+hcB3ltrKhB
         t4QG/bDSuzaog64R4I5jh7ynXkZvfLInZ4srn1kzCMLDuffN4kDBpZ24ijpi2gLnX//T
         BHKfzn+k/p3w5C+udt8bcPpN9sVzglO0QqLpZgNPNb3l/7X29ntYvhA7+wZH5Z49+kyQ
         RPWC2ZFxlWQdDU3aPWFRWWW5ViPGDhZFaRYOCArsNv9ujDZQLSw/iyNi4TOyy4ne/XVl
         2unw==
X-Forwarded-Encrypted: i=1; AJvYcCU5mIkcZJTZIGvHAo1hew0Um66zK/Il55GdPF81ZE5OwIjJNP1N1mTnXvPVHOohA5cOOARI310kzw9dX0QH@vger.kernel.org, AJvYcCUtYTRpmluTKTm8KiMuEiBiNgzSyq22srfP1ZF3T+9dJVtpXVNqJ5buOJOOxujOX7UMLBEJ0cmdsu6C@vger.kernel.org, AJvYcCUyDrMuzL/0s67acANV5+m8vvbV1l0m1GJ7CwetQ4+Gxk6sDTUze4sVAOF1ucYC+nmw0yrTbe7sT58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3XwMFO+S5G8PmXgO1j/KTX6ASSlYPwbA1qabConr/Sm0K0coY
	+5ONPIHqxnpbXjhH01waKttiwZXlcLxz0aQYNowIUmNv1OGzdYE8z7pch+6/ejc=
X-Gm-Gg: ASbGnctP/lQ4EMk0l2lf0hkAm3V+q2+4lIVBbocmMF+u3ZZcaTT7q3VlRKdS95uPCa8
	6BIKFIemPU8RMbtS6dkiT6DMe85BYlgTtiqFo7eTY0z4L/mdpgYgWkim/1F0g00H4+EZeV9NugF
	q1OQkF5W7Su9+LeEH/bVgoaVdnSWgovFqvIwh4bK+3gFETyri41GpoyL1xIpeBXrt2zZIsuDuGP
	0jeeWEIrEinx1ToLoEUCNZ4WncdtRGFGC/ddUqmSq6SH6W79x4r1u45KvKARfKzB8UYmi1T9219
	KqEUyYweIB+68aGa93KVQz53JZbTkq51bQQWrjTW8MIDisg2Bmb6CA==
X-Google-Smtp-Source: AGHT+IEOkCuEJ4y6Pz/ka0G+KJKTZOyC+nCXkEkskAiqb7vP1hG++WLS+FAQG98+YjaTGs0pmzRsBg==
X-Received: by 2002:a17:90b:2dc4:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-30151cad150mr17773701a91.2.1742232016547;
        Mon, 17 Mar 2025 10:20:16 -0700 (PDT)
Received: from localhost ([2804:30c:b31:2d00:277c:5cbe:7f44:752b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30153b994cdsm6328475a91.31.2025.03.17.10.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:20:15 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:21:13 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, corbet@lwn.net
Subject: Re: [PATCH v1 1/4] iio: adc: ad4000: Add support for SPI offload
Message-ID: <Z9haCda4yF2SZ6gb@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741970538.git.marcelo.schmitt@analog.com>
 <301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt@analog.com>
 <20250317102751.5702fb82@jic23-huawei>
 <Z9hAUs1wPOIAo2nt@debian-BULLSEYE-live-builder-AMD64>
 <60831e04-52c2-446f-8bc5-b5d3e9e5fd40@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60831e04-52c2-446f-8bc5-b5d3e9e5fd40@baylibre.com>

Hi, comments inline.

On 03/17, David Lechner wrote:
> On 3/17/25 10:31 AM, Marcelo Schmitt wrote:
> 
> 
> > ...
> >>> +/*
> >>> + * This executes a data sample transfer when using SPI offloading for when the
> >>> + * device connections are in "3-wire" mode, selected when the adi,sdi-pin device
> >>> + * tree property is set to "high". In this connection mode, the ADC SDI pin is
> >>> + * connected to VIO and ADC CNV pin is connected to a SPI controller CS (it
> >>> + * can't be connected to a GPIO).
> >>> + *
> >>> + * In order to achieve the maximum sample rate, we only do one transfer per
> >>> + * SPI offload trigger. This has the effect that the first sample data is not
> >>> + * valid because it is reading the previous conversion result. We also use
> >>
> >> Say what happens to that invalid sample.  Is it dropped or provided to userspace
> >> as if it were valid?  (I hope dropped!)
> > 
> > TL;DR: The invalid sample goes into the buffer as a valid one.
> > 
> > In AD4000 '3-wire' mode, data capture has a latency (delay) of one sample.
> > 
> > The ADC begins sampling data N at CNV rising edge
> >           |   +-- CNV (usually SPI CS) is brought low to begin reading the data
> >           |   |                                +-- Data N + 1 that will be read
> >           |   |                                |   on the next transfer starts 
> >           v   v                                v   being sampled at end of transfer N.
> >            ___                                  ____            
> > CNV  _____/   \________________________________/    \_____
> >                     _     _             _
> > SCLK ______________/ \___/ \_ ...   ___/ \_______________
> >                    ___   ___           ___
> > SDO  _____________/___\_/___\ ...   __/___\_______________
> >                     ^
> >                     |
> >              Data from conversion N is output from here on
> > 
> > A better drawing can be found in datasheet page 29, Figure 57.
> > https://www.analog.com/media/en/technical-documentation/data-sheets/ADAQ4003.pdf
> > 
> > In sum, we're always reading a conversion that started at the end of the
> > previous SPI transfer or, in other words, the data comes out with a latency
> > (delay) of one read.
> > 
> > Datasheet somehow mentions that by saying
> > 	When turbo mode is enabled, the conversion result read on SDO corresponds to
> > 	the result of the previous conversion.
> > 
> > I think I can do a dummy SPI transfer on buffer preenable so at least the
> > first data is not invalid. Would that be better?
> 
> Not really. There will be a relatively long delay between that conversion
> trigger and when the sample is read. So the data might be slightly less stale
> in that case, but still not particularly useful, e.g. if you are doing any
> kind of signal processing that expects equal time between all samples.
> 
> On similar chips, like ad7944, we just documented that the first sample does
> not contain valid data and needs to be discarded.
> 
Okay, I'll assume that to be acceptable and do the same for this one.

...

> > I also didn't expect to find out HDL support for 16-bit data width was removed.
> > We used to have a build parameter for 16-bit precision ADCs.
> > https://github.com/analogdevicesinc/hdl/commit/b2dc91b30dae891b6319d88e083f26e726f43ba0#diff-1117c2618353232e5f22aa6a12e8ae976757fa897b3425f470a12123cae26535L13
> 
> A while back the HDL engineers mentioned to us that they wanted to standardize
> on 32-bit data words everywhere. While not the most efficient use of memory,
> having fewer options does make things simpler across the entire software stack.
> 
Ack

> > 
> > Would something like 'because SPI offloading leads to data being pushed to
> > memory in CPU endianness' be a reasonable comment?
> 
> Another way to say it is that SPI offload reads data in complete words and not
> in separate 8-bit xfers (bits_per_word = realbits vs. bits_per_word = 8).
> 
Ah sure, I recall the effect of setting .bits_per_word now.
Will add a comment explaining why the difference in endianness.

Thanks,
Marcelo

