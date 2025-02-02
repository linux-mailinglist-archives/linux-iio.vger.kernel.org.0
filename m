Return-Path: <linux-iio+bounces-14857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA1A24D8B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AF0163C89
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AB31D63C0;
	Sun,  2 Feb 2025 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBcRUQRr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410117FE;
	Sun,  2 Feb 2025 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738491648; cv=none; b=C17ZgjKQyJBXkf5hBYDyEC2UAgpNo4Qjfh9KU1Z7iixfdkIme8u0aw8qyFfy2/nVfIAH3r0zE/Q63TBpOi7uuRjnJtyQ6p70Y37lLOpf0w6+RYYS+H+bIYGh7ryTpiwIVAQx+OinSS0f47WkdLmFuZAaS4s804CUQT0RlWs9yQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738491648; c=relaxed/simple;
	bh=/mfrv5StkavXHKQJTlc+XAcy2Icx8CIyOz7toCaa4Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgMt+hcYKfhpxbm/XjxAkgipW6pEhd6w06Eh1Svtnn/zcvFpg7+t6dcIz6uDmrMnRMToExM+rNHMDeD9a8WRc5ons8NxdNjVJun/rnPYS2UcX6edvZjmHJZWJGZq5V+zP/SwnQbIBhTXWYp39ttdHrUCn3bkOAvCYs2zcFhr5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBcRUQRr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso679852766b.1;
        Sun, 02 Feb 2025 02:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738491645; x=1739096445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abuLAjBdtRLiVsNmQ3e7MBj/eyGhzqb3O3rD3el2slQ=;
        b=dBcRUQRrx56Aq2v8m4McNw3OcKV2deZKi/MLqHp6fVngka6uKh4kdgE+59v0Vc9bkI
         ZXp5+Wb+dldoO7Czl233KUdZzsCVWzRxhQEYf8jumlF+Eze3OiKxE0pptbNlFBFWFs8h
         gRiGu1TMgsTAjv5AHXuQD/kfHKAIxF+s1w/wREzZHbVoWxSXmdSnPd3FZ8UB+9M6qfN5
         cx9pQOJwlZ9OY4qZW3SHrBm5zrBRfLMvxTkld332TC+xZ1m7UwBdyZ+VxNieyae0wyPo
         luUKoJnx3cae3I5/GwffscQJJjTYJ0O18KIpl5NxtxCcqmyPZRWYOmZR0sdm20Wsl2a1
         4fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738491645; x=1739096445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abuLAjBdtRLiVsNmQ3e7MBj/eyGhzqb3O3rD3el2slQ=;
        b=jIDeTkkPBbEBj5LAR9IzMED9GRvdbKOVmyvwj12AHVinNZlzDQTsJ/sVgA/xR7r94y
         x1X3WziyU4zuRXKzMJP5FkYz9Wo1I9vFh1WgAh0Oqg2U0fSTWi+K4DS/YU+3nplcK3mY
         OYPU+xd852SkpRxDjT/a/Yvw9rfG97s9orxrCOh+2sDB3gZ70cFinqgNWjfh2yhvQytq
         vTCpYrrqhM9UI6WjULIu3i87D5/u4Olma64rHVkNBSnZ1HbRIdX25tExDpNccMwdGkFg
         5YWF/HEEvgcQyFDBN9TDasvj37WaM6SDmYppHBYza86D7Tqy8r3DWu/JPKJqkYPK4k61
         zbkg==
X-Forwarded-Encrypted: i=1; AJvYcCUD2LSm5pcZtaWuqC4zLD7+BZtKAuveZvLinnBHCxq1GHgLM0gGSXU4jUjPdgJj68ZjLcYyhy4D@vger.kernel.org, AJvYcCVInN/7PtvHBpVUXUgG2fxoen6JrfcC1RbQ8kiKUQv/VcGU3UTScuGBWkQEF//nxVUigz0ggPEqUkrB6f/N@vger.kernel.org, AJvYcCW26Z4lOX6+G0K3gS1zNtm8xfN7Nrq3eFe1ccCxHyFR/CJui7qafY/HtMVxnHA6bH80KBh9FBZX7jff@vger.kernel.org, AJvYcCW6XBNN0dJkgNgrOHkcEyPPtIItIGWNKK+ZMK6doRXqPGjCC9yCW7liCNTO4EWfl2KhMlO4p2YvkfQpmzE=@vger.kernel.org, AJvYcCWDm1A2g5dIgsMBzAJvKZ/2XXZiiiDWN+UIi7DZ2D3WlfOQfv7uSkvhHteorbC1Of+Zj/ahZLlvsgeC@vger.kernel.org, AJvYcCWwnbppgru4VIIroi5gcP1v7ZIVS2ZkSvp2NEFoOS0S3U0qTOSuPwYYu3G62E8QuupNNTQAVKc0UCa8@vger.kernel.org
X-Gm-Message-State: AOJu0YxtG36UVt57jyX3pblR0OILE7B2ebyjETjJml0raiwSMe0m3g7w
	ANrdt2ym4nXOtEw/VPSKvyu+BcMOBZSlGvOygPA/0SP5NSEJmunJbDQloH5sKNfamBiIH/1i2pt
	u1CHAnyIEkE85kH3sIW/5S9rT0XM=
X-Gm-Gg: ASbGnct6nwxvXvevjBXyAyX7HVf6fVyEnYd+yRA8dy9tZ/E/oC1rx70xwud+MfPtrO0
	DswBwCDQbvw/GUp6jDg9dNpi97IWl+RrzBugw6/WrTjA3iV0y0K2a72CdkROlOyYNdiL4GHJ+
X-Google-Smtp-Source: AGHT+IF/+uZMaus2XNgM2nDOwGoxfdb50gAm721dJ95mc0Z1AhtjtqPDVV+/FfrSVjpX5K8wsYBAli8SEFndMMe5kfQ=
X-Received: by 2002:a17:907:1c13:b0:ab6:36fd:942a with SMTP id
 a640c23a62f3a-ab6cfe27037mr2143028366b.50.1738491644744; Sun, 02 Feb 2025
 02:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com> <20250131-gpio-set-array-helper-v1-12-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-12-991c8ccb4d6e@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Feb 2025 12:20:08 +0200
X-Gm-Features: AWEUYZlSUWREHLYnafA4D-LM02R9rz-LXsE0FD1seSMpM0Zva7Lcfwmi-U7vSis
Message-ID: <CAHp75Vc66j5omBZe422HcgSDaASZRrP-pA1RgnOnUrX1n-tmhA@mail.gmail.com>
Subject: Re: [PATCH 12/13] phy: mapphone-mdm6600: use gpiods_set_array_value_cansleep
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

On Fri, Jan 31, 2025 at 10:25=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
> gpiods_set_array_value_cansleep().
>
> ddata->cmd_gpios->ndescs is validated to be equal to
> PHY_MDM6600_NR_CMD_LINES during driver probe, so it will have the same
> value as the previously hard-coded argument.

...

> static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
>
>         values[0] =3D val;

FWIW, side note: this code is (potentially) buggy on BE 64-bit. Same
for the rest of similar cases, in case you want to address this...

--=20
With Best Regards,
Andy Shevchenko

