Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015FD567BBD
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jul 2022 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiGFCCO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jul 2022 22:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGFCCN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2022 22:02:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7881193D3
        for <linux-iio@vger.kernel.org>; Tue,  5 Jul 2022 19:02:12 -0700 (PDT)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 314A540274
        for <linux-iio@vger.kernel.org>; Wed,  6 Jul 2022 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657072931;
        bh=jnmb0zpL4NW6n76DYnJeaBav9/Yc3ZJVxQW1CIFh74k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=aAAuVX/kiFDl53SaM81pUxOzhIl7Ri7lAp1oo9MlN1LR9ttmDic/nUZr+mP7/LMRu
         KPCvcAG2C+zYUtizGM/uzE8dld0vnlIbb60grK7jI+xlMTLeyAHhml1r0CBmP58bM8
         plTNuVvHnq94tSOJAMGll7697A+OYFb3nVgUws4y0VyBTMxI9w0wk1nJlhJy7XioIY
         7MelqF+iOeDmoVrKdsCPcKoCzKPJ9KqBUf6zX2KIuIz5N+IJGfMjDBdlgl1yWrjeBd
         9f2rMEPuSVZtkWjV3CAyVrRh2E7yItuBYvLMBe+9l5f0w8OA9WcUABUyROHqpRX75H
         f/HoVZ26nI2Iw==
Received: by mail-ot1-f72.google.com with SMTP id c26-20020a9d75da000000b00616e2d467b8so5495703otl.12
        for <linux-iio@vger.kernel.org>; Tue, 05 Jul 2022 19:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnmb0zpL4NW6n76DYnJeaBav9/Yc3ZJVxQW1CIFh74k=;
        b=YZc9D6Nkv+h72WJpsQH4nf1dFmAFhTqJLHL5sHdbd5PQp43zh8NcHYKA3G/cRz+rS1
         vA4w702xFd4VzDn7KM/3bamIa3U1JHrJWV8NGwi1gLgx8i5mOh7jCweASgEfYA8e1zjo
         hV3Qst9svF7LxXeXolBMNSYkxUpAXqXNel4apIVlCVYtZUaIM9HdG2APi8icnQfxOw5s
         nQtRJLP0gztJTcNA4V2P30ChCU0IIcIj2wSUYoxv9L8r+ItVp+4NeBhBOAns8Be9MujL
         C2isH9rZvv2Dn7KG+KDe6LslG/WAc3s2F8hQkMmIg2gL+Unz4+cc6OLPc/iQXM+nIWAU
         0+Rg==
X-Gm-Message-State: AJIora9oG5hWbJ8tOIbrsLX+ZlWNf9kKRkpGj/xBTb/v4mU2JJ1DYoRw
        F6/TQte8nTijcbhy8Na/jJP+sZTyi08VcI+ifSWr3bPbOyBJ6APNIGAzSmMSU6pUNSF2EYUZRcO
        Xn5eQIu7IE6y/qoZfeDgPoZ+gH3A09PR0Hi7O4bL+xW+mpHBp8yfNcg==
X-Received: by 2002:a05:6808:1805:b0:335:8dcd:5d95 with SMTP id bh5-20020a056808180500b003358dcd5d95mr21886991oib.176.1657072929957;
        Tue, 05 Jul 2022 19:02:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssxVPF7ft55Orm/Ztsbmk8TBHMuXJEKIQkFhfgSW+oG1zxq6y0ZMqz8t1s3bTZ3S8pKGr4G3kDd4sonpkspH4=
X-Received: by 2002:a05:6808:1805:b0:335:8dcd:5d95 with SMTP id
 bh5-20020a056808180500b003358dcd5d95mr21886969oib.176.1657072929635; Tue, 05
 Jul 2022 19:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220705121756.41660-1-kai.heng.feng@canonical.com> <CAHp75VdnvxhR7yB2sroH4y8VgU3ORnCC3wH4CEKYCX1XSPvMxg@mail.gmail.com>
In-Reply-To: <CAHp75VdnvxhR7yB2sroH4y8VgU3ORnCC3wH4CEKYCX1XSPvMxg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 6 Jul 2022 10:01:57 +0800
Message-ID: <CAAd53p4ZNna2G7hD4vDfDF-fAtLNJinr+tr9LddMq06yFT26YA@mail.gmail.com>
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

On Wed, Jul 6, 2022 at 3:12 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 5, 2022 at 2:31 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > The read on in_illuminance_input keeps at 0 after system sleep.
> >
> > So add proper suspend and resume callback to make the sensor keep
> > working after system sleep.
>
> ...
>
> > +static int cm32181_resume(struct device *dev)
> > +{
> > +       struct i2c_client *client = to_i2c_client(dev);
> > +       struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
>
> Simply device_get_drvdata(dev) ?

iio_priv() is still needed to get the struct priv.

Kai-Heng

>
> > +       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > +                                        cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
