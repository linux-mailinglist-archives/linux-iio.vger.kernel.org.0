Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5F31B152E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 20:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgDTSy2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgDTSy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 14:54:28 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C8C061A0C
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 11:54:27 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z12so10940210ilb.10
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sS4YS2nlJ10xkXGmMzOy7jMGWrIlLM0vLffgB5tHhvw=;
        b=U1UVPdXMQxck81iz4E9kfwVW/WHaF+jXQmb23OmsK2DtqmBRTlEGOSYmWQjag5K5gb
         YM3qRvf52nmsT+0gO8oiB6foiANGTqwGioB9RKe+xH3k8P23jLzkVbwo2uwh3JGl9+ra
         NXFyZV8dOv+8azYRNM7Uw5YLdug3rmD0pjCI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sS4YS2nlJ10xkXGmMzOy7jMGWrIlLM0vLffgB5tHhvw=;
        b=C2RCBdo5ZC1rRxya23Coygtclrdwzqf+W80EfbqAyBHBk1xZnwoyRyThiHy9/4CzNx
         gyW4oMTBqOHgQc6TqpWrjzN54+a1KQwR8/EO6BQ3xwCqTInljVnU3iN991PvJGIA5pfi
         IXqfQ5njRKXHYFjikma2y/jBTROEZBR6TB2yw55mOAYuPWuYkrUS+iNhJkA1SgtiVrEk
         jp6jhyfTN/ciccCalHPA4zrZ8SMsLxLfMGEgdLmozgugkokP1karALvOK0kyx+57PFHp
         KI+On0C4IGUMHtAI5JYjHdnbdQXmKmPbkP3egpx7neBePMAW0DMnksU8KBEMr3u+4N3c
         qZ6g==
X-Gm-Message-State: AGi0PuatV6Gti2Ia8sVLNsSw0PZzlPxTv31YWSH/+QMKh41QbEGK4qXL
        OOy8M7nYDJWknz46w97PGdjERmCdWXW2hEYhsUbgLQ==
X-Google-Smtp-Source: APiQypLWXvyYVM9rwFOfV38ssOrflZRJlOT5tya/OAF1hXcPghtYYQIc3djt453TYnFBcv/sp9r1hsBVBgwBmTe1UBI=
X-Received: by 2002:a05:6e02:544:: with SMTP id i4mr3464318ils.145.1587408867241;
 Mon, 20 Apr 2020 11:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200413195514.192868-1-gwendal@chromium.org> <20200414204814.GH7347@icarus>
In-Reply-To: <20200414204814.GH7347@icarus>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 20 Apr 2020 11:54:16 -0700
Message-ID: <CAPUE2utas86PQdQem7bPsNL+xnHreepG8wbvbt2Vk5rtjoyn-A@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: counter: Add Cros EC Sync counter
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 1:48 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Mon, Apr 13, 2020 at 12:55:14PM -0700, Gwendal Grignou wrote:
> > When the camera vsync pin is connected to the embedded controller (EC) of
> > a chromebook, the EC reports a sensor with a counter that increases
> > at each GPIO rising edge.
> >
> > The sensor is presented using the counter subsystem.
> > In addition, it is also presented via the IIO subsystem with a timestamp,
> > allowing synchronisation with sensors connected to the same EC, for
> > image stabilisation or augmented reality applications.
>
> Hi Gwendal,
>
> Sorry for the delay. I have some changes requested below.
>
> > To enable the counter:
> > via counter ABI:
> > echo "rising edge" > counterX/count0/signal_action
> > via iio ABI
> > echo 1 > iio:deviceY/en
> >
> > To disable the counter:
> > via counter ABI:
> > echo "none" > counterX/count0/signal_action
> > via iio ABI
> > echo 0 > iio:deviceY/en
>
> Although in theory a user could manually disable the actions for a
> Signal, this is a very roundabout way of actually disabling the Count.
> It's better to expose an "enable" attribute to allow the users to
> perform this functionality; for example:
>
> echo 0 > counterX/count0/enable
> echo 1 > counterX/count0/enable
>
> >
> > To read the current counter value:
> > via counter ABI:
> > cat counterX/count0/count
> > via iio ABI
> > cat iio:deviceY/in_count_raw
>
> I know we discussed this in the last review but it's still the same as
> before: IIO_COUNT interface is deprecated so new drivers won't be
> allowed to use it. You'll have to remove the IIO_COUNT code in this
> driver and replace it with Counter subsystem equivalents.
I understand the need of a clean separation between counter and IIO subsystems.
I will wait for counter to offer a way to gather timestamp'ed counts.
Do you have a plan/proposed ABI you can share?

Thanks,

Gwendal.
