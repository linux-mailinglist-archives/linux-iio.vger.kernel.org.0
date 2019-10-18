Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A61DC5F2
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410277AbfJRNYs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 09:24:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729109AbfJRNYs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 09:24:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5B62C30637865E3D5328;
        Fri, 18 Oct 2019 21:24:46 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 18 Oct 2019
 21:24:43 +0800
Date:   Fri, 18 Oct 2019 14:24:33 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rob Herring" <robh@kernel.org>, <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 5/7 v4] mfd: ab8500: augment DT bindings
Message-ID: <20191018142433.00002a86@huawei.com>
In-Reply-To: <CACRpkdZBWK5BHi7TcPVrF1j3Fg4CgeMxLisn2JB-mPPA+uKS7w@mail.gmail.com>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
        <20191011071805.5554-6-linus.walleij@linaro.org>
        <20191011134449.GA12969@bogus>
        <20191017222238.673cd60b@archlinux>
        <20191018072959.GS4365@dell>
        <CACRpkdZBWK5BHi7TcPVrF1j3Fg4CgeMxLisn2JB-mPPA+uKS7w@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Oct 2019 09:48:49 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Oct 18, 2019 at 9:30 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 17 Oct 2019, Jonathan Cameron wrote:  
> 
> > Can you change the subject line to start with an uppercase char.
> >
> > Else my OCD sense will go into overdrive! ;)  
> 
> Jonathan: it's fine to rebase the immutable branch for this as long as no-one
> has pulled it in I suppose.

True enough.  I'll check the obvious branches and hope nothing else
gets through!

Jonathan


> 
> Working on a binding example cleanup.
> 
> Yours,
> Linus Walleij


