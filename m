Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C488D5806DD
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jul 2022 23:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiGYVga (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jul 2022 17:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiGYVg3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2022 17:36:29 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D059655A
        for <linux-iio@vger.kernel.org>; Mon, 25 Jul 2022 14:36:28 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id g19-20020a9d1293000000b0061c7bfda5dfso9656376otg.1
        for <linux-iio@vger.kernel.org>; Mon, 25 Jul 2022 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7cvYlgtdGg1h3CTVF2WaSRQBHIHM5H5XLOWFN5YrXI=;
        b=G/CNlIUeeRYvjXQx1OkZO+zQIqaHU+PJf3O1y0fIajjIIpn7/FpkyExlNNIOOE2i50
         xxvQCtPRyryXfUoskN4MHcOoy+jkfOz4QrukvqBn6SebqNqUIjq1Rw+TFp8FfxqSP8+1
         2U0ObJxxENofJC8LOwDKDm2PQf5nHUhK8HufTv8dCbJhyocauMqe7e/dywvly/eQR6G5
         6fMNd5udTo2Gz4EVfym3yT/Jwv3DhYyi93N4VqOiBcX2SGANbKMffeW/SW+fDjrkjTPK
         4dWlONhl/0HPKCYcLFJdGTLjoO7HRMU2qirRO/Ly81mYWgFhD5ZOeGt+ymUHO5FT/0Ah
         tQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7cvYlgtdGg1h3CTVF2WaSRQBHIHM5H5XLOWFN5YrXI=;
        b=pH0cw2tps/139McNxNfEmW8pFvuIiYeSDzqwEsKTBXcnfKkTcBtPWnw1XqWoDeZHCB
         RlEJd/IoA+rke/YB+JUmfvW+IUytME73ykppcNRJVG79OWJIPJQOD+ZnR6wKWYTSfvKs
         Ft6PE/Mh1v9gCuZI3OH0g+GfXg0h/cl1ZUZODuzs4DNxDrCPTMb8VG14OPwGahXXWqua
         Ze/WkIgHZurUlyoeKZwRCwOZx6OL93oEthnQX52oLZn8oWOPbfe3RHplYCpAjqN1Cgb0
         npPbPn3Fj/U6lc2G9nEHNWzeVNUHltj9j42jGg0NLBaYa5gAJW5ZlO0je3nvIhqtuJ/M
         LWgg==
X-Gm-Message-State: AJIora/DSjYEbcpT/AKZvJlC8tcfL1pW+pLCFLpqW/OFihfeZ+cs/eTL
        9dquwIGAgU1Q8+1WQu6ulfgXt4MwyP1VXpTHkbjOtQ==
X-Google-Smtp-Source: AGRyM1vJHxcsCou4YmOsgQR2B7XcKzmyPi4H3Wn4ClrrplXsC87Ety+fxHLB0gqU+lxl0bDPOnYVHyhZ7ISSu/irQDU=
X-Received: by 2002:a05:6830:6583:b0:61c:fd55:57ce with SMTP id
 cn3-20020a056830658300b0061cfd5557cemr2375372otb.184.1658784987333; Mon, 25
 Jul 2022 14:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv63uvFgLD8d5a4cc12OQZezHG2kfLuY=7X1obmZp4XYP7ANw@mail.gmail.com>
 <CAHp75VcrFQXW10vkLSB5Yh2D24zPzKR9FtfDU8bsSqDwD7=zjg@mail.gmail.com>
In-Reply-To: <CAHp75VcrFQXW10vkLSB5Yh2D24zPzKR9FtfDU8bsSqDwD7=zjg@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 25 Jul 2022 23:35:51 +0200
Message-ID: <CAKv63uv12XWEEVAhUBuK9Botj4mCtKWwRL-YzxywOipTAHgQFg@mail.gmail.com>
Subject: Re: Controlling device power management from terminal
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Jul 2022 at 23:27, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jul 25, 2022 at 10:48 AM Crt Mori <cmo@melexis.com> wrote:
> >
> > Hi,
> > I am implementing the power saving modes for mlx90632 device driver
> > and while I have implemented routines for SET_RUNTIME_PM_OPS
> > (runtime_pm_suspend and runtime_pm_resume) I am not able to find out
> > how to trigger them from the terminal.
> >
> > It could be that my driver code for power management implementation is
> > incomplete and I need to initialize something more.
> >
> > Maybe it is helpful, but the power submodule of the device contains below files:
> >
> > $ ls -al /sys/bus/iio/devices/iio\:device0/power
> > total 0
> > drwxrwxr-x 2 root gpio    0 Apr  6 14:17 .
> > drwxrwxr-x 3 root gpio    0 Apr  6 14:17 ..
> > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 async
> > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 autosuspend_delay_ms
> > -rw-rw-r-- 1 root gpio 4096 Apr  6 14:18 control
> > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_kids
> > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_time
> > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_enabled
> > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_status
> > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_suspended_time
> > -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_usage
> >
> > And control is already set to "auto" which according to documentation
> > should allow the PM.
>
> 'auto' should enable it. So, whenever the driver thinks it's a time to
> power off/on the device it will call the methods.
>
> You may hack a bit to enable autosuspend (which often is not a good
> idea for IIO sensors) and see it done automatically after some time.

So the idea is to wait? How would I enable autosuspend - by lowering
the autosusped_delay_ms? How does the driver decide that it is time to
power off/on?

Do I need something else enabled to have this done automatically?
Autosuspend is 5000 in my case which would mean 5 seconds, so I am
quite sure I waited that long and I did not see printk's from the
driver.


>
> --
> With Best Regards,
> Andy Shevchenko
