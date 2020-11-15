Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F62B3A67
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 23:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgKOWvE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 17:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgKOWvE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2020 17:51:04 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD603C0613CF
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 14:51:03 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 74so22593349lfo.5
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 14:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZe1fx7IfIv51Te5TCQoL3jLShb/zNDf2uTo6faO4zk=;
        b=T6Vpwn9ZC+wp3rUIuIKey5ZTdePhxfIA4l1bZDM2MeAqeRCsNxaYtxPyYlhBI3FAol
         EyCFsHubHobDVEDTSv95awaRksw1k9ZUzgtCLiqazE9EH7umPZBKip+QLMrtD9Za5FIw
         pjBWHlkjvru3L9E+sxhiu+GwlpTt4OmYiX6pa33mAy8E25ZmsWXzTiIpbLV2ySkM2xOx
         tfJ53h1x2tcpAo9gPVMhFfOIYeQaYsuygOjpQbfZJT1gYyfWbb4mK+k5i7VVRsk6uIpq
         c2pdVBoh48hheh6ZUmESat+jOs5WXZw9H1PMT/kvyGr9IuHncKkWJWVUQnVhsUd8gUjf
         fGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZe1fx7IfIv51Te5TCQoL3jLShb/zNDf2uTo6faO4zk=;
        b=H37nuf18OY9Y3jzp9ela1v/ViBNOerFewk0NDbY/axsGFUJIELTsK/f4/Db4Zhc5QS
         /inhZJcr0YhkAsmSu9ftXvOWf/7KFPrbYTC0qNW/bvfbzrjEiEAx0mmGcUuFddReniaN
         YxZXBUn/hd0ywNm63HEr5TQSMslNM10g+8l46HGcNdceD93/CJY/6xAQwgVUQObQbHM4
         4p+BTHA3Xb0+2yhp/XZkf4HEg9sgPrUT9S5etkyq6ln+Giw01wGCj6DKQV8mCUWVC324
         UyYyDuHNtCRxNsWLfxQNQ6dxMOsDYfHfs11S/KJt560KNQ8dGoPj/YJESC4Makj5nkzO
         ylHQ==
X-Gm-Message-State: AOAM5327VKAhwQ2DwMSgOawOarSGB++E7PRFlgK4vMdg7vG1J0tBLkUC
        P04uWbxFxuEJ5zGCHVdLXRTV6F14IULz6IHH0xeS3vsIKug=
X-Google-Smtp-Source: ABdhPJyY3BWvXTyD0Ewg32V3pEANYRiFiwIP3icGZ9GxDUQmaB3TCzTm1QGQNvDHIu7Tc+diU7TsteaxrheK3H71I8w=
X-Received: by 2002:a19:8686:: with SMTP id i128mr4177697lfd.333.1605480662245;
 Sun, 15 Nov 2020 14:51:02 -0800 (PST)
MIME-Version: 1.0
References: <3b8dc467b30dd6869ea60ed583cad750c74eb44e.1605450804.git.lorenzo@kernel.org>
In-Reply-To: <3b8dc467b30dd6869ea60ed583cad750c74eb44e.1605450804.git.lorenzo@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 15 Nov 2020 23:50:51 +0100
Message-ID: <CACRpkdaAuppq8PesYRv-8Tww0saRbJu2XmYzGWnTm5Rdm-xZHg@mail.gmail.com>
Subject: Re: [PATCH] iio: common: st_sensors: fix possible infinite loop in st_sensors_irq_thread
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 15, 2020 at 3:38 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Return a boolean value in st_sensors_new_samples_available routine in
> order to avoid an infinite loop in st_sensors_irq_thread if
> stat_drdy.addr is not defined or stat_drdy read fails
>
> Fixes: 90efe05562921 ("iio: st_sensors: harden interrupt handling")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

This looks more clear if nothing else.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
