Return-Path: <linux-iio+bounces-10116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A129904A8
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 15:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1D71C213B1
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889112101AA;
	Fri,  4 Oct 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhkjGeX5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD001D5ACD;
	Fri,  4 Oct 2024 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049309; cv=none; b=JB2sV4kKMgGBcT4pJgVNavf3M8Y5SsGMGb0AiYilWc7ESZfwT1Gb8rAJS05iJHID32CYvosjdl/BJ6IQAMCYnfEAeUWmx7OIhBRVN+xgRcDLunxKJPtJmspBtL37zBCYchRHOmjr7ZIUY37kDRzydlXtCJ3T+nbFtxNYqX5VMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049309; c=relaxed/simple;
	bh=LYDX20T11oTAkXiIWin0BvpWWVUQQxkjYtmeZYuwNbk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWcbGMmcwTaznbFje/UWBDeW9axPxhQBixLv0xeBq2wQxCppYq64seXue03XYWPdRv5iSkUl9NIPqEQteLdBVkiSiIsmH4Bhlhiv8ipNX5HAT0HYkGc6HH9aQVn+hkDaDhoWCrwzCb+6AkbMy0jZGxCTG/BBh3xU5+gRuWoXhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhkjGeX5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ccd50faafso1560163f8f.3;
        Fri, 04 Oct 2024 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728049306; x=1728654106; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TtPETmw7YzlFheFDK0xFqJOzi5ALYhNaiimnRlYGnho=;
        b=KhkjGeX5EyDJ1fqgedbjOBbjSLDSBwVCwBcV6WmO9Sy8wvmWgeXVYctEbpHQWgNV82
         HMII9l4lPtJaUkgvAeXAHfxYsDntv3XfSJ1vG+smhNj+pDgEjbzVLY/pGnvsW+6+Dr4R
         H8hBP0v5lCW0iM8NJQLLs9MEupQFvu2Wd+u6GWW8ge6w5Iz0wWLrR8038XmwKBono4yq
         B17rRZbmX5p/kJbU1P9TiWWKnrUgPssDcj6h1nnH3YqmA1SgGQLYrtyS6ufTs867W0Kd
         WXTOgjE2vZiGOVCTtX4u5CnAlZIjsIP9vXB+/XU7wLhukHvipLipmOILTxqOpA6jdTdD
         /Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049306; x=1728654106;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtPETmw7YzlFheFDK0xFqJOzi5ALYhNaiimnRlYGnho=;
        b=uQ3YIAXzaaLWid2n+ASz/rDe0wPAcSsUuDBzvQttR7pujiP7ampb/j+f8FIBBQ/qF+
         fGFD+OA+8BG0D6KMFbA71CjdGkc672Gu/0D1RzyB42k6Z9O0T8JT/TP+EsUdFWkepnhD
         KyqYjKPtPlXDWcihHDxtQJ7/Vz5GZzmH7pPYkYbPj6s0Lua1ZpX147Wy8S7HdkDNH7k+
         LYTDZBneHERVv1TZ8kieA/u8IE0+pq8yzexPfpbbyZfd2qNuYPaQscNxF9hNZhygBAty
         WmMcSetrMEuEGC8LgD6kr3u6m4faHoaa2deopLF+SJQ2wNvW1uWhdRQPkJU6Lqq1IlmI
         M03A==
X-Forwarded-Encrypted: i=1; AJvYcCV0bex+GPn2GBr75CCyza1tZU0uCR5YVSYMsEebEzu05dGRtMqm61O9VZOuEj60kJ7LI8Yth46tsHcpAYLY@vger.kernel.org, AJvYcCXT/PKS5F42DZ3/G+Oc6G76B+teMxSt5XlPijDwgQPrrpnuS9KSfTSNmBX1qvKWoWpaLK/0zInI0iSm@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7ZB2YbMQHBQ4BKa9AeOweCmQ7sRs5JAj7BQST8AtkyMLsWAK
	ONXsF5Il1YXVrFL1TVzCEA8AUT9EFrCHSph7XhhoQhAJ7xFPvaWv
