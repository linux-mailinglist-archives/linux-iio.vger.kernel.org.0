Return-Path: <linux-iio+bounces-5313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C08CF44D
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 14:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2E41F212CE
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3949BDF5C;
	Sun, 26 May 2024 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8ANDBL0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2058E55F;
	Sun, 26 May 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716727453; cv=none; b=svGBuu0dydubuuo1KlkEoXSo8EJKA4zgAxng1GJMXVcZYFzne9ZOk8QTaL+M5N7Ewk9Pe7+XaLs2Xfw/KylgrXCw1DGjlKuvMSAaMWwPO/XmmQwyQxJV5QPXcaewKiKDw18ymOZp1x3RaSfNQzRxjFKLFyl6Z93R/LI9sg7XoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716727453; c=relaxed/simple;
	bh=hBzV6FgMM5YCNorVFd0uf12WCp/mI0demg44nwp60mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWyzMYFoQdsk1LfwNpiQyULLYxIqLIOqSdMs9bggFyHCYsaTO3DykLvTEiMmLO++QbzRn5jh2uFq3CDs5g+pz+6WVivR6bkGrr4IAtNeQjE42LEzjHknikSoxDYgpGfJfTTTCQlnfKpyxiDiHgGNdUI4XvDH9YD4pz0dIPlFTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8ANDBL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC60C2BD10;
	Sun, 26 May 2024 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716727452;
	bh=hBzV6FgMM5YCNorVFd0uf12WCp/mI0demg44nwp60mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t8ANDBL0DdRdYYPX4L/oQqNuPvPDRBaf6YDczoOyjLtsBwKtLbSj5n/iz3MrQ5RGR
	 eH2QBu6uYahDHeq0KkTdJWoow7E1I8qholMIow36TvpxX+wHXpoa5Gi8IJGsfiDgkf
	 a5P9Hj9n8sBxtc7SLOkrM0b9b3bB1p056BW4lk2IwOTNYjSMMSCdFE5tDzbN7TyIsk
	 uHBoUiRDPdEKN88ailfk2OAM/CXyk4LayHSpgza2gfWDG5+qtamC3ZZWYUXf5U75jf
	 4wMlIVLrLLyqqXmqYZoMAPhZkpMXUjkmtQ3x50ki50tLBxbTawmyu/xPAYk0LeUVLa
	 ZEwuQjt9eXlYg==
Date: Sun, 26 May 2024 13:43:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v4 08/10] iio: imu: adis16475: Re-define ADIS16475_DATA
Message-ID: <20240526134344.6675ab5c@jic23-huawei>
In-Reply-To: <4ccfe084339360695edb5ae774a3bc67b1781c95.camel@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
	<20240524090030.336427-9-ramona.bolboaca13@gmail.com>
	<4ccfe084339360695edb5ae774a3bc67b1781c95.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 May 2024 12:47:38 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2024-05-24 at 12:00 +0300, Ramona Gradinariu wrote:
> > Re-define ADIS16475_DATA such that it takes _has_fifo as parameter.
> >=20
> > Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> > --- =20
>=20
> I may be missing something but do we actually need to patches redefining =
the macro?
> If I'm not missing nothing the first patch is only relevant for the new A=
DIS devices
> which are added in patch 10. So maybe squash both patches changing the ma=
cro.
>=20
> - Nuno S=C3=A1
>=20
If that's not possible for some reason, give them both slightly more detail=
ed
patch titles. It's confusing to have them identical!
=20
I'd prefer them squashed as Nuno suggested.

