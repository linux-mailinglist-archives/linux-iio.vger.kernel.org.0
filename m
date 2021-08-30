Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41C3FB426
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhH3K4I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 06:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235818AbhH3K4I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 06:56:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C6B610FD;
        Mon, 30 Aug 2021 10:55:12 +0000 (UTC)
Date:   Mon, 30 Aug 2021 11:58:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in
 rzg2l_adc_pm_runtime_resume()
Message-ID: <20210830115822.759f4bba@jic23-huawei>
In-Reply-To: <CAHp75Vdim8S5kMZY1DYSMM-gLbPHoqRcEMD-rcZ1sm9hPeTaOw@mail.gmail.com>
References: <20210819132416.175644-1-yangyingliang@huawei.com>
        <CAHp75Vd22aP098s9iXCGmBG505dW1vmZgvy3h9NoNA=J-eQ-CQ@mail.gmail.com>
        <9b848f1c-9acd-243e-2c5b-d489d2427464@huawei.com>
        <CAHp75Vdim8S5kMZY1DYSMM-gLbPHoqRcEMD-rcZ1sm9hPeTaOw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Aug 2021 12:17:46 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 20, 2021 at 4:52 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> > On 2021/8/20 1:20, Andy Shevchenko wrote:  
> > > On Thu, Aug 19, 2021 at 4:19 PM Yang Yingliang <yangyingliang@huawei.com> wrote:  
> > >> Add clk_disable_unprepare() on error path in rzg2l_adc_pm_runtime_resume().  
> > > ...
> > >  
> > >>          ret = clk_prepare_enable(adc->adclk);
> > >> -       if (ret)
> > >> +       if (ret) {
> > >> +               clk_disable_unprepare(adc->pclk);
> > >>                  return ret;
> > >> +       }  
> > > Huh?!  
> > The pclk need be disabled, when enable adclk failed.
> >        ^                                                         ^^  
> 
> Indeed. I'm wondering if those clocks behave like a bulk or any
> combination is possible on a working case?

They are handled independently in other parts of the driver, so bulk
setting is going to be a mess.

> 

