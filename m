Return-Path: <linux-iio+bounces-6796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB29914443
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 10:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB7B283CDA
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 08:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA1849643;
	Mon, 24 Jun 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSwdhsVN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2EA1F93E;
	Mon, 24 Jun 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216572; cv=none; b=driZRgMSuJJSx+3Be1pdzOR+v01AztYUxl2dXSrMY1bKctWhlqjB/SZ7TGIldv7BiqUc+n1JlEH/h+UrOiDT56yNVyXg4kl4MP/vCdwGozyjGKU4xIMl063/g9RTqFcabekbMByHesBkfx9A+x+lD+saKyeaZrAD2W6YwVb0ViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216572; c=relaxed/simple;
	bh=NOhGw9rMrJpNkjxZpnWcF4vb9fMkV6OjsmbMKaXvgvk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vx3kBgsqYd/sCOmKdguCGqOCkiJdwRxr7RoLK5yt3q6r3i1laln/M/deu1HdajDJH4iVIopStaec3jBxHXQoDyYPvRSs3WrZKUY3HnuyxzUajN5bhdKjiJccGy9ifDjRkPqLZwiApDAPWtF26QqXC8vQCHFi40wiYPY4cghQ5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSwdhsVN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-363bbd51050so3040628f8f.0;
        Mon, 24 Jun 2024 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719216569; x=1719821369; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NOhGw9rMrJpNkjxZpnWcF4vb9fMkV6OjsmbMKaXvgvk=;
        b=OSwdhsVNd1DQKwGWNJMG/TsGEBIm/jsPujjB57AjjFx5K0yp93zF0mozMcCdMyT4Cj
         5THLIVmjHkm6zXVYSJ+RCRFevVC85wmCNcwSf870Rza5ib6EFMu6jPtkoxOTs62p4yLM
         rWxDfEI7ckkc02m5t2d/CN/wZnDW6zH7wAWG7waBGw8okMcKxJJ5BJ3dsYdj55HQ+r8y
         mN9zr8HufKCaCWas1SfPNgts+qceYuXv9uu3BGP/8VbMx/QPPQ0RwhwrfpchVqD2Yo46
         Q0yQ8BL5kgAaBveI1xQXMYEoAnRmcZG6BJ0sLfbmvzKXywKOK1YGQwAqf3IDV4r1gh+U
         yhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216569; x=1719821369;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOhGw9rMrJpNkjxZpnWcF4vb9fMkV6OjsmbMKaXvgvk=;
        b=gyuwNy/GSq75k19kMv51WYHrr4w1FQiWXOdn1cpIZIgnBjRCzocpyPh/rRRQ5XQwQG
         bFhfmQUtRh4zxIoQ5IgO9NSsfslGgBWLcCnNAKTnJGJuLE0p2CQD38Jmr5IczIHnau6/
         qbHF3o6uX3wnyM50UbL1r0oYDnwO3Au07Ktb1OcDyhLGZyPs3kPFw9gs/90HkRQVAl7x
         Ump3hkkGaVd+g3iaCafcGJIBdEm5gbpbHRzFNnS/3mOh4dVso4cvj+660BnaLtVI5fBL
         wVFqe26bpElKwy+mJob85SOs2DI0rzjpY2QVBYsPryqS6u2vrEoQOwn5BLTYMwS0pClg
         pj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWPlQGxmFAOSxA/gqrPFgj+KXHrTFtUNXNEwUJ3EmLwhm1PL5BqgN7Aiw8gPVearSQn2yQHppBh5Dl2rhdcV1x4FEjKQrAAbTikym+ZfYb6Jjm91yIrAFYLUQ6s+R4wNuBHZ6qYuJkiSRShES+nmJiA3S4b91iOHCFUeJ6tav9WrpLo8WjlM63d54aTQxXTbGtwPSkWqtmKjiFCCTG7A==
X-Gm-Message-State: AOJu0Yy6lh6eEWsrqYmgXSu8GBr9YWnWP5qhu/VOlwaLzmxsrLoTo+bj
	rE6R29RZ8QWMsA+8nGxO/81u8hGnKtQd8RM3Tnxd/97hypCxKpgP
X-Google-Smtp-Source: AGHT+IFsu4SA440qLS+OTNB2Kp/IDfKOew+1SLAqJbJX3Dq9uflpOsscaCxVGx6MDcd8J/58+fIhuA==
X-Received: by 2002:adf:f887:0:b0:361:dde2:87a0 with SMTP id ffacd0b85a97d-366e4f0cd03mr3249911f8f.65.1719216569219;
        Mon, 24 Jun 2024 01:09:29 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b8597sm9252800f8f.36.2024.06.24.01.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:09:28 -0700 (PDT)
Message-ID: <85c7b836721ad49125eebf7498d2d8a9cd15dd64.camel@gmail.com>
Subject: Re: [PATCH v6 2/2] iio: frequency: adf4350: add clk provider
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Mon, 24 Jun 2024 10:09:28 +0200
In-Reply-To: <20240622195018.587997ae@jic23-huawei>
References: <20240621121403.47912-1-antoniu.miclaus@analog.com>
	 <20240621121403.47912-2-antoniu.miclaus@analog.com>
	 <20240622195018.587997ae@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-22 at 19:50 +0100, Jonathan Cameron wrote:
> On Fri, 21 Jun 2024 15:13:59 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add clk provider feature for the adf4350.
> >=20
> > Even though the driver was sent as an IIO driver in most cases the
> > device is actually seen as a clock provider.
> >=20
> > This patch aims to cover actual usecases requested by users in order to
> > completely control the output frequencies from userspace.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> You addressed both of Nuno's comments and I didn't have anything to add,
> =C2=A0so I'll pick this up (can still add a tag though if Nuno wants to g=
ive one).
>=20

Please do.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



