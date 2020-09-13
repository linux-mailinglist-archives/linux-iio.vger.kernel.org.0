Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5749A267F06
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 11:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgIMJxF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 05:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgIMJxE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 05:53:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96100208E4;
        Sun, 13 Sep 2020 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599990783;
        bh=K22yTIikP4vslFO0VN/xtTarwlclibn9EbgAS0yUKiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zxJMUGR0JpbgrA8oolxEbUtgpMtXztccd5hyrEiEGHiPCVnyfSg/b/Q9aliXIab7b
         UWAbvdd9r0yAblepBul0I8W66IMsetoyhlelz0AYJk1L40xuK0RcX88IAvWp8xS7jO
         iejmecFR06xpMvJyMEwv4+gh7cgcIjnoWY7g3PN8=
Date:   Sun, 13 Sep 2020 10:52:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Nishant Malpani <nish.malpani25@gmail.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] iio: gyro: adxrs290: Add triggered buffer
 & debugfs support
Message-ID: <20200913105259.40611cd6@archlinux>
In-Reply-To: <20200911091407.000057e7@Huawei.com>
References: <20200910180450.29696-1-nish.malpani25@gmail.com>
        <20200911091407.000057e7@Huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Sep 2020 09:14:07 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 10 Sep 2020 23:34:47 +0530
> Nishant Malpani <nish.malpani25@gmail.com> wrote:
> 
> > Introduce DATA_RDY trigger for triggered buffer setup; this enables continuous
> > data capture. Additionally, add support for direct register access using the debugfs 
> > iio interface. 
> > 
> > The device-tree bindings documentation illustrates an example of using a GPIO irq
> > line to trigger a data capture.
> > 
> > Nishant Malpani (3):
> >   iio: gyro: adxrs290: Add triggered buffer support
> >   dt-bindings: iio: gyro: adxrs290: Add interrupts support
> >   iio: gyro: adxrs290: Add debugfs register access support
> > 
> >  .../bindings/iio/gyroscope/adi,adxrs290.yaml  |   6 +
> >  drivers/iio/gyro/Kconfig                      |   2 +
> >  drivers/iio/gyro/adxrs290.c                   | 237 ++++++++++++++++--
> >  3 files changed, 231 insertions(+), 14 deletions(-)
> >   
> 
> Odd. The original patch one eventually made it (I'd checked it hadn't
> gotten to me or to lore.kernel.org yesterday :(
> 
> Ah well, one of those quirks of life and resend does no harm.
> 
> Will catch up with this tomorrow probably.
I picked it up from this resend version because b4 doesn't like the
earlier one due to the broken threading.  This one has Andy's tags
anyway so that all works out nicely.

Thanks,

Jonathan

> 
> Jonathan
> 

