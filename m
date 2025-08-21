Return-Path: <linux-iio+bounces-23116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E213B306DF
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 22:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C337A39C0
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 20:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA212FC01A;
	Thu, 21 Aug 2025 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hWWY0jRp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981622E8B80;
	Thu, 21 Aug 2025 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808325; cv=none; b=jzczpfF9WtkQQDIYLJu6hamSkDxOn+AkbG7MuRZ1zNwJ+aBeI6HdQ3EBKlJqUOUpUociwxii+y2rAfDRA3jUM92fMm7+u76JEZU37HChsVrZPk1K2MroG+ZQRW0tuBdrOFJUDD0592+AfX0C13Y25wGxhTcXPvQ4IywIzEckjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808325; c=relaxed/simple;
	bh=koAxHIBSFF6bH48Q0RNFABzF3yhUiviXXzFvJ0pZf/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHL5MfS78Uf8ty4T8zPt0YR366864H8cuP0m3W2wSf1WFQQc+f9MqhxKw4Q81eOaVIULn7h50z/CuXI1MjT8qGfJ9XXSaDDhFJCjAAhmc5eMwDd0Eu/4UaW3LjK67zPKF62c3wu39RPWnCDeTPuu0QrRWghenpMoHCnAjzEZDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hWWY0jRp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b471754c159so945921a12.3;
        Thu, 21 Aug 2025 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755808323; x=1756413123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzt1SP3iQ6Mi6cPK5jzb7ybF2HUvqkuc1RDuKVXJJow=;
        b=hWWY0jRphgpJTb9wdmFt6E7du7kpxgqvPbfe6xxt+XZG6TCkZlBmvOfvBAqzMcKcaB
         rsy2XJtdcIMzvGeu1Y5yBtXfcIGRoO02YTjVFrqcR2Kc8YILWVaDmUGvh6mOh9lSTfQV
         mq8WwEer8txHODdGdS+4wuRMbj26EoNwLPrzDps90Zy11Fz0A7LgN3L/AjVH06pza0XL
         SUwaHd4XRoUUoLeCENGeTAvHcqopMkHUKo+k7LzskNg00R2zwRt8+F3/crLg1ksNoCf0
         /w/uOPC/69va02AFm9gMHqeS3S99Zkk4Q0vJI1umSrucrfRc3zfDsmOwWlRvmmFGw/pJ
         1NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808323; x=1756413123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzt1SP3iQ6Mi6cPK5jzb7ybF2HUvqkuc1RDuKVXJJow=;
        b=EfgSJR1QBiSbI95kKz2cLgAjyhcghnZZmumDvuf/QD6cisJd1qeSSXovaRAeV6zv9F
         ixFytMbKGxzU5vw4yPORlKKh/TRVFZR+Hq1szugfhj00fUbvm4ke6XtlZKl3cbyXi2xX
         1B1zB4f90X967mtF1WGscF1/GUgjr+mZ4cFywZZJ9L4gr8AeLkN3rigJSm/oJI7FO1Vc
         qFj7b6IFk2EZqZggP9/Az0P8epdRb2/k3EGB1gBWEq5s6B9VYN7lVxkAp1/736pdQJIH
         8mKYjuS/YIXF7IYzt2sdRL89as4vN/kM+DhGLO1W0txXmv3Pqs0FR6MUlAtmP5gh6WUN
         XDfA==
X-Forwarded-Encrypted: i=1; AJvYcCUjCTXFKSfpcXQtg1Yfd2KaZMfsTpQWJ6L0InepnCTwny1FhQHN4qgSlOoKrFZlEwYULzYu0RRrrf4=@vger.kernel.org, AJvYcCWzuZD/qWohl2IQ26c6hjZrFgn3n5a2y3JHZnmPv+O7CeV2zFP/qPIYOc6mPvnkIS2PzurEsHsFQaJmTblY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9NIOKS6dNtxUm8qdfPKcZxu+oObnUQPJryBQxZ3UmRYATc+q
	4j308ZspWkLqiwfpHUJlTa3a9C2Sby3ocrns/oX5YozGGKLm3onqwjp7+NOICttHuM4VAL/7m9p
	kwZWxcIUA3XN48q7P5ZPYlYi4KQrqKY0=
X-Gm-Gg: ASbGncuTthJ5e4KEhDehUn53AcPjO2zZCc2IxJ2D9FY/i+pCMd0t220n0ZIMr59WQQe
	NN9RuZPO1jtppV2CDDI0bN5Fq0qtviRJa73e6pcparPF78k5VJouo8HvMq+0rdHzKEdV72QJ25A
	DhjYIpLk491jZSZVw+ZAhHz+ECsVM8SY6NGsCZYZHpZz4f3A3gYeBGEq8sQ3EMMux6bzNQ6WG+f
	GyuTj5JF4+x0KLa3BZj0ByOWGgbFHRUrTYOADrV
X-Google-Smtp-Source: AGHT+IFMJWQfSak742OMRIUVPAmUKPCtjTTxsMGlopsj+ykj2AINC9Rf8YaWuAZsX0Tjk/DC56u1mBE4PhmXtNwtDIk=
X-Received: by 2002:a17:902:ce02:b0:23f:f68b:fa1d with SMTP id
 d9443c01a7336-2462ef4fd9dmr7514195ad.39.1755808322840; Thu, 21 Aug 2025
 13:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821080723.525379-1-zhao.xichao@vivo.com> <20250821080723.525379-3-zhao.xichao@vivo.com>
In-Reply-To: <20250821080723.525379-3-zhao.xichao@vivo.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 21 Aug 2025 22:31:51 +0200
X-Gm-Features: Ac12FXxvviABKwS3Jk0G8ABxqYSzrQsOIcnTQmwdAPckvZYFYDz7726qKXLaDEA
Message-ID: <CAFBinCDDMo2Dm1UAoB4QKyf-KKoRUTNNg4i7Qh_vgZh71trMNg@mail.gmail.com>
Subject: Re: [PATCH 2/7] iio: adc: Remove dev_err_probe() if error is -ENOMEM
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Haibo Chen <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Marius Cristea <marius.cristea@microchip.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Heiko Stuebner <heiko@sntech.de>, 
	Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	"open list:AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 10:07=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com>=
 wrote:
>
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/iio/adc/hx711.c           | 2 +-
>  drivers/iio/adc/imx93_adc.c       | 3 +--
>  drivers/iio/adc/mcp3564.c         | 2 +-
>  drivers/iio/adc/meson_saradc.c    | 2 +-
For meson_saradc:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

