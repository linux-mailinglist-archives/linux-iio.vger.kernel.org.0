Return-Path: <linux-iio+bounces-4286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0478A4EE7
	for <lists+linux-iio@lfdr.de>; Mon, 15 Apr 2024 14:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC3D281218
	for <lists+linux-iio@lfdr.de>; Mon, 15 Apr 2024 12:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF566BB50;
	Mon, 15 Apr 2024 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="himGpr2m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C26996A;
	Mon, 15 Apr 2024 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183707; cv=none; b=RdU5foc/q0xJrLKc+WjHDs/eSNZr4NCHKdr4EIDvW2z5WnbhNnzMlQVTzHbrWGzKtZPT2zuNdtSiDxgdePYMI69iaF8fJ2UG+K/xwmDTPu5gVPGHauAmchWfuYtta2NYn/yKAyI/Zlp+PQ0VDtjvsGp13l55P3P9hzuUwmpxp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183707; c=relaxed/simple;
	bh=oxYZDNagqijYSZ+6DLoasunnbu0tHoD6v2B4bzlvYXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UN7Bwng6wjsMRRzZnP+QIE3MzpsKrmqfIXrNTL0g37Vimw/8c36GygXNVtjhHe+cVQvnSGUX82iM9FwI9d0ShNhcvaSj+bqHT/PIUyz50LTm5UAdqU1JpCtay6OpANJw03pC5kO7wx66jm26nBCkzG0wiM3gKLlPa1vtT3cSJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=himGpr2m; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56fffd131a8so907155a12.0;
        Mon, 15 Apr 2024 05:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713183704; x=1713788504; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oxYZDNagqijYSZ+6DLoasunnbu0tHoD6v2B4bzlvYXs=;
        b=himGpr2mJiiN6R2swqnfMlgZe8la/yxaxR3pdA4yy63XHh5v/fT/O7bU61imYvt4tE
         KmeyMQd3gWwQI95jjtiZ8vUoG0Xxlj9RYiPmRlpx2IPYjQrjxim8MUziOFoYU65PBt10
         HlSZOZgAXfumpSTgbmbOt08fkApFGX8jovPxdI/F9O/p4zgWRJSjTf9Z7pqWGy0YBJmK
         88CDhlweLsSDNk4Jqzk00zExZM3wMhUuXqS7r7xi/O9EPTeJXuW5b2xacI7+D7XLy5Go
         tuEZYPY1Hplz2uaQlCX4PVznL9KUTuXhxbX7YPCggekHpBEEHDMaBKUMWmgLYY6wFWnt
         G1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713183704; x=1713788504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxYZDNagqijYSZ+6DLoasunnbu0tHoD6v2B4bzlvYXs=;
        b=NkyE9V/RyHMo0BbfucyjgnLtAV/q1yupivWoivP1qmvdVn+CUEg6KklpPXmrMQ57Bw
         ZeemmuOOh4KlN0ObI/w51lHByyrx21HQU/YLRhLcBVJVFde8MsJ8g7Wg3kw12k68Nj1O
         txeJOhqSA3zHcKMhAe7I/eWg2Rh7X8mJCfRgMl1lJJwnjUBqbq7s0xM806JI2ayf2HTY
         Pt5WsYsmek8DdUSEb+5D8+1TwJJ0A+mw9Vu15pTTquC59De/lF1OdIgbm5PRTJLXlzTl
         Aj5iaCMRrixxOlFrYx9zVYtxO0oD3VJ11c1/54/dgu0e7066Uj/ee6V+guV6Ah9M6eEt
         Ih6A==
X-Forwarded-Encrypted: i=1; AJvYcCXqau8ZPoieljH57YsV2cQTYP7tosMXla6D9b2dMQiwkClH8IxL5rZZuk1ajnCn84Xoc1LF8eNshJwnPgmJNZqHVWCVmCC0FIGofw==
X-Gm-Message-State: AOJu0YxveXZvKMWxfaqCo4BEkeiKEz7mmOjP9FOhd70YMPUtYZ17FsxG
	6jtTMHtJPdGjy2+fdhJN+1EJgzpSWzh8Hj6480OIiS4CaHN/a/eo
X-Google-Smtp-Source: AGHT+IEgcTU9buC9ZFMTo9J2N4MSJ0vNvU0XHEQatZvPGf4xKJvbEHW3LDYGecBSyTDncOHAULV7KA==
X-Received: by 2002:a50:d49c:0:b0:56c:1735:57a2 with SMTP id s28-20020a50d49c000000b0056c173557a2mr8699108edi.31.1713183703885;
        Mon, 15 Apr 2024 05:21:43 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090624ca00b00a46a2779475sm5376827ejb.101.2024.04.15.05.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:21:43 -0700 (PDT)
Message-ID: <304de7549627332ebdda77cd0c00b327f7a7c188.camel@gmail.com>
Subject: Re: [PATCH v3 07/10] dt-bindings: iio: dac: add docs for AD9739A
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Dragos Bogdan
 <dragos.bogdan@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Date: Mon, 15 Apr 2024 14:25:17 +0200
In-Reply-To: <CAMknhBHZRfvNtkbpWbi7tTXYa_rgRk+Q4z5MOd0O61FeEqBQnQ@mail.gmail.com>
References: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
	 <20240412-iio-backend-axi-dac-v3-7-3e9d4c5201fb@analog.com>
	 <CAMknhBHZRfvNtkbpWbi7tTXYa_rgRk+Q4z5MOd0O61FeEqBQnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-12 at 18:47 -0500, David Lechner wrote:
> On Fri, Apr 12, 2024 at 8:36=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
>=20
> ...
>=20
> > +=C2=A0 adi,full-scale-microamp:
> > +=C2=A0=C2=A0=C2=A0 description: This property represents the DAC full =
scale current.
>=20
> The description could be improved by saying what determines the value
> that need to be entered here. (Also wondering if this is not something
> that should be set at runtime using the _scale attribute instead.)
>=20

Hmm, not sure what you mean here? For anyone using a device like this, it s=
hould
be clear what this is about :)

> > +=C2=A0=C2=A0=C2=A0 minimum: 8700
> > +=C2=A0=C2=A0=C2=A0 maximum: 31700
>=20
> Missing a default value since this is not a required property?
>=20

Hmm, yes. That could definitely be added.

- Nuno S=C3=A1
>=20

