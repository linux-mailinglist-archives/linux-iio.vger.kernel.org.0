Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE5434CDDA
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 12:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhC2KUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 06:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232295AbhC2KUf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 06:20:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0DE861874;
        Mon, 29 Mar 2021 10:20:31 +0000 (UTC)
Date:   Mon, 29 Mar 2021 11:20:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Use as standalone trigger
Message-ID: <20210329112038.12369262@jic23-huawei>
In-Reply-To: <CACRpkdaLkMfsBDi-fp+6pN4SgaYjjRbH3o=0VFEF2jYG2wozyg@mail.gmail.com>
References: <20210322132408.1003443-1-linus.walleij@linaro.org>
        <BL0PR12MB501168E715C96BBDF34D1ACCC4629@BL0PR12MB5011.namprd12.prod.outlook.com>
        <CACRpkdaLkMfsBDi-fp+6pN4SgaYjjRbH3o=0VFEF2jYG2wozyg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 25 Mar 2021 20:36:20 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Mar 25, 2021 at 6:08 PM Jean-Baptiste Maneyrol
> <JManeyrol@invensense.com> wrote:
> 
> > Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> >
> > We're lucky this is working without any sensor running, it was not obvious.
> > On which chip have you tested that?  
> 
> This was tested on the Samsung GT-I8190 (Galaxy S III mini)
> mobile phone, I don't know which version of MPU6050 it is.

Applied to the togreg branch to iio.git.  I added a note that it
wasn't suitable for backporting. More than possible that will get
missed though, so lets keep our eyes open for anyone picking it up.

Unlikely to do much harm if we do miss it though.

Jonathan

> 
> Yours,
> Linus Walleij

