Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59743BADBE
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGDQKj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 12:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhGDQKj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 12:10:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4A2613B1;
        Sun,  4 Jul 2021 16:07:59 +0000 (UTC)
Date:   Sun, 4 Jul 2021 17:10:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        devicetree@vger.kernel.org, lars@metafoo.de,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org,
        leonard.crestez@nxp.com, lee.jones@linaro.org
Subject: Re: [Letux-kernel] [PATCH 0/4] mfd: rn5t618: Extend ADC support
Message-ID: <20210704171023.6199826a@jic23-huawei>
In-Reply-To: <20210703185540.5b6bec20@aktux>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703165950.6e2aeb89@jic23-huawei>
        <20210703183932.75c7012a@aktux>
        <20210703185540.5b6bec20@aktux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 3 Jul 2021 18:55:40 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> On Sat, 3 Jul 2021 18:39:40 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
> > Hi,
> > 
> > On Sat, 3 Jul 2021 16:59:50 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Sat,  3 Jul 2021 10:42:20 +0200
> > > Andreas Kemnade <andreas@kemnade.info> wrote:
> > >     
> > > > Add devicetree support so that consumers can reference the channels
> > > > via devicetree, especially the power subdevice can make use of that
> > > > to provide voltage_now properties.      
> > > 
> > > Does the mapping vary from board to board?  Often these mappings are
> > > internal to the chip so might as well be provided hard coded in the
> > > relevant drivers rather than via DT. See drivers that have iio_map
> > > structure arrays.
> > >     
> > Most things are internal to the chip, but 
> > AIN1/AIN0 are external and could be connected to anything.
> >   
> hmm, iio_map stuff looks nice, so before messing with devicetree,
> I could solve 90% of the problem by just using iio_map? For my use
> cases it is enough to have the internal stuff at the moment. That would
> simplify stuff a lot.
> 
> So I could go forward with the iio_map stuff now, and if there is a use
> case for AIN1/0, the devicetree stuff can be added later?

I was just thinking the same.  I 'think' that it will first try to find
a mapping via device tree and then use the iio_map stuff.

So you can probably get away with a mixture of the two.
Worth testing that works though (hook up iio-hwmon to AIN0 perhaps whilst
also using the iio_map approach).

I might be completely wrong though and am not aware of anyone currently
doing this...

Jonathan

> 
> Regards,
> Andreas

