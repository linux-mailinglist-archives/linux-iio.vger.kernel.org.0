Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02A224D16
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGRQdk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgGRQdk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:33:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781382177B;
        Sat, 18 Jul 2020 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595090019;
        bh=KdUPr2RAIGryhaGAIOD+pqH9l+8+z5jhUK4ivui7FtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w6P3M19R8tsqi/bgmXIX9PHHIctE+W+XBZBs/oT/4tR0EaYPEk3LcIO0PltfvhlVl
         jaeQSoLbztCFjsZZuz/pdLlcm6UD5rNgB5uDgzeh3/Fti1HW0wx8yarQv9DP0kofw5
         oudRjERbOg9SblXPZu5rgrdExzAYaFkskM4nRCHI=
Date:   Sat, 18 Jul 2020 17:33:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] dt-bindings: iio: ti,ads8688 yaml conversion
Message-ID: <20200718173335.0b3b8cf2@archlinux>
In-Reply-To: <20200715215744.GA879805@bogus>
References: <20200705131720.240574-1-jic23@kernel.org>
        <20200715215744.GA879805@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jul 2020 15:57:44 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, Jul 05, 2020 at 02:17:20PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Fairly simple binding.  Most of the changes were filling in information
> > not previously found in the binding.  I dropped the previous explicit
> > mention of spi-max-frequency as that is covered by the generic SPI
> > binding.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sean Nyekjaer <sean@geanix.com>
> > ---
> > 
> > Sean, are you fine with being explicitly listed at the maintainer
> > of this binding?  Previously we didn't have that formally laid
> > out in the old txt bindings but it's now a required field.
> > 
> > I'm going to slowly work my way through some of the simpler yaml conversions
> > over the next few months.   Of course I welcome anyone else taking
> > some of these on but for purposes of review, please keep it to only
> > a few at a time.  
> 
> Actually, I'd really prefer a bunch at a time if it is by one person. 
> Not because I need more to review :P, but then all the mistakes are the 
> same and can be fixed in one go. I have a script[1] I use that does some 
> of the boilerplate, but not the hard part (properties). It works best if 
> you tweak the template with what's common for a set of bindings.

Fair enough.  Let the deluge begin :)

Applied this one to the togreg branch of iio.git and pushed out as testing
for the autobuilders to probably ignore it.

Thanks,

Jonathan

> 
> Rob
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=yaml-bindings-v2

