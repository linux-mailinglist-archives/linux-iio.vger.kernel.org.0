Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701A117CDC5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 12:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCGLUv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 06:20:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgCGLUv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 06:20:51 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D177F2070A;
        Sat,  7 Mar 2020 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583580050;
        bh=ZJk7na9QpRsDSv5+wNyz1Qd2b8Z/RiQ9Ql0BUbBcEJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k5WKrAMtNLuNcAQLaZcuaZZiqJ3EYe6Ep3LRies158Q2KMVgL3NYK/ca4dKUTbssy
         Z+nMGUDthiojBUn5Ukx2zV/Wvh+StvPvXL/1QHkfpOl91sXQ+jM6HoVedxpWPIdSbw
         0FdG9+zwDX1fsTwosQylFogb47sZz9zJoAGCOPA4=
Date:   Sat, 7 Mar 2020 11:20:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dylan Howey <Dylan.Howey@tennantco.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: Expose temperature channel
Message-ID: <20200307112046.073843ef@archlinux>
In-Reply-To: <20200224210018.GA937@tennantco.com>
References: <20200205203240.13550-1-Dylan.Howey@tennantco.com>
        <20200208163154.4d4f6752@archlinux>
        <20200213220407.GA11762@tennantco.com>
        <20200214132400.7133bcf5@archlinux>
        <20200224210018.GA937@tennantco.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Feb 2020 15:00:20 -0600
Dylan Howey <Dylan.Howey@tennantco.com> wrote:

> On 02/14/2020 13:24, Jonathan Cameron wrote:
> > So ideally we'd get someone at Freescale to confirm there is a hardware
> > rather than a documentation issue (i.e. maybe we need some other magic).  
>   
> NXP says there's a documentation issue. CTRL_REG6 can only be written
> when the device is in standby, similar to the other CTRL_REG* registers.
> 
> So I'll need to use mma8452_change_config to set this register. I will
> try this out and send a patch.
> 
> One other detail - the temperature cannot be buffered by the hwfifo.
> If I add hwfifo support, I think the right thing to do would be to
> disable hwfifo implicitly if the temperature channel is enabled and
> fall back to one interrupt per sample.
> 

It's actually fairly uncommon or people to want to sample the temperature
anywhere near as often as acceleration values, so you might be better
off only supporting sysfs polled reads to the temperature channel.

That way there won't be an unusual result of enabling the temperature
channel.

Anyone who wants the temperature (slow changing) can just grab a few
readings alongside using the buffer for the much faster changing
inertial readings.

Jonathan



