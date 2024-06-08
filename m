Return-Path: <linux-iio+bounces-6072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211AE901304
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FD41C20C9E
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115DD14F62;
	Sat,  8 Jun 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Aw+F0C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180312B95;
	Sat,  8 Jun 2024 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867416; cv=none; b=TKVkxMmGDlgm/idfYFzREtrSIG8IhUmHW4RW55pV+U+w+rnbX1TVIb7gEf0QB2zMkUFE4sHH7v3tz2tiOp8dVro4DkFO5u+37Ss1elq7a3sLwmEh2kMlualQPvKOupe5NXpSB3IqTXyByRdiuHemPzKaq0TMDagIK6/w2sjWpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867416; c=relaxed/simple;
	bh=mauOWTLBy/iG5crtqyO9tr74vWuQJlW7QV/TKLI1eRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKb3jXWJ7L0+qLy22f1QClx61rCyt5c8WBNt8uFe8hyH6iNPn+pu6XsdmKE+B0OifF3SDmqgJPMtKQ9/xlDVUi9UDHrGmDR7r1zFYpfD4ghdAroZ258Z9rsAz6EpNvi4vXYvKwDjn6bkVYDfSRnclvq0hapVVUtLE6UxD1YINz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Aw+F0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEB6C2BD11;
	Sat,  8 Jun 2024 17:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717867416;
	bh=mauOWTLBy/iG5crtqyO9tr74vWuQJlW7QV/TKLI1eRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/Aw+F0C0CCfT6LvS4KqXWDMYKiMAArkq/d1Z+xEP2cVIOj+lN2nl69GEi2LkT9ka
	 yhpVoNtDERJEJhwQDJpFwGBxq5RlKK+lIYXY1VnxSBsqqxwf4AmAt8EURsVFuMx1bG
	 Mserau9AltAcSI9P1CcMqqakCMdeHUFxolxKbv/o+oE8ZOcV5bU5aMpwfGQhbN/KnT
	 QuLAfQdggUBfQgHdcSOKCaT9qqlQQCeLx4EBpiXJDt8JQAws9nrc9HDXoUNZMTFyCe
	 D2fXPMZ+5WMFkf3WO8cevL0i3sJzJwBotPNFBHwLr7Z8Ve9lHZKJXKmwZ9sLUALGf0
	 LbAkI5lAJ625A==
Date: Sat, 8 Jun 2024 18:23:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@baylibre.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich  <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <20240608182328.7e486e93@jic23-huawei>
In-Reply-To: <89675b5391c3c37a69654f0cd4ffd0e2ea312056.camel@gmail.com>
References: <20240606155407.499344-1-u.kleine-koenig@baylibre.com>
	<89675b5391c3c37a69654f0cd4ffd0e2ea312056.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 07 Jun 2024 11:23:12 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-06-06 at 17:54 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > These drivers don't use the driver_data member of struct i2c_device_id,
> > so don't explicitly initialize this member.
> >=20
> > This prepares putting driver_data in an anonymous union which requires
> > either no initialization or named designators. But it's also a nice
> > cleanup on its own.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> - Nuno S=C3=A1
Applied
>=20
>=20


