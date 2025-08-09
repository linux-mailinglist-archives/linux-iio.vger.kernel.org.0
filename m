Return-Path: <linux-iio+bounces-22494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5235BB1F5B7
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 19:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CA434E10E1
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 17:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799A2277CA0;
	Sat,  9 Aug 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0VaT3/x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF551D618C;
	Sat,  9 Aug 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754761651; cv=none; b=L86zLxDR3L3ejlpkGPEWfkHzvRxbIq/jHeplC7Ft6T6X3vB/DZDorKbO4zGlHcybiCAn8MvSlm3ApweoL94XVxgEdjGWvHnkgGeHxo/Z9DjhOCH9+8XypSNDRL2qIfOtkuRvhKkuNCWs9b6PpcRc7GOd4dyN44r3pmHq2qLSVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754761651; c=relaxed/simple;
	bh=2pySo+y0CSODRR5cdQftQZ1uLPdfSk0OHDudX+OWhQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/RnkAnLdDAg+HObny6WwKjkq/IO1YDrwk2VzjXd1PLFZith9fCfeqdbUdZe4zjSPJuzG7MOORHV9zGwgGEqYyT12YpxW1hVzVVUTv/uWDGyLlx4J0cYT+XtekZPLtuLu6u/4MNbd0qU0xKYDz6GTRXr52HAx86tgo8odxkbMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0VaT3/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE7DC4CEE7;
	Sat,  9 Aug 2025 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754761650;
	bh=2pySo+y0CSODRR5cdQftQZ1uLPdfSk0OHDudX+OWhQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T0VaT3/xn09RQFBDQnSE7caWfHqXJ5Q1Mhq8LJP94fhaQR/sSxGZX5lFQ5M5wwXIp
	 wIbegSNMpGmRhZMymWEwY8MxCi1fKIi+d9vwf6IS9ENazVrOIx4CzQmp6g1xS25Xsr
	 6i96Vj9UkRygPftvrYRI0h9GVZ2YfU5X2JPIAT1mqEcZm1vQGBVt8JOW87o/9bVb6m
	 c9TBhczMHAOpKc7O6HdNuNs0lkHQARsDb4jLteYZl8gTLeqft1vBHztkQBI7ikvqvL
	 KCzADCppFsCr4jKYG0+/yCG1sTzKzRMEcbmMOh8zt87eYX7Lk6Yu8U5waNBU6s5olA
	 NVLKBe5cpS61A==
Date: Sat, 9 Aug 2025 18:47:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com
Subject: Re: [PATCH] MAINTAINERS: Update max30208 maintainership
Message-ID: <20250809184723.42ce6a70@jic23-huawei>
In-Reply-To: <CAHp75Vdgafv9hqtZYiouC_RgY+0m2a3TfOOsk12LUMDEmY+4AQ@mail.gmail.com>
References: <20250808190203.7493-1-marcelo.schmitt@analog.com>
	<CAHp75Vc1KgiDUUEjeEKdrSfom6NThPG-383O=sezydnrZLoGqg@mail.gmail.com>
	<aJdSYIv8_QX0WwdI@debian-BULLSEYE-live-builder-AMD64>
	<CAHp75Vdgafv9hqtZYiouC_RgY+0m2a3TfOOsk12LUMDEmY+4AQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Aug 2025 15:53:42 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 9, 2025 at 3:51=E2=80=AFPM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> > On 08/08, Andy Shevchenko wrote: =20
> > > On Fri, Aug 8, 2025 at 9:02=E2=80=AFPM Marcelo Schmitt
> > > <marcelo.schmitt@analog.com> wrote: =20
>=20
> ...
>=20
> > > > -S:     Maintained
> > > > +S:     Supported =20
> > >
> > > Just curious, are you really having this as a day job task? =20
> >
> > There is a request for MAX30210 support and so this driver may get exte=
nded to
> > also support that part. Though, even if we end up with a separate drive=
r for
> > MAX30210, it feel unlikely to me that people lost interest in MAX30208
> > as that's still in production according to MAX30208's page [1]. =20
>=20
> Ah, cool, thanks for taking care of this!
>=20
> > [1]: https://www.analog.com/en/products/MAX30208.html =20

Applied to the testing branch of iio.git.
Thanks,

Jonathan


