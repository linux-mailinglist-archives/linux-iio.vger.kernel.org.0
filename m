Return-Path: <linux-iio+bounces-15632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D081A380C2
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2111B7A24D2
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42C7217646;
	Mon, 17 Feb 2025 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvzQRXPC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56DD2165E2
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789579; cv=none; b=Xy+7ysCYC66OtGMGAzlHm6OLsP69veXPZzf9XsVPd2mKZKroZj8wIYs4XIs4pJbdNIo8R9JyX6VJodxv0nGcmjYz1DfoUTKzqTpdR7wbzKWApZjIUPqsPfJZMZrSGznN0oJddlGcwOUXnb8cXdKZTOkn3kTqFO0aQUXTmPxbDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789579; c=relaxed/simple;
	bh=iFIx1UK1xlLS6lDZ04cTXVNv+LZewlGGEJmhocevR18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YgdJUwWX38NP6cGCT+uELbSMcF0STUF2PRZwFU8/BGtak/0E1ecGaI28zQFQcwNihVLNPMCsgNQcNw45Hx9P+nXiXat95ZSRHwZ8na1628kGfXt5OEV0dejNYlvXOV/BlLeAh0S3kBYcloDuvP2rJQTMnO6xlh6vfeLWmmQtLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvzQRXPC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f3ee8a119so595402f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789576; x=1740394376; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LfA/hsUuUm2euyBkQ1OYMBPcRWIcwPTXy4qeeB98/rU=;
        b=XvzQRXPCyumh6xW4tRcJZX8AUwOgxQvLoT5ylM3uo4BeE5Ok5DQN2/cLZmEcvihp/M
         H5I7/ndGxf5/nSfMdO7wAtQmh+3+laWt6CtCu8E2I8/eClSNcXBnwt86wgFh0U22ymbB
         3y2WVRk+wZIBITe6xKhmgaaZCfQ6vOtPvFv4W6Kobsh5N9iO+3DXI+91C70FvxYsN+Ik
         ixqAlbNiIEtlqGwPzHVu7mxFQy7uocArTPgXHTBFjEjS149I1Ck81rE0ufUXaj2Dpofp
         TK54tJ9uZfJvtJU6fixVbNJdasIyMvR96bovoN0WZnu+9P0j+Bjks0QfZmbccmBiBFxF
         PsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789576; x=1740394376;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfA/hsUuUm2euyBkQ1OYMBPcRWIcwPTXy4qeeB98/rU=;
        b=PMwMe0CsVzz+/AhuG3DEKa70ecpQ/xlkxBZOKv57+u5E67Lb8LNeLZTi8/dCCEwnN4
         fRY+6UmfP4bZP9wG2Mg4t+HtTur5B37CXH0P9aa9sy8Jv/QyuLeaOgfnL/5Ncw9PioPk
         qsvLd+A3CgFSLorkTQ+LW7RPLrU+hmBB0CpNEV95bsLFqK5DHBh7jMckOn79pW+9mdnw
         Zs+xHc1116dnmASnpSG2OdBnx904QaEL9k3cBp8c3x/2OCjmbfpn1SG9v0GsvowPiu3k
         AS12wJRCQwC983TrvlQNzQxav7Xef40ZvuTBTOvW8ZQa72piFlbZozJCVS0lhkX6jd7A
         9Jsg==
X-Forwarded-Encrypted: i=1; AJvYcCWu/d14Tpb2AI1Nk0w9UbZWWafQXNUZYkjidUH81t9UsdhK4X0c6T+SIUbvtjBMblqCw/9MQdkJ3nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykFh+XPGKJb0hQysMduO8lnzHdNCqpclsXkm6tbyKwVP41Zmyq
	Rpclt6jSubaMIQQhdJ82uXB7cb0mhcowfrBQEuMCaReVskaTAxYH
X-Gm-Gg: ASbGncvc8cPi+zyoPKXuYaA4LQeNlgZtxoGw4tzbO9+M2crEuxyMk5ooML3XLy+MRrG
	+ZNPqbO/22z3u2M2I8wPmpfzS7tuPNdO/6WQSesaJYw5WhA5XM7WJhgnx33PWLNcaVVkZLsfLyh
	KSaxPp5f1RCqfFAfDNz1KpH0NFs7Xm/fsi3QKmtQ4x4vK7Dkkh1+U+znnR8ZEFAVBOa5A/eToyU
	/gH6AS6qpOUPcmhX+lO3M6LugIRwZT/7mYzlPvLSW2/DUKiqYIBSV/TV6v2c2J9yGcjH/HhrsZI
	WUOBt+cG+wUlV0GmQfzxWgSnPSmmVIryuEH0bH3cEFZUJb/rBFpRQIsVoG7VWpY=
X-Google-Smtp-Source: AGHT+IFtmxNlt3Hf7oAA9H4RsOGp9p6NWwszfN4OPxk6mqDF/rnjAMTkrmD8FqvAYhsKzJ4uhtvQ9w==
X-Received: by 2002:a5d:6d85:0:b0:38f:28a1:503f with SMTP id ffacd0b85a97d-38f33f1195emr5271905f8f.11.1739789576142;
        Mon, 17 Feb 2025 02:52:56 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25914171sm12076617f8f.53.2025.02.17.02.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:52:55 -0800 (PST)
Message-ID: <3bbb2990541c01ec0d188f64b4629b7db6a5e464.camel@gmail.com>
Subject: Re: [PATCH v2 23/27] iio: dac: ad8460: Stop using
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
Date: Mon, 17 Feb 2025 10:52:59 +0000
In-Reply-To: <20250209180624.701140-24-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-24-jic23@kernel.org>
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
> Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad8460.c | 18 ++++++++++++------
> =C2=A01 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
> index 535ee3105af6..6e45686902dd 100644
> --- a/drivers/iio/dac/ad8460.c
> +++ b/drivers/iio/dac/ad8460.c
> @@ -264,9 +264,12 @@ static ssize_t ad8460_write_toggle_en(struct iio_dev
> *indio_dev, uintptr_t priva
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> -		return ad8460_enable_apg_mode(state, toggle_en);
> -	unreachable();
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret =3D ad8460_enable_apg_mode(state, toggle_en);
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t ad8460_read_powerdown(struct iio_dev *indio_dev, uin=
tptr_t
> private,
> @@ -421,14 +424,17 @@ static int ad8460_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0			=C2=A0=C2=A0=C2=A0 long mask)
> =C2=A0{
> =C2=A0	struct ad8460_state *state =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> =C2=A0		switch (chan->type) {
> =C2=A0		case IIO_VOLTAGE:
> -			iio_device_claim_direct_scoped(return -EBUSY,
> indio_dev)
> -				return ad8460_set_sample(state, val);
> -			unreachable();
> +			if (!iio_device_claim_direct(indio_dev))
> +				return -EBUSY;
> +			ret =3D ad8460_set_sample(state, val);
> +			iio_device_release_direct(indio_dev);
> +			return ret;
> =C2=A0		case IIO_CURRENT:
> =C2=A0			return regmap_write(state->regmap,
> AD8460_CTRL_REG(0x04),
> =C2=A0					=C2=A0=C2=A0=C2=A0
> FIELD_PREP(AD8460_QUIESCENT_CURRENT_MSK, val));


