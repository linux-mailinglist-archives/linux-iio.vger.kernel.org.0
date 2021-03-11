Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166A5336CAB
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 08:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhCKHB5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 02:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhCKHBk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Mar 2021 02:01:40 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933D0C061574
        for <linux-iio@vger.kernel.org>; Wed, 10 Mar 2021 23:01:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hs11so43958194ejc.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Mar 2021 23:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ePbzz48BJbDJZuqQXB7WXLflIirIxYx6QnnOQ+uwEqw=;
        b=M6rNgnhsV40/pF8sbJS8kDhuQoBWHBydy/t+rnMp/oipKzwSc2EJs5XEKBD3bCSxhC
         AbtGRxM7eKC3ZuA83BLwVHocs3ZMLlHC86NStpUyWVagbx2dF4Birpv9gpetyPBNHMOh
         ENK/8W44nqSJaqlLBY8Mp4Hc0KtVfjQRLzrdB3W1oyOavHD9+4RlIjgmy2GYimdNVlUj
         ny7pnUGdOab8VaDjOcF6b+yNE4K8DGMpCGg5/H2jTlE8Q5st2ZLSj5xVv3oJBeJ5zx95
         KCR7wsi4jfGsi0wGS4PwvPSsW+vZD5AqnX1Vw2aQHM8sJZ7RVl2frRgjtOgKGjGIXSh1
         GEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ePbzz48BJbDJZuqQXB7WXLflIirIxYx6QnnOQ+uwEqw=;
        b=WuctQ6dV/DZe9vi7PZth4GxrNZ7XPcKMb6vlEN2889EAs0YYPExyaCBd9mYL4jyJjA
         +kzUDr+K/xgpL9QX1M0GaXqLgiMp4k6DyZSlNxZzT2f3hOR/xeym52lj40xsdDlRCF1i
         0/1mdh7+EEtwAPQPL8lyE/6VvjBH9RqbjtIwIZoMDGfXE2cQD4bRWGOH+6eeyB2eKdLP
         /yIi4rTj5Tvsw7xPkYcqoH139Yidmd1Z+uvFZSABuQJ6xTf1xXeY238RNQGsMghWZcrc
         dwZIUbr9IiCUK1w/x8ChEKCDdv/UtOAZ2CxBUZxnzQDzsUD2LlZJv2QI+3geOEmubLjU
         xUfg==
X-Gm-Message-State: AOAM530T2ij9nH8u/N+ZMslrAmkdHgEHyDaNoR+kMi1uFCYpcJZE1+O8
        QZnf34jHE15Mw97hQl9T6rx23Mlxvd5deW7y6VpvwJZ49ubnLA==
X-Google-Smtp-Source: ABdhPJxs37EYuCM/VnZ5SZ7nUd7jR4PA+6tN2vXlxKpYfcB87GySAmcUB5GYJOOc5+shPXODUxTQ2cenXZkjD6H0Vxw=
X-Received: by 2002:a17:907:788e:: with SMTP id ku14mr1670821ejc.17.1615446098820;
 Wed, 10 Mar 2021 23:01:38 -0800 (PST)
MIME-Version: 1.0
From:   Mugil Raj <dmugil2000@gmail.com>
Date:   Thu, 11 Mar 2021 12:31:26 +0530
Message-ID: <CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com>
Subject: GSoC IIO project: Mugil
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
This is Mugilraj, an undergrad at NIT Trichy, India. I'm applying to
GSoC'21 for the project IIO driver. So, I need help from you guys with
the application process and finding the device to develop a driver.
I've done few exercises on patch submissions and completed a Linux
Foundations course, "A beginners guide to Linux kernel development
(LFD103)". I found this "https://kernelnewbies.org/IIO_tasks" task for
beginners, and now I'm doing that also If anyone suggests some fixes
to develop, that would be helpful for me.

Is there any IRC channel for IIO?

Thanks,
Mugil
