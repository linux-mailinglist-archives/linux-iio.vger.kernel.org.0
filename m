Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39878496D41
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jan 2022 19:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiAVSQg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jan 2022 13:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiAVSQg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jan 2022 13:16:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA708C06173B
        for <linux-iio@vger.kernel.org>; Sat, 22 Jan 2022 10:16:35 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a18so48463488edj.7
        for <linux-iio@vger.kernel.org>; Sat, 22 Jan 2022 10:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVjNMhAOEvIRMUX+Vct6qJ0TvR34CHCUM62ejLntanc=;
        b=nQviZLdPNIMOvpKR4hw1dvsw69UW2MrvEo0X3/PoG2YDPOrwpcdTdeCk5WjEO4JnJ9
         bmLLvBLwpTnRKHOHYtgrA9qPgLBKeEOZvaBjqMfJW/xyjThzQJCQOjt8yGiV3CGXaVxC
         OSiArPv2xRhvBaXBkpDxjKRopaX8k6fb3XnDCbUqmAeTaE671jRvvQ2CYLAMaE6FSKNX
         M9czt2pDIPayo528xsTL2iDg0qdV2NVDb/PQx5rEEl4GvBeiGvBEOQduObahbjtVboqj
         78z9J11szVCZzjuKj+vzvldF9/vPhnRgi9brAul+gFgyZ7XMgfru8lur6oZFUvM3PB6E
         WgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVjNMhAOEvIRMUX+Vct6qJ0TvR34CHCUM62ejLntanc=;
        b=lh3Dq0cAfetNjuCE+SUhc4y7Q5JcCdswroYTLEEphTC3qtKgH+Vn2hcw7Gf+hSCsKk
         t/Nh/f0GUFaVWcv/R1AnIi2AVFerF5ien/gMXYFSKLidCXk73sSquWlKLd/+Ga7YxEV9
         aOooEaqFTz9MqneAatbjWKSXg3B2DR0bht56TKMTkDTZD2bpCtVkUgBh9mZDxglorC8V
         L9OM4wAOFGrzVseKu95cyAJr1xAvM+1IF4+1VVU1+h0CGD8N5vQnspzrFcEe+eQj17Rl
         0v7SbTrKLHh+LoNv5c94EdtvneXhSqDGpqmh9mxwF5mkWhR4r813LvLTiUCzWHX2B587
         H/WQ==
X-Gm-Message-State: AOAM533FZC/YYyre9zgbPHzM1sxMzXu00X880YLalLOUKrDq2M8uL84s
        ykC4xIu7uiQG2hF1jQ8E/8vz9KQscJwM0PTk9GHAGrabEms=
X-Google-Smtp-Source: ABdhPJxostjOpIgxd87i9c1Nk7G+zSosFuzr8MWZJCofEgJMcmlxUDpebsloXfGy58qhlbLZochTsT3G0LaS7MH9pxA=
X-Received: by 2002:aa7:cf0e:: with SMTP id a14mr9006985edy.296.1642875394115;
 Sat, 22 Jan 2022 10:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20220118212504.832429-1-gwendal@chromium.org> <20220122172940.125d8033@jic23-huawei>
In-Reply-To: <20220122172940.125d8033@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 Jan 2022 20:15:57 +0200
Message-ID: <CAHp75VcRFRVOPvgGROiNM4wQurTDn+D-DSc0oU1YsrgkkNOF6g@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9360: enable push iio event
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, jongpil19.jung@samsung.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 22, 2022 at 7:23 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 18 Jan 2022 13:25:04 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:

...

> > Fixes: f75095753 ("iio:proximity:sx9360: Add sx9360 support")
> This is part of the tag block so should appear.


> fixes tag should be here.
> > Signed-off-by: Jongpil Jung <jongpil19.jung@samsung.com>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

...and the submitter's SoB must be last (according to the documentation).

-- 
With Best Regards,
Andy Shevchenko
