Return-Path: <linux-iio+bounces-14168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547AA0A888
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BE1166A74
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE7A1AAE0B;
	Sun, 12 Jan 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuPtFkkw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047314D2A2;
	Sun, 12 Jan 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681446; cv=none; b=HTMLkgeqTenMCiDm4Udp5uRkWc//UCsxVB3cuU2Q/UX4oKh3Eq/uOs66FvO5v5/AmV3prahZLzBPZ9OQEUPcSNNuU+dvh6kou+kx0XCZJiX3G0VL+T1bmBV87PxSxA00F2R0bkGJuH3XzjNi3xfLvJP2KUuFZzdYj1YE1zfzzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681446; c=relaxed/simple;
	bh=h/77Zz3CZhftQQuCMeg6ITXk7HEYEDJn28+0rmIDero=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo6RrRMEy2EQEKb0bJ5h9XHSKFifkKSpQODoRoHIVYaSGoS3jccqwNkw4u5zcZnu5z9Q7GDoab8SaONXN9nJfyl76dGcgF/83o7T2A5Q0flJ1ghzZrHw1int5qlsMF/zBv+eWQrr2/4bxUIB19+xE++DQ7FjMPIEKCGNSKCmORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuPtFkkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15188C4CEDF;
	Sun, 12 Jan 2025 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736681445;
	bh=h/77Zz3CZhftQQuCMeg6ITXk7HEYEDJn28+0rmIDero=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kuPtFkkwS5YoJJTMlQfI0fikpT6P3mV6MpG5v5HACfHKrJkzZCc3XIlbyGWwTA5L6
	 uIl4xT/P/X8OHUNWbyJQa+TnrjLW5RKv0QqN/ZwCjqZEI4Ur8FULFH35kFbcH6LQFc
	 d+gfITAH9JMyVzh03GxMhNKjDGQrqZUNHjodN6u6gZsZy2luobC6ZLz3HelgoNZtu1
	 zHqsF+M7wXYGIzX5iDc3r9kjvg3rK9lCy6fd1HAdZ/lQ+qLW+ediXErEAZalzoRI3G
	 50F3I/BA/vZ5B/0uiXk3GnyYfzu7gfYGdwvNYmcjklI0/lm7ypxA6qXFJduFKXM7NV
	 vQkl4n3siP4Cw==
Date: Sun, 12 Jan 2025 11:30:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iio: adc: ad7380: do not use
 iio_device_claim_direct_scoped anymore
Message-ID: <20250112113036.50f1e728@jic23-huawei>
In-Reply-To: <e3ef72e6-4f39-488f-9aaa-2bbc91e43bc4@baylibre.com>
References: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
	<20250107-ad7380-add-alert-support-v3-1-bce10afd656b@baylibre.com>
	<e3ef72e6-4f39-488f-9aaa-2bbc91e43bc4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 10:48:18 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/7/25 2:48 AM, Julien Stephan wrote:
> > Conditionnal scoped handlers are turning out to be a real pain:
> > readability issues, compiler and linker handling issues among others so
> > rollback and remove the scoped version of iio_dvice_claim_direct_mode.
> > 
> > To impove code readability factorize code to set oversampling ratio.
> > 
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---  
> 
> FYI, might want to hold off on this until we see how [1] ends up.
> 
> [1]: https://lore.kernel.org/linux-iio/20250105172613.1204781-1-jic23@kernel.org/

I'm fine with not blocking on that series.  This will just end up as one
more to convert if we go that way alongside a lot of others!

Jonathan




