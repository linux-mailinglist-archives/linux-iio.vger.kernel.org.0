Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EEE2D49B6
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 20:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbgLITC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 14:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbgLITC2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 14:02:28 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8E9C0613CF
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 11:01:47 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o8so2757861ioh.0
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1mf5iOSjX13GcL+45kiqu3DQCQxVs4tml2wPWDIlRM=;
        b=HlSFjrus6Qqw7wKk0m9B7YGYOLekmwDlYhD2Tpp6OvlMox2xwl1bi29xf7Djf2K2s4
         6eoNLeb/HwSiKPW0oDagaMfMSaiJ4Ht7/R2sptN7o2TeUeBOYi2WiMYFd/V18bNUaGRh
         +npRzb8VkgGonyipHiUtMCfluaWjh+uhsQC28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1mf5iOSjX13GcL+45kiqu3DQCQxVs4tml2wPWDIlRM=;
        b=pGKHY3xMRFPcVvTzvaGIozyY1IPzcgGyhHP3P1FKaRG1aAzJbZ/db83UVYs+FxqRai
         98IzD4Po5L+ojjop6QUMbA91OL8sNRJrLL0DpbHtoVsb9Gw32Q4WEy9ETiKVcQ75Tz05
         8A7J0hyKCE/6oSHb7g44Wz90bGVuqaNnI2QruCQn+Sive7M06BzoECOSWdjWLmYrf79I
         N+bw44EfgCNwq/6Txmcn25yeVSZqsB0ArQARc4Dw9OuXHw8e01RRAoiJ1cQdtOOTa2p2
         gfZuH7OhmmpF5cdLsFnyVEdvIeCABNkefAoMtcVkm/bCR80rbmAjxkfvPtAh795tUBo8
         /M9A==
X-Gm-Message-State: AOAM53204FLPDvuAiSFkwthupjVc9y0GiqHC0VMrVcejzBfmTl9pnCjv
        PCojqdxTiJ3r0ivawrycm46D8cPgPXoDIyXUQkncF0OFFRA=
X-Google-Smtp-Source: ABdhPJyVhtc5lRWk4GOFLgNwdRl3BubVNUnYifwhs2diGhpPxMdJpvK2q+w/txyZJo7metO6cJuk54nDKV5UNFxiiHQ=
X-Received: by 2002:a6b:7501:: with SMTP id l1mr4664768ioh.92.1607540507159;
 Wed, 09 Dec 2020 11:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20201204203755.818932-1-gwendal@chromium.org> <CAHp75Ve+oXJoYqRFV_FeMrS_Kh9d_3VhVQSgqtn3BxNx9k0ZtQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve+oXJoYqRFV_FeMrS_Kh9d_3VhVQSgqtn3BxNx9k0ZtQ@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 9 Dec 2020 11:01:35 -0800
Message-ID: <CAPUE2uteTbf3WKngh05-hFh-TKyZGZ1-NbDwqLrW9CAi_OezTQ@mail.gmail.com>
Subject: Re: [PATCH] iio: acpi_als: Add trigger support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 9, 2020 at 7:16 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Dec 4, 2020 at 10:40 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Add timestamp channel: use standard procedure to collect timestamp.
> > As some firmware do not notify on illuminance changes, add a
>
> do -> does
Done in v2
>
> > trigger to periodically query light.
>
> Sounds like two things in one change, you have to split.
Done in v2
>
> > We can either use the device trigger, or a software trigger like sysfs
> > or hrtimer.
> >
> > This change is not backward compatible.
>
> You mean you are breaking ABI? It won't go like this.
No, I was not setting a default trigger: on machines capable of
sending ALS readout asynchronously, the user had to set a trigger in
v1. Fixed in v2, now backward compatible.
>
> > To get samples from bios that
>
> bios -> BIOS
Done in v2, submitting soon.
>
> > supports notification, we need to register the hardware trigger first:
>
> --
> With Best Regards,
> Andy Shevchenko
