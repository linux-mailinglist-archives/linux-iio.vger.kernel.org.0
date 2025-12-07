Return-Path: <linux-iio+bounces-26892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E670CAB6C0
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C1E300A1E8
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD7E2EA172;
	Sun,  7 Dec 2025 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlwc4cmO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF9286400;
	Sun,  7 Dec 2025 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765122029; cv=none; b=b4H9C3qsntp6yO0Yfa9Iy7ThvjSKZ3tU6I4V+sBUvCTKRiCzx3+NDToMRfcFPSln11isyhHQ/rOuqD7doFG0+49wDeH7eCKosG4Lq5cCWA/HymMw2a5eSa1bhCkhZLhFpSzrUEyJYs0RVaqZn8mwWaproE2uZ9Ad4HtT4a6YfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765122029; c=relaxed/simple;
	bh=LfvJWDW6bFWHeol1iJVz4WEFQOfGEkU8CfL1SW1OPQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3JFgxvVXWKY1S2TBDHACwHx+SkDUS7YACJmrGyifGNTWOasMseEOCQe5lKb3FB7BnoUPKPVfuPBUAVFVNZjeP6IJxWxbVT4l1ghyeN4HTnvFotww2sh+ybF6BGVOXwMXlIuyt3JFXSfX9K9Kl0qtMPH+Rehq2a2R81W4EL55cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlwc4cmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE43C4CEFB;
	Sun,  7 Dec 2025 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765122029;
	bh=LfvJWDW6bFWHeol1iJVz4WEFQOfGEkU8CfL1SW1OPQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wlwc4cmOb5wRggvpZ40HiU/6Q7ND1Mu+QRYIUVSnvrPgiGNDXSvd8UAriy14ATbLQ
	 qrn7fEShW2/X7KYN9y5QAPnbjh0Fng+YrbIjv+Uh5kCOL+hPv4c+ZIIzY9Xk47wuE3
	 EKZaTC1/suUnBuoh6YbXP7w70qSWqao+QT7MWT9HWDc8l6Xuo666Hq0e8TJfzAPQlP
	 jvLb4je1EXhQJO9YK3ORGSPNF6oTEslW4bkwRMejtLv4vHV1lAs8Ce3bNoNnYlRDfR
	 1PrR7M6FrRyxUjR8U2tn17kAZxscUVfIydEldNLzXZYhu0WBuQ23/VeJxAZpr8KmHP
	 E2yAUrKa7ys4w==
Date: Sun, 7 Dec 2025 15:40:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 9/9] iio: imu: st_lsm6dsx: add tap event detection
Message-ID: <20251207154020.1e5e33c8@jic23-huawei>
In-Reply-To: <20251201100018.426749-10-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
	<20251201100018.426749-10-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 11:00:18 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> In order to allow sensors to advertise tap event capability and report tap
> events, define a new struct iio_event_spec array that includes a tap event
> spec, and a new struct iio_chan_spec array that references the new
> iio_event_spec array; for the LSM6DSV chip family, use the new
> iio_chan_spec array and define an event source for tap events.
> Tested on LSMDSV16X.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Nice series and thanks to those who did all the reviews!

Applied this one as well. Seems there was never a clash with patch 1
going via the other path.  Great as that makes it easier for me ;)

I have pushed this out as the testing branch of iio.git for now but
that will definitely be rebased.

Jonathan

