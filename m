Return-Path: <linux-iio+bounces-2186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B19849752
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 11:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D69BB2A02F
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 10:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3A14002;
	Mon,  5 Feb 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaNrco/V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960829455;
	Mon,  5 Feb 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127345; cv=none; b=gqdMbI/maj6BJi5mFPPg18zPWUVxG7Yg+0ypVa6hIFeKrCaG2+E4/lU/xYMwY6+ox1MsIP7QqaqeQ6syYPuBn+ff3A0ulwGjhaTxneERYVkhFYlfOPBi18KUwPqHtxmqRowq1rVw/mLTQxdLKVr1WIRzhdHcAsqLAeg2vwqNI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127345; c=relaxed/simple;
	bh=IsHe1eXNyLbiL9eOw49HOBHN7tXZzpCngzNkOFT5Xq4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2tEh//aWmC+45SppdAn/hzgd6k7orZ41OtJUuG8sTlBw3hJN8zNkqFDjO9c680D94+3/IYICah0dIK52gUA7sjv8ILXeObreXyKEWR5/CRiBhFY6hOaKtpHNpsCvEPpHGWeDUbvNopBxZkk+Zz8qUigc33fs5Hc1JNi0Zt8knI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaNrco/V; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fdd65a9cfso3042185e9.3;
        Mon, 05 Feb 2024 02:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707127342; x=1707732142; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IsHe1eXNyLbiL9eOw49HOBHN7tXZzpCngzNkOFT5Xq4=;
        b=FaNrco/VwIEIQMPbsg9zc05MDCVqwQjXw83V47Pp34Hm/nLjAYo0EBxE6bR8NBY1ex
         MU/PeYow9hBSTfsDnA57j1Fqpnf+cKjlNBrA7Cd6CVqg9wysVz2PqGcQ+/bf4qYtkBOD
         nz96LhT8hIMydLDdbT1Xx2XoHiymDtg85XHm7yEw40egbNvWfIzoh4pLwVm0c1Q6AG9R
         NVYpMfliMg1OB4UuohWeKGF4sviI1giSVOriA0GgCcmUuqk9hlvhHd6Xw3OAtXx2XEPk
         foDQ1p8XtVuW+8liUDB4h73/9V1WBzrWTGHkuVEOFb7CmbMRcKcqD5ji5QNklAI/lM9P
         8KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127342; x=1707732142;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsHe1eXNyLbiL9eOw49HOBHN7tXZzpCngzNkOFT5Xq4=;
        b=wShcNwHLDVOjPAw8YydgIpwKZcM5aNRxLKJhhgmWstp3auPNCrcIkju8DhSByMUdEc
         pSViiasMJ7P91ZDIb4RTQEj4JM5nNZTQieNOUQkJDWA8wtpS8lntPo/PofkEs5l2YvYL
         vxm4Mwa4+dvHM9HufC3624D3o+gRA/aPzThDXPXjCyNXTTLFfjkCIhMOXMUGIG6dmCGL
         wRTnzQCGXtRtoD8kFSnZbQVS0PWBANA1ETLBWzQyXc0yk2g8aVZfy4PFDxXuDqMA68pe
         dv/ql5zbYrzWYKExEULHbsZBnoh5NaIA4gIz9qpK1V3H61D3Tjhbd5GriTf3fcRnIB2j
         f5cQ==
X-Gm-Message-State: AOJu0Yx2QPZv+UUTWCjUXPeRaZKM5Dl/T9IPlK6dH1zyJJASbDRzjOvc
	4ufFmBOeoJUgbDGlr58NSbKF9Rb3mQ9ZyjY58CEGMElvkAM5dHYO
X-Google-Smtp-Source: AGHT+IEHp+ogu5TfZMdotux+9McGowVxpFpNHYMI+P1V4lMQ2DSRJ11+/0oza0XPsb4Hq68RV3AWdQ==
X-Received: by 2002:a05:600c:4508:b0:40f:ddac:86f8 with SMTP id t8-20020a05600c450800b0040fddac86f8mr635624wmo.35.1707127341616;
        Mon, 05 Feb 2024 02:02:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXkVhkTH8oGp9wNxhOGJSNsnWyy1WhYJxdlF804eFTr5vLmMYkL4hSmfV5IXk0sqSgDx5O4ILHi0HD0IZkr6QmAujBwsUeCUrQn9+Xi9mpQl2M5hgeM8rkLBObboV7nUoqDPBQ1wH4h/HFZETlpYb4BQ0NPbUFUgLYRr886NoCn649YnkNW1+2DnV3b25EWvww73mVRaP0OIJtPLWKz6wbT8xzoZFVUfpLYgMmsLyXqx0DqrtW8msHy6EjqNSuzcEHctx+KoXiSLMsi0tHBc6bzUJQf7saQcLgebAiREF/V2Tze2QoVyBZJ8lI+skub/WFpL5bp4AWnSv9OBpNkc8tNYuWO8nlrnCjCDk8S9RrW9N/6S/Y5g9LB5O1SXs0rWA==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b0040f035bebfcsm8066127wmq.12.2024.02.05.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:02:21 -0800 (PST)
Message-ID: <50e29a95f5a620179f19056fd7948da5e093d980.camel@gmail.com>
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
Date: Mon, 05 Feb 2024 11:02:20 +0100
In-Reply-To: <Zb-yr0u_a9-vE86t@surfacebook.localdomain>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
	 <20240202-iio-backend-v8-5-f65ee8c8203d@analog.com>
	 <Zb-yr0u_a9-vE86t@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-04 at 17:52 +0200, andy.shevchenko@gmail.com wrote:
> Fri, Feb 02, 2024 at 04:08:36PM +0100, Nuno Sa kirjoitti:
> > This is a Framework to handle complex IIO aggregate devices.
> >=20
> > The typical architecture is to have one device as the frontend device w=
hich
> > can be "linked" against one or multiple backend devices. All the IIO an=
d
> > userspace interface is expected to be registers/managed by the frontend
> > device which will callback into the backends when needed (to get/set
> > some configuration that it does not directly control).
> >=20
> > The basic framework interface is pretty simple:
> > =C2=A0- Backends should register themselves with @devm_iio_backend_regi=
ster()
> > =C2=A0- Frontend devices should get backends with @devm_iio_backend_get=
()
>=20
> ...
>=20
> > + * Copyright (C) 2023 Analog Devices Inc.
>=20
> 2024 as well?
>=20
> ...
>=20
> > +#include <linux/cleanup.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/property.h>
> > +#include <linux/slab.h>
>=20
> Missing types.h and maybe more. (E.g., IIRC linux/err.h doesn't cover
> linux/errno.h for Linux internal error codes, >=3D 512.)

Just sanity checking... EOPNOTSUPP is define in [1] but I don't really thin=
k we
should be including that directly (don't see anyone doing it at least)? I g=
uess I
should include <linux/errno.h>, right?

[1]: https://elixir.bootlin.com/linux/v5.0.21/source/include/uapi/asm-gener=
ic/errno.h#L78


- Nuno S=C3=A1

