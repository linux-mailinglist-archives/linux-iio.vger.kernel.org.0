Return-Path: <linux-iio+bounces-18459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B2A9528C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 16:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F1F3B41FE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6CA84039;
	Mon, 21 Apr 2025 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5agm/Pm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11DF18B03;
	Mon, 21 Apr 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244657; cv=none; b=L5cWeCKBpFxzMXkfOS2iLFB86ArpJA9dBbaTeXkgf2TvMcKNTkG7nzOxyqrQoIN4WGR01NOsA3oVXVeKlPGgUh6UnbLejI+B9/yONiqo7sbZwhRrTiBjmaubw8enl9ekraOnYxtKf3GmurTRdqL1VOF8txBWnCr/zvDSNRH6Y/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244657; c=relaxed/simple;
	bh=j5xTBEBcb/E8ufFtOXDdYcV01li92cSUZ1cpwTuXgYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNHL8OwkfuSL1X1JjmC/iSZuuLiylKLoA/DLOSyK8hwLgfzIkEdMmDPLgdkhmMAhpp4beRRvaMBmo9LhMWU36Sgk9OMeBle7gZg6TvMsRDoC9e88dBCjkn1gKtIdm7gESaRohoRJZP+hdem3EAx+JMN6LhS2C1vW7v3G7pRmzvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5agm/Pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A5FC4CEE4;
	Mon, 21 Apr 2025 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745244656;
	bh=j5xTBEBcb/E8ufFtOXDdYcV01li92cSUZ1cpwTuXgYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p5agm/PmrKq6HIWUY3qILlEMK/I9M7ttFom7jkxzLhYPR6fVGZFhxIDaCr7Ntz7n0
	 YHfbTs8zImbi+YaiJXYEjchnWZrTfXgjYg64JyMB3K7KM/ugEhNcMfpzol2NcXS7Tl
	 +SQwICvtoaRgOKVuG8w08s2bmv7CtjzNr9h718fnXdOjsuf104o7XpZr1VUQfS1AIk
	 QmHTrhd4KNlIBvms5xiiTVKww0IbfksUGv6qJKVyoCSoItqKKI+DskwtaxrXfICB3e
	 wiRsUluMNW5SPZwQEHrIcw70LR2PX8P/X8bm3i5HhPv76vpYzWyAb0Y3Kn4GmeXjgt
	 /sJ5ibZYNKqUg==
Date: Mon, 21 Apr 2025 15:10:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
Message-ID: <20250421151052.0144516a@jic23-huawei>
In-Reply-To: <CAKUZ0zLEacGg5cD4wGmFz80e4FQ9A=JsVyrzGAHkKEeOT=CU2A@mail.gmail.com>
References: <20250421124915.32a18d36@jic23-huawei>
	<20250421131539.912966-1-gshahrouzi@gmail.com>
	<aAZNCEUejrTgy_yZ@debian-BULLSEYE-live-builder-AMD64>
	<CAKUZ0zLEacGg5cD4wGmFz80e4FQ9A=JsVyrzGAHkKEeOT=CU2A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Apr 2025 09:55:24 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> On Mon, Apr 21, 2025 at 9:48=E2=80=AFAM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > On 04/21, Gabriel Shahrouzi wrote: =20
> > > The inclinometer channels were previously defined with 14 realbits.
> > > However, the ADIS16201 datasheet states the resolution for these outp=
ut
> > > channels is 12 bits (Page 14, text description; Page 15, table 7).
> > >
> > > Correct the realbits value to 12 to accurately reflect the hardware.
> > >
> > > Fixes: f7fe1d1dd5a5 ("staging: iio: new adis16201 driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com> =20
> >
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com> =20
> Should I have included the reviewed-by tag on the latest patch sent in
> this thread since there were no changes to the code?
>=20

Yes, but that was all a mix up anyway so don't worry about it.
I have the tag anyway.

Jonathan

