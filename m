Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B81E0929
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 10:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbgEYInt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389198AbgEYInt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 04:43:49 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04974C08C5C0
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2020 01:43:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m18so19860944ljo.5
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2020 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9oiGHt9PBJoqyCwwv33bq3uxWQdSndxMSFHyZz70QE=;
        b=BuX4Q2f/lzQJvGFKiZIlqhWhogs8lr3fcw+sZpc6G0plTK1oabro108MGvtaiMSvta
         IzZFgH3+6dAj+mW+ilQ7e/Xl3qGFGW6UnRz++vvMtNvH1Iydo2gAxmFleD0bCTlU4OGC
         WwXgktHERh4xL568BMwGrFum1lfAr0lvZvkgIMvJ/l3p37faF/Pd/c+DTzCgHDQx5ziE
         3q80wbIKz14cHdt0Vuc82XCE2gQN0QuoZWse6gN5xqWX6Gj/Ry9TO1bXYOtWeC4TKK6p
         mXvZxZy6QaF74rDikcFGZuln8XZAp3CRQDDJsLVCEudq94+aVsntxbcgyavrHWMaSvVP
         WM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9oiGHt9PBJoqyCwwv33bq3uxWQdSndxMSFHyZz70QE=;
        b=roWwNfVMwh+VSBZVASLK7UIWzmw+MrXtyRoyZ8kyNeqxnlaEL3KdNDZUP5+eTVL5OT
         VmDwwwJAYpmoevi3Zg3CQJRiHO5ctATVs2HfaTttqkYzoiHnZooC4QdHJwycSfOxZTRm
         Uajaq3S2awIBLxd/W6GapKY9dwrsSFMjB8uWwlKEMVIzzleZL7KavNlUyWy7Rkihmr/S
         kbM8CHbKI2PJdPfNyNbL9pjpghGL4H5qkKh1ZlcZuHyTNCaBjPzarZ4EUhBspZks14xI
         NhD41Llf+2wrhqfebsbk3mAVZSE6Ouj5v9TCeNrUExk5koNqQ52MOQqwQrE+3ophtudG
         8iuQ==
X-Gm-Message-State: AOAM531stfuV8QBopy91iat6OS4mnozplcHaGmNUZ9Ut7MyFNBHcmM45
        lGPnZkURiKGhMTfdNVOlH0fVI592ZpKzt8gqI9kSKA==
X-Google-Smtp-Source: ABdhPJzJzDb/nbfb/AfHIt2PD8Hlir7+oQAowRn9WMca5ooAz57VzWQdZv5VnV8f24g2bCjQh6/IWZyE5mAFUZu4TZE=
X-Received: by 2002:a2e:3818:: with SMTP id f24mr10278752lja.338.1590396226463;
 Mon, 25 May 2020 01:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com> <20200518133645.19127-3-jonathan.albrieux@gmail.com>
In-Reply-To: <20200518133645.19127-3-jonathan.albrieux@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 10:43:35 +0200
Message-ID: <CACRpkdZrcie3Op2aLoTQgwT-2so+s2FqKn0R4B8VQ7qcxz2oCg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: ak8975: add gpio
 reset support
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 18, 2020 at 3:37 PM Jonathan Albrieux
<jonathan.albrieux@gmail.com> wrote:

> +  reset-gpio:
> +    description: an optional pin needed for AK09911 to set the reset state

This kind of properties should always be plural, so
reset-gpios please.

Yours,
Linus Walleij
