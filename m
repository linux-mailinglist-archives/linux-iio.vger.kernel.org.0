Return-Path: <linux-iio+bounces-26576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A6C95294
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 17:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 628293431E6
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D32BE7D9;
	Sun, 30 Nov 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxepM4QF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DABE56A
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764521562; cv=none; b=QaGGN3y4cxyEAcKEjMvdrjxMjmiRimcbvPggYBMB2GEQd9YZi49cQ75a03CVjsqByp7z8kmQOtr+GVuBLBvMXqfbfMGMm29NG1hF72P8u378qZiX4QQeJ+C8teycoKwMYZBepSFr45/StzsnyyN8vZdma9q/FK2Pvpy+8LyHQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764521562; c=relaxed/simple;
	bh=aSXL3seJLL8qXfeWiZkHI4sxakZslscQUZ5xtdgHtCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSGiRx+RH8fvWAEtVWRSJuY1cR5aW8BuEUfBCrQJ6gIfHmYArHAoITF+r/ArVZmUlxEvqtZcisX9Ahb+zbCHDOET8R65fF9vTMCo1l6qyXFoiISTws5djbPiUKpi2tIf4Wa2TQ5IsOHY+cy1gsi5zMMrNCGCpQcvuuaFkD8EfzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxepM4QF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso5145232a12.1
        for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 08:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764521559; x=1765126359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJ6fe76ukcbqGnHSuOdykcp8qylK0vyCmnROxjOrYkI=;
        b=fxepM4QFaYsAlmvLn7uae5un5doG4GIj5ZccQgkK28HUuC0fHNxORXEebDc4IbPWdH
         5T4xpBWVw5hGNOg6aHc0sriVjEFhY/UNPTjy/yAegwrYKSF8rRBy+ceNhb74+87YdWh8
         UgFPQLYKnH8h+VfDsBxNQHbf9aL1m6Q3lFUyZ0P2m/WYsGwLjf1msYi9qLpwBaq0abxr
         o0AVUyGiqkl+rtLCgipp0Qx2lCKmi2TYroIMu0ybKb6ivDibvoUMlGwnBQ1u/YyIlGb4
         0w40ByimENVfM7CsKJm2YALNWEytnbeKfZybxKS08YHTTvP14+RvIdH4AHGoR9WIke0G
         Z5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764521559; x=1765126359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wJ6fe76ukcbqGnHSuOdykcp8qylK0vyCmnROxjOrYkI=;
        b=A8evI79CYNeeUeU8rPQFkuOskEBtYIDs7quH6VneGQCTIwYuzBIzymxRW8kSBm7OWh
         A4ysyVYxC9h4qpDsP6EAGsoIJBlD1OVs0efpatBiMOLcRyZRNactuFrxjmVInNC3u8BW
         iJy0cWAb6/nxAi8WAscBEfX7oY9ptKfHLXomENkfIBKZElE0eadrO1uZZCDjJbNFtelA
         1ye2yqHSRS1jrg0vG/Qs9JRZbEyQi34lRV7FhQF3XJx66PvNVfp5YzdtjzwyTEUjLzZ4
         oEaKitud0lhTE79jnEnE3qt36BnucxisDcjKhJHnTizeYxSTXciThBU8nvgLAQmPzA42
         5Gxg==
X-Forwarded-Encrypted: i=1; AJvYcCV4nOPV/eW5ap/SzR1nerX4RF+5s8kUh2/e/d2C8i6H1lYt9GGM4PVasJH/jOXLmZ3q25S537bpfWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybrm9OMdwOI5CNoH+pAxD4bZgbOqQCQXM9H6RuCiZ9paAzm1JV
	XKqw56PccvOhqp1sq7HTH4ZFYNi1/VBLa/7QbG0l1lwRUrxYo2io7HATeXZfhwdG8epytOI0fXJ
	tS3MtuZe0wJfeT2blxnquAAJqbO2fISU=
X-Gm-Gg: ASbGnctqcbixbMItCZP+PskHNpZQY4K0V2GuzFdBb4q19M5WhBy+l0KzlA9udg0deb4
	91+gVVc/C+x4xURF37kNLG3d5wpeg1Ek3nvyT+6Rt9n7jropwILyrzLPzfsT98hwKrb9HCHaXc+
	BH7Wx0nOw+3zO6zy7ua1+0B+KY9NqYlDtCFdRxg4TMd1XadXCKYkL+or1ersNRqeHRLQKT2emlZ
	osaOf1yucMz59+cnupfHt7Wan/tkWdtWoJTc4f6UezIr3mZTvGHq8+xlieHj2xT+8/ULpELmCrj
	8omFmaiFw1IwT8MwPy8SR8QePcTUDiG5wsK9QIZ0zXWDl2gVAfppF1QkaGaOPwLVKSkUMeNPvrC
	KuXPnQOQ=
X-Google-Smtp-Source: AGHT+IEgrdz8mK9TGBNR/edqyq1M4MUt61WNWmr7XneeYKJJ1avxdhdJ/mUSBsp7M5BngB5Q3YPqSdESAIgzBL9WIuc=
X-Received: by 2002:a17:907:3e0b:b0:b76:60ad:77f8 with SMTP id
 a640c23a62f3a-b767170aea1mr4019953466b.48.1764521558404; Sun, 30 Nov 2025
 08:52:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130153712.6792-1-raskar.shree97@gmail.com> <20251130153712.6792-4-raskar.shree97@gmail.com>
In-Reply-To: <20251130153712.6792-4-raskar.shree97@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 18:52:02 +0200
X-Gm-Features: AWmQ_bnLDmE_-g4Cj4lFQQDM568Ha-UkLbhD1fvEJHei9syL8qH60b7dNaKtSow
Message-ID: <CAHp75VfPjQB3UqMEb===5j0YYoWn6mMuaaAdTjUcFMuChBq6_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: proximity: rfd77402: Move polling logic into helper
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, heiko@sntech.de, 
	neil.armstrong@linaro.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 5:37=E2=80=AFPM Shrikant Raskar
<raskar.shree97@gmail.com> wrote:
>
> This change extracts the polling logic into a dedicated helper,

Imperative voice.

> rfd77402_result_polling(), which improves readability and keeps
> rfd77402_measure() focused on the high-level measurement flow.
>
> This refactoring is also a necessary preparation step for adding
> interrupt-based result handling in a follow-up patch.

...

> +       while (tries-- > 0) {
> +               ret =3D i2c_smbus_read_byte_data(client, RFD77402_ICSR);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (ret & RFD77402_ICSR_RESULT)
> +                       return 0;
> +
> +               msleep(20);
> +       }
> +
> +       return -ETIMEDOUT;

Reimplementation of one macro from iopoll.h. Include that and use a
single call, will be something like

  return read_poll_timeout(...);

...

> +       ret =3D rfd77402_result_polling(client);

Ah, even better, you don't need a function for that at all. Just use
that macro here inline.

> +       if (ret < 0)
>                 goto err;

--=20
With Best Regards,
Andy Shevchenko

