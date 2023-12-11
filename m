Return-Path: <linux-iio+bounces-811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC480C483
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 10:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B091F21076
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7952134D;
	Mon, 11 Dec 2023 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3MA4FmE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8766FD
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 01:26:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c26a45b2dso22692265e9.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 01:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702286780; x=1702891580; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ViS1cDnQlRj+JFLNGYA503vGafg9qFYbVZY1JM1+K8=;
        b=Q3MA4FmEgNtQ7CNHgLtZgEujhj7F4OuV3RO9wKFxQlcPgzFm+VkMO0nB7zHELYzMPj
         juyYNyAXlJfs603Xi9GLZ5PkcnZthiwHSG5lZHbv7rDr+nGjjz1PJVbw0qpAixUh8MBK
         TW9K7W3E9IgMeCPnV64zQAA/E6lar8g7g1eBshTQ1EK82Z9Otgkz/TtdPb4+utKBqeZI
         3mqXU/xCJ4sHs7IhGZJ2PDpuQuRmc38IlT0sSZgAKl9kOV9AYvtgD9N/rahQ4BA6Nitm
         Eu8bZ/O9jJz8XSIZd6KsCh5ngQz59BeMx3Ock5QsQKGVBZVbbEummIBUj04NyDA5oDCm
         V3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286780; x=1702891580;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ViS1cDnQlRj+JFLNGYA503vGafg9qFYbVZY1JM1+K8=;
        b=H/IAWAbULvjzSG0k/XMlJX/LwRVp0wULCk7F1zTs6zGz/fzua67jQlp/2qHmDDuckj
         Potdx8nzUUzQxI92PDQ/c0Z59CNjhvy3vsK+gFy508vrHv9PzthQBMP0YkmPVCkwbSTi
         ZOh60YLyuIkBxfUwuunNWsINdhNGTcabiLbAjG871h+gWLalX9vYQnQeGxl5o4UaH0Wu
         T1PC6LuQ0BiW6rla4r3wpYnbSAj6otfkYw2U6jw+SZkg63FWDibDWUgp/Bg1sO0mWHvq
         dPq0QY8FZjhZx8iVMy1P9gKAvJj27RaCxUGGG1duFkRnV594r0Xx2ItZx6fsjN8aN9mD
         bbRQ==
X-Gm-Message-State: AOJu0YzzVwTElk4gIo1nO7bdiApIGWQAxV8ZtSuv8UE0BHwiEkZtp9d8
	uG1Ehy+jbT7WWTQ+h2ncLmg=
X-Google-Smtp-Source: AGHT+IE9NssGoxtKnZ0wl/iHWF4LuLcgzjthEjzmZcj3gkGn4dWyTc3HV/HgfIc6sBdSeU9UT5zYyQ==
X-Received: by 2002:a05:600c:4f4f:b0:40b:5e26:237a with SMTP id m15-20020a05600c4f4f00b0040b5e26237amr2109836wmq.43.1702286779885;
        Mon, 11 Dec 2023 01:26:19 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040c46ba7b66sm3476599wmn.48.2023.12.11.01.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:26:19 -0800 (PST)
Message-ID: <ac2361c65738ad97f3cc112cf1a9b0effcea08b0.camel@gmail.com>
Subject: Re: [PATCH v2 0/8] iio: ad9467 and axi-adc cleanups
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>
Date: Mon, 11 Dec 2023 10:29:22 +0100
In-Reply-To: <20231210114338.1189c2ea@jic23-huawei>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
	 <20231210114338.1189c2ea@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-12-10 at 11:43 +0000, Jonathan Cameron wrote:
> On Thu, 07 Dec 2023 13:39:23 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > As requested in [1], this is a preparatory series with some basic clean=
ups
> > for
> > the ad9467 and adi-axi-adc drivers.
> >=20
> > This means that the iio backend series [2] will depend on this one but
> > hopefully we'll quickly get this one in.
> >=20
> > [1]:
> > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/=
T/#ma7ed8a58d747e78e1ff2273c2d6cdd11de22f177
> > [2]:
> > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/=
T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
> >=20
> Series applied to the togreg branch of iio.git.
> Note I haven't marked the fixes for stable, or taken them through the fix=
es
> tree.
> If you want them backported then please request that after the next merge
> window
>=20

Nope, I think I even mention somewhere that I added the Fixes: tag kind of =
just
for correctness but up to you to backport them :)

Thanks for applying!
- Nuno S=C3=A1=20



