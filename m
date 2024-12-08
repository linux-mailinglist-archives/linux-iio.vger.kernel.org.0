Return-Path: <linux-iio+bounces-13256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4659E8784
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 20:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10190164410
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0DA18B477;
	Sun,  8 Dec 2024 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK3UZ0ra"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9CE22318;
	Sun,  8 Dec 2024 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733686952; cv=none; b=jZGix2xCovhq0GXLUYbrU8P78dYvQ+4Kq6aSfdkcU4sB1FSF/LGkiEnWXXm2UB4aud7EGXh72pbFHmEIBe5AOp+qP2tUZI+p7zNjLSiI+mWbeBQTodV2spUvGuA+byyadRVvWi3faX+N7q3Z23r41L9GJSPR7Cb3351h0ZO7Jlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733686952; c=relaxed/simple;
	bh=XGNgU+VmvHw4VDIxp/iNk9p7PBZ8WJRqSDMNMjlbAZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFOPV/5IyyCP5pXbjQO7gtPyNZX/G+u1awhndN58XByUSg1U1XHSXLHvTWgTv013KlirEaEahaid5MhbV3VpDHOn7TRiuQkfBFPFxI/9cpU6y+x3MtFWf7PdC6WxCym1Pd3DFo7vO8rtzFbjfbDcrwURrjdCk66fuD1PqM0PI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK3UZ0ra; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-518799f2828so57359e0c.0;
        Sun, 08 Dec 2024 11:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733686950; x=1734291750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtDNOiPMkwKya6aI4cfmRRKd3laQnqn0nZutH8e3Pls=;
        b=IK3UZ0ranngmWifn7DsTGJxsps1X2qEUqeNN2KpiHTYpOlj5NulSKmalDpBqvW3g8F
         IBlBbwr5/d3LWrPXkr/OxMLq/ZWrMl/qlaX6RfWNSQpDHNI1F5GAj1ly7vdwUhYkyYIF
         O1gUjIx6qchmEqZRGM54EkUQ7RlTGOYuZfr0f/lk9AS/hKFCTK3TBhX/Bt9Uiwm5fudf
         idymxYCrBDQyG7aqK4vWiUCZMmiiOs8mxsvx9Mb+E4xSRAvzq/SOXsYEHc/mmaqxiixH
         coURGJl9yDfuOCclg61ASeLlto9tHqFivABl+GqQgK++vakRUJEC2Lnnw+/gvhC5ZB2m
         sObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733686950; x=1734291750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtDNOiPMkwKya6aI4cfmRRKd3laQnqn0nZutH8e3Pls=;
        b=qKBf04HWxsB5Ep/Dcbg0/pu3Fq7hFTI8FNCovnsEmy9fjjGxu0gcdPntKlge6GCZGR
         eTJt6bH+CRWBjg0Rv8qK8GnenJOdrq7O9HCk/b9T49RD6Ims/ybHVgiWqxxy4GoasUiS
         F41oP5N3Nbc8E05zdsUtx8vhnbl2lXsBOkg95wYnDihwG3eSxmfzfzKMnedqrXLEcJgU
         6cO584luWtuTsmMxgecspDVF+EztuNwhGlhxj16JZolb/zrr2dxSoxAmKHtC5gMwSdXZ
         e8o6NtTcrcsXpzvXd0EnE9GfBHClw5SzqqRV8rXj3bfLFvDntIkqc0KhU+SFajfiItGm
         6lAw==
X-Forwarded-Encrypted: i=1; AJvYcCV4AGokJj/BBRnrNistO5zP3f344WlrT/4UfAjN5N0YgD+86/hKGw2giXMM1CzS3eBaSLcMkm/JRwCb@vger.kernel.org, AJvYcCVa1oLTuNdgQF2FCryb7eRCZGysTewf9+QoQluxD3oOR0bnkXeGENJZlygseeG46/N5qqewOPtA8biXTE8AZop371o=@vger.kernel.org, AJvYcCWCyXSXN6rs7MXvZdLi9+YaTHX85eLr8dLGUTaPzqX3dsBxLq5PRpoZ+8sq/Al8yTfvVgJSgGxfYSILBJM0@vger.kernel.org, AJvYcCWtra7CAPXYAStCxJTPvjIWWCukXhmG0Kdubq2PRhQwZdCTnQV6c9ckaeh4mIjZ87MVpR5QDneQnlIa@vger.kernel.org, AJvYcCXR8be9GyQ2xh/3/Hzo+VWvueMkOFDIh7gjylT7+KUEkdFlB33AWXCpqd32PIPI4TR6+pBMEyRwcfhD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aizvMaBXGLtPqEIOJ7hDa91oiBQjcDc5x+tQLfGW6EvFvnq1
	KFTGNl6mUy8bv+w7ytvmWLl4CmrDB122Uy+IN9FV4dycFgzQ6LqpBIcr9ARNFhx+7MeOVX8NOXU
	e0BQYGN9ZozovuNHXG2HjLoQoQA4=
