Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87759282650
	for <lists+linux-iio@lfdr.de>; Sat,  3 Oct 2020 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgJCTgS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Oct 2020 15:36:18 -0400
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:37162 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgJCTgR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Oct 2020 15:36:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DC1A2180A7FF0;
        Sat,  3 Oct 2020 19:36:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3874:4321:5007:6248:6742:6743:7903:7974:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:14777:21080:21325:21433:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: ship26_570a7fe271af
X-Filterd-Recvd-Size: 3575
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat,  3 Oct 2020 19:36:11 +0000 (UTC)
Message-ID: <306974234222092651f7497504f8c03e1304926b.camel@perches.com>
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate
 statements
From:   Joe Perches <joe@perches.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, tools@linux.kernel.org,
        linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-acpi@vger.kernel.org, David Lechner <david@lechnology.com>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
        openipmi-developer@lists.sourceforge.net,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-ide@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-wireless@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Sat, 03 Oct 2020 12:36:10 -0700
In-Reply-To: <c7fd58ebd81f8731fc03434b2bdd8aa4bf99335a.camel@perches.com>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
         <160132172369.55460.9237357219623604216.b4-ty@kernel.org>
         <b1174f9be2ce65f6b5ebefcba0b48e792926abbc.camel@perches.com>
         <20200929113745.GB4799@sirena.org.uk>
         <db26d49401dc0bd6b9013a603a155f9827f404a4.camel@perches.com>
         <20201001110150.GA6715@sirena.org.uk>
         <f44d19ad596f261c0287c9ab18c45161003efb43.camel@perches.com>
         <20201003191501.o56tqq63d2buq5ox@chatter.i7.local>
         <c7fd58ebd81f8731fc03434b2bdd8aa4bf99335a.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-10-03 at 12:27 -0700, Joe Perches wrote:
> On Sat, 2020-10-03 at 15:15 -0400, Konstantin Ryabitsev wrote:
> > On Sat, Oct 03, 2020 at 11:40:48AM -0700, Joe Perches wrote:
> > > (Adding tools and Konstantin Ryabitsev)
> > > 
> > > There seems to be some mismatch between b4's use of the
> > > cover letter to a patch series and what maintainers that
> > > apply a subset of the patches in the patch series.
> > > 
> > > The merge description shows the entire patch series as
> > > applied, but the actual merge is only a subset of the
> > > series.
> > > 
> > > Can this be improved in b4?
> > 
> > So, the following logic should be applied:
> > 
> > - if the entire series was applied, reply to 0/n
> > - if a subset only is applied, reply to each n/n of the patch that was 
> >   cherry-picked out of the series
> > 
> > Is that an accurate summary?
> 
> Exactly so, thanks.

And there's no need to commit the [0/n] cover letter as a
part of the merge unless the entire series was committed.

Or perhaps trim the cover letter to exclude the files
modified by the patch series and show only the actual files
committed.

And I believe b4 inserts this line ahead of the 0/n series
cover letter description for the merge:

    Merge series "<series>" from <author>:

Perhaps that like could be "partial merge of" when a partial
merge occurs or left as is if the entire series is applied.

cheers, Joe

