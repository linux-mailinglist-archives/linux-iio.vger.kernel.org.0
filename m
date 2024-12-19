Return-Path: <linux-iio+bounces-13660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC369F8008
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C088A1889526
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDFC22655F;
	Thu, 19 Dec 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGKNcLJ5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83422619A;
	Thu, 19 Dec 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626289; cv=none; b=oKkaHjSR4UfCTrc4lpvYm4vwzFg+T92FK5si4UkugPwuu7v00//PTlbSGC162hcVFE6dxQxmC2mm0QJ8oBBN7SOvUs8MzfUJv6MOgWuWj5Lx3DIL0W+MMmtAjljaP1Qcgv2E7SBmrlOzlXgz1IQ278Xd22qWRhvIjAmKODbAaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626289; c=relaxed/simple;
	bh=BhSIMHso+TtsADRRedAOIQzKLynGGeOmcpsn8yixHBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqNaHFFtRzJArd0Io4oA1qds/uT66o81iNqPaB4Ezo6Ku8cbwYeTdd0Vlwv4BGvzZQkbvOxjaupvteRwZb6MYIF7Gy5ZFPI/3shPCmFBkuo1JnZzZGl6/j4fMYHSWiyfgGdd8q8bf/RD0JU83t1U7eeqPm6EOxrI3c2LfOl9O3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGKNcLJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28566C4CECE;
	Thu, 19 Dec 2024 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734626287;
	bh=BhSIMHso+TtsADRRedAOIQzKLynGGeOmcpsn8yixHBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VGKNcLJ5+LYgDujIxJBFvhJp1awLQRCAuVUzQZ49vzOuaPTi2+psr6QHfkk146MCR
	 XjDpMAKtsjvLPy8SB7bUBYmXfN9y6Y4VDic3O+sd5SMUgU2Qpc/6Nxxh/0VN+XeHJL
	 AQMdd4SIwj95ZIngVN1lXV3TtHnPSHQkTxsmjx/aKb6CiIQiyRpCxsYcgXdO1xyfWF
	 ybsnoze8nZYeIrgeFhJTtdQAw59gQUlFSLooa9SzhiULL2qY2Bt61Q1b+qMVA4cMSq
	 5mFNSVALy/nBgoHvQ8BsqLZi2LM8T1uSH/Q0oz6VlxWxHlIVj6aE3xCc5ZwDsddHqb
	 8ExwcF3yCcvyQ==
Date: Thu, 19 Dec 2024 16:37:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Liam Girdwood	 <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Antoniu Miclaus	 <antoniu.miclaus@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: ad7293: enable power before reset
Message-ID: <20241219163758.6507221a@jic23-huawei>
In-Reply-To: <f24abf927dcd21866bdb335d5ed27f3be4d94705.camel@gmail.com>
References: <20241216-iio-regulator-cleanup-round-6-v2-1-9482164b68cb@baylibre.com>
	<f24abf927dcd21866bdb335d5ed27f3be4d94705.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Dec 2024 11:05:38 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-12-16 at 15:44 -0600, David Lechner wrote:
> > Change the order of regulator enable and reset so that power supplies
> > are turned on before touching the reset line. Generally, chips should
> > have the VDRIVE supply enabled before applying voltage on any pins.
> >=20
> > While we are at it, remove the voltage level checks. If the power
> > supplies are not supplying the correct voltage, this is a hardware
> > design problem, not a software problem.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied. Thanks

