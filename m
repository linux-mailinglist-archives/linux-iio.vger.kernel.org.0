Return-Path: <linux-iio+bounces-18167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA97BA8BA1D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B891904FA0
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7381414C5AA;
	Wed, 16 Apr 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kntNaOiq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E5184E;
	Wed, 16 Apr 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744808841; cv=none; b=RNGRVSb3KOCgAxNzpzWDUIaazKih7znyMsF6Rt2f8fGULmIGYsfQZ+AMtaM7M8FKDjgGC73QZnCqlD6bSDGg/VxU82b5+nEP0OHAPiMBv2WpimnkZfc+yRHCuNvLu1mzGUd/S7IvRH08yAl39gylojQ/XKTa2o7y5IF4CVVUp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744808841; c=relaxed/simple;
	bh=3PwhXk0T8PkNmFpMngPwoJOiScLtG7ErNwGb0vtGzEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGnLbhby23naA4jW8GQB920OLmjmJvy3ZaOgfcAZZha0BEdaGAuk+HPNXnRTVWGTb0CdzfLdiytu1I7t1LbxkoDbUVk8USYb4rRGVjG231Bzo3ZAn+DYaiHuBT5ZxS3XVj/F/PA+QYSX+ALtMBqTR+IXbC1dw24ezNVkSsymT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kntNaOiq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac7bd86f637so138452266b.1;
        Wed, 16 Apr 2025 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744808837; x=1745413637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PwhXk0T8PkNmFpMngPwoJOiScLtG7ErNwGb0vtGzEw=;
        b=kntNaOiqHDpyKLp59tVgK1rNdkWLpU+Kd344tpGF433/83a6zWtyYCsXB3XmoqjumF
         nY1CcUkxKem6yazGyXSgfqAq5ev4UPlSpqpzjdvt7aShq726ZWsi/+srN64rP7wZKfr7
         i2iGS3XvkUN8mhmv1/+8RK4JsXMXumIvgLR0RJARvv/tVae2+hYigoD4/cvdTJctTkMw
         EPGoWdb72F0t94vwK/tF/nM14+PIdroC1/4XI5Dh7Ul8b/l3tUd5C404DZh/QMXTFnUY
         OrZVY6rdvuCAdIQ9L7wwlBt1Eqknbz1a0o6uldqOt3z5dKH548kSZsioI405SEGtEcIS
         Spdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744808837; x=1745413637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PwhXk0T8PkNmFpMngPwoJOiScLtG7ErNwGb0vtGzEw=;
        b=C2MPVuYBcdFw0CCMDAmtol4V4RcV4/1By2lPxmNB5KIYhSS/NjCjuO7Yh7/yhNMcBX
         WTMnVSBsNe85Z2u4IyQIMad56QmfjbhqF5AQ7wOo7l3sZN/e2afrwKUJpvxM30a0MsOz
         KDnc4FD1mCE7w3BwbmrUcXU0LBMaYEX+//q3761tZoaOZgJLS7dHAEx2MOhyWHXj372L
         3qTJG77p6JWn4v+0a3SpX9not8nDcVy8a2R1kXQFgi3dvoU7wFUgGlA+121TrBawxGzi
         h2oVxcFow9IlnNmZvgrdci97Gs+MOv1GoxMnKd60Sp05MPFsJKjgUEbfKkPiOYi9j05l
         AOew==
X-Forwarded-Encrypted: i=1; AJvYcCUPufGifVDut8HL/Fv5fmUi4k8/LacwlA4UkmgK2qzo+6Q1u6k4ejSS/kRUP/XCqAnvfkI0gGu0p8MNXncA@vger.kernel.org, AJvYcCVz9iwl88eQd/rdMKB5JO6J8wcW25gJ1JBi5MWtjwrxhKIzMBMayl2EULryKKeJCCSW8Vkv8SV2Y0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3qEK16OXYwLhx4BCM1+qe3vq54Q4KRXX5JBWgB6/f4ZGlHgzX
	/ZP251qSBnJ3zTS7JAU3fgD9ddpum8Qisk2L3Q5iabWwSVMlvW81DUCISfZpPWvsNj+SMzQCl+P
	IS2+qCyvJWp/747Cu5xk8Dxb3ujU=
X-Gm-Gg: ASbGnctNi1csZybNua5YWFCeR5F5w8OI/nDJtiAoGNNOqQ4Or7POsjfwOpKzwxLKNog
	Li+mi+cMRhI46vpJdlD7uvc6VvlT5BXQWXazvOc4hhbUflAi3tcaqg0TGKbtDXJXX1uf02xjx1C
	BkqQUNRlk6pdbXHrrQ8/ImOwh+
X-Google-Smtp-Source: AGHT+IF40m0QmQzucW7RJ5mRehoRCaJeliza9CCEESfheRiOq+/XML8zXKHRPYOdKwI5H6qrnQwQ4DK9vLWTIsPC6fk=
X-Received: by 2002:a17:907:3d10:b0:abf:48df:bf07 with SMTP id
 a640c23a62f3a-acb4278ee7fmr132132766b.15.1744808836426; Wed, 16 Apr 2025
 06:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-losd-3-inv-icm42600-add-wom-support-v2-0-de94dfb92b7e@tdk.com>
 <20250415-losd-3-inv-icm42600-add-wom-support-v2-1-de94dfb92b7e@tdk.com>
 <CAHp75VdZDovPuRqQMpP=TkjeBr9AgRssPFJfmsjnXC=wUXxFHg@mail.gmail.com> <FR3P281MB1757B4BF12AD9F6AC5F8F361CEBD2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB1757B4BF12AD9F6AC5F8F361CEBD2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 Apr 2025 16:06:39 +0300
X-Gm-Features: ATxdqUG5Hu5J3MvGQIfA4QkFR_rdXGXhwWiKOS_CRzohMcKeiWO9qPe7tyFzn5w
Message-ID: <CAHp75VciPdgt13GbWtH08_k-f6VHQ-e3aA+CibKNAS6WRWE9Ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: imu: inv_icm42600: add WoM support
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 3:41=E2=80=AFPM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:
>
> Hello Andy,
>
> concerning usage of kernel types, my understanding was that we should con=
form to existing types usage in a driver. That's why I'm keeping the standa=
rd types instead of kernel ones. I could change them in the patch, but it w=
ould mix usage of both standard and kernel types.
>
> Another thing not related, by reading the coding style documentation I wo=
uld think that for new driver we can use whatever we prefer between standar=
d types and kernel types. Is it not the case?

It's not for the repositories Greg KH maintaining directly or indirectly:
https://lore.kernel.org/all/20170411140919.GC4388@kroah.com/

--=20
With Best Regards,
Andy Shevchenko

