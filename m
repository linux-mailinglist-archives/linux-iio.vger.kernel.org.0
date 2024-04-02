Return-Path: <linux-iio+bounces-3995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A01E894CDF
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 09:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC54B22566
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C846D3D0B3;
	Tue,  2 Apr 2024 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df5Ob1H/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BC3C478;
	Tue,  2 Apr 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044167; cv=none; b=iFqgBtV0yiyHtyIV5d9KPxSzHe1AlTi+06PIyhAaoYuKudtGzeSus3xJvi4xn7sg6WO85fiom3SrX8OBxuHVk75DcH0rFHUpOwHrIsv44ApJTdakfZq/rD61yeoNipFBotl+3XBqSyRfxZDc8j9gdxsnFBXwnB5Tt8tyE3ict8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044167; c=relaxed/simple;
	bh=jJzO7uT7o+qRmZhE7mm42bbXoswjbM/tjdkD5FdM7aQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jr0GlX9Yo77MyGYzmFh8wWXFMrjBDi1Ln72qIMihkZC34M8zL4UraKQkkqKL1YPhBh355LK+M70jCMTdd+bSIt4kLMYBnWWeQPgzCFSO7MiJfSKIIEx/yKLrFsOw7A0W1qY1kNoWoPTcYgC0Zc3zPwWB632zoqrK7rpMMXQ29uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df5Ob1H/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso63754061fa.2;
        Tue, 02 Apr 2024 00:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712044164; x=1712648964; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jJzO7uT7o+qRmZhE7mm42bbXoswjbM/tjdkD5FdM7aQ=;
        b=Df5Ob1H/sin6mlAhqSjJahtAEogw4/5J0LNaoGYwSCFblIZmrQ2QrIflEB/86VW1LO
         3+gyLLe6FPxUWOuZ7XfFKpXWxB1MHgfEShpd5iH37Z73vn6I3MgtxPaoAU2YDqrLZfjp
         d/+qj03IFvr0UVNMj2reTANQEerQ4bFHJh8Lm8eiZVczpgcI36oeHDdhynAYj6pnm1pt
         jqlz1dfgwQDk+iP238NoR8YutjgwRUEBynMn8eAiW//X777tJ3fSLtl80hrY0OXxkrMx
         7c8TDnY+ssyKTO0c1hB7FZUNME1uXffL1ttR9tFGqD422N2PntSTuwTCWiTr7o6dP+AT
         j0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712044164; x=1712648964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJzO7uT7o+qRmZhE7mm42bbXoswjbM/tjdkD5FdM7aQ=;
        b=FMUUqcKEfkygLfR/9PEq88PlFJQKB7APIJjbyBnU1AmfpH8IpZA/QGCgXJlBnw4trI
         h0uDc2QZPDfq0GffyLaH+L45PGlvXRWqxFkB/b1KGCHiZ2WI9ATrb33AouIpdW7s4Ng7
         JVjBBxqZR2iHT6V9wNIun9hAzi3PiTa4ambav7zoMUIIN8NbNKlIG+2VMj1ENLoku6hw
         B3ZddtSwyRRl2I+B5Hd+n1Nb0jLuIckTW9blBCzzHcpUJ9tQv9C8vIL8oJPCyXwSTaqO
         wdi/fUc0kbDGWZ6fwdfTs136HM99IGrylJscymjaKQIEZ9RgBSEdnUAG1kvAZIhWTyAc
         GjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj5RzUWTJwu16V/0TXK6UiC7vrMniBCpE9dz+6kNdzDfqoHoPL4d8Ma1Iotpb1uEr1XR6WHWImvB1/te4Glj4/zZ7Ep9UwGvK4mQ==
X-Gm-Message-State: AOJu0Yz3RyyYgL9BGKNnPVQK1Tf1MY6wJjeQne3xoBuUCMmUtagWiIiU
	DEpStjMjuquPw6bo1DKo2+FEWeRms/FU32Kh14Rh4ACja+1b7Bfc
X-Google-Smtp-Source: AGHT+IFaU/U+A03CTgpdn9xqN3dtLJx+Qt/LLPcKF34nTM9u/3YRMKCE8R/qp/MLOPljrC1WVctmHg==
X-Received: by 2002:a2e:9d42:0:b0:2d4:54f2:c409 with SMTP id y2-20020a2e9d42000000b002d454f2c409mr6583663ljj.38.1712044163687;
        Tue, 02 Apr 2024 00:49:23 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041477f3f99fsm20086153wmo.30.2024.04.02.00.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:49:23 -0700 (PDT)
Message-ID: <cd7b5041bbf0dbd75038a03afe2f36cce9e84955.camel@gmail.com>
Subject: Re: [PATCH 07/10] dt-bindings: iio: dac: add bindings doc for
 AD9739A
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, David Lechner
	 <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Dragos Bogdan
 <dragos.bogdan@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Tue, 02 Apr 2024 09:49:22 +0200
In-Reply-To: <3d876e90-4821-4c00-b880-6966b53c70a7@linaro.org>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	 <20240328-iio-backend-axi-dac-v1-7-afc808b3fde3@analog.com>
	 <CAMknhBHA3LOhZicUCG32RyiV4+OROJymzm0Qc=wqhfo3u=8vnQ@mail.gmail.com>
	 <3d876e90-4821-4c00-b880-6966b53c70a7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-30 at 19:27 +0100, Krzysztof Kozlowski wrote:
> On 29/03/2024 20:06, David Lechner wrote:
> >=20
> > > +
> > > +=C2=A0 reset-gpios:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +
> > > +=C2=A0 vdd_3_3-supply:
> > > +=C2=A0=C2=A0=C2=A0 description: 3.3V Digital input supply.
> >=20
> > vdd33-supply would better match the datasheet name
>=20
> And would conform to coding style. No underscores in names.
>=20
> Nuno,
> To avoid comments like this one, please read and follow DTS coding style
> when you work with DTS or Devicetree bindings.
>=20

Noted...

Thanks!
- Nuno S=C3=A1

>=20


