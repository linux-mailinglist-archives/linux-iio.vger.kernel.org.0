Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C1F4E48B7
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 22:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiCVV65 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 17:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbiCVV65 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 17:58:57 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F216EB1E
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 14:57:27 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-d4164acd34so3095557fac.4
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=SfPaV706mzf7LD/k9iodk6fw8mNgdKmY8MpWGwKVFSU=;
        b=E31pR5kDUasDNZDFz0ARpHY1hIP1zTgG9pdO5YBzRYKZPLFCkCnfNdlv8a9kzoiwst
         F00TE6wTwa6UIUZNnv4X8LBPH6v5vvyH9Myf8+76ViqGfDU4xvh+w+0u6wA++f8rrgGc
         JwQwfAzobZw1AFiIkDiOwZ6Ldew0fVkKDURZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=SfPaV706mzf7LD/k9iodk6fw8mNgdKmY8MpWGwKVFSU=;
        b=yo5kRp/gBTb4R85+4W2akKCkAcqhrDv5Pv7nE9+Hb/TP98JRrN6N0UNx+0/nDmoKBe
         ZE7pLWaIwGq2CrZ1UCTAdnSBaN4yYUQnbzhHaDA9NeFyuMhkusXZ1k+xRnVMHP51co/f
         wGRQh2OgLT8HnbH97Q2qB+THHArWt1nNIEP1cK+YB5VosoLsWuW1eAjMFxm3ZZs1mWVI
         6edMN5T7QPGiwTiLBB5tnw6NLg3s1LSSNIQEccBSs/XWSnEP7tIgM/I6li1/PGlsTa8G
         d1z7ycVMfT4ou6VmLPENvDJft6B9eaZwi/8oj+BXKnTkEt2wJKfxm/OSk36ODPZ1Qa9/
         mY/Q==
X-Gm-Message-State: AOAM530/API/n3YGQvVkhi2l/VPEsC2wGLWqC5QgJWePg+8JKkAw+82g
        juYPi08AI9gIrwg9iX6dwmUcvamNQfqZALFnrIXK1w==
X-Google-Smtp-Source: ABdhPJwbSHhRs5Y++NGO3oszBoNTYAA6ag8jdOu5XrhXLUceI5d29DIZavih9eOM8SFOiz31smVOQp9zIBpax8wMtMg=
X-Received: by 2002:a05:6870:b69c:b0:dd:b74b:4099 with SMTP id
 cy28-20020a056870b69c00b000ddb74b4099mr2510322oab.193.1647986247339; Tue, 22
 Mar 2022 14:57:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Mar 2022 17:57:26 -0400
MIME-Version: 1.0
In-Reply-To: <20220322203844.0000466f@Huawei.com>
References: <20220318204808.3404542-1-swboyd@chromium.org> <20220319152641.49d8b3e1@jic23-huawei>
 <CAE-0n52jDZz0qKhfg8OWVDmDg5+xXo-qSL3jNka82QHwA2-xsw@mail.gmail.com> <20220322203844.0000466f@Huawei.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Mar 2022 17:57:26 -0400
Message-ID: <CAE-0n51=ewQnTctWsmvawb_p3CrE0JgJFwLy+FR6rUPkWmTgHw@mail.gmail.com>
Subject: Re: [PATCH] iio:proximity:sx9324: Fix hardware gain read/write
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2022-03-22 13:38:44)
> On Mon, 21 Mar 2022 19:36:33 +0100
> Stephen Boyd <swboyd@chromium.org> wrote:
> > Quoting Jonathan Cameron (2022-03-19 08:26:41)
> > > On Fri, 18 Mar 2022 13:48:08 -0700
> > > Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > > > index 0d9bbbb50cb4..a3c8e02f5a56 100644
> > > > --- a/drivers/iio/proximity/sx9324.c
> > > > +++ b/drivers/iio/proximity/sx9324.c
> > > > @@ -379,7 +379,10 @@ static int sx9324_read_gain(struct sx_common_data *data,
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > -     *val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> > > > +     regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> > > > +     if (regval)
> > >
> > > If 0 is reserved then I'd return and error code here to indicate
> > > we don't know what the gain is rather than carrying on regardless.
> > > Or is this going to cause problems as it will be an ABI change (error
> > > return possible when it wasn't really before)?
> > >
> >
> > That sounds OK to me. The driver is only being introduced now so we can
> > still fix it to reject a gain of 0. Unless 0 should mean "off", i.e.
> > hardware gain of 1?
> No.  I don't think we want to add that sort of fiddly definition.
> So error is the way to go - I'd forgotten we only just introduced this
> so no ABI breakage risk.
>

Ok got it. Does the write_gain function also need to reject values
greater than 8 and less than or equal to 0?
