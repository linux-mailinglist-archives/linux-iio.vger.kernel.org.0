Return-Path: <linux-iio+bounces-5970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C188FFCD3
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F030A1F2BEBC
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F7D153578;
	Fri,  7 Jun 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX9q9tJ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396D14285;
	Fri,  7 Jun 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744330; cv=none; b=lls9I3mimF0M4eUTsxFwuZbocHdsPiekXlQ2+a/zstsaAfP1yMU8Gv49tsRKL755XTvLAqpSc26ylU9LgpjCWAD6UBynhWEclGtqz61UEjtSFjgaEY4Bf9ciheS6erde8xYk29hiX+BnwYalF/4t/NFhSvFB0cUZpYwa7woo/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744330; c=relaxed/simple;
	bh=bEmjUK6qoSrvk12pQiUVl21AfkI/9k/FBQYmQj9gOKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VRMKLYG0u/T62P3BPwW7ywRKya6xnnX8IkYTzxTNcgCmv02iuk1Kb5gxt3zgl+HP5PWQi9yahh3GqeYpoYezugQCBbxIMcyVCPcssO7XtHuks9iyHXprIYxfuy0Fv5NPGuHWfwX6PbOxu5FGqfDMx6q+/t0BundH6GKETKPwLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX9q9tJ6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a68b0a229so1989791a12.3;
        Fri, 07 Jun 2024 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717744328; x=1718349128; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bEmjUK6qoSrvk12pQiUVl21AfkI/9k/FBQYmQj9gOKk=;
        b=NX9q9tJ6nVMZ/RbaOsM5CjM6sVcNPy+t7dligKVtKUti1XDDAF54743xVX2ljq25hP
         PVHLt34Fe2RZ522l+u/tyB7Q7ETlP62dsh9cm2XL2VUZiPu+p6hvgVoOd/5g+NeyPtCK
         XHMIn3N7CdB/aaskJtaPF7Al57CJp/rc9ZlK33a7gN0jNXElk8AGf/gK6WFIavoB6RQd
         V0PnzuYbNiSddcLuYOd8072LUYEZQj/oELBMECAUj7DtOdF33LvaVCJJS4iGMB3f/1U+
         XJ4OU0Rceg4yxY8B35JDZBp8sen8KWb0/SR3byB9fJ0M/x0hSQvhMWzKIybFxpZv2H69
         2odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717744328; x=1718349128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEmjUK6qoSrvk12pQiUVl21AfkI/9k/FBQYmQj9gOKk=;
        b=cH0vLLWeTfYWrm5vmXuOmhRRBvj2Y9fx/q/QhaVbeg0hXZDjrbYmnJ++lvPfRTvkcY
         QzjsAuBBy6zK58C8+SabX/sIuJxR5CMeLV80sv++a1bCRkr+gmYlv9InyY4DV3vx/4q7
         y8+p0GazN+FcrnRPTz5kygu7zTxcEWrBmFGBsjLoJ/dwJZD3ZqLqH6u9dPmRsG6M6phb
         usNbcaEZy2Wj9hWpsu+grAqUCC2saiz3EUSX+Nv/0Zi42mBKLs1G7gD8jQnJaJK1A3vK
         rqNRSqN+3g0xLFA+RS9srtEDKZYEMxtxE+2qkgCb6kjV1+/D8THzzsP73Vt9KmN0S9YD
         JeNA==
X-Forwarded-Encrypted: i=1; AJvYcCVnYOdh4SflE9GwzTFSD3Uzrcwo7obiuLDr4LJvqiJ8edesW24qE3ZoXbGznq49Fc4pro/FhXt3HrXnux2XisUbrQL5ZWHkoJzVrgSA62hzDhzLosv3yLA6sBCzSIBG8JFKdaEhh/a542TPrNLZrHSjMbWsFdov1AC7QpCXwqCrEVaHkqM7NJhbH6JIgjX+MH7+IxC5mx/ph3q0CrF+Ww==
X-Gm-Message-State: AOJu0Yy7CIYtBChzL0ZjPZ+MghHxtefbvChn89YSU+HAlbbpWOVgPAh4
	66i+Ti/mTl5YdoKFIob4oC+sF4qO9i6I0Iw1HdSMUC7UADiJqUxY
X-Google-Smtp-Source: AGHT+IHzEiccoGREhale3WSaW0vqNTLmxOuBlaWs7896ljD5D4Lg+XMwSiOTVQB3KMA1zv4B8K09Ig==
X-Received: by 2002:a17:907:7295:b0:a6c:70b9:15f9 with SMTP id a640c23a62f3a-a6cdbd0d06emr132728666b.68.1717744327399;
        Fri, 07 Jun 2024 00:12:07 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e9b1sm199654966b.165.2024.06.07.00.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 00:12:07 -0700 (PDT)
Message-ID: <04b1296ff98a0accbf962a4a4bafc2e85a9869ae.camel@gmail.com>
Subject: Re: [PATCH v3 4/6] spi: spi-axi-spi-engine: Add support for MOSI
 idle configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
  linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 09:15:54 +0200
In-Reply-To: <ZmIqxS-xUVMNH_lJ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
	 <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
	 <ed4fe3de-726b-4eba-a12a-d2f7b1da26d1@baylibre.com>
	 <0e18b3aa83a62103b0f06ee516193c03f80abae9.camel@gmail.com>
	 <f8ce5dc8-ed68-4f04-af3a-187bf0e4a3b3@baylibre.com>
	 <ZmIqxS-xUVMNH_lJ@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 18:31 -0300, Marcelo Schmitt wrote:

...

>=20
>=20
>=20
> When is a driver version check needed?
> Yes, older versions of SPI-Engine won't support this, but the patch set s=
hould
> cause no regression. Even if loading the current ad4000 driver with
> older SPI-Engine HDL and driver, the ADC driver would get a warn (or erro=
r?)
> and do what's possible without MOSI idle feature (probably only be able t=
o do
> reg access) or fail probing.
>=20

Maybe I'm missing something but with the patchset we unconditionally set
SPI_MOSI_IDLE_HIGH. So if we load an hdl which does not support it things w=
ill
apparently be ok but it won't actually work, right? If I'm right we should =
have
a bit in a RO config_register telling us that the feature is being supporte=
d or
not. That way we only set the mode bit if we do support it...

- Nuno S=C3=A1



