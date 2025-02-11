Return-Path: <linux-iio+bounces-15372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD50A3187E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E43C1888C69
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 22:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0313268FE9;
	Tue, 11 Feb 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0lCuePj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443E268FD7
	for <linux-iio@vger.kernel.org>; Tue, 11 Feb 2025 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312479; cv=none; b=QVIFtl2o0TjJJBg44Fa4dh9YyKQY/kO0Qwy64zUnIjAburaNgPHO6Jhh7Ogx77GyQDpWJNSPTC4oKwJHKHJX+VMPS2lm2XxH0X7B0bIx7LujYvpJwMO9yis+CCEWHihcmvr6ylEiKfJC9NylTUQu/htEFi/OL0mnbyiJ/NG1XAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312479; c=relaxed/simple;
	bh=a1YSwYfSHtvwJzBZ4RED+1zkCwMf/mzH1nEkn7wsbQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWA7F64gBsEwlDtXq02c1OQmPh3rbpPnAo48hZ7cFvBgw8qwIk1Gz12YRpd/fN+8VXWoS4tlR/V5IZR027cU/hpWmF3x7OrTAnyBNkfl9Hl4rIBPvGFARVL6HtGrUSwo4eBQXYKSbIsvdX4gpoPOiA/2dyk/SkYzUrb1/pUR4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0lCuePj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f72fac367so47025ad.0
        for <linux-iio@vger.kernel.org>; Tue, 11 Feb 2025 14:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739312477; x=1739917277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjzryGBicQVImcaUwF8Kk/J08SYkgXHEDzMrm9AaCFM=;
        b=A0lCuePjEqndR/u2jYv1ql0b3NvLNdLV39OTn9zzp/SpH9Ffo0nZSbQDyt2SFhEULR
         Vw83RJhOLHVFlvbSdhTnJeULok+zImblUmaOLqceK1kTq+2TJ3OyrqOPv2mW0VYkASOn
         Iu4y+Tbbev0jRVYBn8CC0H8miYzZCa8y27YrcXxu1XC84A1wnCFLCW4hwdLDpX1BNW+l
         L1d2FXTfkDzvvFUeo2aKHyVHkHYNEeU9L0O+PZCWPahzQyVUgorJ3g3TdlEovSrCEA+V
         h8bZfytDmrox3TENLcuhozy2bWIxy7Fm4WUA1Ib0Qd8lmED6HjAXmi5+C0iAEyLe1DZv
         0KXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312477; x=1739917277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjzryGBicQVImcaUwF8Kk/J08SYkgXHEDzMrm9AaCFM=;
        b=kup/G4Mo3P15Kqh4yVyFkUtSyBShGpf8GS802pc7TC6C3L+mTkSe3RiINARiFeOg+1
         YsVgMbCFcKLro5NRjc+KnD6rtez9CcWK7xQ8Fh24xg3zyK2Yx5gS/rDyEPeAG/OeHlH4
         CFe/n2N8PFMlB09FxIc7I4e422lupGj+hAg33MPt4tu8hF9fx9etRDUK4lzWgUW/p5Wa
         1Jtx+lxFORptMcnE3/Im1a1od0zzDE/m3Oq6gKjI6zxJdld3tgWyanNCsnqJY8IxTv0W
         ptXCekmFzpuG+TJDNEGrhe1LIf0TlKN3P8cAbJBriZ1vNyAKKH8uCWekK9inXBcxhyz8
         kd/w==
X-Forwarded-Encrypted: i=1; AJvYcCXNHXrnygoEeZ8C+o7Z9+h6lu/lMVq/sADwVXqlWB6C0jh/EvuC6/QR66V81XjSjH2piAczbaWAMYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6YY5OomiuQJAL6/6grGUt6+FkUOFq4n4KEzTjzV3eFvK1sKQH
	uCsbUj0XV8G2i5brzA9tTAo5Xs2YSeOQO54EcRYJ7avpCZrwl+FWqR0QQENqPA==
