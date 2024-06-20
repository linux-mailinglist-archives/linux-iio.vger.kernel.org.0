Return-Path: <linux-iio+bounces-6614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5CF910108
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 12:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336C9284CE3
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2B1A4F0F;
	Thu, 20 Jun 2024 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQL4VC3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6DD18EFEC;
	Thu, 20 Jun 2024 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877842; cv=none; b=hcBITkHa0lZ/eDuFTcD+CcC09vRotoqKNjzyMJTheSrACHIfp+eXqBupYcvK8Mjuz5grHu8ONJnIiv8XBUcBnEx3p4a9oroiO77FamNxOwu+QxQczVpas5DA92RFFOYW4eLn774D/4KptQCG0xOyOpfP37QBpqbi+8KKEB8UFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877842; c=relaxed/simple;
	bh=ueRVg8DMJrZEak1h6ucKy0U9j9rI3mHqqg9vFNniReY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9p6ahY5++l4RA4diHm5TTr/r7WPZ4livXJMsjj3/3wbbWrVfN0JQ9sYw3xyxeHJDLsdhyIV6ZcVUkTTGgKWMMTkQELfT1gJ9Ik7jgKq0cimZG+Q3nTxKvqHqOREWZuu54d2DRhPT17zcRVNx3B1DJbXEOdh905h7h9Gvw6wvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQL4VC3C; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso628301e87.3;
        Thu, 20 Jun 2024 03:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718877839; x=1719482639; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0aqNfc/0Rdu8/Y7kaB9Lub6YCvdNDl/TqQK6TdmUekA=;
        b=MQL4VC3CF5yiEiRER73JXGjmTg4Fp1FC9kTLpV58DXy4ow9IX9KZSpxaXO3cCa9Px8
         WtVmueq3C4U8QBuggmF0F/g6dZn5qiUrR2BVZhYpbQp96D3TL7FtHe/Q97OS9ckemb7s
         bBWfuwtri3ZYpKiL7gztJxPJThCRTQSX801FI43QhtC0sL3ZD5ASGIjdXSOIjtVdVTmG
         hGFuHEAN9V7SozAN2uug73s6KFM/0itV2uD7e7wTtTRoWSvnbYHQENDuBzqD+A99N2DK
         DLim82IITgk58yDiOXa2k4e7WrBcTOmiwdT26ev0DvKOvzCByicL+fdD+HxudSMPgebo
         BxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718877839; x=1719482639;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0aqNfc/0Rdu8/Y7kaB9Lub6YCvdNDl/TqQK6TdmUekA=;
        b=ECTBJcifPJPCAp4fGK+YgSLbfLaBgvAjKRqTggSZAX78eTUywGGLSiFFf9I44uByWv
         q6azq5GB08h3Bh5HRK02XCq/xrXvNUNuW6Zzv/CdP9CQzRu2v6JJMI37zy2ra5A+nMlW
         Y/XpL3NVf2H8N+YaP49o0r9E8X03/5l34MONlomSBGNquJsGSitu7LLgxLN8r1iQxNQH
         oSR0/z94+5elBLwAh4GztjPHwO7OE7WHMEKHZ4KYqu+UWaTqe2bcU6ADI998vF7EO3ie
         NEYted+nZKGWvKTILsoJOzbQmCBqa0xyHs9yFUdvTQhlBfDlv0Y4G+uHz9M/d5lFBjxq
         Mkcg==
X-Forwarded-Encrypted: i=1; AJvYcCUNIL/Qvn/LyIwaM9oFWH10WEO+WPd/zDYtaHvNf+LGNEplgwFl6CVYf/NWXtQ+ulf7lqvbtGlXinRU43P8kiiHpnRTm8Vjf9mUOAOg
X-Gm-Message-State: AOJu0Yx6PqHWiK4Umdbr0hXt5hROpmjdEdH4byOmyFzVEYwBXCT1wn1+
	xmp38cPrLhOpGOiZtQpyeVR3aLpIXP6OKCN3j/wnWPjGCmWVsC0EojufEpsO
X-Google-Smtp-Source: AGHT+IGQLYd/tgOYQvJ2HKtsrBKV0UsdGIWwmZqiJYtcYCo8VHnQTw9FyI7f0gX1T9G/1e88yVTkoQ==
X-Received: by 2002:a19:4347:0:b0:52c:82cf:b80 with SMTP id 2adb3069b0e04-52ccaaa8d48mr2353736e87.63.1718877836743;
        Thu, 20 Jun 2024 03:03:56 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b8f74sm20146435e9.4.2024.06.20.03.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:03:56 -0700 (PDT)
