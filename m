Return-Path: <linux-iio+bounces-16817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A783A60ABD
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 09:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56753169296
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE6618D634;
	Fri, 14 Mar 2025 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKSfu3JL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFE12CDBE
	for <linux-iio@vger.kernel.org>; Fri, 14 Mar 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939594; cv=none; b=p8UDJ/6vlUobhPXFLQw70fXHIblJk4dIkbgcqKXB9TpXzSV0zaSlX/9LmIpkrAJRY8Q9B8l0dHh6sRKC/1VaTDrw5Yyy9+7fLrO4DyifYHEW8p+4jVHpQjCNN37V4Z3vWs8E7oGhlkK8jHl6mIzWjIYfPDTWkD5eACnbYuKLe1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939594; c=relaxed/simple;
	bh=Np2+ir/YDyqBGLE6/yaW/9ul5aC/JmyUQ2E9dd5YD8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h3hm0xz3pASPeXOm03CjVAto0kOqyaqBSJK/RC5wOtAUYQzZ1PS4a16XE+kYRJl5VL+wN9PXD2meRsAv/vAfSqyLMbTHh1H3xRagvDnVOkOJAl7Zk9R2Bbz9o6mKivP+K6T5HaZwNCQ/e6POLUloUOzARS2bZnLetdVblLLjY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKSfu3JL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39130ee05b0so1784058f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 14 Mar 2025 01:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741939590; x=1742544390; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WcW5nhaDnk/bftEW3wFXti22zmjxrW0wrKPIP7nBta0=;
        b=GKSfu3JL9PH0Lgtz3TNOCWn8v0UJ9Lm+RcP00rMcOCPWvaK+eOOPS0m3TIgnbl7SSD
         /MIwB5TeaW0kYs0FHKeUK3u77OiDiPY3NE/IRPOcTi+bUe48o/5b3n8j1YBlctW4UfbP
         8FDNOtW9o9cKfncy9lYUzRRvW/NNffT10hRuGpwjm7bjYAhs80uj653tZgyIrzfcLAUh
         YE1Dxb7Rr/x6tfnVBhg3C/FAGq+W5aqvkNGafEG5UDINEvsrjSbVmtcuMlcIoZNsMhrJ
         KWJlVGh0BRboKsD13EopcrrzGHeUxkrb3FmRkHbRpaZjxxVDVMh5v29+GhI/gfbDwaIg
         3rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939590; x=1742544390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WcW5nhaDnk/bftEW3wFXti22zmjxrW0wrKPIP7nBta0=;
        b=sWTQmtdKeT2BsOlydzVt9BTft2LZpuJGRtC+V2L27sy2FHI+HoDi+TRcmjsn1Peuw9
         w9HB1hj7eelhp87zZCqyh5BJ/jUaybUqGVwdeHF/LW5iSDWWiGGXmBXqw1yxJxQikkYW
         yD5j76xGVUrQtLi43Uhdntlpih9X0Ol70lhP0Ii2rkKFq9A5vJB0dXNBfEYk2XXV7I7U
         raBArXZ2Eor3ZBnucm1tBZ5vx3az+sm6Fen4IgAlQ80FaeURf3ZCndRSC+jLYC19qaCi
         CWPrbjXDbaFNexh+FHr4EWleGWhROs9xbYvGUUqvK5vTrSqUWvwK15Eorwt0wlWYMM3L
         h7LQ==
X-Gm-Message-State: AOJu0YxgsMUCJ7zCDvZ7+sJc1UnUZ7wL1P3K6K0MTbDc7czQ+mRDqt3O
	XkW4Yk10ZBtN9NYZyhq3VgZotM6fSZPeqlVoqOuW3298zP87uDr1
X-Gm-Gg: ASbGncuMs/4DyTm8TXOdSeYVFb7MyeBBPKAqul3QCn+VBwAvjOJuACRekWmX9d7BP/Y
	Z7nSkkc93TUcEO73IIGxlaxEdY4SQRW+3Y/mZTmehfZYC3S9vGoS1343Gcl8FmrfqoE55WHXQWq
	DBcgSUbPnjNQfjEtyzdOcCpXLYC3EaldJjCM/+HwiTDI+T+phaohRslwMaU1sdzmSzgHDcq9t3q
	XFhixEZVFogD3OU7Y4CMTaEgY+pXOrsEqLQ26UYa7Ul0VgflGcVo8JP/e5Bx1dJ2NqVS1ClOsXi
	NXIGi+YEfly3MFw4U2leTNl6AOW8hnfnThgJLEDDv3ELznw5HpAm9O+y7aMIY6uLpWKqKBdb++o
	pSzgTBUZZNdE8+52NFyfzx0EYzqjcbw==
