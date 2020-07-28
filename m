Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF7A23142F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 22:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgG1Urz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 16:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgG1Ury (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 16:47:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D09C0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 13:47:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id kq25so9075859ejb.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExajQAZpNTd+joqebqoVtMbLAI74qmTPLZGYxWwu4D0=;
        b=i9sjjh5UAFRZq+C3SoLUFHBEFZe6/rz5SKiFPjmp8dcIsULItKWNbWHaJLPdjgA3Mj
         TmKlkfab84dkU55DoSBegy1MTK+TCHgJKsRJtDKe0ppHkw9hqFaosw/z/OPlicU5HoFK
         om2qlX+kETm4XnxUxtAKkwLggUd0PsUuko2zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExajQAZpNTd+joqebqoVtMbLAI74qmTPLZGYxWwu4D0=;
        b=fgdS+hXLEq9pTi8y741Z+Z2dvkjKBI/SwojUy6hfpCXZvLXGyZl/5YupKMzEawCxnE
         K3MEyfNucZTJhE96lN0UknFpsp36U6hUAwmR3uAv8R1OcGnxSY8zvgCEMgn8MiLpeW/n
         iUEb4POdOc5Fl5ml6Nw5L68Xk3NllGp3pEBSUbsmyweIQTbpl9vlHw1dZWQM0OoKe6zK
         Co0h80aHbQQAhrdFX6rMwHRGEsMXJAwPMFK7OxVcjqNS2lmdGs78b4B+2pX1t3ZQ5TNi
         BIsjPVkMwc+x9vMQcJTWuDb0nZHSZXSi9LiBCocoOA9ZBb5LUsba3m9O+QEQ8rK6thP9
         CITg==
X-Gm-Message-State: AOAM533YWqCRDZqOjpC5FBOi5ToRIpop7sbFrQjI6iKX3FSqOyFBI2dy
        DVKz/8NE4CDMKH0OJXD0cR5CUEqzs0Q=
X-Google-Smtp-Source: ABdhPJymeI9Fl31LG3BBCzDHtr0OiFz9TeS4TJDxvDo+6CrkBjLI/0/4z/Rs5KxcRFIU3pCvZMPqgw==
X-Received: by 2002:a17:907:11c3:: with SMTP id va3mr17305072ejb.497.1595969273102;
        Tue, 28 Jul 2020 13:47:53 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id r9sm123737edt.1.2020.07.28.13.47.51
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 13:47:52 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id d190so774870wmd.4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 13:47:51 -0700 (PDT)
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr3518054wmh.79.1595969271235;
 Tue, 28 Jul 2020 13:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.4.I33c50453845a8167969130d514af86e573b6ef31@changeid>
 <CAHp75VcRBCmRdGh5WVGDY28AzNhBufkoNkrEZ7uEFCW2MsJ=qg@mail.gmail.com>
In-Reply-To: <CAHp75VcRBCmRdGh5WVGDY28AzNhBufkoNkrEZ7uEFCW2MsJ=qg@mail.gmail.com>
From:   Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 14:47:15 -0600
X-Gmail-Original-Message-ID: <CAHcu+Va0DVm1Pw__jYF_EhZHSQnSqb_zex2NN1M67zc=FTAitA@mail.gmail.com>
Message-ID: <CAHcu+Va0DVm1Pw__jYF_EhZHSQnSqb_zex2NN1M67zc=FTAitA@mail.gmail.com>
Subject: Re: [PATCH 04/15] iio: sx9310: Remove acpi and of table macros
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Tue, Jul 28, 2020 at 12:09 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 28, 2020 at 6:16 PM Daniel Campello <campello@chromium.org> wrote:
> >
> > Avoids unused warnings due to acpi/of table macros.
> >
>
> At the same time I would check if mod_devicetable.h is included.
I did the following and no error showed up:
#ifndef LINUX_MOD_DEVICETABLE_H
#error Missing include
#endif

>
> > Signed-off-by: Daniel Campello <campello@chromium.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
>
>
> --
> With Best Regards,
> Andy Shevchenko

Regards,
Daniel Campello
