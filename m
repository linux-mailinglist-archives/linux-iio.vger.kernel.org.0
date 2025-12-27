Return-Path: <linux-iio+bounces-27358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 751CECDFDEE
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D91F30109B3
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB901684BE;
	Sat, 27 Dec 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ/2tVJr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08932A1AA;
	Sat, 27 Dec 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766846838; cv=none; b=iFLd1HMhGDbcr0W0ooi5uF7FTpktE/lQxPRsdbuTmLoyYzv7wo3EahMJn5+yQN1rXxE6Kjg4TdIOazuMeKHR+kpbGgb+bYm4jWy5uCQo0f7Wgk9BaqKP1DvOovOf0QNmjQGIYExUFMasDLbjTZhK3ly5+G6FYU5XwiQcbRZ1JKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766846838; c=relaxed/simple;
	bh=NUFiKMQl9mIiGaZn2iIaGx4fqwvU14eADKqt4otrwng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0wbPRu46j89NU7jHMbjzTkr9v83xa/q30F3RX+Rl85PGthiUlprhT+KPcnW5oknNcrTt9p8bftf6rGCqpNTyBYYVqNMuxDWWDYN80j5ffMZMAWLDYqvEe08buERASnXcURxHHih13jeYhPgVWiU1VrdAwipuDvmwvjyp7u9wJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ/2tVJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9A6C4CEF1;
	Sat, 27 Dec 2025 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766846838;
	bh=NUFiKMQl9mIiGaZn2iIaGx4fqwvU14eADKqt4otrwng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mZ/2tVJr7cVrfK/J113SXVQSjdFcqpIBs2mxGcmh/kd76Mlq7TM4sAeTWjv2hkdff
	 MZdk+tuMkt7SUuOZWQD1Ss7eMJ8Fn84Ky5mw3DtykN2ban0nN9nve5UkR/mvQ04NRe
	 4wxLVKmqmLzE6F9PjKfa7fzcY8yvPU0XijLcCV9OkHKBU9xDObT0HXh5WBH1SjXetO
	 WP366LV196YW4gmATq1ZUU7SvTP26Odqt3Hl35qf/VAsp+9ljoB/MudljgHzH2RleT
	 26Us9guuMfo4UvsBE08WREi4m6ktyZOOsWjvtohlqlcwrIgfMYHMRtvOAxZg4ttp2Y
	 ghf/DdArdRIWQ==
Date: Sat, 27 Dec 2025 14:47:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Benson
 Leung <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 3/7] iio: core: Match iio_device_claim_*() semantics
 and implementation
Message-ID: <20251227144707.1bebcf27@jic23-huawei>
In-Reply-To: <20251211-lock-impr-v2-3-6fb47bdaaf24@gmail.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
	<20251211-lock-impr-v2-3-6fb47bdaaf24@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Dec 2025 21:45:21 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Implement iio_device_claim_buffer_mode() fully inline with the use of
> __iio_dev_mode_lock(), which takes care of sparse annotations.
> 
> To completely match iio_device_claim_direct() semantics, we need to
> also change iio_device_claim_buffer_mode() return semantics to usual
> true/false conditional lock semantics.

I wasn't rushing to review this set because I want it to sit
a little longer than a typical series to get more eyes on it.
Anyhow, long enough for this version at least!

Whilst I find it hard to care strongly about out of tree drivers
and in place flip of the return logic seems a bit unfair on anyone
trying to keep those rebased on mainline!

So with that in mind, maybe we need to name it differently even
if we are getting rid of the old implementation all in one patch.

Given earlier discussion about this one being rather more tricky
to name than the claim_direct because claim_buffer sounds like
we are grabbing the buffer, I'm not sure on the best naming to have
here. iio_device_claim_buffer_m maybe?  Ugly though and
these are super rare so maybe this isn't a particularly major
concern.

Given I think the people maintaining most out of tree drivers
are Analog Devices maybe this is a question Nuno can answer
for us?


> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>



