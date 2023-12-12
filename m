Return-Path: <linux-iio+bounces-872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F5780FB93
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 00:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC291C20E18
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACE777F2F;
	Tue, 12 Dec 2023 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CacnCAzw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0738BB3
	for <linux-iio@vger.kernel.org>; Tue, 12 Dec 2023 15:51:16 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4b2ede7754cso1555261e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 12 Dec 2023 15:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702425075; x=1703029875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDJv/MdPWACPkzPDU+UdHfxT6bKwGCJYIve5sJRmC4w=;
        b=CacnCAzwSbudmwwYJOMgYdksuVWzV/PGJjKuKG4M3a615cLK/lglaxwE9zk5hFFLo5
         +CqOmBQkgfnp+8zkSWZPaEYV2GPASHFAN0D/DVDYAcvWKYf6BsFnTuqXOIo5xD1gxawY
         JHRdJIBcuHHuqOuh2uRLB5L1jEmpvSNMxTbVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702425075; x=1703029875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDJv/MdPWACPkzPDU+UdHfxT6bKwGCJYIve5sJRmC4w=;
        b=qXe8EsPYpUwd1aD3A17P5scxE24Zf9vGxM0INGVRnnYqz1xFnOeujuhB6SSA35ffUc
         tFjyecPDtQrQ1dYdCbTurjHsp8nYnEB+3v8b+HBjKCLCkOBa8LOqPQDUECJ6gVykUGsM
         W8Adu+I4gKxVoa+lQTfla1KbDAMDm3plwhFb6Euf3FzibQI4sKnuTehZZHFXWKMUvYcb
         kFXcvTeW96nSCvjzrOqgHbljuS32Pdc3/ACBoAndFOw1kd5mdv0eB8837c7HGjYBpsdp
         35FWhWPhApgMH8jpxsFnIjbM9MdCQ0eZTmOcz50FQTwPpas498qpswGKk/v7+ljRSPJN
         ou0A==
X-Gm-Message-State: AOJu0YyR7as5axrclDuekk0lW19Jfo7ehHGMKZz5tagR2tIeuEU/7hJP
	5LBBCxMfnS42pNj/6xTdfoJ3wbcJxCDpLB2cVaj43w==
X-Google-Smtp-Source: AGHT+IHgzY6TxuyoNkpl2aQeyRJYTpGY2b/Uli21Z+t7hU04lfjLJQ/88/mR7DldxbjQ1RCBksHpytK1u9KPLiGxHEI=
X-Received: by 2002:a05:6122:31a:b0:4b2:a7a9:b2a with SMTP id
 c26-20020a056122031a00b004b2a7a90b2amr5285959vko.11.1702425075124; Tue, 12
 Dec 2023 15:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
 <20231028162638.5b477ded@jic23-huawei> <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
 <CAFhGd8p76R-oaPWR0G6wESe7kgM--2bzU88j2vz4QGy8wKNffg@mail.gmail.com>
In-Reply-To: <CAFhGd8p76R-oaPWR0G6wESe7kgM--2bzU88j2vz4QGy8wKNffg@mail.gmail.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Tue, 12 Dec 2023 15:51:04 -0800
Message-ID: <CAPUE2ut0gbSyzUQ+m=760kXeOqKoi+9OwaExXTSgg8S=bWhUvg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
To: Justin Stitt <justinstitt@google.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Mon, Dec 11, 2023 at 4:46=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Mon, Oct 30, 2023 at 2:44=E2=80=AFPM Stephen Boyd <swboyd@chromium.org=
> wrote:
> >
> >
> > We need to free it in other places too, like if the count doesn't match=
.
> > It may be easier to extract this section and just have 4 string
> > literals.
> >
> >         switch (reg_def->reg) {
> >         case SX9324_REG_AFE_PH0:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph0-pin");
> >                 break;
> >         case SX9324_REG_AFE_PH1:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph1-pin");
> >                 break;
> >         case SX9324_REG_AFE_PH2:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph2-pin");
> >                 break;
> >         case SX9324_REG_AFE_PH3:
> >                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semt=
ech,ph3-pin");
> >                 break;
> >
>
> I've submitted v3 of this patch [1] trying out Stephen's idea. I'd
> appreciate feedback.
>
> [1]: https://lore.kernel.org/all/20231212-strncpy-drivers-iio-proximity-s=
x9324-c-v3-1-b8ae12fc8a5d@google.com/
>
> Thanks
> Justin

