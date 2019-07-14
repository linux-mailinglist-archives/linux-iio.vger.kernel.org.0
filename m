Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3AFB67EF5
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfGNMTh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 08:19:37 -0400
Received: from smtprelay0118.hostedemail.com ([216.40.44.118]:41370 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728302AbfGNMTh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jul 2019 08:19:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 07B6A100E86C5;
        Sun, 14 Jul 2019 12:19:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6238:9036:10004:10400:10848:10967:11026:11232:11473:11658:11914:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21740:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: chair55_70b4cd25bb85f
X-Filterd-Recvd-Size: 2713
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun, 14 Jul 2019 12:19:34 +0000 (UTC)
Message-ID: <b3744e64b22de98bfe8885f76811d4fc7e41b8eb.camel@perches.com>
Subject: Re: [PATCH 04/12] iio: adc: max9611: Fix misuse of GENMASK macro
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Date:   Sun, 14 Jul 2019 05:19:32 -0700
In-Reply-To: <20190714125403.0789dc9e@archlinux>
References: <cover.1562734889.git.joe@perches.com>
         <2929234bd4ecec41c0d012edc52416ef80f3e368.1562734889.git.joe@perches.com>
         <20190714125403.0789dc9e@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2019-07-14 at 12:54 +0100, Jonathan Cameron wrote:
> On Tue,  9 Jul 2019 22:04:17 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > Arguments are supposed to be ordered high then low.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Applied to the fixes-togreg branch of iio.git and marked for
> stable etc.

This mask is used in an init function called from a probe.

I don't have this hardware but it looks as if it could
never have worked so I doubt the driver and the hardware
have ever been tested.

Does anyone have this device in actual use?


	regval = ret & MAX9611_TEMP_MASK;

	if ((regval > MAX9611_TEMP_MAX_POS &&
	     regval < MAX9611_TEMP_MIN_NEG) ||
	     regval > MAX9611_TEMP_MAX_NEG) {
		dev_err(max9611->dev,
			"Invalid value received from ADC 0x%4x: aborting\n",
			regval);
		return -EIO;
	}


> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/max9611.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > index 917223d5ff5b..0e3c6529fc4c 100644
> > --- a/drivers/iio/adc/max9611.c
> > +++ b/drivers/iio/adc/max9611.c
> > @@ -83,7 +83,7 @@
> >  #define MAX9611_TEMP_MAX_POS		0x7f80
> >  #define MAX9611_TEMP_MAX_NEG		0xff80
> >  #define MAX9611_TEMP_MIN_NEG		0xd980
> > -#define MAX9611_TEMP_MASK		GENMASK(7, 15)
> > +#define MAX9611_TEMP_MASK		GENMASK(15, 7)
> >  #define MAX9611_TEMP_SHIFT		0x07
> >  #define MAX9611_TEMP_RAW(_r)		((_r) >> MAX9611_TEMP_SHIFT)
> >  #define MAX9611_TEMP_SCALE_NUM		1000000

