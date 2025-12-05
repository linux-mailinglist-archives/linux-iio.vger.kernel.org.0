Return-Path: <linux-iio+bounces-26783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEA6CA7571
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 12:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27FCB3023146
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 11:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0512C11F8;
	Fri,  5 Dec 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANRtYEDi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6129A322
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764933463; cv=none; b=V0+16C+hazN1BCNi3mTxbv9Csv7rPVb9Pgqx469pGzQtmAGBJYdSFmLQ08qYR7xJRnd68s/pojvVs5WVM9LI8Jn8V426IyDDrCpkg9Je6wiRaClGHS6qKTFgcL24Pjh2eI+WGT30HBubXmUkoDT+jrB+bAcfbRCqjfGDtSWThbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764933463; c=relaxed/simple;
	bh=ok0CnOEsKbEPGgLDIeb7Gzo1ydpNHQJysrD4JlFUOr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WtYEidHCxImxiD6FITs4++gNGlQ5ef5qXplL83QgPeRkD9/mu+PgGIgAziaZupcsiOTiGtshXkcPcc2Y1xnEkVUI2p8X9/a3iQq0DHwtL4ItRl9wSr6fIXYNolVeWKEjOqEaoJqZR5pDOYZTNtPClW4GbNZZUQx2er6Z1VvVHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANRtYEDi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477632b0621so14264635e9.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764933459; x=1765538259; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ok0CnOEsKbEPGgLDIeb7Gzo1ydpNHQJysrD4JlFUOr8=;
        b=ANRtYEDihyIyLdj3NWFj86PgKoAH/CKufQ9cQLmJ0ETMFw5qV39WTbIUs9Qywt4jZ1
         Q0w2K/WxBf7kafvWwglc8XIE+AxI3HHvMXM149bvGfMBjQMz+W/LDpZ2V8wz/beRfdhK
         mzKRgREqFfJOySHNocqKngmDG31mQE1OafuZeXmsCRRjhtdiZWsh/Ty2vcrVVocpW9n1
         DQ8p6TEDSCs0a+UhPftve8RxybtDXaRb/+7sNhf3rPjPYcB+wRs4LymoMnXKBVs014us
         fDixXrbLhbNOcPbr7yxfVclDk5SAU08xpFvHqjfsue+s2Y6ifVS353PL2h1Jh4xmXWy6
         8alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764933459; x=1765538259;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ok0CnOEsKbEPGgLDIeb7Gzo1ydpNHQJysrD4JlFUOr8=;
        b=B/Hj04A/tW6GpF261CV/Yo5vi0V3XCetQBQB2PBqh1JABuCyVPS7hDj4wFoiEF/gYG
         rFM/pgoKyxjoJxZEsECIUpe5q2NFCIpoWTmYarVqV5gbA7S/Z5LUliLbYce8ZAMbd8vW
         iMwoCLMqP8It+g3pyiWq3qMdO2g2Ceu37rZ9nhrig5zzvBdAksFbi5YIIjYX6BHJjTTI
         IHTxImfUukSW5yA9n2RKfGeSz0bAZOnOEpR1CcPtXpsxZsbaTVFwGW3JD+zi9+9EC5t7
         tP1OnQ5Vx244kt/OONiYXzNM9AI7EFQ+aKAJhrrL4PEtZpT8TRx3tK1H9O6hrYZdzpB2
         sUHA==
X-Gm-Message-State: AOJu0YyBlUGBS8gMoco+bp8qYltbfk/PQ2Ad1j4Mh+1iiZRlJLqSHG1D
	Su1bl/g5uhZ82Ilc0E1mMG9r6Rd8NUnnE5s19u5hkQqqu9NMxuQX7iPg
X-Gm-Gg: ASbGncsYibmsWQltxHvSwMYS5gvUK4kprzOxsGYETF/G5dJAKU1gOAP3g4MRH8CmiFG
	4Pz3+t7GgwRQl306N0ceaOF1vGu+rnFG3TNPbBQlmexwGoDobD0qFPSUrTw9ssA1RpzF3PRzkbN
	SLDPoXhgZSkDD3PcGYCAC2cABpmeXIejTEcF2dIci5o5Qq3UkbiowJ/sgfdsEatnHI7BuFOxHF9
	EImMNnzJMRhxGCP2LPl9dKm8i1lhzKErAkM8nSKpjkaTOZXuV4EIGrB2bwsxtbz4eq/1o8pDkgh
	dsDsYywEI7U46kJ8Ug4KGII9G9LyJsmALAnN7ErhsykXiQ0jMibemspD1w7emjrlMc+yXTml26H
	qzQidvdl4Gs89Itf0TZvPABmcchoddOWQIK7K2QypHXrxiyvFO4O8MG2NWgRGgkge0sCe8+z+zd
	e3Sq3C7/9Hb5GDBOBKJBI=
X-Google-Smtp-Source: AGHT+IHbDukBOHgHqTiXjfHCCwU7YmNMNifrCOiVZp6QlczE7PXOOtD1wEMoHlJ8oqCZPwQzpfOn/g==
X-Received: by 2002:a05:600c:4f8b:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-4792aeeb58cmr96006435e9.10.1764933459109;
        Fri, 05 Dec 2025 03:17:39 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b02e806sm57794245e9.3.2025.12.05.03.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 03:17:38 -0800 (PST)
Message-ID: <a74364aec06a6d26569c84cf83b022737612a5c7.camel@gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: adi-axi-adc: Make use of dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron	 <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko	 <andy@kernel.org>
Date: Fri, 05 Dec 2025 11:18:19 +0000
In-Reply-To: <CAHp75VdSAGxy-fkdigSFumKuRNDGtF-82sbdMoPyNpBVv5nB0A@mail.gmail.com>
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
	 <20251204-iio-axi-adc-minor-change-v1-1-2d441d6c5b65@analog.com>
	 <CAHp75VdSAGxy-fkdigSFumKuRNDGtF-82sbdMoPyNpBVv5nB0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-04 at 17:33 +0200, Andy Shevchenko wrote:
> On Thu, Dec 4, 2025 at 5:23=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > Be consistent and use dev_err_probe() as in all other places in the
> > .probe() path.
> >=20
> > While at it, remove the line break in the version condition. Yes, it
> > goes over the 80 column limit but I do think the line break hurts
> > readability in this case.
>=20
> ...
>=20
> While at it, you may also add
>=20
> =C2=A0 struct device *dev =3D &pdev->dev;
>=20
> at the top of the function, which might lead to even more cleanups and
> neater code at the end.

I'm fine with it. Need to do the same on the DAC series.

- Nuno S=C3=A1



