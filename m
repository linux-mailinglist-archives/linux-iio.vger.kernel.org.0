Return-Path: <linux-iio+bounces-27848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD69D2C3A2
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 06:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E286F305DD90
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 05:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27453347FDE;
	Fri, 16 Jan 2026 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9iCOQm8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9933A03A;
	Fri, 16 Jan 2026 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768543039; cv=none; b=PWZVvj5lEAlEUsaMOnChJ6pxXOWuuHG+b3m70e4vXAKn5qNR+IWACRwptJjz0LKAIkZd0xskmr5Cbuk3WUrqyT1Y3WoqMqrMQPNXVdkyulaMbT1ZO4q1CZJcbUllFFqigL14Wi4zU0b/o/9tCbvu23A0IzZtbeDYPHqcPwNrhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768543039; c=relaxed/simple;
	bh=tdTm5h85kuImW7HEYxS2VNH5d0DM2pD9181VKz7CDts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nN+zva9tzB6yQPnk8zYz2v2T19Z0scaCRme3wAJIQFGSDdRgsddQpyQ6ho8uVrqixE76XqL/Jt16TpqQCZMuVEdpen5fwYnlJ8k7OJ7kfONFVfkLAMUc4ngk/4sEqJBm7quJFsIWl7kFR2hba3vEFZptP8hCKryjNCEvdfWWjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9iCOQm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E71C19421;
	Fri, 16 Jan 2026 05:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768543039;
	bh=tdTm5h85kuImW7HEYxS2VNH5d0DM2pD9181VKz7CDts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9iCOQm8XmgUiV79NCUN1zfxltsn07pOfqjsAL11YC1LH8S2X9UkrsQhN5huSchYa
	 zxlFiLJK+fwJBqOeJH+a2YPxS/MHH2SJu15jII8adU7n7l9Re/d/JZGciBX5sP6I4J
	 t9i1/LlIXFZI2zt+o9Z1iiXZkm/xnHg/kNVxvfn5giW0Oodeswb/HjWcXZmB4MXwqj
	 duMhOswA5vx9p41nvZBpopzNkHLPvRpTk6OTvPwYy7JdzGl/fM5FkGv19GBo1+BFkv
	 g208BrrN27iLpSlH19pVJ0NNZyU5EjnySyc9Awc/bGeCpUj/VJUUW7JxEZHlE8fUJA
	 llp1Z9OM/nZFQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Frank.li@nxp.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 3/3] counter: Add STM based counter
Date: Fri, 16 Jan 2026 14:57:06 +0900
Message-ID: <20260116055708.428641-1-wbg@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113165220.1599038-4-daniel.lezcano@linaro.org>
References: <20260113165220.1599038-4-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5000; i=wbg@kernel.org; h=from:subject; bh=tdTm5h85kuImW7HEYxS2VNH5d0DM2pD9181VKz7CDts=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJmZl95Kf5xlUhWq6Wa/29DwtGlx5aN5FyYvMD70y6QrN kLiyD3jjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAimpYM/9S2fdpd6nVvXtvy wqvHVzCozPtTKO7Z+fXBdp+2bbpzUg4wMjztuFXZK7tJY5WJ9f6qbRzX9pzt52E031I761Rk16E 3XxkA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Tue, Jan 13, 2026 at 05:52:20PM +0100, Daniel Lezcano wrote:
> The NXP S32G2 automotive platform integrates four Cortex-A53 cores and
> three Cortex-M7 cores, along with a large number of timers and
> counters. These hardware blocks can be used as clocksources or
> clockevents, or as timestamp counters shared across the various
> subsystems running alongside the Linux kernel, such as firmware
> components. Their actual usage depends on the overall platform
> software design.
> 
> In a Linux-based system, the kernel controls the counter, which is a
> read-only shared resource for the other subsystems. One of its primary
> purposes is to act as a common timestamp source for messages or
> traces, allowing correlation of events occurring in different
> operating system contexts.
> 
> These changes introduce a basic counter driver that can start, stop,
> and reset the counter. It also handles overflow accounting and
> configures the prescaler value.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Daniel,

