Return-Path: <linux-iio+bounces-6302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E690987B
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 15:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1B11C20A0E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BB14594D;
	Sat, 15 Jun 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFmDPr4E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7517BB6
	for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457536; cv=none; b=fC+WY1D7oVZEbSrkghAlbIUQbxJSB7UWOYawuCjKWE1pRvKBP7Nfp10Gl4jres4P2L1SyGyhgYJQPu9HiRRvZr2iGmfWIrmDDXGuBdQK6mZGxwQe2ZD1GgrM41UywPmwapvUpA2dae7CCQzd9UaW7jQUe5szOC0g7ZDCnkNRCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457536; c=relaxed/simple;
	bh=QeKqsa0Lc7UC1eYMDdXxZ0M0d6zT7q+rB9ysiA3L+kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOAbzqC/7VhiWhFMY82HBkdUCZGcKMYkXARYMoDQSCCPJCQtgFsLuQADEeHvTs6HRtMlSgCdp4HNLDMEGEL3p5I7V0yhTrSmy0Lgt4gM4OOzO87VAgBMmiJNaSSN4lOPy03Lp4sp4iecAMtf0crCXA+i+baAilUV6aelV7iUoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFmDPr4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D42DC116B1;
	Sat, 15 Jun 2024 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718457536;
	bh=QeKqsa0Lc7UC1eYMDdXxZ0M0d6zT7q+rB9ysiA3L+kc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tFmDPr4EvJNb0Wm7bcKfYQ6B/83jbuVlSZp0Mt+EzyA6zcZTPhqhP8dD+nUnGK0yf
	 EjKEmhNZ/yDWElnDr3d/YdVjo8HQcvRph28t4YgjBMeGyxeOSrG+DaA8HWxu9XlD4I
	 nqcC4Wn7OBzMufBUptrTQHlKDf3iArtBjBhKz7XrFTfiQPogUWIvDlm/4ltRMg3n1B
	 9jZuvmuSwQRRu8Y+m+2nnLWVA0TeZx/1ldysHxdiEdS5481ugxSG+D3gf+54nEmQnS
	 vo3jwp2h6lgmecrv8Fhs3RI+nFGdHg758vxk1BkvX5WuBWXEnz6BUrmQsWaXDD2Z2z
	 4tv7bKhg2pWhg==
Date: Sat, 15 Jun 2024 14:18:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH RFC 0/3] iio: add helpers and accessors for active
 channels and masklength
Message-ID: <20240615141847.70429abd@jic23-huawei>
In-Reply-To: <20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com>
References: <20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 16:20:47 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> Hi Jonathan,
>=20
> In [1], you suggested for an iterator for the active channels (so driver
> don't directly access masklength). This RFC showcases that iterator and
> goes one step further by giving an accessors for masklength so that
> drivers can read that variable (we have drivers doing that). The
> accessors uses ACCESS_PRIVATE() so it will warn us if some driver
> directly access the variable making it more difficult to mess with it
> (like changing it's value) without being noticed during review (or the
> auto builders).
>=20
> Anyways, before jumping in changing all the drivers using this, I guess
> the questions are:
>=20
> 1) Is the iterator useful enough to add one (kind of like it and save a
> line of code :))?
> 2) Do we care about going with the work of marking masklength private?=20
>=20
> If we go ahead the plan would be:
>=20
> 1) Add the helpers macros;
> 2) Convert all drivers that directly access 'masklength';
> 3) Annotate it as private.
>=20
> [1]: https://lore.kernel.org/linux-iio/20240428142343.5067c898@jic23-huaw=
ei/

Cute. I'd not seen the __private bit before.

Looks good to me.  I think we should spin it a little differently.
1. Add macro and a dummy=20

#define iio_dev_mask_length(indio_dev) (indio_dev)->mask_length

2. Convert drivers

3. What you have + the ACCESS_PRIVATE change.

that accessor still lets people change it rather than making
it strictly private.   I wonder if we need a little more complicated

static inline int iio_dev_mask_length(struct iio_dev *indio_dev)
{
	return ACCESS_PRIVATE()...
}

or can just review for anyone doing iio_dev_mask_length(indio_dev) =3D 4;




>=20
> ---
> Nuno Sa (3):
>       iio: core: add new helper to iterate active channels
>       iio: imu: adis16475: make use of iio_for_each_active_channel()
>       iio: core annotate masklength as private
>=20
>  drivers/iio/imu/adis16475.c | 3 +--
>  include/linux/iio/iio.h     | 8 +++++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
> ---
> base-commit: cc1ce839526a65620778617da0b022bd88e8a139
> change-id: 20240612-dev-iio-scan-private-86f4a0fd288f
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


