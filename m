Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F42A58C5C4
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiHHJlF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242587AbiHHJkf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:40:35 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10711112
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 02:40:33 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d16so6042571qtw.8
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=W+Asxw2695JJnIw/8vRanEpWpwip3DS5R73N/sZqMwc=;
        b=YKQZ/bclDMh7JXulPjGNi+d+jYgSY9gjxOG/5VWYdQR1hmgDLBJWflC+OFu5jVlFCP
         mmpryySl3Oe8apWKgv/C+arXakPah9VLafTJsc9+5Lho5i4gd+F+eGy83e+YslIOgz16
         y+8WdmuRzu66Xkjl52b7PxFlgwhdCbW2z6zulM1Zqdkm9hKbiAqD085eeNq7+RQJvKJA
         krQgyzUKhmYwTekzrnJRd9n5o+oP/bxztmRRqLrmeIZmHVgFUAYwxgf0wMNK1y/ZLAWM
         9wD0WrQfkSX1fk9k7UJd9zhU0c9DTW8bZG+uybYf6a9NavP5PeYHFMCbAg2/u+re1daS
         6MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=W+Asxw2695JJnIw/8vRanEpWpwip3DS5R73N/sZqMwc=;
        b=0F8W8Rn6V84wGoQBLDc+fDBVlGKXGMlTtG4Zs+uvuXHqu6Qs62lGTSm3RDwbLjpzQg
         B67DS55bjjBbr3Rm3ZpiX0oG+ziudh73y0EXymL4ks6DVreavJaq9YpAa+QQirw9co3E
         V6t8OFYVqKmIYz7aApDVsEp/FQyA6vQnw9LChUfQVxSwMdfZlf8pzHXqAHvnGuROWOIF
         Hw79NyDgOdraxR08BJB2VZwp2kHtkcs/WfIvXLPFdFkMOL7yZypZcSXs2/YWlk7tL5vg
         s7mlUeOpwrXaagaNtTuJEPVHQy01GcVKodf/lAmWLZyITBA3zbjqt76CYxWk0M6CdxfP
         pcsg==
X-Gm-Message-State: ACgBeo2XOl9oRQuHwGxjQGYK2dHeJqPAQL/vF3RaV+nvUQ1VrbhV5RdI
        rXG7HWSqMwgf6iYfYlUV2Edv/wYlWy64QSVmLDY=
X-Google-Smtp-Source: AA6agR7tjqQfVIemrArkYFwRlN66eeUGGiujybi02lA9PmjqohrMhjRplDqI1GpL3B+LicCH7Bq3ZjALGlpuuRGQBCA=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr15275804qta.429.1659951632877; Mon, 08
 Aug 2022 02:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220807185618.1038812-1-jic23@kernel.org> <20220807185618.1038812-5-jic23@kernel.org>
 <CAHp75Vf5PX3UsyofUWbaw7ndntp0fSrLhRP2fcQGnjA_wOTZ+w@mail.gmail.com> <6MIAGR.E5WEOO3MXOKZ2@crapouillou.net>
In-Reply-To: <6MIAGR.E5WEOO3MXOKZ2@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:39:56 +0200
Message-ID: <CAHp75VeEtkSUioMLafQuS+kiyEU71SEjcMj8ZLUEv_AJk2mx+g@mail.gmail.com>
Subject: Re: [PATCH 4/6] iio: proximity: srf04: Use pm_ptr() to remove unused
 struct dev_pm_ops
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Mon, Aug 8, 2022 at 11:35 AM Paul Cercueil <paul@crapouillou.net> wrote:
> Le lun., ao=C3=BBt 8 2022 at 11:28:12 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Sun, Aug 7, 2022 at 8:46 PM Jonathan Cameron <jic23@kernel.org>
> > wrote:

...

> >>  In this case we can't simply use DEFINE_RUNTIME_DEV_PM_OPS() because
> >>  that would provide suspend and resume functions without the
> >>  checks the driver is doing before calling runtime_pm functions
> >>  (whether the necessary GPIO is provided).  It may be possible to
> >>  clean that up in future by moving the checks into the callbacks.
> >
> > ...
> >
> >>   static const struct dev_pm_ops srf04_pm_ops =3D {
> >>  -       SET_RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
> >>  -                               srf04_pm_runtime_resume, NULL)
> >>  +       RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
> >>  +                      srf04_pm_runtime_resume, NULL)
> >>   };
> >
> > static DEFINE_RUNTIME_DEV_PM_OPS(...);
> >
> > ?
>
> Read the commit message?

Yes, and I'm not sure how that part is relevant. The callbacks won't
be called if pm_ptr() equals no-op, no?

--=20
With Best Regards,
Andy Shevchenko
