Return-Path: <linux-iio+bounces-15925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFD5A40500
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 02:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2344205E9
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 01:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BF716BE17;
	Sat, 22 Feb 2025 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ecvcVJv9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7878F40
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740189101; cv=none; b=jE9FhKm9XCQylpfbuClorgCNNE+vTfznP3wv17Ky7QVu91aomrCbqDQwnGRVBpdN+so2XrOJUCOtQdcG4GhMMg/N2nu1O8fh9VzGAsqrgvSl6bH0ZDACm2FWID+2O+LCLPZRiCryToDZCtr+CVQQjXXQdmAVMEX/REwDqOQmAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740189101; c=relaxed/simple;
	bh=b/wCdmMliqE07gTjcVqKdmn4h1VhcVtYzWKk7Ib2gis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccEVbhW+w9z5N2/bs6l8xJlR2pPeL+Pf9NEZW1gbOTHJnGC6Ccq7DoiBsz+npKwX3CZRmw/IsCCNAPjyRMKL015LvtpylspzzyrpcByaWDgOBSWYMXK8f5zsI+v7hk1VfJ121ceu6vSgmB6bNFmvNULdkJPpjQWkUq341lNeUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ecvcVJv9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22100006bc8so49196195ad.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Feb 2025 17:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740189099; x=1740793899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bha+1AwEm87+wTDNDH+caF+yfplFmYnHclPIveYfWAQ=;
        b=ecvcVJv9LVPT0YklwYr6vYCC/8JRmm8gLXgmNdPv2uo/mG71uEU+DbJ0p+Stga4iXB
         tRmbZYIRuU1vIvplHdnzFeVcHIDN1IslEJfXuYgh58Me2vmHEnx87FO5H5SiYV02OdUV
         SCg6N6F07ZU2TQspJvdAUZTLwPmTOEWRbqwow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740189099; x=1740793899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bha+1AwEm87+wTDNDH+caF+yfplFmYnHclPIveYfWAQ=;
        b=FO87KsXG06jt+WxK4bbM+gO2VFIVgHzj42f+Om03b09P4bm42EfgHypACuXRClfU7x
         CHXCY+qudD0Hv6JKrejfW/pXSMvACbw6Luf2u5QHqK4t0Q/pTiUaZ5S6PmdRgVVpdydl
         ImiRy082WgvzEf/9si7HZB+pwdvUf3DOprFtemI4DC/Vihs49z2wgGrQ/GLZWKl7+Bek
         YXZ4VieeuC1u8pnD+BnKVCGOovZk/2UEi/eGBASUyT9+8E88bYEjm9ILizA7IMDXecbu
         6QfL9mOT/uwhapf201Y5zqmjxffYIu65BY7EJh/bCrXCpKJOS061VIlC+iQx+jMxhKSQ
         BpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNM7BLqtnQKeSNNTU9PHuUtsByaZTIjnjtV3UtsLcowL7BBxXeABr5mNr9Q3zeCvX5uPo+5LR4+us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLIkJT6scPFZn9WeYP2TCvLDUeRu6UNBcLFbLIKjt50ELdcma
	dxapv4ynXkWW/qNc3Ae1oQWLc+rrYlp+zXyuqmQd4gOFWR29hPNG/xZDGopWLQ==
X-Gm-Gg: ASbGncv3BegsEXUJ8Ibd2JK1+AH2LRDvIXXbhX9NuES9QKyC6tsvC6a5NMctRO4wtZ0
	fn+NejUJw0RueVYqoJ4Th+Nq1RxaZ90V9WEaty0LrcfMnfa6xbUcVJ8AbbdS5aMg09OAHIKukCT
	XDJiUiuRjoX29r+VS1vxgTloaDeH2eadrYslGJlx4Vu5JcwW0munNjeXaIHEaC3LQNgcMxJ77Vl
	GWOzuf5QwuBVolX+NXchW480zZqpx6VhfRr2JtfJQ5skelqvkJSFJbHIaJCwzZMLTkD/LWLwdSU
	B+toCzYyuJ9L3qebk7CCDTDPfUkGPLuAinVrWeM7KxmmOULeUgsEHdL25tmqkOqK
X-Google-Smtp-Source: AGHT+IFQyCCmTk5w1MoV+somoLERcOrpGo8lL2HFayqWLgHH5Imn3/GOjNna8e6kg5FpReH7HQUnQQ==
X-Received: by 2002:a17:903:2342:b0:216:6901:d588 with SMTP id d9443c01a7336-2219ff565d8mr81388185ad.15.1740189099244;
        Fri, 21 Feb 2025 17:51:39 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:cfe4:a8ae:32fb:3c84])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2213394d6c8sm89030505ad.181.2025.02.21.17.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 17:51:38 -0800 (PST)
Date: Fri, 21 Feb 2025 17:51:36 -0800
From: Brian Norris <briannorris@chromium.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ajay Agarwal <ajayagarwal@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <Z7ktqHxIhp90jLxi@google.com>
References: <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com>
 <Z6vNV8dDDPdWUKLS@google.com>
 <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>
 <Z7ZYEp4oqPs12vsP@google.com>
 <50de9721-2dd8-448b-8c11-50b3923450f6@suse.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50de9721-2dd8-448b-8c11-50b3923450f6@suse.com>

Hi Oliver,

On Thu, Feb 20, 2025 at 10:30:34AM +0100, Oliver Neukum wrote:
> On 19.02.25 23:15, Brian Norris wrote:
> > On Wed, Feb 12, 2025 at 08:29:34PM +0100, Rafael J. Wysocki wrote:
> > > The reason why runtime_error is there is to prevent runtime PM
> > > callbacks from being run until something is done about the error,
> > > under the assumption that running them in that case may make the
> > > problem worse.
> > 
> > What makes you think it will make the problem worse? That seems like a
> > rather large assumption to me. What kind of things do you think go
> > wrong, that it requires the framework to stop any future attempts? Just
> > spam (e.g., logging noise, if -EIO is persistent)? Or something worse?e
> 
> suspend() is three operations, potentially
> 
> a) record device state
> b) arm remote wakeup
> c) transition to a lower power state
> 
> I wouldn't trust a device to perform the first two steps
> without error handling either. It is an unnecessary risk.

I'm not sure I fully understand what you're saying. I'm not saying
drivers shouldn't handle errors. I'm just saying I don't see why the
framework should decide, "fail once and you're out."

Do you think (a) or (b) will fail silently if retried after a failed
operation? And what's the consequence?

> > But anyway, I don't think I require asymmetry; I'm just more interested
> > in unnecessary non-functionality. (Power inefficiency is less important,
> > as in the worst case, we can at least save our data, reboot, and try
> > again.)
> 
> You are calling for asymmetry ;-)

Actually, you were the one who proposed asymmetry :) My concern is
asymmetric, but the solution doesn't have to be. For example, we could
remove runtime_error entirely, or else make it some kind of
ratelimited/backoff state.

Anyway, I appreciate that Rafael has helped improve the situation a bit
([PATCH v1] PM: runtime: Unify error handling during suspend and
resume). At least it gives us a tool to achieve what we want: ensure
that retriable failures produce -EBUSY or -EAGAIN. I'll have to give it
a whirl.

But I'm still wary that there are corner cases where other errors may
appear, and yet retrying is indeed the best option. And I'm not
confident that foisting the burden back onto the driver ("just scatter
pm_runtime_set_suspended() any time you might have fixed something") is
a practical approach either.

> If you fail to resume, you will need to return an error. The functions
> are just not equal in terms of consequences. We don't resume for fun.
> We do, however, suspend just because a timer fires.

Agreed.

Brian

