Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2631E430883
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbhJQLyd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 07:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236245AbhJQLya (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:54:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E70F60527;
        Sun, 17 Oct 2021 11:52:19 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:56:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] iio: light: cm3605: Make use of the helper
 function dev_err_probe()
Message-ID: <20211017125633.0832bcd4@jic23-huawei>
In-Reply-To: <CACRpkdY0uM4BNapd7XNUhZ5U0sGdP3hu5Tr+dM1jigg5vQ+KDw@mail.gmail.com>
References: <20211008092656.421-1-caihuoqing@baidu.com>
        <CACRpkdY0uM4BNapd7XNUhZ5U0sGdP3hu5Tr+dM1jigg5vQ+KDw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Oct 2021 01:45:47 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Oct 8, 2021 at 11:27 AM Cai Huoqing <caihuoqing@baidu.com> wrote:
> 
> > When possible use dev_err_probe help to properly deal with the
> > PROBE_DEFER error, the benefit is that DEFER issue will be logged
> > in the devices_deferred debugfs file.
> > Using dev_err_probe() can reduce code size, and the error value
> > gets printed.
> >
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > ---
> > v2->v3:
> >         *Handle platform_get_irq() that returns -EPROBE_DEFER.
> >         *Handle the lack of availability of an IIO channel
> >          by converting an -ENODEV to an -EPROBE_DEFER.  
> 
> This looks good to me!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

Patches 1 and 3 applied (2 and 4 were applied at v2).

Thanks,

Jonathan
