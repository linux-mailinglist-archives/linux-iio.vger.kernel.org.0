Return-Path: <linux-iio+bounces-8128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D306B94456C
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 09:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC6E28233B
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 07:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC27158A1E;
	Thu,  1 Aug 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESmb5FwD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E1157493;
	Thu,  1 Aug 2024 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497240; cv=none; b=kKnjCF6Cz/GNST8ZvH7fcVZqFWeXeSEnniO+73Gdr+qJ0GBmiahe/2MB3uaH+YJ+ksRjVVI99cgNGVqYcf5ZyP1oYjDNOILmwKgX3vqkrwvcI5gNSm8/rX7GAwF1Fnhm++tHm4LiSdiX+fVlrZhomZakTihFZ1bnxjJax2LWL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497240; c=relaxed/simple;
	bh=VQncXqaDcXbENEjX/CAKjfBcbGdtFbzJO3FhAhpP9sc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNyzpC2mpOyJBJ4YykiZwQW4qxgmvC24u0QuDxQHivRRYNRwmmSnMEIVWKvTwxfqP6hDctPn1z933ScCx2kpR6kglfFOK05FJMiA1wTESvsUFRKMq4BrzzGUjkq5yn4Gr4yjZYKNtJee5RQAH00TKjBiT4zfJiPlEZtZt04eXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESmb5FwD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a728f74c23dso873652366b.1;
        Thu, 01 Aug 2024 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722497237; x=1723102037; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VDaQ/XLqFOxVKm2NIkUI8ZRKKv0IjyT6x4eynWB+efQ=;
        b=ESmb5FwDvLGbd2EfNDGGij73eP0Rt4+psj2m5iqTP0tH0G5i/B4KBKkwcH+Gtf0ur2
         HmXTIpwlKsaOpH6LNcn6orK6FbvhpEmD/i/YTM7R8jcWMmqcFXECgF8OXdgS44pVTwCm
         5edBxC+z7nvETNYAffrHt0td0RHvdhICNiBGcKCTF653QOKnuBpP6mLlVOE06wnna5gQ
         nD1OjrhXBmeSejGm/tXJFptugCcQeaH/cgQTkXnWmh4vNHGKLIm86RTu/HKhnILPGCxE
         a8rY0FEKFuF0lXukjuohNcARZPC4O5o+Wpp3R97KBOEuRhX/+ThpxcajZVeJ1V/d54Ba
         ZJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722497237; x=1723102037;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDaQ/XLqFOxVKm2NIkUI8ZRKKv0IjyT6x4eynWB+efQ=;
        b=Fc3Gv1uKg6LlqgwmU7fVWbljKipoqzLnW95M09MjwNg0QO7L2m6GRUDCFdTGrDZBWD
         a4bUykZp6UAQGrtzKc9xVFBN4vVpq9u64Oxr3FOpp/qjyTMUC9amuHffvI3Anw3xquh0
         P9xIYRx7mUuuWJQQYt/LZbbMNPvTC9KCsImmznIwHT5WlG7ybi6eD2bbKneSqqbl2Rh+
         j2tdWBrdav8y5cRRazCYVvGPF9SXX0oMs3fIiUcBGl2wp8B51haGgzxBW/Jafd8Jo0/N
         ud5E52dLraxwOVifXGeIG/xPHAIBoRMcl57P3lPrJKiSiypeHNqXKhH33bTz6DDU38xq
         Gvfw==
X-Forwarded-Encrypted: i=1; AJvYcCUKpEC/yFYWqVxvOFkm1hR9wkY/bs9RadexsGsgn2QNC7FAFyWDqrs0xmJ2t9vEDivrnstT58vlnsLqo3jqH3x/BWlqyVGviAle69kCoFYTi99ZUCYVDcccrznSIObgGDWDgfxW/DMAU+yrAj0pLkvRgCmgzBwT8J17IyZJkvgt925BMA==
X-Gm-Message-State: AOJu0YwVDUEtCBAmopYkmKDQ4uI2n3fSGwIxwXJ+CdIl9ihRdOhG2Fr4
	7OlDKud+ie22JcJOE4I/c0+ihD/+rbtiC7281iMEF8p1J5QdMt8r
X-Google-Smtp-Source: AGHT+IH/70r1yEd0ZRNC82j7r32/G4ScQiEWhCT0rp8swngQe3uZ6EiGp/nlrRbIK397TZc47zc4BA==
X-Received: by 2002:a17:907:e9f:b0:a77:c824:b4c5 with SMTP id a640c23a62f3a-a7daf9b165fmr100435966b.18.1722497237264;
        Thu, 01 Aug 2024 00:27:17 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7d23e8bd62sm802293166b.73.2024.08.01.00.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 00:27:16 -0700 (PDT)
Message-ID: <02bda6f37ac5ed171429a980b9a3ac69cd4efcf9.camel@gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: ad7768-1: use device_* to iterate over
 device child nodes
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, James Clark
 <james.clark@linaro.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>,  Michal Simek <michal.simek@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-leds@vger.kernel.org
Date: Thu, 01 Aug 2024 09:31:16 +0200
In-Reply-To: <20240801-device_child_node_access-v1-2-ddfa21bef6f2@gmail.com>
References: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
	 <20240801-device_child_node_access-v1-2-ddfa21bef6f2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-01 at 08:13 +0200, Javier Carrasco wrote:
> Drop the manual access to the fwnode of the device to iterate over its
> child nodes. `device_for_each_child_node` macro provides direct access
> to the child nodes, and given that they are only required within the
> loop, the scoped variant of the macro can be used.
>=20
> Use the `device_for_each_child_node_scoped` macro to iterate over the
> direct child nodes of the device.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7768-1.c | 5 +----
> =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 70a25949142c..721672fe84ab 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -544,13 +544,10 @@ static int ad7768_set_channel_label(struct iio_dev
> *indio_dev,
> =C2=A0{
> =C2=A0	struct ad7768_state *st =3D iio_priv(indio_dev);
> =C2=A0	struct device *device =3D indio_dev->dev.parent;
> -	struct fwnode_handle *fwnode;
> -	struct fwnode_handle *child;
> =C2=A0	const char *label;
> =C2=A0	int crt_ch =3D 0;
> =C2=A0
> -	fwnode =3D dev_fwnode(device);
> -	fwnode_for_each_child_node(fwnode, child) {
> +	device_for_each_child_node_scoped(device, child) {
> =C2=A0		if (fwnode_property_read_u32(child, "reg", &crt_ch))
> =C2=A0			continue;
> =C2=A0
>=20


