Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798C62FF124
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 17:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbhAUQ4T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 11:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbhAUQxf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 11:53:35 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5657C0613D6
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2021 08:52:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b8so1627936plx.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2021 08:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJX0HrW9tS3WgkqUv+3+02Fzpw1Qn7ekZe9z3ez85uU=;
        b=doa3SyJBNX/UBl1teNAmQZiu0LZ0W/cCySZIpOJ0kgfxE+B7nJ8ILy8wqyjpAv/uck
         cBYRaWgs0g7kKQR0SsGJHoJQTeIhUzeKDgGx/kUm9m6VRHTFMX810FxuoqlRaVTedwyp
         Q1lBJ4ZJoFleSZaAppYy5ZK2s93S2czIg6sJZvUq3fjDWXT3pnHCKhc44WcTQxXKy50m
         iYyZCgAzpkzyp/5gEln8oz8RvKM7nDsAKgT8galYR+sVevmKI9nkoVuYxkCea2HuSiRn
         H1aDB2ooXNjnwAMSvkacXAZ8WIN6S7Mux765CHF4ykuGblnfHVFZSTb9S55Wi7o6V6lu
         Osmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJX0HrW9tS3WgkqUv+3+02Fzpw1Qn7ekZe9z3ez85uU=;
        b=HV/3Qc2IoSwOzncukJHNfrbF8s2nRHhVrUISDQXY45Ffx0jkOHY0iRvUaq/vnsP+HZ
         XqMdCZPbzsf3qjFjSC08ionqvcCxAK+9tfX1kTLbTyX0uIDuCrUiZfwIXM1UNEO3qNgY
         WCkPCDYkVl0i49iiWMq+j0zqw1oglk8Upu1Jir8CO+/XnOMaLEcqBj278fz90RFr1cFl
         kA4VRsVUVZArm8PY1PK3KJ+FPuNdHeo0Dek6oHVA4vUwrvgEjSph/JchQjOj7WpmWXPP
         oQq05B+lGNxMTI3AVMOYo9JaU+YhQ0VpvXUGZAd8oR6hyk1ctsp+9sdDWPQuKbm4aKke
         1gYw==
X-Gm-Message-State: AOAM531JReSjSECVaBu2DdNDkQ3Lsh2CcEfDqKgBnRoMj50T7xg7LK3P
        K4McOGKxXgMq+WVa2lTEF6vtaFQJI7/Cc1AY/3o=
X-Google-Smtp-Source: ABdhPJwElvHKcYJegEwuWk95i7b53wAeBcFQurHoA4BmfqOK2IoQLcjrlhSGE1Qy93mMSVpnMXB7VEeejKVxSXdULzg=
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr311935pja.228.1611247975215;
 Thu, 21 Jan 2021 08:52:55 -0800 (PST)
MIME-Version: 1.0
References: <efa4524cd07abe0a7773b24d33b64f09e0bf1f82.camel@richard-neumann.de>
 <CAHp75Vc0aF+Gf3=c5FCcbxLRd8jON7f+xktcJOmHzFSMBv62tA@mail.gmail.com>
In-Reply-To: <CAHp75Vc0aF+Gf3=c5FCcbxLRd8jON7f+xktcJOmHzFSMBv62tA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Jan 2021 18:53:44 +0200
Message-ID: <CAHp75Vf60xw3aZ2viL8KQSWJxk-5VoyTJV77st6sidy_9F1pHA@mail.gmail.com>
Subject: Re: [PATCH] - AMD Sensor Fusion Hub refactored driver with module parameters
To:     Richard Neumann <mail@richard-neumann.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Cc: maintainers of the subsystem just in case

On Thu, Jan 21, 2021 at 6:52 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jan 12, 2021 at 12:48 PM Richard Neumann
> <mail@richard-neumann.de> wrote:
> >
> > From fa17269ddab9113a4325a0c22b7b71acb16404c3 Mon Sep 17 00:00:00 2001
> > From: Richard Neumann <mail@richard-neumann.de>
> > Date: Mon, 4 Jan 2021 20:09:39 +0100
> > Subject: [PATCH 1/7] Updated MAINTAINERS and documentation.
>
> I like what you are doing but you missed a few key points here, i.e.
> tools you rather must use and some additional remarks.
>  - be sure each patch has a commit message
>  - when prepare a patch series, run
>    % git format-patch -M -C -v<n> --cover-letter
>    where <n> is a version of the series
>    properly form a cover letter
>     % $EDITOR 0000-* # runs your editor against the cover letter template
>  - check with checkpatch.pl (in the scripts folder)
>  - take care about Cc list by running
>     % scripts/get_maintainer.pl --git --git-min-percent=67 00*
>  -  and send with
>     % git send-email 00*
>
> I have a script [1] which helps to send a series from a repository but
> it does without the checkpatch step, you may probably want to tweak
> it.
>
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
