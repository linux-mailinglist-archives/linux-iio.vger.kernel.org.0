Return-Path: <linux-iio+bounces-18250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC217A938CC
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10ED17CC45
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5FA1C5D46;
	Fri, 18 Apr 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRBvSKcz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C41C2324;
	Fri, 18 Apr 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987456; cv=none; b=UsusnF9+NpVLmZyDK5Hw9qRS73vIWYQyi1xhXy3mwQs9OgSsjzG+Hp0Q4aR6+P2NmNWxQRRBXO5Af2ie6CmWv9mAZ0qD1fgiE7KUdNbvBrgSNfPlV9QVsFdZb0ICYt3iakdFAxRSYbKFYmYXXcKMLlsV7BG5wH8shOTuyItxkIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987456; c=relaxed/simple;
	bh=GNhKko1seFHw18Ma89S0NH7KnQgIl9H3ALOI3HIBnDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfOrJBuUnYLFxfZm0C0Gkr5fvWDiXFZfb6kEvhTBLy92MQtgly85KThZz7Y45v6RawCSwMWlQ5DFORig0o9AyRAucBqxRg1fHi+Bw6iMF1WMBQ1lnEiepaSzS2n6AYCAC2sWrVed9iY4cYKmyTwbfc9snxF8Px9isTlv8XtHfN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRBvSKcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C04C4CEE2;
	Fri, 18 Apr 2025 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744987455;
	bh=GNhKko1seFHw18Ma89S0NH7KnQgIl9H3ALOI3HIBnDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IRBvSKczkNaeWa3oymabOo6nGXxglDbWbUFLfXy2Std4DBWNzRKIbXG/ciAKTygh8
	 eiN7QKXLBKziiyvYWnHvYOuKFglauFwqaBzx12mt6yqKLHOFJe8rb1VUB8y2Kl74M3
	 vBfaCgGHE8N7BqEJwlVcH+GN3EOZaogxv9aU18hLG3jgvCIvZ1+JOn7HZE9DaBgloU
	 oRlAFoBnbwDoqVo/XzofwhLs+fMI0eP+eD4A1zpMiws/8CmdHGopykOEcuVCyzBG6M
	 9ZYLR7iEB3IlZDuIS9gvpveNkyxaDkIRHxXIytxKhqFU3xHkz5C9du8AsDLJ9pUojM
	 rXJTYcPEi0SoQ==
Date: Fri, 18 Apr 2025 15:44:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, Petre
 Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/8] iio: adc: dln2-adc: use aligned_s64 for timestamp
Message-ID: <20250418154407.622af22e@jic23-huawei>
In-Reply-To: <494ee0cc5be01cb6a4db29d7f1a11dcee22850d6.camel@gmail.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-1-eafac1e22318@baylibre.com>
	<494ee0cc5be01cb6a4db29d7f1a11dcee22850d6.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Apr 2025 09:58:04 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-04-17 at 11:52 -0500, David Lechner wrote:
> > Follow the pattern of other drivers and use aligned_s64 for the
> > timestamp. This will ensure the struct itself it also 8-byte aligned.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> With the fixes tag:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
This one was in my series... Admittedly without a fixes tag.  :(

I've added a tag to that patch given I'd not pushed it out yet.
Fixes: 7c0299e879dd ("iio: adc: Add support for DLN2 ADC")

>=20
> > =C2=A0drivers/iio/adc/dln2-adc.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> > index
> > a1e48a756a7b519105393f77c4aebde1f2f85d50..359e26e3f5bcfe16d723f621bdfc0=
1df2dfcf6a9
> > 100644
> > --- a/drivers/iio/adc/dln2-adc.c
> > +++ b/drivers/iio/adc/dln2-adc.c
> > @@ -466,7 +466,7 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void=
 *p)
> > =C2=A0	struct iio_dev *indio_dev =3D pf->indio_dev;
> > =C2=A0	struct {
> > =C2=A0		__le16 values[DLN2_ADC_MAX_CHANNELS];
> > -		int64_t timestamp_space;
> > +		aligned_s64 timestamp_space;
> > =C2=A0	} data;
> > =C2=A0	struct dln2_adc_get_all_vals dev_data;
> > =C2=A0	struct dln2_adc *dln2 =3D iio_priv(indio_dev);
> >  =20
>=20


