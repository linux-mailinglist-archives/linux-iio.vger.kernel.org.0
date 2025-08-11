Return-Path: <linux-iio+bounces-22601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A6BB215E0
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 21:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E0B6241D2
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E625A655;
	Mon, 11 Aug 2025 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahbssDxG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ADC18C322
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941727; cv=none; b=F70BhdT31Ng4ke0UM7deHoe8OR/HhfB9EtLwLmXYp1jcM5Rn3hNvsK9f7viq87LFFdQwG67D6aucDcYEG5ENsAKUpiZJTaQqhKRpvdwjqKWzUrYQCg1LzGJaz95jMtt4LMOGIFAQ2tzbV9/Q0gnIyTnp+CjW4kPRGMUWsIJZjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941727; c=relaxed/simple;
	bh=FYT7/fZEOd4e128g9j58m1cQRxweg29zA1YBvZHkLF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hj+ebmp+9i6PPv/iW5eUA2F/Aek6lSVoQrwdth7q2uXwuwOzEBT7UzJpig7XGQ0ZXLvD7yGQwxWrO8m5JxHEox4nuBdNqnye4KtEJ8WJSfqhC+jb5bj5hnalAOmU47m3I6Sn5kv/qfdrMLWYsGcaUGbu3cSri0Ri43wWQncvx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahbssDxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FACC4CEED;
	Mon, 11 Aug 2025 19:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754941726;
	bh=FYT7/fZEOd4e128g9j58m1cQRxweg29zA1YBvZHkLF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ahbssDxGScH8UdPFLHN2uYAYtApdzvK9VUYdRpW+jSuhFpDxZp14JAEwaKAxEfSVw
	 kLaPNknrzAXMBIWqEAT85ollyQ9+RN0rx+gG40q62w475CFIl86kEcu1qB29F0M9o0
	 aJDqBgtPGIOa4ThgYisD9IxQlJC+C36YDgO6IOla3fL3prrPXt7d8TGQJDJG7UxQwf
	 LCpAiVHPwbiqLblxiiF/HKANj1nH5sJhxTgK0h47+cHmTdjyQKzo6jKQtHwWcRAAym
	 z/wCpZX/jBe5N8KppWKR1zL94HzE+KpX1dEhgDIRT9d48NDKCJNqKkEmKQim2legSn
	 SnXCfWvhxuPAg==
Date: Mon, 11 Aug 2025 20:48:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: ASSI <Stromeko@nexgo.de>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bmp280 v1 3/6] iio: pressure: bmp280: implement
 sampling_frequency for BMx280
Message-ID: <20250811204840.74b2be91@jic23-huawei>
In-Reply-To: <877bzbf0ti.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-4-Achim.Gratz@Stromeko.DE>
	<CAHp75VfhzJrPU6E=potYqPDYMbimhOy7edw9U0MfKsYMYwo8Sw@mail.gmail.com>
	<874iunknar.fsf@Gerda.invalid>
	<20250810191117.37c26fa8@jic23-huawei>
	<877bzbf0ti.fsf@Gerda.invalid>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 21:12:25 +0200
ASSI <Stromeko@nexgo.de> wrote:

> Jonathan Cameron writes:
> > Call it BMP280_ODR_MODE_FORCED rather than making it 0HZ related?
> > Using the value 0 for the sysfs interface doesn't make much sense though.  
> 
> Technically 0Hz is correct, though:  it dosn't cycle at all until we
> tell it to do a single measurement.

For cases where we 'trigger' an event we normally use sampling frequency
to be 1/(total time to capture a set of readings)  Idea being it's
the frequency at which you get results if you immediately trigger
another one.  Doing that here doesn't correspond to 0Hz.

Main problem is no standard userspace code is going to understand
a value of 0Hz as that effectively means no readings ever.

> 
> > Even if it is a pain to work out, we should estimate what it means to
> > use force mode wrt to how fast a single sample can be obtain.  
> 
> MODE_FORCED just doesn't work well ffor devices that do mukltiple
> measurements at once that then need to be read one by one.  At least not
> by using the sysfs read request as the trigger for the measurement,
> which is what the earlier patch did that went into v6.13

I understand it works poorly under at least some circumstances. It's
just the issue of 0Hz not being a way people would expect to control this
or how any other driver does it.

> 
> > It may be that is such that we don't bother with the other slow sampling
> > frequency modes if they are slower as they aren't useful vs only reading
> > when we want to.  
> 
> The way these devices work is that you can read the result of the
> last measurement as often as you want and in any order, even while
> there's another measurement is in progress; and you can chose to have
> free-running measurements or host triggered ones.  It's the current sysfs
> implementation that enforces a rigidity that wasn't there before the
> driver was changed to make the device sleep between measurements.

Okay, with that in mind...

Another approach might be to stash the timestamp of the last 'forced'
event and if it is 'sufficiently' recent just go with the readings of
other channels grabbed at that time. If it's not we pay the cost of
another read cycle.  That's close to doing a runtime pm autosuspend
on many other sensors where we take the view that if no one asked
for a while, we will pay the cost of a new power up and hence put the
sensor to sleep.

Hooking a single forced capture up to a hrtimer trigger would also
be somewhat similar to this but the interface to userspace is
rather more different so perhaps not the right way to think about it
here.

Jonathan


> 
> 
> Regards,
> Achim.


