Return-Path: <linux-iio+bounces-9753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025DE9846EF
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 15:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEBB1F23537
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B5D1AAE2D;
	Tue, 24 Sep 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JK1VvNao"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BD1AAE0B
	for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185375; cv=none; b=XpMEeV3uPI95ydjL+AA4qwuKsjm35w/R5Bmb966UVtHIn4PsuKaGza8MHa98+doAygCoA/xcbYpHKLBmckwpm+ban1mib+L5GNg8+bluN4XOkEYhQAaFK4YdOaC3+6ntDGCjTjXIXTO2KjUclwXmftrlvpx25WMqr/9lzgo/1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185375; c=relaxed/simple;
	bh=JBAqJKIn6erssC6h7Fru/SUmSHqFjR15KojsKwYgo9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWQsgAc4YrEeffKHHtGXPO22ceDIZCjVe6Q6kJtUoDdKp7auOYtdQ780rAbzPfq5xQWUVn/rBgCM8DCtWaivKNk5BV122RjwV7st2S1G8/Vm7LHWpvFuXnZ5MXXdSoGFJw3XVwM0Ly+RPUeJR3eKmYLjsAdr+88VL8M6llnGrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JK1VvNao; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso56415191fa.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2024 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727185371; x=1727790171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c1M7ohqRDqRP9lr59f4TBK5eNeNiABegCv0HpvHngk=;
        b=JK1VvNaoudfAypA/xNo4Pr3cBLv486zmTOrbFGqs8rm46fS/7ahtY3oDex05aLQkPm
         VdfgrvgNBjs4LRy5GtxJh22zPzLBAFPwyJgxT9VliXtk+WhIYW7WK18AtcLaTSOefyBy
         Ww3MyjwiVue8mNtkKOzU9ZF1DIvuer4dArmILwePVRgMMzNjxGyEHF6L81fCrX5nirfj
         LoofpFT/+qPf6NHNMLHvQkkgGnUp02pyhuV02RXAT+t7f3ZkCUrOkAq5+mqYSd/p0Fa3
         XkuaDvz/IlNz22EwRb/4UMND9rk4hEt15IOWSmKG2l2/lP0dNkkax19G79EMEie+jj/A
         BrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185371; x=1727790171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c1M7ohqRDqRP9lr59f4TBK5eNeNiABegCv0HpvHngk=;
        b=DCbg4JDU80wk/3i49ziflZgOQMpvJrFF6kLB4QhDuedegVY70xZSLMtNNA16947y/n
         RWU3YCXjUd+KH0c+Ue/fMmhdhhXA3SDE1f/BQhU/izGSIk1W0hmhLd1pG9zqki2OSRip
         QPheQV3RBrTQuMrHVIjQgJqw5WwbBp2O51CENxS+u02bU30uU5pWx/Ttp18wo40Ml50v
         Oq296y6KDegvwbXj30fj9pXexPwHYa/HpzG2eRh/FxKBZgeON+bn2/nqdLvruuTrlz8v
         9L7UGMIDedWf9MgBgU2iaIFq9n1IvCyvCk9UA+0d0s0wUo5tvsA4Vohav5xPxQWbojE8
         EGig==
X-Forwarded-Encrypted: i=1; AJvYcCWg/eGW4+Tb2QSRoFGjkbzV1dgqLny2qRxD4zpVfcTBbgSn2d1jWA4d/f8q9FePlr4PNmfhoVpecKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfbDLnoFKhdrK3Bu5rhDnZuogMUTaVcZkMq1dYm1UhewdNLUd
	NitNX9pkrq1cliLAQRXtnRnxshZNhdYe+GRRSy/g5oBTvQysXx/p4DXtNSmaZ/Gy1fgzbht8mjr
	M/4wDX1BvmOR/vHZiAsbyJhqfp7WoBAnd65M0Bw==
X-Google-Smtp-Source: AGHT+IFMCvX6ZomfwNVSQWZNrBg2XpB69scXfnzM6UFVXcdM7yblmJSqpExFckfnrrDnAlkTcnMFVsc76PzpIEqxbmM=
X-Received: by 2002:a2e:4c0a:0:b0:2f6:2b51:ee3e with SMTP id
 38308e7fff4ca-2f7cc5bb64emr56870301fa.41.1727185370526; Tue, 24 Sep 2024
 06:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923101206.3753-1-antoniu.miclaus@analog.com> <20240923101206.3753-6-antoniu.miclaus@analog.com>
In-Reply-To: <20240923101206.3753-6-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 24 Sep 2024 15:42:39 +0200
Message-ID: <CAMknhBE_RoDg+EhqF5+UbqV1z7i1PvVRi3HC48SAsR5AYDF6TQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] dt-bindings: iio: adc: add ad458x
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Marius Cristea <marius.cristea@microchip.com>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:17=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> Add devicetree bindings for ad458x DAS family.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad485x.yaml          | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad485x.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> new file mode 100644
> index 000000000000..5f5bdfa9522b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---

I think we could make the bindings a bit more complete (even if the
driver doesn't use everything yet). Some suggestions below.

> +$id: http://devicetree.org/schemas/iio/adc/adi,ad485x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD485X DAS family device driver
> +
> +maintainers:
> +  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Analog Devices AD485X DAS family
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
4858.pdf

Links for other parts? (I only looked at this datasheet, so some of my
comments below might only apply to this part and not the others.)

Since this is a SPI peripheral, we should add...

$ref: /schemas/spi/spi-peripheral-props.yaml#

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4858
> +      - adi,ad4857
> +      - adi,ad4856
> +      - adi,ad4855
> +      - adi,ad4854
> +      - adi,ad4853
> +      - adi,ad4852
> +      - adi,ad4851
> +      - adi,ad4858i
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply: true

Do we also need vee-supply (it can be a negative voltage or 0V)? Or is
vcc-supply the voltage between V_CC and V_EE?

> +
> +  vdd-supply: true
> +
> +  vddh-supply: true

Datasheet says V_DDL can be the same or separate supply as V_DDH, so
should probably also have vddl-supply: true.

> +
> +  vio-supply: true

What about reference supplies (REFIO and REFBUF)?

> +
> +  pwms:
> +    maxItems: 1

I suppose this is connected to the CNV pin? Probably worth adding a
description to say that since it isn't so obvious.

> +
> +  io-backends:
> +    maxItems: 1

For PD pin (power down):

pd-gpios:
    maxItems: 1

> +
> +  spi-max-frequency:
> +    maximum: 100000000

Datasheet says that minimum CSCK Period is 40 ns, so that would be
25000000 Hz max frequency.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +  - vdd-supply
> +  - vddh-supply

Datasheet says to tie V_DDH to GND to disable LDO, so it sounds like
vddh-supply should be optional, not required.

> +  - vio-supply
> +  - pwms
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0{
> +            compatible =3D "adi,ad4858";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <10000000>;
> +            vcc-supply =3D <&vcc>;
> +            vdd-supply =3D <&vdd>;
> +            vddh-supply =3D <&vddh>;
> +            vio-supply =3D <&vio>;
> +            pwms =3D <&pwm_gen 0 0>;
> +            io-backends =3D <&iio_backend>;
> +        };
> +    };
> +...
> --
> 2.46.0
>

