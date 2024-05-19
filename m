Return-Path: <linux-iio+bounces-5103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097598C94C8
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3901C209B7
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4D482D0;
	Sun, 19 May 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T91Wes5i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76145BF9;
	Sun, 19 May 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716125086; cv=none; b=LNaclUTpeVyrVEMFjt3DQYBCILZnqVZ+t2gB9JhEvpemqIAgtbtbxwYLXybtU8tp2ATbqkodTrdqrZKZeEn0WU5D2Z6/MRenbuzW4XX+gv/fZrDZvvgHm56eSfAAFAdJH7zB4GgxUkuq5PjwZPmus8QqIvKDmm6qcBeu3jcO/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716125086; c=relaxed/simple;
	bh=CucozrtdOVuNaSrdIYeewqNiTGAWA4ZEe0MjrxLng5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o83qKVFPGeA0wfMUEJrU16EY9+K6h1wgFdhTko9rL8tR6FlbrJ5z08sIljPclBlGn8X9awzaH3eS0thwuvM1FWs8MSdNnpUm2F/mcpZIRBBPTzyVIsDcvGXHKGbJGtjQxE0B7kpk12zYL9FggePPFWMVU//6SpX5yMIBCYrNrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T91Wes5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3687DC32781;
	Sun, 19 May 2024 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716125085;
	bh=CucozrtdOVuNaSrdIYeewqNiTGAWA4ZEe0MjrxLng5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T91Wes5ie51G0mISD7dSe4rk2hcDwyA/4ToQhoposuE+NeGuveGbr0bDocWJI+Z5O
	 9mtJNWl/ZmAd8hxmk2DdSqrZTYwUz9RD5LfsWt2mEoneYze4jSB3iQX1cDOFIHeMl4
	 fqnr1idRqUrFGPcCtTWYITdbUEeqRkLiYWOlcEisnpeurHKw0qOsUl5WCKAvDefFbx
	 MFA7+gRTJyORtqN4vxbfzI9V7mWZPkNIcwrBKKIPT+Ka2w2Ga8ed2UZPiXPd9yGFx3
	 hpxyR4TnNBCXrUu7zd32mufkCUTpAa6Jf6P/OGHNfCUxqWdnYInz2kp1etamxcCV6x
	 fg3ahXsAr0CgA==
Date: Sun, 19 May 2024 14:24:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Gustavo Silva <gustavograzs@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lars@metafoo.de,
 gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: chemical: add driver for ENS160 sensor
Message-ID: <20240519142433.78fda3b5@jic23-huawei>
In-Reply-To: <205163e0-e2bd-4ed9-9f51-e20468f77655@wanadoo.fr>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
	<20240512210444.30824-4-gustavograzs@gmail.com>
	<205163e0-e2bd-4ed9-9f51-e20468f77655@wanadoo.fr>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 May 2024 21:12:55 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 12/05/2024 =C3=A0 23:04, Gustavo Silva a =C3=A9crit=C2=A0:
> > ScioSense ENS160 is a digital metal oxide multi-gas sensor, designed
> > for indoor air quality monitoring. The driver supports readings of
> > CO2 and VOC, and can be accessed via both SPI and I2C.
> >=20
> > Signed-off-by: Gustavo Silva <gustavograzs-Re5JQEeQqe8AvxtiuMwx3w@publi=
c.gmane.org>
> > --- =20
>=20
> Hi,
> a few comments below, for what it worth.
>=20
> BTW, why I'm in copy of the mail?
> I'm not a maintainer, and not active on drivers/iio/chemical/
> Slightly proud, but curious as well.

Now we have evidence you'll review if CC'd, wait for the deluge :)

