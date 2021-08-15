Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF8B3EC9D4
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhHOPHT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 11:07:19 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:35316 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229603AbhHOPHT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Aug 2021 11:07:19 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8004C100E7B52;
        Sun, 15 Aug 2021 15:06:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 329591124F5;
        Sun, 15 Aug 2021 15:06:47 +0000 (UTC)
Message-ID: <c08cfa8b6bbf07e1860d7dc93739e71ff5f4c0c4.camel@perches.com>
Subject: Re: [PATCH v4] drivers/iio: Remove all strcpy() uses
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Len Baker <len.baker@gmx.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 15 Aug 2021 08:06:45 -0700
In-Reply-To: <CAHp75VdBuQTzCbz1CJciSA1+UOw0ZmJKAh8u2cbr5eDLSsRJEw@mail.gmail.com>
References: <20210814135509.4500-1-len.baker@gmx.com>
         <CAHp75VdBuQTzCbz1CJciSA1+UOw0ZmJKAh8u2cbr5eDLSsRJEw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: scyjwk97ndjnkxgp9nz9retqreya6djg
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 329591124F5
X-Spam-Status: No, score=1.60
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+4BUvjSH6v/IegChk0z+GhPszkuLSdVFQ=
X-HE-Tag: 1629040007-28485
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2021-08-14 at 22:36 +0300, Andy Shevchenko wrote:
> On Sat, Aug 14, 2021 at 4:55 PM Len Baker <len.baker@gmx.com> wrote:
> > 
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. So, remove all the uses and add
> > devm_kstrdup() or devm_kasprintf() instead.
> > 
> > This patch is an effort to clean up the proliferation of str*()
> > functions in the kernel and a previous step in the path to remove
> > the strcpy function from the kernel entirely [1].
> > 
> > [1] https://github.com/KSPP/linux/issues/88
> 
> Thank you very much for doing this!
> Now I like the result,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
[]
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
[]
> > @@ -261,6 +261,7 @@ int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rate)
> >   */
> >  int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
> >  {
> > +       struct device *dev = regmap_get_device(st->map);
> >         const char *orient;
> >         char *str;
> >         int i;
> > @@ -281,19 +282,24 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
> >                 /* z <- -z */
> >                 for (i = 0; i < 3; ++i) {
> >                         orient = st->orientation.rotation[6 + i];
> > -                       /* use length + 2 for adding minus sign if needed */
> > -                       str = devm_kzalloc(regmap_get_device(st->map),
> > -                                          strlen(orient) + 2, GFP_KERNEL);
> > -                       if (str == NULL)
> > +
> > +                       /*
> > +                        * The value is negated according to one of the following
> > +                        * rules:
> > +                        *
> > +                        * 1) Drop leading minus.
> > +                        * 2) Leave 0 as is.
> > +                        * 3) Add leading minus.
> > +                        */
> > +                       if (orient[0] == '-')
> > +                               str = devm_kstrdup(dev, orient + 1, GFP_KERNEL);
> > +                       else if (orient[0] == '0' && orient[1] == '\0')

bikeshed:

I think this change is less intelligible than the original strcmp.

And separately, perhaps for loop would be more readable as

	for (i = 6; i < 9; i++)

converting the 6 + i uses to just i.

> > +                               str = devm_kstrdup(dev, orient, GFP_KERNEL);
> > +                       else
> > +                               str = devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);
> > +                       if (!str)
> >                                 return -ENOMEM;
> > -                       if (strcmp(orient, "0") == 0) {
> > -                               strcpy(str, orient);
> > -                       } else if (orient[0] == '-') {
> > -                               strcpy(str, &orient[1]);
> > -                       } else {
> > -                               str[0] = '-';
> > -                               strcpy(&str[1], orient);
> > -                       }
> > +
> >                         st->magn_orient.rotation[6 + i] = str;
> >                 }
> >                 break;


