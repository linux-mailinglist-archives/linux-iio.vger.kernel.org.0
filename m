Return-Path: <linux-iio+bounces-27282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA27CD43B5
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93E893004600
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5582303C9E;
	Sun, 21 Dec 2025 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GErmou5X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8BE221FB4;
	Sun, 21 Dec 2025 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766340818; cv=none; b=HkNyRIDYOViQc/cbwa0U7qhVocg2es/BwEOSsl4/k51Vv0v9ygEkY1Ayrp7qBSIzGARJ3PhDw2vMFxVQkv5yJfkwc21RVMC8862sTo3mzqm69W9o0JOHfsrefinmDacyUtwmSKt62PA0xEs2o0QzxxZwVeCUB5BLMSMxM9zJVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766340818; c=relaxed/simple;
	bh=bdpucyozByHL39OAqrcsoit1OC/IWGNE9z7SnH4SDUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdpRl1nZCGZssTKMTBwhbq4asLJDW8eJvkogT3iLVLS0oSHo0GdFWJI5MEe5dKWNUyTbogSAnHX9syPwN0YOW1O9wTksPN31laeYbL4heu4vjmuaw0ognLn/tHtCqFOgbMjBgL40GuhPyKop77NzBt8qUBc12iV6YK7vGKM0l2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GErmou5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D014C4CEFB;
	Sun, 21 Dec 2025 18:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766340818;
	bh=bdpucyozByHL39OAqrcsoit1OC/IWGNE9z7SnH4SDUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GErmou5X3rQ8svKquToDtCbzPLfjYyj9M0Yqa2pVo5oATv6Y1uWFmVtWaCwmw+hNs
	 tw1OyCw3JqOUKZcnkPLM81uRpfDAU9V/OpoSWjg0qUq9kyqFR3pabf/ZyM5C/plH2C
	 mDzl0cbAT8PgyOYme0WxvIeLAQC+IaqZik8DbkRZmqHFFht6bXWRpawdelimL3wWCU
	 W+Xro288Yj+u6aEXyPmQwew9H2OBSqFnxiKIVcNeEq2vhYeIj8tUbvH1x/1qTdngPj
	 sQqiMrS+VcqZk5Hit4RDx7af8ERoZ2fZqWVU0/MBbH+3LxPJk0ABUkvUNmjxXT1FOt
	 XjbhFS6hwQxjQ==
Date: Sun, 21 Dec 2025 18:13:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/14] iio: pressure: mprls0025pa: remove redundant
 mutex
Message-ID: <20251221181329.1fbc58d9@jic23-huawei>
In-Reply-To: <aUYpzXmxW-osEHPj@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
	<20251218-mprls_cleanup-v1-2-b36a170f1a5c@subdimension.ro>
	<aUYpzXmxW-osEHPj@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Dec 2025 01:45:01 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 12/18, Petre Rodan wrote:
> > Remove the redundant mutex since both i2c and spi transfer functions
> > provide their own locking mechanism.  
> I don't think that is enough to safely dismiss the mutex lock. There could be
> concurrent calls to mpr_read_pressure(). E.g., buffer is enabled and user issues
> a single-shot read. To avoid the potential concurrent read (without using the
> driver mutex), do iio_device_claim_direct() before calling mpr_read_pressure()
> in the IIO_CHAN_INFO_RAW case. 
> 
This is a little messier.

Direct claiming is about preventing transitions between
modes (buffered, polled)
It is an implementation quirk that it only allows one claimer of a mode
at a time. (It would be hard to change that now, as we'd likely expose
many corner cases in drivers, but still the meaning is not the same
as a lock).

If the locking is needed to protect bus access sequences that is a driver
specific thing that should be done with a driver specific lock.  So things
like RWM sequences should never rely on claiming direct mode to serialize
things.

Now, it is also possible that all the sequences only make sense if
we are not in buffered mode, in which case we should be claiming direct
mode as suggested by Marcelo. That is typically an 'as well' thing rather
than instead of a local lock. If it is all about preventing concurrency with
a sequence that only happens in buffered mode, then maybe claiming direct
mode to avoid that is enough.

Jonathan



 


