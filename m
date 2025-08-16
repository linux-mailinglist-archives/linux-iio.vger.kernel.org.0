Return-Path: <linux-iio+bounces-22818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A51B28E10
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E922CB0108A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E1C2E4265;
	Sat, 16 Aug 2025 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=watter-com.20230601.gappssmtp.com header.i=@watter-com.20230601.gappssmtp.com header.b="KETBCVjh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405E2288D5
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755350303; cv=none; b=s+nm/f2EZz3rbpk5+Ft++zv5WNbebwrojqw3JGrxsC2jDw2q3IL3Vjmlt7goLl0N24icMKcy0u0oX/oajtqUqY3VqCU1VFe+SJVA4CHKdsFAFWsnqy20gxtm9pTqbBxT++kx+A0vg55rpDEldW1qn1Vk7PCHH6KITEoPXa8THYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755350303; c=relaxed/simple;
	bh=gFv5AiUoDKOtaASrGVzw6Cfk5wDTFd1ZbzMigzVHKts=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=H4RbDkjPVvJqSuwVO2URPBSiwFjnREL///HYkzhtzx+sfUanI9Md2xU2Sdws9aEbexWDLKoKJ4xZakhJP3pJ6LZG/b5mmjL5/w86GQLzPxIm0p3AfXKAysE7Ag+E7FIrDHt3N2sEnIttTg/qtFyAMaJAd390d0HQ+YYIE67MpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=watter.com; dkim=pass (2048-bit key) header.d=watter-com.20230601.gappssmtp.com header.i=@watter-com.20230601.gappssmtp.com header.b=KETBCVjh; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=watter.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e870666dd4so328672385a.2
        for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=watter-com.20230601.gappssmtp.com; s=20230601; t=1755350301; x=1755955101; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz9ukFrqWFqJqtKjXZoI2WNXCzAlVgUQ0S7OAE8fvOw=;
        b=KETBCVjh5KnOiWSQqLzVwLvA2SC4ef2mH2GkuVQQdksCwnuVAkE+Uk8ii/27EJm0ak
         UUcWotrlDhMw6+daWyK9z/Zjw4zTgcRn/CIWlgLO0dCB0zvMprR74dAPH0kbnWCTM2nP
         4c3hJV+Dg6awfTYGDfgWMOsANBVUWZ5fk+2fja8MaQyVIVJ7tVFWG5BY989p6wPXKASd
         TfzrJoFqnBqGbcFrRa9R21Bx6Ch1geXDt/mwXC0cO/yh1Qdl9+UnNX2/MBnwaBxsyjTv
         yfo37eyHCJt+7qqmOhL4nWg3TKDCqReafxhN02cq0vbqGflarFB43QfDxDCKHf7+hVtW
         7WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755350301; x=1755955101;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oz9ukFrqWFqJqtKjXZoI2WNXCzAlVgUQ0S7OAE8fvOw=;
        b=N2kVCHN9dRWIAu1Ou8QFpOsePFv8dEUCm56xcCrL3FNkVuAk12WActoo9BWZIvIMtv
         di/wZm7sgl2IC/b+YUybCF5o9A/Wx1Q12nzK1lcNT8Y+JLHL2MzLbzX9BtbPADUft43M
         e17798SaFhdWkCsO1ulnQ7rDmJpHTEJ0Q/5iisGandm0vfkR4S9/dFuOOLzNd0fj8XhP
         gwx994HixuPL7MTbYxMfU18plpMRxsipuNE0eUmpf90w0mH2FVX0MWV7T+vsEk2JRvLn
         nx1IHcIO5G/UsLbfL3BVJHQVOyFVTkjqvy7O7VhqhTS3QT94e8vP0UpZ+UbZg9eCHNaP
         rMdg==