X-Google-Smtp-Source: AGHT+IHqD2bdoPdi+t0MPBoSOOzuYBARrS14pjEYuEfHFqsh5TfjoaZ/UoDdVNB9jU9Ke/rWwj3VkQ==
X-Received: by 2002:adf:f00b:0:b0:37c:c5b6:ec2e with SMTP id ffacd0b85a97d-37d0e7d43bamr1875485f8f.46.1728049305631;
        Fri, 04 Oct 2024 06:41:45 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f7141sm3322495f8f.6.2024.10.04.06.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:41:45 -0700 (PDT)
Message-ID: <8def18e29299ea220d684bb6c963831071fded68.camel@gmail.com>
Subject: Re: [PATCH v4 07/11] iio: dac: adi-axi-dac: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mihail Chindris <mihail.chindris@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, 
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Date: Fri, 04 Oct 2024 15:41:44 +0200
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-7-ceb157487329@baylibre.com>
References: 
	<20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
	 <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-7-ceb157487329@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-03 at 19:29 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Extend AXI-DAC backend with new features required to interface
> to the ad3552r DAC. Mainly, a new compatible string is added to
> support the ad3552r-axi DAC IP, very similar to the generic DAC
> IP but with some customizations to work with the ad3552r.
>=20
> Then, a serie of generic functions has been added to match with
> ad3552r needs. Function names has been kept generic as much as
> possible, to allow re-utilization from other frontend drivers.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/dac/adi-axi-dac.c | 278 +++++++++++++++++++++++++++++++=
++++++++---
> =C2=A01 file changed, 264 insertions(+), 14 deletions(-)
>=20
>=20

...

> +
> +static int axi_dac_read_raw(struct iio_backend *back,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int err;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY: {
> +		int clk_in, reg;
> +
> +		if (!st->info->bus_controller)
> +			return -EOPNOTSUPP;

Since we'll likely need a more explicitly flag for requesting the reference=
 clock, I
think that can be used in here and so, replace this one. Sorry for suggesti=
ng this
one. More details below...

> +
> +		/*
> +		 * As from ad3552r AXI IP documentation,
> +		 * returning the SCLK depending on the stream mode.
> +		 */
> +		err =3D regmap_read(st->regmap, AXI_DAC_CUSTOM_CTRL_REG, &reg);
> +		if (err)
> +			return err;
> +
> +		clk_in =3D clk_get_rate(st->clk);
> +

I don't think the rate is likely to change (at least for now it does not ri=
ght?). So
we can cache the rate during probe (and then no need to save the struct clk=
).

> +		if (reg & AXI_DAC_CUSTOM_CTRL_STREAM)
> +			*val =3D clk_in / 2;
> +		else
> +			*val =3D clk_in / 8;
> +
> +		return IIO_VAL_INT;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>=20

...

> =C2=A0
> -	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> -	if (IS_ERR(clk))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> +	st->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(st->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(st->clk),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get clock\n");

I think this is wrong. If we look at the docs [1], the clock we want in ord=
er to
calculate SCLK is the dac_clk which should be the reference clock. The cloc=
k we
previously had in here is the axi clock (s_axi_aclk in the docs) which is t=
he axi bus
clock so we can read/write registers. So, before we had no clk_name before =
we only
had one clock but now you need proper names for the clocks. For the axi clk=
, we can
keep a local clock and just make sure we enable it. For the new dac_clk (as=
 named in
the docs), you need to get it only if the IP needs one. And I'm not sure at=
tach the
clk need to the bus_controller flag is a great idea... So I would replace t=
he
bus_controller flag with an explicit has_clkin or has_dacclk (something alo=
ng those
lines) and use that to request (and enable) the extra clock conditionally.

[1]: https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
- Nuno S=C3=A1

