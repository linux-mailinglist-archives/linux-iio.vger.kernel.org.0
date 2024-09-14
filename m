Return-Path: <linux-iio+bounces-9568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81175979197
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383E01F21E77
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3641CFECC;
	Sat, 14 Sep 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfvtV97l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C41E487;
	Sat, 14 Sep 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726325126; cv=none; b=NbEWpTdLfNSaMmwRnBdqTxyqteiDXwn3oifdpB+UJQB+NCsv68V5wM7MdKl+U2pOO7GwUxU2zXCRoPH8bakfgIsT5EXQy7qAF1cwv1ONu3TImf1ZGUhmycALWvgBW50V18gKdzRDsvKpJqkGfwCcfOD2U2DKVyUTnZH8BomLibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726325126; c=relaxed/simple;
	bh=fzmabugR93vyQEesPLr9AM03j4Ffq8r9Ysvh4DSqyvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXFBNNt2H+ME1rM20yTlBgyj59Im252UuyPCPxt6Do4aPFDfGLvflNuW9bTc8PzEo3iNnt8MXY5h1jkz6aAjlmxOh8bL4OYn6Htn5hcpFkpsKMI2/yiOOG+mce/yWRrABmpHoq4lESGTal0A7N4kj2EKwR71z5BwcUfvFKQynng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfvtV97l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DE0C4CEC0;
	Sat, 14 Sep 2024 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726325125;
	bh=fzmabugR93vyQEesPLr9AM03j4Ffq8r9Ysvh4DSqyvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MfvtV97l5rN9gxgbWdM4/cfV7cmqB8pMA7Te4lxKc7IeVeIpm0/sOerUQRi0eIqqg
	 zf2jNqJ390GUwCF9EPZmf0n3GlWStohGmpJb01nQ2R+B7GRXzZp4OYyF+e6pfjof0P
	 XXBgh5k3SiAfdZAwA6XtMNnsEX/NGocVDHKHG27A7cw+mYH5RGC02VC1FhZop2xziY
	 +QFN4b78+yk91bb1Na3PA1X0GbYnpHEnfGFgX5sOiWMH3/3u08GYmWUQZ7mOyCv9kb
	 83NWq69BhDq+qAaLxGN7Sv8lVHDVbIEeFVRm8oaF5bm5vqY8nB9s/dXPlwXDE6UoiS
	 uVQMl/99Db0Nw==
Date: Sat, 14 Sep 2024 15:45:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com,
 dlechner@baylibre.com
Subject: Re: [PATCH v6 0/8] iio: adc: ad7606: add support for
 AD7606C-{16,18} parts
Message-ID: <20240914154518.3adfbeca@jic23-huawei>
In-Reply-To: <20240913135744.152669-1-aardelean@baylibre.com>
References: <20240913135744.152669-1-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Sep 2024 16:57:35 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
> The main difference between AD7606C-16 & AD7606C-18 is the precision in
> bits (16 vs 18).
> Because of that, some scales need to be defined for the 18-bit variants, =
as
> they need to be computed against 2**18 (vs 2**16 for the 16 bit-variants).
>=20
> Because the AD7606C-16,18 also supports bipolar & differential channels,
> for SW-mode, the default range of 10 V or =C2=B110V should be set at prob=
e.
> On reset, the default range (in the registers) is set to value 0x3 which
> corresponds to '=C2=B110 V single-ended range', regardless of bipolar or
> differential configuration.
>=20
> Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.
>=20
> This changeset, does a bit of rework to the existing ad7606 driver and th=
en
> adds support for the AD7606C-16 & AD7606C-18 parts.
Other than the issue the bot found this looks good to me.
Will let it sit on list a little while though for others to reviews,

Jonathan

