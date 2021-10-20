Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBDC435485
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 22:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJTUZl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 16:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhJTUZk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Oct 2021 16:25:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB74611B0;
        Wed, 20 Oct 2021 20:23:23 +0000 (UTC)
Date:   Wed, 20 Oct 2021 21:27:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, kernel@axis.com,
        linux-iio@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mux: fix kernel doc prototype
Message-ID: <20211020212741.4855df03@jic23-huawei>
In-Reply-To: <f8282455-9d8c-31ad-f722-6a59c6d97d20@axentia.se>
References: <20211019064521.18113-1-vincent.whitchurch@axis.com>
        <f8282455-9d8c-31ad-f722-6a59c6d97d20@axentia.se>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Oct 2021 09:17:07 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2021-10-19 08:45, Vincent Whitchurch wrote:
> > Fix this warning from scripts/kernel-doc:
> > 
> >  drivers/mux/core.c:391: warning: expecting prototype for
> >  mux_control_try_select(). Prototype was for
> >  mux_control_try_select_delay() instead
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>  
> 
> Obviously. Or, just squash it if that's still an option?
Folded into original commit.

Thanks,

Jonathan

> 
> In case it's easier to just pile it on top:
> 
> Acked-by: Peter Rosin <peda@axentia.se>
> 
> Cheers,
> Peter

