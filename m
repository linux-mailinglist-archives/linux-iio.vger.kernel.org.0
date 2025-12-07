Return-Path: <linux-iio+bounces-26886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B50DCAB696
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96854301B4BD
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298EB276038;
	Sun,  7 Dec 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrtP7bKK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44B218845;
	Sun,  7 Dec 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765120989; cv=none; b=Cv4kLCxHCE4FWxyM0kA7hBWzU5vhBb7ggp7LhPEuR8cFRXjGK2uUJG3VAyZPUc3FE6ulguKVHBleJOJ6Kdy/5capunmWonSmDADDOJJ5cXG4iVJAldIyOUJ69iVk+PJBQ5n7XftZFisZmRpOPSSSJIqiLSlBtExXja03MKeewzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765120989; c=relaxed/simple;
	bh=q3dOoZ1cYtuIkfbc7FjLHwrKh2yOG37JhBl13bWpzSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFXJlPRPntcec6bGtZJh+MVIScoCzgIJ+42cBAodaR4FTDsYGv6ktGIUy9bhb6uExyJr+nPeEVxeofJq+k3bl1diivUIUIqnm9bB9L2kEigHdklQzbGwxoKkstIl3OcQFfU8CoGhQfhJ7YBkr8l642G/NAa1klI7vqwZW9KMUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrtP7bKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD726C4CEFB;
	Sun,  7 Dec 2025 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765120984;
	bh=q3dOoZ1cYtuIkfbc7FjLHwrKh2yOG37JhBl13bWpzSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VrtP7bKK6rnVUjXZmeCRhlEkHUpLjL4QJ1plXgC0g3y1iPnp0+E6WIIW+0Go5Af/G
	 cMlKFW8NPJmYjUZ0LAXgsrgsQ3+SrN/LKR4+erwBQSVxWqm5iUAGWYqsawPT1YLqMz
	 4JFpwQ3UMVPfP+WVWiKPwTtwQrMUh/bLRIkEead2OScHhwLRLSML2Qxt3lsru+fKJJ
	 824Ch00j8Zu9rO+r9bhjv/EwBOu2hSABysG7tQtygYcTMAIamHLeCgons2jDdMtHDv
	 8dhxAgNR9AyQzXmTiT5LjF0x8sndQlsWqwjDY77MIOnVPjBh5owUBIgmHsEuRBFug3
	 yCidgaMjAkTmg==
Date: Sun, 7 Dec 2025 15:22:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 3/9] iio: imu: st_lsm6dsx: move wakeup event enable
 mask to event_src
Message-ID: <20251207152256.1f432c62@jic23-huawei>
In-Reply-To: <20251201100018.426749-4-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
	<20251201100018.426749-4-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 11:00:12 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> The mask value being assigned to the irq1_func and irq2_func fields of the
> irq_config struct is specific to a single event source (i.e. the wakeup
> event), and as such it should be separate from the definition of the
> interrupt function registers, which cover multiple event sources.
> In preparation for adding support for more event types, change the
> irq1_func and irq2_func type from an {address, mask} pair to an address,
> and move the mask value to a new field of struct st_lsm6dsx_event_src. No
> functional changes.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied

Thanks,
Jonathan

