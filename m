Return-Path: <linux-iio+bounces-19226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37202AAD7D0
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 09:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D599B206EE
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0AD214A6F;
	Wed,  7 May 2025 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsRuZzMY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BA214A7D;
	Wed,  7 May 2025 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602593; cv=none; b=bmjpB7qV1SuES4uyqrM8jQaN2+iOsC/gLv/jvhemFakWBzALlTJT+4GXgnCy0PKJcVWmHdqZgOLgB3ZRd/a4ZYpQwxNOKt26GwbGty1xLYr13ZcO72ZcNwix4pItgsPDKUc8H4NkHp4dro61ppWGOrKRqkHXXuKW7waOb6S7yEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602593; c=relaxed/simple;
	bh=zzQDM7rFrnKw2zBb55C8h0nwowW7iIGVTdSRpuyGpog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZGUJxhQ+SizUvvWMPgAXByPnqDdJQZl7witJh/WmkcraGRvNOWaLpuG0nlkrVz6/+U8ciHID6r7VJyN2gzzOBMHf+5/DZ6SrZhHtcTiEZ8pAMc93qLjhpYC5kbA8cQRlRbLHHbIli+F5sGNMm5M9LaaFiH2XxjDk+amCWi3XAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsRuZzMY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39efc1365e4so3132601f8f.1;
        Wed, 07 May 2025 00:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746602590; x=1747207390; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HHUK2W+R5/NcKaec57McPVIU/CaLWo7Hp3y8UpO3pnc=;
        b=PsRuZzMYPexAPCDbvWjhKShpG/e8o/5hkiu/Rhx2a1H4pqburz+uIGPN5jlYpC3SdV
         bOfVnEyp3JX88DsTny+WQrXVh62B3l8Vyq5L5q3incsg1LYTXLMyroRV61MlFxMqu/pM
         +QK8d+xOMniyMVIFEOiAlrTD4xUfZP61lfQFqUN6IyQ2Qr5y4+UiVTLugRJruqLrSp7J
         CqayPOtlXMj3Z1dWOT0ZKGmrWfgN23N/MxNl5ELjiozPbLj6No+leAnLsTVSfMAzUjJH
         JaW05YldXrQoib32hSuXPVo4b0l91L/94oPld3TjCyHDQF4Hrk1jydq32zavgiQsU1RN
         HKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746602590; x=1747207390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHUK2W+R5/NcKaec57McPVIU/CaLWo7Hp3y8UpO3pnc=;
        b=lm+I573NJ17kGGhQLX0aseqSqilaL/+861Wp2ZNU1Tz7RQBNqkIuxZNepRlqiUaTWA
         Y/whTNpYA9GKMi5laqhJ/M+LFmJmcWh0sr9LNtzFkUkflPuih9cUf/9P0pENJ0LbP7wq
         6UBDdmxKYKP4KMd1oKKh3HNmDXrzVU+6s6YOVnyYe6bEeLpmIu++Hz+B7aLqRuTURJk1
         esA4w2w3dbSJGERhjQbOXU5rmPquh4xt3+uykD704ie6eund8gaun5JDTn08yesWeqP6
         E07JPbzUTLzI/fGp1A1jIESLj4CyAqoohiibG4nyDU3QfSUr+vkJoyUEh4+rCsRp+UTB
         eDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBo1xytPD37LygWsudPVBvxkbMcCjXkg76WZbijCQ4Mbnzur6qlnU7u1gHJzTOfYjHMxD9GFerIRI=@vger.kernel.org, AJvYcCXIfp1XKpMzQLG7IbtoQm7FS2YRT8yrLtNl41CPO2CD+hbT/9phFp66Ugk00QkIHF3/6ApK5v7KSJHlVVn/@vger.kernel.org
X-Gm-Message-State: AOJu0YyYq8Cqf7i9grAua8svEvzAYS7+nHAd0ZTOY7tRewXreuVBbZ+f
	bYbcyd3vKGi9qnnX6ZQ/wJDawfEHfZDAwHzQIcNWD+eDLJ/+c1j/
