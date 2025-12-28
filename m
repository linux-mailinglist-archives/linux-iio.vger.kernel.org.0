Return-Path: <linux-iio+bounces-27399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEABCE499C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 07:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B04D3004F09
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 06:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4BF27A904;
	Sun, 28 Dec 2025 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2L+Z5OH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5891259CB6;
	Sun, 28 Dec 2025 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766904768; cv=none; b=GTAFe+Ld4RUPqT71yL8Qs89Iw0+nDGt+pBtsoBhP6AHRDfV2eTqekCrwS5CqHiiD0P0U6TMcw7KLsiLIxY8DQnBe+SkZCckURpstZ+Ru6Iq5dRGsHUfVyJvACTPSubp3HSlRkPbPSVocegjL7blLjwtJr2UGthFzDTa7AiKV0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766904768; c=relaxed/simple;
	bh=uXXoCbWj+ft3G+bbeyfRGBLWRRFRoHtxxL0vn/VevBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bglBtmF1sL4asyBPoNR5sB/m9CwDi38oulZlaKh6S2OeHWK19rtfHcIYCx4hYIQCyqJ9Yo+6mJW1vnJanl3em37mHoNrnjFE6pgOz3lc9DlYWcJeMkES7W30hDF2zNYPaAN1QO/6Gy+/tdeipyB2aUioD3hX8b4bcE6bd1oXwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2L+Z5OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436C6C4CEFB;
	Sun, 28 Dec 2025 06:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766904767;
	bh=uXXoCbWj+ft3G+bbeyfRGBLWRRFRoHtxxL0vn/VevBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2L+Z5OHw3Hd1gGt0E756UjXsqxG8RhwILE1aNPwgIQXC0rK6KeMfUyQmktUja8os
	 bbjyLS3qPSL2ZDi9DkY7SHSNC2x/P76EJRw68nWV5d8rKpqTZ/FxSGWYLsHkq49Hkm
	 LNjIQHEv1gEcMRy6ftiW1g+4ZlGVnRzqj0Imem4WYNL9AJNAMEylRD5WIr2OgVV7nN
	 xPb0W697Zq0lHCMYmgvsp9e74pEDcBrdkHVFRuKK0ZBl+zEgp08u2cZgXyulSSsTzZ
	 Z338+nSqrne2lBAvIHTtuF+JW2Ix+85u99QmaY+bknGr3tyTOX/BiTC3B1n2ljkEd0
	 HO6vtHLspJQ6w==
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
Date: Sun, 28 Dec 2025 15:52:40 +0900
Message-ID: <20251228065241.21144-1-wbg@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217075000.2592966-4-daniel.lezcano@linaro.org>
References: <20251217075000.2592966-4-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2114; i=wbg@kernel.org; h=from:subject; bh=uXXoCbWj+ft3G+bbeyfRGBLWRRFRoHtxxL0vn/VevBo=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJkBl5eV3nC/Oe0pY83T8hc6BcdPKfLm9+5mFD+035VV+ kJtXqRjRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRaB1Ghs1TzRb95zCbxpir seOwT8ghvW/5s1aLfzTbkFv5Y0VSUhHDP3uzJrP45bUXa/adLkhWex/S6BOXfnXF1lOSr0113Nf MYAcA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Wed, Dec 17, 2025 at 08:49:57AM +0100, Daniel Lezcano wrote:
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

It sounds like you're trying to implement a clock for timestamping.
Although the Generic Counter interface is flexible enough to shoehorn a
a clock into its representation, I don't believe it's the right
abstraction for this particular device. Perhaps reimplementing this
driver under the Linux common clock framework would be a better approach
to achieve what you want.

Regardless, if you do pursue a Counter driver you'll need to follow the
Generic Counter paradigm[^1] and define at least three core components:
a Signal, a Synapse, and a Count. Resetting the Count is typically
implemented by defining a struct counter_ops counter_write()
callback[^2], while overflows are typically implemented by pushing
COUNTER_EVENT_OVERFLOW Counter events[^3] that can be watched by
userspace.

William Breathitt Gray

[^1] https://docs.kernel.org/driver-api/generic-counter.html#paradigm
[^2] https://docs.kernel.org/driver-api/generic-counter.html#c.counter_ops
[^3] https://docs.kernel.org/driver-api/generic-counter.html#counter-events

