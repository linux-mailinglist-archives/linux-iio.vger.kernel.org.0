Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0411363F92
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhDSK2t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 06:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhDSK2s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Apr 2021 06:28:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3A2C06174A
        for <linux-iio@vger.kernel.org>; Mon, 19 Apr 2021 03:28:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l22so31367736ljc.9
        for <linux-iio@vger.kernel.org>; Mon, 19 Apr 2021 03:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/SttTdmW2nXkjWTD0Fh5WztehWpMKnyW4BL03277nc=;
        b=yAYczwZ4KhV68N7ygzSM7TGFiY6LBRC6rqPp6z39D1FMiLTja2+9JYOq8Dt8CycHMX
         KgIJ+YtE1FAMH48/srv8vgQa6yq35l5BxHcUwzXHPOzG4gy97QInowNnmnlOykQ8SSwt
         qhO00aAhIicFGpTXeWLsQShjNFIcXKy8SV/tuDQBs4CzNSMMx3lQiQoBZSDgNs+mCzmG
         uEGWN+uzn3JyTe9vPZctphg39ja9gEvOd6Rz2hW+ihgRPT5g5bPgDDym094CaOFplVAJ
         p8tmrR/QCL/RfFqf79JQKj9U1wSiTWJgzNgKDATQ7WYuUdwv2eyou6SwYovbRJ+rqPQ8
         2IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/SttTdmW2nXkjWTD0Fh5WztehWpMKnyW4BL03277nc=;
        b=UsrJUnPwS2fHdEFDCOU09EPrfSerfbeIDzSkU36lOUP57iwuhlzqDR/9MOjszQYwxz
         L2G0m6NQCzuC3p/+81A9WBOs92sq24qZGp8m9+/A3ojKqlyBrszIRLv++jLisjGfxduB
         dZ/752IOd7lB6ttDIn3kCg9q226MY1wy17o56OZ8+5SAzQ7ZxPS4EldiT4p4GwHCFC3m
         /RYHWkbiCNNP5F9/xpgmL2ULMVwf3NqljwCWJEs+UepkVMLayIBDs9ZP4EZDp8pUdKpk
         uFOnzy30hY24IWCSFq0stkDeYril2XlDy6lTy0AjSLzpZR/RjAVTMqGvj64jcJ4I6RGa
         PUrQ==
X-Gm-Message-State: AOAM532h0gcJsvYc3cjTzniUSYUGDQNt5Q8HksiABcqEy5ypcuQbt9PR
        gvXrjStY26lV3TclZjhdrESLQt0WFnCyPZDLqRLBfA==
X-Google-Smtp-Source: ABdhPJxd2ZK+Sw+8Bh8HsZimNvX4Nzwwd9JxF54Hc30ImuOFlzg1Qn9Z8Fz8SDQpfGq+V7kMghgnHlVieW9YdHgDAF8=
X-Received: by 2002:a2e:555:: with SMTP id 82mr10664751ljf.200.1618828097501;
 Mon, 19 Apr 2021 03:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210407034927.16882-1-dinghao.liu@zju.edu.cn>
 <20210411160720.037c405c@jic23-huawei> <CACRpkdYrRi3pa6Gw4_Q+P=WYbv-a27FHmOupKVv5s=yU53RFWA@mail.gmail.com>
 <20210412111506.0000653c@Huawei.com> <CACRpkdY9sDbVSjBULg3tV-Zpr_Tizd4HKeTG-NjCjUru=94QYQ@mail.gmail.com>
 <20210418104353.5a6e498f@jic23-huawei>
In-Reply-To: <20210418104353.5a6e498f@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Apr 2021 12:28:06 +0200
Message-ID: <CACRpkdZYU7gJ4OiVaADu3oCJVqD+jJ6BwKVan6hSO_t6BJ4oqw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: gp2ap002: Fix rumtime PM imbalance on error
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 18, 2021 at 11:43 AM Jonathan Cameron <jic23@kernel.org> wrote:

> I'm still far from completely convinced that it is 'necessary'
> to take the reference whilst going through this sequence because
> there is nothing to kick off the suspend until we tell it to use
> autosuspend.  However, I appreciate (much like taking locks in
> general in probe) that it makes it easy to see there is no race.

One part is related to hierarchy, in the past if this device would sit on
a I2C bus on an PCIE card, unless you take a reference (that
escalate upwards) the I2C bus host or PCIE card may decide
to go and runtime suspend, cutting communication with
your device.

Since 04f59143b571 the power state of I2C buses are
decoupled from the clients and we decided that the I2C (as
well as SPI hosts, separate commit) shall make sure PM
resume themselves when transmitting messages to clients.

So in this case, since it is an I2C device, we are probably
fine without grabbing a reference.

But this is not a general rule for any (non-slow) bus, so
the idiomatic pattern to follow is better like this.

Yours,
Linus Walleij
