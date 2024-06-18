Return-Path: <linux-iio+bounces-6456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67590C806
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 12:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781B21C21C49
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B708C1D0555;
	Tue, 18 Jun 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA3cdHof"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB86713E8A0;
	Tue, 18 Jun 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703213; cv=none; b=PrLQWGBzXDCD9i65BubDuqDF2qyDuUS8wH/7fV3pdYHoTxFphsaNCzr0NHt3JJO5FVj4JyCljVJsih0fASFh7Ljggckpnx6OgJLlkYsoeK5Rnq/T2fpJPKIM1HHR5Ds6wejqZ+GjvHcGhZwCReB6b4raAOnw15Ots+Ln+U95Vlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703213; c=relaxed/simple;
	bh=j3q+EyogCgVnNt16mW7TglpR7ZsBC59ypAKFPs0xJi0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVrtIn4dt1+tvTs6y9zXe1xIs+3YYkjin8ZCGb17/ot0tiPSTPcagXr7Ln4qV66A71gFvh2C8A+fZfuIK4Q/eBGfsEp2P6j9NB53DtZkWTh/1GPRON3AEl1uGlTU8islWWpeKPA5Rez4K6qBIpV20P3NVctqIRfFKzHCfO58Fg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA3cdHof; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so6216656a12.0;
        Tue, 18 Jun 2024 02:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718703210; x=1719308010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKRTOK2bSqh5Z6l772n9bon7J4PO0h3RG9G4nJvBISU=;
        b=lA3cdHofgiN4fsfYQVRhcYhVwPj7UwDVCsE6FzGQXF31IL1iQY8Fd/ahXZoPxeMMoP
         YKtqdte3QaDQqou9Q23U454f4SN5leaQQxjsPqzcFJGUdxmJK5HDb+6yUytrB7WklDuC
         fOCHitP6h3AzSqyUStjEch73u4nq1ELN2ZcVkaCIiejQ1OmEgpMa6Lezv8ZMA82X+YDp
         AP3igfnu7VQJciv95siW9Iwn5jRd0RSsKMjec795CWjiqTUZ6Qv2yVUIbC92grdgP2sh
         plKQagy/OH/vDECosbVcRoxj90+gQc+bBwYh7mzozilDNm8uA6UeAF14IFjhrO0KCGHF
         hvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718703210; x=1719308010;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKRTOK2bSqh5Z6l772n9bon7J4PO0h3RG9G4nJvBISU=;
        b=GXqcOR5N0LGmMdT3UNRtgSekA6LLrDE449Oua+DkVZ8fpvsOlx5VwF/0Udc1Qxx20w
         FpbUZXJUKUnMmDPZOghWgw4OL5JG4mdBLLMa2JD8IS3bEWlpTUG9GiqeVLXGDm4sJrY4
         0AMJuZVJOvBY50l/S+Ngq1FAAV70tXovs1SK6wA/M8w/+JEkLBbUMd1PcIQt/jGyQirr
         CjJO8oCYv7Z8KxpnkCPc21M9h1skmKc4DaN34WTa080X0ggN9PLHfgrZSx8gxTNGuszt
         ceRnN5x+SPBM2T7zQgNAlf09kzC6nPcFZOnA5phCrgWMbXl5fRlB92Foko+CsfTBhhjv
         Qdyw==
X-Forwarded-Encrypted: i=1; AJvYcCVfOYCkXxQIZnhPPR1I1Qva9pYQHmbJJ+DuXIPqJBJanwk3XHiYgkjzb9V2sJk+F/QXISDjROJnrsCPkHK1CXue8JQvwveOzj9sNeGxDJjCrsVrDscFH2AtksW8wFNDqzKf2ZQ2u7KUY2ex8tfAnHQXKFDNG8LmcB8nDO9C41RqLIAuzEkb9AjdELXpzwZZmUXnIKiQqOQ8DvK0gvUBtA==
X-Gm-Message-State: AOJu0YwiYh7x+yOOcQOaaSoJVtRIYUysADndCb72tw01nQK1v2YU9fJa
	w71s9MeFkXdq3U55SMY8H+u7E5neTXrvTvlexOiKTG662u/UfnQX
