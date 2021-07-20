Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9673CFBBC
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 16:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbhGTNcp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbhGTN2A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 09:28:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB2C061574;
        Tue, 20 Jul 2021 07:08:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n11so11484423plc.2;
        Tue, 20 Jul 2021 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PkAUSa8iO+7WteRWzJzZbVWHxdXWutFxMQnYCPT03FA=;
        b=CXXbqsq/+4Uai+DmJMRIR7PpNVY4/MeKGB04RdhVWil0uMU607jC2kcpJbANpSHaGj
         32ciUW4H9ieKAG5jczZ0Eu/Ls36kDRJCFsuUhLJzagBoQXak7j/fkyvn7JzrtpNlLGRn
         QFuBtS/wu/2xbu8OoDoaWx+aKazVvuojOMQOCCimIy3qWAPDXLSNn8rjjt+HX3/80DcZ
         0uRP85MisKdG0p2GRorbt5vwoE9DiE1rmYow/FTczt1nWJItWJB61iiLXxguWbPhbBCD
         3BcC4Dlwqk2IJTe9Up7Fkon5b+CYG+J1Ukab7utwSZb3kGibyzI91m/05DGdgaYQFMZV
         IIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PkAUSa8iO+7WteRWzJzZbVWHxdXWutFxMQnYCPT03FA=;
        b=t0TQMQLmMcKrCmGFGpdGVXSFQ7CkoGuWNxktltwfiYrMcCGt37PfjqX8nAw2Gzvd7k
         LmRRSfxK9N9bi5WIaiEfSePbMR8pBuzEizRo38VZrvjRa0I348N2AhGPY846j8xiNZ7S
         R0g0SaX+NsmMOFDe4v89XR+r36h+sb0uVu+pvZirNLmJIwxuMwS3TZr4g0ew4t80bee7
         43vXtLpSzhLAsZXkFanP9a5HyLmNFKFUOOS2NauWGIGUVByhsEgp70dRMAV6KAoUTXiY
         tQ3SVgmq4pdEH48tERmEMstt2NoYHvFfZnnd0cesFeEgsMUw+GIbubVgcCHCBo8d7LqA
         jtew==
X-Gm-Message-State: AOAM533K/mb5e0HwQTu4Nle/F/ZcZJOXzJj+fhGKZXqYKbop/ozphpnO
        jtf2S7PKQC8E/l3n0rHcOT251etZxOzq+Hy1pwA=
X-Google-Smtp-Source: ABdhPJwNJvdBAkDBLZMGoPuyB5XVo2FQOgd2tik+AdOrm0UcV9m1VW/T03iaej4iyooKEh45AWMbXBcjnIWeG/UYZao=
X-Received: by 2002:a17:902:b198:b029:11b:2246:e374 with SMTP id
 s24-20020a170902b198b029011b2246e374mr23684180plr.17.1626790092873; Tue, 20
 Jul 2021 07:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
 <CAHp75VcNhJrp4YGZQu1ZB2J4ARtuT2T2p-72H1qn4F+KtZDVoQ@mail.gmail.com> <CY4PR03MB3399083DDE3A03C55D3153FE9BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB3399083DDE3A03C55D3153FE9BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Jul 2021 17:07:31 +0300
Message-ID: <CAHp75VcN2fjVDMfkpgyE2tqu=21ku4KBowNDKJxvpbKzwuEPew@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] iio: frequency: adrf6780: add support for ADRF6780
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 20, 2021 at 4:17 PM Miclaus, Antoniu
<Antoniu.Miclaus@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Friday, July 16, 2021 5:53 PM
> > On Fri, Jul 16, 2021 at 2:43 PM Antoniu Miclaus
> > <antoniu.miclaus@analog.com> wrote:

...

> > First question is why not to use the regmap API (I have heard it has
> > gained support of 17 bit)?
>
> Initially that was the plan, but after this patch:
> https://github.com/torvalds/linux/commit/4191f19792bf91267835eb090d970e9cd6277a65
> the custom write formats for regmap allow the read only via cached registers.
>
> Therefore, I preferred using spi transfers for write/read to/from the device.

Not sure I follow you. That patch is upstream. Does it prevent you
from switching to regmap SPI API?

...

> > > +        depends on COMMON_CLK
> >
> > Is it mandatory for any function inside the device?
>
> Yes. It will serve as LO input to the device.

But can the device work without it (with limited functionality)?

--
With Best Regards,
Andy Shevchenko
