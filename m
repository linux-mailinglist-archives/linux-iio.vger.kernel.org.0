Return-Path: <linux-iio+bounces-23103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333CB2F8F2
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDEA3BA02D
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A220311C23;
	Thu, 21 Aug 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHZzOzID"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F49305062;
	Thu, 21 Aug 2025 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780470; cv=none; b=aDBfvUgBtD0PyCbhieG2FGRUwE1mtM/9I+sKJ8UpmCfoKT2if2tAw7tEkt7fSstxf+lyiIOXBcMjCEXGrVw6KmonwhRh1h7FrR3JbJiajwapTqaKcaBaqvzqai6ohdJtKqo2PIkP4ABzakIGNTUVd+UOtEfyZ4J1h/T3BSGh9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780470; c=relaxed/simple;
	bh=Kww3Z8XQpKUqnrzv3IhCXTW3D/QqhIcasmUvK1+uYck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrFLIiC15LSTdjkSQtlI33Dy7wyc2WwgWre2kXAjLqMQo3L6cG0+UR+IhWHuG5vw6mThR1f/BV+JT2tAEoCjXoh5SnNhqbe4XB7+LrcGLEDi/WWD8WrDtoGhV5iXis2PlIMy/Vv3qMOKcay1i8ElUIk+9XeKM+oxPmNGcppHhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHZzOzID; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so137705666b.3;
        Thu, 21 Aug 2025 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755780467; x=1756385267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kww3Z8XQpKUqnrzv3IhCXTW3D/QqhIcasmUvK1+uYck=;
        b=RHZzOzIDT+HlFG6GhBSyocLV96tjffO7s1kPXwj/0bQWO0GIFm+wm/KMuwqUL2ameU
         cOfi4jdHyN+7pu67M3Ae07GJbvwlr4cYVxTxh9zu6Y22fRhJQl7RscbnWmrf0GYs2FhI
         Nxqd/shVK5XV0n/bPl+GvSNE4n0dBurZzMMwVeUHaCg79KcE/QN/+K77bZKMreHBW+rb
         gFwArLuEJMBGomJurjtKRZLjdpa1uDMZQWnWTI+TGwp2ECWMzz+eM6clQioEFC5VmOxT
         5ZqGTk9Eqnog8Qfw1aDRXfIrUh0u2jckX2lL21rS9pm6R80E8WOEZiwar5Lyacur8/tw
         Ehtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780467; x=1756385267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kww3Z8XQpKUqnrzv3IhCXTW3D/QqhIcasmUvK1+uYck=;
        b=T+5kxt5Ya2aynllIOxZmPcoxGMP4YRPGX5L9b6LN5LVr+arkawcMrBk28k/dkf/Wbu
         2Zra7BegBkAt/HMwXZuWJnEXcKVk8PVCfA+3R0FNDOcyKAYvUADkX+NCRBK63+N4OcPi
         puYr5XY9IoIodXaCHs2IYh+Cb0+wFtc/NuvrrEVnn2DZGktkvh7mGVVxAGgT2Q2YckqV
         Xj9OTzq6INHYBHXeqW60j7rxFN1q4VJqRDsXHF6hrUNpXYcNzGoVRiBGZ6VshJrKITJg
         625e8flkWy/NnBVYp4cbndU+b+1xHLdw1PnI+IqN481+8rg8VtCbdjGuSBoMGrOpVyjL
         rRWA==
X-Forwarded-Encrypted: i=1; AJvYcCUoSIv1uk0ghYX1hrP4nwUtUnFbs83ijAGkdAwVDGX/WMkZBHT7KpYGefpI8ElUQ9s3NVt1FjAzfxS13V5R@vger.kernel.org, AJvYcCW4iCnaCNx+mGor2+GUtmWiMztR0pvJogvIsryut/JkRaOjznfA+xiwsS3UwxKFBfsfHkB1p3llVEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBXE+wSysxsXUQSuJ3lG1EvpqCzEejzvDghX+wdVp1O8FK5+2
	0cGLukKR59d4CZdUsUed7dw/7PJsKwBuCfJcolbTJtpkE8uGw6IDgAd5CNOt7UaUtbyEaImpIza
	CHKfpo5Ap8AWPfct2MSN+my/uM4JolmQ=
X-Gm-Gg: ASbGncuPZ9TNky7LgIS+/YuLnq7g7RC+Eu0iw3+kUk7VCIYBdi6cW4We1RK12dane14
	JgB0z6b17YkHcFGk1geW22YA1mo5R7URMPniBQWOfN5nBwTIsRqHrd7fhVnntxCZcV4svkT5xwA
	9B3j7EuQZnNXhJeWrjeL6NCoVNkJV78m4x2QZHL8t+4g/itQicCiIiXTg/1gN4KayxMyqsTOSab
	Dr6kcFaZw==
X-Google-Smtp-Source: AGHT+IEPEbjECYdBW0nd8xX8lWG/FeWz08nR/1JcSgRS+BCimYdArukTA+i3b9djOGPovIzmf+wskUZ5f9vMyM/jPZM=
X-Received: by 2002:a17:907:9711:b0:ae3:5e27:8e66 with SMTP id
 a640c23a62f3a-afe07a7efc8mr229517766b.27.1755780467264; Thu, 21 Aug 2025
 05:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821080723.525379-1-zhao.xichao@vivo.com> <CAHp75VeDvK8cOr=rVGj_hVX5YzXM-UqrWRBgUrhiA1wzYn7C_w@mail.gmail.com>
 <CAKv63uvfHYATd7ZFweZ0LMfTLt-idHVgYJqOV8PvzaNeigbt9w@mail.gmail.com>
In-Reply-To: <CAKv63uvfHYATd7ZFweZ0LMfTLt-idHVgYJqOV8PvzaNeigbt9w@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Aug 2025 15:47:10 +0300
X-Gm-Features: Ac12FXyAa-NWG2kjb3jWIL5sg7tG4bcy5ylXKO82itEKrqXswF6DvDsUv85LdDQ
Message-ID: <CAHp75VdL9kV2fyi63zqPZnW4CaeYPmJ74tmGEgU=M7FSYBv0ww@mail.gmail.com>
Subject: Re: [PATCH 0/7] iio: Remove dev_err_probe() if error is -ENOMEM
To: Crt Mori <cmo@melexis.com>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Marius Cristea <marius.cristea@microchip.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Heiko Stuebner <heiko@sntech.de>, 
	Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Gustavo Silva <gustavograzs@gmail.com>, 
	Tomasz Duszynski <tomasz.duszynski@octakon.com>, Jagath Jog J <jagathjog1996@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Waqar Hameed <waqar.hameed@axis.com>, 
	Yasin Lee <yasin.lee.x@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:50=E2=80=AFPM Crt Mori <cmo@melexis.com> wrote:
>
> Sorry duplicate - as I commented on driver.

Yep, answered there.


--=20
With Best Regards,
Andy Shevchenko

