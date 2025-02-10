Return-Path: <linux-iio+bounces-15221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0594FA2E2D0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 04:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F883188790A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 03:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BE67DA9C;
	Mon, 10 Feb 2025 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKn1TGDS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D2335D3
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158372; cv=none; b=NHEWBVy1iliJ/fCxRV6h4LZNIjleQcWfnGHVtTfW9YNeMvu90KSL6E7acozTiA8yd1jnNN89chfaSeMPxfTZ3TYT9YtT3T8VWgWtjrooGJgRbNod04sfAszWJCAITIUlsFWwitrPwoa0yoN7UKslhEJmnU/TaT6c+llXLtFpmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158372; c=relaxed/simple;
	bh=jnnmj0WfzpeDrcbnj+h7NoyTOp/J35XvifKCDJfWDYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIRKC3Mb4Z2YxaTn4Og7uZLCgQMVOfKLW8aWYR20UyJxvwxx3Ce8bzc5Vn3vi7G+ZmqVqu9+t7chl7fH+e4OQn1bK7B5oXApH66uFdy1J1jjXqAoNRX2JZMWXbTil1kGrTfSb8fDhoply7x8s1Wn2l/VJU64/I/V/X0Au+CeCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xKn1TGDS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so1569710a91.2
        for <linux-iio@vger.kernel.org>; Sun, 09 Feb 2025 19:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739158370; x=1739763170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDphYiBK6zaLhzzhuS11hijH34kWZBXLf6tNFNwk8Fo=;
        b=xKn1TGDSGa3Y4X9H0nCrWEEnCn9w6ZpgoVjZATI9NyheLH3xESb5tLGtUpf9UAZ0aB
         5LzyYTkT615x0LWGDWSuUKsw5yRJryJwIS4vaSy+6eV8bR7dnGFYFt79AN2xlbkCEWde
         l8tyK8oZfru2cs+XH0G4x6CzxtOQEsWFAeanUeIH4rvsl8eqXeS6cH+fbv7ZKA3163hR
         u9GPzbqYk55OejW0KSyCl4tfnv3OK+wCppqTnWvDnoDm3eVv3NLuIzacY/H2rF1khEqx
         Wx1TMZipsXlzgWs1I0CXeNuG6KRjNl8pNkeFy+lJDAEcRuJoLKTxeJROPhPwPuSeOXp/
         /dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739158370; x=1739763170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDphYiBK6zaLhzzhuS11hijH34kWZBXLf6tNFNwk8Fo=;
        b=PUDMKCUe8AP4uFF5n5I5PBsV23lkg34qot4+UyPTDfrip7D2ITXYhUetqvNKfbJF6W
         p2X/DM14196ESaLdxKvAPHDVRWOz683KVsbkXrmkBzABNEQcBeLOSXKidatDojYYNzyX
         sHbAmNEL2MBOD9p5HP8IOzp+o1MMViVHQMdJ76TiUEnt1D5Dj1/SPYQnY+QpEQscygGN
         szshiKCZkw8Si0TRrp0tSkK/GUuEdQ492cfSxXX71DKHRUkqiWfwFubDxc/MXggXZs5t
         0/4wkhFTuIF7aTiqBzP3fsn18c3cKoKmw8BoLiryqTgCtDt6MPBLF5JTf55Yypki1pSh
         4rkA==
X-Forwarded-Encrypted: i=1; AJvYcCUTf7yjbSPwPSa7egT6G00uHGZ+bry0KdH9KLnHJgexeCB+gIjkpZZsh8HOfQCAP/2XawSCGuM/oDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdf9ym8S9tkYG3kzGIhxdngZ9xs8Pig9S3b/zLC89oZkMse4t
	+HrBh6B3O3jtCAxCqQpHocj4Vsdf0v1UEuf3hihMy5mKGr0Rc3RmcIv7UvqaIQ==
X-Gm-Gg: ASbGncuooSFSqOZp5NvdoL4I1wu1u/sWPTGopJAW7KRaZVxcRMsd64PfPBat3124gw6
	TbfCQWmVu4tzAt+Bxj97zi0bnD8x3+tBKj1xdOvWBi18n4o5eKYGumcErfgrvYHkz5UVKdZrZIv
	KzEburNXGYDB/fxXCBpg9Pg8W12JzPRVXLAn2gvS/rz4xfi5Nj80t5ZPeeX4kp7dNKxjxYNc+QW
	IKVk3CICai8BTnKiTalCwcN9elqaU8ZS19EKPRyhzEd7nAzJfZRT/5AZtYmaqDiItVQivWMMohH
	Vg9UTvUUbS/bWBklb9vY39XXmXPP/MdMhWzv23F0+fEhNQpdp6WsWkwTTQ==
X-Google-Smtp-Source: AGHT+IFjZyZ3ezW0s75YhMjc+3RWhwDMlBTzyIdX4ehs3aMkTRN964Frh+KixLFvEGShcSqs5iHgnQ==
X-Received: by 2002:a17:90b:1d52:b0:2fa:137f:5c5c with SMTP id 98e67ed59e1d1-2fa23f44beemr16953451a91.1.1739158369742;
        Sun, 09 Feb 2025 19:32:49 -0800 (PST)
