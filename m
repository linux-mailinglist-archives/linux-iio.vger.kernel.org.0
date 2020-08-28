Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051EF256009
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgH1RwD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 13:52:03 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:49450 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726794AbgH1RwC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 13:52:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9C5C8100E7B4C;
        Fri, 28 Aug 2020 17:52:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2892:2911:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3873:3874:4321:4425:4560:5007:6742:6743:7903:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21067:21080:21324:21433:21451:21627:30012:30054:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: edge90_0e065aa27077
X-Filterd-Recvd-Size: 3579
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 17:51:56 +0000 (UTC)
Message-ID: <d8dce79d93363e19ea132ba8237a607a1ff28f09.camel@perches.com>
Subject: Re: [PATCH v2 09/18] iio: afe: iio-rescale: Simplify with
 dev_err_probe()
From:   Joe Perches <joe@perches.com>
To:     Peter Rosin <peda@axentia.se>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Date:   Fri, 28 Aug 2020 10:51:55 -0700
In-Reply-To: <b7a5a441-cda1-ad02-b723-255231f2bd94@axentia.se>
References: <20200827192642.1725-1-krzk@kernel.org>
         <20200827192642.1725-9-krzk@kernel.org>
         <f4a5777e-fe85-9f3f-4818-f7539f223adc@axentia.se>
         <20200828062443.GA17343@pi3>
         <3a5cb59b-454e-2c3f-9f31-43147e843c66@axentia.se>
         <CAJKOXPcqNE5U82UThzBTPCvucCf2LsCVSfAHE1vnecJGCKCaig@mail.gmail.com>
         <b7a5a441-cda1-ad02-b723-255231f2bd94@axentia.se>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2020-08-28 at 11:39 +0200, Peter Rosin wrote:
> On 2020-08-28 09:03, Krzysztof Kozlowski wrote:
> > > > If there is no consensus among discussing people, I find this 100 line
> > > > more readable, already got review, checkpatch accepts it so if subsystem
> > > > maintainer likes it, I prefer to leave it like this.
> > > 
> > > I'm not impressed by that argument. For the files I have mentioned, it
> > > does not matter very much to me if you and some random person think that
> > > 100 columns might *slightly* improve readability.
> > > 
> > > Quoting coding-style
> > > 
> > >   Statements longer than 80 columns should be broken into sensible chunks,
> > >   unless exceeding 80 columns significantly increases readability and does
> > >   not hide information.
> > > 
> > > Notice that word? *significantly*
> > 
> > Notice also checkpatch change...
> 
> How is that relevant? checkpatch has *never* had the final say and its
> heuristics can never be perfect. Meanwhile, coding style is talking about
> exactly the case under discussion, and agrees with me perfectly.

As the checkpatch maintainer, checkpatch is stupid.
Using it as a primary argument should never be acceptable.

But line lengths from 81 to 100 columns should be exceptions
rather than
standard use.

Any named maintainer of actual code determines the style for
that code.

Style consistency and use of kernel standard mechanisms
should be the primary goals here.


