Return-Path: <linux-iio+bounces-22636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D764DB23950
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 21:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F2C5A16BA
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E872FDC30;
	Tue, 12 Aug 2025 19:53:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955662F83D8
	for <linux-iio@vger.kernel.org>; Tue, 12 Aug 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028390; cv=none; b=LNUNokVQUE2SvSyKRrBIJritL4pCOTaz/NcMlTaJxWdiZAvvbckylRr1lCKU4CQ+nib16tVtVo2gFFJSd4cVZzd6bOuMcMSdyW2ZhjjQD/Z01Zg4wNrsv9UE3Nn/dmOgNVGx0kkOtn5LTra7brvL8CoqmNNvCQ4HBOSsXcD2IPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028390; c=relaxed/simple;
	bh=tzhUvHhVWyGuAtysgqnnLemvwz1g0JbyMS+S9A/vHxE=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=n88q+YnFqT2EwxEaqci5PsVMhMdnypV5wYqSyup9BMWeTegfbf4wnf+PKqHAWBo/e/HOYZtiYdyQuFCtNnJRKsgY8+AG2GX7+HZ6vT49tOeQ5XBEhvaA+2mxwKLAYQoh3rX+jXC7N71k3wdUPwI4MuFqoqy2A11EG0PWA48Kx7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1ulv3S-0004mb-4M
	for linux-iio@vger.kernel.org; Tue, 12 Aug 2025 21:53:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [bmp280 v1 3/6] iio: pressure: bmp280: implement sampling_frequency for BMx280
Date: Tue, 12 Aug 2025 21:53:00 +0200
Organization: Linux Private Site
Message-ID: <87ldnonwpv.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-4-Achim.Gratz@Stromeko.DE>
	<CAHp75VfhzJrPU6E=potYqPDYMbimhOy7edw9U0MfKsYMYwo8Sw@mail.gmail.com>
	<874iunknar.fsf@Gerda.invalid> <20250810191117.37c26fa8@jic23-huawei>
	<877bzbf0ti.fsf@Gerda.invalid> <20250811204840.74b2be91@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:xSKfb/xAcikYVZw1zMu7nknedxk=

Jonathan Cameron writes:
> For cases where we 'trigger' an event we normally use sampling frequency
> to be 1/(total time to capture a set of readings)  Idea being it's
> the frequency at which you get results if you immediately trigger
> another one.  Doing that here doesn't correspond to 0Hz.

From the device point of view the setting _is_ 0Hz.  That you are going
to read it back-to-back is not something it can know.

There is one more problem with your idea: since that parameter is the
only way to switch between modes, implementing it you way would mean
that MODE_NORMAL+t_stby=0 would map to the same frequency as MODE_FORCED
and then we're back to square one that there is no parameter to tell us
which mode we want.

> Main problem is no standard userspace code is going to understand
> a value of 0Hz as that effectively means no readings ever.

I am "userspace" and I well enough that I'm going to get one sample per
read.

>> 
>> > Even if it is a pain to work out, we should estimate what it means to
>> > use force mode wrt to how fast a single sample can be obtain.  
>> 
>> MODE_FORCED just doesn't work well ffor devices that do mukltiple
>> measurements at once that then need to be read one by one.  At least not
>> by using the sysfs read request as the trigger for the measurement,
>> which is what the earlier patch did that went into v6.13
>
> I understand it works poorly under at least some circumstances. It's
> just the issue of 0Hz not being a way people would expect to control this
> or how any other driver does it.

Beside any other driver (which I've not looked at), you're willing to
break an existing one?  Because no existing userspace that use this
driver will be working past that change.

> Another approach might be to stash the timestamp of the last 'forced'
> event and if it is 'sufficiently' recent just go with the readings of
> other channels grabbed at that time. If it's not we pay the cost of
> another read cycle.  That's close to doing a runtime pm autosuspend
> on many other sensors where we take the view that if no one asked
> for a while, we will pay the cost of a new power up and hence put the
> sensor to sleep.

I've actually looked at that and found it lacking.  That just makes
MODE_FORCED a permanent thing that totally ignores that the sensor is
supposed to be operated in free-running MODE_NORMAL in many
applications.  MODE_FORCED really is for things like wheather stations
where it gets woken up onece every few minutes.  As long as there is no
separate attribute or module parameter to switch between operation
modes, this would be removing exactly the functionality that I want to
use.

> Hooking a single forced capture up to a hrtimer trigger would also
> be somewhat similar to this but the interface to userspace is
> rather more different so perhaps not the right way to think about it
> here.

I haven't been able to get this to work, I've never got a reading out of
the buffer.  I'll try again once the distribution I#m using has enabled
sysfs triggers, which are easier to test with hopefully.


Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


