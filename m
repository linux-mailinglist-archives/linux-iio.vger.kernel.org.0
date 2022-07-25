Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE4580694
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jul 2022 23:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiGYV2O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jul 2022 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbiGYV1m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2022 17:27:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DBE24BF6
        for <linux-iio@vger.kernel.org>; Mon, 25 Jul 2022 14:27:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id tk8so22840993ejc.7
        for <linux-iio@vger.kernel.org>; Mon, 25 Jul 2022 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LHfuBNA8HPcEuiBLLkG5dHMxh+6hUdGe9sNRqIjaOU=;
        b=bhn8J1eXES1FqXT6JHPlQrdVAud5izbQZ5HjqR3ZPkeRVH/ZLcIiVNNsRvP/0LST33
         j2B53qycCDL80be4EsPXaAtLbJusySkEFKITOV12rcO4N3QjLTvE9d2qaNqhLx9jGKWR
         XudEoEkFDZqhQH64UtubpclEPs7/To45yoyfFxB8rZwuSxb7MsopPq34RNk3hNZNPWcQ
         49TZEx+y4Lg4lc/X8lSJ+mTo38b0s6EzHhPsGhKRWydB6lkSmN+t9fm9LPaCmX6ZyAyT
         SZeBSJ3otG8RTXVAF6PiihKfijMOfIXDgJiZNnpjzt0LUYuI3KWM4t8HOoYKe5QekGND
         c/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LHfuBNA8HPcEuiBLLkG5dHMxh+6hUdGe9sNRqIjaOU=;
        b=iGD6t1rd+YuB8EekAOKDuialDdYJgRm2KZDVJJzeMdHgj0FD5PMgp/psLVr6EKghJE
         L1qN/ABZ/gV4+AwGmK1nw7plEpwVOu86dm42Al/JXCN96M5+/V10BFYumuz3Lro5IJle
         tbSm3NJy0H40Y0Z8gaQlg/cU85zSREGSrjeyPQrcyN6GhTSA+9EPgeTO1GC6kAnLfX44
         UfaYPQTvR4KYvzKVVwEozSfGXRqcydliA6gXn/pjdlxRHYYfLCsTDXX22SbIVMk3B7gj
         uXHUz5FFeNPH3/vt1XPSEXpWAysEx7Faus243cnDigbASJ1BBYNQ9X2oEe4mqco4pwmq
         zcOw==
X-Gm-Message-State: AJIora90VOXKYJBdyJ6rFlL3F9oGewy1uNbKmMldsG0aGHuqZ/33GmxB
        BrL7whoFzx6K9yUe/+7J81qS4jCqgB3zGwKiEdZLgWIIER4=
X-Google-Smtp-Source: AGRyM1tqh03nRi8zYV1msk2FyLNz7Fv1CaNfdTqEUNf85YEUy8ik2/ptLicfNznAgWfGfkk3UmgXHai7dre4r4h1N34=
X-Received: by 2002:a17:906:9b09:b0:72b:9612:d373 with SMTP id
 eo9-20020a1709069b0900b0072b9612d373mr11301733ejc.606.1658784442118; Mon, 25
 Jul 2022 14:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv63uvFgLD8d5a4cc12OQZezHG2kfLuY=7X1obmZp4XYP7ANw@mail.gmail.com>
In-Reply-To: <CAKv63uvFgLD8d5a4cc12OQZezHG2kfLuY=7X1obmZp4XYP7ANw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:26:45 +0200
Message-ID: <CAHp75VcrFQXW10vkLSB5Yh2D24zPzKR9FtfDU8bsSqDwD7=zjg@mail.gmail.com>
Subject: Re: Controlling device power management from terminal
To:     Crt Mori <cmo@melexis.com>
Cc:     Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 25, 2022 at 10:48 AM Crt Mori <cmo@melexis.com> wrote:
>
> Hi,
> I am implementing the power saving modes for mlx90632 device driver
> and while I have implemented routines for SET_RUNTIME_PM_OPS
> (runtime_pm_suspend and runtime_pm_resume) I am not able to find out
> how to trigger them from the terminal.
>
> It could be that my driver code for power management implementation is
> incomplete and I need to initialize something more.
>
> Maybe it is helpful, but the power submodule of the device contains below files:
>
> $ ls -al /sys/bus/iio/devices/iio\:device0/power
> total 0
> drwxrwxr-x 2 root gpio    0 Apr  6 14:17 .
> drwxrwxr-x 3 root gpio    0 Apr  6 14:17 ..
> -rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 async
> -rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 autosuspend_delay_ms
> -rw-rw-r-- 1 root gpio 4096 Apr  6 14:18 control
> -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_kids
> -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_time
> -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_enabled
> -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_status
> -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_suspended_time
> -r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_usage
>
> And control is already set to "auto" which according to documentation
> should allow the PM.

'auto' should enable it. So, whenever the driver thinks it's a time to
power off/on the device it will call the methods.

You may hack a bit to enable autosuspend (which often is not a good
idea for IIO sensors) and see it done automatically after some time.

-- 
With Best Regards,
Andy Shevchenko
