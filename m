Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B074E9E1
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jul 2023 11:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGKJIn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jul 2023 05:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKJIm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jul 2023 05:08:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF093
        for <linux-iio@vger.kernel.org>; Tue, 11 Jul 2023 02:08:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991ef0b464cso1315724266b.0
        for <linux-iio@vger.kernel.org>; Tue, 11 Jul 2023 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066520; x=1691658520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCT/XxzRuhIOCG7TiLnjd8ZHAjjC0sPyU5Ljlso/Sg8=;
        b=axcTDMKvWOaCpjgFCXQMwYBE2lmCs6RzORIdLuoQRO/2WHMgaHPXhQ5zcpWbNxfdlo
         ql1rLkG8mcH+X5JhbVL2WHENCOaFuX88nUU3WWs1P0iGQ2KyxRlSuFA8c1c6h6N9LF/x
         e/OPlbRfjKZ+vnGkeNOhcT012SV92wg15ZFdrA8h5R1zHgM/nS6fx9k4vgiZ3IpSEwoE
         pcJkPVOdFimX166tbv2VjAQeVzNWw90Cx1YimtQOXlzwTy6+O7gaEotVTNQJW6XEQAc/
         Y/hmWZ1ZZmT/beOS592ksZbvAKLGRZoMrIt2byWFwmd2O/MorxCsufkyX1hHRFg+KmjH
         ywcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066520; x=1691658520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCT/XxzRuhIOCG7TiLnjd8ZHAjjC0sPyU5Ljlso/Sg8=;
        b=gG/y5PMOpM80Jo8rUpPK6GEHkn5iBCJpre0/s3QyLAd0XRvbC5uFrizXICh11B7AyJ
         fdG4F62KaUAyns/n87m16Cadt6RiDoQG5BqnsUaSvkiG54KVvCqsweRyeHsFY5f7D6Mg
         2mG0fFMMMuHjTo6545gvHr2eYjwArEx1DZoWvme8tHJ7lmaO2I20aDrcu55a+2LxhR77
         5Cq/ZSLU6OGY5vUhs3viWRDpdo6tedVKtkpj6qcpCsbwylZGPPmemcyNGxPRc7RbFu1u
         00n5JgDn6COcWX8v894pd45nvD4HwAJuMZTYebEgxb/4JhYh63nC6JA+bX6YrrseigJ5
         q0ZA==
X-Gm-Message-State: ABy/qLYfKv168yIBuVGu6AzI0XmjWIYD6RwrWCbVoKBs0fBXIzPhHv0B
        ziPjHk8K7L1KIr/8uN3NQy5BX27VqmH2D0Mzbuk=
X-Google-Smtp-Source: APBJJlG9oYRzvqfzRnSDLsSqTOvOr3+1Fkikr7LESzJMGOR+MNOI/0JkogPu0ClQfrYZkp3aUQpgbZwhHKcA8t8Nc2c=
X-Received: by 2002:a17:906:c152:b0:974:fb94:8067 with SMTP id
 dp18-20020a170906c15200b00974fb948067mr19527068ejc.23.1689066520235; Tue, 11
 Jul 2023 02:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230710042723.46084-1-kimseer.paller@analog.com>
 <20230710042723.46084-2-kimseer.paller@analog.com> <CAHp75Vd386P9xM_+wLahp6B_XwYVq1AZxaFQeWvZ2pnk-tFGHA@mail.gmail.com>
 <11c30a02df784ca78be271fdf9190dad@analog.com> <CAHp75VegvKFUXoJoJnuXstJa_L66M2Ah9yf1aEQ8-ET1QczDtQ@mail.gmail.com>
 <fe0cd5348f864a6392a7e0e5ca93bec5@analog.com>
In-Reply-To: <fe0cd5348f864a6392a7e0e5ca93bec5@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jul 2023 12:08:04 +0300
Message-ID: <CAHp75VcpguSN9DkuCtpaB+_=sY7+Ot1MGPWToe-2pYjFXC9=4Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] iio: adc: max14001: New driver
To:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 11, 2023 at 9:55=E2=80=AFAM Paller, Kim Seer
<KimSeer.Paller@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > On Mon, Jul 10, 2023 at 11:17=E2=80=AFAM Paller, Kim Seer
> > <KimSeer.Paller@analog.com> wrote:

...

> > Hence instead of v10, reply with a draft of the comment in the code (I
> > have asked before) that explains these bit twiddlers.
>
> In patch v9, regarding with my bit arrangement comments, is it somewhat c=
orrect
> or do I need to totally replace it?
>
> I am not yet familiar with the terminologies, so I hope you can provide s=
ome
> suggestions and I'll definitely send the draft first.

I'm not sure I understand what comments you are referring to.
The v9 does not explain the algorithm clearly.

What you need is to cite or retell what the datasheet explains about
bit ordering along with the proposed algo (in AN as far as I
understood). Because I haven't got, why do you need to use be16 +
bitrev if your data is le16 (and that's my understanding of the
datasheet). Is it because of the answer from the device? I don't
remember if it keep the bit order the same (i.e. D0...D9) as on the
wire.

For the terminology, use what the datasheet and AN provide you. Also
good to put those URLs to the code and datasheet as Datasheet: tag in
the commit message.

--=20
With Best Regards,
Andy Shevchenko
