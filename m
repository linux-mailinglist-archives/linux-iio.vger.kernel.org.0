Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099A632FC33
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 18:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFRRG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 12:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCFRQ3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 12:16:29 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C8C64FE8;
        Sat,  6 Mar 2021 17:16:26 +0000 (UTC)
Date:   Sat, 6 Mar 2021 17:16:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix error handling in
 mpu3050_trigger_handler
Message-ID: <20210306171623.41a9e664@archlinux>
In-Reply-To: <CACRpkdZMrQNncocSdqQXbFCdTB9N=PuoNSvW5sU_DLZ8Es0feg@mail.gmail.com>
References: <20210301080421.13436-1-dinghao.liu@zju.edu.cn>
        <CACRpkdZMrQNncocSdqQXbFCdTB9N=PuoNSvW5sU_DLZ8Es0feg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Mar 2021 16:45:10 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Mar 1, 2021 at 9:04 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> 
> > There is one regmap_bulk_read() call in mpu3050_trigger_handler
> > that we have caught its return value bug lack further handling.
> > Check and terminate the execution flow just like the other three
> > regmap_bulk_read() calls in this function.
> >
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>  
> 
> OK that makes sense.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Applied with a fixes tag (it goes all the way back) and marked
for stable.

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

