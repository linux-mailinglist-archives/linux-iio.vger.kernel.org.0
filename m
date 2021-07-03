Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D283BA998
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 18:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhGCQ6S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhGCQ6R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 12:58:17 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15124C061762;
        Sat,  3 Jul 2021 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vggw9YPIH2+nZjkRtdf8oMGdKMPN/MJ+ayBYJkv/pa8=; b=n+Bh+yZF9zvjBx5VSehhsPIrMh
        7GNmh8vaOw6pwis5zwBjoJTCwBQbPKAMR6/ts+GWVfzag3Xg9vjRNg4eUB/6kCQTDKmy+7IGkwfvv
        r+FX1qvx9+Ongto1YPsYoeR75AmV5egj7eyJ05sHK+nSZ7ir98FpjMOotGFkRiMbHaw8=;
Received: from p200300ccff37da001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:da00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lzivd-0000fd-UL; Sat, 03 Jul 2021 18:55:42 +0200
Date:   Sat, 3 Jul 2021 18:55:40 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        devicetree@vger.kernel.org, lars@metafoo.de,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org,
        leonard.crestez@nxp.com, lee.jones@linaro.org
Subject: Re: [Letux-kernel] [PATCH 0/4] mfd: rn5t618: Extend ADC support
Message-ID: <20210703185540.5b6bec20@aktux>
In-Reply-To: <20210703183932.75c7012a@aktux>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703165950.6e2aeb89@jic23-huawei>
        <20210703183932.75c7012a@aktux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 3 Jul 2021 18:39:40 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Hi,
> 
> On Sat, 3 Jul 2021 16:59:50 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sat,  3 Jul 2021 10:42:20 +0200
> > Andreas Kemnade <andreas@kemnade.info> wrote:
> >   
> > > Add devicetree support so that consumers can reference the channels
> > > via devicetree, especially the power subdevice can make use of that
> > > to provide voltage_now properties.    
> > 
> > Does the mapping vary from board to board?  Often these mappings are
> > internal to the chip so might as well be provided hard coded in the
> > relevant drivers rather than via DT. See drivers that have iio_map
> > structure arrays.
> >   
> Most things are internal to the chip, but 
> AIN1/AIN0 are external and could be connected to anything.
> 
hmm, iio_map stuff looks nice, so before messing with devicetree,
I could solve 90% of the problem by just using iio_map? For my use
cases it is enough to have the internal stuff at the moment. That would
simplify stuff a lot.

So I could go forward with the iio_map stuff now, and if there is a use
case for AIN1/0, the devicetree stuff can be added later?

Regards,
Andreas
