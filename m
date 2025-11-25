Return-Path: <linux-iio+bounces-26457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6FAC85F19
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 17:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61E1C4E4191
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4529723D2A3;
	Tue, 25 Nov 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0QkPZLY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE2235045
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087719; cv=none; b=nGR4YHVgmc0SivUDGhyRAZliJ2RKclRNCgIEKnn0WfAFzSBiVeQ0KtoazZ6lqA3AUJFzCzDORQtOc+P/zet54nuwpJzElBfzUNS+RR74BQKWNcdAOmPDMevIeva/8JnByYzkXH4fZsoQu27LcnfR8iDc8oa8BvPemJbm07f4070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087719; c=relaxed/simple;
	bh=gsqoBe/P+gDXSg+Co7lmatw2lDoEMGYKSHIr2hmgxPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcXh4384hAi+qR8POUKeUPBbTdwOQmF22u4n8I4A9FngOJySDTPB9kxEI/QbU6Yx/33LA02sweq7D56Od021Xyptmdg1VFMTLXJTJKRwV66OD979qGlcI1G51IsvrfAwFNDDZqphICd/640QTbi16yx2dGMX2Dt8RIhXU+kYdys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0QkPZLY; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b73a9592fb8so173872566b.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 08:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764087715; x=1764692515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJkq02ikHZSwRsClVSJ/tPC8U25hKZKbxH46PlYpMBA=;
        b=d0QkPZLYaJsJ87+/2GO4+X2kiuBsO9o9WOxXHmlML8zuMabRzTFHckZU991VXIS9B/
         AEkm9AwM8748Idl6rj1n9WuX+fhUkb+mEXyPwvXjDwXmF+axyC1t51a3q+fLuGHyQTvM
         2Qe9npu7vqDsOSEOiZeBBaC9XRSRWsxayfiPeU5fQTWZbUB/XzE0OQA5fO8HQU1QEkaf
         1Mytp5Sfo14janC7gI1Zw1roefFLDexQ/Ds+X/tdlUMtjfmQxjfHi+jmS6FJu1etX3uN
         s7J4Z329ta8feuzPEHUsbo1llMgV4DHlGCZgd8QW9zSKhTsmYQYnx7YVeD+CddqLd6J/
         WFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087715; x=1764692515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eJkq02ikHZSwRsClVSJ/tPC8U25hKZKbxH46PlYpMBA=;
        b=FXo9eRpz3tUWyAffCaZIy3lW+ucKhrWjonxdXYFqQWEGio1O5MUA7qStdBmUUj7lgP
         Kc0gdkN0V/ntq6r1R3ua9g9MD0pzFiIvXzqZipUaQsF69nwHPuWxVSwFfbe6DOFmmcR4
         jo8gz/3iWcjgdsTIWY0ehYtwF7hicg+1hlvZGshKhz4WHVICF4OUSovS7QRtstGT/Hbo
         Gi7jx0m3AOR75mfUQdzKwC0SMeMF/BpND552Vgoy/m2ZSgFBdVsp66edsHn2B5Nepvoo
         8mUGUekw7kWTYQpiEY1i0cFi0vdcaKGu1l1lZm0ABp9113Izz/rRiprZUpF8G6Loz0HD
         Y5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOJdZ7ZvMWIEPtfR37MQqTl7/y2fMHg66F8BMWw77xvqycb2Mr69G/VQsAp32+XoIsvheJ4lLWJ7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJcGsQp0h0V5YznrkwWPYXIK90XDdmw6J/8lmqTnj1AbQdA9n
	MdYl97liUzm47JkuxunGsb3xSbIVDhqN3590Gy/jiIJnLtvKQK0NaichXHFCXrhrGfthtnhKRZN
	IodpcQBdkJATwOWCIDq/nmgwvg5tnaRs=
