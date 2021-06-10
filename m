Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F093A2CA7
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFJNRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:17:42 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:39472 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhFJNRl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:17:41 -0400
Received: by mail-pg1-f174.google.com with SMTP id z1so347799pgj.6;
        Thu, 10 Jun 2021 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sfHCqQhJ6KIziFqK+bZXXcdZ+JSEffjikrxWZk9GikM=;
        b=hg0yWdwpe3kthTnrHd+RJEGNQ4L7Wm620a9Zz+AJoTBF9Lyog0W8An4TIAeCfCQpUb
         a+r5fdKO2HqYqp2J+ixblglzUAmWEHoa935CyOJElDyVytRR9Xyg6vSu3UiKbRY45UqI
         qjBnbla+obLTHi4ZC4RiVNGmpqErlBeNchQHfqyvOTV4jK7aUvXnbTH9Ju5czg5U7PhI
         dRlvRd4ghezoABpHFhqre93UlIwvXplL8fPcPTCRlTxuRUZ5Tus3zfJoPn0EoYgDMLII
         VNOlPZTkLDtt7Lyi22tM+gs3NL+MQNc1q1J07kMZ0fiTq7e4iepV4aBJw8dr6lq6Hvy9
         SYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sfHCqQhJ6KIziFqK+bZXXcdZ+JSEffjikrxWZk9GikM=;
        b=BOhR4fiX7bsIpB5GgMv3cT6ukGHfYBoAdGaU9I2gQmGeH3mLyF/fLGV7pCp0ovy798
         6GV0ldkov/LudnxZoX2LSHEWgIkwp9gYcol1dGT9dPM0CvICm0Fn03Va4fZTp9tPhxVO
         Q7at2vBUZUcfTFTbMXT5UA6mYZDh0UKLqtSxN4M2Ajb8fc2aSeMcFED2gkIDVOS6AAtx
         T7oWZLTu7C0+BoZo2ZvhOY+FuHo0gmAsU+qc1HEhZxWeDxljf9yen0/xKrMccoqzWqkX
         GqymNws6bWoWn3Z+5s9dBiOOiiWTH/2QJGhN04zLsKXcfllYVODMaAPQJ5+Bv9P66nD5
         DF5Q==
X-Gm-Message-State: AOAM530Cg6QViQmi6nAh7dDHK2DUVE5YB9nVwWgoqk3dRVOxowgrBHPx
        GFQGNdadSIyRm6W1zymZZHeT/zOKu5471PKMXos=
X-Google-Smtp-Source: ABdhPJwc7cJt495Aeu2b5fZbDY6TvMhc7uiN0zBH3UelzH/n2GSTn/InGzha9EMWFMggqjfhiaZuNQybugdT1EkcmA0=
X-Received: by 2002:a63:b507:: with SMTP id y7mr4978991pge.74.1623330877469;
 Thu, 10 Jun 2021 06:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210610124556.34507-1-paul@crapouillou.net> <20210610124556.34507-2-paul@crapouillou.net>
 <CAHp75VfR5jjMjDhFRvtT01EbuSTwDBi3HERDKi306mRK22+Fnw@mail.gmail.com>
 <TPLHUQ.MUVY4TY05YFY2@crapouillou.net> <20210610141057.00007361@Huawei.com>
In-Reply-To: <20210610141057.00007361@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 16:14:21 +0300
Message-ID: <CAHp75VeT+xGprpX9tAf2fNQgcWNHhWYZwXkm5MHb=DjtUB5Qzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: core: Support removing extended name in
 attribute filename
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 4:11 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Thu, 10 Jun 2021 14:05:53 +0100
> Paul Cercueil <paul@crapouillou.net> wrote:
> > Le jeu., juin 10 2021 at 15:58:51 +0300, Andy Shevchenko
> > <andy.shevchenko@gmail.com> a =C3=A9crit :
> > > On Thu, Jun 10, 2021 at 3:47 PM Paul Cercueil <paul@crapouillou.net>
> > > wrote:

...

> > > I'm afraid, NAK. Otherwise, please put an explanation that clearly
> > > shows that it will be no ABI breakage.
> > > I.o.w. users for the existing drivers and devices will always get
> > > those attributes at the same platform configuration(s).
> >
> > Well, the commit message says that I'm adding a mechanism to disable
> > the feature. If it was actually doing anything else (like actually
> > disabling it for any attribute) then I'd mention it in the commit
> > message.
> >
> > I don't see how that possibly can be a ABI breakage.
>
> Ah.  Both Andy and I got taken in by 'removing' in the title.

Yep. I have read the patch first and my impression was that we are
going to disable *existing* attributes, reading the complete series
suggests it's not true. That's why I recommend to massage the commit
message to avoid this confusion.

> What you really mean is identifying the extended name.   That's
> much more acceptable :)


--=20
With Best Regards,
Andy Shevchenko
