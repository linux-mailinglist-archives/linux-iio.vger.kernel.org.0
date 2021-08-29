Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62363FACBD
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhH2Pp2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhH2Pp1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:45:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0CB60E94;
        Sun, 29 Aug 2021 15:44:32 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:47:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: gyro: remove dead config dependencies on
 INPUT_MPU3050
Message-ID: <20210829164748.710e3da6@jic23-huawei>
In-Reply-To: <CACRpkdaemTruXS3PTz3z_hpkvBYvi802dF6VBDq+fLEyxZStrQ@mail.gmail.com>
References: <20210817081330.9645-1-lukas.bulwahn@gmail.com>
        <CACRpkdaemTruXS3PTz3z_hpkvBYvi802dF6VBDq+fLEyxZStrQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Aug 2021 22:11:36 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Aug 17, 2021 at 10:13 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> 
> > Commit b1fe0cf06f92 ("Input: delete MPU3050 driver") deletes the superseded
> > MPU3050 driver and its corresponding config INPUT_MPU3050.
> >
> > The dependencies on the superseding driver in ./drivers/iio/gyro/Kconfig
> > to ensure that the two drivers are not built into the same kernel is a dead
> > dependency and not required anymore.
> >
> > So, remove those config dependencies on INPUT_MPU3050 for MPU3050_I2C.
> >
> > This issue was detected with ./scripts/checkkconfigsymbols.py.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>  
> 
> Oops my leftover.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

Applied,

Thanks,

