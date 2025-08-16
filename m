Return-Path: <linux-iio+bounces-22814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8BB28E01
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00E6A28347
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3E2D0616;
	Sat, 16 Aug 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXByhVDk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6322566E9;
	Sat, 16 Aug 2025 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755349698; cv=none; b=ANw8xSnb0k65HuZ+FmhxtZD1boAWRRrCYMYCiANvJWBzBEDufaqLc+Pehff0Kjr4u1WV6J0cgjMe/NAPRYJ0n6mtqseZVJHZ6ihkFgiOJgcSEMtgcqYb8hteRots8mR9cFPGrezniX0rj76gYFlU0rFJMcgRwmme9T3URs9FGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755349698; c=relaxed/simple;
	bh=ohFfaNHc2qw5CgEesJPXZJR+Bykk3NLX9ZZFQ1Bx/AI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSh8QVrkSrUr+Mw9cEFQAXwh8lRgWjMinohOE0fiJ5oaXS2NTUNKZJcd6JALK/nVcwN49eRffRb0kYEyUJA7Q0+uyKeUA6q7H79MGzbT0nBRVZyiMZPfJA1HaJMgBt58uY9fIw7Wilm7Y2RQM2x5ssazhbnIP1R5Jq1GxVfi1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXByhVDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62676C4CEEF;
	Sat, 16 Aug 2025 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755349697;
	bh=ohFfaNHc2qw5CgEesJPXZJR+Bykk3NLX9ZZFQ1Bx/AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LXByhVDkUNE3A/4V8FwAUJKOKyj+NcFcKriN/icGvskynFqJbwE030y4NJT7/gdzV
	 F+Nu/PzS6ACl926GzQSQMg3nmYRjpkahap0j+9HItgrUqFeNvpNq3MWHV/GyNgGRu0
	 GOasyz8MB3FmPHOnm+nZDMg+mlr5rKce5lsEaZ9EC9tPTOF2wM7zR+Xfh0ghDC+uHb
	 TR+v5QpvA4pEG/g7LQlt1DiqOdOxqYM5IBmQffgykS+rpuP5KI7OPQIimD5vHwn3Z6
	 Shmqnt9JlqnQcEOLzLIdkEPJlynz6lzMBoKVMaEo4XtGqIKnpvNnI4mzmoM4POdS8I
	 utPEOcCg3T+3g==
Date: Sat, 16 Aug 2025 14:08:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?6LW16KW/6LaF?= <zhao.xichao@vivo.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "o.rempel@pengutronix.de"
 <o.rempel@pengutronix.de>, "dlechner@baylibre.com" <dlechner@baylibre.com>,
 "nuno.sa@analog.com" <nuno.sa@analog.com>, "andy@kernel.org"
 <andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ti-tsc2046: use us_to_ktime() where
 appropriate
Message-ID: <20250816140809.2121a864@jic23-huawei>
In-Reply-To: <92f45b4d-447e-45ea-8fc0-a003a32d934c@vivo.com>
References: <20250813075556.466872-1-zhao.xichao@vivo.com>
	<CAHp75VeRb6HV80P1B60sr4=-pdWW+GS1dQDYUbO0PWLhkKZsGA@mail.gmail.com>
	<92f45b4d-447e-45ea-8fc0-a003a32d934c@vivo.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Aug 2025 11:33:24 +0000
=E8=B5=B5=E8=A5=BF=E8=B6=85 <zhao.xichao@vivo.com> wrote:

> =E5=9C=A8 2025/8/13 18:34, Andy Shevchenko =E5=86=99=E9=81=93:
>=20
> On Wed, Aug 13, 2025 at 9:56=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com=
><mailto:zhao.xichao@vivo.com> wrote:
>=20
>=20
>=20
> The scan_interval_us and time_per_scan_us are more suitable for
> using the us_to_ktime(). This can make the code more concise and
>=20
>=20
>=20
> This makes....
>=20
>=20
>=20
> enhance readability. Therefore, replace ns_to_ktime() with us_to_ktime().
>=20
>=20
>=20
> Perhaps Jonathan may tweak the commit message to be more English, but
> code wise I agree with you.
> Reviewed-by: Andy Shevchenko <andy@kernel.org><mailto:andy@kernel.org>
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20
> Okay, thank you!
>=20
> Best regards,
>=20
> Xichao Zhao
>=20

Tweaked description and applied.  Thanks for a nice cleanup.

Jonathan

