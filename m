Return-Path: <linux-iio+bounces-5606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D991A8D74E5
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1714F1C20FE7
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C798538DF2;
	Sun,  2 Jun 2024 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFNfHbjs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A02C694;
	Sun,  2 Jun 2024 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717326990; cv=none; b=qvCjRC3EszkWFpGW6iWDWvjl4DBOwvoKt/PHIFAWtcjAIJyDbMNGZRuVCYz8Kt5c5jHn8ao4O2bly1zC23tP9GyHubE87TBODJHKH9K2pvJ/88u5t9jTSvRBjWYZ7llRwi95Ti93KH8nO9fK4QHsPXWksk4MoMhgTa1d2PQQGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717326990; c=relaxed/simple;
	bh=W9+6j3CJY2BQ6wjRbyfAkyac0heJKolaFZ45NLSp48I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFquE1t/10e/zOxHaQX3MKiwlcFfS6/O3+8KefKDMZYoL/N6Bzq/4YV2pxQy03/6Nf5+avPYeRc5QaFtH11wLRzV33dMVdEwGw5590Ja/LrmKI1mJaPRjzlj1K+Pxo1HMM1vFWyirhRjDmtqtZosneTFzdQ8uUmflvwshJjuN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFNfHbjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05315C32789;
	Sun,  2 Jun 2024 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717326990;
	bh=W9+6j3CJY2BQ6wjRbyfAkyac0heJKolaFZ45NLSp48I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PFNfHbjsHFUCNzXGNt1XfZoonWjAv9Id5B3Nkx9wUZLz0XuCzHcFBxUddhZ9dq87b
	 4bvCT7NEHitULcRvZA4YMMriOrFW44daFYaeAssxQesM4IZpusQyg4L8E5fLq3GQMX
	 I86FX0Q9u4W56+GnhrXEHc6V10qqaqG6A7/g28WmD+nt2gIbh1EjTKeh0kvIOgY/gS
	 LzUethw6b65FFf//s01gugnxKZLczMNezIIoRsUG30u0yZ/U0ws5Tyus/1XUgSk7vv
	 zmiFSsWgUoDZx/Ua0M2E5ju9WhOugM54I/HkMStTQjlAwvRjTS3u5+WX0fFZpZ+x9T
	 2xWzkwjJzLRCQ==
Date: Sun, 2 Jun 2024 12:16:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net,
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH v2 0/6] Add support for adis16545/47
Message-ID: <20240602121616.035d2775@jic23-huawei>
In-Reply-To: <5b002e3b9df0da1a81b248a4e4dcb82464a61cf6.camel@gmail.com>
References: <20240528142409.239187-1-ramona.gradinariu@analog.com>
	<5b002e3b9df0da1a81b248a4e4dcb82464a61cf6.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 May 2024 10:40:01 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-05-28 at 17:24 +0300, Ramona Gradinariu wrote:
> > Add support for delta angle and delta velocity channels in adis16480 dr=
iver.
> > Add support for ADIS16545/47 devices in already existing adis16480 driv=
er.
> > Add documentation for adis16480 driver.
> >=20
> > Ramona Gradinariu (6):
> > =C2=A0 iio: adis16480: make the burst_max_speed configurable
> > =C2=A0 iio: imu: adis16480.c: Add delta angle and delta velocity channe=
ls
> > =C2=A0 dt-bindings: iio: imu: Add ADIS16545/47 compatibles
> > =C2=A0 iio: adis16480: add support for adis16545/7 families
> > =C2=A0 docs: iio: add documentation for interfacing tools
> > =C2=A0 docs: iio: add documentation for adis16480 driver
> >=20
> > =C2=A0.../bindings/iio/imu/adi,adis16480.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> > =C2=A0Documentation/iio/adis16475.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 +-
> > =C2=A0Documentation/iio/adis16480.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 445 ++++++++++++++++++
> > =C2=A0Documentation/iio/iio_tools.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 ++
> > =C2=A0Documentation/iio/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +
> > =C2=A0drivers/iio/imu/adis16480.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
393 ++++++++++++++--
> > =C2=A06 files changed, 825 insertions(+), 71 deletions(-)
> > =C2=A0create mode 100644 Documentation/iio/adis16480.rst
> > =C2=A0create mode 100644 Documentation/iio/iio_tools.rst
> >=20
> > --
> > 2.34.1
> >  =20
>=20
> LGTM
Me too.
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it and see if it can find anything we missed.

Thanks,

Jonathan

>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20


