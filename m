Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D2D2918D4
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgJRS1F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 14:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgJRS1E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 14:27:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9C3C061755;
        Sun, 18 Oct 2020 11:27:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b23so4652842pgb.3;
        Sun, 18 Oct 2020 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5m1S5sZujQt2BwrJwE08lEoVDm6unn9shH52UvLq8Pg=;
        b=eCP39ru/wgTWoNuwiKr05wbnzi+MNNugEbNjFFhzbv9bIlF4z0H41WAb7F4QFdrzUs
         3wApOFJXpSx7+78Xj1hxnR2j5WckIejtQxGjFSu6/frC7Px0NHZdr7s+cR+aVnqBAMZy
         L0pru/h6bvGuBNskG6WWNXhhERcHqmM0Ya6D7tREXWbwpbb8ked7joDGAyt2LB/uNhkv
         igmMotPA4vei9LB5S8fw9yuBKvoMeL1jnh7i4hoj4IlvXjn0CuTJS4dI4RAfo2vWHCyl
         luAzC2CT5EzaYE5fTWW6bfM6kXw4OtDs4OvbUeOXBWMgILs0ZaFG4zihUOnNsvQvL3Cr
         GAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5m1S5sZujQt2BwrJwE08lEoVDm6unn9shH52UvLq8Pg=;
        b=ESOOf98xbVzQgPAEXSKtuzpNsrZ0B6YO8YjBvuRaBPu+Gy6GzWJwlgxkITUKlEm5RQ
         puZ2OWZw4RI9lcXXrfJ0xy9/sGiV7Mh0Y5YGBhETzb/VAjko1WZSZX5x3ebsLejspe+v
         blUGrR/Sz+PAyB2IUzHPFxXeJH7AcMGhP0q0hqKNIWbXlAri9sQ0GQe0oq1KTo4AZGMM
         5iS3wxEGYdsLDUqD5xbFhOL/8Pr7hdaJqnPmLtm1oQmW2h8/WQr5qWpwwcSgR0rzMQHZ
         gyzhORkgPYvAawa4V3U+peYS1i7c5AeqezY5tEQzbtalUXh+jdy03eKR+/lOi65wGjKX
         q1EQ==
X-Gm-Message-State: AOAM533TMxbLngHFFHMWXPpqSFL1eWYi8bdXVp/sF9P1Gj3EpgMMmNws
        ItLH9e4KfoBWJ7g0iDfLSR8dghdNSKeZAfMjSa8=
X-Google-Smtp-Source: ABdhPJwGULC56yMeMCTuCfZOR7vq/3gi+527g6HGEFWCQUoYxjC3jZWMZspFWo8az4pMvmRQfXU/2rwfArpqJE7bIq4=
X-Received: by 2002:a65:47c2:: with SMTP id f2mr11362279pgs.4.1603045621632;
 Sun, 18 Oct 2020 11:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
 <20201013103245.16723-2-billy_tsai@aspeedtech.com> <20201018112249.44dd3bde@archlinux>
In-Reply-To: <20201018112249.44dd3bde@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Oct 2020 21:26:45 +0300
Message-ID: <CAHp75Vd4Sequmg_qLbtkk2JktM95bk+xg65P0gJNzPO3OQ7Vkg@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: aspeed: Orgnaize and add the define of adc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 1:32 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 13 Oct 2020 18:32:43 +0800
> Billy Tsai <billy_tsai@aspeedtech.com> wrote:

...

> > +/* [31:16] */

Useless comment.

> > +#define ASPEED_ADC_CTRL_CH_EN(n)     (1 << (16 + n))
> > +#define ASPEED_ADC_CTRL_CH_EN_ALL    GENMASK(31, 16)

But the main point is here.
First of all you may use BIT() in above.
Second, it's a good practice to put variables in the additional
parentheses in macros in case you are doing some operations with.

So, something like BIT(16 + (n)) would be nice to have at the end.

-- 
With Best Regards,
Andy Shevchenko
