Return-Path: <linux-iio+bounces-26239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDAFC60961
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DABC34A27C
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737413019AB;
	Sat, 15 Nov 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvQeRzdW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899327B335;
	Sat, 15 Nov 2025 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763227777; cv=none; b=f1DdvYx23B4ZrP3TiWO4EvEe89+KrCGjJJ4j62cjgxLHOBGvwpU0m3nKXwB9txBQ9h4OMbrO3EaLDBPUtGdOKyL2VvWA+w7WYPIc7E9IiohApkfd5/Go6rcvHetWVH1RLfOtbYo+Wk63OWQHt2eF8gyoyA2zGXI1XP4mKKX8GF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763227777; c=relaxed/simple;
	bh=JNWoJnw8C+4j9CTDfWsKuXQlb0Nial1Cln8Nj5OdMf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXiLWD0pMZLtwoih8MqLtpSLpQBTpOgVBm2lrc4a2MZleRqm6Ohv3EYkpgWhthCtXJiema5go0itE1gl70TY+eyi0pYbU9qNNW/t5P5Ep2NvUzR8rxMRKKbwRRF0hllGHQ7TLQ1/J5t/dRO4bkQDtMYE3HSH1lBHamerIuAS5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvQeRzdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDEAC4CEF7;
	Sat, 15 Nov 2025 17:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763227776;
	bh=JNWoJnw8C+4j9CTDfWsKuXQlb0Nial1Cln8Nj5OdMf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DvQeRzdWddE1WfQqOpDG2Qtn4Avwc5MMn52TnNauE6Ekhcg0WM++zIb1iW0Brwsl4
	 WZPIGy/+ODCha87Z5uPQ3t8KMFNzAW3Ox3qIobqQmhVp3y5lc5Ew2khKHvsvczgv+n
	 cKwbHKia6huHRM28/LP3tCSn9jyAON9RvQx19Nu5jPjasdCGYiBifYP05wm9kBvzo8
	 E4B03T5a5svH+cwaAuWN4NHMZD7shfbnHY7rExEzXZ2hK02MH5Pfbpd4YpjYRXx5mP
	 39TZNzYbscOP3wqSKXF9CxKyh61lSoylmcXbEA4000Emw5Lk445MAId6QvCI+nR/DN
	 Nd9uOsAzQxe2w==
Date: Sat, 15 Nov 2025 17:29:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron 
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 0/3] iio: core: fix error path in iio_device_alloc()
Message-ID: <20251115172930.3b06d771@jic23-huawei>
In-Reply-To: <0ec0086b91528e67c9a5c1fe4c27b65a3cc9f8aa.camel@gmail.com>
References: <20251112145735.2075527-1-andriy.shevchenko@linux.intel.com>
	<0ec0086b91528e67c9a5c1fe4c27b65a3cc9f8aa.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 18:00:42 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-11-12 at 15:55 +0100, Andy Shevchenko wrote:
> > The series is induced by the similar fixes in viio_trigger_alloc().
> > Basically two things happen here: 1) add missed mutex_destroy()
> > calls, and 2) refactor to make sure we clean resources with put_device()
> > when appropriate.
> >=20
> > Andy Shevchenko (3):
> > =C2=A0 iio: core: add missing mutex_destroy in iio_dev_release()
> > =C2=A0 iio: core: Clean up device correctly on iio_device_alloc() failu=
re
> > =C2=A0 iio: core: Replace lockdep_set_class() + mutex_init() by combine=
d call
> >=20
> > =C2=A0drivers/iio/industrialio-core.c | 18 +++++++++++-------
> > =C2=A01 file changed, 11 insertions(+), 7 deletions(-) =20
>=20
> LGTM,
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
I'm not going to rush these in given where we are in the cycle
and the fact only some are fixes (and really no one cares that
much about mutex_destroy() as it only does anything at all in
a particular debug setup.)

So applied to the togreg branch of iio.git and pushed out as testing
for now.

Thanks,

Jonathan



