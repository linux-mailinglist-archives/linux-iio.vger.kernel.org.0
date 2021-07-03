Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A783BA97D
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhGCQdw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 12:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGCQdv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 12:33:51 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C82C061762;
        Sat,  3 Jul 2021 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kQgLfSpFMoY+GI46MF6nXECban6/vAuQq5e7prXXW9k=; b=mMc3onkefVS8nYWi87kqtsjOK+
        Ev5ociBssDhjuut37NKaGxDDlV4kqfUVsUqYTwgJ63Xk6cnFsWmYz+z1QNlnFYYc6eytgzlsK8zFY
        qwSRRFG7S1KQUT//i3a17hygCr3n3ruWk+AyjnKk/NAWx+MNjL6JHfNQlV+XNyECPLKA=;
Received: from p200300ccff37da001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:da00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lziXw-0000VW-6B; Sat, 03 Jul 2021 18:31:12 +0200
Date:   Sat, 3 Jul 2021 18:31:11 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lars@metafoo.de,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/4] mfd: rn5t618: Add of compatibles for ADC and power
Message-ID: <20210703183111.2b2b9b4f@aktux>
In-Reply-To: <20210703170405.60828c57@jic23-huawei>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703084224.31623-3-andreas@kemnade.info>
        <20210703170405.60828c57@jic23-huawei>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Sat, 3 Jul 2021 17:04:05 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat,  3 Jul 2021 10:42:22 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
> > This allows having devicetree nodes for the subdevices.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/mfd/rn5t618.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> > index 384acb459427..b916c7471ca3 100644
> > --- a/drivers/mfd/rn5t618.c
> > +++ b/drivers/mfd/rn5t618.c
> > @@ -24,8 +24,10 @@ static const struct mfd_cell rn5t618_cells[] = {
> >  };
> >  
> >  static const struct mfd_cell rc5t619_cells[] = {
> > -	{ .name = "rn5t618-adc" },
> > -	{ .name = "rn5t618-power" },
> > +	{ .name = "rn5t618-adc",
> > +	  .of_compatible = "ricoh,rc5t619-adc" },  
> 
> Odd to have a name of 618 and a compatible of 619.  Why?
> Definitely deserves a comment if this is necessary for some reason!
> 
Background of this whole thing:
Both RN5T618 and RC5T619 have an ADC. I would expect the driver to work
for both but I cannot prove that. No RN5T618 here to test. Maybe it
requires some quirks, probably not. The only hint I have is that
a) I use register definitions added to the kernel for RN5T618 support
b) public datasheets looks same regarding the ADC.
c) out-of-tree code for the RN5T618 does not give a clear picture, it
shows no differences but is not complete enough to judge.

To avoid introducing untested things, I am only adding it to the
rc5t619_cell list. I would really hope that someone does some rn5t618
tests... Because everything else which is both for the RN5T618 and
RC5T619 uses rn5t618 as a name, I continued that practise.

The subdevice driver also gets the information whether it is a rn5t618
or rc5t619 via rn5t618->variant, so it can handle things.

> > +	{ .name = "rn5t618-power",
> > +	  .of_compatible = "ricoh,rc5t619-power" },

Similar situation here.

> >  	{ .name = "rn5t618-regulator" },
> >  	{ .name = "rc5t619-rtc" },
and this one definitively only exists in the rc5t619.

> >  	{ .name = "rn5t618-wdt" },  
> 
> 

Regards,
Andreas
