Return-Path: <linux-iio+bounces-848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60F80E06D
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 01:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1B02824F0
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 00:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9939B;
	Tue, 12 Dec 2023 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pk+ZLWqU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9134B3
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 16:46:33 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1e7971db2aso578229366b.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 16:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702341992; x=1702946792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGDztTP9Y8jmLygA/ILQ99z4JlzsbnXKKrjvScgU9V8=;
        b=pk+ZLWqUHYIvu8d9k+G0s0CWKocvLC8DYhIushLNhPUSTu8f8+VH7lteILZTs+irpa
         Ak6dNTTDPlcBVf6+pFizlMoGDszp4ZtKdxCNcdZHiqj54f+i3xAE7sN7mDC4GIDvHtT3
         hCvFceWhvSMDpIs07mILYdbGSkVvmtToYfc/idiLuOF1ZOJqQtLKZAPEj0Cr3Yo9le0W
         LAstZg+Ed7LuLP7Bu7kUfdZb2Ci/x21m5mGoXPNBMGrGTplnfZ+xCIx5DWGZmOzN78QY
         ftWrj8fB/LXiODnVuT5LWkeNSDAQKNc42ww0Dnbowp6aFyJNf1Ao8vFhuH+srOzBekLq
         mSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341992; x=1702946792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGDztTP9Y8jmLygA/ILQ99z4JlzsbnXKKrjvScgU9V8=;
        b=aEtNFfsnzQSthTr+e7dMqCIkd98Gz7i19i4Ol6lbKuUaC29A+z1u/rfE9mGUNfHTt6
         ArrjS+GZ9aQK5KuYKb+a4kwHXJevvD8cly/KlSGAv2mtvueEHDCcZ5Ch74QZQrbI0xbQ
         aYWjchs6RZVZI18skEpJ1/AsLDCzzVMUFC09LkC4SSp2FjRtZtZaT+zRKPZ0tIsvN4z1
         yqaDWj13u0THj7FXFapWMoTCP3p+5WFT7YX7/mGb7/ELAKr9ScOqL2J0e4NngKnzkMLg
         in6tPGg7TVSnjlR4f55jIcCsVBvu2IMikVQi/IO6lrkHeLPUmx9cZWg2wluRiKC5rwiZ
         /8Mw==
X-Gm-Message-State: AOJu0YxMUJ5cTfDZ2d+taqB3xABh2VXrEd4GgarPWyC9lxxvVlEkAopc
	8KngDkCk5LEaMv4eCz+k20H5b1ZGWHNGV0PEpaoxGQ==
X-Google-Smtp-Source: AGHT+IF3Vb9uYK4veE0AEj+63MVpg5F+Fk633PnRVz/Mrgr8rxF8f0TZLUH4FJYcKHO1B7bz6tONcIHqoCsdrSHNL48=
X-Received: by 2002:a17:907:72cb:b0:a19:a19a:ead2 with SMTP id
 du11-20020a17090772cb00b00a19a19aead2mr3218422ejc.139.1702341992095; Mon, 11
 Dec 2023 16:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
 <20231028162638.5b477ded@jic23-huawei> <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
In-Reply-To: <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 11 Dec 2023 16:46:20 -0800
Message-ID: <CAFhGd8p76R-oaPWR0G6wESe7kgM--2bzU88j2vz4QGy8wKNffg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
To: Stephen Boyd <swboyd@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 30, 2023 at 2:44=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
>
> We need to free it in other places too, like if the count doesn't match.
> It may be easier to extract this section and just have 4 string
> literals.
>
>         switch (reg_def->reg) {
>         case SX9324_REG_AFE_PH0:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph0-pin");
>                 break;
>         case SX9324_REG_AFE_PH1:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph1-pin");
>                 break;
>         case SX9324_REG_AFE_PH2:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph2-pin");
>                 break;
>         case SX9324_REG_AFE_PH3:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph3-pin");
>                 break;
>

I've submitted v3 of this patch [1] trying out Stephen's idea. I'd
appreciate feedback.

[1]: https://lore.kernel.org/all/20231212-strncpy-drivers-iio-proximity-sx9=
324-c-v3-1-b8ae12fc8a5d@google.com/

Thanks
Justin

