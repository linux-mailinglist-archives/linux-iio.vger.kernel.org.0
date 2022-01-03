Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3CF483410
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jan 2022 16:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiACPTG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jan 2022 10:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiACPTF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jan 2022 10:19:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A00C061761
        for <linux-iio@vger.kernel.org>; Mon,  3 Jan 2022 07:19:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 643E2B80EFD
        for <linux-iio@vger.kernel.org>; Mon,  3 Jan 2022 15:19:04 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 010EEC36AED;
        Mon,  3 Jan 2022 15:19:00 +0000 (UTC)
Date:   Mon, 3 Jan 2022 15:24:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 01/51] iio:accel:da311: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr() etc
Message-ID: <20220103152444.0e22e971@jic23-huawei>
In-Reply-To: <CAK8P3a20AatvTxHEXfTpMWD8RJtLbJiTLbhiKJgQrn+KXYG8zw@mail.gmail.com>
References: <20220102125617.1259804-1-jic23@kernel.org>
        <20220102125617.1259804-2-jic23@kernel.org>
        <CAK8P3a20AatvTxHEXfTpMWD8RJtLbJiTLbhiKJgQrn+KXYG8zw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2 Jan 2022 09:15:06 -0500
Arnd Bergmann <arnd@arndb.de> wrote:

> On Sun, Jan 2, 2022 at 7:55 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > -static SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
> > +DEFINE_SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
> >  

Hi Arnd,

> 
> Does the new DEFINE_SIMPLE_DEV_PM_OPS imply 'static'? 

It does.

> I see that you remove
> the specifier in all the patches, which would not work otherwise, but
> I wonder what that
> means for drivers that actually define the pm-ops globally on purpose
> and can't do
> that any more after the conversion.

That came up in discussion of the patch series introducing this macro
https://lore.kernel.org/linux-pm/20211216110936.6ccd07d3@jic23-huawei/

Most of the cases that don't define it as static
also export the symbol for use by other modules so the approach of letting
the compiler detect it as dead code won't always work.

Exceptions from a bit of grepping are
net/ethernet/broadcom/bnx2x/
scsi/esas2r/esas2r_init.c
  not sure on reasoning behind the file splits in these drivers
  but definitely looks like it we could just merge a few files
  and let this be static + the compiler remove it neatly.

vs 17 cases where the symbol is exported and more cleverness will
be needed.

Jonathan

> 
>       Arnd

