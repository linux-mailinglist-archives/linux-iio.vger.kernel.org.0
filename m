Return-Path: <linux-iio+bounces-23203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA68B33C25
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636E01890804
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6DD2D5432;
	Mon, 25 Aug 2025 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkiVHQCS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6A239567;
	Mon, 25 Aug 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116501; cv=none; b=NmDVw6OGRldIu9VseW4VW/0bZrfnBxa8DKsXg4aJDwx2rcLUujo+WTbcEXMPeef2mnhZJRbLM26KAH8Eyw5ZGgREVC29TYXmsfWOBsClL8x9kSdfU3/zxZAi25xBNn68I4e214MYmxJjaNC7WO2fdnewyIjjHkZiNVb/Fw4TYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116501; c=relaxed/simple;
	bh=rAfTV0ht9vAHtbKtchAUt7rdrtOVQlvGCAunap04Tew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2ySxSIVpQotVPs+kgqFh69rgvDz4oiB4ItyVclk9Q4KNtt3N9D8155Nuzr/wnyKFzwdAxBQlVw8LwTZ+L2W8OBlaVTkEqg2JA9mQ4Oz5ey9MaHpqouJ25TTLpbfGpc3tAxHKxz2DLFWflj53tOJg1dkjqFWYhHuO7X6rVfGtl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkiVHQCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22205C4CEED;
	Mon, 25 Aug 2025 10:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756116499;
	bh=rAfTV0ht9vAHtbKtchAUt7rdrtOVQlvGCAunap04Tew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QkiVHQCSDWGgNy3/DZjjxwWkSoq2ZSX+v+uBtB1QGkU0uUafA9FDddEyt4rzwl+Qg
	 T8DwqYryqZ80roN0WU84iC2TIEMtU6OCfeCrOJavQR9rp/SYNAPuopX7VQ9xK6kKNa
	 a706LcgPjYMhhwYJJoePOZdPKQUcy4F41uAzCajTuAdffrlkoEBW4NlReGopDKh3d/
	 rxvYjhMoIDX4sSCreD0oV5BIDfBOQSaJ5ssNdDHFuN/ohhej9AYr9ShEeynro+Dyvi
	 30AaiywZoI4k5dgHYv1k1aMkYIhNmtml+NQG9ham2R3MQqjhCJJHMZmGCr/jxuLa18
	 uvndcOejpr8rQ==
Date: Mon, 25 Aug 2025 11:08:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Junjie Cao <junjie.cao@intel.com>, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: core: switch info_mask fields to unsigned long
 to match find_bit helpers
Message-ID: <20250825110812.63c276c5@jic23-huawei>
In-Reply-To: <CAHp75Vc_GYzDw77deKjK5Pn9duGi0p8W4C2Z9kmVWBWK5qgETg@mail.gmail.com>
References: <20250820004755.69627-1-junjie.cao@intel.com>
	<CAHp75Vc_GYzDw77deKjK5Pn9duGi0p8W4C2Z9kmVWBWK5qgETg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Aug 2025 12:52:18 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 20, 2025 at 3:48=E2=80=AFAM Junjie Cao <junjie.cao@intel.com>=
 wrote:
> >
> > for_each_set_bit()/find_*_bit() expect arrays of unsigned long (see
> > include/linux/find.h), but industrialio-core passed const long * into
> > iio_device_add_info_mask_type{,_avail}().
> >
> > These masks are used purely as bit arrays and are populated via BIT()
> > (1UL << n). Switch the info_mask_* fields and the corresponding function
> > parameters to unsigned long so the types match the helpers. This removes
> > sparse warnings about signedness mismatches (seen with 'make C=3D1'
> > CF=3D'-Wsparse-all') without changing behavior or struct layout.
> >
> > No functional change intended. =20
>=20
> Thanks, this is better than v1.
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20

Applied.

Thanks,

Jonathan

