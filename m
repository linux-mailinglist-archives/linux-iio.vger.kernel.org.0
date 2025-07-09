Return-Path: <linux-iio+bounces-21465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1432FAFDE97
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 05:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB0D18971A4
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 03:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7A91F8EFF;
	Wed,  9 Jul 2025 03:53:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1661A23B1;
	Wed,  9 Jul 2025 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033180; cv=none; b=f21JKdoc0+3zLRIc1Ux46OsB9tr4X8QP1UirqH8h62md661h9PmSNOsTAVGQDj3nG+MV1rJgL++noH+gG7hgwN/QlnETKG2KvzdGv14HUcTsUZ+8pulJu0S3Udmpv7S1w0Pk4XjB52Yoe2dEeOAdEO4i73NkRc/ykGJC/6hj4zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033180; c=relaxed/simple;
	bh=zgBiysRO3o5cVKKfxc6QqBibR6ZB227VIaKeujFCzLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTdjrXqMGZt36j7alW9M1iEYbC0PEuD9PZlLD0Bm5a+DOOARVXGKNmlR/4lmYDdYhHPcderTTrUSiBqpmT8joE6rjoY0Iw+um/ZfUMW7vM+Zu+t5/IezRjx1/sKnfULDG0gudaDl/g/qNwxx5kmhVu7j5jYBbSj7zWjDA36Yrwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55622414cf4so4711843e87.3;
        Tue, 08 Jul 2025 20:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752033173; x=1752637973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2WLrs8UFl83Bka6HJdVR44cmF3Cl8IJgCemJs93MWgM=;
        b=VDWFZPnQfdHCaunqroaw2p/HgKFS/+veBfI/3QBKLqfJjbwmn+CA1OQIzibDV1Gf1x
         TlvYJBEXHrFmvOEZY+nsWaBSbfeh+aDjQ/eff08AZO5PJXc+q5OruF0oLvvI4DlLyjeR
         VpUjU5cmVXPaF8yUg464773OeBY2ZzTMQ/XhJfR1pDHgeU2pj/dMq/a0HEjpPSpMxG3b
         9nQRQQ44MCmXgZezcGL9BRFF3ZgWUPXXdfiy44BZu66CGWPa8Y214cCr9fii8gNSZtRc
         RwjHpR8P5bVcNiZQOeciDTU3S25nZvCqvOIjK8tRFb6zNUbTyCXZn3XkfoNa2PpFLqfd
         pbfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOAJPuSWvfm4IVWcsFjmJLOvTdXMCbn0sDLuenrm9eNoUefhCba0mRdfLwAtNu6hOe4tMpIcSNjKM=@vger.kernel.org, AJvYcCWMW1EejySIgpuYfF/9KlYAjZwVN7jwfH8ONpzU/bQC1dD9717RGg/N3/68esqAm+rAHnMUHfcsAG7E2xOd@vger.kernel.org, AJvYcCWhbxXGwm5061WxCzEAt3eafW3OJo4MX38v/x2aTv7mr2hXWb1AYPYtHDiGpCCMtgY4kFYki2jR1KShN+XPKNTZvBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIHFJyfq7aE+HXLg9Qz512kemk+T41Wtuzpzds9IyLy7xEVCI
	PWC4/qCOBdPULTqdLRdCD94TIxHkpC0wcyLi+cVLYcFlu6GwVTDc28hPXbRSFsu0JnY5ow==
X-Gm-Gg: ASbGncsgnUlPVG5zVtr6GhgB64OCZcduEE8rFjqIy2a+uudcjzuoJB2HplC1Iju/WNs
	15gmUPno9OK3MiKtKk2chL/TzYBr3CE6WJR1HHrUkmjbpjoq30VHB5h2z1SN4VChCXnL2xzmFj/
	Y6eP5VxuhNswhNZ3Y2O485Zr3Acd1hU6PX2lTZL9c8Ioxt34cfxAu/TUEokivekcDGsd1SJ9E7z
	ZxybTuhSU9deZLBHsPsAcLXt531R7kv+dd0SYP9ZGMtw2N8c46BofbIyfj+g0feT5Josg4wKwxa
	yqChZXZCIOGXKWId55MdxO4GLeDj+3+cwMALXUwiouI0EKvIMYhwOT+hc7+y4IZctC6Jj9A4py/
	2VGkl3+B4r11q0qvKgkU=
X-Google-Smtp-Source: AGHT+IF8UObNFFX0glrD6YM+OFN0vS2+nUL/LpgdQPxcmKgcebs1YA6pVJCf3sjf7D8d/oOqhKv9Cw==
X-Received: by 2002:a05:6512:1102:b0:553:241a:b93a with SMTP id 2adb3069b0e04-558fa8fae21mr266231e87.31.1752033172914;
        Tue, 08 Jul 2025 20:52:52 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384c485esm1838590e87.232.2025.07.08.20.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 20:52:52 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32f1df5b089so35629531fa.3;
        Tue, 08 Jul 2025 20:52:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzzVUAqwwUUl4LVNtM0OW6otth4k2wEToL+Ry3qTEsGDJDJe6/+Q1hbsomGQIrxL1s0mgBNyIQ/OsohloP@vger.kernel.org, AJvYcCW4QZv22aXfVYTVVoJ7Vu/WhlMbWghdpsc+9aEP4wEDc15Fa8d3Lh1frfq3OofIFXp05y2Ith5Y7896sy+VF+XN7No=@vger.kernel.org, AJvYcCWK229Ask4wXRvIQZn+TnZOyzZ0aOxDRd2qSwlbVZ0p6NPSMJDYFi54864akQffgO44pWg9tFexPM0=@vger.kernel.org
X-Received: by 2002:a05:651c:221c:b0:32a:888e:b30f with SMTP id
 38308e7fff4ca-32f48421a2emr1518491fa.6.1752033172370; Tue, 08 Jul 2025
 20:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com> <20250708231152.971398-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250708231152.971398-1-sakari.ailus@linux.intel.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 9 Jul 2025 11:52:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v67zSf6X5B0rvkKPb1sOna+EW7f5JzqduO1rt1hSUo3p8w@mail.gmail.com>
X-Gm-Features: Ac12FXwreyUxlabds-QeysMrnIp1a5yDkx7pVnlh5FRhGlmU6_2tIIE3jiUb5cg
Message-ID: <CAGb2v67zSf6X5B0rvkKPb1sOna+EW7f5JzqduO1rt1hSUo3p8w@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] iio: adc: Remove redundant pm_runtime_mark_last_busy()
 calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Marek Vasut <marek.vasut@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Julien Stephan <jstephan@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 7:12=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

>  drivers/iio/adc/sun4i-gpadc-iio.c  |  2 --

Acked-by: Chen-Yu Tsai <wens@csie.org>

