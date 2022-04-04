Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A674F1B58
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 23:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355480AbiDDVUG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 17:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380584AbiDDUh6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 16:37:58 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A03D26AC8
        for <linux-iio@vger.kernel.org>; Mon,  4 Apr 2022 13:36:00 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso8086907otj.0
        for <linux-iio@vger.kernel.org>; Mon, 04 Apr 2022 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=kg/HA+QVDj4BE3Pqgs7Z5r8nQIoSf5HmU9Y6IMHvcQ4=;
        b=UVy/2H9XcZxhjUlG0pYTnPvMihiwPuXQOj7n67eXl88rrzpXlhojBgVlnVFlDpSu4L
         CrXdTnuAdKochmYTpKdEYeBgTUI5N0by54eD0eZz37TSdHUNjKnsLDZK2XXj6SPQtxZ1
         fJu3eDe/uIOk1oFujxuRIgdsO2/npaXmdg/KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=kg/HA+QVDj4BE3Pqgs7Z5r8nQIoSf5HmU9Y6IMHvcQ4=;
        b=7FKEH3zHKTU1t8MxVd5dQ/m/eo0AIaFq2ohXXNlOkR4UQxfzVSpoubjEVPvytduHyx
         HQRm/I7UTM9OCSNFk3rvNh0neu/f2bnOlUhhknZ0zCApADdCRnMEmlw6Qb26DcBQXG63
         KK0geJHxuTRQjeFSTlYzarDq6TrqVpfI8MDuiR5r1gXyo34QXps/npAXgKNDcxUsmmJz
         iIMVfMPXCr4jDx2b+2/XYPARYgl2tB324G1FN3G1ch80mjYD9b69dWy0Oj1jG5I5HWot
         H16yUgMxQlkNY4iyt75rLYyjMLBzBSPcjgtD4QojwakMV/fZMHSzSGK4nLHWUWCdIe5c
         2S/Q==
X-Gm-Message-State: AOAM530O7bFigNF2yl6hrbKOdLbSkZvmw0OGmq/GjjkQFsmvnLU1ClW2
        okBGXOL9Df17wHNxLC5xYiSazx4QMAR3cix1I5SYPw==
X-Google-Smtp-Source: ABdhPJx/Lq/nxMT92DUF/KzpDcHBIOBMR/7Ec7G1dTVR2ng1S2RYXmK8ST+N3xxfbiKsvwc+yRZ4cDCJFzXmSyQu4NM=
X-Received: by 2002:a05:6830:61b:b0:5cc:e44:7dc3 with SMTP id
 w27-20020a056830061b00b005cc0e447dc3mr36332oti.159.1649104559265; Mon, 04 Apr
 2022 13:35:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Apr 2022 15:35:58 -0500
MIME-Version: 1.0
In-Reply-To: <20220402175131.75bb95de@jic23-huawei>
References: <20220324222928.874522-1-swboyd@chromium.org> <20220327155147.52e898b4@jic23-huawei>
 <CAE-0n50T9uqcB9EK-RnGXPGhd6RWdrsE9pA5FJY9yC58xd=05A@mail.gmail.com> <20220402175131.75bb95de@jic23-huawei>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 4 Apr 2022 15:35:58 -0500
Message-ID: <CAE-0n53iU+Wne7Tvxr_ivwdqLVd3Mg-FNM7xLJ=ztsAF3QEALg@mail.gmail.com>
Subject: Re: [PATCH v2] iio:proximity:sx9324: Fix hardware gain read/write
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2022-04-02 09:51:31)
> On Tue, 29 Mar 2022 22:25:31 +0200
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> > Quoting Jonathan Cameron (2022-03-27 07:51:47)
> > > On Thu, 24 Mar 2022 15:29:28 -0700
> > > Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > > There are four possible gain values according to 'sx9324_gain_vals[]':
> > > >
> > > >       1, 2, 4, and 8
> > > >
> > > > The values are off by one when writing and reading the register. The
> > > > bits should be set according to this equation:
> > > >
> > > >       ilog2(<gain>) + 1
> > > >
> > > > so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> > > > in the register field, etc
> > >
> > > Example seems wrong...
> > >
> > > ilog2(8) + 1 = 3 + 1 = 0x4
> > > ilog2(4) + 1 = 2 + 1 = 0x3
> > > ilog2(2) + 1 = 1 + 1 = 0x2
> > > ilog2(1) + 1 = 0 + 1 = 0x1
> > >                        0x0 reserved.
> > >
> > > or have I misunderstood?
> >
> > Nope. I hit the wrong key but your table is correct. Can you fix it when
> > applying?
>
> Done and applied to the fixes-togreg branch of iio.git but I haven't pushed
> it out yet as I want to rebase that tree on rc1 when it comes out.
>
> After that, please take a quick look check I didn't mess up.
>

Thanks. Looks good.
