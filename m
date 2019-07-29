Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE00178D2F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfG2NvP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 09:51:15 -0400
Received: from onstation.org ([52.200.56.107]:35686 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfG2NvO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jul 2019 09:51:14 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id EC8B83E910;
        Mon, 29 Jul 2019 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564408274;
        bh=89xXheC+LLFYyAGIZ9A+v7CcZyeg5IL9Z5vUpZcHPb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbsI0aGkwYytIrBOPD/CK+DXISYKi28m6BHuin/ZTIMgn3x17Vakg34uk1Wx0bumG
         K6AhnmXln3A7avFH4ZPkG2sIJBeVqWBfdw3u+IvSGH2HhCJ+49kmuUKSCQ4gzCwUzt
         quVBmys2OrnS790WbkkIQ9oMPDLtyjWRNLbG1pKU=
Date:   Mon, 29 Jul 2019 09:51:13 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2772: Use device-managed API
Message-ID: <20190729135113.GA3049@onstation.org>
References: <20190726123058.22915-1-hslester96@gmail.com>
 <20190727125749.63297c28@archlinux>
 <20190728083141.GA14194@onstation.org>
 <CANhBUQ3QiV1mPD6p+AROv6YnK+1CB5voVAHKbmzueUWc7P6vcQ@mail.gmail.com>
 <20190729080307.GA360@onstation.org>
 <20190729120802.000025e8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729120802.000025e8@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 29, 2019 at 12:08:02PM +0100, Jonathan Cameron wrote:
> On Mon, 29 Jul 2019 04:03:07 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> > There are devm_regulator_*() variants of the regulator API available
> > that you can use. Lots of other APIs in the kernel have devm variants
> > to simply drivers.
> I don't think there are any devm_ versions of regulator disable.
> 
> IIRC the argument made when this last came up was that it was rarely correct
> to be as course grained as a lot of IIO drivers are.   We should probably
> do runtime pm and turn these regulators off a lot more frequently.
> 
> The reality is that it is an optimization that doesn't get done in 
> IIO drivers that often as we mostly just want them to work and many
> usecases aren't actually power constrained,
> 
> So we end up doing a lot of devm_add_action_or_reset to power down the
> regulators.

That makes sense. I have an out-of-tree patch where I started to add
runtime pm support to the tsl2772 driver around the time I was working
on the staging cleanup. I was unsure of how to do this when the user
configures an interrupt threshold via sysfs since we don't want to
completely power off the chip in that case. At the time, I couldn't
find any other examples in IIO that showed how to do that. I should
dust off that patch and send it out as a RFC to get some feedback.

Brian