X-Google-Smtp-Source: AGHT+IHUxP92cIx74txTEoSNldn/+MitmD3ADr619kkZa1LITQ2dqqzU1WBR87S8p5slRgmD2CR6gw==
X-Received: by 2002:adf:a31b:0:b0:390:eb50:37c3 with SMTP id ffacd0b85a97d-3971e0bfa2emr1494080f8f.27.1741939589479;
        Fri, 14 Mar 2025 01:06:29 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbcf12sm8925885e9.12.2025.03.14.01.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:06:28 -0700 (PDT)
Message-ID: <62edc1d1b8ed3911e148505fc7ff0d403e53bdad.camel@gmail.com>
Subject: Re: [PATCH 0/2] iio: adc: ad7124: Fix 3dB filter frequency reading
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-iio@vger.kernel.org
Date: Fri, 14 Mar 2025 08:06:44 +0000
In-Reply-To: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
References: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-12 at 19:38 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> here comes another fix for the ad7124: The getter function for the
> filter_low_pass_3db_frequency sysfs property used wrong factors to
> calculate the f_{3dB}.
>=20
> The first patch is a cleanup I implemented before I noticed the issue. I
> didn't switch their ordering because I was lazy. If I continue to
> discover issues in the ad7124 driver at that rate, swapping for this one
> fix doesn't really matter :-)
>=20
> Note the setter function is still broken. And it's worse enough that I
> don't know how to fix it at all. The relevant part of the function looks
> as follows:
>=20
> 	sinc4_3db_odr =3D DIV_ROUND_CLOSEST(freq * 1000, 230);
> 	sinc3_3db_odr =3D DIV_ROUND_CLOSEST(freq * 1000, 262);
>=20
> 	if (sinc4_3db_odr > sinc3_3db_odr) {
> 		new_filter =3D AD7124_FILTER_FILTER_SINC3;
> 		new_odr =3D sinc4_3db_odr;
> 	} else {
> 		new_filter =3D AD7124_FILTER_FILTER_SINC4;
> 		new_odr =3D sinc3_3db_odr;
> 	}
>=20
> The issues I'm aware of in this function are:
>=20
> =C2=A0- the sinc3 factor should be 0.272 not 0.262 (which is fixed for th=
e
> =C2=A0=C2=A0 getter in patch #2)
> =C2=A0- for freq > 1 the if condition is always true
> =C2=A0- In the nearly always taken if branch the filter is set to sinc3, =
but
> =C2=A0=C2=A0 the frequency is set for sinc4. (And vice versa in the else =
branch.)
>=20

Ouch...

> Also it's unclear to me why sinc4_3db_odr > sinc3_3db_odr is the test to
> decide between the two branches. Maybe something like
>=20
> 	if (abs(sinc4_3db_odr - current_odr) < abs(sinc3_3db_odr - current_odr))
> 		use_sinc4()
> 	else
> 		use_sinc3()
>=20
> would make more sense.
>=20

I think the below is indeed the proper solution. I know that removing an at=
tr like
tis breaks ABI but since this interface is fairly broken anyways maybe it m=
akes it
more acceptable. Anyways, just a minor comment for the series. With it:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> I intend to add a filter_type property to the driver next. When this is
> implemented setting the filter_low_pass_3db_frequency shouldn't be
> needed any more and we can either keep the function as is (and
> discourage its use) or just drop it.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (2):
> =C2=A0 iio: adc: ad7124: Make register naming consistent
> =C2=A0 iio: adc: ad7124: Fix 3dB filter frequency reading
>=20
> =C2=A0drivers/iio/adc/ad7124.c | 176 +++++++++++++++++++-----------------=
---
> =C2=A01 file changed, 85 insertions(+), 91 deletions(-)
>=20
>=20
> base-commit: 8dbeb413806f9f810d97d25284f585b201aa3bdc


