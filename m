Return-Path: <linux-iio+bounces-23101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2934B2F72E
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 13:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5460A20EBF
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 11:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0832561AA;
	Thu, 21 Aug 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="bhzSQGoS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F22D9780
	for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777040; cv=none; b=Ptr6cQJzimBAXk3qAEk6R+HNvPb9K//2C7lfwRdpuSn4P5nrzarEdTntAmiWtgUW3nm1odAKLRRKsSBtWoC8QC72LxGSDZEx4l7TsLNkLmcU78UmBVFXHEQRgb3YeinJ28+ft87YAbasEd/KDsBH/H6e/qSdykRjIa9BQcNv9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777040; c=relaxed/simple;
	bh=GI2XcWaMkZXf3XlixG2IPGL+6e9Vy4tl86zb1yjrRNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYl9D88bcl75eIccao553BptnThJdnTbWVVaLbrc49c3LLTPEPZCF/JiZYqjqLgwZSl/rk9MGMN1aumpwHHxbb0OfYvLzkwaXX0ck7FxwYl4BHfwKY4RjU7ZQkceTDMXRdPZQcOwWW3Nq5sk6HuLQqdLQf4Akb/Dt9hSPzZ4+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=bhzSQGoS; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e8702fd3b2so79147985a.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2025 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1755777037; x=1756381837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI2XcWaMkZXf3XlixG2IPGL+6e9Vy4tl86zb1yjrRNY=;
        b=bhzSQGoSh7ZoPACOTHPjTO2x6SdpkQ9Lu2YbvggZmmFzNRWq0HY+8fYvbcup30yjqM
         SgOMZkf9kK1APK9bEGcegS6tKnwzPE2t7AVECKTvcpJV4D5HVbfW1YA5/31mLRM1AyRQ
         SLtUfede5t8/wOGhcsC9afQfocYZjAAYftB0Hs7LG3D4fgeymLEpXcS5c69FUU7jTnWH
         S84vlMXapPmZWLtTSNY7WVlbGMShQePqlMi8MCy7o4qxVCs/R/T57LWSlGLtVKo3GcNm
         4Sm7aAAwYjf27MCFS2xILJYt697aG6KBJH6PhXVJZjj3SvtT3esA+dvB7ENi03xMSRla
         EyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755777037; x=1756381837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI2XcWaMkZXf3XlixG2IPGL+6e9Vy4tl86zb1yjrRNY=;
        b=uZnlKreOMERMtuG5kEPhsgR/oIAbZExO1oCikfft/jUmQvUUWYcAX4GGZiGYH1Mor8
         VDjdu4YsId7/oabGn63f7K6NhXKxR5tnikv3d9eInoMDu8UxUlgEfgPxNbEWhN7api+J
         Sgmi9+XH1P6fVwilP1MhK0vLtYp0s8vggUO5AU+fM1/NRyfNcKxVZeqPCrBPOTfBbPtu
         gX3vG2Gvbky8bLP5Uwmox0fVwRZabUdbb/SXrxNv+HxguDDlRDz0D2bmRpVUn0e6S00l
         hIE4UHkfdrDTNSEd/Mo+xbmaZDgtxdjsvt2xYyhgbElSXmg3M5f/jox5+FpBYTOlE5i5
         mbyA==
X-Forwarded-Encrypted: i=1; AJvYcCXYzdJBMioFlhgP4ZKFNIVqEuVxVOGzoRb8VWTSFUpXqa5CUagnX4eX2tW8h8/wmfCbJ6KaV+/BLOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzefIqlg7xtWWeNggbRlyGzvp8NwGQX/YaH0kpo1tI/oldiIHh4
	FhPFnqbqo7vb+0OR8LvJvwatde+PtAryNVU1iPh/jMn/Hu9qk8AQiRxyzWEu5PS1UTn0L+1oPL2
	IPKExfDk7VekJUN2bg1CSOrxnaPj3NGO0zp8+KcQ3
X-Gm-Gg: ASbGncvCyJN9lclqqKKKa2yFO0BJOeNNVgN3b/sKQ4bfd1vP2NlRLxp4F3lx3fBtQ9p
	vQ8mLYskkYAbkkgBuyb1ayI2K9Hkdv2qwHBnaHTtJoZUGdohs0BWHfRNz2pjzaEe5bnWAdwVLIZ
	IJeq80GtGWVpSNBwY1KLVV6+5I/+MFQpoGGHBRW4rJxVuG/ZjiKRL9gGZO7y/TgCog361ksrM+D
	3dQgheWyw==
X-Google-Smtp-Source: AGHT+IFXgN4z+V5r61maVUoVH7Q+4oGAXqZzaV+iRCJ0lg/aewM1N1+KmnykJmm4zHXRs1rwg//XUIeBfKZTRO4+v7g=
X-Received: by 2002:a05:620a:4548:b0:7ea:5aa:84fe with SMTP id
 af79cd13be357-7ea08c78a25mr207064785a.2.1755777037356; Thu, 21 Aug 2025
 04:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821080723.525379-1-zhao.xichao@vivo.com> <CAHp75VeDvK8cOr=rVGj_hVX5YzXM-UqrWRBgUrhiA1wzYn7C_w@mail.gmail.com>
In-Reply-To: <CAHp75VeDvK8cOr=rVGj_hVX5YzXM-UqrWRBgUrhiA1wzYn7C_w@mail.gmail.com>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 21 Aug 2025 13:50:00 +0200
X-Gm-Features: Ac12FXxGX8W0hsOM6YtKDXVSOgl06ennUByjlBCRIy2fIDyre-p0gjpggdKZ2cA
Message-ID: <CAKv63uvfHYATd7ZFweZ0LMfTLt-idHVgYJqOV8PvzaNeigbt9w@mail.gmail.com>
Subject: Re: [PATCH 0/7] iio: Remove dev_err_probe() if error is -ENOMEM
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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

Sorry duplicate - as I commented on driver.

On Thu, 21 Aug 2025 at 10:13, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> On Thu, Aug 21, 2025 at 11:07=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.co=
m> wrote:
> >
> > The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
>
> when the error
>
> > Therefore, remove the useless call to dev_err_probe(), and just
> > return the value instead.
>
> In favour of this series,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> (yes, I indeed looked at all patches in this one :-)
>
I am not sure I agree with this. It provides an error message with
reason and I understand we want as few as possible, but this would be
a valid remark inside the logs, but without it we only get error value
to figure out where it comes from?

> --
> With Best Regards,
> Andy Shevchenko

