Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DABE27F2A0
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 21:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgI3Tds (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 15:33:48 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:56070 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbgI3Tdr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 15:33:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 97B421801EC3E;
        Wed, 30 Sep 2020 19:33:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3872:3873:4321:4362:4384:4385:4395:4605:5007:6248:6742:6743:7903:10004:10400:10848:11232:11658:11914:12043:12266:12297:12438:12679:12740:12760:12895:13019:13069:13311:13357:13439:14659:14777:21080:21365:21433:21451:21627:30054:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:13,LUA_SUMMARY:none
X-HE-Tag: bag86_060c7b527195
X-Filterd-Recvd-Size: 2698
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 19:33:41 +0000 (UTC)
Message-ID: <db26d49401dc0bd6b9013a603a155f9827f404a4.camel@perches.com>
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate
 statements
From:   Joe Perches <joe@perches.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
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
Date:   Wed, 30 Sep 2020 12:33:39 -0700
In-Reply-To: <20200929113745.GB4799@sirena.org.uk>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
         <160132172369.55460.9237357219623604216.b4-ty@kernel.org>
         <b1174f9be2ce65f6b5ebefcba0b48e792926abbc.camel@perches.com>
         <20200929113745.GB4799@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2020-09-29 at 12:37 +0100, Mark Brown wrote:
> On Mon, Sep 28, 2020 at 05:45:24PM -0700, Joe Perches wrote:
> > On Mon, 2020-09-28 at 20:35 +0100, Mark Brown wrote:
> > > [1/1] regmap: debugfs: use semicolons rather than commas to separate statements
> > >       commit: 7f4a122d0b50b40c64d24a5cf7aafe26dd9487ee
> > Rather than replying to the 0/n cover letter to a patch
> > series, can you reply to each of the specific patches in
> > the patch series you are applying?
> > Otherwise, it's a bit difficult to figure out which patches
> > you are applying.
> 
> Feel free to submit patches to b4.

Have you tried the existing option to send
thank you's on a specific ranges of patches?

b4 ty
~~~~~
usage:
  b4 ty [-h] [-g GITDIR] [-o OUTDIR] [-l] [-s SEND [SEND ...]] [-d DISCARD [DISCARD ...]] [-a] [-b BRANCH] [--since SINCE]

[]
 -s SEND, --send SEND  Generate thankyous for specific entries from -l (e.g.: 1,3-5,7-; or "all")



