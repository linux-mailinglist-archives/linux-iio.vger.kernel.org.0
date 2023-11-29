Return-Path: <linux-iio+bounces-476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1E7FD0BB
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 09:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8481C20CF8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18C125B6;
	Wed, 29 Nov 2023 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agzxlpLX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5119B7;
	Wed, 29 Nov 2023 00:28:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a132acb67b5so252122966b.3;
        Wed, 29 Nov 2023 00:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701246534; x=1701851334; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ts9qLZBjYQxWkoxOrPRUqONPnbAneYb5fj2vxXgeAUE=;
        b=agzxlpLXv5SBZJ2XmThPq2shuqUOktuWR8nzyHTIvoVYJ9SopDABnvAENGWj6m+WHM
         S0tKd7qGYvcuG7tQbPBmw+6szzv5t1NuBXlGouJNLMkPhS0Obu4kU/AMPz32bT0qqVXb
         2/e4okAvxiKsphONjwYrBP7Biu4GLuESpAVQG3oth0CUAsTtVyllOmL37sfS5nOuUZZL
         G2B4TdY6u8oGZ0t1Ilc91mZQDaopcibI/4ZVDUrfa1mawIEdJSQL95hWwuQxQ67SXmKj
         K/BIerqLqFkscTCkf+lW4RbUjFOKdqEG/yqtFR2OE16fPbIkL5WIKx8cf5a0+P1aLEP2
         88nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701246534; x=1701851334;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ts9qLZBjYQxWkoxOrPRUqONPnbAneYb5fj2vxXgeAUE=;
        b=iiVtgFWtVFxi15Q/OA1nF5Lz4uZOhN9ArPaHgk2OCSF9i7lM5A1FwzAfuC+J9S3iQC
         sM3a2aeTm2tVyuaF6Vj0rdisCKD9jfZ7A8DfhOSLuUpKbXeelrOU4ctRTMZIsKregbzP
         ZbY0K8E0lmS6E3MS/zqfJyTaHFJ4qOZ4fnyEnVvz2/2PlIMeabLm+TlHVESIMejSZdBH
         kTM2qHgxFPp3MKwAWfLImBzgWpOAbYmJqivpxLhyfoTZboQ/T1r4Wo5uYZVlclyJ40AI
         0eeP4XXi4v+CxCjKkreFnV/VOMv60NOUJjsKqMQSC65uyg1EMT9p7XStkLkTEDcRBwQK
         NvMQ==
X-Gm-Message-State: AOJu0Yw6vk8B3q4JyJtP00mwABKcTrgSLza3nH8wPYcCwx1PfpRYqEoY
	sQSLJBu9GvEm5uH+ae/mo6cSvXbNkrTaGdUe/e4=
X-Google-Smtp-Source: AGHT+IFNbBbO6mrFfuJyo4gjHoIKxEj7pAq+DF6gwAbts407nXDErvqusD9F7qPpST4q7AiCMHej4Q==
X-Received: by 2002:a17:906:9e08:b0:a03:4acd:750f with SMTP id fp8-20020a1709069e0800b00a034acd750fmr11379403ejc.20.1701246533645;
        Wed, 29 Nov 2023 00:28:53 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id hg25-20020a170906f35900b00a0d714f12desm3957211ejb.120.2023.11.29.00.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 00:28:53 -0800 (PST)
Message-ID: <fde82c39dbf56eeb8decac715ce5ec723da31e32.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: adi,ad5791: Add support for
 controlling RBUF
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Date: Wed, 29 Nov 2023 09:28:52 +0100
In-Reply-To: <cf778d32-73a2-4ef2-a0dc-31c6c4efe3ea@linaro.org>
References: <20231128-ad5791-michael-stuff-v2-0-541bb1c9dc43@analog.com>
	 <20231128-ad5791-michael-stuff-v2-1-541bb1c9dc43@analog.com>
	 <cf778d32-73a2-4ef2-a0dc-31c6c4efe3ea@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-28 at 16:58 +0100, Krzysztof Kozlowski wrote:
> On 28/11/2023 16:26, Nuno Sa wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >=20
> > This change adds support for an external amplifier to be connected in a
>=20
> Nothing improved here.
>=20
> I said "This commit/patch" so you replaced it to "change", really, read
> the Submitting patches document.
>=20

And? Is this message so horrible? Yes, you did said "This commit/patch" but=
 I thought
"commit/patch" was the issue because yes, I already saw other maintainers/r=
eviewers
complaining about using those specific words but nothing really against "Th=
is change"
(and I do have some messages like that). Yeah, the submitting patches docum=
ent
suggests to do it more like "Added a new property so bala bla ..." but I du=
nno every
word in that document is blindly followed. Is this such a big deal in here =
that you
had reply like I don't care? And even if you're technically right, there we=
re better
ways to say that what I have was not exactly what you asked for...

Submitters should make maintainers/reviewers life easier but the other way =
around is
equally true and nitpicky things like this are not helpful. Really...

Anyways, I'll send the v3.

- Nuno S=C3=A1


