Return-Path: <linux-iio+bounces-22971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D794CB2BEBA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 12:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14F25637FA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667627991C;
	Tue, 19 Aug 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8gl50rQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999027933F;
	Tue, 19 Aug 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598755; cv=none; b=ZAxd5XmpCtn2t7svNWyo+ndDzqV0/1WCROxlA06upmJK0U6HCSPEc7Zt6f8OsWHsarepL8ZhTUDbdHfPYY4DCMZQRb+R5FOxnIy50ILUDAF9xkQN7UJvGSifr1AkbgEXx/aJdNckhHho1uuF+d8iqzbfLpSwxCpmd5sRuqrgVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598755; c=relaxed/simple;
	bh=0EjDE6u8MVcC/51W3+t4Ut7a8LrhsszVT2OFAaIuc5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ns/VHB8F1+a6852K/R0/fdwplOvzRllpS5ESjihI7S2V7xHYHgyNjd35Zg47cGhrM625n1ilX21/Em+Qss/3RKQwEdWvjw5upR38aEHeMQQokyFEe8YThv8cK1Tcxa/zIQK380st1R79tu/iNQhQuQ9SB5SCyXhK3lLbtFIlb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8gl50rQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb78ead12so721834566b.1;
        Tue, 19 Aug 2025 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755598752; x=1756203552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0F7HokeKW0p2jlg6RLl/yITsSEjXuBKt+Z8fZSpp4c=;
        b=T8gl50rQnAB6Mz0ODtOcCm171wieVyWFuHfP3Rn3Qat45A1AECee/yyWmtyBL9G34M
         EkJmyrrcAVrRLeF5uEl0T/bY5ZxuaHNIhzex/znnDHrXsiKGL2vtyFOHL9pxjnQ4HPXV
         cNmb9EUg55yC7RjwJILB+E37KssvzY3M/yEkDf6Ph+CORe+yuGU0nVbVShEdL/DUC26K
         mzooXENWTUSoxd1RMf7tRXsmlEIF8XNiqYhqabfolhTFO2cZuHqu1oXBp6K+r+x2/TUq
         PtfcYOdcTBjJAp2iYSRH1MVBYTl5jQlZ+YUBthCW0A69KUSDE3bO5Z6c4P7qZvOVtQaT
         aj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598752; x=1756203552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0F7HokeKW0p2jlg6RLl/yITsSEjXuBKt+Z8fZSpp4c=;
        b=dP6vfaVPmy9ZboYm0Xid8P6WTrkmOKDyBp/B6tpaZeXHbxU1KWmLvZ5eGcaqfhC4A3
         c+dBfDEM2ndK1aaGZdKT1xVfv6l1inMB3z+xiVehADuSElPBGlVKw6qI3/eKNMbOk7RG
         gQRj8v9IMBXMHToAG70ki4HnysvAklqzDHcirkQkkNWLWGzB9ZRw3MMyrUgN4caC7d8e
         l/AtgDzWto6BEqNGQJEqcm3pUUbzA4Q4r1FqDu0ykuOvyaEcUPLXchmWj2ytcYYEG4lN
         gdJj0AbpDRy6eyHIO1nIraiVcQqPkMLgud2LbWDi+nedBrg1+gfudR+jy9YLA0LlvCVs
         cfTA==
X-Forwarded-Encrypted: i=1; AJvYcCUG3RDozDtQGZ7AqmJwvJo9ESDxbOL3xD46o37L8mttt32+g3CZkdW19mJiLA8FowUfqxDJDwcISXi2m+As@vger.kernel.org, AJvYcCV1HJpciVZcaxu42VrCUPkLz8F5Xum0sw6s7ECct9AXh7+h+E0Sr7b0cLAd1PNkxjSNjGzUs3R2QgVJMGCyjMU=@vger.kernel.org, AJvYcCX0wtIbHxNP73mLFFZ8gnZ191c0rQp021FhdIhHOVTEeJsICbWLGjeiE5xx85J4iI5oPAY5zaGsQct3@vger.kernel.org
X-Gm-Message-State: AOJu0YymDYFmgIV30w3yPblUGIf1ij7DDr9Cu2taMcBFrjHIMOpzWYJ4
	zhdTfIUAhYEIPpYjYYmNqZ6LorS6XekGoHOKAt8LlbeeOtf4w3G78kjV9XpNStMpcPRUbUIADVJ
	1K9NCqPDg17YIloXzJ0bemErBNT4Gcw0=
X-Gm-Gg: ASbGncsZEFy7B194Hydaqh/XVoE9zapbehqmIds7chfUN3JZtipdwoN3SMKOIi0Psyx
	KAi0/sXOtVqZuOqI1t6MgxLH9YZUHedQYNJO1bbz5xTStmhNvNsP1whhQLoi7bSFslRhgRZdbyb
	3KL8Hhu8OvN14Z4sECXNsry+lTcIYR89PpfxzAJg7N7obXz/xKV0Kl7CU7y8nScC32SN1evDVVW
	chsSoE=
X-Google-Smtp-Source: AGHT+IGGjeNefxzAMSN1CP2wWZmnG+PIp5tfLgOlWlZMZo4Lw2zH/uXQicurb+A2YlzP5qYe5kKRv+n4rxgYXRICgnA=
X-Received: by 2002:a17:906:fe45:b0:af6:3194:f024 with SMTP id
 a640c23a62f3a-afddc959ba9mr199360266b.13.1755598752038; Tue, 19 Aug 2025
 03:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKRGXFJxf2bdQE-Q@stanley.mountain>
In-Reply-To: <aKRGXFJxf2bdQE-Q@stanley.mountain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Aug 2025 13:18:35 +0300
X-Gm-Features: Ac12FXzUxhxJrxVkC6RXjHkIPb6PsrC5d1P-S_yz7KtfF4UKmk75MM2N2qEHTsk
Message-ID: <CAHp75VeTL7mJ-Ttgpkjd5A04DgHqkkPY90LtJriQjoaUZ0TbhQ@mail.gmail.com>
Subject: Re: [PATCH next] io: proximity: vl53l0x-i2c: Fix error code in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Waqar Hameed <waqar.hameed@axis.com>, Song Qiang <songqiang1304521@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 12:39=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Commit 65e8202f0322 ("iio: Remove error prints for
> devm_add_action_or_reset()") accidentally introduce a bug where we

introduced

> returned "ret" but the error code was stored in "error" if
> devm_add_action_or_reset() failed.  Using two variables to store error
> codes is unnecessary and confusing.  Delete the "error" variable and use
> "ret" everywhere instead.

Agree, this is a good catch!
But please, fix the Subject to start with "iio:".

With the above comments being addressed
Reviewed-by: Andy Shevchenko <andy@kernel.org>


--=20
With Best Regards,
Andy Shevchenko

