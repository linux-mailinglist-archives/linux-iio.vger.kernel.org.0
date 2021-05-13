Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE15037FBA7
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhEMQke (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232279AbhEMQkI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:40:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DACE6143B;
        Thu, 13 May 2021 16:38:29 +0000 (UTC)
Date:   Thu, 13 May 2021 17:39:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 03/28] iio: light: tsl2583: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210513173937.75a1dcf7@jic23-huawei>
In-Reply-To: <20210510104601.GB296@onstation.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-4-jic23@kernel.org>
        <20210510104601.GB296@onstation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 May 2021 06:46:01 -0400
Brian Masney <masneyb@onstation.org> wrote:

> On Sun, May 09, 2021 at 12:33:29PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Error paths in read_raw() and write_raw() callbacks failed to perform and
> > type of runtime pm put().  Remove called pm_runtime_put_noidle()
> > but there is no equivalent get (this is safe because the reference
> > count is protected against going below zero, but it is misleading.
> > 
> > Whilst here use pm_runtime_resume_and_get() to replace boilerplate.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Brian Masney <masneyb@onstation.org>  
> 
> Reviewed-by: Brian Masney <masneyb@onstation.org>
> 
Applied.  Thanks,

Jonathan
