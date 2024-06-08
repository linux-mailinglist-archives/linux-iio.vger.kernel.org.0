Return-Path: <linux-iio+bounces-6075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4E90130D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0138F2827D4
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A7D1C2A3;
	Sat,  8 Jun 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRaztyqo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844151BF2B;
	Sat,  8 Jun 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867917; cv=none; b=KqSFWUcAzIWhsW9Uiv4WvOW138XCJFB/bw//fBedAhkAUT5uT0Vr59c+mOE+1Ro6p4xOgHtP/F/bxJ4GOV4sBmet72fBmG+/P6C4n2aSDtWfhsZxHHuC4VhqjkudDtYyM3ohoXy3roVPE/zhpt0uKr3gdyM3AL/H3MeTboLEufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867917; c=relaxed/simple;
	bh=9CoFCdmwD77xRwqsXokhReaCzROWC7hV5HtjLditw7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTQ2eU3sNUez5EhRiAaIV+4l1bdJD2GMZQZ3cKZQBpuuC7gKbmx4YAp8D6mq/JUhHtbm41X94bFMiUBGEyMx1X6qz1Orx1Kv8EsKqxPxrL/7wHp9BoyY4gch0lGWOzvyOKnBMOIbg7poukWbuim7eb22AppergyfWXl9+FCGSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRaztyqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7239CC2BD11;
	Sat,  8 Jun 2024 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717867917;
	bh=9CoFCdmwD77xRwqsXokhReaCzROWC7hV5HtjLditw7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BRaztyqoiS7201ErgyBZakfm8XQeSiDCyUypZsurgxGNSJfbysBkD4ylzq/yL3k7b
	 6c5QAreLpuBj2RVDXVZX/5Khq3uq0L5jj5Gl6n4grZfBR9enG1C8ABIN3RLaz+c/Aa
	 vmmllsBaBVpaFF3tYkfeHHTYLgSHuaKjo+Z0hYFQCRwPJCe6qBc6pYtygO/kbzA0RD
	 XRO34b3v28bDxWsdiskHYGBZAyDusQ87DroN50jQX8IelyyBib3jDxed50l+AX15S/
	 Q8LFfgLFVPUkfihMGTacRv2GMiWnMOJR+k3a2c50Aycvqv3MzXE8UV1Gzp0aWPeHQ3
	 m9H0ehzpVoGsQ==
Date: Sat, 8 Jun 2024 18:31:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, AML
 <linux-amlogic@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] iio: adc: meson: add support for the GXLX SoC
Message-ID: <20240608183146.2a71572f@jic23-huawei>
In-Reply-To: <1E90764E-5D50-496A-B4DC-3D3982392183@gmail.com>
References: <20240604055431.3313961-2-christianshewitt@gmail.com>
	<202406041751.elQWr6cj-lkp@intel.com>
	<1E90764E-5D50-496A-B4DC-3D3982392183@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Jun 2024 07:15:58 +0400
Christian Hewitt <christianshewitt@gmail.com> wrote:

> > On 4 Jun 2024, at 1:10=E2=80=AFPM, kernel test robot <lkp@intel.com> wr=
ote:
> >=20
> > kernel test robot noticed the following build errors: =20
>=20
> Apologies. Build errors are because I wrongly imagined this dependent ser=
ies from Martin to be merged:
>=20
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/2024032323130=
9.415425-1-martin.blumenstingl@googlemail.com/
>=20
> To be continued!
Given that was a case of not going to right mailing list, if you want
(and Martin doesn't have time) it is fine to pick that up and send it
a single series with your changes.

Thanks,

Jonathan

>=20
> Christian
>=20
>=20


