Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D59018E3B1
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 19:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCUSfj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 14:35:39 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:43138 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727015AbgCUSfj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 14:35:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DB539182CED28;
        Sat, 21 Mar 2020 18:35:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4384:5007:9025:10004:10400:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:13972:14181:14659:14721:14764:21080:21627:30029:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: word42_6b2f3b9dd3046
X-Filterd-Recvd-Size: 2030
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Mar 2020 18:35:36 +0000 (UTC)
Message-ID: <ed459ac3c268d6287f70a0aa8ca682b022f27a8e.camel@perches.com>
Subject: Re: [PATCH] drivers: iio: Drop unnecessary explicit casting
From:   Joe Perches <joe@perches.com>
To:     Nishant Malpani <nish.malpani25@gmail.com>, jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 21 Mar 2020 11:33:48 -0700
In-Reply-To: <9aa90ffd-9574-d615-0bc0-f791e51b3be4@gmail.com>
References: <20200318100754.25667-1-nish.malpani25@gmail.com>
         <a7778635620163cb6185192819a56ed44d76d4b0.camel@perches.com>
         <9aa90ffd-9574-d615-0bc0-f791e51b3be4@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-03-21 at 23:56 +0530, Nishant Malpani wrote:
> On 21/03/20 5:56 pm, Joe Perches wrote:
> > On Wed, 2020-03-18 at 15:37 +0530, Nishant Malpani wrote:
> > > Provide correct specifiers while printing error logs to discard the use
> > > of unnecessary explicit casting.
> > []
> > > diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> > []
> > > @@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
> > >   
> > >   	regmap = devm_regmap_init_i2c(i2c, &config);
> > >   	if (IS_ERR(regmap)) {
> > > -		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
> > > -			(int)PTR_ERR(regmap));
> > > +		dev_err(&i2c->dev, "Failed to register i2c regmap %ld\n",
> > > +			PTR_ERR(regmap));
> > 
> > Another option would be to use %pe to print the error identifier
> > and not the error number
> > 
> By 'error identifier' you mean the symbolic error name (as described in 
> docs [1]), right?

Yes

> https://www.kernel.org/doc/html/latest/core-api/printk-formats.html#error-pointers


