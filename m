Return-Path: <linux-iio+bounces-15944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D728A408EE
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6DA703499
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB13155A4E;
	Sat, 22 Feb 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiOB6dbc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7781552E0
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234285; cv=none; b=nfddqcu5sffZAg2cRhd9UlUcOZmO5Lml9BbQFJ+d1uchviKoVzRwa6z0kOCHS4cZ5PV0wEe7qVLE2+r8LbkDyEAkP/aWL5F3sXxEWz8dKHOQTN1kzduJh1IqQ0ys03OeMQEVTPmYhYAboryxeA1tz1iT2vxleH4o2pxOwW70oL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234285; c=relaxed/simple;
	bh=xPqLSiRoVJOM1Lv4eJ+fsaqlBwscjuG+e/bKyfHnFHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebjuUnHxh6MylMb0i+unzJ8FsXJcnaGjJUESDPbePR87I5Ouge4DVRmCErV5QCtnt4xPkPvNcTLdY+n5z+YPJ7PL/Xu190/I1+ri/03BHrJgw1o/mhVx5Lv5q++A3twZAa3betb3iVGOURyWmIanmiB8Bpx6KWkSPsQ1lMAoVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiOB6dbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFEFC4CED1;
	Sat, 22 Feb 2025 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740234284;
	bh=xPqLSiRoVJOM1Lv4eJ+fsaqlBwscjuG+e/bKyfHnFHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OiOB6dbcYoANz82I3UtohlX/6Can8F7ufTnFiKXDidGhU8NhyZHkCAReygDA/uQdw
	 /67jXYCkcWMA7Nz1JtnVkCxuyZyKvgsm1S0sMOrnmNjiOTDtpVj1A1D7iZEM0P2A/y
	 8bvvji1ypLf0xn0JnIpTWFvzQepwyVqbEK13wiB759PshMbnV9TCwSo0YxAVglL2t2
	 EsSuOHWmAn60IFpySzNY50A7PDnsa/zW8ZupSOPfbMnVbuc/UOBy5zOajdj9IlAjXK
	 mi8v8Raa9AoBp6u7NLN4qJDQVt6vys/H4oDGsqD2gJ08bUz48ihCtu5HPg9s3WKLdy
	 wlYehqMAlCE8Q==
Date: Sat, 22 Feb 2025 14:24:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: replace of.h with
 mod_devicetable.h
Message-ID: <20250222142438.16e051fb@jic23-huawei>
In-Reply-To: <3ea6bd9d-4ef1-4cd6-b08e-54058e97938a@baylibre.com>
References: <20250218-dev-axi-adc-fix-headers-v1-1-5ddc79221d8c@analog.com>
	<3ea6bd9d-4ef1-4cd6-b08e-54058e97938a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 09:54:23 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/18/25 4:34 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Don't use of.h in order to include mod_devicetable.h. Use it directly as
> > there no direct dependency on OF.h
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > --- =20
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>=20
>=20

Applied

