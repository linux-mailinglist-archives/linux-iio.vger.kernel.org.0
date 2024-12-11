Return-Path: <linux-iio+bounces-13325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5409ECD27
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 14:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767222810FD
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3959222B59D;
	Wed, 11 Dec 2024 13:27:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434091F193D;
	Wed, 11 Dec 2024 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923671; cv=none; b=ubAYRVYJBkSxz+n/GgDpMdSSC7mT4/PqbEUKnmK9HPbqxGybcQIqmniaX7Og7+jVV+7z7iVv6Zl6tDp9zNkW1mlWe4REoHzdlTBFnVDOEvuYySgMwVxW4mDVeMbmaufxxxX/AFrtCGp+y998lcoIRomfojw8XEn2C5TsmYPfsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923671; c=relaxed/simple;
	bh=l0n79E0UwxAsx0c03t/5SUdllR1UMQbgv1in/olMbfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaKvy2wc8fUGy0Kv1XiZQLi041YpPAjyzy0Icp86Ho0K5MURSBl2lmC9txHHVFFx8h1S5RG0H2lRP7L1yBP8W+yLLqxvWGerhJmd2NtmWx7S1i6mbLvzNm/G7MYRMaSQ1rPFUlieC0KfqUDY+dIc6HlrFQapdj8dLcsuGWc8dKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4affd0fb6adso883031137.1;
        Wed, 11 Dec 2024 05:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923666; x=1734528466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsR3cWj2rQxpzGsWHeVcLZXw5195PPdpxK8V3I3ghRw=;
        b=YYZqbrqSyeOZI2Fqzkicj0UKbM+YQNUfFy7PzkfhwkWWJGZ1EeSY5TPwT2mGwdg+dx
         xyQQvWVr2UbiwGkYiYqBlxGrs64LV5KWdbQWt3Wb4AAtPQtNRWmyvlzu50o+0qdz6KhG
         TMVOl9VF18wizZUSL7/Wxl8hQnbGHNNp25E2mA6Nk2/9XO8mBxvbGpSWD7JM5GThsG07
         z483Fj2UvBKlBAyJ7+LEzfecCrHk7GOPo/hYRv5rUsuvNFgmwY0zthqMGIxqIC5OxLKZ
         0BhEb0LhikChrqxvcfMlwQneLbORa3+s6zxaXHnaWw2+C+yL9hO/vg3XeBrpKFPh0HsD
         U8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj2as5QSUeRzdZmiRPzuQC1paSBzkJ/IGCG2Z8iU+q6Nv7sFzpY2CY7fR+7qXIDpZN+ekzyCNb9//HL+P/kap0bt4=@vger.kernel.org, AJvYcCXOR/LbON0XZI+fbxITcafV1TqlVuX91gTx0slMX+LPSEmDWO8JY8YnQcy0HNJeEoOmHUjH+TopTTGQAc8w@vger.kernel.org, AJvYcCXTIIyHmX+kF6pttteAvc3KTJ6S6LtOB+Ou73hGzmgzaaQaAx8TgXoryRHsSCb1HWWPEV5tnFlo3EUF@vger.kernel.org, AJvYcCXeVzmDNdHddGmXw3PQjoiXYchnamDpGdVUvw5yBq6o9Oi06heexyFOwemF7FqMS/LjpB9Mvky35h+x@vger.kernel.org, AJvYcCXu3Vv37E8+z5K8WsqWEzcV20222gLa+SkiyXe7Zn3/McTC4QvTo4qpjhqY4tG3GPRIRS4vyeetsH+B@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9p78pnv4NNsAkSZZvoYvzD382z5jCseBxN/1Cgx9V6TvdPAUP
	+Vms90n1IEvVL6Lh5pvG+mozHJNrE/I8u1usfNQMmxo5bQIi0NmMjL/zX2UF
X-Gm-Gg: ASbGnculy+oKyCcKE02L74CSRG+fKgbbSifRyw9V3MmliuL4hkRoIMHiaEdQQ+wDKm1
	3P/f6lzhyu+OLG1xWaEAgEUt5uJsTx4ZfdazAWpZnd+Erwxd2rKykckg7otqLfQjFsJWaTqhRWG
	cSouJ1x46gORndje7kd7522ymnnA61UE2LXy3ENZ1vreDIEXMY19NMdIhd6EREGOMRLXLazJrFc
	QT6fYeNWkC1r2G8im2/oy7tottPtSAfpmF1eyVi1rO5ogOlrGJRMgycKTjLFjH8rFU8nZiVAqrt
	AMFOOjEDa5VYTrtp
X-Google-Smtp-Source: AGHT+IFG5nawDJgp9Y9hp1fhzqYJ9iMidO8pohabDIzv8vzkSQD2kgphyJLtwTgEP3KQs7hivQbNzQ==
X-Received: by 2002:a05:6102:32c3:b0:4af:2f95:4ae5 with SMTP id ada2fe7eead31-4b128fa102fmr2556194137.9.1733923666478;
        Wed, 11 Dec 2024 05:27:46 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4aff0e2fae7sm947447137.3.2024.12.11.05.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 05:27:45 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4afde39e360so1352677137.0;
        Wed, 11 Dec 2024 05:27:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoGjeVU54a+hbZndzpflVRhUw/qJUan4tR6Rv6AHF5gWObp4RpNN+4IKGWsGMt5V6gwiFWbAaFkHbB@vger.kernel.org, AJvYcCVlLLPJkzFYULS8GW7dYBktLzVfbpQKLksGnGKMuG0qWUqbqUf0dlrDtdTta+/5JS/FbMtxSO1sVgvT@vger.kernel.org, AJvYcCVlM5/XRQYy32M5MGtACNL3LPySYxFF72+XUikZjkZ9Fhhjv8VW4TSGXXU4RycapeQmCkXDWSDEN3idD3IZT5FyVCs=@vger.kernel.org, AJvYcCVuxbsV/Vr0ycuP9Zo0Sp7Y9O7v53M/QPsUdoOyrmJHXaaG0PP2f6ZNa2YH/fGLCpUtwQlLI/x1FEzsIw0u@vger.kernel.org, AJvYcCXLrNsn6qO9tP4xhmWnTTbZpWrruAfIHaLmAkkIMaahiE/RU4ZDV4vCE5FGSfSnTFNeskQUWHuvhWAI@vger.kernel.org
X-Received: by 2002:a05:6102:3747:b0:4af:c31d:b4e9 with SMTP id
 ada2fe7eead31-4b128fedb4cmr2541368137.13.1733923665100; Wed, 11 Dec 2024
 05:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-15-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-15-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Dec 2024 14:27:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVMQr9RhG7v32vQeSrepmdh2VdzzwF5obJUpdGNotGV7Q@mail.gmail.com>
Message-ID: <CAMuHMdVMQr9RhG7v32vQeSrepmdh2VdzzwF5obJUpdGNotGV7Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] arm64: dts: renesas: r9a08g045: Add ADC node
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

Hi Claudiu,

On Fri, Dec 6, 2024 at 12:14=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add the device tree node for the ADC IP available on the Renesas RZ/G3S
> SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> @@ -87,6 +87,59 @@ rtc: rtc@1004ec00 {
>                         status =3D "disabled";
>                 };
>
> +               adc: adc@10058000 {
> +                       compatible =3D "renesas,r9a08g045-adc";
> +                       reg =3D <0 0x10058000 0 0x400>;

Table 5.1 ("Detailed Address Space") says the size is 4 KiB.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.14, with the above fixed.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

