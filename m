Return-Path: <linux-iio+bounces-4957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E2C8C3195
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 15:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8B81F2174B
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E3251005;
	Sat, 11 May 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8BxQ1Ib"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FCC47A58
	for <linux-iio@vger.kernel.org>; Sat, 11 May 2024 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715433617; cv=none; b=TR6+ViwKqaNT338fm5gSMgqkzcFRzmo3/vuqk2+cjztH1S6CGoETHFTyNNrOYdMOpWXGsY0v+0bsQKWEH+2fohDBlLNWCGeiL9Qfa2MMnvBypRL1/s4nSmYuc16JQJFGaAF4SE+BFQ1+/uwFw6ksOHphVl1svHEe202XpObtmvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715433617; c=relaxed/simple;
	bh=KNyIk+8rZq+JNjFAaXmyGtUHLmbeSTz28burmqQIR5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9kwXABc+xW94/4fE1ilADhh/LUUSyklhmVODTbNlVch7YT6X6AV86kOyoeMi9QmH3RUgFl5mRvUPEwm/D4vg6jJleyIzViugm2oOgw4ef1VtBXe2QewPiWLViHNeiGdCmoVUYINwqHfc64ekh/GZgYEnlAh5WFyGOgZ/HW4cd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8BxQ1Ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5624CC32782;
	Sat, 11 May 2024 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715433617;
	bh=KNyIk+8rZq+JNjFAaXmyGtUHLmbeSTz28burmqQIR5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g8BxQ1Ib85OP1G+gJWtXO44bh2I4cds3mMBM9ZTw41Q7z/VUeIg8E27rl4IePKddB
	 em/MAsgXXecIV5qAApSPimfwV2x8U3FK6tiJP5/iidyHl0hek4jGJoZv+I24S+o+gw
	 zdVcIsjvlKSRhXZRjwtfekJVAFj6O2L4bjrD6GEeXyJmWGwlcG9h21aa4JuDPj7yyl
	 9bv/hTMAlatetiW8ThrdPsehVI7YP6RswbsynBLICSU9wCdru2OyL33GZuBwfISY+z
	 yENgB9EuRytFCf3QFtphebAM14xHWuvNEFolKnG5UGpGgsWFopeb3ByPFBFhDGxWAC
	 ifXGyXcqzmySA==
Date: Sat, 11 May 2024 14:20:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, linux-iio@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH] iio: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <20240511142006.27facd74@jic23-huawei>
In-Reply-To: <20240508072928.2135858-2-u.kleine-koenig@pengutronix.de>
References: <20240508072928.2135858-2-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  8 May 2024 09:29:27 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>=20
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>=20
> While add it, also remove commas after the sentinel entries.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> I didn't add all the individual maintainers to Cc and put the iio changes=
 in a
> single patch. If you want I can split per driver (or per iio subdirectory=
?),
> just tell me if you prefer it that way.

I don't mind a single patch as resolving any backporting issues around this
should be easy.=20

Whilst your changes for driver_data in struct i2c_device_id obviously don't
need it, maybe it's worth similar patches to cleanup acpi_device_id and
of_device_id tables with pointless 0 initialisation?

Applied this with some conflicts in bmi160 resolved by hand.

Applied to the togreg branch of iio.git but only pushed out for now as test=
ing
to let 0-day look at it. I'll rebase on 6.10-rc1 once available.

Thanks,

Jonathan



