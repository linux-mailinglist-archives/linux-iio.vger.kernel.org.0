Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8773342D91
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 16:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCTPOe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 11:14:34 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:34876 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229546AbhCTPN5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 11:13:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0313E1803BAF1;
        Sat, 20 Mar 2021 15:13:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3353:3622:3743:3865:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6117:6235:7557:7652:7903:10004:10400:11026:11232:11473:11658:11783:11914:12043:12296:12297:12438:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21212:21433:21627:21990:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: quilt82_231057427759
X-Filterd-Recvd-Size: 2448
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 20 Mar 2021 15:13:56 +0000 (UTC)
Message-ID: <5fda4359734f5b008040090d1bad96e36473e307.camel@perches.com>
Subject: Re: [PATCH 4/4] iio: dac: Convert powerdown read callbacks to
 sysfs_emit()
From:   Joe Perches <joe@perches.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Sat, 20 Mar 2021 08:13:55 -0700
In-Reply-To: <3e26d657-4f03-5284-8cfe-73131a65e33f@metafoo.de>
References: <20210320071405.9347-1-lars@metafoo.de>
         <20210320071405.9347-5-lars@metafoo.de>
         <733be1879f059f87fc03df79b33cf5560f3dfcaf.camel@perches.com>
         <3e26d657-4f03-5284-8cfe-73131a65e33f@metafoo.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2021-03-20 at 13:52 +0100, Lars-Peter Clausen wrote:
> On 3/20/21 12:01 PM, Joe Perches wrote:
> > On Sat, 2021-03-20 at 08:14 +0100, Lars-Peter Clausen wrote:
> > > Update DAC drivers powerdown attribute show callback to use the new
> > > sysfs_emit() function.
> > > 
> > > sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> > > knows about the sysfs buffer specifics and has some built-in sanity checks.
> > Thanks.
> > 
> > unrelated trivia:
> > 
> > > diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> > []
> > > @@ -255,7 +255,7 @@ static ssize_t ad5360_read_dac_powerdown(struct device *dev,
> > >   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > >   	struct ad5360_state *st = iio_priv(indio_dev);
> > >   
> > > 
> > > -	return sprintf(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
> > > +	return sysfs_emit(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
> > rather than cast to bool, perhaps standardize to use !!(val & test)
> I very much prefer the cast to bool since it semantically stronger. You 
> don't have to know that the !! idiom is used to cast an int to bool.

Using !! does not cast to bool, it's an int.

casting to bool and using %d in a printf equivalent ends up with an
integer promotion/implicit type conversion from bool to int.

Anyway, it's not my code so it's author's choice, but similar
code using different styles is, at a minimum, inconsistent.


