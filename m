Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF00322DF20
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGZMqR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 08:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGZMqR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:46:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA6E2076A;
        Sun, 26 Jul 2020 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595767576;
        bh=FI/9nCBY/E5Ixrb7yl4SCIjDKbdKdR6Lkz97qpX4NqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fNXKd+bN7yEgi5T+MYwxCkO4OfJhMZ8tdSwJXH6zCbe6tfMi6PrDhlWXxcfUqxPsv
         limpYOeYJ9lvrsOsqTp975/fRuJrj/wepoQ83XpmG7mroE7SsQpOWoWuGrZpznKSfz
         6w5+taCgOqvaFNmOSzps0v8x8och5LcDEvvqmZR0=
Date:   Sun, 26 Jul 2020 13:46:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: gyro: Add driver support for ADXRS290
Message-ID: <20200726134613.6c483a81@archlinux>
In-Reply-To: <91b82340-832c-6e02-c595-613322926337@gmail.com>
References: <20200715092757.14563-1-nish.malpani25@gmail.com>
        <e369f36c-ec9e-0f90-674f-06c7d51d8b5e@gmail.com>
        <20200720121315.38500910@archlinux>
        <91b82340-832c-6e02-c595-613322926337@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 00:25:48 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Hello Jonathan,
> 
> Thanks a lot for the detailed review. Comments inline...
> 
...
> 
> >>> +#define ADXRS290_REG_SN0	0x04 /* Serial Number Registers, 4 bytes */
> >>> +#define ADXRS290_REG_DATAX0	0x08 /* Roll Rate o/p Data Regs, 2 bytes */
> >>> +#define ADXRS290_REG_DATAY0	0x0A /* Pitch Rate o/p Data Regs, 2 bytes */  
> > 
> > Are we actually right to map roll and pitch to x and y?
> > If so we should probably add that to the docs somewhere.  We need to document
> > which one maps to x and which to y as that mapping is far from obvious!
> >   
> "The ADXRS290 is an x-axis and y-axis rate sensing device that
> is also called a roll and pitch rate sensing device" (datasheet pg. 4). 
> I think I'm right in marking the DATA X-axis register as the roll rate 
> and similarly the DATA Y-axis register as the pitch rate.
> 
> Also, I thought it is a known convention to use x for roll, y for pitch, 
> etc. [2]. But you're right, its not very obvious. Where do I document it?
> 
> [2] https://en.wikipedia.org/wiki/Aircraft_principal_axes#Principal_axes

Documentation/ABI/testing/sysfs-bus-iio


Thanks,

Jonathan

