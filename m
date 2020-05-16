Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7CD1D62A7
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEPQek (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 12:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgEPQek (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 12:34:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F5C20767;
        Sat, 16 May 2020 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589646880;
        bh=8VsOCTUyZDLwAQDe0mi00nKcnUzxLfUqS+uzovdK438=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=banzCGF/7ZSvWB96XaYeoOiTks4i/l2cqf3zeHhsa9JyFdKKfd3VD18iiVxuwW4sy
         2qN8iLXxKABcxiuaw1Ec363iLPZL96xvyr+Eae76DppxX9SwQ7c1PEet5cRJYDK0wB
         eJDytC8+EHLDasQ9FYRfaXEYSFR68ORGNu6XRM+s=
Date:   Sat, 16 May 2020 17:34:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: light: gp2ap002: Take runtime PM reference on
 light read
Message-ID: <20200516173435.674019bd@archlinux>
In-Reply-To: <CACRpkdZ-uuzjbHz9oXwjkTBO5ss1KcBN2Vth6N6h32zmgYhAUA@mail.gmail.com>
References: <BN6PR04MB0660DD24B7B4418DCC2806FBA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
        <BN6PR04MB066041D27D2A70B6B00C4751A3A00@BN6PR04MB0660.namprd04.prod.outlook.com>
        <CACRpkdZ-uuzjbHz9oXwjkTBO5ss1KcBN2Vth6N6h32zmgYhAUA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 May 2020 11:03:22 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, May 10, 2020 at 5:58 PM Jonathan Bakker <xc-racer2@live.ca> wrote:
> 
> > The light sensor needs the regulators to be enabled which means
> > the runtime PM needs to be on.  This only happened when the
> > proximity part of the chip was enabled.
> >
> > As fallout from this change, only report changes to the prox
> > state in the interrupt handler when it is explicitly enabled.
> >
> > Fixes: 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F")
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Sorry for missing this!
> 
> Yours,
> Linus Walleij
Applied to the fixes-togreg branch of iio.git. 

Thanks,

Jonathan


