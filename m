Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4B1E9805
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgEaOAF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgEaOAF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:00:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C0E20723;
        Sun, 31 May 2020 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590933605;
        bh=nm262quWmD0DcxBgdTM4rIOmm1pxgL6odqNjGb98nWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gOV+2f4FhYq9WkWYultbMsyn5xrcsdnj2+zH9pSZGMDHnn413ieBz3LpMGwif/LLb
         cVt722flsxqBt7rVj9gBEUBQJcINOtWLSUqm57fc5F30euCFaeNR+GRlbnTBzZt5sw
         awt4WYYKKsHnnK6yAWLQdjfLM5rfHJFDrpujZjh8=
Date:   Sun, 31 May 2020 15:00:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Kangjie Lu <kjlu@umn.edu>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] iio: magnetometer: ak8974: Fix runtime PM
 imbalance on error
Message-ID: <20200531150000.20d1ec61@archlinux>
In-Reply-To: <CACRpkdZi=UaGES_bupj_fQB+sPj5zOvONdCn7_Rs_j9mcukAAQ@mail.gmail.com>
References: <20200526104717.3181-1-dinghao.liu@zju.edu.cn>
        <CACRpkdZi=UaGES_bupj_fQB+sPj5zOvONdCn7_Rs_j9mcukAAQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020 13:13:56 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, May 26, 2020 at 12:47 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> 
> > When devm_regmap_init_i2c() returns an error code, a pairing
> > runtime PM usage counter decrement is needed to keep the
> > counter balanced. For error paths after ak8974_set_power(),
> > ak8974_detect() and ak8974_reset(), things are the same.
> >
> > However, When iio_triggered_buffer_setup() returns an error
> > code, there will be two PM usgae counter decrements.
> >
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > ---
> >
> > Changelog:
> >
> > v2: - Change 3 goto targets from "power_off" to
> >       "disabel_pm". Remove unused lable "power_off".
> >       Move 3 PM runtime related calls to the end of
> >       the function.  
> 
> Thanks for fixing this Dinghao!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Could I have a fixes tag for this one?

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

