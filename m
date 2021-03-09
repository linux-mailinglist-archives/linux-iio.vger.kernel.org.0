Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EFA332F23
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 20:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCITiP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 14:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhCITiK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 14:38:10 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297BAC06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 11:38:10 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id o9so15243225iow.6
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 11:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlB9Dyc7z9+MJcOkZPqC41CRf0S+8DZITHDcDt6IdPg=;
        b=I7IKSj2uwddFqDr1gYwP26zsWtrvuMG6yi0vCv+iFOTLeXiPBfw/6ktOuIeqs4/woY
         yZvRhu2yuAiKanSDhNElPLD9izzqg71ZAyt2HPWYrlczNR04MXHuvwxPmKAkvRi4dIs7
         0S8q2zzbPhLXZxEUefJ7VnVEiqBvx8pepuKxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlB9Dyc7z9+MJcOkZPqC41CRf0S+8DZITHDcDt6IdPg=;
        b=WqjEQOdKoGN5/CXyGTwKxfVh3MrtQhOVkTIxQWFBvKUvyuoDjHvMrLPXrcuGkME5bv
         6sDVO1brnoPdOK7I0DeC5DFZYCMN2m1W/Dq8jApr1TQefY5iZOribK6zeX2+vlWGOBQ2
         AIo/BgaVeq5vfQRWJYM1HpYQemHr5YM1ykoRKnk+6DW2KOpBhnR/ToQbC3yhxCCg6h9f
         UQSq1YL5W5IO0mHnAvBh4G/b7Ak36QlgmNKJr4mPyRFoIP2JBJmWXI8LvXYTIBZm+S42
         TjSJzqiUryKoMbLYXZQfHS6qqDWhBo7PYvkTx5WkiIlf3YBwPGetXoh9WoE1nyXecQYT
         WAwQ==
X-Gm-Message-State: AOAM533px8sSyTP8jRcQj58NZQATUmnq3uJBUCNPYvGXO7b0KNTCCb6D
        7EZxJdWsFypM2jUiWF0/kPI3RaVyljOqcMH3PdjDDw==
X-Google-Smtp-Source: ABdhPJzNFxDvAenxIN5S02CqY+zQa/L5safbIVIewEH7N8SMbIm9UWNZkJar56mg6qYmtk2yFymeRTQNwQCbpHz/2Ac=
X-Received: by 2002:a6b:6f14:: with SMTP id k20mr24737216ioc.52.1615318689736;
 Tue, 09 Mar 2021 11:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20210309011816.2024099-1-gwendal@chromium.org>
 <20210309011816.2024099-4-gwendal@chromium.org> <CAHp75VcFdEWHUYDxVATLTnVNACJ-t4A_=YG1KjowtmT13NMyzg@mail.gmail.com>
In-Reply-To: <CAHp75VcFdEWHUYDxVATLTnVNACJ-t4A_=YG1KjowtmT13NMyzg@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 9 Mar 2021 11:37:59 -0800
Message-ID: <CAPUE2uuwnedq40qs5QZtmiNcJPKPRsXO+g5NKYmxQXrUUq3_Wg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] iio: adis_trigger: Remove code to set trigger parent
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 2:03 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Mar 9, 2021 at 3:18 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Already done in boiler plate code.
>
> What exactly? Please, be more verbose in the commit message
> independently on the subject line.
Done for this and all subsequent patches.
>
> Hint: you may fix all commit messages at once by using `git
> filter-branch --msg-filter ...`
>
> --
> With Best Regards,
> Andy Shevchenko
