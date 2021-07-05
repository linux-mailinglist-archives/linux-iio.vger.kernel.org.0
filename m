Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207DF3BBC12
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 13:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhGELV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 07:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhGELV2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 07:21:28 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE06C061574;
        Mon,  5 Jul 2021 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3lp+7OK+HfsYz8a5I6i5SZB/z375QfgglVqw2EMRVxs=; b=js14/rOGP2/QHs4YP5/Y57vnTd
        faI60nHcL0hOioBaobuEeeoDtlQmp03wC23Hxaqi5RD5V5e0+ETORthBzSIKJmnGSQXhzQDOd9Z1h
        hoDNOi5d5OylsWRr6V/TZ7RJiivTCWr4tFvYZmG0G6aSND88z//Dvfky168EgxZSIT38=;
Received: from p200300ccff0e44001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:4400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1m0Mci-00076D-Gq; Mon, 05 Jul 2021 13:18:48 +0200
Date:   Mon, 5 Jul 2021 13:18:47 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        devicetree@vger.kernel.org, lars@metafoo.de,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org,
        leonard.crestez@nxp.com, lee.jones@linaro.org
Subject: Re: [Letux-kernel] [PATCH 0/4] mfd: rn5t618: Extend ADC support
Message-ID: <20210705131847.471d3ca5@aktux>
In-Reply-To: <20210704171023.6199826a@jic23-huawei>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703165950.6e2aeb89@jic23-huawei>
        <20210703183932.75c7012a@aktux>
        <20210703185540.5b6bec20@aktux>
        <20210704171023.6199826a@jic23-huawei>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 4 Jul 2021 17:10:23 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 3 Jul 2021 18:55:40 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
> > On Sat, 3 Jul 2021 18:39:40 +0200
> > Andreas Kemnade <andreas@kemnade.info> wrote:
> >   
> > > Hi,
> > > 
> > > On Sat, 3 Jul 2021 16:59:50 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >     
> > > > On Sat,  3 Jul 2021 10:42:20 +0200
> > > > Andreas Kemnade <andreas@kemnade.info> wrote:
> > > >       
> > > > > Add devicetree support so that consumers can reference the channels
> > > > > via devicetree, especially the power subdevice can make use of that
> > > > > to provide voltage_now properties.        
> > > > 
> > > > Does the mapping vary from board to board?  Often these mappings are
> > > > internal to the chip so might as well be provided hard coded in the
> > > > relevant drivers rather than via DT. See drivers that have iio_map
> > > > structure arrays.
> > > >       
> > > Most things are internal to the chip, but 
> > > AIN1/AIN0 are external and could be connected to anything.
> > >     
> > hmm, iio_map stuff looks nice, so before messing with devicetree,
> > I could solve 90% of the problem by just using iio_map? For my use
> > cases it is enough to have the internal stuff at the moment. That would
> > simplify stuff a lot.
> > 
> > So I could go forward with the iio_map stuff now, and if there is a use
> > case for AIN1/0, the devicetree stuff can be added later?  
> 
> I was just thinking the same.  I 'think' that it will first try to find
> a mapping via device tree and then use the iio_map stuff.
> 
> So you can probably get away with a mixture of the two.
> Worth testing that works though (hook up iio-hwmon to AIN0 perhaps whilst
> also using the iio_map approach).
> 
> I might be completely wrong though and am not aware of anyone currently
> doing this...
> 
I tested that approach, It works, so I will first post a series with
just the iio_map stuff and later the devicetree stuff.

Regards,
Andreas
