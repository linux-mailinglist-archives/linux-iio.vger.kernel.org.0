Return-Path: <linux-iio+bounces-2176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82184955B
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 09:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0CE1F2186A
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50411197;
	Mon,  5 Feb 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSCw+nNh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50512B61
	for <linux-iio@vger.kernel.org>; Mon,  5 Feb 2024 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121662; cv=none; b=kveHS3yX48dq0SWuCcuYWMgfvThkjSXOyi9PV1i+y4JJndLT2tVk632kdAUTtcSQfI92afKCoaWrmH2RXxhMLSPy7dy11mLwJ2buC24PcxDIHr73OLdGV14HAnbGxhZk7uq5Vyg6S2ZVTELHSSeAMP5FGCRHuevhOqJeVsdzMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121662; c=relaxed/simple;
	bh=TuBJPnbpvRpCYOKHAD0lR+xCLFI1cdFDiUHoZ1kcH0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sm+zuVwDrpXNMggE9zBsOz1rDJox5KPPmJEKH/LBvbqo20unVZkKzE8DgbOqonWl20j0kPlCp09ZpxR6tgi9EHIGp7BHqjplTKpqVAvGEyUBiB/XzFSUrYZwwjVV9TB2x32qxY8f+5/ao8eMz6qqEPnWka6ykjMuFV0rE33HSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSCw+nNh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so37757305e9.3
        for <linux-iio@vger.kernel.org>; Mon, 05 Feb 2024 00:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707121659; x=1707726459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BM5GMXeawZ9u9XiFMZzePa5WqKRMz5Q31LIf/vQrifc=;
        b=GSCw+nNhp3DQyzd5UBHbKQEVpvmJkuEzyfdaIzJDTNK1JHjv6iZqbeX06u4eWGALYn
         MLnvPaT+dJ13mLBkiwxtkFcp7pwxS0Lgcks9llm+NJs1RPXmBsXiS72x90/bFU8hN1pL
         C+SpaFX4aYrLnyn/3OVDgrypHUzxFpBoFcib/eMkKKjcZasAxjJLajz9gOcXYPtv5s/5
         8R0rSPp4s7UOD64E/mkBQtmnTRCDzgd5kOV8CWWq/q3spt0EQcRocL3vNjtQLiQ8kSjE
         lJXXESAinjve4I6h9NiUm9Jm20BF8hGAd0xwZIal1q6NXAj0rlLpmdC7pCvsTjoSRSV0
         tK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707121659; x=1707726459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BM5GMXeawZ9u9XiFMZzePa5WqKRMz5Q31LIf/vQrifc=;
        b=r5l+vxc1rJU8ItsZSZwJI8ZSDhqRQbeozF+ln7MUe3z1YESXe8b7Xew5vj0yaeUYK8
         PCQpWxcD7VeJCc4C8vaDGYAE7QnnjE/ebHoN4pACyZbBOgCGZvBO1VjS8OVkiK2LRqIa
         05QXEM+sq6tyy5/os3nIC3/6tkGClhqYnN6wUf+vUvWFbMtyV5t9wtT67KGidZGlg5G/
         4PPZc9NUtP/X6NYFOscHIedr9ZTjIcRhTE7EW+1qkdACy+/gzDpj7pc/z3RQdZbSLdNZ
         Cb7qrfkgXgzXoVw2BcGFD9mGaNBPXrDy+r2MkCSgP7QnEBLFNlgF2+OKAK5WFJOjcL5G
         er8w==
X-Gm-Message-State: AOJu0Yyr1360rwwPopy8nSghLAkrDq4sg7VDYG63mFC9aJcoOLtrNFuo
	N0IhMwu2eC2X0hR5YSh6hbp+aepUZw4JiI41VyimPbJxz1dEftGh
X-Google-Smtp-Source: AGHT+IE7UKEhBjvqJiZgBMd5i/eR/bwnrySDELFkIMbNWK/VPLAYqwPahI4L7RsfTE8+PDGcoamMFg==
X-Received: by 2002:a05:6000:2c2:b0:33b:41d9:7ae3 with SMTP id o2-20020a05600002c200b0033b41d97ae3mr580602wry.19.1707121658870;
        Mon, 05 Feb 2024 00:27:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVvgXVvnnN3X8zHyfVjI/qh3P9m8JxWnLPJi5/drAu5UuPGG6ekYib935HjRuSq4zg4sqjq7u7ySE4iE/Bl0IDLYwStTr+Lnc5Uz891E6D9qU4uTWMaMypmVEToT5eqqTv5tI2pQ5384F+XyNz7Rw2V4Rd8Z0AJLDs=
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d4dc6000000b0033b40a3f92asm674560wru.25.2024.02.05.00.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 00:27:38 -0800 (PST)
Message-ID: <a80051f81a91e0887b1c40b7a284394d4081a847.camel@gmail.com>
Subject: Re: [PATCH 03/10] iio: accel: adxl367: Use automated cleanup for
 locks and iio direct mode.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Peter
 Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 05 Feb 2024 09:27:38 +0100
In-Reply-To: <20240204134817.1a2dff4f@jic23-huawei>
References: <20240128150537.44592-1-jic23@kernel.org>
	 <20240128150537.44592-4-jic23@kernel.org>
	 <270d95aa0190520c443eaaa94c30b5d4d9c64389.camel@gmail.com>
	 <20240204134817.1a2dff4f@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-04 at 13:48 +0000, Jonathan Cameron wrote:
>=20
> > > -out:
> > > -	mutex_unlock(&st->lock);
> > > +		ret =3D adxl367_set_measure_en(st, true);
> > > +		if (ret)
> > > +			return ret;
> > > =C2=A0
> > > -	iio_device_release_direct_mode(indio_dev);
> > > +		st->range =3D range;
> > > =C2=A0
> > > -	return ret;
> > > +		return 0;
> > > +	}
> > > +	unreachable();
> > > =C2=A0}=C2=A0=20
> >=20
> > I do agree this is irritating. Personally I would prefer to return 0 (o=
r the
> > last ret value) instead of the unusual unreachable() builtin. But that'=
s me :)
> Definitely would be an error, not 0 or ret, but I'm still in two minds ab=
out this

Agreed with that... In theory, would just be about making the compiler happ=
y.

- Nuno S=C3=A1


