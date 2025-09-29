Return-Path: <linux-iio+bounces-24550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7ABA8266
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 08:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52575189400E
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 06:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF31C2BE7B4;
	Mon, 29 Sep 2025 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPME/JuR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D167F24E4C4
	for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128044; cv=none; b=HfGYLcKbld6swqyyBTdiWZeR0VRXokLyXwPft7mlwIfq9bQ+ZsMXjgIu1zhOjKiviAQz+musMRfqcsz+XB8vnrTlmQlzSdS3s1mYsofEKoHgWhplgjaBXWCM5SXY65fChiLt96ScPZoR3fjFn+Xv9rGhnO5CyWxZfyPXDONUH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128044; c=relaxed/simple;
	bh=3LR8E8CjvEpJbrTYnxXLx7VWtyus9mJZto38+M9EDak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XwlqkPBQ1QioeNB6/1T68Q3+nBx9IA33d8WdtKbi2oXweBOnZd29eTDfHyP3+loUvAl7iERz1jiQBakzpFnvBdSRal6HZa4y35ZC7za7YB335BE2Tw5gAI3xUDWVJcuTANbE9NZPoclXe0ctzwN40gbP/jPK3I4/WjkS3Kg4OYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPME/JuR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e52279279so3724285e9.3
        for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128041; x=1759732841; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G3vOHHXpuMKt6IoeyX80AZv8OaZzqV02cCRhNcQ5018=;
        b=PPME/JuRlY866f2XMmXmxGea2H5lEThmGWqBJkqtJxnIZF/djrZGw0mgFE64AOKQt2
         sCabwQpjTxqM8+LLfCMgUUQrgXoetI+wM4+Hb4cpp+DeqxprVIhqzXw/yA/8bDVsnxKj
         3jHyXuifbgr7L4vIkIDaW13LeMlApkCtjHhXiL/4Z23MTpODp7aSoFP2l5jteJKvHomz
         q7A4h9X7IIzAxiG4z7Qf+qnd0n8sipEAU+9M2TFwrW2Fx2U2nmbmhkly0Qtao/KQ4Orm
         jUqNOMF39lWCHUw1I3noy1srjj0jfxBdAP6CsZ0qlipSq5XMkDRoB8cJ+MjNjDfzd4nc
         QThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128041; x=1759732841;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3vOHHXpuMKt6IoeyX80AZv8OaZzqV02cCRhNcQ5018=;
        b=igV3O+lw/vpEnopzHtYbpzDQGnungq/rftizZ61LXeBZ9z7nGbLI3RabnMeKNEQt9O
         LKbFHOEJl2XQHgiL2OyKmzh3vR1RzqpoOy8ewBbCrLYh7mCL+B14NPy04iw4zqY/vWpQ
         ZD4RWnOE/Hj0ZA0Ik/FUToblNurflGObvdmG3YvSie9+rMh9pqqhw/AOBOEfLUGS7iSw
         iliwiGn8ZVtkelcZM/ktZ3Ur3icLWA+xSiD47pCTdufrorBTmNspi5z/gzKi97OYRv3f
         BV1+wJsajgJo2qdVJ/0ODZPNgxeydnmFS9Ym9KeWh7P1DrlaQEuWHWBbmFMaMnexmxNa
         5WhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoiQ/svsdnQO9b7VOndFzIPoEpsQ+DpVA7HcgjsEkjG5FgxvUQx0zm9uYGL/y7EJ+zWiUlsQMdZHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeT2N4vmjsReHcWKPmV2/eFRpQj/4TV8S6lUGUiiADM+mZYO6W
	PvsqDSsqU0lqqp7r9tGxC6qUe5zHKHigbLbfH5uSu8paTuZ9awn7uxaT
