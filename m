Return-Path: <linux-iio+bounces-22600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF152B2156F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 21:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18084636E3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0027D296BC3;
	Mon, 11 Aug 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtR4gT6T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4EE26ACB
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941163; cv=none; b=bHxHqrK2AMuuNScUw7aBz5BbvVzr1arFgfsJAdaA39QTms/RKXn/1g2kJDdCmg4ffB1L9Qi5dJdu06EVavx8Ol1emFfrNjtUDiy0xXXb6s/qVsV9n4I/wuIwzk2JqquV5Q8RI9nrmDcXMrDePyaxGYQdIJFweaNs8xshfYTKZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941163; c=relaxed/simple;
	bh=BcRaQQD7FR9mqWcjcRucDGNaLzKHEeuxuXpAt6Hw7AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFDRcFyIMRl0XnZqm1aEAh+CN3HigO4A5fFoKfMaGQ8azv3zsSV0uOw/JOhUY2e4/Y3vOoxYpBGEGeiwLO8mI+EQdUw5JmQEQSUllzT5OHRvsJUMe9KCZD5viS1jcBdaWmJ7WeODTDhA/U2MFAM23VYdOhcllA/hr9brMHXG2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtR4gT6T; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af97c0290dcso833653966b.0
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754941160; x=1755545960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcRaQQD7FR9mqWcjcRucDGNaLzKHEeuxuXpAt6Hw7AI=;
        b=MtR4gT6TXaKJdX2AkxsBQnIbYiXksrZA4qfkZsdvkSm/0atlp3wd7nBn06+CFOWpV3
         NhQIDmWGP2tHvdK3BojYlSDgjnKcUUL13WeLWaHTrQmM4BXsdV21f+Zg0AS2ygFUX55n
         aE8ZtVeLhVqLkXMtP+dD2Yjgscmq3X3BwUHReM77XhutGL7ydm1HxgkzNlVzAkNyO2U7
         UNxvdn/RrDiozJpNHZW7kz/XSraQCK3t1Fr1une1Quonv3OWgT7O2PCD+Y3Bx8bRSch3
         QUwm7HqcLlirTPj1i0DOsqf2vJ0QO36plxgGunydTrR556LDgvmQL64wZU4Cva/GWR2y
         N8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754941160; x=1755545960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcRaQQD7FR9mqWcjcRucDGNaLzKHEeuxuXpAt6Hw7AI=;
        b=v9+Sfm9mL7evwssoX/DZhOtrMVjzQGbQM6h+TlftabDxYriWD2WNifA+LgtZYqyl70
         geOnWgLbCJLEdNyT2+jE6Uu/mSetHGqs1CGknowJqNO72mu3CR5YBNohmo+pIaD+wdxo
         ic+4Gfu558o3/oZI5fL9srUOF+0b0TieSJY9W5eCZodUI0C3jOae8GpCkxmi3B7EwJhv
         noabC44h+j3gaIaZWYBmc4WBvHCskrlsJMi9d2PlpsbDafgiEwWJIMJXD240e/SHo2Ih
         gCOAmie9rK2Ge42fUDl3l5wo6N8Nk8Rk/Gmeyi/lAEIcKp+4b5aiRupRyQSH7ZK01g6B
         ta4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7EVq046Q6hZl0WYv+i3vFPmyqhiVrAvmi93+h/Pq/SWsWDU50i3DSDW4i+YHyRTQCAgLVFj7Bd6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTUY5+dI9wJoE8NkBOadDC5QrjGdxDYblfw7cC3r8TmvzBuJH
	ETKbzB63vyQq9zvTehCc1C9Ezo2VLxRY8/SD4cX+n2RQiNd5sF2r9zTPuePY3ik3l0tXsFMan+0
	xLJSzK06yBIkm6aVNNFFOl42EwYxsU/E=
X-Gm-Gg: ASbGnct2kKuWcr/VM8NclobmRiG8Q/2iQBa3VzknaB3HKnmllCKpym0TntpGPLdNgad
	cDLIri0A7golPj1wHkhg3AbPJJJMRFrG9yurxJ1ckC++bP79hgH4kBhhc3bj4XEi3Q3og4X/286
	QLD4ftm+IVWB6iSjkbW87SFEDPcsnbikVewvIIPUH2rSn6EP6irPTKUGjnbPurNOkt6VC/a55mP
	oDks0wOexjQR4skf5ui
X-Google-Smtp-Source: AGHT+IHBanEwimJY/IPrH6yo3II7ntFsYP3Y0nLq1Er/yLI4Zbm3ybPIb5504nty4LQ56j8Hv/AW82V0p5hidRDB94I=
X-Received: by 2002:a17:906:fe49:b0:af9:69d1:9c6d with SMTP id
 a640c23a62f3a-afa1e127cf7mr59571166b.40.1754941160376; Mon, 11 Aug 2025
 12:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811155453.31525-1-hansg@kernel.org> <20250811155453.31525-6-hansg@kernel.org>
In-Reply-To: <20250811155453.31525-6-hansg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 21:38:43 +0200
X-Gm-Features: Ac12FXwXlu0UM36qPyWxu67VOoi_u9A-snqUdd7xcFBB32hX1Fs4L7UKdQFJXSk
Message-ID: <CAHp75VfQyKJpDn4ovmSL-1uD+cXUAmW9ZsGj3DDjrQ5afjhE_Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] iio: test: Add kunit tests for iio_multiply_value()
To: Hans de Goede <hansg@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Matteo Martelli <matteomartelli3@gmail.com>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:55=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Add kunit tests for iio_multiply_value().

KUnit

...

> +#include <kunit/test.h>

I believe we still need header inclusions to what we are using outside
of the KUnit and IIO consumer scopes, such as types.h, math64.h.

> +#include <linux/iio/consumer.h>

--=20
With Best Regards,
Andy Shevchenko

