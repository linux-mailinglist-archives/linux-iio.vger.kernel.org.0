Return-Path: <linux-iio+bounces-8194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F179946975
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DA1281D21
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994BC14C5A1;
	Sat,  3 Aug 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IILy70xm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF64A2F;
	Sat,  3 Aug 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722684094; cv=none; b=FZqEc7XqL1okuX3aqXA4v70U1GayeQEtieNUgQgzk4rtzQ2hmnuPSYgsvrNOq0zjHi782tIwFnyWcTI9s50QsyLNhYgAPP3Gu0rft8xAJxnCgTVqVCqgkD5N7WIZNo74PC5vumebSAYZ8EUatvZJCl5DpC8Cxo15bQFhagW3+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722684094; c=relaxed/simple;
	bh=bjxkaPPNfgEGeJM4wfWPLDeFdjy4DE0IeEkh1Py7n6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHpH7hqbiJV3f12O7U4I7k41dUU/ODfL9BkL5lmsgIO0stz4AjAG5mC0cs/undxxk9bzl27GRaFdnNJl67mVLhcFirH8G+DiU8mFtG4V7KWeG826P8qreVdvzu/KavFX4LFGcHrutIU8+44Cum99NWyyawb63bQkv2DlLXdRf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IILy70xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF8EC116B1;
	Sat,  3 Aug 2024 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722684093;
	bh=bjxkaPPNfgEGeJM4wfWPLDeFdjy4DE0IeEkh1Py7n6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IILy70xmDoCTodYnbpz08gL7NGDGgBt5qrxTeJjat2xBBvDVjtmRSYaz3NKiCOihq
	 YgPn2dXdccL3/MnWiC4P+x4GDaaRYgnCBgZjkl3XsHXRhn7wUFuKd9M45bg++TAcxQ
	 eW9A978bhOFJ1+AK/pMad/+Z82fjXCPPrVAoEHaxy9kC4YV1jtTYJqCI9FWCPQmoBF
	 CO9mI0uHibngAe9SmNN5nb0gfjUTpa58yxLG4M8o20H66yWMuJ2Wi0Fgl4dPIu8pkX
	 euCJ7HU++hy+2rV7C3GofY8zgTFac5uGU9DKbCTPdmChGNxLmIbqZ6VgZ3deXi4Hfs
	 2xN6jW/N7UUtA==
Date: Sat, 3 Aug 2024 12:21:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Lars-Peter Clausen
 <lars@metafoo.de>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: ads1119: Fix IRQ flags
Message-ID: <20240803122127.221da36f@jic23-huawei>
In-Reply-To: <20240731142016.6immldd7i4y7v2iw@joaog-nb>
References: <20240731140657.88265-1-francesco@dolcini.it>
	<20240731142016.6immldd7i4y7v2iw@joaog-nb>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jul 2024 11:20:16 -0300
Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gmail.com> wrote:

> On Wed, Jul 31, 2024 at 04:06:57PM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >=20
> > Remove IRQF_TRIGGER_FALLING flag from irq request, this should come from
> > the platform firmware and should not be hard-coded into the driver.
> >=20
> > Add IRQF_ONESHOT flag to the irq request, the interrupt should not be
> > re-activated in interrupt context, it should be done only after the
> > device irq handler run.
> > =20
>=20
> Reviwed-by: Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gmail.c=
om>

For the direction, there is a risk that we will break someone who
has a firmware that isn't setting this correctly.
I don't mind doing that if we have another board that needs control
(and is setting it appropriately) though.  Is that true here, or is
this just cleanup?

If it's cleanup we tend to leave these alone (but not introduce them
into new code!)

Jonathan

