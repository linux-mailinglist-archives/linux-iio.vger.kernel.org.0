Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC8D18E12B
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 13:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCUM2m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 08:28:42 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:50760 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726192AbgCUM2m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 08:28:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 76636837F24F;
        Sat, 21 Mar 2020 12:28:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3868:4321:4384:5007:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:13972:14659:14721:21080:21627:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:15,LUA_SUMMARY:none
X-HE-Tag: wall25_68ce15f06c463
X-Filterd-Recvd-Size: 1554
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Mar 2020 12:28:40 +0000 (UTC)
Message-ID: <a7778635620163cb6185192819a56ed44d76d4b0.camel@perches.com>
Subject: Re: [PATCH] drivers: iio: Drop unnecessary explicit casting
From:   Joe Perches <joe@perches.com>
To:     Nishant Malpani <nish.malpani25@gmail.com>, jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 21 Mar 2020 05:26:52 -0700
In-Reply-To: <20200318100754.25667-1-nish.malpani25@gmail.com>
References: <20200318100754.25667-1-nish.malpani25@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-03-18 at 15:37 +0530, Nishant Malpani wrote:
> Provide correct specifiers while printing error logs to discard the use
> of unnecessary explicit casting.
[]
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
[]
> @@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
>  
>  	regmap = devm_regmap_init_i2c(i2c, &config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&i2c->dev, "Failed to register i2c regmap %ld\n",
> +			PTR_ERR(regmap));

Another option would be to use %pe to print the error identifier
and not the error number

etc...


