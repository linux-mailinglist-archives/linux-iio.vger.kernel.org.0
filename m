Return-Path: <linux-iio+bounces-781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CB380B4EF
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 15:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FF81F2122D
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791A3156D2;
	Sat,  9 Dec 2023 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCZFMAxu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555C3121;
	Sat,  9 Dec 2023 06:40:52 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1e83adfe72so294853266b.1;
        Sat, 09 Dec 2023 06:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702132851; x=1702737651; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sV1DKws99nYlvpD5rucfuWsO7jpxgf6pAYHODyhBmew=;
        b=PCZFMAxuW9BU7YMZGInlKL6+ToXPz3MtoO72WZgvEh2+prZEfhjQJSqaDtKHmegTei
         2iC328PgeJZjORzzdlsYOw5tB5qcmr5CTQ/oK7EPHhbbwCz5BFVQouDBvFqPFD8pt7kY
         5yxfYE2wtSa/4USIoGXHMplcqfiPbXSHm9npORj+Tb4zSvt0q8V4WYVtg1gMAM5VVrg/
         +xYfsK56yZNbvhIn3kqfb4aQuTlsux2pnNPNfEKba9Tub2PlRVSTnnXXGv1OnlFXp1sM
         m2QiwMMTp3GYR9jlcUtxB+IvmCqQRerBUP5VY1qfct5+0AeKtcJyjDeAblkgiZRchguU
         nJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702132851; x=1702737651;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sV1DKws99nYlvpD5rucfuWsO7jpxgf6pAYHODyhBmew=;
        b=YZ1GJNXYFFLE0uIAgDdoAxn21Iic7u1TL+T+HqTBWeM0xGKnskwuUScEjPjgPpxL+7
         n7+ZZ2zH7bBVFnH1nfta3V0TR7Y60eRzZtcZXPZosYk3fjatGWfgae0s9pdNuX2fgKOB
         eFj9Ynm4Rjn4NTtSRGFn66opq8H1H1tE725BhwG9KZtszoa2oyABJHs4f6l9x8LIAqgS
         6klKT44bWAayUGgHKbC7SLRBj1PCAputktnrGS17XjYReAbIxua0lgak2+U0CXaqBpO6
         5/0rT6Pj6bO74nNOhvbYJW6CNMYY/+IxEmbrNG09jgly4qO2mtQLI3NRxiPuGRSZyou/
         +otA==
X-Gm-Message-State: AOJu0YwhehyUzsPtAYcg28pwUaPO6SSp2MEOXXCyx8bK/e2UZixxtqFz
	5U9VbJH7MzVNexFMrAJ41Ww=
X-Google-Smtp-Source: AGHT+IGAl/WZNh9QZIWU2HAZc72JeANhwZj9YuUpwmVrQE5vMFH3bhOT/LJQBu4ukFcZpi8VlveIDg==
X-Received: by 2002:a17:906:20c8:b0:a10:e86f:5594 with SMTP id c8-20020a17090620c800b00a10e86f5594mr986552ejc.3.1702132850614;
        Sat, 09 Dec 2023 06:40:50 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id gl17-20020a170906e0d100b00a1ddf81b4ffsm2262388ejb.207.2023.12.09.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 06:40:50 -0800 (PST)
Message-ID: <84fb0d3c8e17b91a047658be3074f7a3fc311bbf.camel@gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: adc: axi-adc: deprecate
 'adi,adc-dev'
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 nuno.sa@analog.com,  devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Date: Sat, 09 Dec 2023 15:40:49 +0100
In-Reply-To: <62c75eed-ed8d-4d51-b49d-9ed9c53162ed@linaro.org>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
	 <20231208-dev-iio-backend-v2-2-5450951895e1@analog.com>
	 <62c75eed-ed8d-4d51-b49d-9ed9c53162ed@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 18:39 +0100, Krzysztof Kozlowski wrote:
> On 08/12/2023 16:14, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > 'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
> > also remove it from being required.
>=20
> Why did it become suddenly deprecated? Unfortunately the commit msg does
> not tell me more, except copying the code...
>=20
> If this is result of previous patch, then squash it.
>=20

This property will be deprecated by the generic property mentioned in the c=
over
(basically the property in patch 1).

I'll improve the commit message on why it's being deprecated. It has a lot =
to do with
the changes in the drivers and how we want to start handling these HW arran=
gements.
I'll try to explain it in a way that makes sense from a bindings point of v=
iew.

Thanks!
- Nuno S=C3=A1


