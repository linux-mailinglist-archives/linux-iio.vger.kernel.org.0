Return-Path: <linux-iio+bounces-25100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B111ABDF227
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70B248032D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047B26E6FA;
	Wed, 15 Oct 2025 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVBg0GvA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221D72622
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539360; cv=none; b=XRjZYoFjkN8uQ8PJGZy8HWhUY2UvACy8YCEsO3NS0/Bx7Lgh9TAzZwIdijcylvVjwDrIe54ol9bylyzzAHDTfCloxPyBuMK8Gr5m9i4piJn5+A8HUwZb3fs8VFZs6ViL7iJjE8lFCqV93ez+1PtsbS3qgsMPvA7bOOPwHT7IYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539360; c=relaxed/simple;
	bh=R+RZb2wy9J/5TGQx2voNXnYWcNOyJFa/k1JK4V1Ksu0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Idt7C+O+EC8dxcEkFfDbLMEaXi8+jDOlZpjuHVzJUBxkJ4xh0ZadgPs6bXoO87hfa/fHv5drX0CVmHv9j92mC/PDu8KGe5HRCGmSj6OY8Zvc3FcWlYEqjj247xbZJ2N0YzA6s2tnrBNLugGzcHOjt+Ob9cNEV042PFFQJ0PaWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVBg0GvA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so76350155e9.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539357; x=1761144157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R+RZb2wy9J/5TGQx2voNXnYWcNOyJFa/k1JK4V1Ksu0=;
        b=OVBg0GvAufKKjNANUbPU5qdauq//nlD1dAnPvRbSrz1Y+ZAzUffczf9Fl+wyN38cVd
         oG5p9V3F+peXwaVdCXWIzQ30OIPb1VUNXEu603Y/y+yNgjpkyVNpbJiwEyzNRUt+fjpx
         qF2ljfIHtO88eJPUA71dC4M2IlYOEgv3UsvhBcE7PEwBqzfgEGGCKemaXkXgv5G0nh4Q
         wNrHJXERsx/4hnsa3YqRLSE1hk1Ym+bW7Qmiw6EJXgTdhylm/OBypaXRxPSTd05AI0XY
         d4+URkVSMsjg58G2XIfodrUd3hDUT+d211gsmcjXg1y2LLY0aLcy8yPP8lwvIeWVF7E6
         xcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539357; x=1761144157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+RZb2wy9J/5TGQx2voNXnYWcNOyJFa/k1JK4V1Ksu0=;
        b=uBsbGuEofGmdZ82Wt2/40R3Zmplu4Fgrn+WTJOFicCT+xbh7SVp7F9MWqw2Vt1/AW3
         rkvRHRJFUWZPhIwbWI3rXsDe2aEXzsFeG3/+zEf1e3jUJNEoWkN2yGpR1uH6Jinx3A4j
         ZxLPbCNmfty6vpF/X4uf6ycqb2ym0/pxTUu1+bwYHGLcs/3yizQ677lJMO7Y+gUbfrpn
         hs/fuP9bU5Zw5uLR0VYHbT0WiklZ9yRoK9HzJ7S1095RDQy9Ecnin1ULA2vZvcgDZwUX
         pfgwCFW07VLG++qy9OdTHdFNNHNIPdGFenzQy4rkJ/8t+7gAkUMwS3eVfCA1wSMxv8Ei
         a2hg==
X-Forwarded-Encrypted: i=1; AJvYcCV8VezYbDStqdweFK6I4nZVhmmqP7EFFGlhLiUW+/6LDWKVt3o8eYqCR6zTdEoAtHJwQiaxkN5v24A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIG6mKFsmUB/xpRQUPBYu2l2YZ6KEK4HdHqyW9XxxGjgSDPcrg
	znMi1+QVPazTqd5f4fHK3up08ePUPzdUqwtNXZPRJjJf5WGlQhGboaYl
