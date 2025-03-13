Return-Path: <linux-iio+bounces-16805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C5BA602F9
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 21:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4B63B329B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 20:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE061F4623;
	Thu, 13 Mar 2025 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU8guPI0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7BA145A11;
	Thu, 13 Mar 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898920; cv=none; b=BgctLDVc9gqQUwweKYm4tFQh9og3fEgd1eNkRYw3zIKxQMNCr6xOfaW2bbua2GC3lMqL1tYmq8S2Rn/7xJq0Fbjkc6vn3Gcbg+y6VMMhs8IWeU+ua3OMSBE5QIMdU1AQyOhuIMMbm1UB7Xk3fAgUp9QJkwpmeCzs2BanSEloau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898920; c=relaxed/simple;
	bh=bzPYKY3lsPVchaKR3bQgaTpUlj8CbHB37ry0Wjb/REM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTOiNzdtaQ1waJ6z8cCSdtLcc7jRM7gIbVlW6zwAolhNHsfKQFU7okOiN7A1Tg0BDlpVAlwuxO5pkej077Kqc1Xl3sCSYzpfl0JjxIoZLQYw3Ioyns6TyF+m5GayA4dWgcePe9Pu3kwjgWCpK6kROMLJ7OjfY+BPG8DIEyRslxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU8guPI0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so13098315e9.2;
        Thu, 13 Mar 2025 13:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741898916; x=1742503716; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3M+KzacL88R9fEWhVfWkksQHP3+7Qg3oqYjBVfhgIw0=;
        b=XU8guPI0JYkUsnTWZGJIOtGbjWQxSO1kWrt5LJscInfjxsMAw7e9FNLDQs3mxm1jF6
         rg0VLi2kUNUQiZY6jR36WPHCvdLped1SzC57DvgCuGHjE5lkaoFYL2lcPC8oey3FD8b/
         yEwgJjnzGQZnjLawKN+PmJHBE3qOOUgxDvCKQtDY5Jdpje6v3SVPl0lB3IOp7YnK6JhS
         4qxtEMUf7HsqKUe9mvWrvO6PNPY1/ejdqDKekwZn2ZFEXykYAxzyTkh3l93/2GfXTRsY
         Iaw3aX0Be5OcjCTdIl8Xl7vrnxt2gIKwQNX2cm9Wb4+XWxn1pkZ86/mlCz2kFmC0V4Y/
         nUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741898916; x=1742503716;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3M+KzacL88R9fEWhVfWkksQHP3+7Qg3oqYjBVfhgIw0=;
        b=v82UTgqVGuW62l0zlcjm3f1jorV/iDvHYRzpvpXWXGZ2rcd+ifbV2osh5cX+6c54ZK
         f+JL/guTFIh7kLPxEBOn/5gqIWFqzmTM2lE7nR9iWv+iQs3vzBV7cYI+5+LnWI+EvapF
         j2jUls/8VheY4HiLGLFtFQREOBXqMu4SdhU76ZADbXKJmM2ii4+2c7inLXhv+qZP+87C
         KpSY/Kjviim/QYy4581qCEEHSwQAuwoUS6Wjp89KECteDnVScgNS/roCZ9nA6PiHprb5
         68NR6VLVr+toaICdLTnDgZPaIkW8XIUciQGmf8bpCxYlYeo40+IUgQW9UBycO4FAY9FQ
         hCIg==
X-Forwarded-Encrypted: i=1; AJvYcCUbigMkI4LNN+l4+RlqK4q2n4cSTgOGF6PXKyS6bbxYPxT7Wq46FRpTpR0JoQ8mVL+h+6NaRm+taSM=@vger.kernel.org, AJvYcCV8zUVq4PGRY2IvippysM0X8MP5chTqsBNEUk4rhTnMV0cmLZv32YZe8TVEynRBGCwAFsBl1MpWiXDGJwbo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09z3vBEaiRQUuIzAckYFDo3IM7+j2U/ZhpOcFYf0hPew9HM4b
	RrqsTAODsB3g5xBoeHHN27fx1JUhSMrOiXk2fsDdKr7HabqF9Yx6
X-Gm-Gg: ASbGncumXBOOslC1P2y545niZvyriCGnjXqrAi17rIvoQw71cLMJ4aurSIONA1DEMrU
	Ct641gxN0kYdJrReMNDZf/JFAC6qKGaQUH3Cj+nidd+7adP5LSawp96nvYUokzOArDBzZktDYzn
	fCbzdOCtTBPqEAAvXfILqp3D6wFBM2CafXghT861EC0Vij8XwirUfwJqnBG5seFq5fMPhUABLFT
	SFBL2WhCQGK3HOKmModazT19vaA4TXrDOHGdKA3kjfjdNaRe4qaENK8AP5M37+aBlhDXJQ7oEsu
	6xrxBoFBUO8Nohqj4vxX0bBDQI+u8bZeo0tLwIhN/zV53vsBsFu5yA5OEVazFU4oLK6q9i/BYnd
	TEycasfssd9x79pqG6VE=
X-Google-Smtp-Source: AGHT+IG+XIjsbTUFYLzcvMmKBT0mslsJ4ZGWPf1npQg3tcOd3geNpnyYN8S19XPzvQ4Ty4pJ4BGwAA==
X-Received: by 2002:a5d:59a3:0:b0:391:38a5:efa with SMTP id ffacd0b85a97d-396c2010f8emr951103f8f.23.1741898916296;
        Thu, 13 Mar 2025 13:48:36 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df339asm3224343f8f.3.2025.03.13.13.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:48:35 -0700 (PDT)
Message-ID: <96b2920f2bfd4ac44de73f3f940eb66913996952.camel@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: amplifiers: hmc425a: Remove not fully
 correct comment
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner
	 <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Date: Thu, 13 Mar 2025 20:48:51 +0000
In-Reply-To: <20250313162254.416422-1-andriy.shevchenko@linux.intel.com>
References: <20250313162254.416422-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-13 at 18:22 +0200, Andy Shevchenko wrote:
> The OF match table can be used outside of OF-based platforms.
> Remove the (misleading) comment.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/amplifiers/hmc425a.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hm=
c425a.c
> index d9a359e1388a..e92d7f399e33 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -398,7 +398,6 @@ static int hmc425a_probe(struct platform_device *pdev=
)
> =C2=A0	return devm_iio_device_register(&pdev->dev, indio_dev);
> =C2=A0}
> =C2=A0
> -/* Match table for of_platform binding */
> =C2=A0static const struct of_device_id hmc425a_of_match[] =3D {
> =C2=A0	{ .compatible =3D "adi,hmc425a",
> =C2=A0	=C2=A0 .data =3D &hmc425a_chip_info_tbl[ID_HMC425A]},


