Return-Path: <linux-iio+bounces-12003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90E9C0E2F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 19:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642671F230A0
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947BF217449;
	Thu,  7 Nov 2024 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+ux3hif"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4A4215033;
	Thu,  7 Nov 2024 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005990; cv=none; b=KPelgTyUFQ24r0dY4v3KDRpNd30+j1CMaCtvJL6ORas1ezzRGqDaOdYgFK7FZJUS+A5Jq/Ml3xGccRqRqzDXWv0ZtQekrFQQLefghqcqIQ7HumGWzH7zxPfXJadCHD1w1GZVTbXjQWoGC2DLi4MO+tWEb+qFC4xZQvF3v0wP6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005990; c=relaxed/simple;
	bh=xEyQQ2L1KlNWDa9ssSbmTpB3kGYcExSn4bX8Ux0wkd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=km95SWrWSQ7QZJnapGf+1qlEgyOVFQOclMo0SURy185pDIGTW4CezN1AnZb69yxlpC+BRyTOglYaiviyWsZYd68hvK9MwLbE+/kSyJzd07JTBQ2evGoEzzfpX/auoKBKZhPxxvtqhCBpvTBc3u9vUzUeFHBNtxhupyulyO73BfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+ux3hif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66343C4CECC;
	Thu,  7 Nov 2024 18:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731005989;
	bh=xEyQQ2L1KlNWDa9ssSbmTpB3kGYcExSn4bX8Ux0wkd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q+ux3hifDj+FETz3M04QWAV0Xj5qiKpHxjIkTMxkTRG3zcXG2/yEPPOktwLSwyjOH
	 +TPTZpQpusCFNwX1Y3jjVFo0IZJeTfWjkhA8Y6XaTparA9bryJkuX9tmNlTV7ZIiXB
	 hJHQxyEfRfb47GdPV+fhY2BOqcfY0aJcLm8wqAUUj49Q+DM4JXeT3252rCRmEYX20Y
	 VoVCsFP9rgIT1AfqYA5cXC6X35KRTtAuNw4grda9wsSnzrCTlPhSnY21E9zbycKpxi
	 f49nCJhUkvthn2MagGVRVDvPNcEsbN29NK1tqiO+BrmIhypXXQy00UKbkhkIXZSM9x
	 1J9KGYA+W7QFw==
Date: Thu, 7 Nov 2024 18:59:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Harvey Yang <chenghaoyang@google.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: hid-sensors-prox: Add support for more
 channels
Message-ID: <20241107185941.629e3330@jic23-huawei>
In-Reply-To: <f7e474ae70e659a33174ff3571ee7d311e47c8d3.camel@linux.intel.com>
References: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
	<20241101153255.4d835495@jic23-huawei>
	<f7e474ae70e659a33174ff3571ee7d311e47c8d3.camel@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 06 Nov 2024 09:07:07 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Fri, 2024-11-01 at 15:32 +0000, Jonathan Cameron wrote:
> > On Fri, 01 Nov 2024 07:46:26 +0000
> > Ricardo Ribalda <ribalda@chromium.org> wrote:
> >  =20
> > > EgisVision 620 provides two additional channels:
> > > - proximity
> > > - attention
> > >=20
> > > Add support for them.
> > >=20
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org> =20
> > Looks good to me. I'll queue it up, but Jiri / Srinivas if either of
> > you have time
> > to take a look as well that would be great of course.
> >  =20
> Sorry for the delay. I was on vacation.
>=20
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
No problem. It ended up behind a merge commit that I don't really want
to redo, but there is a link to this thread for the extra tags.

Thanks,

Jonathan

>=20
> > I'll only push this out as testing for now to let 0-day take a look.
> >=20
> >  =20
> > > ---
> > > Changes in v3:
> > > - Make attention CHAN_INFO_PROCESSED.
> > > - Fix comment style.
> > > - Multiply attention by 100 to make it a percentage.
> > > - Link to v2:
> > > https://lore.kernel.org/r/20241028-hpd-v2-0-18f6e79154d7@chromium.org
> > >=20
> > > Changes in v2 (Thanks Jonathan):
> > > - Create new attention channel type.
> > > - Improve documentation for HID usages.
> > > - Link to v1:
> > > https://lore.kernel.org/r/20241024-hpd-v1-0-2a125882f1f8@chromium.org
> > >=20
> > > ---
> > > Ricardo Ribalda (5):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: hid-sensors: Add proximity and at=
tention IDs
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: hid-sensors-prox: Factor-in hid_s=
ensor_push_data
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: Add channel type for attention
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: hid-sensors-prox: Make proximity =
channel indexed
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: hid-sensor-prox: Add support for =
more channels
> > >=20
> > > =C2=A0Documentation/ABI/testing/sysfs-bus-iio |=C2=A0=C2=A0 8 ++
> > > =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/light/hid-sensor-prox.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
95 ++++++++++++++++++--
> > > ------------
> > > =C2=A0include/linux/hid-sensor-ids.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A0include/uapi/linux/iio/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0tools/iio/iio_event_monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A06 files changed, 122 insertions(+), 87 deletions(-)
> > > ---
> > > base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
> > > change-id: 20241023-hpd-edeb37f1ffc4
> > >=20
> > > Best regards, =20
> >  =20
>=20


