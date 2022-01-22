Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691BC496D86
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jan 2022 20:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiAVTH4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jan 2022 14:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiAVTHz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jan 2022 14:07:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D34C06173B
        for <linux-iio@vger.kernel.org>; Sat, 22 Jan 2022 11:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA86160E8F
        for <linux-iio@vger.kernel.org>; Sat, 22 Jan 2022 19:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC760C004E1;
        Sat, 22 Jan 2022 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642878474;
        bh=qz/XSsmq6dyVDD1/12oulEBz5kWq530icoJ5F1KDIAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q9XXS2VY15ZxwWLTiUCnmZtX5pojwbDOX/3VxupFUbAlIYMvfVzro4E2OTNbsXKW4
         gQvzWtD9/7qAHloLySuSO/mAcNHURVEcYs1SPeUFmJZ5mD7aGTaxCtT2W0ivpVxfg0
         8cQBmrvZwzCN5t10MVeZU/X8KfoH96z1uaMfqEsbV6MKhGYk7+VDtrhmV0lLud1zO/
         hzkztgSWYdK05UhPf4/A3mqezXngKmznUmo/uU5izAfGJazScNUk/ZUKXFb0EGw8yu
         IwBmFBvqzwveTqzfPfb+OHhW6R+7cOVfRP0mRK/Legd3AMn/2AB1BWBT3ngwSMA/HU
         jF1Q/GwihZksg==
Date:   Sat, 22 Jan 2022 19:14:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, jongpil19.jung@samsung.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: sx9360: enable push iio event
Message-ID: <20220122191403.22364523@jic23-huawei>
In-Reply-To: <CAHp75VcRFRVOPvgGROiNM4wQurTDn+D-DSc0oU1YsrgkkNOF6g@mail.gmail.com>
References: <20220118212504.832429-1-gwendal@chromium.org>
        <20220122172940.125d8033@jic23-huawei>
        <CAHp75VcRFRVOPvgGROiNM4wQurTDn+D-DSc0oU1YsrgkkNOF6g@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 Jan 2022 20:15:57 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Jan 22, 2022 at 7:23 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 18 Jan 2022 13:25:04 -0800
> > Gwendal Grignou <gwendal@chromium.org> wrote:  
> 
> ...
> 
> > > Fixes: f75095753 ("iio:proximity:sx9360: Add sx9360 support")  
> > This is part of the tag block so should appear.  
> 
> 
> > fixes tag should be here.  
> > > Signed-off-by: Jongpil Jung <jongpil19.jung@samsung.com>
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> 
> ...and the submitter's SoB must be last (according to the documentation).
> 
Hi Andy,

If it's a handling chain, rather that about co development etc then
I'd expect it to be in this order to indicate that Gwendal was on the
route to upstream. 

"Any further SoBs (Signed-off-by:'s) following the author's SoB are from
people handling and transporting the patch, but were not involved in its
development. SoB chains should reflect the **real** route a patch took
as it was propagated to the maintainers and ultimately to Linus, with
the first SoB entry signalling primary authorship of a single author."

Jonathan
