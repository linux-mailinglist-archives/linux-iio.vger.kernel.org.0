Return-Path: <linux-iio+bounces-4104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8147089AA53
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 12:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829EB1C20E17
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7422EED;
	Sat,  6 Apr 2024 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGo6eGx4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0772C182
	for <linux-iio@vger.kernel.org>; Sat,  6 Apr 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712399278; cv=none; b=YWohoiFRGvmzVl6vEcT3OHdL9mMSIcMWR57D4gC0PqqSABl3cZS9KEGRctvfZwOqRFCfcoGOuXObvL85qoBVSFy2nd05CHiUNZ009MNshopN8W0wG2Y8QD7zd77tNrQlo/uFCW+izW5P14iNYQLka7omkfILEhfg/J74v5IuXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712399278; c=relaxed/simple;
	bh=55oC2znzUpXZqVs1SGzpYux6yxLYhgx79gP0AwFlGDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKfYof5IBMjMjqIHYbtimItQ2W2Yq0ehyXTNxYGmnsyxBeeKBTYa3lpH6VQXy3jvaVp49PpKbDe2TNN2mlziZ/4aAitbaNVeoR6eDbH3krQxW8J26VyMILQvTAEoKrQdpJJByYvjrBiHD/rQGw2EVm0sK8l1j7lr9rjpUhU0/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGo6eGx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C1AC433F1;
	Sat,  6 Apr 2024 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712399277;
	bh=55oC2znzUpXZqVs1SGzpYux6yxLYhgx79gP0AwFlGDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aGo6eGx4iYrX4Q/eH8xp+hOGK+2txBjb9vyIti0FDrVwfXtIWPhDn0jNg7Ky0EWHX
	 1IIEJXzOCssS3dMkRuFOvRTpxqGMJEia7TmQnm2Bdc0XDzI0mNCehIbhi8SRy3+dnp
	 KpFSol/VdwW0frktKkLyKsPonO6zuYz6gwWCedsCaM7IZDfoY6mg9r1pq1orpyTGlL
	 EIX5Vrn5Yl/4EDzmY2DLjLkzsYl4f8ATDlKgD2J4AbiqinW1OHRz5WEGrayG9gRRff
	 AP9QOceECAo2ihhCXWJWBIJEJRVcAw+Z9q1TxlKlvDtdqKUwRUYKE7zUwvi3eQsMLj
	 mDU12egYk55eA==
Date: Sat, 6 Apr 2024 11:27:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, <linux-iio@vger.kernel.org>,
 "Marius Cristea" <marius.cristea@microchip.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Kim Seer Paller <kimseer.paller@analog.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Cosmin Tanislav <demonsingur@gmail.com>, Nuno Sa
 <nuno.sa@analog.com>
Subject: Re: [PATCH 1/8] iio: adc: ab8500-gpadc: Allow COMPILE_TEST builds
Message-ID: <20240406112744.64f53089@jic23-huawei>
In-Reply-To: <20240405113622.00000896@Huawei.com>
References: <20240330190849.1321065-1-jic23@kernel.org>
	<20240330190849.1321065-2-jic23@kernel.org>
	<CACRpkdZzOi5vv6yxqheqGZAZYBLTEL-uB=dt-i6ByDEhF6H0Kw@mail.gmail.com>
	<20240405113622.00000896@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Apr 2024 11:36:22 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 4 Apr 2024 13:36:15 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>=20
> > On Sat, Mar 30, 2024 at 8:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> >  =20
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > The dependencies on various ab8500 components prevent this driver
> > > being useful but they don't seem to prevent it being built.
> > > Improve build coverage by allowing COMPILE_TEST.
> > >
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>   =20
> >=20
> > ...but I think AB8500_CORE is a hard requirement because
> > <linux/mfd/abx500.h> does not provide register accessor stubs?
> >  =20
> hmm. I clearly didn't test enough.  Ah well, I'll drop this one.
> > Yours,
> > Linus Walleij =20

Tested again, nope, AB8500_CORE isn't needed as far as I can tell.
What register accessor stubs were you referring to? There are some calls fo=
r debug dumps
in that header, but those aren't used by the ADC driver.

Jonathan


>=20