X-Gm-Gg: ASbGncsMtnC5WUxVWcY1E7meHFjTCeZFqAGPSruEOxrQup6BnAAUAhVt16YV7/B7QGW
	HqbIt3BjaZDsPjlvKNRvDvxzzFwh/nbYsYpsBvWEBm2soBmHU86dPKAwbCIwY4hZvNh6Dco+RLL
	NzxZRhI/6xCYgEzx2zuE8bXWUB9sRjmm0eEzQ+1U5ohER1q0klZI3FvWuTJ+9IgbD6eXaOt2Py3
	jKl48GfsBTRwoNH+Kq8Ue7yi9Ka9n5HEIb5jZgCpf3m3uL1G2kDG9sARyMHJJrd8jvzCQK5oYKR
	kqTYx1pdlPsDDx4Bfz/5LL/Rnh2N0Bz0rqX4EuA0M1r4BZvrev3NNPKaSIIbMe+SVYzSFXg5HBy
	iBvUU3Kn2dT5eFy+2G4znBux6L9DAMe16Wgt3KbuWN4wmqwX9c9Tm4esSVm8mMgWxH3Wnyfu7
X-Google-Smtp-Source: AGHT+IFZZJA3o5F9x0k/0C3Pbj7NTufjIeL93o2MLa2YiTXLngzlgMm0cTptySotti3yH8tb/SXC0g==
X-Received: by 2002:a05:600c:a4c:b0:46e:2861:9eb2 with SMTP id 5b1f17b1804b1-46e329a4931mr177920745e9.8.1759128040686;
        Sun, 28 Sep 2025 23:40:40 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e8aesm169142595e9.4.2025.09.28.23.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:40:40 -0700 (PDT)
Message-ID: <7fe5c02a0594a8fee0a0008722a2ab3d943925de.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: ltc2688: use the auto lock API
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= via B4
 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Mon, 29 Sep 2025 06:41:33 +0100
In-Reply-To: <20250927185631.1051e315@jic23-huawei>
References: <20250923-dev-ltc2688-minor-v1-0-ef92c441dc42@analog.com>
	 <20250923-dev-ltc2688-minor-v1-2-ef92c441dc42@analog.com>
	 <20250927185631.1051e315@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-09-27 at 18:56 +0100, Jonathan Cameron wrote:
> On Tue, 23 Sep 2025 09:41:48 +0100
> Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Make use of the cleanup API so that we can simplify some code paths.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/dac/ltc2688.c | 24 ++++++++++--------------
>=20
> This enables a few related simplifications that should be in this patch a=
s well.

Yes, both make sense.

- Nuno S=C3=A1
>=20
> > =C2=A0static int ltc2688_dac_code_read(struct ltc2688_state *st, u32 ch=
an, u32 input,
> > @@ -236,15 +234,15 @@ static int ltc2688_dac_code_read(struct ltc2688_s=
tate *st,
> > u32 chan, u32 input,
> > =C2=A0	struct ltc2688_chan *c =3D &st->channels[chan];
> > =C2=A0	int ret;
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> > =C2=A0	ret =3D regmap_update_bits(st->regmap, LTC2688_CMD_A_B_SELECT, B=
IT(chan),
> > =C2=A0				 input << chan);
> > =C2=A0	if (ret)
> > -		goto out_unlock;
> > +		return ret;
> > =C2=A0
> > =C2=A0	ret =3D regmap_read(st->regmap, LTC2688_CMD_CH_CODE(chan), code)=
;
> > -out_unlock:
> > -	mutex_unlock(&st->lock);
> > +	if (ret)
> > +		return ret;
> > =C2=A0
> > =C2=A0	if (!c->toggle_chan && input =3D=3D LTC2688_INPUT_B)
> > =C2=A0		*code =3D FIELD_GET(LTC2688_DITHER_RAW_MASK, *code);
>=20
> There is a return ret later in this function that can be return 0;
>=20
> > @@ -359,15 +357,13 @@ static ssize_t ltc2688_dither_toggle_set(struct i=
io_dev
> > *indio_dev,
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> > =C2=A0	ret =3D regmap_update_bits(st->regmap, LTC2688_CMD_TOGGLE_DITHER=
_EN,
> > =C2=A0				 BIT(chan->channel), en << chan->channel);
> > =C2=A0	if (ret)
> > -		goto out_unlock;
> > +		return ret;
> > =C2=A0
> > =C2=A0	c->mode =3D en ? LTC2688_MODE_DITHER_TOGGLE : LTC2688_MODE_DEFAU=
LT;
> > -out_unlock:
> > -	mutex_unlock(&st->lock);
> > =C2=A0
> > =C2=A0	return ret ?: len;
> return len; as can't get here with non zero ret.
>=20
> > =C2=A0}
> >=20
>=20


