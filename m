Return-Path: <linux-iio+bounces-14854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90EA24D76
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 11:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0209E18841D7
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3E1D5CFE;
	Sun,  2 Feb 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZNbA9be"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93DD111AD;
	Sun,  2 Feb 2025 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738490943; cv=none; b=pK8eXkAfIgXZOfVzXKhMGbsOtbIpEJqIlGYaaKD4WB3QZ+85AAu3vhfaREtQjBuZUfSW/qxHzpQG1Uud8v3TdDAQa2fY8kOOI6Efl1WBLVe7Y8HCGwrunTvBMrUreF2eJoTb5eGubNnOtrxuc3L4qsJUm45MeKLVfSBe1AUe0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738490943; c=relaxed/simple;
	bh=JWUZPomdszTM47BU/+BbEkaucwLYsLRFbnWZlNYrstw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNZGvPRdVuTG57yde8DyS94WZfP2n2Cyg50p4kXr5Cjh83lUhm6CnDhYMOS9vyIQUq/J1jV7nQfjXPx+r1WFIWi1oGTBRfdcVqvzy/dNDizvJGb/b2BuC26Y28rwBfb4iwEDFLdXL5i0+mMMgF//0t2suuvqtfHFplYtNGiFSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZNbA9be; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaeec07b705so550649366b.2;
        Sun, 02 Feb 2025 02:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738490940; x=1739095740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWUZPomdszTM47BU/+BbEkaucwLYsLRFbnWZlNYrstw=;
        b=iZNbA9bezlp6KbsQrUs/FPw3vyS+EAKNYIxbWQVxDvSlUfaUg4ky3IxLDx7bMcFB/y
         AraWGul5wM6a5FykKTU1Wx/gFIEPLDImrY8BcGVy6aKOOOo3ED5qH6gwrcO/6IBPFs8+
         2S0Y/1BFYmjIiwZfzmC3dpE8l0GyuWD/W8r7ct3J1k+iKycDw6R2GxNgeZHb0XoYofCH
         dAlys7+pISt+ew+qV/rQG+kp0IFgXQKWN4DxZmuy3jjLHM0njjj9JjXY6gS0bjCAUP/s
         o4FioniKTw+fH2R+9pjtkpcEZuN+air8vwZYuNkbVmAzAqYJDr+YpcesCNOwXcngn6ZA
         AuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738490940; x=1739095740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWUZPomdszTM47BU/+BbEkaucwLYsLRFbnWZlNYrstw=;
        b=oLdRd+vUuKdPWde/8iayhTiJqAGpJfI5jwZ0bm6MUPXctQyffH0oZSsDrda2TXBgWg
         XVY8CfWToDRIM+oWw5PWBagOssz4euUL2NA+M2pCOGymNBYz6cb7PKVU0Sqa/OhN3TiA
         YApGjMb51FtnunuVVeSOYRWzuS+zO2H+/Oy/NVOoUsUmWfA5ajzR82KvCn47BoLuvyzW
         ML5YXNSvfdRGsIo3bxmDcCwE+mYcA560eDKp10+lCn7+8zcyMZH5MJ+2+v0o4AvbUNpZ
         G9zD5QBCOVuaxEODKOz8snak6RnwAXymCpj0u1Zy5PeVyl18X+daIYGez0T5iyB/25yW
         ymEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVuU+ZD4lFV2EHK/m50tevXVxmE3aYUiMZIqtIiW6QoeaKrT4j+1y0pOZpjA5N16er8X6bxaxE@vger.kernel.org, AJvYcCVaxKmU7uQdNCbk0DIrI0EYSvTOvtmmXD6Ir3xkFyBv5N0p6kHKGgwjgOniVcMwuUQf+H+6MhrZBJ2+IFyn@vger.kernel.org, AJvYcCVxxyvpXZBBBLI5QheTm3kl0/tnAlqPkKtsRrQiyOSI8H+TNItfogzT7vX+pM+aOdNQYtchHoaN4RxA@vger.kernel.org, AJvYcCWWDvRHNRcSgE8cQJdDcxmkG9MroU/tGEvh83NvXXySjh61ELDbF6Toz3DVASDR93njcaR1s9/P/aG7@vger.kernel.org, AJvYcCX+bU3HTd3wvaDejqSpMzQf06+oQOPDYgLXQ+fCoWbpRJObxSSpq+gSC2bMMz1vd6bwYhoMupT67A1I@vger.kernel.org, AJvYcCXDFFrtxg+lC+8Bgl3iNEBkKukSfnAoYeHe8aVOHUKpjKKajpdUkKdD6d8+yfM7px4SMo/IAJjvVPUTuPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTP3XX8Cn2pFwMjiPerji6Og9g/XjgylvzRdlFIoWBCZ1y014U
	5PN/ET9r+4rVyZpHihnTXtsuDwJpiGfxzV/avRUBftPYQT6OOhAq8yVWHa/0g4+230kYmHVqULn
	rdiTIsj4S/XugHerzIP9DOGgj9R4=
X-Gm-Gg: ASbGnctWgQPYVWKmcO2AlSp5iJXsPX+vBXyflVwq8sQNqv4VbGlNjwv5rDxBi5CwNEz
	uh64UPAyHkFJGGUCzLL6Zlh4qCQAeTkOmLeRSuKb2l1OAbI3Io0ugKTsiyWmtXxLpRDwWSKks
X-Google-Smtp-Source: AGHT+IGoMhEdpYXBWWR7zI4SfcoJvtkFU2TWS1zQ7GZgm8kyeKcPqMITa2e0cneA92EhnMutQOz1UJGZQayvtg32aYY=
X-Received: by 2002:a17:906:40c7:b0:ab6:d660:c845 with SMTP id
 a640c23a62f3a-ab6d660cb02mr1815035366b.50.1738490939878; Sun, 02 Feb 2025
 02:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com> <20250131-gpio-set-array-helper-v1-2-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-2-991c8ccb4d6e@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Feb 2025 12:08:23 +0200
X-Gm-Features: AWEUYZn8sXhkqdCp_uJFCgUuy56ygLY55_-aYNnx8QdbJRXYArIopW_KyJxDO2E
Message-ID: <CAHp75VcPgCeC9RJQA411RYCiPpTjEqiwtchPyajz9su5dgvPiw@mail.gmail.com>
Subject: Re: [PATCH 02/13] auxdisplay: seg-led-gpio: use gpiods_set_array_value_cansleep
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

On Fri, Jan 31, 2025 at 10:24=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
> gpiods_set_array_value_cansleep().

Acked-by: Andy Shevchenko <andy@kernel.org>

Or if you want me to take it through the auxdisplay tree, please
provide the immutable tag/branch for the first patch.

--=20
With Best Regards,
Andy Shevchenko

