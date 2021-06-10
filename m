Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4883A2C88
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFJNMT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:12:19 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:41510 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFJNMT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:12:19 -0400
Received: by mail-pf1-f181.google.com with SMTP id x73so1574965pfc.8
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KS2L/Lra9Fei908H1seSGQJ2Tw264siU30oDuyqsQfM=;
        b=gzmFKK5g4Y2BOGi59GBgeXmsYPedL6c7JzSJR/QDnMxovT1wDP4hD7ihLuLIPceFUE
         KwlHJheEivKiKF5zx2+6B5wM8EYfvMgPZBSDesl5MwsAFNmPARc3hSwkNPzqIWteJh39
         Dd9D0ModFHQDApmvlni07/4HdeHD8/xQgM/D62NgagX7r2bQwmgJw/m7Tw16IjMRKAA9
         8TvS+CsOkDdFqm0AH7rIMKT5a3WI8Y1bWT9aI9wtpiRiNDlUyaZPu0qoW5YP19+Xi4Gm
         8IJFumJEHWTQMfn4ilMvKjcz2Mdr9JAr20sk1Vr+pYL7UPDe9/4By3twdnFwOZVOsOLw
         UAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KS2L/Lra9Fei908H1seSGQJ2Tw264siU30oDuyqsQfM=;
        b=hq+wmqhZa7jGmOnXdNlK/coL6N03NkQA2o5dVSAvZsLU01VAshIc1cvPsBMaiHVQHL
         10NaFrM4JKjQYItBVBLHdj/xOHG+zRaZpCTuGnXwgm41sRu1P7GOREaI5UeQ4kj5w4Tk
         inlqC7OrIiKrpB5+r0mMk+ot/nMFFat+YvxZ8U2aIezYdnO1p9+AmGZ48olBO2HGUBP9
         YhSXHfb4jxIS4zUoJX06Sbv0m1hIBfstJcOv5qil7Z6T5p44hxc9SMo7o6eBnTjeWS4c
         ctskwBalzDVASxS1IVRaU6SFreGEtmCUVlGkKxWxwBOml15Ew8ulA4TSPYQvBWI/aa3N
         8+QA==
X-Gm-Message-State: AOAM530eDqe9yy1wCRex09Co1yuj0ySGn5WVJ81mWPXhR2TuC1v//9rI
        dcOGU7uTO4ml4G2L34JZSywuq+JnDMKLzGZiNeo=
X-Google-Smtp-Source: ABdhPJwp5KXnX1yU/9Sydz2TwzuxTfMofBDu1Ps/+PoN99YN7jiMon98fwWi9jrBHlXJXh+kZogbv8m5IPXPVP0zrd8=
X-Received: by 2002:a63:b507:: with SMTP id y7mr4954261pge.74.1623330561545;
 Thu, 10 Jun 2021 06:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210610125358.2096497-1-mkl@pengutronix.de>
In-Reply-To: <20210610125358.2096497-1-mkl@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 16:09:04 +0300
Message-ID: <CAHp75VfwQRirSrPzuipk6J8bKK6L5TL2xC6aae-6ttOvwDmdDA@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: ltr501: fix regmap, initialization of ltr559,
 endianness and mark structs as const
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 3:55 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Hello,
>
> here are 3 bug-files (probably stable material) and 1 enhancement for
> the ltr501 driver.
>
> regards,
> Marc

By some reason this is marked as patch 1/4 (should be the cover letter
as patch 0/4).
Hint: --cover-letter parameter will do a template for you (`git
format-patch --cover-letter --thread ...`).

-- 
With Best Regards,
Andy Shevchenko
