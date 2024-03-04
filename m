Return-Path: <linux-iio+bounces-3306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B1E86FB40
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 09:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7D8B21D4C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5277168BC;
	Mon,  4 Mar 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp9y4Igg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8184134D1
	for <linux-iio@vger.kernel.org>; Mon,  4 Mar 2024 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539288; cv=none; b=ecP9AWXJZ2BEuoBqRNVWekpBLELSShP3fHekuIg/enW/zdmP2fibf9q6ldZF8XXaNd4acqJGCL7b05ubt3H+YQYhS29fJ7r4OHKP6CSSIQL13SsNk8MrTch8MqO62mFNgbt/8oqPjjiCk9PwrwD9HU91JKiQGhnADmeG3mIlQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539288; c=relaxed/simple;
	bh=SCXBrtR6S4gESkeNWfKSaoRgwnwtPMIsMCTt9yvqnFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iUv5Q71ean5M8sKB0fiD2s0of6x4pF8HkD4grdvAoIjBGLlBHZKK56NPjwgxyT2q0IDY4KeKE8zuw2bEbzcbiJ6ezQ82dXa3/RLYw3UsvxDPFaILhyOR3E60tPiKUWJM+gXJ/T0vP6KQo5Fa3I2Az627pEqPF3pIN9I0jkba/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp9y4Igg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso246383466b.0
        for <linux-iio@vger.kernel.org>; Mon, 04 Mar 2024 00:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709539285; x=1710144085; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pDbQMLihnrgu/doEJ7qqheb/rgC6/JQgB3UMrEkn8H4=;
        b=cp9y4Iggltj/ZtQhBv0W5GnbMocIUyVDveGyzOzalVMv3YGd6qaYQamJwgr29ItX3M
         6xF2dZnss4Y4pXvt6GQ+smr9fZNtUez9SM13tRyDjcXGPorcEt6uZF695d0qdJP4Q2jh
         MgYLrGW9mcuRGzD1AGDcviEZHU6N7CSQY70leAp1jXHHdIAS0uvW/heFChU6lUKsNnHk
         odLd27K3FY3esvOZznJn+YP/1e0tPorbRaTnfhQnT/6IcAAdjmEvbMOHnw70LDG6+9JQ
         MsFl18PcT0+qC82ljQELVx7FCnYGNwhW+xZy3JCNTlCS8X91aZ0WGFA4gvpyAj/nQyT4
         wznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709539285; x=1710144085;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDbQMLihnrgu/doEJ7qqheb/rgC6/JQgB3UMrEkn8H4=;
        b=myblRnJO98sdbjQRQMVnAW/8FASmtfz7St0o3vwE95LDhjtoMJxUcHmW9FiDsDYrEr
         x9D3kHUv1E1VNP5g8dbwuHWi9NCcl3Pnu/G8H5MYufRi7diZ080qhyvJ6Xq3nRyU8pWZ
         eLpgXbndPLvop07vIvKJl2tRBp4vQaK7rhPU1t6p4oDVG1GOdlQ/ZAKqL/SurU3pMzYx
         shQq7LuwcPM6mC7jFcfwkdmHY+lRPYTI639OX3P9GCwNWd/IeV6JqTEwgPBajkNdHG8j
         So0zd/D+VDqD7URo3nj4UmoCAxcxYyiZatrfq0ZAkBSY3qDGNnxS4YRs1bh53dOUCBAP
         Motg==
X-Gm-Message-State: AOJu0YwoxHFtqhXVih73yc7XujKIS5QbECQo0TAmHQVbWNzh2gBJx6mT
	YZGsyf17auTPvUEgTmVKlpneGrfkSTPqSWvnjenlMcDZHEjHbrKQ
X-Google-Smtp-Source: AGHT+IEKru4se0fd3Xk4Iw1ZzIw/+fU5Q7FKInNbxi9EU+opzJZxybkwXm4heoTTqDMnZZjOLYiZIw==
X-Received: by 2002:a17:907:174a:b0:a44:c1bf:a801 with SMTP id lf10-20020a170907174a00b00a44c1bfa801mr4199242ejc.17.1709539284994;
        Mon, 04 Mar 2024 00:01:24 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709064a0300b00a449ebf3d58sm3131365eju.85.2024.03.04.00.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:01:24 -0800 (PST)
Message-ID: <740c98678f943c761623800544a8ba998aa4aa93.camel@gmail.com>
Subject: Re: [PATCH v3 4/4] iio: inkern: move to the cleanup.h magic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 04 Mar 2024 09:04:49 +0100
In-Reply-To: <20240303142431.506c05a2@jic23-huawei>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	 <20240229-iio-use-cleanup-magic-v3-4-c3d34889ae3c@analog.com>
	 <20240303142431.506c05a2@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-03-03 at 14:24 +0000, Jonathan Cameron wrote:
> On Thu, 29 Feb 2024 16:10:28 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Use the new cleanup magic for handling mutexes in IIO. This allows us t=
o
> > greatly simplify some code paths.
> >=20
> > While at it, also use __free(kfree) where allocations are done and drop
> > obvious comment in iio_channel_read_min().
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Hi Nuno
>=20
> Series looks very nice. One trivial thing inline - I can tidy that up whi=
lst
> applying if nothing else comes up.
>=20
> Given this obviously touches a lot of core code, so even though simple it=
's
> high risk for queuing up late. I also have a complex mess already queued =
up
> for the coming merge window. Hence I'm going to hold off on applying this
> series until the start of the next cycle.
>=20
> Nothing outside IIO is going to depend on it, so it's rather simpler deci=
sion
> to hold it than for the ones that add new general purpose infrastructure.
>=20
>=20

Seems reasonable... It may even give us some time to see how the cond_guard=
()
and scoped_cond_guard() will end up.

>=20
>=20
> > =C2=A0EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
> > =C2=A0
> > @@ -757,29 +711,24 @@ int iio_read_channel_processed_scale(struct
> > iio_channel *chan, int *val,
> > =C2=A0	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(chan=
-
> > >indio_dev);
> > =C2=A0	int ret;
> > =C2=A0
> > -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> > -	if (!chan->indio_dev->info) {
> > -		ret =3D -ENODEV;
> > -		goto err_unlock;
> > -	}
> > +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> > +	if (!chan->indio_dev->info)
> > +		return -ENODEV;
> > =C2=A0
> > =C2=A0	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)=
) {
> > =C2=A0		ret =3D iio_channel_read(chan, val, NULL,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_INFO_PROCESSED)=
;
> > =C2=A0		if (ret < 0)
> > -			goto err_unlock;
> > +			return ret;
> > =C2=A0		*val *=3D scale;
>=20
> 		return 0;
>=20
> > =C2=A0	} else {
> could drop the else.
>=20
> > =C2=A0		ret =3D iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
> > =C2=A0		if (ret < 0)
> > -			goto err_unlock;
> > +			return ret;
> > =C2=A0		ret =3D iio_convert_raw_to_processed_unlocked(chan, *val,
> > val,
> > =C2=A0							=C2=A0=C2=A0=C2=A0 scale);
> 		return iio_convert_raw_to_proc...
>=20

Hmm, unless I completely misunderstood your comments on v2, this was exactl=
y
what I had but you recommended to leave the else branch :).

- Nuno S=C3=A1


