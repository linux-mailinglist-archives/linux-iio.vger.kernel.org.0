Return-Path: <linux-iio+bounces-15623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4476A38084
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EC016A8EC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81421660D;
	Mon, 17 Feb 2025 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFBRRt6R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F2216E3D
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789137; cv=none; b=FQaECX3jtgTiP7RuwaRktK8tOLJ1kVz+LtRlAZiebikqdB0dKr6gXn98wft1s9VwiTfRhl5nGkvuq+AAtNClJNe+nGJgHaIbLJFlaJpNXiDnYANChNXkQuk2Ui7+sDl2HRdrju927kTCX/M8k5+PwT1LpFa7gVOYDL+S6bboZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789137; c=relaxed/simple;
	bh=g1GH1e35IAUq0UoI9r4hLZgqkXpOqKFbNI5vyYHOkIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HV/0iQqUIoJvRZo02ZLKuE9fWnKA0n91dJscVHz/LJ/55MqPbf9ImB5mqe8TeQWrjLQ+lls5NNOZ9IgonPcmQ2GHaT1Aq1Md/Dh3CYfTmmJ7oYtqbQym9chc/nAvwgRxX866nCgMXC5HC4fXFMMBqg5xLyvuaF5hTNhId/JXVF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFBRRt6R; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f3ea6207cso929009f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789134; x=1740393934; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jtp1NzFVs3tW6MAFtPjCVyyPsqyL+lqqqHST9ki6HQw=;
        b=RFBRRt6RdhYlbiBusCLYfn4DoqjVVmlJkMFR9laZUG/Sv6Kq5yQ3923Zy0fX4+c/VY
         xDQV+mHqNPQGGAkbyPI0h9rcnsgznP3U9uItIlE7lkfQTqy3/0WuBCBBYrNTBauvv5rK
         3+FHicvOuUaHI8RZ+OUav6wtgAisiFW3tzPtEHZ1QXkXIxDzhtXZ8ggme3aGfTld5aAa
         DA8ssdoz0V2ptwkdZHOJ01lXBpi3WoQ4A5jzqK+lxR7APPXiMXmXEMnYOOkmnkLUunDz
         pR2IvDmLFm8Xw1wzaSy30hN7OH8j6iWK75uwvk9I+dImkUB2m4OB7azVEzBq/rHVrFv2
         Yk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789134; x=1740393934;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtp1NzFVs3tW6MAFtPjCVyyPsqyL+lqqqHST9ki6HQw=;
        b=s+XDRAIrs0iHF0Cu3gPL6jM23EuJ+JnlmP3ogVgx7SPre5GPjAYQtteXR6mlSBBcwN
         2exZMg+hPcG1kj905OpsGH3XJnfPvM4YcqHPQ7TP9wO3zq0WHgADkSdmL1HrDeYsJM3s
         Vxx6UIZxJhelIys8bfW12uw2Kdz9kTcmRQ0ne2eW/C0J8omHUT4NLMIQlknWHHM3pnXd
         8RlRibBwZEkL4OK2ORFbEFMZjfvlgPid/BeYNkWrK15pT+5tAPXJzJG1H8wad4OhaIEz
         5tvEbO2QOoS+psRTSqP6T9y6WizFdks1x9G5sW+FJI6lx2l7RszBzYzm4WYinKkAkxbl
         rhLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY2/otRGrFRUeBOI55iIEL+1Y+XGsDExBZEPn99aX1jan06OOaFoEz7eTyLD63qM3Npn1koRMyBVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqTs8LJOrcz1OT2xaTdH11z+cwZ1XVPIBCZRn56mAyTypO1V+
	BxLbZAgunq0h1aaDlq0yEfHjUUYAZRzFISJ/Qn3Swz6VbXTGvkiH
X-Gm-Gg: ASbGncuCoDDA5lNN4spcrjlhAFbnpJmaoi8w6F1zEuTeiAtMO1vCzltSJEmouLxffus
	KyjTEfvyw52vqzS4jNkc+aOpRY3z7qqWNycNvvHiSCQ7s9Lqrhrd84BLN8FwF2ev3mdbW3Fa6//
	uh8PLQU8QoRZfdTFVSr/khldzuCp3eZdYUfLA6gn0LwSLM3oKQSxqvLsWTa2u0uoXwaf9yCwRJD
	3rDehNBlxOi0ei78IbOJ7vRfe0cE5j/DuWIn+SJZ78BwJEQS2Kj7BwXlrvDeO0b28L0rL61YzQH
	hJ8fLo0fUXhOO5JWJ0mbB64D19XH7yZnYvEJgsJdJj3G+uVW7LB75CWqN86krc4=
X-Google-Smtp-Source: AGHT+IFqvNiZqsqENPiiahTvY+Z83j7iVWXz9qPMr8XuLiPhDpXVPfSOL2sP/i9EQWi3DNI4t3lunA==
X-Received: by 2002:a05:6000:11:b0:38e:6cd0:f973 with SMTP id ffacd0b85a97d-38f33f3dbe4mr9069303f8f.21.1739789133744;
        Mon, 17 Feb 2025 02:45:33 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915146sm12065467f8f.56.2025.02.17.02.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:45:33 -0800 (PST)
Message-ID: <7434a3a8d8100706994a5046505a7976696f02b2.camel@gmail.com>
Subject: Re: [PATCH v2 10/27] iio: adc: ad4130: Stop using
 iio_device_claim_direct_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:45:36 +0000
In-Reply-To: <20250209180624.701140-11-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-11-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:06 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>=20
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.
>=20
> Cc: Cosmin Tanislav <demonsingur@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4130.c | 18 +++++++++++-------
> =C2=A01 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> index acc241cc0a7a..061eeb9b1f8d 100644
> --- a/drivers/iio/adc/ad4130.c
> +++ b/drivers/iio/adc/ad4130.c
> @@ -1067,13 +1067,11 @@ static int _ad4130_read_sample(struct iio_dev
> *indio_dev, unsigned int channel,
> =C2=A0static int ad4130_read_sample(struct iio_dev *indio_dev, unsigned i=
nt
> channel,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val)
> =C2=A0{
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		struct ad4130_state *st =3D iio_priv(indio_dev);
> +	struct ad4130_state *st =3D iio_priv(indio_dev);
> =C2=A0
> -		guard(mutex)(&st->lock);
> -		return _ad4130_read_sample(indio_dev, channel, val);
> -	}
> -	unreachable();
> +	guard(mutex)(&st->lock);
> +
> +	return _ad4130_read_sample(indio_dev, channel, val);
> =C2=A0}
> =C2=A0
> =C2=A0static int ad4130_read_raw(struct iio_dev *indio_dev,
> @@ -1083,10 +1081,16 @@ static int ad4130_read_raw(struct iio_dev *indio_=
dev,
> =C2=A0	struct ad4130_state *st =3D iio_priv(indio_dev);
> =C2=A0	unsigned int channel =3D chan->scan_index;
> =C2=A0	struct ad4130_setup_info *setup_info =3D &st-
> >chans_info[channel].setup;
> +	int ret;
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		return ad4130_read_sample(indio_dev, channel, val);
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret =3D ad4130_read_sample(indio_dev, channel, val);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	case IIO_CHAN_INFO_SCALE: {
> =C2=A0		guard(mutex)(&st->lock);
> =C2=A0		*val =3D st->scale_tbls[setup_info->ref_sel][setup_info-
> >pga][0];


