Return-Path: <linux-iio+bounces-22820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D887DB28E22
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAE71CE19FF
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C62E5B3B;
	Sat, 16 Aug 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmDwhStw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CA2E336E;
	Sat, 16 Aug 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755350755; cv=none; b=WLN+BwreRh03ANFEW0D1jsnL/J3XBABTFRXChWPs/wax4Jyq+YjF1GqqCPXKN7kx2WnAk7z79ih1UtoQzIPvhbULWMeX2jBOTr0LhhxU1JvTtyMwVYR7aHgwryFWCy/KBjotN0F9kG5UtrKAYCHgFFrewrrqyLbjcflmbLP+fKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755350755; c=relaxed/simple;
	bh=890RF2JWg4IgMP+9dRktXmbETIMTw4ix0Tb+YoqDhlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnLnDadDk/zar4KOtZ9PFgM4F3iajFLGMtTrZPKCOlUAtikKYnrakauNJG8WYYJmSLwx4G+Ty+Ic5n19KEHdjJp52pnur/96egTIGTuNUgxmGkCtBHiEa/uFlGW8sSDB39HHSDVUv3csIsnqybkPxAG1pGMlwznutNZygv+QaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmDwhStw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BACC4CEEF;
	Sat, 16 Aug 2025 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755350754;
	bh=890RF2JWg4IgMP+9dRktXmbETIMTw4ix0Tb+YoqDhlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SmDwhStw5Ui48Q6uHwzDpZJZ0oWpXOCvO92JeEK/UXQ6oQft0dI2J4g2CvLzX1ln5
	 D42fsFBxZZr0K2apyceAfC1uN9PkTYwEcx84WSLqSCI/eBfkE07Ngz2drhMft9Z9b/
	 3T5Mx5awJhP77otGAnJqsH2Ebk6TfLik97a2FylSbLWjTzllPvfZQyH2A5w0vtD1VZ
	 8tWXKN8yygqwnX2bbklU8BzL/16xBFWeqe2XIx1PqC7tH/dOFKl2ccmqCXzuCjjrU9
	 hT86OSID+BMFXrEWh8QyWdbWSfHbZlv/lltu5Zqviud9tDBotXnSrUzJ1J886gUUM8
	 WeeyaneAF+FWg==
Date: Sat, 16 Aug 2025 14:25:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@anaog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: iio_format_list() should set stride=1 for
 IIO_VAL_CHAR
Message-ID: <20250816142547.1c18a7e6@jic23-huawei>
In-Reply-To: <aJyP5PhTcNv8QWQL@smile.fi.intel.com>
References: <vidvwybkm3vwmtopihyaj6tlvswwa5ixmgptfzpk5ujl2ixjjb@olz6275ftabs>
	<CAHp75VfQFN+F0xMyhWvHOejD0AefDfBLf9s4eu1bpqCBY7bkdA@mail.gmail.com>
	<aJyP5PhTcNv8QWQL@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Aug 2025 16:15:16 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 12, 2025 at 10:44:13PM +0200, Andy Shevchenko wrote:
> > On Tue, Aug 12, 2025 at 1:13=E2=80=AFPM Ben Collins <bcollins@kernel.or=
g> wrote: =20
>=20
> ...
>=20
> > > Signed-off-by: Ben Collins <bcollins@kernel.org> =20
> >=20
> > Please, keep the Cc list after the '---' line (note, you may have more
> > than a single one in the patch, hence you may just add it here). This
> > will reduce the unneeded noise in the commit message as the very same
> > information will be available in the email headers and in lore
> > archive.
> >  =20
> > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > Cc: David Lechner <dlechner@baylibre.com>
> > > Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > Cc: Andy Shevchenko <andy@kernel.org>
> > >
> > > ---
> > >  drivers/iio/industrialio-core.c | 1 +
> > >  1 file changed, 1 insertion(+) =20
>=20
> Forgot to add that no need to resend just for _this_ case, take the above
> advice for the future contributions. I hope Jonathan may remove these Cc =
from
> the commit message.
>=20

Tweaked that and applied.

Thanks,

Jonathan

