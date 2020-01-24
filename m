Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B69148F63
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2020 21:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392461AbgAXUcE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jan 2020 15:32:04 -0500
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:58216 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387548AbgAXUcE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jan 2020 15:32:04 -0500
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jan 2020 15:32:03 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id CCE608124187
        for <linux-iio@vger.kernel.org>; Fri, 24 Jan 2020 20:23:58 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B7182182CED34;
        Fri, 24 Jan 2020 20:23:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1543:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3870:3871:3872:4250:4321:5007:6737:7576:8603:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12296:12297:12438:12555:12679:12740:12760:12895:13095:13439:14093:14097:14181:14659:14721:21080:21433:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: front94_3f46724fd7512
X-Filterd-Recvd-Size: 5158
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 24 Jan 2020 20:23:54 +0000 (UTC)
Message-ID: <315149bed8f3442fabcb36ec9d8c8caffe8e11eb.camel@perches.com>
Subject: Re: [PATCH] iio: ad5755: fix spelling mistake "to" -> "too"
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Ardelean, Alexandru'" <alexandru.Ardelean@analog.com>,
        "zzzzPopa, zzzzStefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 24 Jan 2020 12:22:52 -0800
In-Reply-To: <69bbc2af79d9463681b54d0aa240f89b@AcuMS.aculab.com>
References: <20200122235839.2830850-1-colin.king@canonical.com>
         <c32a44272aa593c3d0cda71a50b08f33338a2dc0.camel@analog.com>
         <69bbc2af79d9463681b54d0aa240f89b@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2020-01-23 at 14:55 +0000, David Laight wrote:
> From Ardelean, Alexandru
> > Sent: 23 January 2020 07:03
> > 
> > On Wed, 2020-01-22 at 23:58 +0000, Colin King wrote:
> > > [External]
> > > 
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > There is a spelling mistake in a dev_err message. Fix it.
> > > 
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/iio/dac/ad5755.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> > > index b9175fb4c8ab..dad0b26228a2 100644
> > > --- a/drivers/iio/dac/ad5755.c
> > > +++ b/drivers/iio/dac/ad5755.c
> > > @@ -655,7 +655,7 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct
> > > device *dev)
> > >  	for_each_child_of_node(np, pp) {
> > >  		if (devnr >= AD5755_NUM_CHANNELS) {
> > >  			dev_err(dev,
> > > -				"There is to many channels defined in DT\n");
> > > +				"There is too many channels defined in DT\n");
> > 
> > If going for the spelling stuff, maybe also change "is" to "are":
> > 'There are too many channels defined in DT\n'
> 
> Probably better still: "The DT defines too many channels\n"

bikeshedding:

How about fixing:

o missing newlines
o odd indentation
o unnecessary braces
o message grammar

at the same time?
---
 drivers/iio/dac/ad5755.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index b9175f..f6e4cf92 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -631,10 +631,9 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 			}
 		}
 
-		if (i == ARRAY_SIZE(ad5755_dcdc_freq_table)) {
+		if (i == ARRAY_SIZE(ad5755_dcdc_freq_table))
 			dev_err(dev,
-				"adi,dc-dc-freq out of range selecting 410kHz");
-		}
+				"adi,dc-dc-freq out of range selecting 410kHz\n");
 	}
 
 	pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_23V;
@@ -645,17 +644,15 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 				break;
 			}
 		}
-		if (i == ARRAY_SIZE(ad5755_dcdc_maxv_table)) {
-				dev_err(dev,
-					"adi,dc-dc-maxv out of range selecting 23V");
-		}
+		if (i == ARRAY_SIZE(ad5755_dcdc_maxv_table))
+			dev_err(dev,
+				"adi,dc-dc-maxv out of range selecting 23V\n");
 	}
 
 	devnr = 0;
 	for_each_child_of_node(np, pp) {
 		if (devnr >= AD5755_NUM_CHANNELS) {
-			dev_err(dev,
-				"There is to many channels defined in DT\n");
+			dev_err(dev, "Too many channels defined in DT\n");
 			goto error_out;
 		}
 
@@ -681,11 +678,10 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 					break;
 				}
 			}
-			if (i == ARRAY_SIZE(ad5755_slew_rate_table)) {
+			if (i == ARRAY_SIZE(ad5755_slew_rate_table))
 				dev_err(dev,
-					"channel %d slew rate out of range selecting 64kHz",
+					"channel %d slew rate out of range selecting 64kHz\n",
 					devnr);
-			}
 
 			pdata->dac[devnr].slew.step_size = AD5755_SLEW_STEP_SIZE_1;
 			for (i = 0; i < ARRAY_SIZE(ad5755_slew_step_table); i++) {
@@ -695,11 +691,10 @@ static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
 					break;
 				}
 			}
-			if (i == ARRAY_SIZE(ad5755_slew_step_table)) {
+			if (i == ARRAY_SIZE(ad5755_slew_step_table))
 				dev_err(dev,
-					"channel %d slew step size out of range selecting 1 LSB",
+					"channel %d slew step size out of range selecting 1 LSB\n",
 					devnr);
-			}
 		} else {
 			pdata->dac[devnr].slew.enable = false;
 			pdata->dac[devnr].slew.rate = AD5755_SLEW_RATE_64k;


