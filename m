Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813C21C70B6
	for <lists+linux-iio@lfdr.de>; Wed,  6 May 2020 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgEFMrk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 08:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728364AbgEFMrk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 May 2020 08:47:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E03C0610D5
        for <linux-iio@vger.kernel.org>; Wed,  6 May 2020 05:47:39 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b26so1226130lfa.5
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2020 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHVvUB43yJMR2ywq8FjwLtRue3JBjP1es/NQQxOMgHk=;
        b=xTqz08J2AQ3jobyQwn6kTFMt6Dq8VbZ2Acjud74nn8JuVnxxnCv77Uvn1lrNTLjNIG
         OUXfAhgbA2ir3p2H0ysEHZVlDApXpjO5Mp7tNNK8nfl/2skS6FD1NgcVN3HinysBQGNa
         HvaqLulbsjnih3Dfk6oyYE1HFE3K2QfPUdgkBQm61mXPrMVNzycHiCWDDzpo08xIvNcc
         9JN3ACXFUTIaG8Y2dcMVxayD+9hrxgd0ibqDrJO9RUdgiKBRi3c0P7UlIrebxbrmIvTx
         PYUiTYO/O+Fb5YbsretlLsS7uVt4K6ASAmIAzNea0Y2r80H3EgemStUl3rv99TuErvm0
         6DEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHVvUB43yJMR2ywq8FjwLtRue3JBjP1es/NQQxOMgHk=;
        b=tb6ZeSUsFUl5keGdWCHtXr5t97DRrakukkI9KvX+lGnLt19pie0Eg8c+naESyDSpG/
         JFJvkkZZaLWAmvdA2RR40tp107OPHK9JC2VEppGNkB5cuANsZuaM7lUnLQCndjKNWIKf
         aqilFk2Z7WpfGBcGfxMSlzmI37viqJ8qyHybNGpEsHDFR9JF4IAB9phe219QvYZI4wLm
         f8mCzn4XZjCwRZSBfyThugEkKgwUuoKn3yE35TWrxb4J4/Ku9o59vKbIet0xh7OmhApv
         73PhRJVduh68GzbUIGL9nfBQZrB7i7Wfp5NsbIUsG18MgTjY6jOU55oJ5oL//CHtks8G
         XgOQ==
X-Gm-Message-State: AGi0PuZJYePIwDZIYZ+lgw/p9WHY2tDkdQ9afb6appq3+P1sNCe0CxQ9
        QY748NVR9dmWzFeuxTlaeaM2uIiQq4FJfNP40kqcpw==
X-Google-Smtp-Source: APiQypKBbl7K+xy+RhSGXMmOQBxZEWjnqxgPMoR3N1qvMn2Wotn5IUAW/yAiP/gr5YCR7Sw7ovooKd8Y1hu1QPDahkc=
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr5062159lfr.77.1588769257911;
 Wed, 06 May 2020 05:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR04MB0660046ABD79433EA94A85A9A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB0660046ABD79433EA94A85A9A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 May 2020 14:47:25 +0200
Message-ID: <CACRpkdbb89q2FRJZ1=2QoQs8JFYcwWpNZwJUbnjsVvZYEE-LKw@mail.gmail.com>
Subject: Re: [PATCH 0/5] iio: accel: Add bma023 support to bma180
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 3, 2020 at 7:22 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> This patchset adds support for the bma023 three axis accelerometer
> to the bma180 IIO driver.  The bma023 is found on several ~2010
> phones, including the first-gen Galaxy S series.
>
> The bma023 differs from later chips (bma180, bma25x) in that it
> has no low power but still working mode and no temperature
> channel.
>
> The bma023 is already supported by a misc input driver (bma150), so
> when both are enabled, the iio driver is preferred.  The bma150
> is very similar to the bma023, but has a temperature channel.
> Support for the bma150 is not added in this patchset.

I'd say, if it's not too much trouble please also patch in
support for BMA150 and SMB380 to the IIO driver so
we can delete this old Input driver, we have done this
before and thes "input drivers" are just causing headaches
and wasting time for the Input maintainer.

It can be in a separate patch set from this one if you
don't want to get stuck on this.

Yours,
Linus Walleij