A few of the features in this driver are implemented using somewhat of
anti-patterns in the Generic Counter paradigm. In particular, I believe
the overflow and accumulation features would be best implemented using
the Counter events and watches idioms rather than in the Counter
attributes. I'll explain further inline below.

> +static void nxp_stm_cnt_cfg_overflow(struct nxp_stm_cnt *stm_cnt)
> +{
> +	/*
> +	 * The STM does not have a dedicated interrupt when the
> +	 * counter wraps. We need to use the comparator to check if it
> +	 * wrapped or not.
> +	 */
> +	writel(0, STM_CMP0(stm_cnt->base));
> +}

So to implement overflows, you're currently setting up a compare against
0 to fire off interrupts.

The problem, besides the added complexity in your driver, is that users
now lose control over the comparator for other threshold checks. A
better approach is to define a COUNTER_COMP_COMPARE() attribute for this
comparator which users can set to the value they desire, and push
COUNTER_EVENT_THRESHOLD on the interrupts. Userspace can then watch for
these COUNTER_EVENT_THRESHOLD events and use them to detect overflows,
or for any other general purpose now that they can control the
particular threshold value.

> +static irqreturn_t nxp_stm_cnt_irq(int irq, void *dev_id)
> +{
> +	struct counter_device *counter = dev_id;
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	nxp_stm_cnt_irq_ack(stm_cnt);
> +
> +	atomic_inc(&stm_cnt->nr_wraps);
> +
> +	counter_push_event(counter, COUNTER_EVENT_OVERFLOW, 0);

Remove nr_wraps and push COUNTER_EVENT_THRESHOLD here instead if you
implement the comparator design I suggested above.

> +static struct counter_comp stm_cnt_count_ext[] = {
> +	COUNTER_COMP_COUNT_U8("prescaler", nxp_stm_cnt_prescaler_read, nxp_stm_cnt_prescaler_write),
> +	COUNTER_COMP_ENABLE(nxp_stm_cnt_count_enable_read, nxp_stm_cnt_count_enable_write),

Add COUNTER_COMP_COMPARE() here for your Counter's comparator.

> +static int nxp_stm_cnt_count_read(struct counter_device *dev,
> +				  struct counter_count *count, u64 *val)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(dev);
> +	u32 w1, w2, cnt;
> +
> +	do {
> +		w1 = atomic_read(&stm_cnt->nr_wraps);
> +		cnt = nxp_stm_cnt_get_counter(stm_cnt);
> +		w2 = atomic_read(&stm_cnt->nr_wraps);
> +	} while (w1 != w2);
> +
> +	*val = ((u64)w1 << 32) | cnt;

Just report the raw counter value back directly. If a user wants to
count wraparounds and accumulate the counter, they can do so by setting
a Counter watch in userspace for the COUNTER_EVENT_THRESHOLD event.
Userspace can then keep track of the nr_wraps and perform the
accumulation calculation with the current count value.

> +static int nxp_stm_cnt_watch_validate(struct counter_device *counter,
> +				      const struct counter_watch *watch)
> +{
> +	switch (watch->event) {
> +	case COUNTER_EVENT_OVERFLOW:

This becomes COUNTER_EVENT_THRESHOLD.

> +static const struct counter_ops nxp_stm_cnt_counter_ops = {
> +	.action_read = nxp_stm_cnt_action_read,
> +	.count_read  = nxp_stm_cnt_count_read,
> +	.count_write = nxp_stm_cnt_count_write,
> +	.function_read = nxp_stm_cnt_function_read,
> +	.watch_validate = nxp_stm_cnt_watch_validate,
> +};
> +
> +static struct counter_signal nxp_stm_cnt_signals[] = {
> +	{
> +		.id = 0,
> +		.name = "Counter wrap signal",

Surely this can't be how the signal is described in the datasheet (is
it?). Although you do not have to match the datasheet exactly, the
description should make it obvious which Signal is the source trigger
for the Count state changes. I haven't read the manual for this device,
but I suspect to this signal is named after some sort of clock
oscillator if it's for a timer module; this could be named "System Timer
Module Clock" if the signal is identified simply as that in the manual.

William Breathitt Gray

