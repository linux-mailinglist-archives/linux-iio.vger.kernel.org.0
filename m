Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693C0231150
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgG1SJf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgG1SJf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:09:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D93C061794;
        Tue, 28 Jul 2020 11:09:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id lw1so325764pjb.1;
        Tue, 28 Jul 2020 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HDjrpdMo090Z5nVx60USGUKOYZQ+AliEwhHwHDwRhM=;
        b=XpNoAZEUg9FyFFeE5qQzG9gg4yIewA3HqlMHSFqD+WDO/4O1558Fvn6V2HEhjbn7Ml
         xnd2CYm5TQK3VCPE5HkK1F3ucPQcxpJQ/elOcUiiuk7ugaiOxcB6xyanBxUB0CxUPxZO
         bot94w4Cu9nH64nPqEdx5gO3ftEkKNldgOQBccK4kAHikN/YMLlFa5U3pT2eHXHZf9Lr
         0rIgJZhAUg6WE4aWONAmy/Tqph9ox9WzDAiTjiR1+yqkgaj9HBiDPpsxY7NiP+heAUrF
         iZsnfhxNxu1e4uklfOCCporwwv/lKaKxxLJRLu0d+E8SIi4kWn/uqY8VrSkSwAPll12d
         1laQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HDjrpdMo090Z5nVx60USGUKOYZQ+AliEwhHwHDwRhM=;
        b=qKKi6YjDKveoKREsP4IUdXJekY+yd5595uhzIbLTeVtluj8GM2AEh14ZZl+qmqwszG
         3bV07F6I9RlPfX8uhnT+Y16nInv+lOnw4RU2FgCYjCNVRgVVQvtE78Gm8pZ0Dj5IV4YK
         iKjxmrtcpht1BEi2xSBJ9NjDZESpItgtk3KZyBHZglIpTZERHECNGcbTAv/xDm8z8mCG
         0wzYnVXdgu8JoK1Pjprfb2z+3Euau6QbnFLcy7lKXs+og+g+JT1TGKaJSI9bNeOFKBBv
         G6B63FVwXWwrlg/pdkDFl/FxkEE8KW+jbYBkEB6ChhP6/GH+4e2n+vYZejIj4A0WcJz1
         VImQ==
X-Gm-Message-State: AOAM531uaOBfnAKHaxlg8Q2xe+GWIxe89tp3WheMSka5kCRahLsXaL7b
        aikeVzA4nqkxxM/64D7wMJ6fc2ymvfv8IgqKdp7IWlnhTqM=
X-Google-Smtp-Source: ABdhPJy5HuWI8Esi15pv7m1hUH6L316xV80VtgQOLaLjdeK7+LJ1EQdeoJ5yBW0uTW5978ZHZG6U7uJZeRNzk0MHMgA=
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11mr24289864plv.255.1595959774728;
 Tue, 28 Jul 2020 11:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.4.I33c50453845a8167969130d514af86e573b6ef31@changeid>
In-Reply-To: <20200728091057.4.I33c50453845a8167969130d514af86e573b6ef31@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:09:18 +0300
Message-ID: <CAHp75VcRBCmRdGh5WVGDY28AzNhBufkoNkrEZ7uEFCW2MsJ=qg@mail.gmail.com>
Subject: Re: [PATCH 04/15] iio: sx9310: Remove acpi and of table macros
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 6:16 PM Daniel Campello <campello@chromium.org> wrote:
>
> Avoids unused warnings due to acpi/of table macros.
>

At the same time I would check if mod_devicetable.h is included.

> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reported-by: kbuild test robot <lkp@intel.com>


-- 
With Best Regards,
Andy Shevchenko
