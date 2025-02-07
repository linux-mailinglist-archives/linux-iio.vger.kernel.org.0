Return-Path: <linux-iio+bounces-15109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83447A2C0AD
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 11:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99533A1453
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8B1DE3BD;
	Fri,  7 Feb 2025 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge21TZ35"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756553A7;
	Fri,  7 Feb 2025 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924537; cv=none; b=JPte5bIid8fy0LurPfX8s8I98skDaTBPgYkrg9pmw1dAg8Z6ruGFnO2oxB1ZB6tszvi8oLDRomoJqtDN1UcvtIV2lscUlTLe6/pw6kS9f2k5Nhq7+MWt6p5kS8a/V5u3vMgHmhTuA+isYHQdtA4b90QYUHR87XhKE7lD/ISF/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924537; c=relaxed/simple;
	bh=drEqbq+UnvUiG38XEE933fBD387EM48h5DcS6gouwlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4hP9UgxW38FWfgIqkvMsb4Sgfm698zMYFK0/tbRMuWgBd5C3IN9PO0u2zQQXbDuUBANJhNHIIf0f3PbTLHpFDwiy4wjvs0q9kZWNmcmZMDHagBoSKZoWSsyY9ybZ55bRWhzPnoEErUYtAduYZh+XQfMNYOCkpEhsqO24UT9CJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge21TZ35; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dce4a5d8a0so3220982a12.1;
        Fri, 07 Feb 2025 02:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738924534; x=1739529334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSXOXieTVzhRaapZT+T7hFM0hi46AothZ59+EmZcB08=;
        b=Ge21TZ35TTdcA4rTcPUGHtfa0lsIwv7wuJ1PhFEMD1+so8hxfV5tHx4StI15UsOmoU
         7vsH0kqvUlYTO+lGW2c1Xta5DKBrSNa8dlcXcZenp22PJUNtCM9I4Z+19ef0wgv3N/2t
         58Onh+JX4x6+2/CiaBww828WM9NZkdr4BvLuZpI/lsm6sjG8zJ+WxEjqQr4U1QXYWklm
         lowwm1Nezzy4SJQzWLuQ/zz9QvxkZFbUwh0KoEc4afXe8lmJzCmtS5+mCIbL/ltspNbJ
         DLL8qJXvGwFnX9K87AKOTxQp74gzZ2Qz6WC1bMxGlOlqFgpeokqaZT5jxVuOWyx+AmIx
         wE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738924534; x=1739529334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSXOXieTVzhRaapZT+T7hFM0hi46AothZ59+EmZcB08=;
        b=XTA9vTH2HRyfyOUwPJndBMzfnu9SjUFt7uRcGZJzWhL7g33vnwzZxsu4jSg71uM/pl
         Y86X8skvmiNHr/kA1VecePI6wAfwe7+7W7N3N2tjPsso1Q4WfgqSMQcKymNbSBxYPzpv
         EMVJV0aIsmSpD9heT5GmJSmtaWQl549flU10FBB2T2Rqi5dnM4Onb7xwLP4bh86+iB/h
         9eSaJU4E175NZ+4P1S7zl3SzrK9NMEHhe2TL8XhvfXAyTFeJSohVtq74Wm6FkHdvHnOT
         ICAn+5Ss7Pf5r6T7RTnNZDD3vUYu2cwkoINLgf6U/+QFVTh+Gmcrylh134Nzj1+FkBLx
         t9MA==
X-Forwarded-Encrypted: i=1; AJvYcCUB4pewmjylgyeFfzAQ2ix6qsMxNV/a4SwthdK2xYoyEIh77nkQsUsXR0quDEsZLUqIHOEaTRG0XqzO@vger.kernel.org, AJvYcCUHSXb5v0nkYHZVm5btNixaimW2aTJ0Kh9RlHjpM52miaWj/yQoyT/CnPkOAouPPv5R/qhqIZMhWaHoLqIN@vger.kernel.org, AJvYcCVZrJT2tBCVAnX9vEttYIYaTwdKhbWlYfEK0YQrGwaNGDwRAdwJbDeB6VsFbHNhOt0ykJrNW+MD@vger.kernel.org, AJvYcCW2UzeLCY/C1GadvMyakiYGgINDPJK1ncn2Mj7fSskmSOV3E2TItdGdqNMZQY4NY/DpvND+89oVYkjCNnc=@vger.kernel.org, AJvYcCWgyrajtyKEfUa7ogbh7nq7avb6iDBgfC9UBpLnc2WWfXKC1vpDw4w10OMkV6GK5dJN7qXxx1sShlwN@vger.kernel.org, AJvYcCXhs6/c4mdz4F5pX1oOGEA5YXSCfqPKO0FSoinF70pV1JSYTrkASWPQCYi2OB52Gs9VcRAw5CWffvGh@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8F/iptWSxgFcGvq8PC89Oo8YXXYoxmQssDzly5tHG9bLRYyC
	WzQNxPwWzCOiSbKhgSAa4Io11a7e4qf2duddwKwzayTMNrcQ8kygvj60Jn1VLEd5duPDW6YB5NB
	bxulvXYFcZCpDKjdVk3JMj9OJZes=
X-Gm-Gg: ASbGncuvqKN0E4kKEwmxEd8p0gjsbYeiRn7yyu1mxXdT7NcOvnrCwqj+PHR6xKbPiJn
	jEIiDcrSC+upPJ9muWXK1b9XAxLswfv45+U5otWMoluzCrxM53RqXLpwykREi3Yf+pdnsJUPX
X-Google-Smtp-Source: AGHT+IFsDdaucX1wfJ1VUpx8G0evRZY0LiedNNpXT4C7C5nBCiZUH/mVnC/GlcSGS3PbeRf0OT9nsN0Xw9qx25jpLbY=
X-Received: by 2002:a05:6402:4606:b0:5d9:ae5:8318 with SMTP id
 4fb4d7f45d1cf-5de450706dbmr6829476a12.20.1738924534208; Fri, 07 Feb 2025
 02:35:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com> <20250206-gpio-set-array-helper-v2-5-1c5f048f79c3@baylibre.com>
In-Reply-To: <20250206-gpio-set-array-helper-v2-5-1c5f048f79c3@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Feb 2025 12:34:58 +0200
X-Gm-Features: AWEUYZn9dUBLgrBMB29t-azFViPsoLod9-AdOpM2gmZK6mo_lnlhIZ1x0iHhJeM
Message-ID: <CAHp75VcNJzPH8to1Y6NzPMXnH48Ve4LJ7oid7_wEHtwhO82Fmw@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] gpio: max3191x: use gpiod_multi_set_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:48=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value_cansleep().

It seems you missed my comment.

> +static void gpiod_set_array_single_value_cansleep(struct gpio_descs *des=
cs,
>                                                   int value)

This is not good namespacing. Can we change this while at it?

max3191x_...

(I would go with max3191x_set_modesel_pins() to make it shorter. I
have no clue why the function repeats so much from gpiod API naming.
Is there anything else which is named in a similar way? Perhaps fix it
by a separate patch?)

--=20
With Best Regards,
Andy Shevchenko

