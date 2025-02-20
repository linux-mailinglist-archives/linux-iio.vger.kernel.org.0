Return-Path: <linux-iio+bounces-15826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D820BA3D4C8
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9D73AC103
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0F1F03CA;
	Thu, 20 Feb 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fWW/2AjN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC2E1EE7C4
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043840; cv=none; b=oQA5tSJzBGNtudGl+rsb9FCkrbhcha3y+5k8mEmTG798QR0I++CiOn2ScmXAtJ2R+xujCcgBsQ5ypA4gAftQO36bW9+buww0bAVCVf3uwj6TNga/gHoogDvJz7zUxapXpSmJWCmiSFLN0mZ+lCvNDoBPch9+YTppmk2w/3HNUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043840; c=relaxed/simple;
	bh=mJiT3XmfGosfifXl1yjMZDq+iitE9qUOlBFMxJgjgYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5KMDtIsO50ti2pSeISVgR0F1nLpTzsV2r0LBwkaDo2mkFADFhIpafZIEZtjNF2rmtdujkMGi0KHtbfOneh0HzOFYuD1rLlYb33E12DvL+4SMdH3PoxQu69jXQnxcIR/z3rPyTAYjlWViI2rDw4cgSKXsJw8YVXnXIJqyRZcgKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fWW/2AjN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4399deda4bfso4359695e9.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 01:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740043836; x=1740648636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+AyV1ElPPjhQNUEXRx/M9RMpbSIJfQK14iFeHgY7bo=;
        b=fWW/2AjNilIQwv33XSMtZ0gjPOrBvUd96cH+14EAfl7FycrndoKevrxlePNe3689b3
         r6i9t0FLlrlbOJoZrWeAXCHx35RDNax06G5TQv1a4tz73lUi9dND+hYlUcn5RN5wr9MA
         najCDvKnsOwtPhKsTM1OykbVE1ubWRbOkXhIorf6J1upwmAT32QKIewqlM/3ub2470AV
         9d+1bH7/uCyyLznaN1n5A98T3Ezy77EStDy783uOR6wu9YHllgJ3Uqe702TqtWrn31Yi
         WL1CL0TndifrRaj2CpuEHRiqvmuEhzP2XARJ9AaFM2GdYE0ZLpI1LPiMNY5FQY0rcC4U
         5E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740043836; x=1740648636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+AyV1ElPPjhQNUEXRx/M9RMpbSIJfQK14iFeHgY7bo=;
        b=kLgZPZXg3DKFSAA1EscY9f+zzek9TLxwFc8EqeyJonGN9Khnh+BDqVpOoQd+TdurOh
         ggz77UBh2TAde1uLQFyNKqI5Z8H3wUD5CoxsBiHdQzMNLvoHah2qXaiVW3K6IMEVOctl
         1MHciB2g7fvOfiS/0XypiHWWiYXlwkyfrDCb9yzBQQwVkrQd2Bu77QVSlemQCmTwM7vu
         t6TGU0eBYHEBjGT3MjwRT0ZRgjQKrd6tyF3On2wHN7mIo0VXsSSTA/WzuRnb2NO5kRsr
         RlDlGOmwNTFWup56ilMT8q8mNdwmIJdWgUb80CoRaAy/iEcaGvhW1jvPfXI/Rjok7k4u
         oevQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR6GD2xSEGmHZz2hrvFmm4g383i7nQ7Qo2aglDGJy4zisVMTetlW8puSJbAwt5MAc5LjY1wXQoRA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjMv8qiIDnpdFoVIpSSMHREfI1iOYOk5k6xPc5k4SvlMettaOe
	GVGOobW746T+7e5hAv0RqCicl6K1/oyEc1mPLCoFtjwBo8J/J3dGDCxqDCJ5oQs=
