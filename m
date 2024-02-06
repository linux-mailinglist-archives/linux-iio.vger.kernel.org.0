Return-Path: <linux-iio+bounces-2228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C969A84AFE9
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 09:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292D6B23C75
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 08:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE3C12B144;
	Tue,  6 Feb 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgTSch/2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF29212AAD9;
	Tue,  6 Feb 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207979; cv=none; b=pYBfRMa8/3iewqxiuDBDt3ztQlQj9XMB6ZlgnMRpBEoHz6+MMPwJ3AqTgh2PxlaAW/LW5soX1m50ZR/SSrKEXVMmhBIL8gv8ND9LvrQzs/t5tiCGpZssC9rRryk+Ig/b0RwhPdcBChjjhoPPGPUAcZL8W/W4YVr+1zAdd7fpOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207979; c=relaxed/simple;
	bh=TfLjlqfgdGe0ODzWV6H6w+x3+TNAT6Y3WgTw8F4eEfk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRWtZ/IPPnWIRkrLvfGHeuIgmQdc2qVmV3yPeF0iVe8NC6QJckF1XKi5MUv6EZj1E+ahmqz9b6XDqgmYdy/Wh+rrgOpkOCuoc7Mhrg6BVYSQqtTjV7BM21lHnuOQB2RpczHtRccNOhlKF5PTNXEc3ZycQP+aGOGA6SIWvKoxk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgTSch/2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fe6c66c3fso1541075e9.2;
        Tue, 06 Feb 2024 00:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207976; x=1707812776; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TfLjlqfgdGe0ODzWV6H6w+x3+TNAT6Y3WgTw8F4eEfk=;
        b=FgTSch/2XViM+rFlD+Vl9eTNRVSydFKq53vGA0og5mwnABJxagyYq/WtL0yPROMnSk
         uimp5ck+CpmgWusYHOn/vtp6Qtoi7VbOgO5ho75YuGk7wxFRtMIW4z4ImQUpTghrt0ui
         CQjt8rHOww7RtWMYPxd4y8fRIpmQLBY1NJ9T5rI+aRW1gn1DFg6FUjfo0XdiLFLLKcYK
         VztsBzewbIam24Spe3RmdpVbvVK3RSpXZ297AKw28V8NgKNSZZy82KaM2KrdPRmVr3wM
         TYqVPLrxLAdYK2pjKVqYm4MA9PN/J7I5k0ob4Ee850ki6U+LYHKr0FOXCideoUD1yhs2
         +KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207976; x=1707812776;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfLjlqfgdGe0ODzWV6H6w+x3+TNAT6Y3WgTw8F4eEfk=;
        b=iddceIn8YHtx4+mV/DTOoIVCfyROCrX+bLxn0vuk4XHdpNAg8kFzS/H7shrSVIfQEh
         4c5mKhCs6LHKIE5geDLKB+DXfjaKpiVcQhzMMEVr2yYs3fvqElCCIhypqcm6HL8I/A4t
         gAx59H2uqXnok3BXkDWnzn79Uo0r1uKbJRPtC8gd0jLm54xSE8OL2EEgDenh5Hyi+Rcb
         Q6Z62s2rcudfDNtfDfRPF/jhm3ZqLz51C0T/hOzRGPnUJodCMV0CSvNrvwvgpPpygAfM
         faSOXS7Lx5l919VoEWsRVGVrXkRXtR1QUpaL4STO7i1zJJplfnKKLFUjKVWDOfsptRpj
         m7kA==
X-Gm-Message-State: AOJu0Yz/TpJU6KdKRxTkzH+HmZuCUcX2m9PudeXkaxJ531eKPmf/TX2b
	03oNCfEMRfjkYhnMC9xUBNLfX1/icEkx0kGloWw6RX5dX7/b0u/V
