Return-Path: <linux-iio+bounces-17785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A572A7EC83
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F50174A9E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0560257ADB;
	Mon,  7 Apr 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUCBSLq9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E925743C;
	Mon,  7 Apr 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051938; cv=none; b=l69LHPTKqSpBuF4Xqu6qCs9S1rijFaZjqOKSK7FkGt7TC5JgUN3ytu4ugXnOpz+xuZr+5CB5kpRBCE+lIjzVGEHLMdG/uXHr/e097zZFuYcQzYx7ERK4EL0OAXyLLjLe9As9qzGLhk8PY7oB8Ciq7/iOeBXTkDQTENUnarRAbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051938; c=relaxed/simple;
	bh=vreekJCbYUyr2nBN19FV67KOaZwFS35iVay45wa/5hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZsyigiYkw2xTpC+pLCoIP7DtnnJfMXJanZNw0ANIn8Myrn5JBuIQOJxDM3Hp7pfVg2Dg0Zo24WRhMS7Lucli4kKJkIpG9gCeWjunuhrIq9JMncawsi+vTIKVYQ/RrVLRSPzmkAmQY0fhJdml4kcRAyLNvEbPijZKkoiwh7xiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUCBSLq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FFDC4CEF2;
	Mon,  7 Apr 2025 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051938;
	bh=vreekJCbYUyr2nBN19FV67KOaZwFS35iVay45wa/5hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VUCBSLq92YWk6t+iUGyKZi/BwANv9/NyIzmljd+F72XQVgO4MpizLewljE+oS9+OY
	 +r9lnwjCvi9C/eVqxetBRzE/zLpHlR+Mk+jYrjCw7By9rKyfE8jfKpEeGLQxvzYIZn
	 L6Y2AcfZbMHaecC4P0wft1S72/dcE+N/5zxYfmLv+kKdljmlLDJn7rPvGLik1cWts2
	 9HrGnBYykNIKXYNetN3RbU2O1Qy6iRIEPgpwTfVW+UPBFiubx5uX+uiqu9PPSicGhV
	 lj9ZYrX3nMPE+aIcE6qYHKdQiaRFdbovhjP/ybDh+kPlOUEmqELr72luKq6FJmpPNc
	 LgLpMFKU79lTQ==
Date: Mon, 7 Apr 2025 19:52:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gyeyoung <gye976@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, lars@metafoo.de,
 gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 3/5] ABI: iio: add new ABI doc for mhz19b
Message-ID: <20250407195210.2fea4461@jic23-huawei>
In-Reply-To: <CAKbEznuHUbzV_gGSvZssPQo_qSdx-saop7f_vPdrEphsB5gpLg@mail.gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
	<20250403053225.298308-4-gye976@gmail.com>
	<20250404123308.00003d72@huawei.com>
	<CAKbEznsozpnfFgy3Giamv3XJvf_XqPQ8ZF3TSZHPGfQhm+baFA@mail.gmail.com>
	<20250406122048.3d59c2b5@jic23-huawei>
	<20250406122628.7511e1b0@jic23-huawei>
	<CAKbEzntnZ+SJ07An+tD3ByrxqOR0FrJ09bymoUZODM0XXjYFQQ@mail.gmail.com>
	<20250406163338.7457f940@jic23-huawei>
	<CAKbEznuHUbzV_gGSvZssPQo_qSdx-saop7f_vPdrEphsB5gpLg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Apr 2025 11:10:21 +0900
gyeyoung <gye976@gmail.com> wrote:

> Hello Jonathan,
>=20
>=20
> > > > Actually - any idea what the gain is doing?  Is it adjusting a anal=
og
> > > > amplfier, or messing with the integration time (I have little idea
> > > > how these sensors work!)
> > > > =20
> > > sorry, I'm not affiliated with the vendor,
> > > so I do not have any information other than the datasheet.
> > > And the datasheet doesn't specify any trade-offs related to adjusting=
 the range.
> > > (only "=C2=B1 (50ppm+3% reading value)" is here)
> > >
> > > I think this range setting would be better implemented in
> > > some other way (like module parameter) rather than IIO subsystem. =20
> >
> > I'm not in general keen on module parameters effecting policy (and noise
> > vs range is definitely a policy thing) so I think we would want to figu=
re out
> > a suitable sysfs ABI. =20
>=20
> Or, how about adding IIO_CHAN_INFO_RANGE to the
> iio_chan_info_postfix[] array for range setting?
> I think there might be examples of devices that expand the range
> without affecting scaling,
> like this device (though I haven=E2=80=99t found a case yet...)
>=20
> If this is a valid approach, would it be okay if I submit a patch for it?

No. The reason isn't technical, but rather that if we provide that
we'll spend years explaining to people that _scale is the right
choice if the _scale is 1/_range (or similar).

Even without making it easy a lot of drivers try to do that!

I think leave it as an open question for the future for now.

Jonathan

>=20
> Regards,
> Gyeyoung
>=20


