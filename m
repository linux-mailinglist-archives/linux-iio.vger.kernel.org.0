Return-Path: <linux-iio+bounces-13495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A89F23FC
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 13:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA081650C3
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B48B187876;
	Sun, 15 Dec 2024 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMf2hFu4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C41E871;
	Sun, 15 Dec 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734267487; cv=none; b=K3Asw+3znvskQDhmfw1rKPNUGtod/qh3ewmM6KUvpUtFyT/1Z7jTKFq2dfJ0Oly8UYmJCDC6zZkHRroDcuu9jzPKnGNTGxPq52nvYn57pA7376SKcXkL2a7ULo0cWUFP0vFB3mbMmYm6Q9BTwEG6/P9h/wRuobrZ3tJYidd3dQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734267487; c=relaxed/simple;
	bh=FxifYn/J+GjNzuVqe3a+BCsrK72tNlO+6PLafLcq+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmAaTChdGTX3G+l4ifBic51RRaijBYu9HnliJ+kwE0K2Q6ow5vNODCLffGkFM6ngu/qP55K83UDFnfjYgbTQQrT4t9yrJP1CHXn6v3J51oirmGk0VkjitY3uLsNLow1m71AGJrUdMiz0WwIrYFdKRh9sMaNpl/Bh9ft3Ef5WoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMf2hFu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8325EC4CECE;
	Sun, 15 Dec 2024 12:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734267486;
	bh=FxifYn/J+GjNzuVqe3a+BCsrK72tNlO+6PLafLcq+tI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gMf2hFu4o8zeSuijrgmVpm9v3ZMIzFBxQZndg7oa0go+XzjbPgd9Se+oF0KpgfV3K
	 XRhqff+LDFiz43ZukEbjs44Mpv2SsvsftfI50nR1kkNFCz2sKVhkuprE6s8PuNPajZ
	 7IRV3Ka4ZwaFAPafF0f7lb3QV6wcVlmX0Ni2eI8o7dtZQpPi+YVydZcW3eVOJYfyTZ
	 yDpY5JlARczYOw20P+RgzAy89C9cBJ3hsV2F3AZ80rxoPo/blg6xqXokpP0Njqj0BX
	 HhWBcuvN4YQPNkGHFdeFSv9uwYnSEJeEZNtm4+eIM8wf0ZDbUM8WzWAfsLECxMWYXj
	 t98DoMlA8TLjQ==
Date: Sun, 15 Dec 2024 12:57:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Jiri Kosina <jikos@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Fix invalid read_raw for
 attention
Message-ID: <20241215125758.558cc0ef@jic23-huawei>
In-Reply-To: <d164919c9290ca1410bc21746511799a5c17b94d.camel@linux.intel.com>
References: <20241122-fix-processed-v2-1-b9f606d3b519@chromium.org>
	<d164919c9290ca1410bc21746511799a5c17b94d.camel@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Nov 2024 09:55:04 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Fri, 2024-11-22 at 17:36 +0000, Ricardo Ribalda wrote:
> > The attention channel is a IIO_CHAN_INFO_PROCESSED, not a
> > IIO_CHAN_INFO_RAW.
> >=20
> > Modify prox_read_raw() to support it.
> >=20
> > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more
> > channels")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org> =20
>=20
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

>=20
> > ---
> > Changes in v2:
> > - Do not change the condition for applying the multiplier.
> > - Link to v1:
> > https://lore.kernel.org/r/20241121-fix-processed-v1-1-4fae6770db30@chro=
mium.org
> > ---
> > =C2=A0drivers/iio/light/hid-sensor-prox.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/iio/light/hid-sensor-prox.c
> > b/drivers/iio/light/hid-sensor-prox.c
> > index e8e7b2999b4c..0daa8d365a6c 100644
> > --- a/drivers/iio/light/hid-sensor-prox.c
> > +++ b/drivers/iio/light/hid-sensor-prox.c
> > @@ -94,6 +94,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
> > =C2=A0	*val2 =3D 0;
> > =C2=A0	switch (mask) {
> > =C2=A0	case IIO_CHAN_INFO_RAW:
> > +	case IIO_CHAN_INFO_PROCESSED:
> > =C2=A0		if (chan->scan_index >=3D prox_state->num_channels)
> > =C2=A0			return -EINVAL;
> > =C2=A0		address =3D prox_state->channel2usage[chan- =20
> > >scan_index]; =20
> >=20
> > ---
> > base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
> > change-id: 20241121-fix-processed-ed1a95641e64
> >=20
> > Best regards, =20
>=20


