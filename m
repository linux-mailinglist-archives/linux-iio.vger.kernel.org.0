Return-Path: <linux-iio+bounces-27577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 522F9D0AC65
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 16:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7495230631A0
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF733126AD;
	Fri,  9 Jan 2026 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P1KQTjlq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06519E819;
	Fri,  9 Jan 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970849; cv=none; b=NsWMg02yUsB0huUNHTujYp0pY33OnLzSxcKZUtTx40o0fnZZ0CsDNqCy6huURjX6CPVEqo71IdfHcZrUHEA9aVelm+MNUcvDd0D6pjwbt7HQOSQ5M4Ga43GFYava/g+e2liwmdU+2+DUeh7tHNXWJwCnRFu4YsYq1Hm5aCBOakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970849; c=relaxed/simple;
	bh=A5cvUjWuKoPWYCf67kqiTRwO0yXNxtBMoRIw9QaeM2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtTsinUKV5Y3RcS3En+5/5kwSos4Q6j49OOebtg/BC2ClsBExH44JIeVtVBOGYVqbgZF6Ugw83BLiOGI4OUl9dkdrmHixSCtRurza0oHAEskvL3pNaXryFCYultYsQRf95EfCcoWz4Jq49716TA7chReoYPoQRrVnHArgxalogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=P1KQTjlq; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dnlMF5769z9tGQ;
	Fri,  9 Jan 2026 16:00:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767970841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yfgQ+ftmgHcqzgiVyjzZWkhsASWVxPhK/W9eqyBb/g=;
	b=P1KQTjlqHWrx6upibdTo37Yft3+Hawvzd+Hqdslroo0oJ/a7anF352i2JQk/pwvaEsRM9i
	v6tn4q6ujtPijTf7Kbbi6Aq68+8u0GzDe7Zuo9cfe0QuHCe498XNlBpQXr8KOn/TIFTpqU
	MMbpEnElxvsKHRa2+/1dhajchO328V7AjGTnlitVtlovFh5bv63L6zav4kpT/VKE9DVcAH
	aZuA0bQ/A8XdNKd64MIfTXMwXgc+MalZrV5IKPGs297WXQTk7bk7/DrH42ZTo8ExG/voia
	1OWEUduBNHHovY9KBbsxPRxk2Tl4lR6FgBdTgia230HN4K9xlXklAqRFujkrwA==
Message-ID: <e7d81db8-297c-4063-b663-448172805edd@mailbox.org>
Date: Fri, 9 Jan 2026 16:00:38 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Linus Walleij <linusw@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Peter Zijlstra
 <peterz@infradead.org>, Salvatore Bonaccorso <carnil@debian.org>,
 linux-kernel@vger.kernel.org
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
 <20250621181733.3cb6111e@jic23-huawei>
 <07d91b36-dbeb-42b3-8dd7-b0771df9b306@mailbox.org>
 <c42243fd-ffd2-4144-875e-b156133eb031@kernel.org>
 <7d327efe-94ce-458a-9394-eb5582f1c263@mailbox.org>
 <CAD++jL=OhmJmiq+osdZysfJ=U4mwKcuNVUY-RKq-xO_YZpeP3g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAD++jL=OhmJmiq+osdZysfJ=U4mwKcuNVUY-RKq-xO_YZpeP3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0fd5047fd4a39cb556f
X-MBO-RS-META: s3y19i7eda8qy38hws19akoxpgspcbn4

On 1/9/26 10:24 AM, Linus Walleij wrote:
> On Thu, Jan 8, 2026 at 10:55 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
> 
>> On 6/21/25 10:14 PM, Hans de Goede wrote:
>>
>> Hello Hans,
>>
>>> IIO has separate interfaces for exporting channels which can be polled by
>>> userspace and for triggers which is a more event driven interface.
>>>
>>> It should be possible to modify the driver to skip the trigger registration,
>>> while keeping the channels. E.g. iio-sensor-proxy will then automaticallt
>>> switch to polling in userspace.
>> I wonder if this got fixed by this commit in the meantime:
>>
>> 3aa385a9c75c ("iio: accel: bmc150: Fix irq assumption regression")
> 
> I think so.
> 
> It was causing a NULL dereference for me, so I had to fix it.
Thank you !

