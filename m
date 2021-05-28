Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14551394825
	for <lists+linux-iio@lfdr.de>; Fri, 28 May 2021 23:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhE1VLo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 May 2021 17:11:44 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:47408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229481AbhE1VLn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 May 2021 17:11:43 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id BA90A181D337B;
        Fri, 28 May 2021 21:10:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 74EA217275;
        Fri, 28 May 2021 21:10:05 +0000 (UTC)
Message-ID: <fc3afc8e74ee9eda0b4eaff9a4d9ad32f1c461c4.camel@perches.com>
Subject: Re: [PATCH] iio: si1133: fix format string warnings
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Maxime =?ISO-8859-1?Q?Roussin-B=E9langer?= 
        <maxime.roussinbelanger@gmail.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Date:   Fri, 28 May 2021 14:10:04 -0700
In-Reply-To: <CAHp75Vc72vMbj311P3xnxh6ExxzD1=enoETj6wY8dHn+xBJ4+w@mail.gmail.com>
References: <20210514135927.2926482-1-arnd@kernel.org>
         <7afc367b-8103-9d48-1bfe-d505d86553b9@kernel.org>
         <20210516103628.2cf899a0@jic23-huawei>
         <644a711e4d2639a23bfc50dffa180ad184a4acb1.camel@perches.com>
         <CAHp75Vc72vMbj311P3xnxh6ExxzD1=enoETj6wY8dHn+xBJ4+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.40
X-Stat-Signature: 5acgrz7aqqahef7j4xfkx1oihty81c8i
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 74EA217275
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19u0+cg/CvkDoccaPXMZBb1xXuLYIiXf/A=
X-HE-Tag: 1622236205-755196
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2021-05-28 at 23:59 +0300, Andy Shevchenko wrote:
> On Thursday, May 27, 2021, Joe Perches <joe@perches.com> wrote:
> > On Sun, 2021-05-16 at 10:36 +0100, Jonathan Cameron wrote:
> > > On Fri, 14 May 2021 10:45:02 -0700
> > > Nathan Chancellor <nathan@kernel.org> wrote:
> > > > On 5/14/2021 6:59 AM, Arnd Bergmann wrote:
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > > 
> > > > > clang complains about multiple instances of printing an integer
> > > > > using the %hhx format string:
> > > > > 
> > > > > drivers/iio/light/si1133.c:982:4: error: format specifies type
> > 'unsigned char' but the argument has type 'unsigned int' [-Werror,-Wformat]
> > > > >                   part_id, rev_id, mfr_id);
> > > > >                   ^~~~~~~
> > > > > 
> > > > > Print them as a normal integer instead, leaving the "#02"
> > > > > length modifier.
> > []
> > > > > diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> > []
> > > > > @@ -978,11 +978,11 @@ static int si1133_validate_ids(struct iio_dev
> > *iio_dev)
> > > > >                   return err;
> > > > > 
> > > > > 
> > > > >           dev_info(&iio_dev->dev,
> > > > > -          "Device ID part %#02hhx rev %#02hhx mfr %#02hhx\n",
> > > > > +          "Device ID part %#02x rev %#02x mfr %#02x\n",
> > > > >                    part_id, rev_id, mfr_id);
> > > > >           if (part_id != SI1133_PART_ID) {
> > > > >                   dev_err(&iio_dev->dev,
> > > > > -                 "Part ID mismatch got %#02hhx, expected %#02x\n",
> > > > > +                 "Part ID mismatch got %#02x, expected %#02x\n",
> > 
> > which is almost certainly wrong.
> > the length specification includes the # which is already 2 bytes.
> > 
> > Likely these should be 0x%02x
> 
> What’s the difference (except printing 0)?

(assuming the argument is unsigned char/u8)

%#02x will always emit more than the specified length (3 or 4 chars)
values < 16 are 0x<hexdigit>, values >= 16 are 0x<hexdigit><hexdigit>

0x%02x will always emit 4 chars

It's very likely the writer didn't know the difference and assumed
that the # did not count in the specified width.


