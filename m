Return-Path: <linux-iio+bounces-5407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2C18D2112
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 18:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC81C2130F
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087617277F;
	Tue, 28 May 2024 16:02:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF419170834;
	Tue, 28 May 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912146; cv=none; b=A2o7ts+zIJZTEsD2q6C7rEMKt+q/UTM50xJyk1Ux8afNJkyPdfBATHA8JbmDq8Hymx4gD87mFVWJ0xEz+r55RmLEZu233q1D/87v7+1BudLZFAIrsmWzNm5xGjL7U6F5a7r35FhpMsn0f2NlkjeAH0BHGiGXhPg1W21dn5Sn92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912146; c=relaxed/simple;
	bh=PVuj5rFCliF+u/3zJ7QQt1qiJY877vkoKGoL5TRFv4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bygvovvc3CgMFBYXlNwhXB0ApuE03t4EC4NSwXMFBe81jIj/0lKG1sEpbbH2a7NKQhKKwLHIfCmkexULd6vmGDGAbn4PAUoc2Ecn9UG1g1uITYizJat3B39x77gyiyQtjSjF8+M9zA2yKmZoR+vEPuu/OnVpHkG8n6RdUrzVMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-529c0d5001eso84489e87.3;
        Tue, 28 May 2024 09:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716912141; x=1717516941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rW1DfIrslvUajUL20RbbzHp2H1UTzX7uBVMdLPKtXew=;
        b=fJwru1AT+/SNjGpNVtu4t3VHNASZbUiNQGc3c8Og1ep4dD4Gf7VxOLW9XrTrfR1nlw
         wiTBYoE8fgY/MaIgMs2Rtlvv1Yhv4/tQu2FFPD2cgdw+EkKib2+810BWEOMxbYdpplrn
         4dWSsx96fBYWhmDnlY8P8byZ6obhZZnTeSLKBGeMIyQ2gaIxRixZDvRcLrUJPco2dRFp
         C+SonjyNTT6MEG5RhsjwOIu07lI7BCWuYyGRMnAzD9l/e21ioAF23zyJyggR7POy3e7E
         n05Glq5aDh7OgEQmq1fWUGUOIQVbOdHCSBn0ShtsP73JofjZRk9neloM6FmCVDe0Y3Yl
         oYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2yTLFzsJ74vAAtGjX9OwdvnfE6M+3Xfu7PWgXkYBEBSwu161GjJJDNg+BgZ6aG6LDFw2DMHJbY4u8ObDWoCpeRWTodd6GIT78Zh85pXFoMFLKNlRxGIYW+ywBQfZP61328x05Piquu/fo/bCE8vOmupuxSN4VqYTE5x7CJjFIpg==
X-Gm-Message-State: AOJu0YwNCjPCN/Rzy/5PDQvi5QONA5v2M0cJ5ypB+fhcGnGZtKiee8TE
	p9avlrBlKmm8WoX64Py3ySoSLoliTfVAaMnYaBL03UZ4bMgZqptSfVfJJqZs
X-Google-Smtp-Source: AGHT+IFQ7Ydi4Lg+WTCN1mn5oj0ezWIcV48Y2f46NOHYHwOey7iAWrUZ7wC+HgbZBjB5zmLkhWBz9g==
X-Received: by 2002:ac2:4daa:0:b0:521:e065:c6c5 with SMTP id 2adb3069b0e04-529647d813bmr7874110e87.11.1716912140890;
        Tue, 28 May 2024 09:02:20 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529a6228409sm736068e87.238.2024.05.28.09.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 09:02:20 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e964acff1aso10358501fa.0;
        Tue, 28 May 2024 09:02:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7krnp+JjW2kiR9R+Nlvkq7sycy/rTe1yfHHCAw8uFvrBsi0h/pBhhARs+RsRlvPz0eCcGX0llGSe0vSE72PMzLHjiqWwSoUn6NR/dMPUWdYv59yEkqKmI6MzSrlgshsNBkTXD9oixA1YcYYwI2oaVQUduhKeBEksDKNKzy8l2Hw==
X-Received: by 2002:a05:651c:234:b0:2e9:8471:f88e with SMTP id
 38308e7fff4ca-2e98471fd3cmr25105761fa.19.1716912140547; Tue, 28 May 2024
 09:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417170423.20640-1-macroalpha82@gmail.com> <20240417170423.20640-2-macroalpha82@gmail.com>
In-Reply-To: <20240417170423.20640-2-macroalpha82@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 29 May 2024 00:02:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v67rqiCA=fwk9USr4-xh3uRGxQ-p_f+--Ui5vVBnb10QQA@mail.gmail.com>
Message-ID: <CAGb2v67rqiCA=fwk9USr4-xh3uRGxQ-p_f+--Ui5vVBnb10QQA@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: sunxi-ng: h616: Add clock/reset for GPADC
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, p.zabel@pengutronix.de, 
	sboyd@kernel.org, mturquette@baylibre.com, samuel@sholland.org, 
	jernej.skrabec@gmail.com, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:04=E2=80=AFAM Chris Morgan <macroalpha82@gmail.co=
m> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Add the GPADC required clock and reset which is used for the onboard
> GPADC.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.c      | 5 +++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.h      | 2 +-


>  include/dt-bindings/clock/sun50i-h616-ccu.h | 1 +
>  include/dt-bindings/reset/sun50i-h616-ccu.h | 1 +

These need an Ack from the DT binding maintainers. And it's better to
split these into a separate patch.

ChenYu

>  4 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-n=
g/ccu-sun50i-h616.c
> index 21e918582aa5..3646be2b88ab 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> @@ -489,6 +489,8 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", ts_pa=
rents, 0x9b0,
>
>  static SUNXI_CCU_GATE(bus_ts_clk, "bus-ts", "ahb3", 0x9bc, BIT(0), 0);
>
> +static SUNXI_CCU_GATE(bus_gpadc_clk, "bus-gpadc", "apb1", 0x9ec, BIT(0),=
 0);
> +
>  static SUNXI_CCU_GATE(bus_ths_clk, "bus-ths", "apb1", 0x9fc, BIT(0), 0);
>
>  static const char * const audio_parents[] =3D { "pll-audio-1x", "pll-aud=
io-2x",
> @@ -807,6 +809,7 @@ static struct ccu_common *sun50i_h616_ccu_clks[] =3D =
{
>         &bus_emac1_clk.common,
>         &ts_clk.common,
>         &bus_ts_clk.common,
> +       &bus_gpadc_clk.common,
>         &bus_ths_clk.common,
>         &spdif_clk.common,
>         &bus_spdif_clk.common,
> @@ -940,6 +943,7 @@ static struct clk_hw_onecell_data sun50i_h616_hw_clks=
 =3D {
>                 [CLK_BUS_EMAC1]         =3D &bus_emac1_clk.common.hw,
>                 [CLK_TS]                =3D &ts_clk.common.hw,
>                 [CLK_BUS_TS]            =3D &bus_ts_clk.common.hw,
> +               [CLK_BUS_GPADC]         =3D &bus_gpadc_clk.common.hw,
>                 [CLK_BUS_THS]           =3D &bus_ths_clk.common.hw,
>                 [CLK_SPDIF]             =3D &spdif_clk.common.hw,
>                 [CLK_BUS_SPDIF]         =3D &bus_spdif_clk.common.hw,
> @@ -1021,6 +1025,7 @@ static struct ccu_reset_map sun50i_h616_ccu_resets[=
] =3D {
>         [RST_BUS_EMAC0]         =3D { 0x97c, BIT(16) },
>         [RST_BUS_EMAC1]         =3D { 0x97c, BIT(17) },
>         [RST_BUS_TS]            =3D { 0x9bc, BIT(16) },
> +       [RST_BUS_GPADC]         =3D { 0x9ec, BIT(16) },
>         [RST_BUS_THS]           =3D { 0x9fc, BIT(16) },
>         [RST_BUS_SPDIF]         =3D { 0xa2c, BIT(16) },
>         [RST_BUS_DMIC]          =3D { 0xa4c, BIT(16) },
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h b/drivers/clk/sunxi-n=
g/ccu-sun50i-h616.h
> index fdd2f4d5103f..a75803b49f6a 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
> @@ -51,6 +51,6 @@
>
>  #define CLK_BUS_DRAM           56
>
> -#define CLK_NUMBER             (CLK_PLL_SYSTEM_32K + 1)
> +#define CLK_NUMBER             (CLK_BUS_GPADC + 1)
>
>  #endif /* _CCU_SUN50I_H616_H_ */
> diff --git a/include/dt-bindings/clock/sun50i-h616-ccu.h b/include/dt-bin=
dings/clock/sun50i-h616-ccu.h
> index 6f8f01e67628..ebb146ab7f8c 100644
> --- a/include/dt-bindings/clock/sun50i-h616-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-h616-ccu.h
> @@ -112,5 +112,6 @@
>  #define CLK_HDCP               126
>  #define CLK_BUS_HDCP           127
>  #define CLK_PLL_SYSTEM_32K     128
> +#define CLK_BUS_GPADC          129
>
>  #endif /* _DT_BINDINGS_CLK_SUN50I_H616_H_ */
> diff --git a/include/dt-bindings/reset/sun50i-h616-ccu.h b/include/dt-bin=
dings/reset/sun50i-h616-ccu.h
> index 1bd8bb0a11be..ed177c04afdd 100644
> --- a/include/dt-bindings/reset/sun50i-h616-ccu.h
> +++ b/include/dt-bindings/reset/sun50i-h616-ccu.h
> @@ -66,5 +66,6 @@
>  #define RST_BUS_TVE0           57
>  #define RST_BUS_HDCP           58
>  #define RST_BUS_KEYADC         59
> +#define RST_BUS_GPADC          60
>
>  #endif /* _DT_BINDINGS_RESET_SUN50I_H616_H_ */
> --
> 2.34.1
>

