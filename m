Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B7C3E4D96
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhHIUDl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 16:03:41 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:37658 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236195AbhHIUDh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 16:03:37 -0400
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E60851809CDF4;
        Mon,  9 Aug 2021 20:03:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 5B4E5B2797;
        Mon,  9 Aug 2021 20:03:12 +0000 (UTC)
Message-ID: <6a75b875a01e8697b5a3556d14f3ee9bd72d5050.camel@perches.com>
Subject: Re: [PATCH v5 1/5] iio: adc: ad7949: define and use bitfield names
From:   Joe Perches <joe@perches.com>
To:     Liam Beguin <liambeguin@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Date:   Mon, 09 Aug 2021 13:03:10 -0700
In-Reply-To: <CDEHW1G78JUJ.CQG08OEMNYLQ@shaak>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
         <20210808015659.2955443-2-liambeguin@gmail.com>
         <b52eb842e1c681b88dbffba262075957b9741262.camel@perches.com>
         <CDEHW1G78JUJ.CQG08OEMNYLQ@shaak>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5B4E5B2797
X-Spam-Status: No, score=-1.38
X-Stat-Signature: ponw9bnqokmxfbtn5trjcqttcnxy4tz6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1878J4i44xS1a+IwmyG+Xhs1fXR3KBpfaM=
X-HE-Tag: 1628539392-208200
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-08-08 at 18:46 -0400, Liam Beguin wrote:
> On Sun Aug 8, 2021 at 12:51 PM EDT, Joe Perches wrote:
> > On Sat, 2021-08-07 at 21:56 -0400, Liam Beguin wrote:
> > > Replace raw configuration register values by using FIELD_PREP and
> > > defines to improve readability.
> > []
> > > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > []
> > +#define AD7949_CFG_BIT_INCC GENMASK(12, 10)
> > 
> 
> Hi Joe,
> 
> > I think the naming is a bit confusing as it appears as if
> > these bitfield ranges are single bits.
> 
> That makes sense.
> Would AD7949_CFG_BITS_* be good enough?

Sure, or add MASK or something else like AD7949_CFG_MASK_INCC.

It's pretty common to define _MASK and _SHIFT for these types
of uses.

For instance:
include/drm/drm_dp_helper.h-# define DP_DSC_MAJOR_MASK                  (0xf << 0)
include/drm/drm_dp_helper.h-# define DP_DSC_MINOR_MASK                  (0xf << 4)
include/drm/drm_dp_helper.h:# define DP_DSC_MAJOR_SHIFT                 0
include/drm/drm_dp_helper.h:# define DP_DSC_MINOR_SHIFT                 4


