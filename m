Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7729EB0F
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 12:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJ2L4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 07:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2L4h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 07:56:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1804BC0613CF;
        Thu, 29 Oct 2020 04:56:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b3so2160028pfo.2;
        Thu, 29 Oct 2020 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnCHDMZH+p3HlSrifhvmvQKQDojvbc4Ld48U0NJUAAY=;
        b=JSNY0wnzeETatdjQvOjXFlGhoUunl5bwriGhNZu7ieobF8HDTx8k0LBUhic0IA0LiB
         somdhWc3XUoTWenuhW4JylqCdiP7NEjETdxk+cOHFBH5HLzhA0xCBtS0iEiGA9aGaoBJ
         lI1EZX77J0ubs50erchqr0jCMpntRwgv3+Bj3xrvjWiFFslUXat8RAgbvnFfbFtBeIrK
         Qb5NrI05NDyVAmCH9wYMjjs+EI9pItVa8Zn1ZR9paknqJq44hqpJZgdvSixYy39LSwJE
         bnH0I0Kg617BdoNM2Z2B3dwrkJK4h0E4URPK1S9DwZUEGSV2xvZHycXx8/6wRokl96U3
         Dy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnCHDMZH+p3HlSrifhvmvQKQDojvbc4Ld48U0NJUAAY=;
        b=Xn3UPjp3sNi1SPag74q206GGwKOdSYRUFEomQKkDgyXMx/IFNoxqDP2+/pEaNolzKo
         lzZubBjZ6L/x8DR8D3oucjfTLGL2/JyAf+7JjRfSBx4Fxe3LkBxSL0hHHeslJoMmXF8y
         OGbGR8UW+GGZmD7gL3V7WhBxfflLs6+EBxrPh1GjbVP75PsNRnVMF18V5N270iyN1065
         lhMTqgLimHeLL9K4TRO+g6G5xjediAw5itLYhVIa9v012iCd/hJ28OhbTp6l13uPzjsN
         d+A/as8Zr5EGLdvQvoEAO0d9w9aqxyrxM1EycA6dSQu4EqChW8AQCsQdXj7+M3oIXOA0
         jL2w==
X-Gm-Message-State: AOAM530gGM5kf4klxNuzqyqyWdGeKVpC0Akj2jUmorlTnheFfV/uMtLT
        EPlnGXP9p2WgR5mNIFuw1DZAwm4rZ3UBtrjCwKI=
X-Google-Smtp-Source: ABdhPJzzOHnZYn+1OqmiDMwuztwomB8/2RSzDOuLvzWM9YTrbhpc+mSK2GKSoT9QSqDFNTn+JxuiHcGUalp07hPA1RA=
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr3925681pjs.181.1603972596724;
 Thu, 29 Oct 2020 04:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201029074910.227859-1-coiby.xu@gmail.com> <20201029074910.227859-5-coiby.xu@gmail.com>
In-Reply-To: <20201029074910.227859-5-coiby.xu@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 13:57:25 +0200
Message-ID: <CAHp75Vd6J_k_F8HceRbXAbi+cPq=YJBnY7rHyNU__uwnnkHvyA@mail.gmail.com>
Subject: Re: [PATCH 05/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 29, 2020 at 11:05 AM Coiby Xu <coiby.xu@gmail.com> wrote:
>
> SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Correct grammar and rethink about them.

NAK for all of them.

-- 
With Best Regards,
Andy Shevchenko
