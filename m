Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8922C43DEEE
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhJ1KfT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhJ1KfT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:35:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C520C061570;
        Thu, 28 Oct 2021 03:32:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r12so22901835edt.6;
        Thu, 28 Oct 2021 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIVqWR7w9FqN75Gh/clQYpTUQSo0SOMlCTB1bNmRN+g=;
        b=XS4q5CaSPV4Mer6GuNt7Y9IVzHgYmjj6gzBzZb1ALqUyDTJ2CD48znU2h7buo0oSNf
         IfTPDViZUA7wbZt9SWC5iQevvnHpnonqLjgpq2EbOrtD94nFkZPkgzIzBHRwImHiILOe
         2KKRv31Fa9n077T60zEAXTi5wFmtRn5S/KADmroK+ddw61X4LSmt8A6AFoGr2Wku+8Gz
         5UWOUFa4J1ySOxzWfkwOMkylaByN8sbUSgOdM1M44dJIlqSMEH+sS0LFZhBfMrQtP+Dt
         QbwfIOc9K1zbmF5T7/foxHRrNTupPseHPeFyh0rPi06swWLdYe+23TUhzWQvdu0xWB55
         KdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIVqWR7w9FqN75Gh/clQYpTUQSo0SOMlCTB1bNmRN+g=;
        b=SYbRbkKsu5hTjSngZl/XiuL43tb6EZQKjIurCyvV80GjrhuHuKZGv0A7gmV+bEC/NF
         cIuttYsCf3n/QZkKECy7Qordonmgv1bK47PozzXzax6J1y9DPzuSsa0gE9kdfroH34W7
         TzVjM9678awNZalL0QEyyjAvh/x54BLjU3FyDcgEPcXhamQOhEEowhr2/Vs468ZfoIbF
         c57n0HhTFRKesYHw2Yc4z2Ip+6gapw8niAIog2jY1JPiJ7bKi4ccMsGMw3Z9jefsP/ia
         +KepF+TiRC+egtFH4q6/ob13n8NXafuTjC4ThOTWIJIYCAKEioNSwzkxqGiYU16zyPGU
         O4jw==
X-Gm-Message-State: AOAM531If4ShXhou6wt5H2/bBfg0I4/dVscBP7o9an62Z/02e7mClUAI
        8hi4VNWuEJBkYEATu5jSya7zC7F1dMeQ4YlRBiQ=
X-Google-Smtp-Source: ABdhPJwzuFNkxJgxO0rT3wGpofdgmmaWrb4y3eEwRplgeg/wvibmcQiStBp712lEquSC4USiIrlaGalBwY9w2bwCD5M=
X-Received: by 2002:aa7:cb09:: with SMTP id s9mr5014786edt.359.1635417170617;
 Thu, 28 Oct 2021 03:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-3-andrea.merello@gmail.com>
In-Reply-To: <20211028101840.24632-3-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Oct 2021 13:31:58 +0300
Message-ID: <CAHp75VeYRBe_-uMRTwM1_MYYHYBTZeZ21SxAyCeeWu6pgJy5BA@mail.gmail.com>
Subject: Re: [v2 02/10] iio: document linear acceleration modifiers
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 28, 2021 at 1:18 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> This patch introduces ABI documentation for new iio modifiers used for
> reporting "linear acceleration" measures.

Because of ordering and absence of Fixes tag I haven't clearly got if
this is an existing set of attributes or that that will be added by
the series. If the former, use a Fixes tag and place it first in the
series. If the latter, move it after the actual addition of the
attributes in the code.

-- 
With Best Regards,
Andy Shevchenko
