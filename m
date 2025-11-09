Return-Path: <linux-iio+bounces-26082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F6C441D1
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F360C4E6CE8
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34DB3002D0;
	Sun,  9 Nov 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mevB3RxU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAC2FFFBF;
	Sun,  9 Nov 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704265; cv=none; b=u7cSnx5tBrBs7oKdapwghXwZ4dKFjnp+8jTLEwByA6YHbxJpsv/uK63jJoD85ccfRX/3AAG/NKoD32fTYMHQ8DY5LPIO4aEj5ePQPh3n1OT1c+SlJoSm0xxFFd7ETj0aMF/OtLNzAXpgp/uOXfQAlYgwHRAbK2c5Kq0POnD1BLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704265; c=relaxed/simple;
	bh=RQwvn8WRYaKj+tPXCnbYN2WFyV803ZvDilOGQVqmex4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjXFL5sP0wDXqppedBfQt9buguvgkrxuWcfUFPiHBGVf3Sdr/yhZeIr2lOp5htrYlTRzBAZTpETS0v3AQAp9aDZ3qRu9xKGo7Kvt9zRu+Jsu35c+70U5t3CNtIcrMlb97B1yc+ydFvI7y4bCis6OcXU7So/TJmyfxplvAUgSjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mevB3RxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED65C2BC86;
	Sun,  9 Nov 2025 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762704264;
	bh=RQwvn8WRYaKj+tPXCnbYN2WFyV803ZvDilOGQVqmex4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mevB3RxUfW4R6aA3TBzYkzaLujAvgFjVbTpKkw0MZcFkRYcspY3GVUJ4PlW+NcsJn
	 QOW6y9SGv1O7AxR1FrBIcwkniMuo6YhGfKDCNObLYN5VvbILTrliKLaordWulqblr0
	 GBTlsCaLlPVIXiRxSVEhXZWNy7btCcFe9LUMS2H44SfSa5WBzpBoq2HT0DsSvwYtvo
	 50ztRSIPEwGfbeazNRu7rctgJwDnLDU3zHSY5veXVtv6rbE6AlcGWXGf+Zjr+QxC0F
	 tnqkwpQ39eR9YjmfxWhKB28HZIpHDtVFXXyob2prKZkATxAHnIY/2hKO4Vt7xKJeiW
	 m3KiKE3dnDKug==
Date: Sun, 9 Nov 2025 16:04:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 02/12] iio: dac: ad5446: Use DMA safe buffer for
 transfers
Message-ID: <20251109160416.48497b3b@jic23-huawei>
In-Reply-To: <aQozkdWtQxv15Umd@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-2-6fe35458bf8c@analog.com>
	<aQozkdWtQxv15Umd@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 19:10:41 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Nov 04, 2025 at 03:35:07PM +0000, Nuno S=C3=A1 via B4 Relay wrote:
> >=20
> > Make sure to use DMA safe buffer. While for i2c we could be fine without
> > them, we need it for spi anyways.
> >=20
> > As we now have DMA safe buffers, use i2c_master_send_dmasafe(). =20
>=20
> ...
>=20
> > -	put_unaligned_be24(val, &data[0]);
> > +	put_unaligned_be24(val, &st->d24[0]); =20
>=20
> Now this &...[0] are redundant as you defined (by name) that the variable=
 is to
> be used as 24-bit one, i.o.w. as a whole.
>=20
> 	put_unaligned_be24(val, st->d24);
>=20

Tweaked and add docs for be16 and be24 given rest of the structure has docs.

J

