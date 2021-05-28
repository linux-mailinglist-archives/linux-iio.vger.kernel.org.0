Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB6D39485F
	for <lists+linux-iio@lfdr.de>; Fri, 28 May 2021 23:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhE1Vgl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 May 2021 17:36:41 -0400
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:51234 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229565AbhE1Vgk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 May 2021 17:36:40 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8B11E181D3025;
        Fri, 28 May 2021 21:35:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 5A2292550F6;
        Fri, 28 May 2021 21:35:02 +0000 (UTC)
Message-ID: <cfdbe504c7ed3964bef22c551f0c78c048ce3d2d.camel@perches.com>
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
Date:   Fri, 28 May 2021 14:35:01 -0700
In-Reply-To: <CAHp75VeQdFoJrPhXU2fYdrhLUwvM4NEoPn=Z4WBPkhOa4xK+ig@mail.gmail.com>
References: <20210514135927.2926482-1-arnd@kernel.org>
         <7afc367b-8103-9d48-1bfe-d505d86553b9@kernel.org>
         <20210516103628.2cf899a0@jic23-huawei>
         <644a711e4d2639a23bfc50dffa180ad184a4acb1.camel@perches.com>
         <CAHp75Vc72vMbj311P3xnxh6ExxzD1=enoETj6wY8dHn+xBJ4+w@mail.gmail.com>
         <fc3afc8e74ee9eda0b4eaff9a4d9ad32f1c461c4.camel@perches.com>
         <CAHp75VeQdFoJrPhXU2fYdrhLUwvM4NEoPn=Z4WBPkhOa4xK+ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.60
X-Stat-Signature: kkmhc1bttsasinfggbmtofn51u6bb65q
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5A2292550F6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+V3ZAlIxraiLN1BNQJiiyx7LjKDDaWv6E=
X-HE-Tag: 1622237702-401044
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2021-05-29 at 00:16 +0300, Andy Shevchenko wrote:
> On Saturday, May 29, 2021, Joe Perches <joe@perches.com> wrote:
[]
> > > > Likely these should be 0x%02x
> > > 
> > > What’s the difference (except printing 0)?
> > 
> > (assuming the argument is unsigned char/u8)
> > 
> > %#02x will always emit more than the specified length (3 or 4 chars)
> > values < 16 are 0x<hexdigit>, values >= 16 are 0x<hexdigit><hexdigit>
> 
> 0 will be 0, btw.

Hey Andy.  Right.

> > 0x%02x will always emit 4 chars
> 
> *Minimum* or at least 4 characters. There is an upper limit of sizeof(int)
> * 2 + 2.

I did write assuming the argument is unsigned char/u8.
For the general unsigned int arg case, you are of course correct.


