Return-Path: <linux-iio+bounces-23091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6C6B2F0CC
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 10:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F28416C49A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EBD2EA168;
	Thu, 21 Aug 2025 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz4uf8rE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC46262815;
	Thu, 21 Aug 2025 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764021; cv=none; b=O15jcEa/dTZi857IlpNxnonVUSnJjuOQhwMmlnxmQvIbFaF1OHNdwaINPvhL1zI5dZmsTXtGDJMOxl99dqebYqoRIDbWz/3MAN0iHSxB6Z5I7DUMDBWcJcFLsULXR+IlGa1D6e1EIVjOq93uZL7wmFe96wJ7r7Si1K+Qd3Ylty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764021; c=relaxed/simple;
	bh=5YQOUvbEt34uyiKkVZzozlI3idOMYzV0MqYkXRUemhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBtWj9FccuWJpi3YjCmfpI8dVry8o8OUoG4xy/xGsQB9tE5ctyG7wm3W+nHhxQ9hH9N87dMPkJALreuYtBFb0nL5NWTNKGyi7yksqbMSHSKTQdbL352aHidagUlVaUwraX+ogYYxzqfNKy7lzDg8EHfo3S1jzdNER8dgzsmW8ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tz4uf8rE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb73621fcso103295966b.0;
        Thu, 21 Aug 2025 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755764017; x=1756368817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YQOUvbEt34uyiKkVZzozlI3idOMYzV0MqYkXRUemhU=;
        b=Tz4uf8rENnVDmzHs+9fLWJRN8b+wokxNuZPTpMhP98G1GyiZY0NTMch03FUl2JFccu
         nnli0fv6WQ81flJ/a4QaJbM23bQj0OFkBrmiFnGWrM4lfSMV9fFo582f/SkYTDhCiyZw
         JzM9LPVcMMTXJBbvohPE4Us4SVZXfcZZlOu47jst0Rbj8X/AFfLplZsL/2UJv/vup3U0
         Be9CK8P5h2/K/81KxkPC7B0n56U9seQPW7YI8gob8hSpbwP01XCkWk9VlqXkVOfYuTSB
         cZKTC3brykF7kcUXxhU0sIIOykmIjXr1VdRQST2UE2zAFMxIy0an8nL5xWuSAwg4fT3K
         2BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764017; x=1756368817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YQOUvbEt34uyiKkVZzozlI3idOMYzV0MqYkXRUemhU=;
        b=C0TIiotWuO048iY+Zu255kZWW/CRHjGO0VxND3jK5dYYk2cHzxy4Jc+JjriZ2X/blg
         doXdyuDxxqYvkZDZfBhRWOq0SRyhO+PuGn3x4QBewb9scYqSrO39JywZe410IVpQ6y6q
         N9d556n6WgMEblF0oansTN/qaS0/nUOgAqANa5NM++xJL14iwR6V6hoyblnSnHWG88RB
         4fiGfVk+nCsYTNR7iGxRqExcivo3y6yLSOtcCsCtfBX5sMyY3Z3EqWJ00XMILpVPSMme
         25jkpLsqajYZRFB6mkhvWjhUPkqSTvpb2ayjliGy/7RN2UJvrPB6axaD0ks5exM+AeX+
         ReUg==
X-Forwarded-Encrypted: i=1; AJvYcCU46Qj4mq71axY7KURQDsBFBnw7hdBHQz7AoskZwMKtpDzULIs9g9fU5pZPEqub6/CBnGgGZ1qGKIY=@vger.kernel.org, AJvYcCV1UYvRE5eePxXw1LbEkPjU7OlMnUOprBt2Gpsn3L+uinlXsTp5+wkz5RXpiWmuFiA7crQkyn1KsgSwenut@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFw62KiwgeK5/QZL4wpsQ7cC0S1Zf3u1a5wtAY01z2jXYikgG
	ir21bTs7K4YQ+K1vsm2ICKSvetjqGSeHmRB+n695Ue5qJtI0O29IDeRE+/MWYdsQqsCCznq8CqL
	81J/T7kFa3vBkJo8tgzXnwaT04LcvZXg=
X-Gm-Gg: ASbGncsX6mTjLKZubwLVtqDWcW4+op4+FbXVK81vFRtk/MhWoumoNuBtONMlmIjo5Wn
	RmKGCpyjhMXdsnc2uX6gRN/MkaSp+PiVm/tTMmYViBM6J8Mz9ctpOuTOmkh3zn/HcxrvCstVTBL
	vP882n9JcZH+G9cbitW2tkg7HtUTKQqEBVWB8y9OSD12eOhviVB3Rre8NzqB0NUXPjD7Dj6C5H2
	VGw68YLjA==
X-Google-Smtp-Source: AGHT+IFBkMJTJYVwPqZUeM9AOOBtno84DfZL+tzYeh7BxO7r/uMPS8lWfXyVKwlrLDHM43Lcm3OKmlg0we9DQAH7T1k=
X-Received: by 2002:a17:907:d09:b0:af9:6bfb:58b7 with SMTP id
 a640c23a62f3a-afe0799eae2mr151798166b.5.1755764017455; Thu, 21 Aug 2025
 01:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821080723.525379-1-zhao.xichao@vivo.com>
In-Reply-To: <20250821080723.525379-1-zhao.xichao@vivo.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Aug 2025 11:13:00 +0300
X-Gm-Features: Ac12FXxWcK6_xcvA9PkQqtCffXDbzCkBD6UYFwXVnTmPqIsWYmsRzpdWdDZcCe4
Message-ID: <CAHp75VeDvK8cOr=rVGj_hVX5YzXM-UqrWRBgUrhiA1wzYn7C_w@mail.gmail.com>
Subject: Re: [PATCH 0/7] iio: Remove dev_err_probe() if error is -ENOMEM
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
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
	Crt Mori <cmo@melexis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, 
	Waqar Hameed <waqar.hameed@axis.com>, Yasin Lee <yasin.lee.x@gmail.com>, 
	Julien Stephan <jstephan@baylibre.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:07=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com>=
 wrote:
>
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.

when the error

> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.

In favour of this series,
Reviewed-by: Andy Shevchenko <andy@kernel.org>
(yes, I indeed looked at all patches in this one :-)

--=20
With Best Regards,
Andy Shevchenko

