Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41ADE67FB6
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfGNPQj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 11:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfGNPQj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 11:16:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF0002063F;
        Sun, 14 Jul 2019 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563117398;
        bh=8owtwbOXDhSNOLpkUWG4AA5Gq1qm1dqxVlDBbMwc+RU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1d9SPkaThpiSl6zzEJprMjjexJA4ggg2NOxSc6BLX8YE9PN30YF7g7w81YAMuyjwN
         ervqGUcWEdlWeousVzq6oxHPFdQYrjTFnJBhmzh+lvSxL5q3mkRqGRVVZMaRNg+rWy
         LzKKzXKT97REEjdUSTlbHm/5kHh36/AVlGMGMfx4=
Date:   Sun, 14 Jul 2019 16:16:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bobby Jones <rjones@gateworks.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: FXOS8700 Accelerometer/Magnetometer Support
Message-ID: <20190714161623.0127bbcb@archlinux>
In-Reply-To: <CALAE=UBN7ZPGTHB_jgSje0zG3mCvE8auW1FTrbjn=KbJzN_How@mail.gmail.com>
References: <CALAE=UBN7ZPGTHB_jgSje0zG3mCvE8auW1FTrbjn=KbJzN_How@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Jul 2019 15:48:29 -0700
Bobby Jones <rjones@gateworks.com> wrote:

> Hello linux-iio,
> 
> I'm interested in adding support for the FXOS8700 accel/mag device. I
> was curious if there had already been an effort in mainline to add
> support and could not find anything in the latest pulled version of
> the testing branch. However looking at the list archive I saw an email
> back in 2015 from Utkarsh who asked about implementing a driver for
> the same device [https://marc.info/?l=linux-iio&m=142920413702776]. My
> question for Utkarsh (if you're still reading this, I get a bounce on
> your address) and the greater linux-iio mailing list is if there had
> been any further effort since then that I can help finish?
> 
> Otherwise as someone new to driver development in general, I'm looking
> for any advice to get me started. I did see a NXP aka Freescale driver
> [https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/misc/fxos8700.c?h=imx_4.19.35_1.0.0]
> for the device but it doesn't appear to follow the iio api from what I
> can tell. Is it worth taking that driver and trying to get it to fit
> into the IMU api or should I start from scratch?
I would certainly start by seeing if that driver works to at least
some extent as it can be extremely handy to have a working reference.

Then it's up to you on how you prefer to work. Either you can take that
code and modify it step by step until you get something you are happy
with, or start from scratch keeping that as an additional source of
information only.

It's a fair way away from where it needs to end up, so starting from
scratch might be more efficient in this case.  Start simple and build
up the fancy features later.  From the reply I sent to that original
thread you reference I gather this is a complex device, so we may want
to have a reasonably feature complete driver to figure out if the
overall structure will work before we merge it.

Good luck and looking forward to seeing the code!

Thanks,

Jonathan

> 
> Thanks,
> Bobby Jones

