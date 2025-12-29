Return-Path: <linux-iio+bounces-27413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56421CE6E7E
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 14:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D2333007CBF
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 13:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93914217F31;
	Mon, 29 Dec 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQhrozgZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A24F881;
	Mon, 29 Dec 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016211; cv=none; b=LDas0gxjoih+xsomLjrgevOOzNBRgP+gc2H5Tb4z7l/f10vACjKSp+Yr6yqJzJrP9AzxXqKNkpHF9XMXT9bnMTHOjAY+w72OsTdDG8oCMQ3u2PA8iohtt/WYr5HR8qTDLlvZ3gtolLtqnKs/N9uGU9yvvpwXVECqxBCZ51jFO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016211; c=relaxed/simple;
	bh=JkD+7Su0h2sVFPy6YBrQzFZfhqvokIvRVoNcw/yYbk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spHUXQDE05vTi5N8O3yPmRxSXh/FIceLos8ZRy3P3pNAwllMP+otfUUA7aJmoSWk7A/O1q0nbZqjYwLg3bKDYLJQKqxkwweHkL+2MbX1dE906HbgzWh5xBdD5smKz62bUQl6GzKBajOiQZ2BJUHbE9MqaPZ7L423zauBH0LJgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQhrozgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F12C4CEF7;
	Mon, 29 Dec 2025 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767016210;
	bh=JkD+7Su0h2sVFPy6YBrQzFZfhqvokIvRVoNcw/yYbk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQhrozgZ3YlCEnV4LQ0e5FjvV7pwfEed0XenxxIsYtqTvg0aWEc1Ubj5VMDEFUJCm
	 uaGAVrMSD1Q+ruWEev6a2ke9reO3YhPOFrFTPP6BJW0Pw1FaG0DYsWT0CxCuVCigqe
	 Bo95h+sQsZemnhs2b9AsBV80kkibUBHFFF/2y240GItUj391+rPq/IN2X07beBYE87
	 Kd7GKJ/wXyBS9M1F5C62GR9LRfBf8FWSdFnQVARJSLDUoAUZaVoTEgjqU854OZde3O
	 5FOVd74V9w6ImzSmbNWTERx6VOy48/jQFyZ7zwE+H5ruRBRDoMCjPtWpUcv+k4WcwF
	 EJ56w5Y67vcUw==
From: William Breathitt Gray <wbg@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: William Breathitt Gray <wbg@kernel.org>,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] counter: Add STM based counter
Date: Mon, 29 Dec 2025 22:50:01 +0900
Message-ID: <20251229135006.10133-1-wbg@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <ba28863a-a5fe-498f-92a0-d71c356e7189@linaro.org>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3077; i=wbg@kernel.org; h=from:subject; bh=JkD+7Su0h2sVFPy6YBrQzFZfhqvokIvRVoNcw/yYbk8=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJlBbXcnzuU387vWVz/VXHTJ8j6JpXukGCJVSuo+SAf8j Mq23lDRUcrCIMbFICumyNJrfvbug0uqGj9ezN8GM4eVCWQIAxenAEwk2pfhv6P1X9Puk1suqrwI nqqbbOwaoqCqbS/6+/fJ3qV3k/fJWjIynGJb5r18e3hWYPq//6tWPOx0a227dWFvraX3vdlmXZI V/AA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sun, Dec 28, 2025 at 06:37:22PM +0100, Daniel Lezcano wrote:
> 
> Hi William,
> 
> On 12/28/25 07:52, William Breathitt Gray wrote:
> > On Wed, Dec 17, 2025 at 08:49:57AM +0100, Daniel Lezcano wrote:
> >> The NXP S32G2 automotive platform integrates four Cortex-A53 cores and
> >> three Cortex-M7 cores, along with a large number of timers and
> >> counters. These hardware blocks can be used as clocksources or
> >> clockevents, or as timestamp counters shared across the various
> >> subsystems running alongside the Linux kernel, such as firmware
> >> components. Their actual usage depends on the overall platform
> >> software design.
> >>
> >> In a Linux-based system, the kernel controls the counter, which is a
> >> read-only shared resource for the other subsystems. One of its primary
> >> purposes is to act as a common timestamp source for messages or
> >> traces, allowing correlation of events occurring in different
> >> operating system contexts.
> >>
> >> These changes introduce a basic counter driver that can start, stop,
> >> and reset the counter. It also handles overflow accounting and
> >> configures the prescaler value.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > Hi Daniel,
> >
> > It sounds like you're trying to implement a clock for timestamping.
> 
> Well no, it is a counter which is used for timestamping. It is an
> automotive design.

I'm sorry, I misunderstood your device earlier. We'll continue with the
Counter driver implementation in that case.

> > Regardless, if you do pursue a Counter driver you'll need to follow the
> > Generic Counter paradigm[^1] and define at least three core components:
> > a Signal, a Synapse, and a Count. Resetting the Count is typically
> > implemented by defining a struct counter_ops counter_write()

Oops, I should have written count_write() there; when a user sets the
Count back to 0, it can be considered a reset.

> > callback[^2], while overflows are typically implemented by pushing
> > COUNTER_EVENT_OVERFLOW Counter events[^3] that can be watched by
> > userspace.
> 
> Yes, I think the Generic counter makes sense here for the goal to be
> achieved. Thanks for the pointers, I'll see how the counter fits with
> the paradigm.
> 
>    -- Daniel

I suspect you'll define a Signal after the peripheral clock input to the
counter device block; if it's possible to read the instataneous level of
this signal, define a signal_read() callback for it.

Your Synapse action is dependent on the edge sensitivity (i.e. rising,
falling, or both edges) of your counter device; e.g. a rising edge
configuration corresponds to a COUNTER_SYNAPSE_ACTION_RISING_EDGE action
in action_read(). If your counter only ever increases, then you can
report a COUNTER_FUNCTION_INCREASE function in the function_read()
callback.

Finally, the component names should be intuitive so give the Count a
more intuitive name than "stm-cnt". The same idea applies to the name
you give the Signal.

William Breathitt Gray