X-Gm-Gg: ASbGncvVlUsRZajkGKiTbL0hk5po9S5mCYKhh53KpfOtNtmM8lRQyh5NjrN3dTByuOy
	5baHwD/xOn7+qqDRNT2N/+fPKaYl+LCjOLPkMRXlTuyWlezHQrV1gEVQP7OWKQcRIoTL2QqaFeZ
	e+mzlnCLLKtz8hRiC884YFFMCDNXLT8A1QzmdHzAHI/dWkfmqxnNTklmTyRaezNHYlEBTtJytKH
	Hn5sA/cgKiSVLThtpiLhoTU9YhZcTWnz9TNWM9krh90k7PLTUEyNAZ8bxnRxCn5oF4qGHkXWuPu
	alsnFmgx1caoOl9RiNYpu04Fku1dGk+Hm7Oxkf0m6H+Yvv0Y6TbX
X-Google-Smtp-Source: AGHT+IE9Eyuod2lYAzKcb7DlMkAvrPxHPMFUvHM7quPOLgjcn1Gu3gW3iwUvOBgkIXWv8Gbuo0K2Ag==
X-Received: by 2002:a17:903:1664:b0:21a:87e8:3897 with SMTP id d9443c01a7336-220bc76be3amr773775ad.4.1739312476858;
        Tue, 11 Feb 2025 14:21:16 -0800 (PST)
Received: from google.com ([2a00:79e0:2e14:7:951b:5f7b:9042:f9d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9aaf7c9sm46982a91.46.2025.02.11.14.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 14:21:16 -0800 (PST)
Date: Tue, 11 Feb 2025 14:21:11 -0800
From: Brian Norris <briannorris@google.com>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <Z6vNV8dDDPdWUKLS@google.com>
References: <20220620144231.GA23345@axis.com>
 <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com>
 <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6lzWfGbpa7jN1QD@google.com>

Hi Ajay,

On Mon, Feb 10, 2025 at 09:02:41AM +0530, Ajay Agarwal wrote:
> On Wed, Jul 27, 2022 at 06:31:48PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@suse.com> wrote:
> > > On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > > > Well, in general suspending or resuming a device is a collaborative
> > > > effort and if one of the pieces falls over, making it work again
> > > > involves fixing up the failing piece and notifying the others that it
> > > > is ready again.  However, that part isn't covered and I'm not sure if
> > > > it can be covered in a sufficiently generic way.
> > >
> > > True. But that still cannot solve the question what is to be done
> > > if error handling fails. Hence my proposal:
> > > - record all failures
> > > - heed the record only when suspending
> > 
> > I guess that would boil down to moving the power.runtime_error update
> > from rpm_callback() to rpm_suspend()?
> Resuming this discussion. One of the ways the device drivers are
> clearing the runtime_error flag is by calling pm_runtime_set_suspended
> [1].
> 
> To me, it feels weird that a device driver calls pm_runtime_set_suspended
> if the runtime_resume() has failed. It should be implied that the device
> is in suspended state if the resume failed.
> 
> So how really should the runtime_error flag be cleared? Should there be
> a new API exposed to device drivers for this? Or should we plan for it
> in the framework itself?

While the API naming is unclear, that's exactly what
pm_runtime_set_suspended() is about. Personally, I find it nice when a
driver adds the comment "clear runtime_error flag", because otherwise
it's not really obvious why a driver has to take care of "suspending"
after a failed resume. But that's not the biggest question here, IMO.

The real reson I pointed you at this thread was because I think it's
useful to pursue the proposal above: to avoid setting a persistent
"runtime_error" for resume failures. This seems to just create a pitfall
for clients, as asked by Vincent and Oliver upthread.

And along this line, there are relatively few drivers that actually
bother to reset this error flag ever (e.g., commit f2bc2afe34c1
("accel/ivpu: Clear runtime_error after pm_runtime_resume_and_get()
fails")).

So to me, we should simply answer Rafael's question:

(repeated:)
> > I guess that would boil down to moving the power.runtime_error update
> > from rpm_callback() to rpm_suspend()?

Yes, I think so. (Although I'm not sure if this leaves undesirable spam
where persistent .runtime_resume() failures occur.)

...and then write/test/submit such a patch, provided it achieves the
desired results.

Unless of course one of the thread participants here has some other
update in the intervening 2.5 years, or if Rafael was simply asking the
above rhetorically, and wasn't actually interested in fielding such a
change.

Brian

