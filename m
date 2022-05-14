Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625FF527320
	for <lists+linux-iio@lfdr.de>; Sat, 14 May 2022 18:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiENQsu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 May 2022 12:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiENQsn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2022 12:48:43 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 May 2022 09:48:25 PDT
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7727B369E0
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 09:48:25 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 77BC532002;
        Sat, 14 May 2022 16:31:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 4395560009;
        Sat, 14 May 2022 16:31:24 +0000 (UTC)
Message-ID: <58a70b4a91a184eef26f9823636bf81c573b2c3b.camel@perches.com>
Subject: Re: [PATCH 05/22] iio: replace bitmap_weight with
 bitmap_weitght_{eq,le} where appropriate
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org
Date:   Sat, 14 May 2022 09:31:23 -0700
In-Reply-To: <20220514165309.7445c767@jic23-huawei>
References: <20220510154750.212913-1-yury.norov@gmail.com>
         <20220510154750.212913-6-yury.norov@gmail.com>
         <20220514165309.7445c767@jic23-huawei>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: zyycxee6xd4h5bntsfrd6nbdzt79pp8t
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4395560009
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ZFvGeH+fXzF/xfnsLphuIT8PlcpdCOCo=
X-HE-Tag: 1652545884-847318
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2022-05-14 at 16:53 +0100, Jonathan Cameron wrote:
> On Tue, 10 May 2022 08:47:33 -0700
> Yury Norov <yury.norov@gmail.com> wrote:
> 
> > bitmap_weight_{eq,le} is better than bitmap_weight because it
> > may return earlier.
> > 
> > CC: Jonathan Cameron <jic23@kernel.org>
> > CC: Lars-Peter Clausen <lars@metafoo.de>
> > CC: Michael Hennerich <Michael.Hennerich@analog.com>
> > CC: linux-iio@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> without being cc'd on the cover letter, there is no obvious way for
> me to know this is reliant in some series to be found in next.
> 
> Please call out the exact dependency and whilst it's a long list,
> it is good to cc all people cc'd on individual patches also
> on the cover letter so they have that background information.

When doing a treewide change like this, vger would commonly
reject the message because of too many recipients.

> 
> Change seems fine, but I've no idea when/if to pick it up because of
> that lack of information.

You could try using lore with the in-reply-to message header id

https://lore.kernel.org/lkml/20220510154750.212913-6-yury.norov@gmail.com/

that gives you the entire thread.