Received: from google.com (49.156.143.34.bc.googleusercontent.com. [34.143.156.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa15ab5b26sm6767278a91.20.2025.02.09.19.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 19:32:49 -0800 (PST)
Date: Mon, 10 Feb 2025 09:02:41 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <Z6lzWfGbpa7jN1QD@google.com>
References: <20220620144231.GA23345@axis.com>
 <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com>
 <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>

On Wed, Jul 27, 2022 at 06:31:48PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@suse.com> wrote:
> >
> >
> >
> > On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > > On Tue, Jul 26, 2022 at 11:05 AM Oliver Neukum <oneukum@suse.com> wrote:
> >
> > > I guess that depends on what is regarded as "the framework".  I mean
> > > the PM-runtime code, excluding the bus type or equivalent.
> >
> > Yes, we have multiple candidates in the generic case. Easy to overengineer.
> >
> > >>> The idea was that drivers would clear these errors.
> > >>
> > >> I am afraid that is a deeply hidden layering violation. Yes, a driver's
> > >> resume() method may have failed. In that case, if that is the same
> > >> driver, it will obviously already know about the failure.
> > >
> > > So presumably it will do something to recover and avoid returning the
> > > error in the first place.
> >
> > Yes, but that does not help us if they do return an error.
> >
> > > From the PM-runtime core code perspective, if an error is returned by
> > > a suspend callback and it is not -EBUSY or -EAGAIN, the subsequent
> > > suspend is also likely to fail.
> >
> > True.
> >
> > > If a resume callback returns an error, any subsequent suspend or
> > > resume operations are likely to fail.
> >
> > Also true, but the consequences are different.
> >
> > > Storing the error effectively prevents subsequent operations from
> > > being carried out in both cases and that's why it is done.
> >
> > I am afraid seeing these two operations as equivalent for this
> > purpose is a problem for two reasons:
> >
> > 1. suspend can be initiated by the generic framework
> 
> Resume can be initiated by generic code too.
> 
> > 2. a failure to suspend leads to worse power consumption,
> >    while a failure to resume is -EIO, at best
> 
> Yes, a failure to resume is a big deal.
> 
> > >> PM operations, however, are operating on a tree. A driver requesting
> > >> a resume may get an error code. But it has no idea where this error
> > >> comes from. The generic code knows at least that.
> > >
> > > Well, what do you mean by "the generic code"?
> >
> > In this case the device model, which has the tree and all dependencies.
> > Error handling here is potentially very complicated because
> >
> > 1. a driver can experience an error from a node higher in the tree
> 
> Well, there can be an error coming from a parent or a supplier, but
> the driver will not receive it directly.
> 
> > 2. a driver can trigger a failure in a sibling
> > 3. a driver for a node can be less specific than the drivers higher up
> 
> I'm not sure I understand the above correctly.
> 
> > Reducing this to a single error condition is difficult.
> 
> Fair enough.
> 
> > Suppose you have a USB device with two interfaces. The driver for A
> > initiates a resume. Interface A is resumed; B reports an error.
> > Should this block further attempts to suspend the whole device?
> 
> It should IMV.
> 
> > >> Let's look at at a USB storage device. The request to resume comes
> > >> from sd.c. sd.c is certainly not equipped to handle a PCI error
> > >> condition that has prevented a USB host controller from resuming.
> > >
> > > Sure, but this doesn't mean that suspending or resuming the device is
> > > a good idea until the error condition gets resolved.
> >
> > Suspending clearly yes. Resuming is another matter. It has to work
> > if you want to operate without errors.
> 
> Well, it has to physically work in the first place.  If it doesn't,
> the rest is a bit moot, because you end up with a non-functional
> device that appears to be permanently suspended.
> 
> > >> I am afraid this part of the API has issues. And they keep growing
> > >> the more we divorce the device driver from the bus driver, which
> > >> actually does the PM operation.
> > >
> > > Well, in general suspending or resuming a device is a collaborative
> > > effort and if one of the pieces falls over, making it work again
> > > involves fixing up the failing piece and notifying the others that it
> > > is ready again.  However, that part isn't covered and I'm not sure if
> > > it can be covered in a sufficiently generic way.
> >
> > True. But that still cannot solve the question what is to be done
> > if error handling fails. Hence my proposal:
> > - record all failures
> > - heed the record only when suspending
> 
> I guess that would boil down to moving the power.runtime_error update
> from rpm_callback() to rpm_suspend()?
Resuming this discussion. One of the ways the device drivers are
clearing the runtime_error flag is by calling pm_runtime_set_suspended
[1].

To me, it feels weird that a device driver calls pm_runtime_set_suspended
if the runtime_resume() has failed. It should be implied that the device
is in suspended state if the resume failed.

So how really should the runtime_error flag be cleared? Should there be
a new API exposed to device drivers for this? Or should we plan for it
in the framework itself?

1: https://lore.kernel.org/all/20250129124009.1039982-3-jacek.lawrynowicz@linux.intel.com/

