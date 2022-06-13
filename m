Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806A549BEB
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344610AbiFMSmR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245721AbiFMSlx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 14:41:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DFAE276C;
        Mon, 13 Jun 2022 08:23:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v19so7659605edd.4;
        Mon, 13 Jun 2022 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aW2/sB6xvxbzYy1ThczPgmabrwZiZM6tErpwVrnth5s=;
        b=YBcthnONIYfNq/xPuZwrIxSKuSg3qjLNuXXAJYAD4gj2Znsg3/71FrSiM4GEYlR6Gt
         hF1puBGJdQtMg2WWn2amed/RzOSW0kIwbp2MAug8QZbt5MARiy3yRI9ZbifXONHwl4V1
         rFH3CEUn72vVjvq3w9KnK+LeJw1+qqtY0OwDh8xdoyThtJ5l24vIIjBfYfJBASy4LZBC
         7jGpxohKDjIPacs3rq7LSemfaacW+Vm+54RUQ/YRqi7+xtDh4f/7n0U66DioYg4hoNul
         hogKuYnXtaZ6JGKEXsAKEdnS5cskci4yxegmNrIvDNfKVVJyR/pIiC5NpFmOzoDXVg3j
         Bg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aW2/sB6xvxbzYy1ThczPgmabrwZiZM6tErpwVrnth5s=;
        b=wohCfJSDvkrymzxjoK5GilpFVf3n+VIVKUGQrEU4Ft9JDza4L+zDnJJ2hSaXpY6YTm
         bZgxlqdxjTczxlEFbwOncawcfP5Kqe7gxI9MKmAO1CGxtQQMF2alZKIpbmOha0SFArnv
         q9sScagplswRvWbp6S4vqhqUgcypf3I4w4te6Efip8NJqKUuTGK6mZM2ErV14eJKrYRa
         WQhnrdL3rV79ZUyFWmlmwVtazTT9mV7fdqua0xdhHCbeKmwzdkJlX1VdOVd1/F6HmiWP
         0tBUb0rYpUbkiMRn1ZGxfWtYXKu9Lcjbhc66cq7ETKuXzSGl1ds5+8nyMmxMlS4y58vn
         k+5A==
X-Gm-Message-State: AJIora9wojVDPlMcwVLR4ohI1Y4N/fA4CWvQcfGRkFpSQGJip3HYKyvx
        cVWqShCafcaDzsXi1iEHfFkny5ITbp4MItQFyCQ=
X-Google-Smtp-Source: ABdhPJz/m+G2NigP+Ox3pDgna3NGdSqfI+cunjueL7zOj2ivH81ydqPDTW5ihcsMdbxjNagn3ejRpsMGAXuyNTtaSRo=
X-Received: by 2002:aa7:c396:0:b0:42d:8b86:a8dc with SMTP id
 k22-20020aa7c396000000b0042d8b86a8dcmr310424edq.54.1655133810087; Mon, 13 Jun
 2022 08:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655081082.git.jahau@rocketmail.com> <b6e100de37921c22ebf0698f8e0e99794053303a.1655081082.git.jahau@rocketmail.com>
 <CAHp75VfFwSQ6bk=TMLiyA1j-AsafjGdVFbTTHJJ67C8zeYfz8Q@mail.gmail.com>
In-Reply-To: <CAHp75VfFwSQ6bk=TMLiyA1j-AsafjGdVFbTTHJJ67C8zeYfz8Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jun 2022 17:22:53 +0200
Message-ID: <CAHp75Ve3ydACAQnHR0rgPHEU9kSLYj-t6dU96gxDLPWKfnmP0g@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iio: magnetometer: yas530: Add YAS537 variant
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
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

On Mon, Jun 13, 2022 at 5:20 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jun 13, 2022 at 3:18 AM Jakob Hauser <jahau@rocketmail.com> wrote=
:

Forgot to add that please try to split even more preparatory patches.
For example, you may convert existing code to stubs / switch-cases /
etc and in the last patch just add the new case or new function /
branch.

...

> > +       /*
> > +        * Raw temperature value t is number of counts. A product descr=
iption

the number

> > +        * of YAS537 mentions a temperature resulution of 0.05 =C2=B0C/=
count.
>
> resolution
>
> > +        * A readout of the t value at ca. 20 =C2=B0C returns approx. 8=
120 counts.
> > +        *
> > +        * 8120 counts x 0.05 =C2=B0C/count corresponds to a range of 4=
06 =C2=B0C.
> > +        * 0 counts would be at theoretical -386 =C2=B0C.
> > +        *
> > +        * The formula used for YAS530/532 needs to be adapted to this
> > +        * theoretical starting temperature, again calculating with 1/1=
0:s
> > +        * of degrees Celsius and finally multiplying by 100 to get mil=
li
> > +        * degrees Celsius.
> > +        */

--=20
With Best Regards,
Andy Shevchenko
