Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC8F3FAD68
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 19:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhH2RMN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 29 Aug 2021 13:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhH2RMN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 13:12:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D90060F38;
        Sun, 29 Aug 2021 17:11:17 +0000 (UTC)
Date:   Sun, 29 Aug 2021 18:14:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        angelo.compagnucci@gmail.com,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc128s052: Fix the error handling path of
 'adc128_probe()'
Message-ID: <20210829181431.67a52d36@jic23-huawei>
In-Reply-To: <f33069f0-601b-4bbb-3766-026f7a161912@wanadoo.fr>
References: <85189f1cfcf6f5f7b42d8730966f2a074b07b5f5.1629542160.git.christophe.jaillet@wanadoo.fr>
        <CA+U=DsoTdb3b+LJEtUagKr=LmK8E2M_2yhtNDENKsczqGaUPYA@mail.gmail.com>
        <f33069f0-601b-4bbb-3766-026f7a161912@wanadoo.fr>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 21:45:38 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 23/08/2021 à 08:42, Alexandru Ardelean a écrit :
> > On Sat, Aug 21, 2021 at 1:43 PM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:  
> >>
> >> A successful 'regulator_enable()' call should be balanced by a
> >> corresponding 'regulator_disable()' call in the error handling path of the
> >> probe, as already done in the remove function.
> >>
> >> Update the error handling path accordingly.  
> > 
> > Good catch.
> > For the fix:
> > 
> > Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Applied and marked for stable.

Thanks,
> > 
> > If you want, you can also send a conversion to
> > devm_iio_device_register() for this driver.
> > And also move the regulator_disable() on a devm_add_action_or_reset() callback.
> > Maybe, that's already part of your plan. If so, apologies for the noise :)
> >   
> 
> Hi,
> 
> I hadn't planned another step but I can send a follow-up patch for that.
> 
> CJ

Note I'll have to sit on that one until this patch is upstream which will be a few weeks
(perhaps a month) given timing.

Jonathan
