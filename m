Return-Path: <linux-iio+bounces-22679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A3EB2500F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 18:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EAA18832B9
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6A62874F3;
	Wed, 13 Aug 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4kof0zn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78811232395;
	Wed, 13 Aug 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103266; cv=none; b=RcH1ktBMTjvHExAM6XNQTf/IeWnq8EvIIn59lBVovNIHQSYDzYFsKblupXWX3MG6yqVtYAPzHNdJwpGU5Od8TS3eBsPDjBvRXwr72O6gq9srtCHSw7EywuFrjIXfeAGSBkzvU7luupOYvC4519tp7YnhqQa65RTm84R5T75Rjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103266; c=relaxed/simple;
	bh=yBwHHprknj6PkryIXl//LRsEtTiobpZSjvx+rnjm8mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUfkKMKBno/0PQLCwJZpK7qhKeKf1VncuCYi49nU3vnICIK/+fqiwd/FYaQb/rQrXsKN46igl6+9UGvWtnJAWtOKBouBsncsag6Mjs1rKpwSx7UCG8k5oJ2J1zt7I6J80Hzl6On9Au8cvgjXiqpq7sjrEkur2PRvBhJghV9MdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4kof0zn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78d5e74so5706566b.1;
        Wed, 13 Aug 2025 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755103263; x=1755708063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8lrtRx8jCEAKl+bITh8cA+FmiqZOy9jagxjCWazHmw=;
        b=N4kof0zn10IFTI3eg0bvg/6e3BCwhhJklzc1Uz97WdSTvUXYVg4MbJJh3yYuYnmZ9g
         ttz5oMu4+uiL9spd/SAmSvlHKlAxH/1A7zr+0DuAFIsmu0mc1TxtmpKsyECJDCfpyRwW
         sDWd8m4gRqcXVkL2jEt1bPgayP6KG3vJ8E4ZVo65Wgwd1AUxqjan0opyKv4rcpR/jlxj
         fNhXyLrbwuJbJOjdX6KxbuW/iVFdVb+tXXbH2hl86eKMv3EeYf5lcCQFMzw0yzFSr88e
         fpZ5PYGyRnYikEKXaKPF++4eq8bzNYq7slndy5LQLeywtgzOLe2SM4n9OBlvAbv4WOo7
         kB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755103263; x=1755708063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8lrtRx8jCEAKl+bITh8cA+FmiqZOy9jagxjCWazHmw=;
        b=WJQuH93bmEMnoHj1wD6y/WZqRH663pnsgvXYNG4kGZJeJjJkkOtv6Zy7iE8497Rp0B
         lyqCCFrcv8VQNuk8RT0/8kiFfKUZc7gbnhkjPcGiqvJ9T7PPXVQGTbsYK3ZIw3yu2Moy
         ZAwWBj5WSmoWfQc+lw/fAGAH8ml21k2yiPpON0b/3cfNAaIkrBq/loUMXFUi1oLgwSUd
         rgXHkh+070v3A4G7C0eS17kza3Czx2L+oS0dB7lyFYAkwAU4aqRTLRjZIKUgNsHe2HmH
         0hXevM7L3bEXWGA4mWlRSW4nAYGph641gDdfRorRhMHol09VDFlsgBkK56C5LHqL2fCZ
         oxWw==
X-Forwarded-Encrypted: i=1; AJvYcCVaLjAaT6HVL5yvgsq4N4WuW4sUZTq2sRgGNN70Q/gXzN1VIhFZF4DLMGwI9SGCZUr4HGiq9d0Ou/QttnvJ@vger.kernel.org, AJvYcCWTvSTYLD1aWFSAboVoni/EgIYneuDBFM89KM6ZlZjqzZ0pc9v0OTVsiL3UstyU96UfU5IFQlBkFig=@vger.kernel.org
X-Gm-Message-State: AOJu0YymfQm5dWQR//SO6Sxk5uyWB5GXVMaETAMERz64B+ES0TkIklkP
	BoE885WD0eqy99Cgsgcl1VU2L7Y/F5MWgHPEmlMNMaKS2BZRFSKxyoVhMazH1OTNNaviVHtuslM
	60Axdf/MGxei0WMTO3edTGHvHdrtlgrAde7IhLDE=
