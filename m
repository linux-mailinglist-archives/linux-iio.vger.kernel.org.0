Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B529342D48
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 15:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhCTO2V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 10:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhCTO2I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 10:28:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A35161960;
        Sat, 20 Mar 2021 14:28:07 +0000 (UTC)
Date:   Sat, 20 Mar 2021 14:28:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] iio: kernel-doc fixups
Message-ID: <20210320142804.5cca0f10@jic23-huawei>
In-Reply-To: <c3872df0-fbc5-903f-8ab8-761c58c61808@metafoo.de>
References: <20210314164655.408461-1-jic23@kernel.org>
        <c3872df0-fbc5-903f-8ab8-761c58c61808@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 14 Mar 2021 18:32:17 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/14/21 5:46 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > A bunch of totally trivial kernel-doc fixes from W=1 builds.
> >
> > Note I've not touched staging drivers as those are a good activity for
> > anyone who wants to get started working with IIO drivers. I'll post
> > a specific email about that in a few minutes.  
> 
> All obviously correct.
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Thanks,

Series applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Transitioning to a new laptop, so if anything looks odd let me know.

Jonathan


