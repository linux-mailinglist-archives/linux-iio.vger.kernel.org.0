Return-Path: <linux-iio+bounces-27881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9CD38630
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CEE53009FC3
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A738345736;
	Fri, 16 Jan 2026 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFF1sbPs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8882797B5;
	Fri, 16 Jan 2026 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592749; cv=none; b=cG77myCTXfIr25NWRLGYsdNZB2TzNUGMNbcVwqJ9p0b0+MJ/NS5JXKDA4FmgwhdTS911jj7Y2917KJU7c4KbfS3o/ALzkwK4FlpjUHO1VzU0a6VZkCvOMsWbXAS9s9d2EED4jJCxEaPwZVEyzH4KvOj4fwrXGdiQ9IkJUtBWl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592749; c=relaxed/simple;
	bh=HzBeIWpbNJTxJNtNdFP+BhmVhwxyi4TFRrSwcVn2nr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K55YkwKQvzFeCAxnkAxJBKgymuEO1hCXlPKIRSvMybMJvQSaOmXDvkqh2nPppfJ1CWLz2qQILjluqvtYeLUWtYo8+YVhnLlfjkz0sQhA4xM3+Zu4+z8LV8LIxQxwOrKpp1CYQZHOUTJOYMqVu5R5DX3ximStBagW2a363G+8rzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFF1sbPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ACBC116C6;
	Fri, 16 Jan 2026 19:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768592748;
	bh=HzBeIWpbNJTxJNtNdFP+BhmVhwxyi4TFRrSwcVn2nr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KFF1sbPs9/WiKRQcbg6w7o26rk3w+PxFwQwCeWyME3bwDj2HpSffpCcsAglRlV9kA
	 RZ7IqZM9DIwOWq0GVmYRlV237yt1Az9/cZYpuagvZSfcTeXUMFDpHn4EbeXsrm0bpQ
	 bRLNXUnZJSyL13qkQPcOu7OelxultiRoR95ODDG4uup3+o27LCX5yQRUb4PaSwwbfh
	 Gp0xWT3uOkFSEJsd3B2KTM9cVbl+gNV7xsCY25dMQpXZZN2Zk9i3XM4q1ohDYZnmIz
	 aFRaLCuVpQoXyKRSppJPv3vgepiu11ORiSmgt53ncGdl+D50ZPhmQaUkxBlkQsveU7
	 BPIBv2ydkNvhw==
Date: Fri, 16 Jan 2026 19:45:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jianping Shen <Jianping.Shen@de.bosch.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: imu: smi330: Convert to common
 field_{get,prep}() helpers
Message-ID: <20260116194540.4ec46d2d@jic23-huawei>
In-Reply-To: <275b806d25a57cb538b3db2a7490e1570175f6a1.1768486991.git.geert+renesas@glider.be>
References: <275b806d25a57cb538b3db2a7490e1570175f6a1.1768486991.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 15:24:16 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Drop the driver-specific smi330_field_get() and smi330_field_prep()
> macros, in favor of the globally available variants from
> <linux/bitfield.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Hi Geert

Thanks for coming back to this.

Applied to the testing branch of iio.git. Once the bots are happy with
that I'll push it out as togreg for linux-next to pick up.

Jonathan

