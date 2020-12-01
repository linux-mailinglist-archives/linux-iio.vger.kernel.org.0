Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00B2CA2F5
	for <lists+linux-iio@lfdr.de>; Tue,  1 Dec 2020 13:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgLAMmD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Dec 2020 07:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgLAMmC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2020 07:42:02 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20620C0613CF
        for <linux-iio@vger.kernel.org>; Tue,  1 Dec 2020 04:41:21 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v14so3864165lfo.3
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2020 04:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjDKiVUvuKMaRcRGWQSpUGV0bwVQVIskn2Kbrs7Awbs=;
        b=EqRY9/TrPSbVxfgh6ruxnu8otDhN3brcU/g32do7o1ip4FbR+r5iJDyBT3FqHV98qp
         +KTHYwAgiUCdnT2RfgfyE43Hpzf4JGaXWwrftuCp4m5LVGiK9WjlzMUJBy4Y8p1CDkm7
         +zlM0Yjy5xDhts1zy6dQmQyBrKZ7eKDGiwqjxQwxqYMKQsnPQQtmAkHQyYJKFfqWiFyZ
         9fBQTt/htHP/0GZ1iAS+ZBTTmOaVyENLJCtEhij5QIjjvSdMUBIuiWXbHTeQ4VNFVmkr
         w9zAluEZUqNvDVKtNi5vOgKB5+nNhY7B/UqK4KfZ0XxJg44irsH8thThAXF2G3dgnL3s
         JtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjDKiVUvuKMaRcRGWQSpUGV0bwVQVIskn2Kbrs7Awbs=;
        b=HU5rCPr1BFphASm8MIgP99m9cBbc9xTHJir3pAxj1usC2BsjbjSMWLAoHgBlpltl4T
         3lz3nIqFvDZ0wDR+MOWbytpKmVCnlz2IqyqPK3/cPs1gBUZwdjnHJ4zmHcfQki14+N+Q
         3YVDqhK58vSd349shqLC9ByxO1g1rib2UiH1aTGJTjjv6BiF1wS01jep2ynu0nCLgHlU
         HhyEFsK+rtYX5ycB6CGVI95vlZ2Y/vOTiq2CSuiX5m9pg7ms1G8byiC18Kiv4nyTyzpW
         K/RpsCgw17JxkoblqS4PdJXkziWoLC9kHhpcVX+xhErfzYFUK1trHznXEqY6IWHv4gp8
         YsRQ==
X-Gm-Message-State: AOAM531AxbYyN688pc0tLZ7M0+3ITxUulCPuasfjTjpp7qEAhzWY+Ype
        gmmUf7isd7TiAhRJZloTQOuUb2k0H0B1ObMD1ALg8A==
X-Google-Smtp-Source: ABdhPJwfHfzDHFP7FoqfTIm91ADs8s/coo8BjsBLPxRNeM88hjwGheLU0HhCxHMWUQTaRQTnNwhXpz/yN/5SSGvGOd0=
X-Received: by 2002:a19:ca05:: with SMTP id a5mr1153633lfg.571.1606826479594;
 Tue, 01 Dec 2020 04:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20201130125915.1315667-1-linus.walleij@linaro.org>
 <20201130125915.1315667-2-linus.walleij@linaro.org> <20201130210752.5028588c@archlinux>
In-Reply-To: <20201130210752.5028588c@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Dec 2020 13:41:08 +0100
Message-ID: <CACRpkdZZG865dgLodBoFUGS0pUjOcb1QW0sCD=13eOc7B3A+gA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: gyro: mpu3050: Store timestamp in poll function
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 30, 2020 at 10:07 PM Jonathan Cameron <jic23@kernel.org> wrote:

> I'm a bit confused here.

Rightly so!

> pollfuncs are per device using the trigger, so writing to the
> timestamp of the one from this device, won't have an affect on
> any others.
>
> If it did, we'd still have an issue as there are no ordering
> guarantees amongst different consumers of a trigger.

Yeah I got it all wrong. I'm trying to find the real bug
(likely in the trigger consuming driver) and fix that instead.

What do you use when stress testing IIO stuff? I have
been using the tools from the kernel so mainly
lsiio, iio_generic_buffer and iio_event_monitor so far.

iio-sensor-proxy seems really nice, but I just haven't
figured out what kind of programs people are in turn
using that with..

Yours,
Linus Walleij
