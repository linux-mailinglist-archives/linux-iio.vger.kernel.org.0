Return-Path: <linux-iio+bounces-9661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8345097D5AA
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D5E1F237B6
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB614D708;
	Fri, 20 Sep 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaauDj1z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E0B676;
	Fri, 20 Sep 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836347; cv=none; b=Enqb4XDbm/HGVLZnkU43S5co1QNobO60t9gJPEMWJf4k1T/CI7xXaZ20zzN/RTmE+A3pBITfP0lEzQ/AKLIt99ieh1SkXR3LlfVUSl9aECcyEyw3Hu98kmsM3VM8rPYc+deVFGacWZkvrG/WCuztzx42QaofeOjvFae6quAlxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836347; c=relaxed/simple;
	bh=Iuc54d6NEiz4BcqdQWijF887D4/QJ1B+uCas39aymUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dVErpyJHYQ9OOjTwCK8sUjdqh2dDKLOYTkn8YtoLI8/lZ4Lj8s/6f6YvlXl/zEarhkkxDyNj1hxpj0tmO6HIfTXJOMNgPiR97tpsgHUDagG9SpYq3yvaJ+PZhc/2MsTOLDOtG1byZ4Jwtc+4xu0hcQPBBdRYCeV7Y5+wWxRbW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaauDj1z; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-536a2759f0eso2651373e87.3;
        Fri, 20 Sep 2024 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726836344; x=1727441144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ezAH96T6rrdFYudMYX1pfn/bn7PZvj1jwszwTMpYXKM=;
        b=YaauDj1zx8gwCPqV15JquvcEq2Iv8QLbXcaa+QuUBEkMdDw7tC8BAUgeKOcyEmvVEL
         s+xchprOppROC9iAVC0PBi8/HVElchJp28IJyCsXYaJzElvXj9Ddin7EGLtqYyP1BbC6
         bwGC+gbNMx+Fvn85TnyqwzwBTt5kd/qCvfuD1hBS6BZ1Vo4MR3Qs2Hl0I47QSMw0f0Vn
         HXWaAEr7VGPWWrx9Qf5MPJKdBMO9Vf7LAkHJn7jFfokSbhv5aRXh2BGf4OOCHAAs7gt+
         o8sMb6YZpLc7Y/LJUHB5c5e1IB0UOiKaYQEEgvS0HTCro2Qfj9hxR8TGNmgXpo8IqWEA
         INIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836344; x=1727441144;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezAH96T6rrdFYudMYX1pfn/bn7PZvj1jwszwTMpYXKM=;
        b=km1mdKuvHcAZuYXPoPoG33RntFmvsEDO5rKCdGGdpOfqVDtCl0DppWS/+mAkA/0NBF
         R56f7hP7/eK+lSLISnCGwelnLpG5BG9gFJBYJsS/q0HP3SBkDLPEmuyAHduK3m8ILlYh
         6IHPwgWHx/GtGxCDJdBygkFproHu3foUpOy9faktYb7NmlYocLqf19xi3MeOVStzJ12b
         jVlJ7AtOew38qlwOYhfEr6GZBLX3QB9DT9/tZItTqdttP+EaslwoyN+dMParYBzjLmom
         0h01t/+KhxY6zl4YZ7DaF035ERYxWJ/H5xhlbLL7goHApNNpal6hqagh6zd20aI7HUG8
         Piyw==
X-Forwarded-Encrypted: i=1; AJvYcCWl2mRaC5Szaz0VjHFOJ2jfIzOZ8QhESlFIE90hUC8xIj5BUc6fWFjKlLDGi8pHHY3hjhXpHljeGlmW@vger.kernel.org, AJvYcCWu3TYRCVqU1c98vVeJYq8lgLSUSgNxoROfobOKhpe8RFecNQpSJWwXxV8tdqJlW2gn+5HXScqzH4XaMTQr@vger.kernel.org
X-Gm-Message-State: AOJu0YzMN868PvKB4fneC2z80J0HZ/mw8uIzzGeZy21BoIR8K6cOrJdz
	IjovUhaT5WKyx+BDwt80lYQ3X/NYOis0aedDjZqq4tZYj28YfzlT
X-Google-Smtp-Source: AGHT+IF1XO4+uDzRlH3ZwrLK6nskExOmf3XhHC5T733GHRIqNJ3rjru6JdVYrgJp7oaq9blikUJbFA==
X-Received: by 2002:ac2:4e08:0:b0:52e:7f6b:5786 with SMTP id 2adb3069b0e04-536ad3f7dcdmr1124478e87.61.1726836343854;
        Fri, 20 Sep 2024 05:45:43 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:1201:c434:b5b1:98a6:efed? ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb492a1sm7161716a12.8.2024.09.20.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:45:43 -0700 (PDT)
Message-ID: <c247b5dab409475633ea8dac5ad23fb75aecb1ef.camel@gmail.com>
Subject: Re: [PATCH v3 01/10] iio: backend: adi-axi-dac: fix wrong register
 bitfield
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Date: Fri, 20 Sep 2024 14:45:42 +0200
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-1-a17b9b3d05d9@baylibre.com>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-1-a17b9b3d05d9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-19 at 11:19 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Fix ADI_DAC_R1_MODE of AXI_DAC_REG_CNTRL_2.
>=20
> Both generic DAC and ad3552r DAC IPs docs are reporting
> bit 5 for it.
>=20
> https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Ouch... Missing Fixes tag. With that,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/adi-axi-dac.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index 0cb00f3bec04..b8b4171b8043 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -46,7 +46,7 @@
> =C2=A0#define AXI_DAC_REG_CNTRL_1		0x0044
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_SYNC			BIT(0)
> =C2=A0#define AXI_DAC_REG_CNTRL_2		0x0048
> -#define	=C2=A0 ADI_DAC_R1_MODE		BIT(4)
> +#define	=C2=A0 ADI_DAC_R1_MODE		BIT(5)
> =C2=A0#define AXI_DAC_DRP_STATUS		0x0074
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_LOCKED		BIT(17)
> =C2=A0/* DAC Channel controls */
>=20


