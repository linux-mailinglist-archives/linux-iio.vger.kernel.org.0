Return-Path: <linux-iio+bounces-18439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2FA95198
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193907A4A7B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F31362;
	Mon, 21 Apr 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmjCYQ+a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD320C485
	for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745241846; cv=none; b=rsrV0fM7RpyUYirukdGhALmfp/7/fOLDsgAv0eCbxzDjajv/a+hKQ2tLssaZ5ZhxXJi05BOBQo1rX91dn1jWZEiYAmZeFvHZdFEjuxUi4OFusc8XcpyU2ccmt6yWvcyv6+bbWwxOMcCjMDNiEoaaPOq091gTBvfeedz2cMa5kVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745241846; c=relaxed/simple;
	bh=LRKkaSMEHoD8lsSD65B5CbdiZvHqN2YLILCm0r9kNTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSmr2vTXiPTZk+CMsuUUfeF98Rcvvw7H20eWfpE8v6sT11sAdwH9Fv4nUgrDsuC+BgMVWgPQlwVzDfuwgS9rVUUCzLbkuqiEXDmJ9HFUpezZ67hbcQn2ksVZR2LnxWU7PHclMiZgIdWY8an7IWtaYOpOekJB3jLDZdCZsP9TopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmjCYQ+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BC8C4CEE4;
	Mon, 21 Apr 2025 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745241845;
	bh=LRKkaSMEHoD8lsSD65B5CbdiZvHqN2YLILCm0r9kNTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XmjCYQ+a7rXVJ1OR0jCF7VJ7wHeIiUqNS1IMk/I1qD8Knti/WTxEyoqbyq6epRR/T
	 tdtOltD4Oti3O3mD+Swt04WQsXvx3qbO8bZxMx4oHr5SSkKrSPpEr3ARcUWFDIE6Iq
	 0uMUaq6RkUrp8ZTXgQ65a0DqGnysHCU6bvDOkRUSUoxwIl5Q7CLNTMtIFbQ/hibzNR
	 ZNzeecUt+KYOCv0JCFIvwvuCDwe+8ZqFcZZXJFBUljOgMsQzK4FhZ2zisXDnjMM3hF
	 SpxoYBb9a6U/DY4Zix3EB5WBzqQsBC/4rVJ++hbBeSmM4jnqtYiMbxChhnuFBXa49x
	 vzt1JtHwnsgjg==
Date: Mon, 21 Apr 2025 14:23:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, nattan <nattanferreira58@gmail.com>,
 lucasantonio.santos@usp.br, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Prevent concurrent access during
Message-ID: <20250421142359.11fb483f@jic23-huawei>
In-Reply-To: <20250420211706.GB5621@francesco-nb>
References: <20250419232316.36002-1-nattanferreira58@gmail.com>
	<c2golk6627ybfpw3t7lnerritq2yysi5zhdlvahnvhxoevmojn@j3d2stvivkyk>
	<20250420211706.GB5621@francesco-nb>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Apr 2025 23:17:06 +0200
Francesco Dolcini <francesco@dolcini.it> wrote:

> On Sun, Apr 20, 2025 at 01:07:28PM -0300, Jo=C3=A3o Paulo Gon=C3=A7alves =
wrote:
> > > Use iio_device_claim_direct() to protect register access via debugfs
> > > from conflicting with buffered capture modes. This prevents data
> > > corruption and ensures correct device operation when users access
> > > registers while streaming data.
> > >  =20
> >=20
> > but debugfs is meant to be used during development/integration,
> > where this probably is not an issue. =20
>=20
> Is even worth doing any such a change? I assume Jonathan will have an
> opinion on what's the expectation for an IIO driver.
>=20
> Nattan, can you explain why you need such a change? What is the use
> case?
>=20
> Francesco

For debug access it 'depends'....

Some cases are easy reasons to add this protection
1) Accesses can't happen at all because to talk to the device and read
   registers etc requires some mode change (e.g. recent drivers that
   can only access config registers when the bus is operating in particular
   modes, or where we have to use a slower SPI bus rate).
2) There are register banks involved. So a single write can leave the
   driver talking to the wrong registers...
3) Driver uses multipart reads / writes (similar to register banks)
   In most cases this is a device specific thing and should use a local
   lock to serialize accesses.  On occasion that is too complex to make
   work with debug so we restrict debugfs access in general.

Other cases are less obvious.
1) Bus traffic in general might slow down a transfer and break things
   because of timing. I.e. missed samples.  That can happen for all sorts
   of reasons anyway so should only be a momentary problem.
2) They might changes settings.

These less obvious things are a case of thinking it's a debug
access. We tend to not prevent actual deliberate state changes as that's
someone shooting them selves in the foot and they get what they deserve.

So what is the case we are protecting against here?  The description
definitely needs more information to justify this patch.

Jonathan

>=20


