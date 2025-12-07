Return-Path: <linux-iio+bounces-26887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D12CAB69C
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD1F7301C97B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24DD26FA60;
	Sun,  7 Dec 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZfAK4EK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886025E469;
	Sun,  7 Dec 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765121274; cv=none; b=lfgfvqmUzTtVd8SjH5R/4hA0bqXDtyAiZJsHBRL5Vr4qNJ+gfPIfbLu+xDLEmZkumOMhOMXMp8gjZruwGrjV7taBguYhIXz4h+WW3RAFmHd9DIJrk0+2q2cFd5imNb7tsr0FOc1xMBsn8tzWaFbXwzxMTDTCxdVeyW4JY82FNiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765121274; c=relaxed/simple;
	bh=QutVBuzh2z43sHo1wtva6NARqk1HqcJkUe0SJ2WRSKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvGwIP02jm7MzPnYcYuqhQImWG5InLT6r3Kc4AMsNRYK63RqzghoJBXcvaTkNj3VFZMiK3TaK6/ExB8JNcORWDRNS4z8eOShXOlr1tRsJdD4nzb/Qj7Vy9XM6VOFFnjgXr3RS/U49LVMokJXLUQqn0CBUiDTXeBAF4R1tuEg5ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZfAK4EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770FFC4CEFB;
	Sun,  7 Dec 2025 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765121273;
	bh=QutVBuzh2z43sHo1wtva6NARqk1HqcJkUe0SJ2WRSKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZfAK4EKjqJGPPXyy+WAPpqzETaIHWLRiXRDs+HqJJARN7eiSLKUbfWUjJ0ANybGI
	 i9Azz85wZVmfxgPacIVkn0EwhFzk3NkoWHDpRs55fhzFqZOh5NyWJIbgqE8O5AtDIh
	 e+wZNpt7YeQe4nrE+KoPgoglmOjnT/KvTSfHo+Fj3r12x2OWQYr+ekXVpEyyz5XvaL
	 fnHhCwewU5+XcsuynL6WfimjBx9J/TTNURYXO7X7wak2jzRT9tzuWaqgXETQnL+m7Q
	 q870Q1ZYkX1ptLawCcYQhp/9VsBPgWQzVjGotNrcqRmSgfCNQgJ8wb6nqUg50eoH40
	 iiLSg6SK1AYwQ==
Date: Sun, 7 Dec 2025 15:27:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 4/9] iio: imu: st_lsm6dsx: rework code to check for
 enabled events
Message-ID: <20251207152744.5ec17be4@jic23-huawei>
In-Reply-To: <20251201100018.426749-5-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
	<20251201100018.426749-5-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 11:00:13 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> The enable_event field in struct st_lsm6dsx_hw does not lend itself well to
> handling multiple event sources, so it will have to be modified to add
> support for more event sources. As a preparatory step, remove references to
> this field from code that does not deal with event management; rework the
> st_lsm6dsx_check_events() function so that it returns whether any events
> are currently enabled on a given sensor.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Applied.

Note that if anyone else has more comments or wants to add tags
I'm fine rebasing as appropriate until sometime after rc1 when
I push out as togreg and linux-next picks it up.

Thanks,

Jonathan