X-Gm-Gg: ASbGncty8PQq/+aBcZ5OshzHdjoGKepQ644BR/a5DBJIF72/ij4gJj3igvi6FNUruFj
	wpKAVLM1AD2KZbOLtzwPdua91BPsGdeWSFZsZlDWbUcFj5Xbn8k8wvLuPISmkfVZlUhM+yq2wcE
	cOK49BZDyRHoMyntrUjnGG6fO7vDv0cYTCQpC0YNa8fkOKvHieFB74qWCBCYd7kTUna1QodqTFG
	tSM6Kz4OdNsei3s//qRw5MUtLhEo0LWq+adWHswxt50JUZsy+2E01LTSX4axhvWs5HR9sFgWs+a
	PO6eLnNMJjlrkIhoVTC3KipANMSXbNuLQZgTlGQRbyEwUoBFtER3QTzSsi9W5ruUSolslrHDgvx
	sNq60HDZssvoIPkTK1yonj3Rc7s9X7Jv5l3BSRouKP2MyznnAQFV5EEyETWBn
X-Google-Smtp-Source: AGHT+IGuuKDzjH39vAEfmkO3f4qqciGa4DQ7MRGXfSIWlyO+usok8I3WtHonwMRrUViH02U0toSKjQ==
X-Received: by 2002:a05:600c:1c23:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46fa9a892d7mr210880025e9.3.1760539357068;
        Wed, 15 Oct 2025 07:42:37 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489ac60sm309551655e9.16.2025.10.15.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:42:36 -0700 (PDT)
Message-ID: <12db0930458ceb596010655736b0a67a0ad0ae53.camel@gmail.com>
Subject: Re: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt	 <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,  Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Andy Shevchenko	 <andy@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, 	linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Wed, 15 Oct 2025 15:43:09 +0100
In-Reply-To: <409ad505-8846-443e-8d71-baca3c9aef21@sirena.org.uk>
References: 
	<20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
	 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
	 <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
	 <409ad505-8846-443e-8d71-baca3c9aef21@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 13:01 +0100, Mark Brown wrote:
> On Wed, Oct 15, 2025 at 11:16:01AM +0100, Nuno S=C3=A1 wrote:
> > On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
>=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 controller=C2=A0=C2=A0=C2=
=A0 < data bits <=C2=A0=C2=A0=C2=A0=C2=A0 peripheral
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----------=C2=A0=C2=A0 ---=
-------------=C2=A0=C2=A0 ----------
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SD=
I 0=C2=A0=C2=A0=C2=A0 0-0-0-1-0-0-0-1=C2=A0=C2=A0=C2=A0 SDO 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SD=
I 1=C2=A0=C2=A0=C2=A0 1-0-0-0-1-0-0-0=C2=A0=C2=A0=C2=A0 SDO 1
>=20
> > Out of curiosity, how does this work for devices like AD4030 where the =
same
> > word
> > is kind of interleaved between SDO lines? I guess it works the same (in
> > terms of
> > SW) and is up to some IP core (typically in the FPGA) to "re-assemble" =
the
> > word?
>=20
> So combined with the existing parallel SPI support?

Not sure if this is meant for me :). parallel SPI is for parallel memories =
and
the spi_device multi cs support stuff right? I tried to track it down but i=
t's
not clear if there are any users already upstream (qspi zynqmp and the nor
flashes). It looks like it's not in yet but not sure.

Anyways, IIUC, it seems we could indeed see the device I mentioned as a par=
allel
kind of thing as we have one bit per lane per sclk. However, the multi_cs
concept does not apply (so I think it would be misleading to try and hack i=
t
around with tweaking cs_index_mask and related APIs).

Given the current API, maybe it makes sense to add (in the future) a
SPI_MULTI_BUS_MODE_PARALLEL or David already intends to support it in the
current STRIPE mode and I'm misunderstanding.

- Nuno S=C3=A1

