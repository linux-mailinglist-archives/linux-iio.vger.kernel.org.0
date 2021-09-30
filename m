Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6941DE77
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348836AbhI3QNX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 12:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348578AbhI3QNX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 12:13:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 984AC613CD;
        Thu, 30 Sep 2021 16:11:39 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:15:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rn5t618-adc: use
 devm_iio_map_array_register() function
Message-ID: <20210930171535.5ede99c7@jic23-huawei>
In-Reply-To: <20210927220834.014e6c77@aktux>
References: <20210926162859.3567685-1-aardelean@deviqon.com>
        <20210927220834.014e6c77@aktux>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Sep 2021 22:08:34 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> On Sun, 26 Sep 2021 19:28:59 +0300
> Alexandru Ardelean <aardelean@deviqon.com> wrote:
> 
> > This driver already hooks a similar unwind callback via
> > devm_add_action_or_reset().
> > 
> > They pretty much do the same thing, so this change converts it to the
> > devm_iio_map_array_register().
> > 
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > ---
> >  drivers/iio/adc/rn5t618-adc.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)  
> 
> yes, looks sane, the patches it depens on are not in linux-next yet.
I was waiting for 0-day confirmation which for some reason has gone astray
(not problems reported either).  Ah well - I'll assume it's fine and
risk next breakage.

> But it seems that they are accepted, so:
> 
> Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Thanks and applied to the togreg branch of iio.git, pushed out as testing to
see if 0-day notices this time.

Thanks,

Jonathan