X-Forwarded-Encrypted: i=1; AJvYcCXrreSsbaDOgxFLHvZw35Kon6BRMoXEDwtnquEIRyEZtJ+8l1vVGEWM0I6bQdDR+nWtwZ6tPWi4Bpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAW3Ld8KEyg9OehVb4D6o9oloEN0k8jfCm4m8mljIWMVeEig10
	oBnIOvLmT6mbaNx/4yNRH9b8OuB65D3iwOeivmqpH7EbpplbKaOyyT6Xn8l6NTs8zw==
X-Gm-Gg: ASbGncsniiDMgFPpU3T5AN6EF51YJ/BPlwBiBzFYGCeZCqZPqt8MaB4CsDGaXl7Ii0Z
	qlkyuLuDvQV7OEaUCAKhasPdArTB8Ji4Td4zSx/zquW+qGHdCesTvh9QrarIBx7UZlB11iQVah3
	6d4Obv3jt9eF5MlBD7VQwec7Dx9MUg04a8jfZDNLi5jdGRsGvyZLIN+7ljryUm4aOIV4U4xH5Rq
	nrmPD+7QVPe0tjm65ciFF7CTQkFOA9W+2n5QRowa4XDofiqioq/PUF+VRwHPOQHylpzlSX67fr2
	AzkY3kPYZbM52oP+pEQcUE2/jRq0nHHJ88FvFnssYyUd33F570HXahrHfCnAk5heaLeiJsJFW/8
	nb0M+1ky+VVJU6ipXbewjcKIDanbvnyEQBtwIjg2T2mOvCyecpqmu
X-Google-Smtp-Source: AGHT+IFO2mPLcoMCnsyNEjljs3NIOEYHeTiCubF3Jca2hjGQBdeRt/V2zlsf3Sb3WYvz2a/hFw9ULQ==
X-Received: by 2002:a05:620a:a905:b0:7e8:8ec9:bdfd with SMTP id af79cd13be357-7e88ec9beb2mr67617585a.16.1755350300982;
        Sat, 16 Aug 2025 06:18:20 -0700 (PDT)
Received: from smtpclient.apple ([70.32.192.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e020514sm266847385a.17.2025.08.16.06.18.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Aug 2025 06:18:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.2\))
Subject: Re: [PATCH 4/5] iio: mcp9600: Add support for thermocouple-type
From: Ben Collins <bcollins@watter.com>
In-Reply-To: <20250816111125.65fcbb09@jic23-huawei>
Date: Sat, 16 Aug 2025 09:18:09 -0400
Cc: David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CAB4E66-23B6-41F6-9782-3F3D66AB9908@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-5-bcollins@watter.com>
 <20250816111125.65fcbb09@jic23-huawei>
To: Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.2)



> On Aug 16, 2025, at 6:11=E2=80=AFAM, Jonathan Cameron =
<jic23@kernel.org> wrote:
>=20
> On Fri, 15 Aug 2025 16:46:06 +0000
> Ben Collins <bcollins@watter.com> wrote:
>=20
>> dt-bindings documentation for this driver claims to support
>> thermocouple-type, but the driver does not actually make use of
>> the property.
>>=20
>> Implement usage of the property to configure the chip for the
>> selected thermocouple-type.
>>=20
>> Signed-off-by: Ben Collins <bcollins@watter.com>
> Hi Ben,
>=20
> Just one trivial thing inline.
...
>>=20
>> +static int mcp9600_config(struct mcp9600_data *data)
>> +{
>> + struct i2c_client *client =3D data->client;
>> + int ret;
>> + u8 cfg;
>> +
>> + cfg  =3D FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
>> +  mcp9600_type_map[data->thermocouple_type]);
>> +
>> + ret =3D i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
>> + if (ret < 0) {
>> + dev_err(&client->dev, "Failed to set sensor configuration\n");
>=20
> Only called from probe so use return dev_err_probe() here

Hi Johnathan. That=E2=80=99s correct in this patch. However, in the IIR =
patch
I call this when the filter is set, so it didn=E2=80=99t seem to make =
sense to
do it that way, just to change it in the next patch.

I appreciate all the feedback. I=E2=80=99ll get things cleaned in for =
v4.=

