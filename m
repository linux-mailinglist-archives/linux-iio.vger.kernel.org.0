Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D516318E42A
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 21:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgCUULC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 16:11:02 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:40818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726777AbgCUULB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 16:11:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 357BB837F24A;
        Sat, 21 Mar 2020 20:11:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:8784:8985:9010:9025:9108:9121:10004:10400:10848:11232:11233:11658:11914:12043:12050:12262:12297:12438:12555:12679:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:14777:21080:21365:21433:21451:21627:21660:21811:21819:30022:30054:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: chess81_42bd387190014
X-Filterd-Recvd-Size: 3099
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Mar 2020 20:10:58 +0000 (UTC)
Message-ID: <c026dcc85e8454a1ea191c20ba03ce2072271af9.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: remove Stefan Popa's email
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        jic23@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Date:   Sat, 21 Mar 2020 13:09:10 -0700
In-Reply-To: <20200321194859.GA2813896@smile.fi.intel.com>
References: <20200317143336.6098-1-alexandru.ardelean@analog.com>
         <20200321194859.GA2813896@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-03-21 at 21:48 +0200, Andy Shevchenko wrote:
> On Tue, Mar 17, 2020 at 04:33:36PM +0200, Alexandru Ardelean wrote:
> > The email is no longer active. This change removes Stefan's email from the
> > MAINTAINERS list and replaces it with Michael Hennerich's.
> > 
> 
> Are you planning to fix entries as parse-maintainers.pl does?
> (Maybe in a separate change, but also why not here)

I think perhaps you should not ask people to use parse-maintainers
on specific sections anymore as it's rather confusing to use and
it's best done as a one-shot by Linus one day.  I hope soon.

Linus, are you going to apply this patch to parse-maintainers
and one day run and commit the large change to MAINTAINERS?

https://lore.kernel.org/lkml/4d5291fa3fb4962b1fa55e8fd9ef421ef0c1b1e5.camel@perches.com/

$ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS

Current diffstat for -next would be:

$ git diff --shortstat MAINTAINERS
 1 file changed, 2749 insertions(+), 2749 deletions(-)

btw: your current tree is still missing this patch from
-next to fix a broken pattern in 'TI VPE/CAL DRIVERS'

commit d44535cb14c981dea66e565edf1df1df4b9e823b
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue Jan 28 11:58:28 2020 -0300

    media: MAINTAINERS: Sort entries in database for TI VPE/CAL
    
    Run parse-maintainers.pl and choose TI VPE/CAL record. Fix it accordingly.
    
    Note, this is urgent fix, without which parse-maintainers.pl throws
    an exception:
    
    Odd non-pattern line '  Documentation/devicetree/bindings/media/ti,cal.yaml
    ' for 'TI VPE/CAL DRIVERS' at scripts/parse-maintainers.pl line 147, <$file> line 16770.
    
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Acked-by: Benoit Parrot <bparrot@ti.com>
    Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>



