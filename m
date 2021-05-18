Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1688E386E5A
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 02:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345022AbhERAdC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 20:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345020AbhERAdC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 20:33:02 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C499C061756
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 17:31:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 131so9408796ljj.3
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtl5qW5ngyrCxRtU2FQ2/K9MskvmJ8cOWL2EWopDeQ0=;
        b=zevlSmEyAgZw0Dl3SUDt8OftbZM0k008Vgi07bfY+kwE7mFX51r6s1DPcpuH/Cpu/s
         tWhphMX7YqNthYOymSaH4fzZTpQYqqrx02LX5SOstqOWY0E2UaVUQug89GW3WM5tbZYZ
         5WEw0gowzHqGFr+/04jVhpvzoeO4RXcBOpx8E2VUCGdWeoV+la5h9842jEdanXxYuZBL
         czCYcUsHbGfyQCm4AdIzBs2ZqWl7yEM92rFc4srwWyonO6WfkNS2UHsW+M2G2lTUQLQm
         5apjcaiJPi8THjO5lyyRtzWviZ/QcYKMqh/oW4SPn7UGCFwd1udiwW06fZWGgkK+2LZ6
         j5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtl5qW5ngyrCxRtU2FQ2/K9MskvmJ8cOWL2EWopDeQ0=;
        b=dly2MbczazlhGfvI+cryrj5Tupb2R+WorylK2kA95NZ9U04+hWXv3PZEHs8YkOZ16K
         7w4GB3dF2TD2E/qmp0tme5XfrRBeb0J/YPNZyjLjYf4vMo/MbXQc8ERxxEEH5aQ7gZaU
         fFy+Y1RF5XmjOTqgMXzZBaaa5shGdHlF0w2Y0Mrpejdag+7xQr5juJz/ROY2+nmuVMnp
         28IKj1NU2X/iEXj5hmuzU+SEKKVLwqtm18pXuxbLNHF1q5PXyaOy1xNkA5JiuFv1gv4T
         MdTNN90D8Qwv44WavHAWiKdtUnedGvEmJHgRpigEsKiRIWwb/g3qH4cnoMeeWJV0zi8e
         sROw==
X-Gm-Message-State: AOAM530mU51D5L/D+rbgxcIwzw8TlrzLOWy2lHH8B/KMywI8zmvhg75k
        n8zn9uARZ4pUAFJYxeDG3G/G46kLKcinVQ8X1cC6sQ==
X-Google-Smtp-Source: ABdhPJwvbHPkqdIqYxErmiViZeFTg8U61Ma14ffPQ6RCRW3Fmd5pOxxjDCM1f4rUjgRfKf+VGK7L02ebIy/X5EwfWJg=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr1755612lji.273.1621297903739;
 Mon, 17 May 2021 17:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210503144350.7496-1-aardelean@deviqon.com> <20210508161643.5990ec15@jic23-huawei>
 <CACRpkdaK6AMVUC+B7JW3y28nNeAYHAS9UjC40KfShZNrHLD7rQ@mail.gmail.com>
 <20210509111925.52f3f4e3@jic23-huawei> <CACRpkdZ2mC5V6PdphmtmtQKHZwPfc7mVgZ-FH3io2ihB8foA4g@mail.gmail.com>
 <YJjXU/mBKnmknItg@kroah.com>
In-Reply-To: <YJjXU/mBKnmknItg@kroah.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 02:31:32 +0200
Message-ID: <CACRpkdaNuGB+qpW-hjsGs5rC0k3nKwKDT0jUU6Jpon1JRf3MoQ@mail.gmail.com>
Subject: Re: [PATCH] iio: core: return ENODEV if ioctl is unknown
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 10, 2021 at 8:48 AM Greg KH <gregkh@linuxfoundation.org> wrote:

> I can take IIO changes in my char/misc tree like many other driver
> subsystems go, if the staging portions are not involved.  Otherwise, I
> really don't see the problem with it as-is, what problems is this
> causing at the moment?

It's in the thread: pipeline stalls, haha :)

It has happened more than once that Jonathan needs to wait for
things to percolate upstream before he can base new stuff on it.

Personally I've encountered fixes that are waiting in your tree
so that new fixes on fixes, or next development cannot be applied
because the fixes need to land in a tag upstream so that can be
merged in first as base for the new development. Essentially
any time patches with dependencies end up on two branches.

Also it takes a while after the merge window for you to move
branches to -rc1 or similar (whether through merge or rebase),
as is natural. Which will delay everything using those. It's just
a natural side-effect of hierarchy.

Nothing disastrous but it makes things congest. Maybe it can
be processed around, I don't exactly know the routine around
your trees and branches.

Yours,
Linus Walleij
