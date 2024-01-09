Return-Path: <linux-iio+bounces-1508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88F8284A9
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 12:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C97D286E13
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 11:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A69A36B02;
	Tue,  9 Jan 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEx5WBtU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF929431;
	Tue,  9 Jan 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-557bfc7f7b4so2783649a12.0;
        Tue, 09 Jan 2024 03:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704799230; x=1705404030; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4NZX0EHRxNFHTm/t/SYbExyf5aSTC2bJZYYjJUylqqM=;
        b=nEx5WBtUr1QpKuXgbWyI7Ywtl99doLC0b04T0BRP1D+PMUIlnTu9F8RvXC/zSHSv1E
         efuPFxd/MJydkLwL+I4KN9dWwSTVugocpSvFkJJg17YkHxsXcKY07LpUViW3d5FTmHz9
         rvEWcWwR2H6wBofMl70D13atxawDlxx8OyRodNBN+9eBlB2pBCiG+sGTXccY9KJB7lbQ
         DbPJgjYQk/a25JbB1s5QWzQe9DG5HPtfNKLdU0VrX9tMDVU+87+aOhcBVC2Fub+eYoN+
         G+qFYpLJP58gUJggxN99HkxpUa/lLQkZK4UjPlZbmG9YOb5J+7lMQ7an4eiL+oTMtwf0
         okqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704799230; x=1705404030;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NZX0EHRxNFHTm/t/SYbExyf5aSTC2bJZYYjJUylqqM=;
        b=pLNs/CoEVkgLfcddyV71SPv5FyFz/gMHnlq5fmaePYfeVm6l0D0+dNG0FEyEUWsoMg
         AZvilt9WqpRgoaiBkqi2zQsxDpohJLRSxlqvVseq5oWiJPI9Z+VM3L2hsgCGa0Q8CUGy
         yl/syEN+S5PZmBFQ4EU9ARhMfeZLnDyBEI6PcM5m4ZKjp4zxcgtYtPUVcjzddJdwkw66
         Z8v/eAK+ZzbaTsyKfurXgnzSXzULU1G76dQwlkZK9rEC4nN3OTDVXaDmXwBYcw9Cuha9
         4gTAb9w3V1W+NrEBORlPtx6QaTZkB/zPzWsD3zc+LbhDMcpdxokUBHmS8OkHSTWeaoxD
         WGMg==
X-Gm-Message-State: AOJu0Yziwd2ccsXDN1PS+Yk241OxWNcuAkjwrEQPNGbU1nOnNhp01VfM
	G4J0hGq8Kc/feL5p4aQyzf4=
X-Google-Smtp-Source: AGHT+IGXf/m2QIRzKQ1oStdVxwLExVWwxpRPwZ3jXCPKit0oTg9DYq8+QM8W3Oq2r3tHVJ1af0+Z2w==
X-Received: by 2002:a17:907:77c1:b0:a2a:19eb:9144 with SMTP id kz1-20020a17090777c100b00a2a19eb9144mr612510ejc.1.1704799229477;
        Tue, 09 Jan 2024 03:20:29 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906529800b00a27aabff0dcsm938655ejm.179.2024.01.09.03.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 03:20:29 -0800 (PST)
Message-ID: <e64da4a8907413a75bddda0401bbc2e21b12fd7d.camel@gmail.com>
Subject: Re: [PATCH v4 4/8] of: property: add device link support for
 io-backends
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Tue, 09 Jan 2024 12:23:39 +0100
In-Reply-To: <CAMknhBHqnQoEMoaFQxp5Us+X7bs7G2J2QTNZwguPmJ7XwEHe0Q@mail.gmail.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	 <20231220-iio-backend-v4-4-998e9148b692@analog.com>
	 <CAMknhBHqnQoEMoaFQxp5Us+X7bs7G2J2QTNZwguPmJ7XwEHe0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-03 at 15:39 -0600, David Lechner wrote:
> On Wed, Dec 20, 2023 at 9:32=E2=80=AFAM Nuno Sa <nuno.sa@analog.com> wrot=
e:
> >=20
> > From: Olivier Moysan <olivier.moysan@foss.st.com>
> >=20
> > Add support for creating device links out of more DT properties.
> >=20
> > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/of/property.c | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index afdaefbd03f6..a4835447759f 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1244,6 +1244,7 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects"=
,
> > "#interconnect-cells")
> > =C2=A0DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
> > =C2=A0DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> > =C2=A0DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells"=
)
> > +DEFINE_SIMPLE_PROP(io_backends, "io-backends", NULL)
>=20
> In v3 it was agreed that adding #io-backend-cells right way seemed
> like a good idea. Do we need to include that here?
>=20

Yeah that's something I forgot and should do in v5. Should also update the =
core
code and the backend bindings (axi-adc) to have it (one of Rob's points in
having the #cells was to easily identify backends - providers).

Thanks for spotting this!
- Nuno S=C3=A1

>=20

