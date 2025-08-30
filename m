Return-Path: <linux-iio+bounces-23476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E470B3CDC4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E50D3B9511
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08473D81;
	Sat, 30 Aug 2025 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJQ3PhiL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF7DDC5;
	Sat, 30 Aug 2025 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573544; cv=none; b=AJHJlUNb6WCX+cq5Dz0W7F2wVCEd7tJSI+F2dF1OYXc1FYPygnRNGuMkZItUjRHDHLJBdNkuXLtSrUVCdEIYnSqdA/TjIuICV5V2FhckpcLwJuJsEiPWxcFnaPsb4/NnSba0q+nUq57wVpmtRQYqk3QsNwCITHqlEhdOgMv+HFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573544; c=relaxed/simple;
	bh=eTss+tejWEGg1mKQM7asssNSW2kckzN0fP1SuB3qmso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYvfqkUjGyPIcQvQkp+XXkgnomtm4TCiAzfpcaqhlPbzDInZY6tgsXmcOvSmZDLHsWewomi81VMpjtkzTVO6RbQjdYntSLTqIIK3DqxfMQLj5VjyBxeCY6xlIQtHROGy9Owa1tikplDJo62jmLaYbXsKK/m2swwktb1RkbGBYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJQ3PhiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58547C4CEEB;
	Sat, 30 Aug 2025 17:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573543;
	bh=eTss+tejWEGg1mKQM7asssNSW2kckzN0fP1SuB3qmso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jJQ3PhiLcPaSVCVTsb0Ib2Vr+Y8h5AfTUs+x6AEL49g9SVA7OUrDyNEjUzoWMuXFK
	 pJnQA5j/WRLX2LbXMNzhBN99+Yiq+t+ITmn5d7BA5fDBLmEc8SMf6CHlJB+pWnk/vc
	 pANhUN3d+Pu+cTIMBuhg9ZlfO/kTpRyIlJIBmfqp4Ck3zBmJVsa4dUhqghGZvdf8fw
	 rLugktXKyIdpIySY5Fg8q92o6OowS/2f/x8vp3llwsZ1EVmF+cCHjFc6YU+gYBuxOF
	 1+0YI1nk48X9yMG3zJhUjpWy8As6pU3hc0otiNrapkS1QUwMxKPa3OCymCrsma9ZWa
	 IYHnTUY1U8VHg==
Date: Sat, 30 Aug 2025 18:05:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, lanzano.alex@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: ABI: document accel and roc event
 attributes
Message-ID: <20250830180534.24a8ad56@jic23-huawei>
In-Reply-To: <CAHp75Vf13aqDJj2j7MtfLTAT2MW-S3+M7wtEXsG1Wh7EKfxJSQ@mail.gmail.com>
References: <20250830115858.21477-1-gustavograzs@gmail.com>
	<20250830115858.21477-3-gustavograzs@gmail.com>
	<CAHp75Vf13aqDJj2j7MtfLTAT2MW-S3+M7wtEXsG1Wh7EKfxJSQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Aug 2025 15:49:50 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 30, 2025 at 2:58=E2=80=AFPM Gustavo Silva <gustavograzs@gmail=
.com> wrote:
> >
> > Add accelerometer and rate of change event-related sysfs attributes
> > exposed by the bmi270 driver. =20
>=20
> Seems to me like the absent attributes that are already in the kernel,
> should be added in the separate patch.
Agreed that would be ideal.
>=20
> ...
>=20
> > +What:          /sys/.../iio:deviceX/events/in_accel_x&y&z_roc_rising_e=
n =20
>=20
> Out of curiosity, is it for real? I mean & (ampersand) in the sysfs
> attribute name? This is quite inconvenient for use in shells.

Yup.

Easy enough to escape...

It's really wordy to express boolean relationships without using symbols.
This has been in the ABI all the way back to the beginning I think.

Jonathan

>=20


