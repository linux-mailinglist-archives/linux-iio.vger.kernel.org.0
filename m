Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D934D6EA7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Mar 2022 13:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiCLMUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Mar 2022 07:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiCLMUq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2022 07:20:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54BEBC18
        for <linux-iio@vger.kernel.org>; Sat, 12 Mar 2022 04:19:40 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y8so8886494edl.9
        for <linux-iio@vger.kernel.org>; Sat, 12 Mar 2022 04:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piNItBLqHCeDJidxUNalAaLWUBnWu7tkeeRo5hh08hc=;
        b=PsHp/PyuC94v7ys1vAM6yG43xvb3pZcfG3sFy69y0D3nlzOx1m+UbyGSXAI8lV5hHl
         RVQZL1pKR2hd2kssAx5s2CFL5VlHxH1E+tA26VAS1Oz/Td5T8zQHpPlprg2DfBplw6z+
         6dNjhtL1u7sGAp4fSyMXwNLSJvlhsx13dBhZmlnz96F7EAE/TuvXFgQ3a1m2mNaJ+7dh
         kJ8WsWAavjSw6FIu6443vcW6dzNbY68m3/Dp5zNFph9fwWwG7JyMTcVnM8pObX5kbqOD
         c5gFTPaIViAYN2LU8RQmvltZXvDfeC4WcT3R0PsGD5yngbWzKDWh9mR+S/Dp8X/EFQ0u
         684A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piNItBLqHCeDJidxUNalAaLWUBnWu7tkeeRo5hh08hc=;
        b=3imEFr44lLC3USgy2ERwZKRnefOC608/3pi2G+Qq8mzAwTN8nvAxd7w13nxs2DKOXx
         YQR11JGq4j23fKVJUNM4UJy2RoITUoFQJpeB3G+jl/4JwSkCrsamom/BtqNSUwW68p65
         T8IPSDKHF5aRPqzbzjpHoWQ4OeiG71BWuvfbNv7zkL72mW6tatCgq9vgHHGsRl3pL9CO
         35pquqRI/hqZ3rSxH63W9iaUZwwj+hGLNkdDTfsdoed2Eaug62Gj5oQaITDN0Vnp6qeU
         9OdNObPDBsw9G3dGg03RKOqkv51AO2KaBHjdG1QBUqN0hO0porAatsKcT/tvA2whOfFT
         WzZA==
X-Gm-Message-State: AOAM531F33YLvdsSYSrE/ulpwLj+HF8S1wADvO5gmvJiWS89VHrvQD5N
        WAcM/Sa9DZx4KaMozPXaZEzUA7IYFJfmB/yNqv2EnV9DEqQ=
X-Google-Smtp-Source: ABdhPJzOQ4tUmJUVwykFAH03CH7/mw+rlDAUR8fk28lHbKWep4O/CkGQRo7/MErTq+BfTYvH2BZqJLqA1M4t6KQr6zw=
X-Received: by 2002:a50:da89:0:b0:413:adb1:cf83 with SMTP id
 q9-20020a50da89000000b00413adb1cf83mr12611271edj.158.1647087579225; Sat, 12
 Mar 2022 04:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20220311184925.99270-1-marex@denx.de> <20220311184925.99270-7-marex@denx.de>
In-Reply-To: <20220311184925.99270-7-marex@denx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Mar 2022 14:19:03 +0200
Message-ID: <CAHp75VdS+VRFSu8q3Si4yVEJd3aYxoFBaz4cYh7PXLGCLmNvaA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iio: adc: ti-ads1015: Add static assert to test if
 shifted realbits fit into storagebits
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 11, 2022 at 8:50 PM Marek Vasut <marex@denx.de> wrote:
>
> Add compile-time static_assert wrapper to verify that shifted realbits
> fit into storagebits. The macro is implemented in a more generic way so
> it can be used to verify other values if required.

Thanks! I think we may leave it to maintainers to decide if it is
worth adding or not.

-- 
With Best Regards,
Andy Shevchenko