X-Gm-Gg: ASbGnctMclPzPc6Gxwkky/wURcDM8eU0u0Z5goHZ9N09XdLRt50RvzAXG3hDZwimTF1
	iO9jecBFQMcvzfy3U8GK2LoyCy0ULI25JKj8+7BW3zDyzHrwpS6ke50LBNNh8u+KJwI7Pd7KIGW
	sywBBAqT32NmjU2dSHJlLSUcAGGmvKLge0L1674pB2SIb7knAENkOmtFePVY9TzCi+QUTWMjY0J
	Eb4SnfKViFnY+R8nPhMuu1EEtWAeo4Zzfin/RJj2mvgG0ay/B3bMzqgF2KtyIrLBl7HM4wmZQwz
	kSUma6tz98RkZAr7rRCZrhFccAY/V+4Pbya06arcxrNPSWf1li4NF6FGdH+YJAn9S5FVBMZVpIk
	zgZnVe97YMIhdoAA=
X-Google-Smtp-Source: AGHT+IFRdajxXPOtGFfc+26fgcNwEI65OiT7+TUbL4sOGVeukE0gKNqN8yhGh8x2z0m9v8+ZDqP5/g==
X-Received: by 2002:a5d:64e7:0:b0:38d:b325:471f with SMTP id ffacd0b85a97d-3a0b4a16497mr1984298f8f.15.1746602589898;
        Wed, 07 May 2025 00:23:09 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ffb1sm15923314f8f.73.2025.05.07.00.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:23:09 -0700 (PDT)
Message-ID: <66e8ea9630d69b16fbffdc55d2cf77e0820ebcc3.camel@gmail.com>
Subject: Re: [PATCH v3] iio: backend: fix out-of-bound write
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Markus Burri
 <markus.burri@mt.com>,  linux-kernel@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,  linux-iio@vger.kernel.org, Markus
 Burri <markus.burri@bbv.ch>
Date: Wed, 07 May 2025 07:23:34 +0100
In-Reply-To: <aa7f18ce-9330-4a30-93e5-85489f507a42@baylibre.com>
References: <20250505203830.5117-1-markus.burri@mt.com>
	 <aa7f18ce-9330-4a30-93e5-85489f507a42@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-06 at 12:00 -0500, David Lechner wrote:
> On 5/5/25 3:38 PM, Markus Burri wrote:
> > The buffer is set to 80 character. If a caller write more characters,
> > count is truncated to the max available space in "simple_write_to_buffe=
r".
> > But afterwards a string terminator is written to the buffer at offset c=
ount
> > without boundary check. The zero termination is written OUT-OF-BOUND.
> >=20
> > Add a check that the given buffer is smaller then the buffer to prevent=
.
> >=20
> > Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack b=
uffer")
> > Signed-off-by: Markus Burri <markus.burri@mt.com>
> > ---
> > =C2=A0drivers/iio/industrialio-backend.c | 5 ++++-
> > =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > index a43c8d1bb3d0..4a364e038449 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(stru=
ct file
> > *file,
> > =C2=A0	ssize_t rc;
> > =C2=A0	int ret;
> > =C2=A0
> > +	if (count >=3D sizeof(buf) - 1)
>=20
> Isn't it OK if count =3D=3D sizeof(buf) - 1? In other words, should be:
>=20
> 	if (count >=3D sizeof(buf))

Oh, indeed you're right. Sorry Mark! I was the one asking for it but I did =
not
realized the comparison was '>=3D'. So I was thinking if (count > sizeof(bu=
f) - 1)
which is pretty much if (count >=3D sizeof(buf))

Arghh... Maybe Jonathan can tweak this while applying so you do not have to=
 spin
another version because of this.

- Nuno S=C3=A1

>=20
> > +		return -ENOSPC;
> > +
> > =C2=A0	rc =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbu=
f, count);
> > =C2=A0	if (rc < 0)
> > =C2=A0		return rc;
> > =C2=A0
> > -	buf[count] =3D '\0';
> > +	buf[rc] =3D '\0';
> > =C2=A0
> > =C2=A0	ret =3D sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> > =C2=A0
> >=20
> > base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
>=20
> It looks like we have the same or similar bugs in:
>=20
> drivers/accel/ivpu/ivpu_debugfs.c
> drivers/gpio/gpio-virtuser.c
> drivers/iio/industrialio-core.c
> drivers/iio/dac/ad3552r-hs.c
>=20
> Do you plan to fix these as well?=20


