Return-Path: <linux-iio+bounces-8000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D837D93E5EF
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5F52816A4
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F5137708;
	Sun, 28 Jul 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze9cMx+g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613FF1EB44;
	Sun, 28 Jul 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180901; cv=none; b=Gj8L2Ejc3O5L4Bo/vcEL3rBgt1xBKn1x4RpfbJu8um1orUoDLV06oMI1MWmk/Unuc9UlIdXkdFSXl2uJDNKOIDOiJB9+37r8tJWWIJAbWxjwTZFiY7VbA4Tagc+itxNVI/K+EBJ7bg9KGk0dQbyP+GPkULZ+y5TSwcgdiwjs0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180901; c=relaxed/simple;
	bh=lmrjcP7e9I1jgSEa3HUsV/XCNO6JpPYOKydZ5MmsqEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEKtKyPBjTlSusMOANgPsYu+lIyMqH6TlsxJKJKfAwDoP+dtnrQuWUgg8XKxg/tObKvmYt82TvduQYNCMxnXMMBIrsPSyTzoclRSY11n9iigxc9A5vqEQcUDnlYvMX0NyW5URqN5JRl9YSkgfZXb0iKnk/vbx4KPozFS5gAUNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze9cMx+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DF6C116B1;
	Sun, 28 Jul 2024 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722180900;
	bh=lmrjcP7e9I1jgSEa3HUsV/XCNO6JpPYOKydZ5MmsqEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ze9cMx+g1a8QXsXN9gNBIsmRtV1CKnKvgTyp84eypwLUf3W53VkMimYP7EQ4RhPev
	 IL46/JaySQem1pxaqr2q+LQzuePCEJEFdA/G4SWDlAxAYVuTVGCy0OCQWtynWcC4aB
	 XzkjwgqAL4pR/g117DsdbEG/fieWuaRwTBZGyHd8EFJnfvAnOe23vOOBOIwK1XTayq
	 TVBPfkq3K0an7lakixfb1qmPJVYxSsD2wpvjnXSFO1K+M1d8AidoQcldELgbNdFlvr
	 8UjNZSjIv1A48qxTMeme8RQNP3/Ddkd1Q7BWcQZgFk9b9YLvbyTGtVO/pq8ZFZYC+m
	 xXHj0zbIW5C2w==
Date: Sun, 28 Jul 2024 16:34:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Oleksij Rempel 
 <o.rempel@pengutronix.de>, kernel@pengutronix.de, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-tsc2046: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20240728163454.5aeafbe6@jic23-huawei>
In-Reply-To: <24ca48955e3b005620bded16aabd91aaa6997ad1.camel@gmail.com>
References: <20240725-iio-regulator-refactor-round-4-v1-1-55e9dc1de325@baylibre.com>
	<24ca48955e3b005620bded16aabd91aaa6997ad1.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jul 2024 12:56:27 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-07-25 at 14:22 -0500, David Lechner wrote:
> > Use devm_regulator_get_enable_read_voltage() to replace
> > tsc2046_adc_configure_regulator() which does the same thing.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
>=20

Applied

