Return-Path: <linux-iio+bounces-27572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 696C3D082F0
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 10:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 931653065155
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AAE3590C8;
	Fri,  9 Jan 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7D3DyUp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A483590BF
	for <linux-iio@vger.kernel.org>; Fri,  9 Jan 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950657; cv=none; b=O3bYlVXH1BzeAS8tCgMKJlE0A6ZPguD+dpwXf/hAOl3VjS+lQKurfxdxlhUFvCux/sMKaGZbNVP7muwBh04+URVWbY+GuNQOFXohE15VyVTOE04nUrGEZH/vfiVOfuW3UvrbSE5YgSbSd8YhsWUDjJeF9e87Te6qEcup42q81Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950657; c=relaxed/simple;
	bh=HMeW2z+HFuisPVGzHUTczpWuqgiqCfXERh3hoCQJz9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Utc4AKtOKJSFtUKKXFhECE8hpkVDykAg5iHldmVUL30v3z5v6dl5OVdenchauTJsTI/2mMy06w3vM/YcPuZErOsCzBpqgpdrg0b76OILOW2/uuF1ZmyGHjOotwiQ/YTls79+lbRGDBR/GFvPClJjR4SCH0KX3pB8nCpqO1vR2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7D3DyUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF79C16AAE
	for <linux-iio@vger.kernel.org>; Fri,  9 Jan 2026 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767950656;
	bh=HMeW2z+HFuisPVGzHUTczpWuqgiqCfXERh3hoCQJz9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p7D3DyUptWVxuCIUv1bgxZnwCUjGKIUMtzt0hpIsjr3Uf+JuxU8K/1fXMxnPUmVJd
	 f2XL/N2kV9vuzAKY3QboFywW1aKSTsnnqVB1KViMRTIeKPcp9ZKZfGR3VI1izx/NV8
	 bROG0c70b+Rk0tSt83xZZYmgD3yQd/V5kBXByhYuYCTiF+iX7BBN2o9SqFwqYMhgvF
	 VkJ1xJW+0bxq98rIeoDOXx+M7aQmqNQjfyzJVvO+LyxgP3luZgw6f4sl9ISASXB3b0
	 Ri652LazJvksTLzHC2PG1UtfCjDDIF+gF45awqii1/evi680wd0Q6jMVeE5kMbt633
	 TrlnQs1E+meqA==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fba1a1b1eso44783277b3.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Jan 2026 01:24:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXy3VL3VegH7OU3n4ecTDbe+DNAEM68g694Uxt6GDUbU9DtNDG0AjJ5FlYTHRj/7lkBtqjInfW76ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKJ73tYM6SHi8G5SzFg5PohSPmWsdVwEO3mS8+romM2Ics4OD
	4QEsDV/7JM4P8A9O/iPfgqtXdf0nZyek8tb+6B3dW+v+FjOTva0kmcC19Bdzd7TTDxpF6x0Q0Om
	xw0ARgGSw9MQPsQTg9Yg9+zFY37P9Wb8=
X-Google-Smtp-Source: AGHT+IFfGOMHcBu+Lrr4wQSB5LAgjIli1+ouJok4/eV+kbpe+/OT6QPHsv/5w7mAmTRLx1Y0FIA1JgDvFqY17XZrCq4=
X-Received: by 2002:a05:690e:1c17:b0:646:7b7c:2faf with SMTP id
 956f58d0204a3-6470d2af77bmr9864715d50.20.1767950656041; Fri, 09 Jan 2026
 01:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org> <20250621181733.3cb6111e@jic23-huawei>
 <07d91b36-dbeb-42b3-8dd7-b0771df9b306@mailbox.org> <c42243fd-ffd2-4144-875e-b156133eb031@kernel.org>
 <7d327efe-94ce-458a-9394-eb5582f1c263@mailbox.org>
In-Reply-To: <7d327efe-94ce-458a-9394-eb5582f1c263@mailbox.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 9 Jan 2026 10:24:05 +0100
X-Gmail-Original-Message-ID: <CAD++jL=OhmJmiq+osdZysfJ=U4mwKcuNVUY-RKq-xO_YZpeP3g@mail.gmail.com>
X-Gm-Features: AZwV_QgO_ufNRha8CReUDjyVTL4WG3n5KUaC08N3jKYgtwLGyhruJzCx-wMjHFs
Message-ID: <CAD++jL=OhmJmiq+osdZysfJ=U4mwKcuNVUY-RKq-xO_YZpeP3g@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Julien Stephan <jstephan@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:55=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:

> On 6/21/25 10:14 PM, Hans de Goede wrote:
>
> Hello Hans,
>
> > IIO has separate interfaces for exporting channels which can be polled =
by
> > userspace and for triggers which is a more event driven interface.
> >
> > It should be possible to modify the driver to skip the trigger registra=
tion,
> > while keeping the channels. E.g. iio-sensor-proxy will then automatical=
lt
> > switch to polling in userspace.
> I wonder if this got fixed by this commit in the meantime:
>
> 3aa385a9c75c ("iio: accel: bmc150: Fix irq assumption regression")

I think so.

It was causing a NULL dereference for me, so I had to fix it.

Yours,
Linus Walleij

