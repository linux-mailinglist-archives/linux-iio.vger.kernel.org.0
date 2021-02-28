Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426DB3273AD
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 18:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhB1Rqs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Feb 2021 12:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhB1Rqs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 12:46:48 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067BAC06174A;
        Sun, 28 Feb 2021 09:46:07 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id z9so2354246iln.1;
        Sun, 28 Feb 2021 09:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRw/2nv28qisGZYRahOxi1kCY3LbPoxUF1FoDC5Q+Qg=;
        b=vCda/ont8UDdWOceMDbVy74JJf7rl6iyRQQ4HpEC1l7GaFyRjFAREocrtOudmSe8tW
         vrOvLbG/P4PBX1lvYu2JeHdsVfo9n45zqXgoNoYjj/xPDR8hENJJyfxcBwfZWJD2JiLa
         LLEqQWvh/ukJju82hHLgt71nIHrbw6htZZK9/WgnE4cM3wc8rAT5hyxB6vD99gHtrkdG
         kM2mqvIwRNEEfKZaUsAYNL+Q4yZiDgYePaoZrl40OcK9ZeDMGE9WkZo6JQsUE5uCP9zA
         HLyVMwTYuP76+KcE/pBCQY+JXEk/HSzYbIDZtFKa9Wea0LuQUBCipwx241k5PSMfbdqX
         NRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRw/2nv28qisGZYRahOxi1kCY3LbPoxUF1FoDC5Q+Qg=;
        b=tSb8Xn3SEpmRk6vmKR/jKaTR0Y6qZfDEPsXtuN/oCr6OLwOwKHcPsits0AZIEyay0n
         3Os5LH1DhMHZVi5QAM+Wk+PBhYS5pyGn4KbNRVN8zuJhqtZpr8KFY017gVJhR+mReq0+
         UfsTRETfGmuS+qvzx0FUNWMrpXTzsqnFSG7i0tpSkTcYAFsvwQ2rXVkQbm9pTjHSDiId
         uLizmd9EvpgNgNNpqEnftPVV/gG4aOzjIS8MgkQ6Jxes6FV03v92/cQ2EWpl4nfEbTgL
         8j02JWqDhY5/f6BNnApYUEBcntvjHOSB1+7PgCCXsIgicp6SGt0M16noZFMz+7nW0Niq
         97BQ==
X-Gm-Message-State: AOAM533mS/e1eVQPfcFEpuMIkiUHDS7fh25BHsk0F1MBjt/QLSK7V6k3
        lzgXPOe8KZ4mMPYYEZN9KDeyxjCAIt/txZncj9wS7KY/PD0=
X-Google-Smtp-Source: ABdhPJworkm9CW1mBYzhJiryFnYWnTj3Gl80L5OQtCc8wHoy8DbUdG9OUfTAPsb0DkHyHV33553OYQWxNY3KI7u1rs0=
X-Received: by 2002:a05:6e02:1be1:: with SMTP id y1mr10042969ilv.101.1614534367360;
 Sun, 28 Feb 2021 09:46:07 -0800 (PST)
MIME-Version: 1.0
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-3-alexandru.ardelean@analog.com> <2e6f90be-5dbf-1356-d1ac-22a4273c87ee@metafoo.de>
In-Reply-To: <2e6f90be-5dbf-1356-d1ac-22a4273c87ee@metafoo.de>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 28 Feb 2021 19:45:55 +0200
Message-ID: <CA+U=Dso2PePbTMCmLGeN2eZ4spQd8gM91-w+kDnik0QMb0ikcA@mail.gmail.com>
Subject: Re: [PATCH v6 02/24] iio: kfifo: add devm_iio_kfifo_buffer_setup() helper
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 28, 2021 at 10:08 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 2/15/21 11:40 AM, Alexandru Ardelean wrote:
> > +int devm_iio_kfifo_buffer_setup(struct device *dev,
> > +                             struct iio_dev *indio_dev,
> > +                             int mode_flags,
> > +                             const struct iio_buffer_setup_ops *setup_ops)
> > +{
> > +     struct iio_buffer *buffer;
> > +
> > +     if (mode_flags)
> > +             mode_flags &= kfifo_access_funcs.modes;
>
> The if seems unnecessary. If it is 0 and we AND it with something it is
> still 0.

Makes sense.
Will send an update for this.

>
