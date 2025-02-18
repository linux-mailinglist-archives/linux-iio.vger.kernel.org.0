Return-Path: <linux-iio+bounces-15737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED92A3A2F4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 17:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7551655F3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0033C243387;
	Tue, 18 Feb 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6OZe3H4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B511B6D18
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896561; cv=none; b=BXBPlIFTf7p5HjwniULtiyueWj5PO+UNwQr7odMOmabtQ0Cm21yfoMjAl2n7J/HPFBPn1r8VripgZnrk4FwNvuVlkq/Ynq0e6XomiO3sVOKslOy8QfuNd3EKflBTy2xuuIRLaQ9ka07N65cJohDHO8Mme84Ravd6i1KSpyEnxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896561; c=relaxed/simple;
	bh=ubHVSzE01PyizaDLgsvgRRafY+L5j3bAFbd3vA44MEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nkfLypG1yL5Y9SNPk8JI1zU7D5djZQTPEjhga9ZaCGlbiJmOauxNKtq60vDp3+SJdHPtX+Wwl4+/aSF/c/hTDyUqjcKTTKVeAjSElgP/+xAI30I/BRKUdhNiNeJ4++tnSu9+oKDzFTNV6KDc6n9OlZq1gwrBsOx3IUZr7EaF3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6OZe3H4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f378498c9so3062212f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739896558; x=1740501358; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=51ohHozxJLdmvR1ibQWkRdhwH2tGg0ZtTw8U87yRqKk=;
        b=b6OZe3H4VFsFXg50jX7At0ATh09L1p6UhcmqmjcaesFGiWhRsmRtnqebKLbf/rcIH8
         W9No/50DuzitoXUtZ3JZASz++tUiiilswsO8zgu2NWAN0M0GlZdsvEpzKvCX61A6yFcE
         gpBgkLIbA+pomNzPkqG594xd2uCDwrpGw44sDkcvjgwSCyRfqyDYSBO85F79AG73PQOB
         2jjrb8pg6u8WB8OM08qwEvOpYGtIc5VRaTUyFuSSdAzbSa7gxhMSTzJrU1ZB2UgC/fhF
         Xw4zW2HwHNQGOJZEaWR1Id9uM4AwZVJjhjtDRxlyRKZWEfDa6V1DnT9vrffYwf+5zeGM
         1X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896558; x=1740501358;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51ohHozxJLdmvR1ibQWkRdhwH2tGg0ZtTw8U87yRqKk=;
        b=P+U+B+KQ0Stdn2u3p4HwzxcLEEsOR6RYDdTZjZgzv6N1XCPzDwC3Gg6dwm9QXKh4ni
         VTaF48NKvgOwy1wa7d3j5nLJ/3FnRud6pnWoabaJJyXsvIANSxZDLsh8ZmQc7STylXh5
         1aXwv3YNfYz3VymY+0mEiT0wmOV/j0lkOmt3HwdLoyXnB1PbzZKEdiahrPZ1z83d99fT
         DLHEy67THeQkyTpztnwGZLfZTf69h8NtXsuCyNTa8qbPtvxNrfuLRkN80Ztwm3cdaUO4
         JMmH3zthTKWVTRJHBfSRY9IoACeDQdUltumnb3/jOYV6QhsSVDHVO5r8y1E9Gjm1waRu
         uS4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXgpvJ0IuKSUEAFHSoB6B3JWJgXvcXgvmTrK8ZCMPrRsjVqs2YiNEEj4THgMO5ZBLC7OtRuM9i7Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5g3+kY8Xqa59Yg91ElJmaRoQUGou6c8dNIq15bcLlXIIEXRQ
	8qjUyzTiIEXq5gGauoMR050T+OVtK++YnOVgdxFYxnmTaHUcMbkU
X-Gm-Gg: ASbGncvp5sip4zK+vObRarHkZVU6TV5BagTfBbhTKbFd94aN79nbd8qemILomLUq/pe
	rB9NzKpkzN2zQj0rZc6Eh64GyPRS71pV1IlS/DvNoHhRDUj/PAfmdXhu/itPdPOsPgDpB+hbtNa
	5jboyjeze4sraZHYSVAZt+rwj0bQl1gFNGX4K0/Yl+6HR9Wg9WyOnzaMqV/riZ6HPajvxYyfk2R
	teVQLK34UrRS4s0G0rVCeeqPBzHmeBP5vxPYlGvF3tLskrtF3wHCvv15wHxLKR8haIZBW0RFBYF
	rO922Pk3ef0DwT0JYKxWHjFEiDsosry0dkDZVGKu2r6Bimx5Bv0++/Y1ksWSBJ0=
X-Google-Smtp-Source: AGHT+IHjPaOXj2kFtsUDBjadwHuFF73S1IGgQEhH8KGNXpZ79cYmIdDIhXZp5Ymhpj05MM+mRqbtoA==
X-Received: by 2002:a5d:64c6:0:b0:38d:cab2:921a with SMTP id ffacd0b85a97d-38f33f1249bmr11431599f8f.1.1739896557910;
        Tue, 18 Feb 2025 08:35:57 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbb2sm15156664f8f.40.2025.02.18.08.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:35:57 -0800 (PST)
Message-ID: <3ead92b71ccf8b2d4e1762ca369911d637619883.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: backend: make sure to NULL terminate stack
 buffer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron
	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 18 Feb 2025 16:36:00 +0000
In-Reply-To: <553ed40f-f0dc-4902-9d2a-9b690fce6ff9@baylibre.com>
References: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
	 <20250218-dev-iio-misc-v1-1-bf72b20a1eb8@analog.com>
	 <553ed40f-f0dc-4902-9d2a-9b690fce6ff9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 09:52 -0600, David Lechner wrote:
> On 2/18/25 4:31 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Make sure to NULL terminate the buffer in
> > iio_backend_debugfs_write_reg() before passing it to sscanf(). It is a
> > stack variable so we should not assume it will 0 initialized.
> >=20
> > Fixes: cdf01e0809a4 ("iio: backend: add debugFs interface")
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/industrialio-backend.c | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > index
> > d4ad36f54090204bf3bef08457d4aa55aa7c11fc..a43c8d1bb3d0f4dda4277cac94b0e=
a9232
> > c071e4 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -155,10 +155,12 @@ static ssize_t iio_backend_debugfs_write_reg(stru=
ct
> > file *file,
> > =C2=A0	ssize_t rc;
> > =C2=A0	int ret;
> > =C2=A0
> > -	rc =3D simple_write_to_buffer(buf, sizeof(buf), ppos, userbuf,
> > count);
> > +	rc =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> > count);
> > =C2=A0	if (rc < 0)
> > =C2=A0		return rc;
> > =C2=A0
> > +	buf[count] =3D '\0';
>=20
> Does this need to be count++? Later we return count.
>=20

Don't think so... count comes down from userspace. The termination is local=
 so
we do not want to return count + 1 when userspace only requested to write c=
ount.
Same deal as in iio_debugfs_write_reg()

Also note that we pass sizeof(buf) - 1 into simple_write_to_buffer()

- Nuno S=C3=A1
>=20