X-Google-Smtp-Source: AGHT+IEB0BWx8Gj3AqMac+0Q3+79Cqy6S3VtrMg68UFlYb+8zqogyYLFBFzCgacmNDYh6M7QeyxJtw==
X-Received: by 2002:a50:8746:0:b0:573:5c4f:27a8 with SMTP id 4fb4d7f45d1cf-57cbd8e7144mr8081205a12.35.1718703209873;
        Tue, 18 Jun 2024 02:33:29 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb7439606sm7526102a12.90.2024.06.18.02.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:33:29 -0700 (PDT)
Message-ID: <d35eea56bfef394717611ac43c4e02cd4c813380.camel@gmail.com>
Subject: Re: [PATCH v5 2/2] iio: frequency: adf4350: add clk provider
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>,  linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date: Tue, 18 Jun 2024 11:37:18 +0200
In-Reply-To: <20240618082012.4496-2-antoniu.miclaus@analog.com>
References: <20240618082012.4496-1-antoniu.miclaus@analog.com>
	 <20240618082012.4496-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 11:20 +0300, Antoniu Miclaus wrote:
> Add clk provider feature for the adf4350.
>=20
> Even though the driver was sent as an IIO driver in most cases the
> device is actually seen as a clock provider.
>=20
> This patch aims to cover actual usecases requested by users in order to
> completely control the output frequencies from userspace.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Hi Antoniu,

For some reason your DT patch is missing (or still did not arrived)... Some
comments below.

...
>=20
> +static int adf4350_clk_register(struct adf4350_state *st)
> +{
> +	struct spi_device *spi =3D st->spi;
> +	struct clk_init_data init;
> +	struct clk *clk;
> +	const char *parent_name;
> +	int ret;
> +
> +	if (!device_property_present(&spi->dev, "#clock-cells"))
> +		return 0;
> +
> +	init.name =3D devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
> +				=C2=A0=C2=A0 fwnode_get_name(dev_fwnode(&spi->dev)));
> +	if (!init.name)
> +		return -ENOMEM;
> +
> +	if (device_property_read_string(&spi->dev, "clock-output-names",
> +					&init.name))
> +		init.name =3D spi->dev.of_node->name;

So this means the first devm_kasprintf() is useless :). I believe this shou=
ld be
=09
	init.name =3D devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
				   fwnode_get_name(dev_fwnode(&spi->dev)));
	if (!init.name)
		return -ENOMEM;


> +
> +	parent_name =3D of_clk_get_parent_name(spi->dev.of_node, 0);
> +	if (!parent_name)
> +		return -EINVAL;
> +
> +	init.ops =3D &adf4350_clk_ops;
> +	init.parent_names =3D &parent_name;
> +	init.num_parents =3D 1;
> +	init.flags =3D CLK_SET_RATE_PARENT;
> +
> +	st->hw.init =3D &init;
> +	clk =3D devm_clk_register(&spi->dev, &st->hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret =3D of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_get,
> clk);
> +	if (ret)
> +		return ret;
> +
> +	st->clkout =3D clk;
> +
> +	return devm_add_action_or_reset(&spi->dev, adf4350_clk_del_provider,
> st);
> +}
> +
> =C2=A0static struct adf4350_platform_data *adf4350_parse_dt(struct device=
 *dev)
> =C2=A0{
> =C2=A0	struct adf4350_platform_data *pdata;
> @@ -522,8 +637,6 @@ static int adf4350_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	indio_dev->info =3D &adf4350_info;
> =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> -	indio_dev->channels =3D &adf4350_chan;
> -	indio_dev->num_channels =3D 1;
> =C2=A0
> =C2=A0	mutex_init(&st->lock);
> =C2=A0
> @@ -551,6 +664,18 @@ static int adf4350_probe(struct spi_device *spi)
> =C2=A0			return ret;
> =C2=A0	}
> =C2=A0
> +	ret =3D adf4350_clk_register(st);
> +	if (ret)
> +		return ret;
> +
> +	if (st->clkout) {
> +		indio_dev->channels =3D NULL;
> +		indio_dev->num_channels =3D 0;
> +	} else {
> +		indio_dev->channels =3D &adf4350_chan;
> +		indio_dev->num_channels =3D 1;
> +	}

nit: The above could be simplied to
if (!st->clkout) {
	indio_dev->channels =3D &adf4350_chan;
	indio_dev->num_channels =3D 1;
}

- Nuno S=C3=A1


