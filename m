Return-Path: <linux-iio+bounces-25084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51713BDD4FA
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 10:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C56420C3B
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 08:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905932C237E;
	Wed, 15 Oct 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZzzjpW3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B4204F93
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515687; cv=none; b=NTpw9TlHbTpBTH0jIFUdH7CIs+fpbrtbhRIb7M+WsX3017VBWQyMgaF22E83bJvYgWqFpelDpnsc8+SJjEqB2mE9K1b0HI7BIaOwr4wH4F/zbI5i1i60SCZUrSF7GLqysjCEccFu3M2FjCW+UdOaH+AibdK6kdl24xqLMzovP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515687; c=relaxed/simple;
	bh=82lMN3PHx84x65T7bxBEjnc+PP69vV3I+4c9g6/+BJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XuevtW6VgevGoI1X2yZMHdSvOic/DHmRbIN8OYmsiTcaokbFr1uauCdxtrBs5XHGmHeL/9M9Ye24Hf7iuwt96h63NqV6M0GU0cY6Nk1y0hJLSBOQxFoe0hPmmheqKsXJfgX6iAeO4yAjrAQnHZCgZFH6wrguLWtW81S3tZqq51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZzzjpW3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so35670785e9.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 01:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760515684; x=1761120484; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qIKUsHWr4EfW1osCBnZfPucjiZ7QQGt9ogy8NGoGeu0=;
        b=cZzzjpW33vJKxJZfkWy6OOLBkRpzRY+j8Wi6NfttEqT+jjSCmSJS/lxRV35Je/PVYs
         OrhmUg+cE6HfLjS07yG/537+R95fGBGLwwiU5SNJGIq/9yfASqmno/bSoIKOz/rsuzLb
         xY9gK6K9Nc2SG9nHMHiq7umUcnJzaNrHVESHGsGHBcCtxaUWAz9IGTRBQsvR3zBwdihZ
         s3M6U548JPNFH52yPStE/9VBmcE5vqCDSrDAOMcAfIuB1ZsAa64+GRBWYdy+zyYa2bby
         ppLSMgvIA51Qe94cqv585jJvbWkKM3YaSPqjS5+RXvJIP9aUNKam3d+RYh/5bOf5MdDn
         c30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515684; x=1761120484;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIKUsHWr4EfW1osCBnZfPucjiZ7QQGt9ogy8NGoGeu0=;
        b=RiBzcTZOJ1ZBhiADgkNxJ0lXBJ4RjCfIStwnqms0A24be0iUGkB0WHRSbpTUv669jY
         2rq0OFBB3Jmk57r9vyR3/b9VmMHK3Dul/YulfU2GXLDhvhLcu8E8wLxnlgWv+hdhuSmy
         kk9+/MwM+PQCHOThWfLmVdF+q4BOmsBeiNxW+dGebZAp+ytrWVjUjOxaZUt/uTOnBwV8
         FQG1BxksYQ4q/YZasKeBuMMAZtCRbDjfuxgiTBZe7VhU/aibjL5sXJJgqVoqvVv2lTb0
         Pv7UFdQpRTU/ARNN2MWO1frOvwjTVHhleFzN5Q7rNmSn1UkJVAP0UP7CvubawJyFQrlY
         lsww==
X-Forwarded-Encrypted: i=1; AJvYcCWfImnZJi0V2Dbpqi10ndRP2DakZ/hBxzYXqjulIHZC1064giYAOZjFsVOOmjT7iKOZcd7S24+HRIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DINqrq27Vobr4X9Lprh5E2httbRVmuO6tUO+peQU1KmTPfP4
	CFCaZIysRM5uIhZYCZPx5kN5JARm5md0FYZ10jyjjO91r+q9u6X4U/LC
X-Gm-Gg: ASbGnctLuW41LLRS8Cwk0unqLjWgfEKBcEQbmK9/IE9JsNMplGPW9mtVYCxdaVt7T06
	xAgcdkhDt+65JIfjfM4mMEjo/ndL63F88QdBlvP3yJm6U2nBm+2e3omm7+PGFI6998EgB58n3Wt
	m+PUTYFMd/2PNYbkbCCkqUXEts7TwdT8J/8jqTIn8ppREq354V8ybJD2Gt0/83TZTwdvZudxKfs
	CgqHTKcWy5kCEojPJSaQmmE8drYmOIJjLWKcLmZSJoov+tQkAolMkHECdwt1cPXJRfLADSUeDeG
	TciyNUYIY8tYFaFA2uKLqo8CDwhsMWCwQ1JufY1yfRxf09+OaYPqv3ViGiO2NapZUUTXXTV06gD
	ZRpvaAwokpqcFf05WuWeV5Pm0K4anzJoJyHxUjvk9+j+4fIVXeg==
X-Google-Smtp-Source: AGHT+IHP8N+3px7skvkLMWNcnItWcn1+rGFvMFcI3+FoelwYasutqN3qkfYTHrtQ97up2D/uCItX7Q==
X-Received: by 2002:a05:600c:6304:b0:46f:b42e:e39c with SMTP id 5b1f17b1804b1-46fb42ee509mr132021525e9.41.1760515683625;
        Wed, 15 Oct 2025 01:08:03 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47106fc96bbsm2575855e9.3.2025.10.15.01.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:08:03 -0700 (PDT)
Message-ID: <ed298de2b13040534bb25bd186111f4761d574df.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad5446: Add AD5542 to the spi id table
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	 <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 15 Oct 2025 09:08:36 +0100
In-Reply-To: <03b3c597-0576-4468-a23e-cf6a4b7daf86@baylibre.com>
References: <20251014-dev-add-ad5542-v1-1-cfd197db03a0@analog.com>
	 <03b3c597-0576-4468-a23e-cf6a4b7daf86@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 12:15 -0500, David Lechner wrote:
> On 10/14/25 11:11 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >=20
> > This adds support for the AD5542 single channel Current Source and
> > Voltage Output DACs.
> >=20
> > It is similar to the AD5542A model so just use the same id.
> >=20
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/dac/ad5446.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> > index ad304b0fec08..6e4103f4afcb 100644
> > --- a/drivers/iio/dac/ad5446.c
> > +++ b/drivers/iio/dac/ad5446.c
> > @@ -422,6 +422,7 @@ static const struct spi_device_id ad5446_spi_ids[] =
=3D {
> > =C2=A0	{"ad5512a", ID_AD5512A},
> > =C2=A0	{"ad5541a", ID_AD5541A},
> > =C2=A0	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible *=
/
> > +	{"ad5542", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
>=20
> Should the comment say ad5542 instead of ad5542a?

Yes.

>=20
> > =C2=A0	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
> > =C2=A0	{"ad5553", ID_AD5553},
> > =C2=A0	{"ad5600", ID_AD5600},
> >=20
> > ---
> > base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
> > change-id: 20251014-dev-add-ad5542-8c8934de80ee
> > --
> >=20
> > Thanks!
> > - Nuno S=C3=A1
> >=20
> >=20
>=20
> Interesting... no devicetree bindings for these chips?

This driver is old enough where things were less strict (I guess) and it se=
ems
no one added bindings for this.

- Nuno S=C3=A1

