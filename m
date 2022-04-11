Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838C74FB925
	for <lists+linux-iio@lfdr.de>; Mon, 11 Apr 2022 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbiDKKPW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Apr 2022 06:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDKKPV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Apr 2022 06:15:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD53042A22
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2022 03:13:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so29797069ejc.7
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2022 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dW2Wuja0KH1Gxy5MLTFMA8uN72Yk2POW6UNEaFozYGk=;
        b=kyWQJuaXO7ER7eOjZU1gFaSj/Gv7PO9cJVIk3fLYkzy4MkF2QiNkOE+18IWLRY4YBP
         ax8lFObsHMZjYg2edODNPhnPFwa0JktOeRx3QnYMWeiWXnfLkKWNnr9lQNFNuGpPTBoD
         CcbznmLvBGjXy4v3013j/YmlWrQAU9M2aaUM0P+a9xrJcfYqR8QJXYtZSVvbke01Ekid
         QdY4nuRGgQ0e35n/nI7QLjnyshVmF5HLzfMY223+5lohJKzKhnNYXpM+znwImhEUky86
         14RcZEdK/Wectfvz+fbt0w1jQSaQs5PLhhMSJYVomIOMbL/OUJHx2KiiXBdwOXPlj+FX
         8DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dW2Wuja0KH1Gxy5MLTFMA8uN72Yk2POW6UNEaFozYGk=;
        b=3Pb3jw3iECYy8a4BdxD87AryiXcK0plHThGmCf82HSn50NGg0ythoQNzHpsh5zQYi6
         61kOpWRhCFmxW/hDUAjZeKRaiXd3ZPoGNKYojEb+mGsQS/t2uUkM0Ds7dpDuxitkRyhh
         6Oxys36o5/AIaMzR96mYlqrcrx4tDHLk158ZLzah+If0jH8XBF0qRytkXFg5ibAPeiDs
         bbO0vcy2N2MfMuf2+U+0zwX1v5vJfgiAkNOuCh/hwKg+3E557LfPDS5lO+3/rTKz479v
         8f+wE33zRvn7gJqcDAAQ45CxhJf3QHyvAIOgjdN/8ik6zljBbSrH1r0ssmLAbN7SpoDd
         wqrw==
X-Gm-Message-State: AOAM533hPJLQGnYKaSHOxCLucuz916LStut1c10GOWuIGLX3OpY46Uoj
        oEkK1HUG9PRiCj6Fr5/XdtgXcxJGXeqWKgpTh0Q=
X-Google-Smtp-Source: ABdhPJwObrWOsbKLlQDJh0cFtq2LPHkl0+09d+SbVm7WegCzMhR7sJutG70B/mIOI39DTYd9QeApvAdEJHtvEfEhxm4=
X-Received: by 2002:a17:907:a411:b0:6e1:2084:99d2 with SMTP id
 sg17-20020a170907a41100b006e1208499d2mr12190658ejc.639.1649671986153; Mon, 11
 Apr 2022 03:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
 <20220410182819.23967855@jic23-huawei>
In-Reply-To: <20220410182819.23967855@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Apr 2022 13:08:53 +0300
Message-ID: <CAHp75Veiq8f7Zk4LpG6Urwiu9DgTgT8GEhzm+MJAGy8qNt8B1w@mail.gmail.com>
Subject: Re: GSoC Proposal 2022
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 11, 2022 at 4:05 AM Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 7 Apr 2022 00:23:29 -0300
> Ma=C3=ADra Canal <maira.canal@usp.br> wrote:
>
> > Hi everyone, I am Ma=C3=ADra Canal an undergrad student at the Universi=
ty
> > of S=C3=A3o Paulo, Brazil, pursuing
> > computer engineering. I wish to participate in the GSoC 2021 as a part
> > of the Linux Foundation, IIO Project.

> > I have been contributing to the Linux kernel for a couple of months
> > and have more than 20
> > accepted patches in a couple of subsystems.
> >
> > I started looking through the catalog of Analog Devices Inc. and I'm
> > pretty interested in writing a driver for gyroscopes, inertial
> > measurement units (IMUs), magnetometers, pressure sensors, proximity
> > sensors, or temperature sensors. But, while looking through the
> > catalog, I could not figure out a sensor that would be relevant to
> > Linux Kernel. I mean, I would like to work on a sensor that would be
> > relevant to the community and to Analog Devices Inc.
> >
> > In that sense, I would like to know if anyone in the IIO community
> > could recommend a sensor that would make sense for the company and the
> > IIO community. Any suggestion is appreciated!
>
> I'm not going to recommend a particular sensor, but more offer some gener=
al
> tips on what 'sort' of device makes a good target for a GSOC.

My recommendation to GSoC participants stays the same, i.e. browse
stackoverflow for the questions regarding the sensors that are only
implemented in user space so far (by Python/Java/etc libraries) and
write a driver for one of them.

--=20
With Best Regards,
Andy Shevchenko
