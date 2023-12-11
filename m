Return-Path: <linux-iio+bounces-813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6028E80C4B4
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 10:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9079F1C20E41
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DAD2136C;
	Mon, 11 Dec 2023 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Beu1kFkc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38916B4;
	Mon, 11 Dec 2023 01:33:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3335397607dso4827105f8f.1;
        Mon, 11 Dec 2023 01:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702287186; x=1702891986; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iX9LTKD32QojhDmEQJfPhKZfMZUjvViAYKW+BQEUbUU=;
        b=Beu1kFkcezRNyZJRU9ioYrp2mEWR4b9j/wlSfm00ZtaNODHUWMd9AiCVFIMipuKZ23
         Rs1ygNXblqTh/Ir0pPvHVyRveru/muJHpMEUpiv5/WDR3t8JRz3vmt23LU1As5JCP+Cz
         PITyhk9AnQ1kgYEmtqmhL+n0LRqHpYB/+ULBxu6MObfTJj3dWcyeYEhEs+/WVTNc3BfQ
         9DeCFPF4NcND3ERbYw+VD9CeF4PwuQwD7rgvya1qu7bu6p7nGulQ8pELOBTgFZJ5JQBN
         lx6JniRvtcRh0Su9ECEuDgMRC2XUth9wwe18LusAyVtRzBuHXO1irGCTwdNFbgxo+7Gr
         0MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287186; x=1702891986;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iX9LTKD32QojhDmEQJfPhKZfMZUjvViAYKW+BQEUbUU=;
        b=R8kFMDgrjtcoMfnZWWVoz4oHTD0dkp8RDtvl/kJHklWI2rNSkb053FyRh+laq1fjZl
         iBG2aZoor+Y4YdaS9TxxDxylrU3AVv3x4fma3BsphjUAl4Dt6+TTPFqhOizTlz8OfA/L
         8ifvirhGcbLhtmbgXZbV7XLhRfYF658Dm19Xm4dPiwuRgPMTD0WODXI9yu9Ld11EMCck
         cSWkyuz1PHb9unGDtd6K3elZp0Q+FOdCmuV5kn73VdWYoPZ+NSB0ADnSBGH0yOJIH1FT
         hs0fBo6Eoltic/pL9UtOuawElrZFn4rM0t0ZOao3Tlp9RX5j4o+iK8pfKqhvDRQzI+Jy
         /Zcg==
X-Gm-Message-State: AOJu0YyTHPyaDS4sA3dPIKWFm5LL6LTgwnCuHwkFUjY6RIZKYd/nBtOj
	4HRsRE6+2aAJItVlfSqUeE+6HmwvFj5/xAb3Jw0=
X-Google-Smtp-Source: AGHT+IFBFyK4rQQdt7Doh0z+u1cKE5qm3rWqTF+fcGX7Mj6Y7Tqcm3iPLWnHx7IRte1V2zs45pysPA==
X-Received: by 2002:a05:600c:3d9b:b0:40c:256f:7570 with SMTP id bi27-20020a05600c3d9b00b0040c256f7570mr1862991wmb.186.1702287186548;
        Mon, 11 Dec 2023 01:33:06 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id z10-20020a056000110a00b0033343804ec9sm8058555wrw.85.2023.12.11.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:33:06 -0800 (PST)
Message-ID: <0e21a66b2de2c716295f439c5017c978957f2616.camel@gmail.com>
Subject: Re: [PATCH v2 5/8] iio: buffer-dmaengine: export buffer alloc and
 free functions
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,  Frank Rowand <frowand.list@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Date: Mon, 11 Dec 2023 10:36:09 +0100
In-Reply-To: <20231210142425.338a39f2@jic23-huawei>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
	 <20231208-dev-iio-backend-v2-5-5450951895e1@analog.com>
	 <20231210142425.338a39f2@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-12-10 at 14:24 +0000, Jonathan Cameron wrote:
> On Fri, 08 Dec 2023 16:14:12 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Export iio_dmaengine_buffer_free() and iio_dmaengine_buffer_alloc().
> > This is in preparation of introducing IIO backends support. This will
> > allow us to allocate a buffer and control it's lifetime from a device
> > different from the one holding the DMA firmware properties. Effectively=
,
> > in this case the struct device holding the firmware information about
> > the DMA channels is not the same as iio_dev->dev.parent (typical case).
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Probably a good idea to namespace these and existing exports related
> to buffer-dmaengine whilst you are at it.
>=20

Will do that...

>=20
- Nuno S=C3=A1

