Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0E2D8EF2
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbgLMRFl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgLMRFl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 12:05:41 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B862313B;
        Sun, 13 Dec 2020 17:04:58 +0000 (UTC)
Date:   Sun, 13 Dec 2020 17:04:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] iio:pressure:ms5637: switch to probe_new
Message-ID: <20201213170453.2de3a963@archlinux>
In-Reply-To: <CAHp75Vc1HAndj0qPHFpW+-5Nikz+CqKwD9MWA0vWH3-FtXPvOA@mail.gmail.com>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
        <20201209234857.1521453-2-alexandre.belloni@bootlin.com>
        <CAHp75Vc1HAndj0qPHFpW+-5Nikz+CqKwD9MWA0vWH3-FtXPvOA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Dec 2020 15:26:17 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Dec 10, 2020 at 2:01 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Switch to the modern i2c probe_new callback and drop the i2c_device_id
> > array.  
> 
> First part is okay.
> The second is interesting. It depends if we would like to keep a
> possibility to instantiate devices from user space (strictly speaking
> it's an ABI breakage).
> 
We've also been bitten by this recently via greybus which does
it's instantiations using the i2c_device_id table as I understand it.
That's resulted in us reverting a few specific cases where we'd
done pretty much what you have done here.

So drop that part of the change.

Thanks,

Jonathan


