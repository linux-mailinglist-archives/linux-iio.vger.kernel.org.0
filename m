Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F14468C22
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhLEQqz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 11:46:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33650 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhLEQqy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 11:46:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47C0B6103E
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:43:27 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 9A8E5C341C5;
        Sun,  5 Dec 2021 16:43:24 +0000 (UTC)
Date:   Sun, 5 Dec 2021 16:48:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 12/12] iio:adc/dac:Kconfig: Update to drop OF
 dependencies.
Message-ID: <20211205164835.272d8cab@jic23-huawei>
In-Reply-To: <CAHp75Ve6TM2+-3eAx-QOBg0CjQ7A7VcHApPPpA8mkEZjbSAnRg@mail.gmail.com>
References: <20211204171237.2769210-1-jic23@kernel.org>
        <20211204171237.2769210-13-jic23@kernel.org>
        <CAHp75Ve6TM2+-3eAx-QOBg0CjQ7A7VcHApPPpA8mkEZjbSAnRg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Dec 2021 17:15:41 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Dec 4, 2021 at 7:08 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > We could probably drop a lot more of these, but for now this removes
> > unnecessary restrictions on stand alone ADC devices.  
> 
> Ah, I was expecting to see this on per driver conversion change.
> Is this simply dependencies which are not covered anyhow by the
> previous 11 patches in the series?
> 
Yup.  None of these dependencies should have been there even without
this series.

The ads8344 and ads8688 go all the way back to initial driver patches
and I can't see why they were ever needed. 

max5821 looks similar.

I've added a note to the patch description to make it clearer
what is going on in this patch.

Jonathan
