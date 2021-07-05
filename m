Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768403BBAC0
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhGEKGw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 06:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhGEKGv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 06:06:51 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C74C061574;
        Mon,  5 Jul 2021 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=956zj6j30tlRZ1w7O85satSsrvmOb1dPD6tACO1pQag=; b=cZuA4cgxAzY/zyq6CS7qt/ZP14
        AgGHO874BNBzPsWE7OUsSNXUXPE22cvBZLS3FY5eH0cdyehJCq/j9G1CAbonr8YYTVEWH7NQ+P7L1
        mMJk3jLB4dlNQ7ZvyTyq6Zf711XxhvQ+LCX04izSQivtwSDxrl1ZUN06/QK5QdUWPL2Q=;
Received: from p200300ccff0e44001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:4400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1m0LSJ-0006aN-L5; Mon, 05 Jul 2021 12:03:59 +0200
Date:   Mon, 5 Jul 2021 12:03:58 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, <robh+dt@kernel.org>,
        <lars@metafoo.de>, <sre@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <leonard.crestez@nxp.com>,
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH 2/4] mfd: rn5t618: Add of compatibles for ADC and power
Message-ID: <20210705120358.6bf737f7@aktux>
In-Reply-To: <20210705093129.00005aab@Huawei.com>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703084224.31623-3-andreas@kemnade.info>
        <20210703170405.60828c57@jic23-huawei>
        <YOK2aKYU6TK1GO7H@dell>
        <20210705093129.00005aab@Huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Jul 2021 09:31:29 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 5 Jul 2021 08:36:08 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Sat, 03 Jul 2021, Jonathan Cameron wrote:
> >   
> > > On Sat,  3 Jul 2021 10:42:22 +0200
> > > Andreas Kemnade <andreas@kemnade.info> wrote:
> > >     
> > > > This allows having devicetree nodes for the subdevices.
> > > > 
> > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > ---
> > > >  drivers/mfd/rn5t618.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> > > > index 384acb459427..b916c7471ca3 100644
> > > > --- a/drivers/mfd/rn5t618.c
> > > > +++ b/drivers/mfd/rn5t618.c
> > > > @@ -24,8 +24,10 @@ static const struct mfd_cell rn5t618_cells[] = {
> > > >  };
> > > >  
> > > >  static const struct mfd_cell rc5t619_cells[] = {
> > > > -	{ .name = "rn5t618-adc" },
> > > > -	{ .name = "rn5t618-power" },
> > > > +	{ .name = "rn5t618-adc",
> > > > +	  .of_compatible = "ricoh,rc5t619-adc" },    
> > > 
> > > Odd to have a name of 618 and a compatible of 619.  Why?
> > > Definitely deserves a comment if this is necessary for some reason!    
> > 
> > Actually this is the norm.  We have lots of drivers named after the
> > *first* device they supported before expansion.  
> 
> Ah. I'd missed that this cells array is specific to the 5t619, though if
> the driver is the same I'd also expect it to be needed for the 5t618 entry.
> 
Well, yes, it is needed for the 5t618 also. But if I would add it, it
would be untested. And that second shorter array is also used for the
rn5t567 which does not have an ADC, So I we need three arrays there.

Regards,
Andreas
