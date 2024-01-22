Return-Path: <linux-iio+bounces-1844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB3A836CA4
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAD91C2532B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E249D62A02;
	Mon, 22 Jan 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ighTOgn5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E19629FC;
	Mon, 22 Jan 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939321; cv=none; b=B2tBCWHf8qGs/Yozrra4RJUznYM2qCROjNPW9FLkMOxA45sBueYBXta2/Swy4EvSAFs4e6j/fObN/jeyn6pGK48wJ+8vwLB7QVtgHqMLPYDPpENZpMN3TqV8m3BkdKpa7Zoqb5VTq8iICmYreZKEje7vhYerax6zlgpoKQUxMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939321; c=relaxed/simple;
	bh=fB4hCCEFRfqdFSuceI9EmlUzYOLltu5OB2IYDnk8/Mo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MW+FzA6hZnhxTLBYW3AUEjT4p96FQX5oNnUQ9OI8pZzbDRlBgYPZThz9N/iKX2qfNDORhI+D9rO0AkzuMPk8Bpmw1UjFcKW/uKkAe3b915ac+ihfMDnMx0WAqnIYMy7gL9tl2L9Xm2Xnp2cXRk6sLbShIs7ib3AhrbIpZ8Yd5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ighTOgn5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so325378366b.0;
        Mon, 22 Jan 2024 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705939318; x=1706544118; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fB4hCCEFRfqdFSuceI9EmlUzYOLltu5OB2IYDnk8/Mo=;
        b=ighTOgn5tB7ejx3gLray1Ld8yvM91496AAaNy+6PRMokCGE7IgMmM+9veNgVIJSw7X
         lncom/kxkS99fHMPIAQ+5c54ISrBnOM0a4+5w9DWBbqa9aD5ozu9/hU9ew9leUl0I2id
         L0ccP7wsA5pJb2MGHZJmPhmLFDsHjzZK2PR2j4TzrCfYgWTk8p7/vAVNGGAEA5Zg/uts
         991jdDSoQrugiofd+i/1+vnASSFyoT4IV3IXG5K/b4r+z+lDs4GBxX3WvBDKYbFne3kS
         95Xniq0XE3RJPJRqgtn1/xx7b9SScxChCYAaR+tEv6gac+chz1zH9OlqGgsQ98vJ0wVq
         tYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705939318; x=1706544118;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fB4hCCEFRfqdFSuceI9EmlUzYOLltu5OB2IYDnk8/Mo=;
        b=VrXPqcumgfk3PHYTFcJyEWwewQX3e38RCL10KNvVoQs7VfAMypia/TQyadKxoeIdL3
         cOqO5ssqzCBdUDyKHpJGXcmX4BKpmzJziNUAvx+lPOUgYWy+G050SuNMT4R1p1FMVbq1
         O6rqxWXsuotp/O42/+R/5oB0XNbBb0RCj//duF4qf1yQfPtLXNzawi9sraKsizZQSAVw
         YQEkA2LKpRc9Y8N4cR8iHjfd912tCJjL0eIV9E9rn0055NcWSEI0gNQZMyxug7aaQwS8
         iqfCSNBsBieaWpk8rpw8jRP0/a+MiZf8NUUM/4zFoiIxBSma6oBvrmTnWwLGWXAiDavJ
         y1Uw==
X-Gm-Message-State: AOJu0YwYw+vPO3OxSF2T0wLJbqywwRF7dEYgTOwT1mJJF0pLXfcoO3fz
	hToWgM0EwFJ+LFoHcULgpNp13hsK/kxqWoK0petsROZK0w2cnBNx
X-Google-Smtp-Source: AGHT+IGmtbUb7I0SxeN7awPnbdPnq/+DoV6AI4BG6yQs58SQH9sgfmmhcdPXNqDOvT2G6J1nZJvWyw==
X-Received: by 2002:a17:906:ae8d:b0:a30:461f:b424 with SMTP id md13-20020a170906ae8d00b00a30461fb424mr1027374ejb.136.1705939317985;
        Mon, 22 Jan 2024 08:01:57 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id d15-20020a170906c20f00b00a2ae7fb3fc6sm13598699ejz.93.2024.01.22.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:01:57 -0800 (PST)
Message-ID: <a9e31bf39a04426fead96ffdb086c8c4b92fedd9.camel@gmail.com>
Subject: Re: [PATCH v6 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,  Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>,  devicetree@vger.kernel.org
Date: Mon, 22 Jan 2024 17:01:57 +0100
In-Reply-To: <20240122153735.GB601827-robh@kernel.org>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
	 <20240119-iio-backend-v6-1-189536c35a05@analog.com>
	 <170568455280.599772.1565973986432310014.robh@kernel.org>
	 <20240122153735.GB601827-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-22 at 09:37 -0600, Rob Herring wrote:
> On Fri, Jan 19, 2024 at 11:15:54AM -0600, Rob Herring wrote:
> >=20
> > On Fri, 19 Jan 2024 17:00:47 +0100, Nuno Sa wrote:
> > > The ad9467 will make use of the new IIO backend framework which is a
> > > provider - consumer interface where IIO backends provide services to
> > > consumers. As such, and being this device a consumer,=C2=A0 add the n=
ew
> > > generic io-backend property to the bindings.
> > >=20
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4 +=
+++
> > > =C2=A01 file changed, 4 insertions(+)
> > >=20
> >=20
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-
> > ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml: io-=
backends:
> > missing type definition
>=20
> Are you going to update the GH PR so I can apply adding io-backends?
>=20
>=20

Yes, I can do that. I was thinking you preferred to have the second user so=
 I was
planning in updating only after sending out that series (or Olivier if he e=
nds up
sending his series first).

Olivier already gave his ack in [1], but I guess you would also like Jonath=
an's ack
on that PULL right?

Jonathan,
would that be something you can do? The pull is in [2]... Maybe give your
comments/review in there if any.


[2]: https://github.com/devicetree-org/dt-schema/pull/120
[1]: https://lore.kernel.org/linux-iio/4b1ffdc4-edce-4a69-a30b-45c29741dc2c=
@foss.st.com/

- Nuno S=C3=A1


