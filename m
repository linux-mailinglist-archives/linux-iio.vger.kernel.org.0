Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE61DCECA
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 20:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443030AbfJRS5K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 14:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfJRS5K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 14:57:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84DEB20640;
        Fri, 18 Oct 2019 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571425029;
        bh=+ob980viSySh1OP85GRtS49cUskaLYxYua0FB4wS6R4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BGSdthq0nKvHgb8gSKZ1rDHewKf4r5/rndFw+nZ4f8ivXEYKtdxajFWmH88uYlB6J
         FPScbqQV8+yBpaBx5q6YRbUDjtXVmy7auJF93FUY6h/qa8GaMm/60173EJ3rCOA61N
         lTlaEBSjDwJyswTiT4foKsG17WDG/TDrphvZ9u1w=
Date:   Fri, 18 Oct 2019 19:57:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: pressure: bmp280 endian tidy ups
Message-ID: <20191018195705.55171c78@archlinux>
In-Reply-To: <CACRpkdaW-UXaKcgWA0DpxF1QWhajDXwOYcZhUKztq9UY3mh5fA@mail.gmail.com>
References: <20191013101742.1454364-1-jic23@kernel.org>
        <CACRpkdaW-UXaKcgWA0DpxF1QWhajDXwOYcZhUKztq9UY3mh5fA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Oct 2019 14:20:29 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Oct 13, 2019 at 12:19 PM <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > There is a somewhat interesting mixture of be16 and le16 going on in
> > this one function.  Changes here formalize that a little more.
> >
> > CHECK   drivers/iio/pressure/bmp280-core.c
> > drivers/iio/pressure/bmp280-core.c:215:35: warning: cast to restricted __le16
> > drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
> > drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
> > drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
> > drivers/iio/pressure/bmp280-core.c:229:37: warning: cast to restricted __be16
> > drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
> > drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
> > drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
> > drivers/iio/pressure/bmp280-core.c:230:36: warning: cast to restricted __be16
> > drivers/iio/pressure/bmp280-core.c:237:37: warning: cast to restricted __le16
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
Applied.  Thanks,

Jonathan

> Yours,
> Linus Walleij

