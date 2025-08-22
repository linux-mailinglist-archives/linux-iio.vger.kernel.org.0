Return-Path: <linux-iio+bounces-23149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15FDB3200F
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66749664DCE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D81D25392D;
	Fri, 22 Aug 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6wC64GY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B023D7C6;
	Fri, 22 Aug 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878284; cv=none; b=h8uTowkfEUIc2mJlf4XCP2pbUDcbggnPRzQ+Oqicl6fq6RupuDcDaXqpv0D7WOx437OsAFLjkjVLkNnVkcDzdiYcGIx5qrulY50llfJpVhtkQJNatp/fIqUl79yxvMNJWwRKqIexd0w6Xz8ITLcJAMTn/dU7bOhODDhLyQJPeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878284; c=relaxed/simple;
	bh=bF26FsPaTRyx6UsVlmBqbfbhZykwvFOLYLX/RnnTyR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+zYQYFSm5iESymvJs5KHn+Rxe8umQ9X4WoTxCGKp6vbkP9sKBDfnnkgYETZGQRt3nXylrYtffNvk5D3RJbaCjoVcIkQ6aeODEDc6gl9mbVoCXhhyb8J1SDTI0ZHhDD+dmOQ+mb1k1W9QLmUC1/HJas/aq3om/9HdsnMG/vrCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6wC64GY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf6fso1124168a12.1;
        Fri, 22 Aug 2025 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755878281; x=1756483081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWwhQvkwseWX89ZiDKOLJDX8HiWiWDKqSvWJ0KUmbz4=;
        b=a6wC64GYnJUbpQPqdgtq4AgGNTLzzKYXg1wKjdJ2L4yn87hbaDqtNq389pr47EThl2
         2SU3VmjiS0YbD0lXZ4UE1CG1v33JfeSIyiwb0tI95361oiQCz2rWZhgwckh5Km/rG12x
         ERVSErSoW5Kp9DGROt4PZRn2Z6dstNI6DDqOAPbchLwNyu/5uX39B0Nr8k+Y1NaTN6qW
         qPm5MAQ1s/CxeL7he7iytdjrJQNlbQXsRqa001X/6/WYWEVAzZpAmt8S/G3CegBBL6M0
         0Cpf9E+s73IhMbVutphRPL1tyaN6L4420slhwYLzcfAvHQnZ7Hp4piMZvB/uWFcEUdr4
         DpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878281; x=1756483081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWwhQvkwseWX89ZiDKOLJDX8HiWiWDKqSvWJ0KUmbz4=;
        b=RIasRnWKQNR2ssuhmxXYzQGJD6/exfecuCmzpOxzBt5pLKqS+gkumC2GnaLeG1G4HF
         jNqZ6MQZA/1eDMXi1TWq78cw8WwsJ5bi4WzZaNKv4ce5ti+NW4E0jNRdop7tWcbx0/z8
         fPoAy1fepxqD65gVpRnVT/MmrVyEvGQ2b/fR1G5i7vMbY0XjXWWm9EdW7UsZOTtA4G2w
         53CG9vA6xvpL38qSx2ALQ1Snwz6JFBsfoX29YUHcayLXBRrogi602orJMHqvPkj31DyA
         vla4E0ZLgq3EthHair7csxHtL3FpkZSP9a9EMwXBeBfuEChCuAhzvXDd0u+5sWg22eCO
         BO6g==
X-Forwarded-Encrypted: i=1; AJvYcCV9MB3m6zHz62QEraNIhnhVIrc2qUtmyj4MDLVEBK9nM9tzUXjIqV+OknV4iKOgW9ESziaP7sd9i8GF@vger.kernel.org, AJvYcCXL2KgB8c4Hdm0ZuAW1uDDDkhinIuINV688MCDuAu1YjnNIbRrDutCBi8iZ8/d4T9HooYG5oX86tmD5UfWT@vger.kernel.org, AJvYcCXxPBiO+Nxqq1mPZBrx/ooQDdkGYrL/AHqv4nfKeTR5DxFLU908YMdUDu6GK4NGzGxt6wt4pqxghBcT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PP9qoro9V/A/SPOB0DlPjsr+ZUhRQYLTO31waznhXOg1RDvi
	CJbpAQXYBgaWtQXIBKyHjReUY1adXs7gqcpAs1m7iWPtzL7QdVIXf371jBTpRgjH7VM+bAsTiLN
	sYDmvDWO93miFmmR0VOAw6qhS4FcpC4o=
X-Gm-Gg: ASbGncsTOvsQ9fU/UlYc1J36BLMG/iBKLbLX2tXJBZnRnBwAjZE66vdqwtBAkp2XB9p
	sozwoFLB5G947ulHd5Dc67bIyKG3NTmBLq4H3Js//azjK6r6NpJXgHSoxLBy0o2NAdc6lnBAnMG
	eJ69qQt5jUqwuduTVEzTnLRx/Ab3sWrZGdcHSRs7pRfOt8GbYIALtya0CHguuL8xPbe1qCAizkT
	mIYRaQAUA==
X-Google-Smtp-Source: AGHT+IGjP/DxRM5ah8EzSR4iMCcnrsqNmIzUWo9jxC/gUjnoWEwdWH4+iMrPUUtpaAbWjm2z5h3MHcoHcz3CAtK+kXA=
X-Received: by 2002:a17:907:3cc9:b0:afc:a190:848b with SMTP id
 a640c23a62f3a-afe2904652emr359004466b.39.1755878280397; Fri, 22 Aug 2025
 08:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com> <20250822-upstream-changes-v8-4-40bb1739e3e2@watter.com>
In-Reply-To: <20250822-upstream-changes-v8-4-40bb1739e3e2@watter.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Aug 2025 18:57:23 +0300
X-Gm-Features: Ac12FXxRRqM1DF36R8l2Q4NCibzIu2oWImr-siqGfaTPsAKKaQWGAPMonkcq55U
Message-ID: <CAHp75VdMCY3=bL2t7zWw0D1WqtiLXrWi+ptjpaxK16b8J1KVSg@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] iio: mcp9600: Recognize chip id for mcp9601
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 4:24=E2=80=AFPM Ben Collins <bcollins@watter.com> w=
rote:
>
> The current driver works with mcp9601, but emits a warning because it
> does not recognize the chip id.
>
> MCP9601 is a superset of MCP9600. The drivers works without changes
> on this chipset.
>
> However, the 9601 chip supports open/closed-circuit detection if wired
> properly, so we'll need to be able to differentiate between them.
>
> Moved "struct mcp9600_data" up in the file since a later patch will
> need it and chip_info before the declarations.

...

> +struct mcp9600_data {
> +       struct i2c_client *client;
> +};
> +

> -struct mcp9600_data {
> -       struct i2c_client *client;
> -};
> -

Seems we discussed this. And my suggestion was to defer the change to
when it will be needed.

...

The rest LGTM.

--=20
With Best Regards,
Andy Shevchenko

