Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F329057FB91
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jul 2022 10:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiGYIlq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jul 2022 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiGYIln (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2022 04:41:43 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A59914036
        for <linux-iio@vger.kernel.org>; Mon, 25 Jul 2022 01:41:41 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w6-20020a056830410600b0061c99652493so8195569ott.8
        for <linux-iio@vger.kernel.org>; Mon, 25 Jul 2022 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=uTjKVHM55JmJsVe2aGmCPrG6R8LbZnPZHi2RrDTr+hg=;
        b=ajOOG7RVPogWBL5z787apCCcNbOfTQcTEaLdb3smgqbQqObufplSwxMWZGjSvlLQIb
         1oitahisHCi45SlAF/HI84kBdIQIqs9cttab5v2OHsaQeo00dT485mlY+RhDeHDW60Io
         hw8IK2TxE6GnYwsndW/einvl63zinAlH8vhnnvmBECbG+DpddJs0SGmzw6sECfY6Td5I
         43JpSDr7UkrDA+i/Up2BOapt56fE5mzfVS1ttiAaMe4MJBYIuKEg6naDJAdMZ0Fv14VO
         emK0Fu9AdTIe8AQSO5B9SmHlC8kcAiMzFPPp/nBG8ewhUcgPNR6EmO6C8W4b9XEGCTTW
         MrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uTjKVHM55JmJsVe2aGmCPrG6R8LbZnPZHi2RrDTr+hg=;
        b=qz2IB/qo5gv3cMuk93+UAsZW7AmrXxDGjwHdAEZvWfiLmqZSXKqsk3d1PYsIQgdwU2
         sSK/ll/BNC3xxeCbBmKvMhUN0P7GSBDYniq1utmqJyzi0mvPcqSh3GTJdeb7CnnJ/dND
         WAHaij8ptPnLUbJIo5Uo/h46sJW9AE7hkhp705hWQwnsa9hvuMjHzR8lJk6AdB0VdoAV
         LD+P17auA+AONDhTVdqx1byTpyP8E41knlTG0Z8dun6Nc8zm8wI4mI7JuEgknAy1ytYx
         sOoQfVYGHSxvgiVFubfxQmrNPZKNQ1C7wVt10v5RQtZ69UtBUVF8fFhJ1JpY7o0RWmFs
         94gA==
X-Gm-Message-State: AJIora9D4mODL0qZYGzpq4pYQVpEf/h9Dvn1s8xb73eX/H5mANigJpyt
        xJO9q+N/OCMd68PfLEB274eO4DtviQoZOXd+dIULBaXch7J1tSFU
X-Google-Smtp-Source: AGRyM1tjUhexl5BMwvtevjJPceeD7pVcZfaQilTIyV9QAJD9KJW+C5YCv/f3ACJzOPi4AD4Uo3mrdM0UNYHNILklqNM=
X-Received: by 2002:a05:6830:660c:b0:618:f504:5b7d with SMTP id
 cp12-20020a056830660c00b00618f5045b7dmr4230838otb.300.1658738500275; Mon, 25
 Jul 2022 01:41:40 -0700 (PDT)
MIME-Version: 1.0
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 25 Jul 2022 10:41:04 +0200
Message-ID: <CAKv63uvFgLD8d5a4cc12OQZezHG2kfLuY=7X1obmZp4XYP7ANw@mail.gmail.com>
Subject: Controlling device power management from terminal
To:     Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
I am implementing the power saving modes for mlx90632 device driver
and while I have implemented routines for SET_RUNTIME_PM_OPS
(runtime_pm_suspend and runtime_pm_resume) I am not able to find out
how to trigger them from the terminal.

It could be that my driver code for power management implementation is
incomplete and I need to initialize something more.

Maybe it is helpful, but the power submodule of the device contains below files:

$ ls -al /sys/bus/iio/devices/iio\:device0/power
total 0
drwxrwxr-x 2 root gpio    0 Apr  6 14:17 .
drwxrwxr-x 3 root gpio    0 Apr  6 14:17 ..
-rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 async
-rw-rw-r-- 1 root gpio 4096 Apr  6 14:17 autosuspend_delay_ms
-rw-rw-r-- 1 root gpio 4096 Apr  6 14:18 control
-r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_kids
-r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_active_time
-r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_enabled
-r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_status
-r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_suspended_time
-r--r--r-- 1 root gpio 4096 Apr  6 14:17 runtime_usage

And control is already set to "auto" which according to documentation
should allow the PM.

Thanks for the hints.

Best regards,
Crt Mori
