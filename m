Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65B83CD4D8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhGSLyv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 07:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhGSLyv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 07:54:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99222C061574;
        Mon, 19 Jul 2021 04:52:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h6-20020a17090a6486b029017613554465so2198819pjj.4;
        Mon, 19 Jul 2021 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5o+0N3OXjtJzk5S9pKw1iAJVxSjUfJEVo5LEoTTdaas=;
        b=PBorbwkE+BBQ636dcahg3gBt0MQhtAT53sYXXYWA6BdJln4aOSDd/RxH1ENtddFOV1
         PwEKsrWknyLSTDJnJQn4GGRmSR/hkPM5PGz5fe5LwWPzh0H1eDsY83ykT38dyg1gwtpL
         VEQgYSTXibuaoWEn1OHoB2A4wplfplc9qbu+wDeKjJP6rK7MFIFvheHYWVzwon3xs/YT
         I3wNp1oPBr39jQGJtc2GOQ0Au4KoQywG94w9p+MNlmZVU9b29sCJeZwzGEfSF46rVTgt
         3eBw4xGJf/l8a+fQR6/Q4rOelEKQITd9mRD1ng/ziNsM3F9c1vi3joirkgUEau+avtkT
         v85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5o+0N3OXjtJzk5S9pKw1iAJVxSjUfJEVo5LEoTTdaas=;
        b=b8fy7/BZm0itwDN2u0NHWbh91iEIgQZ38vxouUWY68xTRd+xphdfi3wJAEz6ijt/ar
         R7Y6mvqmQcr4Y758tzNjVkD9xO4rFdEH4Ij9gaMKjGahFkCtQEyx477hwu4qBDMVTDy5
         4FWWqJxpcnOxZf8SKBTjz67gF9sy55sga9RvAswCRxQyJOkM/Ucf9JNzjoHp72MIce+M
         j+gEyjO+zVY7pLFJpHcg8VPgJDnIroLTYy1uMg3kwcI2ecZUyZfrMJzYoBYW+ShL4tOw
         XDkklaTYOG/ElX/IorBhuC3I9QjoI8nIMbDVe4lBRI9qO6rAY/EaKIXr4hvHDyMpsBkD
         PAyg==
X-Gm-Message-State: AOAM533vQmgF0hb+cVLFtIlbOji5d7DZFp4ydwJ4EcjP1mWjOs2biHYY
        W8umCnjpT+WoFG9ZkJl+Di0teT2OmDweungGorLk7dw19io=
X-Google-Smtp-Source: ABdhPJzOmaH70h839VtoRcdhGQWKy17rUTiPzFw4Y6dQkfCYYGHUXRuo32dFY2MlOGE06Xp7u1BL7OSRumrhqHOI4O0=
X-Received: by 2002:a17:903:3005:b029:12b:54cf:c513 with SMTP id
 o5-20020a1709033005b029012b54cfc513mr19062104pla.21.1626698129902; Mon, 19
 Jul 2021 05:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210719112156.27087-1-stephan@gerhold.net>
In-Reply-To: <20210719112156.27087-1-stephan@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Jul 2021 15:34:50 +0300
Message-ID: <CAHp75Ve-mK59bOt+am2GGXww=vf-BhXmpwCeKvX8rph9tRr3FQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] iio: accel: bmc150: Add support for INT2 and BMC156
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 2:26 PM Stephan Gerhold <stephan@gerhold.net> wrote=
:
>
> This series makes it possible to set up interrupts with the BMC150 driver
> on boards where only the INT2 pin is connected (and not INT1). This is
> particularly always the case for BMC156 since for some reason it only
> has the INT2 pin and not the INT1 pin.
>
> These changes were already partially discussed here:
> https://lore.kernel.org/linux-iio/YMOphuXSoODIVX06@gerhold.net/

I forgot the story, but the series sounds to me like d=C3=A9j=C3=A0-vu. Ple=
ase,
remind me if it was sent once before? If yes, then this one misses
version bumping and/or changelog.

--=20
With Best Regards,
Andy Shevchenko
