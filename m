Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3305544F90D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 17:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhKNQgy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 11:36:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235895AbhKNQgs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 11:36:48 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E890D6109E;
        Sun, 14 Nov 2021 16:33:50 +0000 (UTC)
Date:   Sun, 14 Nov 2021 16:38:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 10/10] iio: imu: add BNO055 I2C driver
Message-ID: <20211114163838.41015ae2@jic23-huawei>
In-Reply-To: <CAN8YU5PjJ9e8_RuLpY0JgLek-+HwxOLJ61MAGBqqzbqd6KWuYA@mail.gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-11-andrea.merello@gmail.com>
        <20211028121001.73d8abbe@jic23-huawei>
        <CAN8YU5PjJ9e8_RuLpY0JgLek-+HwxOLJ61MAGBqqzbqd6KWuYA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Nov 2021 11:12:58 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Just an inline comment; OK for the rest.

> > > +#include <linux/i2c.h>  
> >
> > Why?  I'm not seeing an i2c specific calls in here.  
> 
> Because of the definition of struct i2c_client, that is being accessed
> in lines like this
> dev_err(&client->dev, "Unable to init register map");

doh. I was clearly being a bit unobservant that day.

