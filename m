Return-Path: <linux-iio+bounces-2409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FD0850A77
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 18:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583C21C215E9
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D25C613;
	Sun, 11 Feb 2024 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAaVsN72"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911832C88;
	Sun, 11 Feb 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671379; cv=none; b=eEx8Lt/HBFDN1vfSz0I15F02I0Xnz8Lgze4M8zkDMb1lGRl3cJQ3FwJjBc8rdjQDRn6QF+VXVz9UQP8x742Hf8pn+SD3gGguAajJ7igf7Z8sXxtU77p8ogRT6jYy2KVZGYNJQ/ocSyK9Y4/8kcgX0AK2K5ewVquTQ7qnem5E76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671379; c=relaxed/simple;
	bh=++cbGB9xQRfot9YmntaBcfYVCy+hx26IIP3U0QMqdig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AX+qOpyjvDKNeq7Sw4xbFhfnw3awMqOxQ6CRyGt0FOVKq0ipUYCyB+pC3Wg/tmEW54nJHjaYEMJoF40fL8ShZFBxgK2PjHLldPx5m+5TB7b8nhv45zaTy7Rrsxf+Cfb30b34QRv45vM9QdVYcJQlqWvXgs7KY170ZRawmpS0pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAaVsN72; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28a6cef709so333051066b.1;
        Sun, 11 Feb 2024 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707671376; x=1708276176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv+CwvhxaMqwdAIaI6wlp0ZZr0xPk4YmL98DlWKGiAI=;
        b=EAaVsN72l6gwdL6d/szU87mGkWlMC8goRQH/+iaF1MHmIY8ymCJBIkxqmI8dtjidxS
         evBdbaj+fnh7qCmcNhSXzAuAZFDt53+JyTSuN0eEzsrDPArK/l9B4QLEgFzdz/YuA9OJ
         YulQrkgjOpYnAkamoIu41DazUbSTMzEcUE/eHK7OI3t3awPHWw3/R5QS5HRX4X62xwIu
         gaLQZ7k1Ek7cFeMx2oJR74XNKZ6JsxlBcT9ny3QcUXcW1zjBbhoAZ3c2pJ6IXIq2LK3L
         wP8VNKgu4LBj7nWhj9/LV0sBsOWucwwUjwddMSlqGNNFggNYBxsiriYM5PeKb32r4L4M
         iIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707671376; x=1708276176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cv+CwvhxaMqwdAIaI6wlp0ZZr0xPk4YmL98DlWKGiAI=;
        b=UbdE3ddLy2/InpzwhviI2lBwxK2TaZxI2GX9VeMP+T3cE4XgYxvZFm+YxZC1hDXpTU
         eJ60Fvf4qjX2IzOlo++1kpOFRYlPJXIg+OqSwhXJHZFt1v8HQiV65oyTB/FRd6HcvGIG
         2fIpRrcrUvoi2yasGCioRAtQJK3lUqEZk0iqEHEB37CCIvF9pQwsuLu2EO4xzGnxWvDq
         WUZTLuk2wPOkxK0Hsl2kJSD08p/2Xma9lD4LOIh/5s1CpBrbmJuoWV+2h5fHGKdraAe9
         Iwd7MeYMInwSa5hzGzAZ9CEALuw+RrtVa9J9bgl0M/ohzsTmpMOfoxXNDfkuYUMa3Eum
         aLiQ==
X-Gm-Message-State: AOJu0Yz0gUMMvwALmf28Q4QoQWf4f1gtjo3s075rvjCiQJUoF+TcXX45
	QSCLdUG0YcwjNwMjfNaPrHgPsk1JHktYqt3DHWFEJmB3V5oNmxWFR6cBNOhBUToR24gwzHxRbBg
	fUMy4ryyMJYeDct5lmiCu7hXb8kc=
X-Google-Smtp-Source: AGHT+IGdFo2zjWWk2wb3AxTVv36prVLix6UBS2q6vuSQQT6Krp7ucsjSybmx+KXNebK84vihwEWCsLg/RbNhNQs0KWI=
X-Received: by 2002:a17:906:1c4a:b0:a3b:b0fd:dfdd with SMTP id
 l10-20020a1709061c4a00b00a3bb0fddfddmr3316964ejg.41.1707671375756; Sun, 11
 Feb 2024 09:09:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5769241.DvuYhMxLoT@nobara-ally-pc> <20240210164956.3d29e3ee@jic23-huawei>
 <4923946.31r3eYUQgx@nobara-ally-pc> <4956451.31r3eYUQgx@nobara-ally-pc>
In-Reply-To: <4956451.31r3eYUQgx@nobara-ally-pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 11 Feb 2024 19:08:59 +0200
Message-ID: <CAHp75VcFXSfV4rPDaJcUVC92QGK3U55AqQqPo0WYKmpcKnw+eQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
To: Jonathan LoBue <jlobue10@gmail.com>, Hans De Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Platform Driver <platform-driver-x86@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, jagathjog1996@gmail.com, luke@ljones.dev, 
	benato.denis96@gmail.com, linux-iio@vger.kernel.org, lkml@antheas.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 12:34=E2=80=AFAM Jonathan LoBue <jlobue10@gmail.com=
> wrote:
>
> From c65d1ef44d749958f02d2b9a50a0e788b4497854 Mon Sep 17 00:00:00 2001
> From: Jonathan LoBue <jlobue10@gmail.com>
> Date: Sat, 10 Feb 2024 12:31:54 -0800
> Subject: [PATCH 2/2] iio: imu: bmi323: Add and enable ACPI Match Table

Something went wrong with the email body.

> This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi323
> driver with an ACPI match of "BOSC0200".

...

> +#include <linux/acpi.h>

It's not used. You don't need it as the proper one is already included...

>  #include <linux/i2c.h>
>  #include <linux/mod_devicetable.h>

...here ^^^.

>  #include <linux/module.h>

...

> +static const struct acpi_device_id bmi323_acpi_match[] =3D {
> +       {"BOSC0200"},
> +       { },

No comma for the terminator line.

> +};

...

> +               .acpi_match_table =3D ACPI_PTR(bmi323_acpi_match),

No ACPI_PTR() in new code. It's more problematic than helpful.

...


Above for your information for the future contributions, as I said in
the other patch comment, I think the better approach is to enumerate
from an external driver under the PDx86 realm.


--=20
With Best Regards,
Andy Shevchenko