X-Gm-Gg: ASbGncv3ygoRUAvD0rb36E3W3FKmn762FGM290oT3C2WsDFXUaiSuK6Z/MGhjZXzUJM
	doIMxTbohE/oMPGOfhmSfVP4x5qZTYaXBf78Me+P2/wMxFT8K2wlcIFq6H5ouSJMocXK0AX4zHj
	nSxqISKxqCxi8Zn3kuhiuw72sk94nKgjdReUX/idIvk5WHAIaEqc42+WGKFphMyNsW8RwXlK/dN
	+SFtW1eFfx6gw4rofLy
X-Google-Smtp-Source: AGHT+IHpyocSa1M8AilZduqJlSalEcEYBrFzv1dUwM9wYZQD5lOoEfwF0sEPN64AvptMj8eQOzqyBAVkMN+LWXPkqac=
X-Received: by 2002:a17:907:1c09:b0:ad8:a04e:dbd9 with SMTP id
 a640c23a62f3a-afca4df4cb9mr350701066b.31.1755103262647; Wed, 13 Aug 2025
 09:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813151614.12098-1-bcollins@watter.com> <20250813151614.12098-4-bcollins@watter.com>
In-Reply-To: <20250813151614.12098-4-bcollins@watter.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 18:40:25 +0200
X-Gm-Features: Ac12FXyDfASdwmfoCUCeh8J29MH2VM_-BxZ0HM94ZZP1YHdB1y4mzbbhq9VhfVc
Message-ID: <CAHp75Vc6DwpCps9kuXjaCCPrYycbFf3NV2Ye+aEM2_9LWJqMBA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: mcp9600: Add compatibility for mcp9601
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:17=E2=80=AFPM Ben Collins <bcollins@watter.com> w=
rote:
>
> MCP9601 is a super set of MCP9600. The drivers works without changes

superset

> on this chipset.

...

>  config MCP9600
> -       tristate "MCP9600 thermocouple EMF converter"
> +       tristate "MCP9600 and similar thermocouple EMF converters"
>         depends on I2C
>         help
> -         If you say yes here you get support for MCP9600
> -         thermocouple EMF converter connected via I2C.

> +         If you say yes here you get support for MCP9600, MCP9601, and
> +         similar thermocouple EMF converters connected via I2C.

To avoid a potential churn in the further changes to support a new HW,
I would suggest to convert this to the list of supported chips:

  ...get support for:
  - MCP9600
  - MCP9601
  and similar...

>           This driver can also be built as a module. If so, the module
>           will be called mcp9600.

...

> +       switch (dev_id) {
> +       case MCP9600_DEVICE_ID_MCP9600:
> +       case MCP9600_DEVICE_ID_MCP9601:
> +               if (dev_id !=3D id->driver_data)

I prefer to see this to be converted to use chip_info before getting
to a new HW support.

> +                       dev_warn(&client->dev,
> +                                "Expected id %x but detected %x. Ensure =
dt is correct\n",

dt --> firmware description
(the world is not rotating around DT only)

> +                                (u8)id->driver_data, (u8)dev_id);

Use proper specifiers and drop castings.

> +               break;
>

> +       default:
> +               dev_warn(&client->dev, "Unknown id %x, using %x\n", (u8)d=
ev_id,
> +                       (u8)id->driver_data);

Ditto.

> +       }

...

> +       { "mcp9600", MCP9600_DEVICE_ID_MCP9600 },
> +       { "mcp9601", MCP9600_DEVICE_ID_MCP9601 },

Nope, use chip_info from day 1, please.

...

>  static const struct of_device_id mcp9600_of_match[] =3D {
>         { .compatible =3D "microchip,mcp9600" },
> +       { .compatible =3D "microchip,mcp9601" },

Missed driver data.

>         { }
>  };

--=20
With Best Regards,
Andy Shevchenko

