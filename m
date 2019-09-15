Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB50B3058
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfIONxx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 09:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfIONxw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 09:53:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DF2214C6;
        Sun, 15 Sep 2019 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568555632;
        bh=E5UhPrw0VFkzCJ82aQ9YjCuaUvDP6zK97JuAM6sRayo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AiFCnXaZeUghfuUY5tc6rcL6eg7m9KgAs6LgoIPtg/B0h++7GwxdQNs/skLtTO653
         CSLRbh8t4qAade2CmGrkR4YrxRwGc79dDkCuQPS7Arcd3AvNlwizdh01m/haunPIvz
         z+5aKmQ1T4Jk6d51p3CgoCjhBP4sxDPK6Jmx9XfM=
Date:   Sun, 15 Sep 2019 14:53:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [RFC/PATCH 0/1] Quadrature Encoder Support
Message-ID: <20190915145347.42bfc393@archlinux>
In-Reply-To: <20190909121605.92008-1-felipe.balbi@linux.intel.com>
References: <20190909121605.92008-1-felipe.balbi@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Sep 2019 15:16:04 +0300
Felipe Balbi <felipe.balbi@linux.intel.com> wrote:

> Hi,
> 
> Here's a simple RFC for Intel's Quadrature Encoder. Let me make it clear
> that I don't mean we should the following patch as is, rather I'd like
> to open the discussion to, perhaps, extending Industrial Automation
> Framework with support for Quadrature Encoders.
> 
> Let me know if you think IIO would be correct place for such devices,
> then I can start reworking the driver to provide an IIO-compliant
> interface.
> 
> I'm thinking we would need standard sysfs files for configuring the QEP
> into single-shot QEP mode or buffered Capture mode, configure thresholds
> and other details.

Hi Felipe,

Fairly recently, similar concerns that IIO didn't really suite these
devices lead William to create a specific 'counters' subsystem.
+CC William.

It may not address all of your requirements yet, but I would imagine it
is a better fit than IIO would ever be.  We have moved all the older
counter drivers out of IIO and across to this new subsystem.

Thanks,

Jonathan


> 
> Cheers
> 
> Felipe Balbi (1):
>   misc: introduce intel QEP
> 
>  drivers/misc/Kconfig     |   7 +
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/intel-qep.c | 813 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 821 insertions(+)
>  create mode 100644 drivers/misc/intel-qep.c
> 

