Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3F339F10
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhCMQOJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 11:14:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233570AbhCMQNl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 11:13:41 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E22264EF6;
        Sat, 13 Mar 2021 16:13:39 +0000 (UTC)
Date:   Sat, 13 Mar 2021 16:13:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        andriy.shevchenko@linux.intel.com, denis.ciocca@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com
Subject: Re: [PATCH V2 0/2] Add support for ST magnetometer IIS2MDC
Message-ID: <20210313161335.49bfb25c@archlinux>
In-Reply-To: <20210311030554.6428-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210311030554.6428-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Mar 2021 03:05:52 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Changes in V2:
> 
> Extend the exist st_magn* to support IIS2MDC, instead of adding a new
> driver.

Looks good to me.  Will let it sit on the list a little longer so
Denis and others can take a look if they wish.

If it looks like I've lost it in 2 weeks time feel free to poke me!

Thanks,

Jonathan

> 
> 
> LI Qingwu (2):
>   dt-bindings: iio: st,st-sensors add IIS2MDC.
>   iio:magnetometer: Add Support for ST IIS2MDC
> 
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
>  drivers/iio/magnetometer/st_magn.h                       | 2 ++
>  drivers/iio/magnetometer/st_magn_core.c                  | 1 +
>  drivers/iio/magnetometer/st_magn_i2c.c                   | 5 +++++
>  drivers/iio/magnetometer/st_magn_spi.c                   | 5 +++++
>  5 files changed, 14 insertions(+)
> 

