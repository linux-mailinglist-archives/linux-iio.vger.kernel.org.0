Return-Path: <linux-iio+bounces-18403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BD7A94F94
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C89D3B36ED
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CAB26139C;
	Mon, 21 Apr 2025 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMhSdq+J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5725FA0A;
	Mon, 21 Apr 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232742; cv=none; b=pRUkcwONSnzJNM+UbjkXx4ETutGWofQ1gaKWDQGwPx7IDKmyONaCiz25EM3k14yK5Zf6a6eeNqgoVHtQC8OlUZ+OJEL4p3/eQG1lP0GeV8ipOgBVtK3KRnKo2dPr6r370egitMsmCjWYD6+uJ/AUrX9k8CEAzFcHLBZK7GSvncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232742; c=relaxed/simple;
	bh=z0L2+rxrsPjAA6VOG/hMcSQpoDJGinSjBTxVV4vYrKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VanLJ3gQyFHosTFsy+XhBR76HyEHdkF3m+yB161JRsfWUo6TQHzeQdkE+qZhmiTOY+V6BBrNs+Obwg4fO9uhwnsUX2dxVVmcN22uAji7W+WWCfnTpIOESY4JC6g1Ftsy8eNhwHm/pNF94IMb32+BfCqyAKN6L7rooRXvy18hEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMhSdq+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75CCC4CEE4;
	Mon, 21 Apr 2025 10:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745232741;
	bh=z0L2+rxrsPjAA6VOG/hMcSQpoDJGinSjBTxVV4vYrKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mMhSdq+J4t2fCqqcR836n/U/5TBqzGmIxcpKBHahsoS9tThTeP7cjy1bn/uwABSIJ
	 8xO8G1jwe64V4dnWHIKi61OiD8L8UyST8Pu+fZmgI+GPmdDSZumyHxewjq+YS7en+4
	 jdJuoVUmuZsg57O7dbhVGic1EgcJnhWVB54ow9Jvuj1AsPTH+sijf957lxytNCNoy6
	 CNtyAB/WACxlxuuBOVtkz8Z23w8PPPvdteIkI848B0kp37bWGjX/Z1Fk+XtYWko/2/
	 f7FiX1FDb+T5Cb+ZLmGBR8Hu+oFsFWJyjW+a43lASFz1fHvyuVocnfLWKnshhOrOmo
	 pcfZUSui/lp6w==
Date: Mon, 21 Apr 2025 11:52:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Robert Budai <robert.budai@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andreas Klinger
 <ak@it-klinger.de>, Petre Rodan <petre.rodan@subdimension.ro>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: more timestamp alignment
Message-ID: <20250421115214.5720a8cc@jic23-huawei>
In-Reply-To: <20250418-iio-more-timestamp-alignment-v2-0-d6a5d2b1c9fe@baylibre.com>
References: <20250418-iio-more-timestamp-alignment-v2-0-d6a5d2b1c9fe@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 11:17:12 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Wile reviewing [1], I noticed a few more cases where we can use
> aligned_s64 or need __aligned(8) on data structures used with
> iio_push_to_buffers_with_timestamp().
> 
> [1]: https://lore.kernel.org/linux-iio/20250413103443.2420727-1-jic23@kernel.org/
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Dropped patches that were already applied.
> - Added Fixes tags.
> - Dropped the (insufficient) bmc150-accel fix that snuck in the adis16550 patch.
> - Expand mprls0025pa patch to remove struct mpr_chan.
> - Link to v1: https://lore.kernel.org/r/20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com
> 
> ---
> David Lechner (2):
>       iio: imu: adis16550: align buffers for timestamp
>       iio: pressure: mprls0025pa: use aligned_s64 for timestamp
> 
>  drivers/iio/imu/adis16550.c        |  2 +-
>  drivers/iio/pressure/mprls0025pa.h | 17 ++++++-----------
>  2 files changed, 7 insertions(+), 12 deletions(-)
> ---
> base-commit: 52d349884738c346961e153f195f4c7fe186fcf4
> change-id: 20250416-iio-more-timestamp-alignment-6c6c6a87ebda
> 
> Best regards,


