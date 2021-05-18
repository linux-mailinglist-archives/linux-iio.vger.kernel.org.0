Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7C5387EE5
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 19:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbhERRta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 13:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345469AbhERRt3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 13:49:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2E261154;
        Tue, 18 May 2021 17:48:07 +0000 (UTC)
Date:   Tue, 18 May 2021 18:49:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Robertson <dan@dlrobertson.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: Drop Duplicated "mount-matrix" parameter
Message-ID: <20210518184924.185b7b7c@jic23-huawei>
In-Reply-To: <66a1a5e2-181d-bcc6-b453-357fcfd5e5f1@geanix.com>
References: <20210518112546.44592-1-andriy.shevchenko@linux.intel.com>
        <66a1a5e2-181d-bcc6-b453-357fcfd5e5f1@geanix.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 May 2021 14:38:24 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 18/05/2021 13.25, Andy Shevchenko wrote:
> > All of the users of iio_read_mount_matrix() are using the very same
> > property name. Moreover, the property name is hard coded in the API
> > documentation.
> > 
> > Make this clear and avoid duplication now and in the future.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> > ---Good idea :)  

Agreed :)

Applied to the togreg branch of iio.git and pushed out as testing.
@Linus, if you happen to send an update of your series out that
doesn't take this into account I can fix up whilst applying.

Thanks,

Jonathan

