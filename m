Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA339A8FA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhFCRTE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 13:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232694AbhFCRRZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 13:17:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C8A96108E;
        Thu,  3 Jun 2021 17:12:08 +0000 (UTC)
Date:   Thu, 3 Jun 2021 18:13:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: bma180: Add missing 500 Hz / 1000 Hz
 bandwidth
Message-ID: <20210603181351.3bfba96b@jic23-huawei>
In-Reply-To: <CACRpkdbT25_MXtJd02g_8JuD-29Heg_CMwRP2ROoRuXjRUGAKQ@mail.gmail.com>
References: <20210526094408.34298-1-stephan@gerhold.net>
        <20210526094408.34298-3-stephan@gerhold.net>
        <CACRpkdbT25_MXtJd02g_8JuD-29Heg_CMwRP2ROoRuXjRUGAKQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 May 2021 14:12:44 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Wed, May 26, 2021 at 11:44 AM Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > According to the BMA253 datasheet [1] and BMA250 datasheet [2] BMA25x
> > also supports a bandwidth of 500 Hz and 1000 Hz but this was not listed
> > in the driver for some reason.
> >
> > Add it to the bw_table to make the driver match the datasheet.
> >
> > [1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bma253-ds000.pdf
> > [2]: https://datasheet.octopart.com/BMA250-Bosch-datasheet-15540103.pdf
> >
> > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
and any friends to play with.

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

