Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0CA4E3012
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 19:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352222AbiCUSiB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352228AbiCUSiA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 14:38:00 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352767CDD8
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 11:36:35 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so20212206oof.12
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=yXYEBuW6VaDVgClKY3HKdDJSY8KyrlZEOVA56VtcWa4=;
        b=AMClZKU3SKzDzuaJpTabi6xrGsDRYAM73Jppk48lHzd5Ma/lHr8lXJh6zbwtJujY1g
         GEvaGdwRC5L+KCqVFgYYzHdGxuSuCTJs4B9LawELpTXpNAytnHhivXUlbApZ/KBvnmqP
         eDlEeAC9gzGFA7ALWMLyd7iG/Fe+t/5EV/AeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=yXYEBuW6VaDVgClKY3HKdDJSY8KyrlZEOVA56VtcWa4=;
        b=XMy+YnJcLhVQqe9g2nVgaAc42XKmIzZzl0gyq4pcpEkZZHTo9POnPdKvXeGgJauXET
         Nygwmz8KZqTewz8l4wlXEgnc+2j9S3DEOiO9pxjBEr8Ypm4/YNngtqHDltwCjJ3O584C
         +Qcv2UbmVxUt/ppPOQL9B7EeRAmkRF1O+xuQWNJ5JdLkoXdfAw6/2w3TUZg6VEm7Ogbi
         EwTTiwlFeD6d7ZL3fifLASW+kPQldV5FvYXwPBDvXcmqYzTeZPa7ri/FYo8OQJnXpHLX
         0wPCoZEmi4WfLFWBMIaTn52hZjz7MRG6oWPK3xxtpeL9ttqlZs+wJJoboUv00frDZhhD
         F5mw==
X-Gm-Message-State: AOAM5307KssaPk7Avs9aiW59jxWR73Dsy6+BvqjW4u/NVGMyXbxOAMvN
        Trhyn/im9pm4MxHVlB/Ms3SnGevcX4tqm9t5cYpn9MnI21E=
X-Google-Smtp-Source: ABdhPJzUFRaISHJP1MIIbyFz2LgziTazZlouqsO6VXm4BnAJFnDis079ZvsCevPAQzA5liEcTbirPV3VGTbE530ZTg8=
X-Received: by 2002:a05:6870:c0cb:b0:da:2bcc:aa09 with SMTP id
 e11-20020a056870c0cb00b000da2bccaa09mr194320oad.63.1647887794519; Mon, 21 Mar
 2022 11:36:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Mar 2022 19:36:33 +0100
MIME-Version: 1.0
In-Reply-To: <20220319152641.49d8b3e1@jic23-huawei>
References: <20220318204808.3404542-1-swboyd@chromium.org> <20220319152641.49d8b3e1@jic23-huawei>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 21 Mar 2022 19:36:33 +0100
Message-ID: <CAE-0n52jDZz0qKhfg8OWVDmDg5+xXo-qSL3jNka82QHwA2-xsw@mail.gmail.com>
Subject: Re: [PATCH] iio:proximity:sx9324: Fix hardware gain read/write
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2022-03-19 08:26:41)
> On Fri, 18 Mar 2022 13:48:08 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> Hi Stephen,
>
>
> > There are four possible gain values according to sx9324_gain_vals[]: 1,
> > 2, 4, and 8. When writing and reading the register the values are off by
> > one.
> > The bits should be set according to this equation:
> >
> >       ilog2(<gain>) + 1
> >
> > so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> > in the register field, etc. Fix up the functions.
>
> So is the 0 value reserved?  I can't find an sx9324 datasheet but he
> 9320 is online and that seems to be the case there.  If so please state
> that in this description as well.

Yes 0 is reserved. The top of this driver's C file has the datasheet
link[1]

>
> >
> > Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/iio/proximity/sx9324.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > index 0d9bbbb50cb4..a3c8e02f5a56 100644
> > --- a/drivers/iio/proximity/sx9324.c
> > +++ b/drivers/iio/proximity/sx9324.c
> > @@ -379,7 +379,10 @@ static int sx9324_read_gain(struct sx_common_data *data,
> >       if (ret)
> >               return ret;
> >
> > -     *val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> > +     regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> > +     if (regval)
>
> If 0 is reserved then I'd return and error code here to indicate
> we don't know what the gain is rather than carrying on regardless.
> Or is this going to cause problems as it will be an ABI change (error
> return possible when it wasn't really before)?
>

That sounds OK to me. The driver is only being introduced now so we can
still fix it to reject a gain of 0. Unless 0 should mean "off", i.e.
hardware gain of 1?

[1] https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
