Return-Path: <linux-iio+bounces-23504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3102DB3CF27
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 21:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952A1189709A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26A2DECD4;
	Sat, 30 Aug 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnYM+GUa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577FB242D9E;
	Sat, 30 Aug 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583473; cv=none; b=Cm9nAYuDumiIuIu9ZqAN8TeCzTf8hS9gOjwOGButDYppMgnAyA+nJTfsfs8izQsmpt2GLNO3aHE30KlTkPXHVjMEoEfvImhegc1PFjm77EYYS1oFv1wFMSlhaWo7591ZBvPgJGS59Y9dCvmFB/LJV0KBih2kd6d0BsA9939Bsuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583473; c=relaxed/simple;
	bh=gUGT9ZpP7T0v4R1MQrwTuz1NIpTv8oVeEjQlLS+Zn8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGRTswiuP+iW6pWzFk83/pRlv7+NKgOV1GdDfo/EViUGDA5bNizMp2Om+1aUOLubMKEHq1lgoFTORc9t89Ys7ClTdZKCSVu0GCM1DHyAXMkYINczH2vYg4MC/3B7Q7q42XaIv0sEGMDikvs5SD/NdJohczD5oWBl/7j5baLbKPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnYM+GUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B181C4CEEB;
	Sat, 30 Aug 2025 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756583473;
	bh=gUGT9ZpP7T0v4R1MQrwTuz1NIpTv8oVeEjQlLS+Zn8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dnYM+GUa0iWB5+jj10vKVbJaH1LmWnTenJtiGphiVapLIf4jiuGw1AemPGNvsGaFE
	 iUTj5wbKG3IUtfed4wsATUB5ShUnxUVmJeQsroOeSzKIs/056k9Sda33ojIyPHeWJ7
	 HQy9kV0ZDcQ/0SmVMhlBUVTgYDJyuzbMqyHYjWchnpviE2SGPczz38GlWZrAgeexiX
	 FPdQscXttL0LoGGdEV6UnwK889fHWwEuhzPQ3SPimdT/ysDCHVDal/guTJ1WUQo+XC
	 7lh6CqPvwNv68sxhGgG8cd9Ab36tC6PMAIkXWZ/MhmfrWr9K7iLCsvHxS3cSYNwQuF
	 qp6oorfyUuwAQ==
Date: Sat, 30 Aug 2025 20:51:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v5 1/1] iio: dac: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250830205104.38d784a9@jic23-huawei>
In-Reply-To: <CAHp75Vdr5atuW8wivgR3KRjhCK_i+JE2rJFTU3CkWwzpuNv_pg@mail.gmail.com>
References: <20250828140617.3193288-1-sakari.ailus@linux.intel.com>
	<CAHp75Vdr5atuW8wivgR3KRjhCK_i+JE2rJFTU3CkWwzpuNv_pg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Aug 2025 17:43:19 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Aug 28, 2025 at 5:06=E2=80=AFPM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> > to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call =
to =20
>=20
> redundant
Fixed up that whilst applying.

Thanks,

Jonathan

>=20
> > pm_runtime_mark_last_busy().
> >
> > Also clean up error handling in stm32_dac_set_enable_state(). =20
>=20
>=20
> Code looks good to me in this version
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20


