Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0733B0D10
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jun 2021 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhFVSlE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Jun 2021 14:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVSlD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jun 2021 14:41:03 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB469C061574
        for <linux-iio@vger.kernel.org>; Tue, 22 Jun 2021 11:38:47 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id x12so209738ill.4
        for <linux-iio@vger.kernel.org>; Tue, 22 Jun 2021 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YfBJOMVnJKbIdhhRlUJj94L22PTEyZFCqjBlyaS4Be8=;
        b=gp1VQLMtZkRMCFAbE68lER42n4rxSj5ejmnwLgb+7he2cjZiJsP2wQUQhn9jjfT6vr
         8N3pjc2/A8VFmlYqY1lyg+9SJFdl/QBJbxKC3GTb01Hfc5XAeGH9JlvzY3PL8IPvSwaP
         HAtU4VV6ZX7yqhPaZ4MHfERHTswoyE0v2i84P901IjmUyYUjTjtI+EbcVpHn1IbGwkKK
         +Ww4haVjeX4NF7RRjgKLXHSFk7B0VfkQaXs52dNJyOcoF+ee7kBMjYL5sdCZL6WUzzGv
         6kq0NC9he8u7uMZxjos+fa2W4MLfATOwbyAEnT4G3AleMS0drMz9amdVY7GwgszL086z
         0R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YfBJOMVnJKbIdhhRlUJj94L22PTEyZFCqjBlyaS4Be8=;
        b=XjAYNjHgVMw/cfw6jZIXYoSW6LZNQ7E1QLNw2/NsmRDab9Ebw/A0+Mv7pKrw3EENmR
         I+yTxbzxY3GpVbpeF3xCvZblER5AngIsBeKaI803xnp0h7YSe9VEX4GpxFXxeVMlj1eA
         7x1CntwRbFLgnzJu5cj2buJsjVdRz8UDlETB4metHsVIcUmvlyDZdxQ2vM+gR2As3kKJ
         QfsSnvDWh/pfgTph6iSb2mYk40iIhGkhPVL1h4DRO7pTAtuH57dBzntrKrpQxie+OzUE
         P5RhQzztzerkElmeG6wgEQFBAn+cyi5uUpR6Lqalvmv0NxCeasYRwXy7SOY6UfGS35qN
         pu4g==
X-Gm-Message-State: AOAM5322Wq0ru72xOJubGj77a/xVxJ4WB0gzAIoTVqJqXsYdC5GzYb5F
        fA9LcbPNzeBzuclbXMbgcgvdhVdhO2I7LwRCE74GY7ko
X-Google-Smtp-Source: ABdhPJxJzixZWjqegOxPeTigOuvVuXgkbeiDhz+9etDcyU4HnWLN0K4ySw20Mnyz7NaKlRRwdV2emVCtcuTmXylsJ30=
X-Received: by 2002:a92:360e:: with SMTP id d14mr63795ila.106.1624387127049;
 Tue, 22 Jun 2021 11:38:47 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Roberts <arob109@gmail.com>
Date:   Tue, 22 Jun 2021 13:38:36 -0500
Message-ID: <CAPkENw_AL9R-0BGb-_Je96Wit8TBEq=UrF14wkZiO6h1J8BnvQ@mail.gmail.com>
Subject: Re: using dma buffers for SPI adcs
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan,

Thanks for the information. It appears my original email was sent with
an old @ieee.org alias, meaning I never received the reply since that
alias is currently inactive.

My end goal is get an 8-channel ADC working with >100ksps/channel.
That doesn't seem do-able without an FPGA/PRU/real-time coprocessor to
offload the SPI controller to for an IIO-based approach. So now I'm
researching how to do something similar, but with the ASoC framework
instead of iio, using a different ADC that supports DAIs like NXP SAI
and TI McASP. But I'm running into issues there too with learning how
to configure simple-sound-card and a dummy-codec, but I suppose my
questions there should to go to the ALSA mailing list.

Starting to wonder though if I do need to go PRU/real-time coprocessor
route e,g., Cortex-M4 on same die as microprocessor (e.g, IMX8 and M4,
STM32MP1 A7 w/ M4, AM3358 w/ PRU, etc.).

Thanks,
Alex.
