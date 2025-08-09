Return-Path: <linux-iio+bounces-22505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD7AB1F61C
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 22:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484F3189ED0C
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D18727A913;
	Sat,  9 Aug 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBfpFW+t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A63527510E;
	Sat,  9 Aug 2025 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754769617; cv=none; b=QYSi5eaM3iTT6sMs3OIi1z+8390kvM0YPvqIgDd38DDqSwccyyUrN8AT9o+zMBtFRAKZRVq5Q5WBj2DHsvdyEDD1T/W+MWr9NcczFPaywsJ/SrkDMJtDdkx1Wi4GzFlF5AsAV1LAOObhzoGh+QxTofM9XeRd84arl6qfqPKcypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754769617; c=relaxed/simple;
	bh=7fQBK8bgFE1Ri1Krh9HfuYIeNKOzqdzxblIbW7hnQXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFc1kRCZ6t5j16GlPfzu7/eSKWmygWQgB/jNxm26SJEhhYFfY2ba62go7oVkyAKRfdysO3BV9Db7tX3yn9hwk/IcEtP05222AAVw2E6ow3KfwHv8FAA1KTpVMfdecBQzlS1Cry7TWiqL1pL+CPQnufMGLNwSnvNjyelqWLcvykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBfpFW+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432F4C4CEE7;
	Sat,  9 Aug 2025 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754769616;
	bh=7fQBK8bgFE1Ri1Krh9HfuYIeNKOzqdzxblIbW7hnQXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GBfpFW+tldLQvKQQnUCTIxV092GzoC3t6M7VHOAiWjRrEBBkv7QIw0lX0maHUrfQn
	 WNPg5HnhwTezF2HG9Mf+obGeahDBhbzh51uRWrEkfvCUUFVvLxrk/zJfyNCNtL8w2j
	 k09TFBa8vO1yehyW9TuqvYzGAjNx11Jm+zO7PQwHzuvYdj8GO0yhgNyT0n3FV5d/NP
	 vpizg1ixql0wV6LjMsH4jn/G5VZPROpKjsYg8vGgN8LQ0IRuwU3jpQdGkehyrAudvI
	 ekPwDPD/0u+UcAH3gQLmajUXN5nA9OA0uIlzh2/Pcwmb9vYLXkz7OMppBtWWFkzn09
	 Ky7m/QSekg1sw==
Date: Sat, 9 Aug 2025 21:00:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Waqar Hameed <waqar.hameed@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matteo Martelli <matteomartelli3@gmail.com>, Heiko Stuebner
 <heiko@sntech.de>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Mudit Sharma <muditsharma.info@gmail.com>, Gerald Loacker
 <gerald.loacker@wolfvision.net>, Song Qiang <songqiang1304521@gmail.com>,
 Crt Mori <cmo@melexis.com>, kernel@axis.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] iio: Remove error prints for
 devm_add_action_or_reset()
Message-ID: <20250809210001.4d8af4cd@jic23-huawei>
In-Reply-To: <CAHp75VeGvgv6TAYRRtEySmESkjygW79ms-Yd64h08_+7JjJMJw@mail.gmail.com>
References: <pndectqm7te.a.out@axis.com>
	<CAHp75VeGvgv6TAYRRtEySmESkjygW79ms-Yd64h08_+7JjJMJw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Aug 2025 15:06:02 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Aug 5, 2025 at 11:33=E2=80=AFAM Waqar Hameed <waqar.hameed@axis.c=
om> wrote:
> >
> > When `devm_add_action_or_reset()` fails, it is due to a failed memory
> > allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> > anything when error is `-ENOMEM`. Therefore, remove the useless call to
> > `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> > return the value instead. =20
>=20
> Even more, the devm has tracepoints in case somebody really wants to
> investigate failures.
>=20
> Fully in support of this change.
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20

Applied to the testing branch of iio.git. I'll rebase that
on rc1 once available.

Jonathan

