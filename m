Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADBA2D4E48
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 23:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbgLIWn2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 17:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388247AbgLIWnX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 17:43:23 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE4CC0613D6
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 14:42:42 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so3426373ioo.7
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 14:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJfUuPj3oSZPjyjBhw0C66OElS0CfVNxwKJXgZc7UzU=;
        b=LteONkDUNIi6b81ffAqCDo0ehfh173DjDzOR0XYaDaETnPSbslwQOazGULmGPizt5J
         d09nnHyI/7wqBxDwZ/4/whLnMdgsghhunzIopi2gzxdbkiMWNtCTsMnMwUGfr0hQnugh
         LhDADHS5faIjWokP/nC54TTPCa1iUn2s3TCpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJfUuPj3oSZPjyjBhw0C66OElS0CfVNxwKJXgZc7UzU=;
        b=n6t/HsThH4DUFneJE7mc3DNFanN+071JDg9XHAeXgMxXNcjihM8HFAEpjxfIuvy/S9
         u+1s5icSVMI0UcSB40LwYMLN0HsKo+bPcBWmXCALhzQKx8Dd8Jonh3sKuypGkvB7tzbZ
         RH4tpODusgMp3ISAGbiNQ9pMFg1SchJzdshe1VycaM/td7l+0Db3Bwd4xVl9qxdYORMh
         /VHU0OTmy4NkAMbFf7Y4sED/b5SVQDpJxPb4d+CL9EYaynoAwr4zj5UdnakKFycUFJaO
         07HkDTFhQZaes2yGlszu0DOD4TdInYJthnNcWPgl7a7BRvaaMzRDZ8mXbeXoJcSol1au
         ESuA==
X-Gm-Message-State: AOAM531LY14kdw1ySmhjsaWv7/6Ges8efdcPn9nvAk1VNBuXa0JV6G1D
        f2+Qmm/teqxnnB6b/hrhKvMUOi23XAODrW2ogALYaQ==
X-Google-Smtp-Source: ABdhPJwhPNiZ7882B9nnzU0OUYNAVH9vxEw8CKcbGtVEfHdiXOHa5NjU/PVuFemBNcT5FG1XSoYUs/26Z+cmDfh266Q=
X-Received: by 2002:a5d:854f:: with SMTP id b15mr5887899ios.170.1607553761863;
 Wed, 09 Dec 2020 14:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20201204194803.751866-1-gwendal@chromium.org> <20201205180631.004173e5@archlinux>
 <CAHp75VeYgBN8GJXs5bTJpML9Q=jZHJkh7h877Of5-Jn2E3Z_yg@mail.gmail.com>
In-Reply-To: <CAHp75VeYgBN8GJXs5bTJpML9Q=jZHJkh7h877Of5-Jn2E3Z_yg@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 9 Dec 2020 14:42:30 -0800
Message-ID: <CAPUE2usVQWg0rqz-nK9f=5HgazgzUhufRZ_XYimjP74q7VgbNw@mail.gmail.com>
Subject: Re: [PATCH] iio: hrtimer: Allow sub Hz granularity
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 9, 2020 at 7:22 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Dec 5, 2020 at 8:45 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri,  4 Dec 2020 11:48:03 -0800
> > Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Looks good to me. I'd like this one to sit on the list a little longer though
> > + it's missed this cycle anyway so we have plenty of time!
>
> The patch has a big issue, i.e. documentation update... where?
Added in V2.
>
> --
> With Best Regards,
> Andy Shevchenko