X-Gm-Gg: ASbGncsuU8JyrgM0jIQN6YZSu2HWoYYg7pXQ8+6qm1nXztBAOCHHqt/YP9+ajZaCOur
	DiB8hLmNRkv4J+4hu+rgmuTiviB4bqXiqPzuxGGvmkTyI9IFFQ4Hl7jby9FgR5prDldj4DpzKe4
	/DcCXaZxMZP9Z+hTbOANmAIEzm1j+sKk71QVtj5jduiglnw1zuQyvpVlNEt/FAKCLBPzQRzp23T
	iOFJIhTmemzsMBzX009wbZ9he1cw5GY1DT+FqYeAdVkMB9XUL9tcFVQg7NNDS7iZgaQOPtDHQA0
	OZWwA3hdVaSouVvibvvh6C3yoikSMyIRkWFpPldiVp3jy+Cis/PwCcTyDw==
X-Google-Smtp-Source: AGHT+IGsJlbwWX31Qw4w1zUmu7Bk9UHfJExzc1EbOZsajeDzH9je73pVLI7w+d77pplTZTfvLzXlNg==
X-Received: by 2002:a05:600c:4fd2:b0:439:9e8b:228e with SMTP id 5b1f17b1804b1-439a4baf3a5mr12968635e9.20.1740043836387;
        Thu, 20 Feb 2025 01:30:36 -0800 (PST)
Received: from ?IPV6:2001:a61:136c:cf01:505d:b6ac:9103:aec6? ([2001:a61:136c:cf01:505d:b6ac:9103:aec6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258eb141sm19702925f8f.41.2025.02.20.01.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 01:30:36 -0800 (PST)
Message-ID: <50de9721-2dd8-448b-8c11-50b3923450f6@suse.com>
Date: Thu, 20 Feb 2025 10:30:34 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PM runtime_error handling missing in many drivers?
To: Brian Norris <briannorris@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>, Oliver Neukum <oneukum@suse.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com>
 <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
 <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com> <Z6vNV8dDDPdWUKLS@google.com>
 <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>
 <Z7ZYEp4oqPs12vsP@google.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <Z7ZYEp4oqPs12vsP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.02.25 23:15, Brian Norris wrote:
> On Wed, Feb 12, 2025 at 08:29:34PM +0100, Rafael J. Wysocki wrote:
>> The reason why runtime_error is there is to prevent runtime PM
>> callbacks from being run until something is done about the error,
>> under the assumption that running them in that case may make the
>> problem worse.
> 
> What makes you think it will make the problem worse? That seems like a
> rather large assumption to me. What kind of things do you think go
> wrong, that it requires the framework to stop any future attempts? Just
> spam (e.g., logging noise, if -EIO is persistent)? Or something worse?e

suspend() is three operations, potentially

a) record device state
b) arm remote wakeup
c) transition to a lower power state

I wouldn't trust a device to perform the first two steps
without error handling either. It is an unnecessary risk.

> And OTOH, there are clearly cases where retrying would be not only
> acceptable, but expected -- so giving special case to -EAGAIN and
> -EBUSY, per another branch of this thread, seems wise.

Yes

> 
> I'd also note that AFAICT, there is no similar feature in system PM. If
> suspend() fails, we unwind and report the error ... but still allow
> future system suspend requests. resume() is even "worse" -- errors are
> essentially logged and ignored.

Suspend requests from runtime PM are different. They happen spontaneously.
Secondly, failures to suspend in runtime PM are far cheaper.

>> I'm not sure if I see a substantial difference between suspend and
>> resume in that respect: If any of them fails, the state of the device
>> is kind of unstable.  In particular, if resume fails and the device
>> doesn't actually resume, something needs to be done about it or it
>> just becomes unusable.

Again, if you look at it in an abstract manner, this is a mess. Resume()
is actually two functions

a) transition to a power state that allows an operation
b) restore device settings

It is possible for the second step to fail after the first has worked.

> To me, it's about the state of the device. If suspend failed, the device
> may still be active and functional -- but not power-efficient. If resume
> failed, the device may be suspended and non-functional.
> 
> But anyway, I don't think I require asymmetry; I'm just more interested
> in unnecessary non-functionality. (Power inefficiency is less important,
> as in the worst case, we can at least save our data, reboot, and try
> again.)

You are calling for asymmetry ;-)

If you fail to resume, you will need to return an error. The functions
are just not equal in terms of consequences. We don't resume for fun.
We do, however, suspend just because a timer fires.

	Regards
		Oliver


