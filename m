Return-Path: <linux-iio+bounces-21527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC855AFFF86
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 12:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD72F1C278A2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFD82DC34A;
	Thu, 10 Jul 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="b/Ge0SHU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7801245005
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144356; cv=none; b=t+G2vhnTT1xqV8vD+VvUBcIzzCG4ly97ei9/Dbq7h0wTU4it8jAzQyyQmc3QHt53ACNJ/xJy2NanynAJ2Bn+uk07Yq80Pshaa+MMqlGByD6Tk8v5iZuFRwTUp5bhM8wnJ2tDQttpkhnuxAo44YdopSdZMcvOQHwlp8kadmy7xFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144356; c=relaxed/simple;
	bh=ypeDCAgR2fUhnNql6LPGqQy5Ci+gLKPe50v7LDCd4eo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPLFTcozDJEnGF/T/CZWgCe8H5KwmtCiuEkbtPmt4WHt3G0u6aKYwoDkJTObTtJKdorzFpwZcWJqv1yMDbzt6saAOXcVTPz5fBRl8NcZQPbmr8YRUbJyfo9JdH1tFrUDXBUDetkfWhUL8QbWRunCN3701AahgYzvRUcbwdld3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=b/Ge0SHU; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752144349; x=1752403549;
	bh=ypeDCAgR2fUhnNql6LPGqQy5Ci+gLKPe50v7LDCd4eo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b/Ge0SHUd3cAMQuR+TE6+5qwtYJb0fhNAcAlBvemrLcBZNzF8jggwOrXUQYo7kNTb
	 NdFLNAc/oHioibxUGu506+hnqQZdZVo2Q2g/HCJ3buuqgQvT1ZyrUd0mlqhpUnCQSc
	 pJl4oVijX1VhJGfUM/WLhBfu2VJDNnK4gnwnpQz/rilgGJpg6G9+ICIO+WZsWvaON5
	 7SWtKohk60DvNuUUYUpeVOoEvHH9pKBHa/tUiVsQ2LFpYqD6wCExfIG+6wgQ7kQMHY
	 VcMQLqPafkdACZnk3KjQ7fVs0w47ovcXwyIFbfRcgXIL+RyHlOHbzfsqy4zD886OjO
	 NwvEU3QijkJ4g==
Date: Thu, 10 Jul 2025 10:45:43 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <p5aiunwdx7vcncsmamq3q7orffrfpmcjzwnrgn2vfczs3y26ak@jxgbwf3bduat>
In-Reply-To: <aG-DGEpZOHqFoIY3@smile.fi.intel.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com> <20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com> <aG-DGEpZOHqFoIY3@smile.fi.intel.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 08b16e312e7406c43c80f427fe1d79d499fc86c8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, Jul 10, 2025 at 12:08:40PM +0100, Andy Shevchenko wrote:
> On Wed, Jul 09, 2025 at 02:35:12PM +0200, Sean Nyekjaer wrote:
> > Remove unnecessary pm_runtime_get_noresume() and pm_runtime_put()
> > calls during probe. These are not required when the device is marked
> > active via pm_runtime_set_active() before enabling pm_runtime with
> > pm_runtime_enable().
>=20
> Hmm... What will happen if the autosuspend triggers just before going out=
 from
> the probe when this change is applied?

Nothing, as pm_runtime is enabled as the last step in probe.

>=20
> > Also remove the redundant pm_runtime_put_sync() call from the cleanup
> > path, since the core is not incrementing the usage count beforehand.
>=20
> This is interesting. Have anybody actually tried to see refcount WARN abo=
ut this?
>=20
> > This simplifies the PM setup and avoids manipulating the usage counter
> > unnecessarily.
>=20
> > Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42=
600 driver")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>=20
> This should be the first, or close to the beginning of the series, patch.

Ok, but help me understand why?

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20

Thanks for the review :)

/Sean


