Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F43ECA56
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 18:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhHOQ6h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 12:58:37 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:39992 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229453AbhHOQ6h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Aug 2021 12:58:37 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8B330182CED28;
        Sun, 15 Aug 2021 16:58:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 2BD2B24023A;
        Sun, 15 Aug 2021 16:58:04 +0000 (UTC)
Message-ID: <eb51990402a466821b855092a3fa2171b5a98bcf.camel@perches.com>
Subject: Re: [PATCH v4] drivers/iio: Remove all strcpy() uses
From:   Joe Perches <joe@perches.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 15 Aug 2021 09:58:02 -0700
In-Reply-To: <20210815163639.GA97260@titan>
References: <20210814135509.4500-1-len.baker@gmx.com>
         <CAHp75VdBuQTzCbz1CJciSA1+UOw0ZmJKAh8u2cbr5eDLSsRJEw@mail.gmail.com>
         <c08cfa8b6bbf07e1860d7dc93739e71ff5f4c0c4.camel@perches.com>
         <20210815163639.GA97260@titan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2BD2B24023A
X-Stat-Signature: fk3nqhj5ocpdb55rwicp5umkayeqgrc5
X-Spam-Status: No, score=0.35
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX190y5nwdIZ6qcrkev8JWWtvpp12SQYyul8=
X-HE-Tag: 1629046684-898282
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-08-15 at 18:36 +0200, Len Baker wrote:
> Hi Joe,

Hello Len.

Don't take this advice too seriously, it's just bikeshedding
but it seems to me an unexpected use of a strcmp equivalent
in a non performance sensitive path.
 
> On Sun, Aug 15, 2021 at 08:06:45AM -0700, Joe Perches wrote:
[]
> > bikeshed:
> > 
> > I think this change is less intelligible than the original strcmp.
> 
> So, if I understand correctly you suggest to change the above line for:
>                               else if (strcmp(orient, "0") == 0)

Yes.

In kernel sources it's about 2:1 in favor of '!strcmp()' over 'strcmp() == 0'

$ git grep -P '\!\s*strcmp\b' | wc -l
3457
$ git grep -P '\bstrcmp\s*\([^\)]+\)\s*==\s*0\b' | wc -l
1719

And it's your choice to use one or the other or just your V4 patch.

btw, according to godbolt:

gcc -O2 doesn't call strcmp and produces the same object code as your
byte comparisons.  clang 11 calls strcmp regardless of optimization level.


