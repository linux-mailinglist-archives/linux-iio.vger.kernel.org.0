Return-Path: <linux-iio+bounces-14448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279C3A15CB9
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 13:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FD53A8C8A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DE018F2D8;
	Sat, 18 Jan 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBX/zMNu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6718D656;
	Sat, 18 Jan 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737203258; cv=none; b=LoaLifRhOmK26nNmyKlW3o0KBQJpVQlSe9fX0Ew4cF/voNs7b3pKgCz8wFAfe5KSdDkIGu2oSKSN4Jwc+aplyr7WsyJvzjA2fmNePNIYVrN4hLMZp69pGJ6BJVEOjHT5TulgnghOn1DOLhmpjHWB4SihK/Z3PiaqMAOUOxBJOcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737203258; c=relaxed/simple;
	bh=TEYYLMQv8EXmnzCVNsgd4akFq5uJWZ0s4FFkVXX3ZA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNA3Fq75UADZ7dPk4kcyGfmFhpqXJKVDhg5uYAfKpcqa99thlvIhGpho26k6mwnXoTfKx0DOciq40nOR39jS1L3ztPQaMNDaSubku/EHTNk0bvtniXH4TqynzJgpHXe3FF1bMiFL9EEF5Gt5YVh9hWcde1MxfuUKVXuD6Rhutlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBX/zMNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DECC4CED1;
	Sat, 18 Jan 2025 12:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737203258;
	bh=TEYYLMQv8EXmnzCVNsgd4akFq5uJWZ0s4FFkVXX3ZA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hBX/zMNuAVaX6DkfDAtXlSjg6aQUWtorxdszt5Y0pzo6dKv44TnDX9rdRGLtmRPpd
	 foV7Oleewsq3hJrA28Tfo5jAyegOnnBjuWnHhAzc//QAO7BHfTAiwsbWBcJh4NqnEo
	 H5cF9olxAWedHQDP5zYMG1sa9Fu+guWFtFD5cLW7imPyujM6vGdu8915AR5T5bXzm+
	 lISFk9mtFuTMv4U8cOMh5l1vQfQXtteqCwdeAU6SssPa4VLAK0SPAP48+zshzw7JSD
	 BRO6C4A4/JCf/JqUXJfSkNwNuc3QR18HXmzm9RgffmBgrx5xp7r1bJtypZHzUBdgAa
	 m5h7U+eL3xmuQ==
Date: Sat, 18 Jan 2025 12:27:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: victor.duicu@microchip.com, matteomartelli3@gmail.com, lars@metafoo.de,
 marius.cristea@microchip.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: pac1921: Move ACPI_FREE() to cover all
 branches
Message-ID: <20250118122730.26740fde@jic23-huawei>
In-Reply-To: <CAHp75VeDAOofiDg--mVs2M416biv8qCeVFw_PJM_YJZq=xuvTw@mail.gmail.com>
References: <20250117065314.4431-1-victor.duicu@microchip.com>
	<CAHp75VeDAOofiDg--mVs2M416biv8qCeVFw_PJM_YJZq=xuvTw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jan 2025 16:36:08 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jan 17, 2025 at 8:55=E2=80=AFAM <victor.duicu@microchip.com> wrot=
e:
> >
> > From: Victor Duicu <victor.duicu@microchip.com>
> >
> > This patch moves ACPI_FREE() in pac1921_match_acpi_device()
> > in order to cover all branches. =20
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
We are at an odd point in the cycle where my fixes branch
has an odd base so I can't push it out without messing up linux-next.

So applied, but you can't see it yet.  That will all unwind during
the merge window

Thanks,

Jonathan



