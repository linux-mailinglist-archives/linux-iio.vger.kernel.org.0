Return-Path: <linux-iio+bounces-11788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AEF9B9473
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90B728250A
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5781BB6B6;
	Fri,  1 Nov 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3SPYJEg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A722082C7E;
	Fri,  1 Nov 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475182; cv=none; b=cSdyxyAKy6BlGzyxBB8YH3RrFWTgg0NYDijmzOkH4QgyhI6lbIcI7UmuMAf9FEhS1xFBjxSGK1zRuoxzj5j1pR/GH4fVdJAsy03dsliMnBaDSTdmANsmJ2Dm+numr84aNToHgVCulhPtrpHQ+KQsBYUf8PhYe1GEjB0I7UOTY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475182; c=relaxed/simple;
	bh=ap9vfaIc7UJt+zz7HcnD4L60lhS/AaQ+8KbNeR3fmJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uD9Ch5ddw6hjzdezEiRUDfhQfM+H+fizE7IN3kbeWe9XVg1ZgCSkxwYxI8PtmvCs4XRn9iIqKpAxImxWedUAN7mMAxoEppM33uyN3xRq0OeDS4uJO/5wExzhTanxQtdy9n5j5eDaTKnaTHPGfCoC9kI7y6tqEhedC3D2JTkbM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3SPYJEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E77C4CECD;
	Fri,  1 Nov 2024 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730475182;
	bh=ap9vfaIc7UJt+zz7HcnD4L60lhS/AaQ+8KbNeR3fmJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D3SPYJEgkxTZwmG+RFAV76AkK//8wZ2FAHZfMa2zTI2hWXcbCFmFY0viio3AKkvxr
	 xrQcAvfe+QxXLsnJp3dcDj3mR8OLuGDatH6rnaT5UE9D57tr93vlj7GhjU/6+jkRpG
	 q7poRLnMM/8aD965BEeW11fLTEVJ4h/mQbRoL6Hvp+8Uw8Yw7QhUkYqK1U2fgc+mRj
	 Db6u2XJuzMCWaH4w3eedHsLeRx+bILO+rUG5HSiKmFpjsE6WwUfJsI4it8fRJXIinA
	 Om+cZbGWZL24oIb6SJQHoze+vgHzi/wa3Pyu1CtwOisC62YceY7yhHyB2yllzKuQ24
	 vno3GGIgZymdQ==
Date: Fri, 1 Nov 2024 15:32:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Harvey Yang <chenghaoyang@google.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: hid-sensors-prox: Add support for more
 channels
Message-ID: <20241101153255.4d835495@jic23-huawei>
In-Reply-To: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
References: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 Nov 2024 07:46:26 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> EgisVision 620 provides two additional channels:
> - proximity
> - attention
> 
> Add support for them.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Looks good to me. I'll queue it up, but Jiri / Srinivas if either of you have time
to take a look as well that would be great of course.

I'll only push this out as testing for now to let 0-day take a look.


> ---
> Changes in v3:
> - Make attention CHAN_INFO_PROCESSED.
> - Fix comment style.
> - Multiply attention by 100 to make it a percentage.
> - Link to v2: https://lore.kernel.org/r/20241028-hpd-v2-0-18f6e79154d7@chromium.org
> 
> Changes in v2 (Thanks Jonathan):
> - Create new attention channel type.
> - Improve documentation for HID usages.
> - Link to v1: https://lore.kernel.org/r/20241024-hpd-v1-0-2a125882f1f8@chromium.org
> 
> ---
> Ricardo Ribalda (5):
>       iio: hid-sensors: Add proximity and attention IDs
>       iio: hid-sensors-prox: Factor-in hid_sensor_push_data
>       iio: Add channel type for attention
>       iio: hid-sensors-prox: Make proximity channel indexed
>       iio: hid-sensor-prox: Add support for more channels
> 
>  Documentation/ABI/testing/sysfs-bus-iio |   8 ++
>  drivers/iio/industrialio-core.c         |   1 +
>  drivers/iio/light/hid-sensor-prox.c     | 195 ++++++++++++++++++--------------
>  include/linux/hid-sensor-ids.h          |   2 +
>  include/uapi/linux/iio/types.h          |   1 +
>  tools/iio/iio_event_monitor.c           |   2 +
>  6 files changed, 122 insertions(+), 87 deletions(-)
> ---
> base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
> change-id: 20241023-hpd-edeb37f1ffc4
> 
> Best regards,


