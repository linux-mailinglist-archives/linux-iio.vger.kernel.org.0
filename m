Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2C36A0A9
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhDXKqu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 24 Apr 2021 06:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhDXKqu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 06:46:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E4261554;
        Sat, 24 Apr 2021 10:46:09 +0000 (UTC)
Date:   Sat, 24 Apr 2021 11:46:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: gyro: mpu3050: Fix reported temperature value
Message-ID: <20210424114650.6abb21a0@jic23-huawei>
In-Reply-To: <edd85a7f-4c1f-9d2f-0425-93a6e45f13bb@gmail.com>
References: <20210423020959.5023-1-digetx@gmail.com>
        <BL0PR12MB5011563BCD5E11683D51F34EC4459@BL0PR12MB5011.namprd12.prod.outlook.com>
        <edd85a7f-4c1f-9d2f-0425-93a6e45f13bb@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 24 Apr 2021 07:58:08 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> 23.04.2021 13:14, Jean-Baptiste Maneyrol пишет:
> > Hello,
> > 
> > thanks for this work.
> > 
> > Temperature value should obviously be 16 bits signed, thanks for the fix. By looking at our internal datasheets, I can confirm the values for MPU-30x0 family (div by 280 and 23000 offset LSB).
> > 
> > I'm sorry I don't have access to these more than 1 decade old chips, so I cannot test on my side. But there is no reason it wouldn't be OK.
> > 
> > Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>  
> 
> Thank you very much for confirming that the equation is correct, very
> appreciate that.

Thanks. Applied to the fixes-togreg branch of iio.git.
Note these won't go upstream until after rc1 but hopefully will soon after
that.

Thanks for the detective work etc on this!

Jonathan
