Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545CC3DF88B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 01:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhHCXfP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 19:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhHCXfP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 19:35:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495DFC06175F
        for <linux-iio@vger.kernel.org>; Tue,  3 Aug 2021 16:35:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h2so1350965lfu.4
        for <linux-iio@vger.kernel.org>; Tue, 03 Aug 2021 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OboK+DP1GLQ7qO1X6SFXHJeqsxmRJzLpz1cmFRfRtvg=;
        b=STceXaC5PfzZq/z5cCZaqDSKX8eNoQ2p/qIKEt8D5BChje8N2mJqZfrVcp7obJ01FP
         mldMZo6j87cICbQypMXnTk2SmPoMt3q5xG669bjhGQ8WxSqhyd/wfnwXq8DbGh753X/B
         o7+6VHtZLsjsgt6AGtQmvvvoZzCeyuLvIPrIInG2w2RN7Ypr1DgebD3tJcXuMLWIb2RA
         qgYBY6lbkp1BRWqHWC8+ZKkQRMmmdXY9Zc6Vx1tWykRE0Zkawy9z+8YAaQS4l7DJ/98J
         pbodWBxEKltkBkDGLKlmeRbl0rJK5zG6GVxJF7OQxWkN9tF2zFfiJ06t7sJCZvGrCe4Z
         d13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OboK+DP1GLQ7qO1X6SFXHJeqsxmRJzLpz1cmFRfRtvg=;
        b=nNxsWsPzZRn04xnIwW6dnieZs9XdksvPI6GDRLDyUhhjZ056Dne3qJlNE/+2N+OSrM
         9zQ3N7wzA+LtJAnAHNrX770gwmm5ZEQg6cQQQX6XRt1dNK9XAT4Y1cWPGcbwI8yE6U+Z
         xesbJnUK640ZF8KaRv8TSK4I/FVBzl8zcAhFhcsRiWW2ZkWJABoKU6XIO1Cg5SUxFatb
         DgNSpfzrJWHQRhLUbDD4QFZQt3yLK6ev4oZbo74JLTYnxRvI4POHrvQVhvvCJWP2MNGS
         BybHqnjulfIo1ZdkaI5FJOZPJh/slVUQKxWFewttef1CzmKmgSzDoMkDFleB090LXg+2
         iROg==
X-Gm-Message-State: AOAM531VDLUogIudvy8gGEBHocwtrvB8F+UocRrM0ObBNtqGGIXoUGs8
        iWTmPrgcFfoD9oQktO5n61IvMXPY3OAMJFTBFTVESw==
X-Google-Smtp-Source: ABdhPJymjavPtkVqjxK9gWwdsr0cwgOPwoR9crWUlQrL7fb/5sa+YFl7A0NQ2p7gam0sNyYEnLxEs3r4HWOWYf4Xd5I=
X-Received: by 2002:ac2:4c4c:: with SMTP id o12mr17755451lfk.157.1628033701692;
 Tue, 03 Aug 2021 16:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210802155657.102766-1-stephan@gerhold.net> <20210802155657.102766-4-stephan@gerhold.net>
In-Reply-To: <20210802155657.102766-4-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Aug 2021 01:34:50 +0200
Message-ID: <CACRpkdZO9_Z+3UCgKgGkERqV2aK=1GbdDEDzVaKt1ejzBmrG9A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: accel: bmc150: Make it possible to configure
 INT2 instead of INT1
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 2, 2021 at 5:57 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> Some Bosch accelerometers have two interrupt pins (INT1 and INT2).
> At the moment, the driver uses only the first one, which is fine for
> most situations. However, some boards might only have INT2 connected
> for some reason.
>
> Add the necessary bits and configuration to set up INT2. Then try
> to detect this situation at least for device tree setups by checking
> if the first interrupt (the one picked by the I2C/SPI core) is actually
> named "INT2" using the interrupt-names property.
>
> of_irq_get_byname() returns either 0 or some error code in case
> the driver probed without device tree, so in all other cases we fall
> back to configuring INT1 as before.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Looks good
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
