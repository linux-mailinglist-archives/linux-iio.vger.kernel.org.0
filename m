Return-Path: <linux-iio+bounces-20310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF1EAD12E4
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 17:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9578188B318
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597842505A9;
	Sun,  8 Jun 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM81SMH1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5024DCE5;
	Sun,  8 Jun 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749395649; cv=none; b=ho63UllpsYkPI3RSpDx3Liuc5h+iNG4pztm9mqo5ihyDkW+8gcq8NsfJsGwAJdUtOAgys0EqzNuHeyALlWZdWtgmdMZySgJHd4WlnQMYO2/wX12iJdXYSaljBa8QzcOsvlybSQBuoxErQ8HgefstZ6pQSaRXFbV3EZlwv7op18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749395649; c=relaxed/simple;
	bh=UZPce0mtImXOjRUH7sHS6wvNBXEsqDCIGVjyZWiPe8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RC0tl3oqx3mWeDi/1KcR+ANg5vVrlJS7ym+c38xY1PFQEPA0KRYp/pBXBkvf2Dw0qpWIq+8GdbzLIlNir7UAeHABDxBUcink+o8alvBOn37JhijR26zXvH8uRQdBUS1yIc/+XeZm601XtNXxpfXHFuSpDlkCtk0ZJLV0WSdb5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM81SMH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77C9C4CEEE;
	Sun,  8 Jun 2025 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749395648;
	bh=UZPce0mtImXOjRUH7sHS6wvNBXEsqDCIGVjyZWiPe8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eM81SMH1mJBm5474/QJs70ldj7/ynF5JsBQkyWGRlGt+JEN7yWf2VBN9gtUGyIOyj
	 GpQeE1f2wozScM0tD/Hzz9vinST0CFOTP9A+4FGYyo6Q31tVfeYRphqk+b+3OwzvCD
	 FutawlAi3ISPMFrP8WrJ2h3UXtvdnSF8VZjsFniMbxzau2TQUW0xj5Ehzn1sj3+Vs+
	 EPP3ssk/mH5GW265eEhSwpxLkedXhYtmjBlv0ieYQJEcl5cw9fVsE/IwouowazIP7b
	 z/PGfw+aRiH/GZaZ+nZvEYrsejvgrWsNEmKK5nzStcnamfQvjoI096Uz2KtKFfVI6W
	 N7uxY/EYmFy+Q==
Date: Sun, 8 Jun 2025 16:14:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] iio: accel: adxl313: add debug register
Message-ID: <20250608161401.4e982922@jic23-huawei>
In-Reply-To: <CAHp75VfxqmWAA+h4y85F=O2eg038yfmpW=p6P7ykDMKbCJ-bqg@mail.gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-2-l.rubusch@gmail.com>
	<CAHp75VfxqmWAA+h4y85F=O2eg038yfmpW=p6P7ykDMKbCJ-bqg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 1 Jun 2025 22:06:27 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 1, 2025 at 8:21=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.co=
m> wrote:
> >
> > Add iio debug register for general sensor debugging. =20
>=20
> IIO
>=20

Tweaked whilst applying this patch.  Patch stands on it's own so I'll pick =
it
up now even if the rest of the series needs another version.

