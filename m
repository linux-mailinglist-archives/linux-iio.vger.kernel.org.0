Return-Path: <linux-iio+bounces-19915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F2FAC392F
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 07:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000037A95E4
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 05:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F7B13D8A4;
	Mon, 26 May 2025 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfJmzcp6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96EC4A2D;
	Mon, 26 May 2025 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237455; cv=none; b=mXIE4bzCM7aIM5ulZnbRtkD2/QHBHGUZzR5ELe7emUY82a+4wABzGPk2vwlqLd/ugY5ZQLapKQJAY5VqZ8kUr0h/bZSwZOj/iytxm8YBavy+M2UM+kqi0RgB/CFia49kz5bsuB8ULvK1hJv6qpIN7/5irjk2Q/zKnA4t4cKMphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237455; c=relaxed/simple;
	bh=xdgJ/s1d5qleqQQSCqAZIvgqGPyVLwQY9pj3cjg16ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQTnPgLJSJsYqY1dQ7YPZJ+bb+JtzOlU9cpLzb5CGwxoddMvjjnHA1zQBrdSbAqsl/SAldXcn8vxq/cT5t7j/Tb7rcKX/TpTzEK2BsPTwPhG74AnC2nZgSO6tT7R09Vmg/ud3XMeNVp0q0lQ3uQatH4Ums8Tgap08B844Ts43q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfJmzcp6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c27df0daso1218406b3a.1;
        Sun, 25 May 2025 22:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748237452; x=1748842252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdO23MbUOx89Kzc2rQ7utwQi4LgYhCMYtqB+mEcz+FE=;
        b=FfJmzcp6M+Pspcnl1wYbq4/rdnv9BjCdt0i2WBE4f+Xb4GcvMpAzbzvfhYbS/SCVp5
         O0UuNtqyWTbonIIxrqFnHwbdYyGaVNj/khN2/xILeIRwTwhV5MyPt9XsyTJDtsn6/El9
         f5i8OU6upkXlTzKwqm6Zte6ByhuPoPjjfkF6rJVeAES0lt7dMJzBruveqSxfpfR68heC
         lu8cBwltY6Mzuku2XKXMeoa9ZsCqMFVa9XdswJJqlOeGmcNAP9Xac/2sLG1nyMXiFX6S
         jTpA0arMj17IwVgcZuID+VcT5KJWOr5WmpH5wPViErkf6EsT+Ay5gQfq9KYgZApV3YEU
         ofXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748237452; x=1748842252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdO23MbUOx89Kzc2rQ7utwQi4LgYhCMYtqB+mEcz+FE=;
        b=cKB4aDIYJrIZx7FQ51RN4hsGVd1cSR6usTYTh9e2DAGBaaQWe8pRp1FIN60W+je9TK
         bDmrypmR5Vuvw2l4PJK5iCZt/WArWMu66ghbDerGyCp4cuEbL4uXKtXZI950JC/3Ph42
         wqQwhHF4aLfX6R8QXWA7/ocdSzwk6lEws/of+vX7DDDkINOmJ0dFjOPKC1HxYVlCgAez
         oYwi4dEYeutOP9ZVlROlZLiFtzw2kBWkrxNDNyNDnTthKCMWSBfiqxUXh9lawNYJylD1
         Db5YCs2r15/M3yX9J6szaiQHJJMTPAj7Yz+xqZllPlRPhHbvX1QgKnRO0yBQo7162hUL
         51Vg==
X-Forwarded-Encrypted: i=1; AJvYcCW6+bHiUR3AEYxUxan3mK/LFLCWINQGlkFtFGQZSUlyrSXs35oNBhFW5uxwHnYQpbL8VBqgvY0zP6c=@vger.kernel.org, AJvYcCWCTBZep2KPUa0f+m0lZ+dAEsbIqYURA88DalQPRZrj3XDEuTGMsplHh6VDEcT2ncoeSlxdi+EHuVqn6S2b@vger.kernel.org
X-Gm-Message-State: AOJu0YytysIyUS6i6hF7Fw8qL7ojS6Q8ngFoWUxsAXi11ASrDiKmDy+X
	rQ6+djQ5huy4+mfYjWCuU3J/7WWY2STSAgFvwfEIIq9DO8aHIRC9C14uae6N8+DFuAbmGOmdK3z
	yhdDZkmiDV0vd05wdISyZ6I+R854seS979mU4
X-Gm-Gg: ASbGncsWXKWLtASqMXjHnBlZKpddaR3nGgYcnTOMqSrUihDifT/as9e3VfHQs94t441
	vYeGC/fihcvBybaKMVyWO31Gg+m405iw5MoNa3F7+0K4B0wzqSUYqRAE0/7FfhMBUjX1CJHWBZt
	V1UPCmyUrGW+a+UaRrcGbISGkUqvJBG0R+oFxUnAdVvIJM
X-Google-Smtp-Source: AGHT+IENjvfF0dwyW/7RUyfdpxFCqR0Ayc/O+26qxUf6BM2b+i8gHjMhXYZB0HnYTOqt82vaNS2ZNByqUrPq5E9Gjrw=
X-Received: by 2002:a05:6a21:338b:b0:1f5:8a1d:38f3 with SMTP id
 adf61e73a8af0-2188c1924dbmr12589936637.2.1748237452017; Sun, 25 May 2025
 22:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
 <20250519-timestamp-v1-1-fcb4f6c2721c@gmail.com> <20250525183528.14877bd2@jic23-huawei>
In-Reply-To: <20250525183528.14877bd2@jic23-huawei>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Mon, 26 May 2025 14:30:41 +0900
X-Gm-Features: AX0GCFu6hpZGSdGf2LyXPbj3gBPrbLOf7AI5iTMz2mPRdgctiyz0zfM3ndI6cI4
Message-ID: <CAKbEznvdKJx_t2OcYfAJuAP8FVpTjup63Ct6aFvSYuK=-B061A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/9] iio: buffer: Fix checkpatch.pl warning
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 2:35=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 19 May 2025 23:25:53 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
>
> > Remove the following trivial warning:
> > "WARNING: Block comments should align the * on each line"
> >
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> Applied.
>
> As a general rule don't send unrelated cleanup in an RFC series
> doing something interesting!  They might get missed.

Well, since the patches modify the same file, I considered them
dependent and grouped them into a single series. But now realize it
would be more appropriate to split patches logically.
Thanks for pointing it out.

Gyeyoung

> Jonathan
> > ---
> >  drivers/iio/buffer/industrialio-triggered-buffer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drive=
rs/iio/buffer/industrialio-triggered-buffer.c
> > index c06515987e7a..9bf75dee7ff8 100644
> > --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > @@ -1,5 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > - /*
> > +/*
> >   * Copyright (c) 2012 Analog Devices, Inc.
> >   *  Author: Lars-Peter Clausen <lars@metafoo.de>
> >   */
> >
>

