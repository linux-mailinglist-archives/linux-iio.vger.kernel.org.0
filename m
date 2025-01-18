Return-Path: <linux-iio+bounces-14471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C82BBA15E48
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B21A18870E9
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4021A0726;
	Sat, 18 Jan 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOuNB2kG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F019F485
	for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220513; cv=none; b=Uv8zcvzjVu7UXaKdgbmjBizj5pvHUp6rakm798jv8qevLraAnEtz9aYMKkbAK5lGT0ztXrF3Qf2L+yTaldNjDUL8v2l55JXvd1MC3ivz3YASpbAbBCMH0hVc7wiEhIs3lG1yyUWSq9mQILU5oD1u8GuxAceGHvEAEQF8i+LG+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220513; c=relaxed/simple;
	bh=RxpW+hkZOuAmqGFERtajBg8z4IQZd614UdK5v+fJEr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIsdfm62zTrfp1uy2TOb9D8N8Yupv/RmNAw03PQc1y2N4mHgF1OjevSv3465p3vhCwTJpAJVXWFAHEwDtiH0Ur06xKE817tddoHTzTzOcXFbkoj//NdNxlTp+bm8ZzRZq3TgtXmjrqbi+UEXX1JAK/3KmlJSt2YpkBL789hIMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOuNB2kG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADD7C4CED1;
	Sat, 18 Jan 2025 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737220513;
	bh=RxpW+hkZOuAmqGFERtajBg8z4IQZd614UdK5v+fJEr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MOuNB2kGGoE5PFzNQWyIT8nic28h/yp9jJNPRCuyqZm2LaN3gls83Vzv/um6f50Jn
	 yhaCFSrJsWLGShGhoLVo+NSYTCeteri1D6xu/0TvqZjB8qW8lkFcrmzYcJr7eLX7at
	 C6bz6bT3bYSsiNUWg2rM7OFtRU+j41Z24HABwZffb3N+/xIE3v+pqWtTM0NYqmAVd4
	 1cMpfc9a4zF+JSC0EF5vmOXQxn1MAG6uF7dnmAvGR8Y/aQsflHXfy3Y/KaUbNvoS/5
	 3VU4O8O8c1xYmBKHUes1jlhlMT6CmNKowREVc/cIEJW4yusIhicfYteeiALL9mBHZS
	 fXcHTctSsgl0w==
Date: Sat, 18 Jan 2025 17:15:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org, andriy.shevchenko@intel.com, Fabio Estevam
 <festevam@denx.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads124s08: Switch to fsleep()
Message-ID: <20250118171505.3bae679a@jic23-huawei>
In-Reply-To: <CAOMZO5BHw_dUKVnhE6F0nKp2OfC4Pi43ndfh6LMSU64MbxzNhg@mail.gmail.com>
References: <20241209181624.1260868-1-festevam@gmail.com>
	<20241215123040.36d60bd7@jic23-huawei>
	<CAOMZO5BHw_dUKVnhE6F0nKp2OfC4Pi43ndfh6LMSU64MbxzNhg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Dec 2024 09:32:47 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Sun, Dec 15, 2024 at 9:30=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
>=20
> > If the two had been together I'd have included this as well, but now
> > it's just an optimization so needs to go the slow route. =20
>=20
> That's OK. This one is just an improvement and can wait.
>=20
> Thanks
>=20
Now applied to the testing branch of iio.git

Thanks,


