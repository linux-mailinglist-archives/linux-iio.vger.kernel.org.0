Return-Path: <linux-iio+bounces-2286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC6E84CA62
	for <lists+linux-iio@lfdr.de>; Wed,  7 Feb 2024 13:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17FF1F2C1D8
	for <lists+linux-iio@lfdr.de>; Wed,  7 Feb 2024 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA2859B7A;
	Wed,  7 Feb 2024 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGOf0Qwi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B259B5D;
	Wed,  7 Feb 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307522; cv=none; b=HzxJZj1wo/6G/IlQWdMz0zQA0xCtWahg1L+Lk5CsHoLdhTV2uMivUBTSqU/nAd43//qzbUc7uSxA1L6RTraUDxLoNlE19S1S+ahjXJJGOU21IfgN7w5Zii2T4Kz8JDiU9mPRbFmEsGq5utaB9ClPU7w/Z8Uhdfml0jS8wN0YyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307522; c=relaxed/simple;
	bh=hqp7wpHI5u8+fH/hdkw51Enh/lNWecZTbH9l/+a99WE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVGQlo8AyENrkl1wNfTX4EN4jnKBXv3g+KKUInV46Y8KjJuqGp2avx9z0t30Q56B2NCPDFdHa8JmfvPCs/GPVB5xTezr5Gir7arFeMO1OBS/Lt4TUWsUWTLXr6GERf2eK48jD3Zj3OBOsvxIHR/uxKlEFQgX/b3dooNF4/3pBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGOf0Qwi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso82613966b.2;
        Wed, 07 Feb 2024 04:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707307519; x=1707912319; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hqp7wpHI5u8+fH/hdkw51Enh/lNWecZTbH9l/+a99WE=;
        b=aGOf0QwiJTdh4lnyQL+QsMQuT0GTSJsJApFf0T+wzXRxuDL0TH/QJlAr4533BpFfPX
         K8q+e90CbkmUw4r3anye3rlf8Yy1AljITs59ESoN6JlNscrTIYK+fY1u6GipVVnOip98
         GFtdSi3X3lUYHTwJbwPXyToatJBK6eWJCEVxRNJG6iQsVRDFRU6znthkPvLHqR+nigQB
         yp24yysd2ta+1E/qojVf06uPTC3ABchrUE7FrQaK2wv2W5lb3HeEbjuGE0WRnW561es6
         VNRc0hPRqP22mzmybduxyePJh+m0+zSN1muzCZVKSIFZv8eEKeblWRCNkgaX48yEKYrx
         9MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307519; x=1707912319;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqp7wpHI5u8+fH/hdkw51Enh/lNWecZTbH9l/+a99WE=;
        b=kWflorfZk5uhKJ1JSHmPoOKj5U1+jmRDB11rZ+2+QMKmTX+FmEhbOCH0x5zO5ZScPZ
         bOyfoPPUmhYZyU2k20rcMJRMBz7UebZ2LXUh2joQm7FNqe4BzCj4tLOr62kaefQFzoti
         HWyhAQZEzw7z2yxPFabbm1N+jEQRQ87oRGzIvJZzPJq+j2C3de481tpaEPkrBppWU8mA
         yq4/Mzd0xOXDq2dXmGOOXScrexc7omscTiFZ58wgfQWQrzCIzrHZFoVnPXOa+nP880qY
         +7qhfPo84sEh+DdFbFe4O44PSYhSC9jB4RnSMaRh014vs60W4nRECAGZVGgyeQyLDv0l
         i0Zw==
X-Gm-Message-State: AOJu0YyPSvIdJ4c7FjS6D2gQ8a36H+Wabjvr0t467Be//66aSmvI+B8F
	17PpCg2LSrFAvF9qMRExAX3WL7gSUOselCDBbvD0hmbvcI4NjDde
X-Google-Smtp-Source: AGHT+IHKm7U8oRMgNFqACdRc38/gIE9sbsygnzXyDP21P0VvOwxa0eBvcE98YezEKKi1hRiIr21yiw==
X-Received: by 2002:a17:906:218a:b0:a38:5e8c:fe63 with SMTP id 10-20020a170906218a00b00a385e8cfe63mr1539332eju.61.1707307518581;
        Wed, 07 Feb 2024 04:05:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5Vxo7RwtHeP4h4iO/2nbI93NqCLPwwC/YiY+rk5sFWrQrOtkytcUJvCc7Wn/d+U5CqimM4BM7l0/Y9YVYDy3JyyZQQk/1Ma2qFdnGnEvbnX7j0U1n2VnfvX5wJUB1MDlNQovJSQNuv1ZnnO4eKayZhq/yAuFYxxuX5Rwm8MALXHqc1w3GA4j4JY0xLu5u5S0a9HVsSWw8eiDJTeD+zX/XY8aLP75mYJWqXgnJbaV4u0FEX/txfErQitWjy6Rnt4yeXh5H3GM/Z4y2oZ3BTA15jh7Lm8fzv6s/0yoA1t5KPO4/3ybkywq2kcRZ6WEvKM3z6mvAtmr71kv7ywvtxJ0Yb8doz98oIZFLqjN4R+UoFQaneamqXs6lqNkKOnG6WVHN4CX2BC0=
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090633d700b00a3634a461f9sm677811eja.109.2024.02.07.04.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:05:18 -0800 (PST)
Message-ID: <023a660012196e5c3d7679eb78a70cbd8787f6f9.camel@gmail.com>
Subject: Re: [PATCH v9 6/7] iio: adc: ad9467: convert to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Wed, 07 Feb 2024 13:08:37 +0100
In-Reply-To: <CAHp75Veb2TWQQzw=8q+u4YiPX7Q5j8216WL=HaqY1eO_JjPj9w@mail.gmail.com>
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
	 <20240206-iio-backend-v9-6-df66d159c000@analog.com>
	 <CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
	 <CAHp75Ve=Utqb0rtuO9c7xkxqpasFgzj4x4d4mm-CHM=_XJUrrQ@mail.gmail.com>
	 <8d7d33a633f258389adba39930769d577a05cab2.camel@gmail.com>
	 <CAHp75Veb2TWQQzw=8q+u4YiPX7Q5j8216WL=HaqY1eO_JjPj9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 19:50 +0200, Andy Shevchenko wrote:
> On Tue, Feb 6, 2024 at 6:52=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> > On Tue, 2024-02-06 at 16:20 +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 6, 2024 at 4:20=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Tue, Feb 6, 2024 at 12:08=E2=80=AFPM Nuno Sa via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> ...
>=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .max_rate =3D 250000000UL,
> > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .max_rate =3D 500000000UL,
> > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .max_rate =3D 125000000UL,
> > >=20
> > > Forget to comment that these might be preliminary converted to use
> > > multipliers from units.h...
> > >=20
> >=20
> > Note this is just a conversion and I want to change the least possible.=
 I
> > can do that
> > in a follow up patch.
>=20
> Yes, that's the idea.
>=20

To be clear, what I meant is to send it after the series is applied. Not
intending to include a new patch in the series :)

- Nuno S=C3=A1