X-Gm-Gg: ASbGncsAvyqAe43bY6TKq96EHIyGTTo6Cj8ukVOp256b2EZMnQAli1AStau4MI5q4tl
	B8rxXwxAGXLcB2mHX+BHEtsuSyJQF6iH3
X-Google-Smtp-Source: AGHT+IFLYWY8MBrf7lOCkYQeA2YG4FI7QdS3gf6cdia98iw8L6sA64jP38BgSxtln85j4i6i4YzPt4kG52zTVUaJY0I=
X-Received: by 2002:a05:6122:1d93:b0:50d:39aa:7881 with SMTP id
 71dfb90a1353d-515fc81c278mr10562706e0c.0.1733686949979; Sun, 08 Dec 2024
 11:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-2-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 19:42:04 +0000
Message-ID: <CA+V-a8tnjCWSzkuAnKpXV0CtjtFUr7Cy1LLYiHv94i5w6MVyEQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] clk: renesas: r9a08g045: Add clocks, resets and
 power domain support for the ADC IP
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:14=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add clocks, resets and power domains for ADC IP available on the Renesas
> RZ/G3S SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - rebased on top of the latest r9a08g045-cpg version
>
>  drivers/clk/renesas/r9a08g045-cpg.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9=
a08g045-cpg.c
> index 559afc417c6c..0e7e3bf05b52 100644
> --- a/drivers/clk/renesas/r9a08g045-cpg.c
> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
> @@ -187,6 +187,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[=
] __initconst =3D {
>         DEF_FIXED("OSC", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
>         DEF_FIXED("OSC2", R9A08G045_OSCCLK2, CLK_EXTAL, 1, 3),
>         DEF_FIXED("HP", R9A08G045_CLK_HP, CLK_PLL6, 1, 2),
> +       DEF_FIXED("TSU", R9A08G045_CLK_TSU, CLK_PLL2_DIV2, 1, 8),
>  };
>
>  static const struct rzg2l_mod_clk r9a08g045_mod_clks[] =3D {
> @@ -238,6 +239,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[=
] =3D {
>         DEF_MOD("scif4_clk_pck",        R9A08G045_SCIF4_CLK_PCK, R9A08G04=
5_CLK_P0, 0x584, 4),
>         DEF_MOD("scif5_clk_pck",        R9A08G045_SCIF5_CLK_PCK, R9A08G04=
5_CLK_P0, 0x584, 5),
>         DEF_MOD("gpio_hclk",            R9A08G045_GPIO_HCLK, R9A08G045_OS=
CCLK, 0x598, 0),
> +       DEF_MOD("adc_adclk",            R9A08G045_ADC_ADCLK, R9A08G045_CL=
K_TSU, 0x5a8, 0),
> +       DEF_MOD("adc_pclk",             R9A08G045_ADC_PCLK, R9A08G045_CLK=
_TSU, 0x5a8, 1),
>         DEF_MOD("vbat_bclk",            R9A08G045_VBAT_BCLK, R9A08G045_OS=
CCLK, 0x614, 0),
>  };
>
> @@ -274,6 +277,8 @@ static const struct rzg2l_reset r9a08g045_resets[] =
=3D {
>         DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
>         DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
>         DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
> +       DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
> +       DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
>         DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
>  };
>
> @@ -346,6 +351,8 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a=
08g045_pm_domains[] =3D {
>                                 DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(5))=
, 0),
>         DEF_PD("scif5",         R9A08G045_PD_SCIF5,
>                                 DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(4))=
, 0),
> +       DEF_PD("adc",           R9A08G045_PD_ADC,
> +                               DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(14)=
), 0),
>         DEF_PD("vbat",          R9A08G045_PD_VBAT,
>                                 DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8))=
,
>                                 GENPD_FLAG_ALWAYS_ON),
> --
> 2.39.2
>
>

