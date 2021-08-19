Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427A93F1EF0
	for <lists+linux-iio@lfdr.de>; Thu, 19 Aug 2021 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhHSRV0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Aug 2021 13:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhHSRVZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Aug 2021 13:21:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D0AC061575;
        Thu, 19 Aug 2021 10:20:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso5292447pjb.1;
        Thu, 19 Aug 2021 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEeRuc7JZ778PLVAxtNHdGEKV+ow6emdptixqFeRsss=;
        b=Qk98zra5kuNn7pTwcbR3orAMjpWQF64WVlJgYoNFx7Ssj44qU5Gv4udHjRCbRqAyrh
         sT2yo1SM5TVBeibgQVlq8GhwYPcWjUQWGOFv4TBsT/EzNQt9Wb+cZO6Fer6N+PBhuLG/
         e9UoOAoGvyqw4LuoZs5PzO3Rt0kzvwpfdafXKfmDA+64O0OwapHVzcRiZ8p+TSyYWW7L
         yDDj98vMw+7M7pDCHTLjLtrkyQvCFM/H3I9RUpzCQ0DztNysgaCturUwtoGzfERHi7iX
         /AhIb4RrhFKUZo0OM5G70UmtQd8J2YdrSnoL4teQ5iOK/gFwJpC+9af9ywQ+d+imsNxz
         6a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEeRuc7JZ778PLVAxtNHdGEKV+ow6emdptixqFeRsss=;
        b=VxOsNzlukvOS2VLehhr/05IxKujP/un3KkvIav9phDXWKIjiCbvP9w8WXSnFVYQJV+
         o56cDUg+8726HIb/k3wjVrZe8Mq5kmXtYqA7FzLueUc/0VZZI17F1qvvpFWk7DuEt0U1
         ZdJASp8tqjYJtXr3un/Kvbs14svM9eFTpwQh4iKcYoTtFxGxo6nqM6T6r1JE+Gj68dLL
         8/iEqrL375PO3wvBVtnA4b0Dpk1WPGrV4zKu83rlOf3zZwTRRrf+rGiH9rIAu7QEDA5h
         DOG4cPb5R79km3BD/Hg3HlvV8VmZ/q4sZfzZGtsDT+zBdSep1+RrBUqWzz+Zr6A/XUW8
         Azvg==
X-Gm-Message-State: AOAM532BaO8UvjfCJIjJw0q4Bg6ksbKfzVfOtN8Sn2hZQdX5b9IOzhlp
        ECDgCmiFaDro15TkKORJLquboFBGePuwunkWvBY=
X-Google-Smtp-Source: ABdhPJzJ09NqeJwEhvPjmgm7DkwvN+0K0VrKxT8M4ChoBU9e9Y7OgzKabAalajUDF6sLaiVgHuXpCtSZNiRkc8vknYg=
X-Received: by 2002:a17:902:ced0:b029:12d:4ce1:ce3a with SMTP id
 d16-20020a170902ced0b029012d4ce1ce3amr12652051plg.0.1629393648072; Thu, 19
 Aug 2021 10:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210817172111.495897-1-colin.king@canonical.com> <OSZPR01MB7019DD199CB1B9A4521A3C28AAFF9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB7019DD199CB1B9A4521A3C28AAFF9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Aug 2021 20:20:08 +0300
Message-ID: <CAHp75VdWFTi4oSWG45NunJwpe=LdMhAMEAEJh21ML2QXszgS+A@mail.gmail.com>
Subject: Re: [PATCH][next] iio: adc: Fix -EBUSY timeout error return
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Colin King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 18, 2021 at 6:51 PM Prabhakar Mahadev Lad
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> with the subject changed to above: Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Always put your tags in a single tag per single line. This will allow
tools to catch them up automatically.

-- 
With Best Regards,
Andy Shevchenko