Message-ID: <1e38d2638a2cc62f8a73c6eaf4fd4f79637dbb47.camel@gmail.com>
Subject: Re: [PATCH 2/8] iio: add enable and disable services to iio backend
 framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>, Nuno Sa
 <nuno.sa@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Jun 2024 12:07:47 +0200
In-Reply-To: <8c3de47c-bd72-4560-a43b-5275f2f7a059@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	 <20240618160836.945242-3-olivier.moysan@foss.st.com>
	 <5b7b8a7132934b77b43ffde0650c68c1dd9a5b7e.camel@gmail.com>
	 <8c3de47c-bd72-4560-a43b-5275f2f7a059@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 17:59 +0200, Olivier MOYSAN wrote:
> Hi Nuno,
>=20
> On 6/19/24 07:21, Nuno S=C3=A1 wrote:
> > On Tue, 2024-06-18 at 18:08 +0200, Olivier Moysan wrote:
> > > Add iio_backend_disable() and iio_backend_enable() APIs to allow
> > > IIO backend consumer to request backend disabling and enabling.
> > >=20
> > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > ---
> >=20
> > Hi Olivier,
> >=20
> > small notes from me...
> >=20
> > > =C2=A0=C2=A0drivers/iio/industrialio-backend.c | 26 +++++++++++++++++=
+++++++++
> > > =C2=A0=C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 ++
> > > =C2=A0=C2=A02 files changed, 28 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-backend.c
> > > b/drivers/iio/industrialio-
> > > backend.c
> > > index b950e30018ca..d3db048c086b 100644
> > > --- a/drivers/iio/industrialio-backend.c
> > > +++ b/drivers/iio/industrialio-backend.c
> > > @@ -166,6 +166,32 @@ int devm_iio_backend_enable(struct device *dev,
> > > struct
> > > iio_backend *back)
> > > =C2=A0=C2=A0}
> > > =C2=A0=C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_enable, IIO_BACKEND=
);
> > > =C2=A0=20
> > > +/**
> > > + * iio_backend_enable - Backend enable
> > > + * @dev: Consumer device for the backend
> > > + * @back: Backend device
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_enable(struct device *dev, struct iio_backend *back)
> > > +{
> > > +	return iio_backend_op_call(back, enable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_enable, IIO_BACKEND);
> >=20
> > We do already have devm_iio_backend_enable(). From a correctness stand =
point
> > and even
> > scalability, that API should now call your new iio_backend_enable() ins=
tead
> > of
> > directly call iio_backend_op_call(). I guess that change could be in th=
is
> > patch.
> >=20
>=20
> Sure. I have updated the patch.
>=20
> > > +
> > > +/**
> > > + * iio_backend_disable - Backend disable
> > > + * @dev: Consumer device for the backend
> > > + * @back: Backend device
> > > + *
> > > + */
> > > +void iio_backend_disable(struct device *dev, struct iio_backend *bac=
k)
> > > +{
> > > +	iio_backend_void_op_call(back, disable);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_disable, IIO_BACKEND);
> > > +
> >=20
> > We also have __iio_backend_disable() which is static since all users we=
re
> > using
> > devm_iio_backend_enable(). I understand that's not suitable for you but=
 I
> > would
> > instead rename the existing function to iio_backend_disable() and expor=
t it.
> >=20
>=20
> Just renaming is not sufficient. The reason is that=20
> devm_add_action_or_reset() require an action with action(void *)=20
> prototype. So the prototype of iio_backend_disable() has to be changed=
=20
> to void iio_backend_disable(void *back).
> I placed the same arguments in enable and disable for symmetry, but *dev=
=20
> is not required for time being in disable API. So it can make sense to=
=20
> change iio_backend_disable() prototype.
> alternatively, we can call __iio_backend_disable() through this API.
> Please, let me know is you have a preference.
>=20

Oh, yes, you're right. I would prefer your later option. Call
__iio_backend_disable() from __iio_backend_disable() with a proper typed
parameter. I also just realized your 'struct device *dev' parameter. I thin=
k it
can be removed for these APIs. The only reason for it is for
devm_add_action_or_reset() which we don't need-

- Nuno S=C3=A1
> >=20


