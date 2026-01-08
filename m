Return-Path: <linux-iio+bounces-27537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 915DBD0437E
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 17:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BC18314786A
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1EE4377AE;
	Thu,  8 Jan 2026 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqTuLhbQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662094377B6
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864219; cv=none; b=rxhXDeeI2Joe54rYK1zb+Uv/Js2UASTpXN3MdwtNkobbeRiZilZ+PqrnQMh/eG+KrB0yTSqNN/vgTuSgFq3Sfj1n0RO32DJ+5CfN1D0IBxbWMGx3hMh1j00Ynq4ZC/JXoAwKZRioiLtxWYtxUvxBhU3X4Z4wzv/k6nO20ctj/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864219; c=relaxed/simple;
	bh=9sz8M4OsqrEjFEAmvVMnzAkqFqxEQfWdTfWm/sqJViQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABiWivfrW+fIeY7T7N3uvunxkiEeLRNsN28xasxal22oef2DoLMOLRKOArP2aG8pswdXdlGkWrrcpk48sxgXVsdhyH+ErpRzT251C1JPRxm7V20ZyuJLAUSS1rZ20yFQY5IR1pxRvywLcd6OqpsdiwD5u3ibAyF19DW8CvTbhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqTuLhbQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so4932887a12.3
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 01:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767864211; x=1768469011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU1W9vjYgato43VCqM2Yhhv+kz4vo1qTZfwIEGjNHVs=;
        b=DqTuLhbQ+Fwq+x0fOEtvQBY52myONkuscmoHe3RFZ0cQworwaGBzGz37JwPEfy8hRt
         RyPdvba3FLcNfoi5BzXac6FtnA7TiJyocalMI6nvobXSp8D9T30KSXrQlW5+/pvpiOO+
         ROCmFGLxkm5gwGm9lsnVq/aPmG0MU2pYgYRvg3KhHSoJ5Mqd69XyVOTM4znxFDm9IZmI
         EufRwxKVJEEJFnqI8wnhu7HVOLvWiATBs0C/bIJfT7vAaWjagDj9OKCMti6TI9AUdpMC
         ceKuJ+QgMs63Z6Kicd2G3O6aH0Uu0vUBpl0Qvy2DcQrvab+6zque7gNxoItO6MrLAbFW
         S/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864211; x=1768469011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VU1W9vjYgato43VCqM2Yhhv+kz4vo1qTZfwIEGjNHVs=;
        b=KjQLFY7voSuYlTWgwdjWm4rG9kF6c8BPCv/2r0UMLKJbXicCpL3dsZMqITBM/Kc1EX
         souIE9uqahI1DgH7052s7olAVLziAbJCHK4bzBTQU+1K57OVgv/R0kfr4AzuBYZH58jT
         P6DVGQse5OT0F4ZI6jwplWhqMiqPIgfEFZGLlA7m0dd0kxiGgs+89GqKh2MJni/VGoPZ
         vB+7SzEoHvvQFxGmvJiHI6kh3lNqv27r2bmcObuYvfbie8FO5oOl21QF1WRs0YcJp1km
         lZmfYcgBunSG8JRrg7+WDpy/swA+bogifudNPm/BI4zQiP5ZPW61IuJv0gzwUjqSk9Ph
         mZQg==
X-Forwarded-Encrypted: i=1; AJvYcCV9V8Z5r9gMpQ/eY0e7FlDuNksrt98Ai40tuOHJzH7ucH6+j9V+jDO/OM7RUFGQLPZD7HEzKRLwL2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5+Fk1vUx8mvHZr/z6vuIjTTizd1j5fCASYPEugWuUUTWqNfp
	0SqTtcO9tjBVt+yJVuYemEg5ecW/rAEJHM7dqB3JkFWZmsOhVnqQDLuxz9nr64J/xJgVXj+yckC
	V71wPu619SAeQvJkhl2GCE0D/Y7v59JfzbuST
X-Gm-Gg: AY/fxX4Ol8QJPVMPM1QZ3LPkDwrKY2oWHEbN166zcEi8xwn2NFV2kKXTJcVAhlrPI2y
	LpBf6rajuh76EWvMHWQIxP2fZbOyKclgQ3J9YtY1vc8uSmARY0FmxqeiM8wes1SFL+rcVNfkaXD
	3prhnxjrLD9KcOkDj1KWh/80yV4FhggdHL4QuZs2qtnewKDwXdVbRwp5TH9sOlpDu06stRf8Re2
	pHz2TT/OqULSR1PyVIGq1AEoqi34Z8Jzvb2N0Ykt51do1y8LQXpnADNkLR+tHcZGaV6W1oUKtyJ
	FrSeTI95ZQCMahsd2SmTfPZWRaaSDrG0yNHO4vJrysX7sBp1WrmOlWlX2kD7P7Vz3NXs1aE=
X-Google-Smtp-Source: AGHT+IF4WHqAxLGzQ48L8HrgeFKpDmc5Kn1kO0ReW4eB+ZK00AM8+WRNSNjUYLRuTi74PrlPQwqwB9RUtzIoX+ZFFdU=
X-Received: by 2002:a17:906:ef0d:b0:b80:3fb3:bdf6 with SMTP id
 a640c23a62f3a-b8445336254mr520712166b.40.1767864210451; Thu, 08 Jan 2026
 01:23:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108083924.2579676-1-nichen@iscas.ac.cn>
In-Reply-To: <20260108083924.2579676-1-nichen@iscas.ac.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Jan 2026 11:22:53 +0200
X-Gm-Features: AQt7F2rOD1BPm-IQcVO3CicdxkcWnQdZKzOSQK-MqHLuy_HiBXkT86Bp-4MxSDw
Message-ID: <CAHp75Vdiq0jhRV0SuQ9nT1NvSqnpv=3T6OPOLogkrT3f5kGt8A@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7476: Remove duplicate include and sort
 the rest
To: Chen Ni <nichen@iscas.ac.cn>
Cc: mazziesaccount@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:41=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Remove duplicate <linux/bitops.h> and sort all headers alphabetically.

I'm okay with this change, but I think ideally it would be three
patches in a series:
patch 1) as your v1;
patch 2) sorting the headers (as here);
patch 3) getting rid of "proxy" headers, e.g. kernel.h, by replacing
them with what actually is being used.

>  #include <linux/bitops.h>
> +#include <linux/delay.h>

>  #include <linux/device.h>

^^^ needs to be checked if it's used as a "proxy"

> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>

>  #include <linux/kernel.h>

^^^ This is for sure not used as is in the driver, so definitely has
to be replaced.

> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
> -#include <linux/regulator/consumer.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/err.h>
> -#include <linux/module.h>
> -#include <linux/bitops.h>
> -#include <linux/delay.h>
> +#include <linux/sysfs.h>

It's up to the maintainers and to you to resplit, send a v3, but
again, I'm fine with this version.

--=20
With Best Regards,
Andy Shevchenko

