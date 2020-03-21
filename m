Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A15818E0DD
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 12:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgCULxX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 07:53:23 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:37372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726192AbgCULxX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 07:53:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6E7A61800CE17;
        Sat, 21 Mar 2020 11:53:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:4037:4250:4321:5007:7903:10004:10400:10848:11232:11658:11914:12297:12438:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:21080:21433:21451:21627:21990:30034:30054:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: dolls74_57762e850ae30
X-Filterd-Recvd-Size: 2112
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Mar 2020 11:53:20 +0000 (UTC)
Message-ID: <c68e74af78fa0f73a9dc4cf5535a2dc16b99b729.camel@perches.com>
Subject: Re: [PATCH 1/2] iio: light: tsl2563: Wrap comment description
From:   Joe Perches <joe@perches.com>
To:     Nishant Malpani <nish.malpani25@gmail.com>, jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 21 Mar 2020 04:51:33 -0700
In-Reply-To: <9129a6c25f772bdfba28d556190e5511c7005e8a.1584518000.git.nish.malpani25@gmail.com>
References: <cover.1584518000.git.nish.malpani25@gmail.com>
         <9129a6c25f772bdfba28d556190e5511c7005e8a.1584518000.git.nish.malpani25@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-03-18 at 13:33 +0530, Nishant Malpani wrote:
> This patch wraps the comment description at 75 chars. Fixes the
> following warning generated by checkpatch.pl:
> 
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

Please do not scan files as patches.

checkpatch does not emit this message on a file
when used properly with the -f option.

> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
[]
> @@ -222,9 +222,9 @@ static int tsl2563_read_id(struct tsl2563_chip *chip, u8 *id)
>  }
>  
>  /*
> - * "Normalized" ADC value is one obtained with 400ms of integration time and
> - * 16x gain. This function returns the number of bits of shift needed to
> - * convert between normalized values and HW values obtained using given
> + * "Normalized" ADC value is one obtained with 400ms of integration time
> + * and 16x gain. This function returns the number of bits of shift needed
> + * to convert between normalized values and HW values obtained using given
>   * timing and gain settings.
>   */
>  static int tsl2563_adc_shiftbits(u8 timing)

