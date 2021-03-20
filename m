Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232CD342C4C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 12:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCTLgq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 07:36:46 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:41106 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229445AbhCTLgT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 07:36:19 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Mar 2021 07:36:19 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 646C71802EC79
        for <linux-iio@vger.kernel.org>; Sat, 20 Mar 2021 11:06:53 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2E5C71801FC5B;
        Sat, 20 Mar 2021 11:01:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:4250:4321:4362:4605:5007:6117:7652:10004:10400:10848:11026:11232:11473:11658:11914:12043:12295:12296:12297:12438:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21212:21627:21990:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: stove97_440bd9227757
X-Filterd-Recvd-Size: 2673
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 20 Mar 2021 11:01:52 +0000 (UTC)
Message-ID: <733be1879f059f87fc03df79b33cf5560f3dfcaf.camel@perches.com>
Subject: Re: [PATCH 4/4] iio: dac: Convert powerdown read callbacks to
 sysfs_emit()
From:   Joe Perches <joe@perches.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Sat, 20 Mar 2021 04:01:50 -0700
In-Reply-To: <20210320071405.9347-5-lars@metafoo.de>
References: <20210320071405.9347-1-lars@metafoo.de>
         <20210320071405.9347-5-lars@metafoo.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2021-03-20 at 08:14 +0100, Lars-Peter Clausen wrote:
> Update DAC drivers powerdown attribute show callback to use the new
> sysfs_emit() function.
> 
> sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> knows about the sysfs buffer specifics and has some built-in sanity checks.

Thanks.

unrelated trivia:

> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
[]
> @@ -255,7 +255,7 @@ static ssize_t ad5360_read_dac_powerdown(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad5360_state *st = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
> +	return sysfs_emit(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));

rather than cast to bool, perhaps standardize to use !!(val & test)

> diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
[]
> @@ -117,8 +117,8 @@ static ssize_t ad5624r_read_dac_powerdown(struct iio_dev *indio_dev,
>  {
>  	struct ad5624r_state *st = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d\n",
> -			!!(st->pwr_down_mask & (1 << chan->channel)));
> +	return sysfs_emit(buf, "%d\n",
> +			  !!(st->pwr_down_mask & (1 << chan->channel)));

like this and below...

> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
[]
> @@ -57,7 +57,7 @@ static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
> 
> -	return sprintf(buf, "%d\n", !!(st->pwr_down_mask &
> +	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
>  				       (0x3 << (chan->channel * 2))));
>  }

etc...

and it might be nicer to rewrap alignments like

	return sysfs_emit(buf, "%d\n",
			  !!(st->pwr_down_mask & (0x3 << (chan->channel * 2))));


