Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E302719EB34
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 14:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgDEM0H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 08:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgDEM0G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 08:26:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353AB20672;
        Sun,  5 Apr 2020 12:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586089566;
        bh=w9QUzAecpFqcM0HgC1NsocyonUjRV40NnLOep//tZG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pWp4ILFe5FLeyttD8+gfqR5qG/J4T/cjQibOq08fu3kL3mRUq8h6URVOVDVO+Z/dv
         XP+bxSFN01mztftc2+j/Zk4MNQZSunkQQUe50VSyF6807y4yaUaVAXFEsCyHfT8Ne0
         IjET8af7kEYvJpGSbYxFpBKwzDsjyRfekkHLXVQ0=
Date:   Sun, 5 Apr 2020 13:26:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: xilinx-xadc: Fix ADC-B powerdown
Message-ID: <20200405132602.65a7a480@archlinux>
In-Reply-To: <55c93588-2242-2ccb-2d8e-50cc66de28f5@metafoo.de>
References: <20200403132717.24682-1-lars@metafoo.de>
        <20200405131039.37ae5165@archlinux>
        <55c93588-2242-2ccb-2d8e-50cc66de28f5@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Apr 2020 14:13:32 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 4/5/20 2:10 PM, Jonathan Cameron wrote:
> > On Fri,  3 Apr 2020 15:27:13 +0200
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >  
> >> The check for shutting down the second ADC is inverted. This causes it to
> >> be powered down when it should be enabled. As a result channels that are
> >> supposed to be handled by the second ADC return invalid conversion results.
> >>
> >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> > Fixes tag?  Definitely sounds like something we should be backporting!  
> 
> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
For all of them? (just checking)

Jonathan

> 
> >
> > Jonathan
> >  
> >> ---
> >>   drivers/iio/adc/xilinx-xadc-core.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> >> index 2d6505a66511..4fcf1729341f 100644
> >> --- a/drivers/iio/adc/xilinx-xadc-core.c
> >> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> >> @@ -722,13 +722,14 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
> >>   {
> >>   	uint16_t val;
> >>   
> >> +	/* Powerdown the ADC-B when it is not needed. */
> >>   	switch (seq_mode) {
> >>   	case XADC_CONF1_SEQ_SIMULTANEOUS:
> >>   	case XADC_CONF1_SEQ_INDEPENDENT:
> >> -		val = XADC_CONF2_PD_ADC_B;
> >> +		val = 0;
> >>   		break;
> >>   	default:
> >> -		val = 0;
> >> +		val = XADC_CONF2_PD_ADC_B;
> >>   		break;
> >>   	}
> >>     
> 
> 

