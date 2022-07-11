Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937605696A0
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jul 2022 01:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiGFXyd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jul 2022 19:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGFXyc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jul 2022 19:54:32 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54352D1C8
        for <linux-iio@vger.kernel.org>; Wed,  6 Jul 2022 16:54:30 -0700 (PDT)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A2D4F3F6F8
        for <linux-iio@vger.kernel.org>; Wed,  6 Jul 2022 23:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657151668;
        bh=YQXgPRoGuymP1adtfMF9k6DYRLeji+HUOZ31gzrwGtk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ph3jAau4xITx2WTN6shMapd5RWopmq/EWLHy9D0ygTmpMgnSUUNUULrBDtrfOw73I
         L0OL4vJhfsJqkgkXqqtx0SYvf4MsZMEvCyxJrWTb3gbjLwwm3EFrMlZedOIrrANItu
         RJO8UGK7qpE6Gb/rpOsrla9h7dNWS2W86ReJKzWY8ibFG04ivcxyYkxaqStM0BDnm8
         rx5aeRnVemrBzXv5WPdfycdwfZlgsfzwfYK29KDgsbC7JuhGDfzmqzHIKSR1siZZi/
         UbU0xnOO8bjGReReS0izuWY7sw46sLCzB430YbUVH86LFhr4yjLIdvfouI5q+XBiTO
         8EVPF3lTWc/uw==
Received: by mail-ot1-f69.google.com with SMTP id by5-20020a056830608500b00616c152aefbso6660834otb.6
        for <linux-iio@vger.kernel.org>; Wed, 06 Jul 2022 16:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQXgPRoGuymP1adtfMF9k6DYRLeji+HUOZ31gzrwGtk=;
        b=DmOwLR6HAW9v9YkOUXW6gzG3+5DCo9iJwwCkPODdhw/hrwZlXrbzS8IKLdRtqOLj/k
         7tkM2DfS435Tpzh5VkkupzNWorXjzKyS69D2Kbtic2/8vqPmZ7z/SjKQVq4qjnvi24OG
         m61j6Y8oLu+fwLxIvszdpShUsRid227rFJ6h7QJ0INdK/lmijIdExU5QjoVSDTdBWbKd
         e4q/d0tUtrhgNbO3Mj5qHp9EhUnGQcQaf06uhmnXkx8yLkGAdMBF/xq38GMFE+DFap6G
         aEqy6LMio47ojS4AdxTwYEU/tHOGH/747ZajbdbGCwAIlFcI0xb8zE7aPznbDF7i/cPj
         jQLw==
X-Gm-Message-State: AJIora8UveNhvfYmo5uLNBMnWOQnOLwv9S+Pn3N//u5VWWSHQHgdDeDx
        yEeKdKo3wsfYZsDAgxVp4jTS6LZz2sNlPNFQkuu9yaahtfpghbJ6Zd1LnIuz/JyLUOJ2kTLlF0l
        35IXijvJh9KVaTjcmt9gCqGkYp8tIBwqVxIh0P9mLYvGcHUkAExHB2w==
X-Received: by 2002:a05:6870:51ce:b0:101:c7e3:d7a5 with SMTP id b14-20020a05687051ce00b00101c7e3d7a5mr853730oaj.176.1657151667396;
        Wed, 06 Jul 2022 16:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1snlnA/TN5qrGAt1G630oT74yn4ltchkQOMr4vIAzATwdV4DkAG52riAhJFg7URlZzC00Y+2jQ+XtFAZ3CaiDo=
X-Received: by 2002:a05:6870:51ce:b0:101:c7e3:d7a5 with SMTP id
 b14-20020a05687051ce00b00101c7e3d7a5mr853721oaj.176.1657151667152; Wed, 06
 Jul 2022 16:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220705121756.41660-1-kai.heng.feng@canonical.com>
 <CAHp75VdnvxhR7yB2sroH4y8VgU3ORnCC3wH4CEKYCX1XSPvMxg@mail.gmail.com>
 <CAAd53p4ZNna2G7hD4vDfDF-fAtLNJinr+tr9LddMq06yFT26YA@mail.gmail.com> <CAHp75VegnLShEPHg=aRG=M3kf36M3tHPL7Jwz-i=A3Z48-2pYA@mail.gmail.com>
In-Reply-To: <CAHp75VegnLShEPHg=aRG=M3kf36M3tHPL7Jwz-i=A3Z48-2pYA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 7 Jul 2022 07:54:15 +0800
Message-ID: <CAAd53p5fb8-2SbOGwgkvPMnEtYc7wh4hksokLJNz6uesArqchw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: cm32181: Add PM support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 6, 2022 at 8:36 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jul 6, 2022 at 4:02 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> > On Wed, Jul 6, 2022 at 3:12 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Jul 5, 2022 at 2:31 PM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
>
> ...
>
> > > > +static int cm32181_resume(struct device *dev)
> > > > +{
> > > > +       struct i2c_client *client = to_i2c_client(dev);
> > > > +       struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
> > >
> > > Simply device_get_drvdata(dev) ?
> >
> > iio_priv() is still needed to get the struct priv.
>
> I'm not objecting to that. My point is that you don't need to
> dereference dev --> client --> dev.
>
> And yes, I see that client is still used, but it's again not about my point.

You are right, let me send v2.

Kai-Heng

>
> > > > +       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > > > +                                        cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> > > > +}
>
> --
> With Best Regards,
> Andy Shevchenko