X-Gm-Gg: ASbGnctWbUEtT8NQaWoM0iTohWt7I9cKSKynqWQKlbCgdukDJMqxsj27Db1HTst2iN5
	yQndlHUtUMKEn+gfRJ/ZZbBOgYVxbI83lpRF+77d3E+LsEGi9Hd7oCcD+OcTHhUBtU8iOYVblzl
	zQZfvHsAfFJZ7HZonS8Z8CHSzNwozx48cWn2i2/nAyegLw2j/5HBwlFiI43q49hRv5Ca/kFLtuK
	Ia7hkJmrTUs45VSj+HpSRhqnSIBGeaXl95kNqywG16P2k3Mix5RnCdftD2glx9T1gBRH0qSHWzo
	yqzalWM5+9XPG5i+wK7E5aRmmk+VJ1aVrXZjR6XRB/HQeTif2ifxCOEy3tEydCKDxLzJuPw=
X-Google-Smtp-Source: AGHT+IFaTuSNKW949J7wt7ryuKboB6N1PqIuF4iN44UphE8qw1LNveP1OKQkxeS5iDn3VJkMetN5CqPzDk1CBYMFVQY=
X-Received: by 2002:a17:907:3da4:b0:b70:b9fe:aa56 with SMTP id
 a640c23a62f3a-b766ef467f7mr1852708166b.20.1764087715095; Tue, 25 Nov 2025
 08:21:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125154738.55869-1-antoniu.miclaus@analog.com> <20251125154738.55869-3-antoniu.miclaus@analog.com>
In-Reply-To: <20251125154738.55869-3-antoniu.miclaus@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 25 Nov 2025 18:21:18 +0200
X-Gm-Features: AWmQ_bmmTaf3QFSVuCUpoe3z9y2Yzukb3QzUTHbBjNW8T7W_p12_sn3XyqS2VAw
Message-ID: <CAHp75VdGfrbFdqgaSE1dVR-h6p3Ju6EuvsX-cAh_JVJiTmknRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: frequency: adf4377: add clk provider support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 5:48=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> Add clk provider feature for the adf4377.
>
> Even though the driver was sent as an IIO driver in most cases the
> device is actually seen as a clock provider.
>
> This patch aims to cover actual usecases requested by users in order to
> completely control the output frequencies from userspace.

...

> +static int adf4377_clk_register(struct adf4377_state *st)
> +{
> +       struct spi_device *spi =3D st->spi;
> +       struct clk_init_data init;
> +       struct clk_parent_data parent_data;
> +       int ret;
> +
> +       if (!device_property_present(&spi->dev, "#clock-cells"))
> +               return 0;
> +
> +       if (device_property_read_string(&spi->dev, "clock-output-names", =
&init.name)) {

I would rather split this to two

  ret =3D device_property_read_string(...);
  if (ret) {
    ...
  }

which makes the intention more explicit, otherwise it's not clear what
the return values are and what you do with them (since I know it's
int, the rule of thumb to assign to int variable and check it, for
boolean it's fine to do if (boolean_fn(...)) in the code).

> +               init.name =3D devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-c=
lk",
> +                                          fwnode_get_name(dev_fwnode(&sp=
i->dev)));

%pfw / %pfwP

> +               if (!init.name)
> +                       return -ENOMEM;
> +       }
> +
> +       parent_data.fw_name =3D "ref_in";
> +
> +       init.ops =3D &adf4377_clk_ops;
> +       init.parent_data =3D &parent_data;
> +       init.num_parents =3D 1;
> +       init.flags =3D CLK_SET_RATE_PARENT;
> +
> +       st->hw.init =3D &init;
> +       ret =3D devm_clk_hw_register(&spi->dev, &st->hw);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_of_clk_add_hw_provider(&spi->dev, of_clk_hw_simple_g=
et, &st->hw);
> +       if (ret)
> +               return ret;
> +
> +       st->clkout =3D st->hw.clk;
> +
> +       return 0;
> +}

Otherwise LGTM.

--=20
With Best Regards,
Andy Shevchenko

