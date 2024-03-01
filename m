Return-Path: <linux-iio+bounces-3251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF03C86DBF5
	for <lists+linux-iio@lfdr.de>; Fri,  1 Mar 2024 08:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A20428A9F8
	for <lists+linux-iio@lfdr.de>; Fri,  1 Mar 2024 07:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9BF69941;
	Fri,  1 Mar 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leng/8N5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEF6930F;
	Fri,  1 Mar 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277416; cv=none; b=DQBVil/mphwM3RsZfe5V2aLCUI+40H0nNI08MuaCWV+exBT8LJSjfBogj41Nrtfb77vgtK82RfrizG0DajlOn5+DHcP78jCCJ71QjykPvOZq5r8IGmoa+LvCrc3gLbOoD+/n3koR1mV2wS3JeKORWOB10FMmjrFU2tIYRL3n3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277416; c=relaxed/simple;
	bh=WHKVZdrxfAxAeyIcsa7IjNySNrmUfuP0ojsYfxM1XHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RFBxh+OdKQy+iNZL/OsooxJvRCNOElK+po4E49MAdCx1tsqJjS1q98GtU9fPbnp9ry6OALngOmJJ/u2qyb3ooyzYpQgZANV9cFIa7SQlUe/9HMF7wqYlMD/Tktq3pF+La2laudM2ABHQA2u9/XuOHQlG66xjymUjTnu06ckQbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leng/8N5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412c227c80bso7878945e9.1;
        Thu, 29 Feb 2024 23:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709277413; x=1709882213; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0F7J/E4zNfIGX63i/LqfI7L83PfKXt6U/fCuTc8OprU=;
        b=leng/8N5qrrVhKhYYfnlwwjtDXjtcTFQzut6i0i+d1SkPfYBebzd3wRX9DFqaWxin8
         rWQC9o0FY2zjyFFyZbdnUow6Zt60VguEuWjbNiCSIwLEHtpAfwI6bJy1By0Ng7E0QI96
         dWWCHDPB6ObnkYkkTENH/JPgNvG8OG11wEdRuOVcF4iQ/2fSrH5DK+KEL7zM8SVmTrDm
         us6FL9LwMmuK4FV+jAD6dsBIkmsqTTUh4maKP2zXeEzTXZ6kx91n1FqCVqUawIZqfN3x
         me2qRhfK3VTxD9sxXHTre46cjwyOx6A5tlmMZH4vdMe8+nTi9FHnUJfX+MKs8CkOqtWo
         12DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709277413; x=1709882213;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0F7J/E4zNfIGX63i/LqfI7L83PfKXt6U/fCuTc8OprU=;
        b=ZLIcmZodQVjdGcyLqa0KErRC/EPB3Gko4wZoSchABItmvjePVTFcLClDphT6spgqcZ
         Q8q4H9Vre87jvPKxQj4tjrq8Fc++C/r3O4SB0H3i6Llwbr5Y+SpgX2R8FwFZ5C0GKknh
         IY43Ht2M1C3/Bqb8/lU+2u0DEKSxa2p0RhSGuMry/j/r7prLWg+OE2HUY2wyaBcl2jn2
         a50is9OspTbP9I0e5j+UqN+xT1I1uayE61ujBK1nxLuzkmBENQdwO8LqCaCXuxmsgoNc
         SrvllKttysBpBQKjdlfrFk+WNScDPyULlhtXtpsQRITZjk9MgUZylgsAbX4HjDG7yRJe
         NDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmAwZSx0EtvllH62gaBCZW7tVvQyeD4tdxfu+tIIt3r5RC4sOWuidEDGqIltk0I4ERSlsQv3rRhVOyFd4M/9h/0fdZuRectLfSDA==
X-Gm-Message-State: AOJu0YxZwJdhPoB7T6KWjYdZedMFfDSjDtVycntxWi749fpTcAUYdTKo
	pKY+IJL10fbO+3J2WsnVL2loPf5T+AF5D3lHqiJ6z2b6oMS06tVA
X-Google-Smtp-Source: AGHT+IGVXdRL1BMgIqQojocmat4yNXQDqAi1l/tVjGo/Ip7UUfXPxszmXYIcMd5luwPJXYayGLe1Rg==
X-Received: by 2002:a05:600c:458f:b0:412:bfa1:2139 with SMTP id r15-20020a05600c458f00b00412bfa12139mr622553wmo.37.1709277413046;
        Thu, 29 Feb 2024 23:16:53 -0800 (PST)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b00412a9a60f83sm4444327wmb.3.2024.02.29.23.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 23:16:52 -0800 (PST)
Message-ID: <af4539ebb5786d1f93c3d9b2b427412838e75160.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: temperature: ltc2983: document
 power supply
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Jonathan Cameron
 <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh+dt@kernel.org>
Date: Fri, 01 Mar 2024 08:16:52 +0100
In-Reply-To: <170922758600.4099132.651212743562426191.robh@kernel.org>
References: <20240229-ltc2983-misc-improv-v2-0-cc6f03da2529@analog.com>
	 <20240229-ltc2983-misc-improv-v2-2-cc6f03da2529@analog.com>
	 <170922758600.4099132.651212743562426191.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 11:26 -0600, Rob Herring wrote:
>=20
> On Thu, 29 Feb 2024 17:11:42 +0100, Nuno Sa wrote:
> > Add a property for the VDD power supply regulator.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam=
l | 3 +++
> > =C2=A01 file changed, 3 insertions(+)
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.ex=
ample.dtb:
> temperature-sensor@0: 'vdd-supply' is a required property
> 	from schema $id:
> http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
>=20
> doc reference errors (make refcheckdocs):
>=20
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240229-l=
tc2983-misc-improv-v2-2-cc6f03da2529@analog.com
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>=20

Damn!!!! I'll send a v3 fixing this...

- Nuno S=C3=A1

