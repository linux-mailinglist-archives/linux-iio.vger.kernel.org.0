Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6CDD69D
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2019 06:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfJSEdp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Oct 2019 00:33:45 -0400
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:53734 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726971AbfJSEdp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Oct 2019 00:33:45 -0400
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Oct 2019 00:33:44 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id DA5C018020B16
        for <linux-iio@vger.kernel.org>; Sat, 19 Oct 2019 04:25:05 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D5C94180144BE;
        Sat, 19 Oct 2019 04:25:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:4250:4321:5007:6121:10004:10400:10848:11026:11232:11658:11914:12043:12048:12297:12438:12740:12760:12895:13069:13311:13357:13439:13972:14659:14721:21080:21627:30054:30091,0,RBL:23.242.70.174:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: tank37_ed58174bf857
X-Filterd-Recvd-Size: 2088
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Oct 2019 04:25:01 +0000 (UTC)
Message-ID: <0a5b872c48fb4047982c67d84f90bd075a0a357b.camel@perches.com>
Subject: Re: [PATCH v4 2/2] iio: (bma400) add driver for the BMA400
From:   Joe Perches <joe@perches.com>
To:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Date:   Fri, 18 Oct 2019 21:25:00 -0700
In-Reply-To: <20191018031848.18538-3-dan@dlrobertson.com>
References: <20191018031848.18538-1-dan@dlrobertson.com>
         <20191018031848.18538-3-dan@dlrobertson.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2019-10-18 at 03:18 +0000, Dan Robertson wrote:
> Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> The driver supports reading from the acceleration and temperature
> registers. The driver also supports reading and configuring the output data
> rate, oversampling ratio, and scale.

trivial logging note:

> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
[]
> +static int bma400_get_accel_reg(struct bma400_data *data,
> +				const struct iio_chan_spec *chan,
> +				int *val)
> +{
[]
> +		dev_err(data->dev, "invalid axis channel modifier");

All the logging should use \n terminations

		dev_err(data->dev, "invalid axis channel modifier\n");
[]
> +static int bma400_get_accel_output_data_rate(struct bma400_data *data)
> +{
[]
> +			dev_err(data->dev, "invalid ODR=%x", odr);
should be:
			dev_err(data->dev, "invalid ODR=%x\n", odr);

etc...