X-Google-Smtp-Source: AGHT+IHhmx51Jf5d0+sPv+lWgq5kZ+fp7Z/a3V1Og91xYR8BREBtCnJ5IP6HLFR7pb2mDeKA4BqvFA==
X-Received: by 2002:a05:600c:1ca5:b0:40e:6922:7960 with SMTP id k37-20020a05600c1ca500b0040e69227960mr973106wms.29.1707207975765;
        Tue, 06 Feb 2024 00:26:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzXxFYJk5zebrhqmb3PYCN7nHYWVV27VfzBaqtpF87gTyoF9c1gXIQpjHFG+njTWqikGtwuqb1XOiyYjQpBLl3rspeSmSS4BbwceHpwWrrR8SBgJe8lRDuFLZ7TVrQnRqNPheo+D+ZlwMwqHdis0x9FVIqpZukxIbT/US6pV7JpI0ApSmYuh2SmngorInOlQa2vtCXIBX0LRsIrz1qc/CRL38QAE2Nxab9fbDvIQY5BeB43eaBggI65WmBfZpvxXFSbUCnzmO51+n1yWH5zJCY+jIDU/X0F6SrxqntumGAEDHUSlM67njjw2M0QJKi2Rrx3zA8zbscXJ+58NaNNkJDff5cf9yPOQl5CB3sqcSIdUEuD3DT96KhL8a3OEeQwA==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b0040fdd7cbc8dsm1156674wmq.47.2024.02.06.00.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 00:26:15 -0800 (PST)
Message-ID: <3f2659154d7fc01e96f0a7bc4297fbfcfa626d36.camel@gmail.com>
Subject: Re: [PATCH v8 5/7] iio: add the IIO backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: andy.shevchenko@gmail.com, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Tue, 06 Feb 2024 09:26:14 +0100
In-Reply-To: <50e29a95f5a620179f19056fd7948da5e093d980.camel@gmail.com>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
	 <20240202-iio-backend-v8-5-f65ee8c8203d@analog.com>
	 <Zb-yr0u_a9-vE86t@surfacebook.localdomain>
	 <50e29a95f5a620179f19056fd7948da5e093d980.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 11:02 +0100, Nuno S=C3=A1 wrote:
> On Sun, 2024-02-04 at 17:52 +0200, andy.shevchenko@gmail.com=C2=A0wrote:
> > Fri, Feb 02, 2024 at 04:08:36PM +0100, Nuno Sa kirjoitti:
> > > This is a Framework to handle complex IIO aggregate devices.
> > >=20
> > > The typical architecture is to have one device as the frontend device=
 which
> > > can be "linked" against one or multiple backend devices. All the IIO =
and
> > > userspace interface is expected to be registers/managed by the fronte=
nd
> > > device which will callback into the backends when needed (to get/set
> > > some configuration that it does not directly control).
> > >=20
> > > The basic framework interface is pretty simple:
> > > =C2=A0- Backends should register themselves with @devm_iio_backend_re=
gister()
> > > =C2=A0- Frontend devices should get backends with @devm_iio_backend_g=
et()
> >=20
> > ...
> >=20
> > > + * Copyright (C) 2023 Analog Devices Inc.
> >=20
> > 2024 as well?
> >=20
> > ...
> >=20
> > > +#include <linux/cleanup.h>
> > > +#include <linux/device.h>
> > > +#include <linux/err.h>
> > > +#include <linux/list.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/property.h>
> > > +#include <linux/slab.h>
> >=20
> > Missing types.h and maybe more. (E.g., IIRC linux/err.h doesn't cover
> > linux/errno.h for Linux internal error codes, >=3D 512.)
>=20
> Just sanity checking... EOPNOTSUPP is define in [1] but I don't really th=
ink we
> should be including that directly (don't see anyone doing it at least)? I=
 guess I
> should include <linux/errno.h>, right?
>=20
> [1]:
> https://elixir.bootlin.com/linux/v5.0.21/source/include/uapi/asm-generic/=
errno.h#L78
>=20

Forget about this (dumb question). Already saw in your review what I should=
 be
including...


- Nuno S=C3=A1=20

