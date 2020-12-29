Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316FC2E7302
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 19:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgL2SbL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 13:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2SbL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 13:31:11 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 894E620867;
        Tue, 29 Dec 2020 18:30:29 +0000 (UTC)
Date:   Tue, 29 Dec 2020 18:30:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 2/2] iio: gyro: bmg160: Add rudimentary regulator
 support
Message-ID: <20201229183026.7e5a1d4f@archlinux>
In-Reply-To: <CACRpkdbEqN95-bYHjo7JEbSrGx9qHNoeW2wHC6KPvwn0sG7isg@mail.gmail.com>
References: <20201211183815.51269-1-stephan@gerhold.net>
        <20201211183815.51269-2-stephan@gerhold.net>
        <CACRpkdbEqN95-bYHjo7JEbSrGx9qHNoeW2wHC6KPvwn0sG7isg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Dec 2020 09:57:06 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Dec 11, 2020 at 7:39 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > BMG160 needs VDD and VDDIO regulators that might need to be explicitly
> > enabled. Add some rudimentary support to obtain and enable these
> > regulators during probe() and disable them using a devm action.
> >
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> > Changes in v2:
> >   - Do regulator_bulk_enable() immediately after devm_regulator_bulk_get()
> >   - Simplify error handling using devm_add_action_or_reset()  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Series applied,

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

