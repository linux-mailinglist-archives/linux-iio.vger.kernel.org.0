Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8881A242760
	for <lists+linux-iio@lfdr.de>; Wed, 12 Aug 2020 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgHLJV7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Aug 2020 05:21:59 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbgHLJV6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 Aug 2020 05:21:58 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7F12D333062879BF5783;
        Wed, 12 Aug 2020 10:21:57 +0100 (IST)
Received: from localhost (10.52.122.74) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 12 Aug
 2020 10:21:57 +0100
Date:   Wed, 12 Aug 2020 10:20:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Daniel Palmer <daniel@0x0f.com>
CC:     <linux-iio@vger.kernel.org>, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [RFC PATCH 0/2] iio: st-accel: Add support for Silan clones
Message-ID: <20200812102029.000023d1@Huawei.com>
In-Reply-To: <20200811134846.3981475-1-daniel@0x0f.com>
References: <20200811134846.3981475-1-daniel@0x0f.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.74]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Aug 2020 22:48:44 +0900
Daniel Palmer <daniel@0x0f.com> wrote:

> This small series adds support for the Silan SC7A20 and SC7A30E
> accelerometers that seem to be clones or at least based on the
> LIS2DH from ST.
> 
> These chips seem to be widely used in car dash recorders and the
> midrived08 dash recorder that I'm trying to mainline support for
> has a SC7A20.
> 
> This is RFC because I'm not sure if adding clone chips into this
> driver is going to cause anyone trouble and I'm thinking there has
> to be a better way of supporting both of the chips that are basically
> the same but have different WAI register values than copy/pasting the
> block and changing the WAI value.

The different WAI value suggests to me that we might be looking at
something made under license, or manufactured for them by ST.

Anyhow, it's not unusual to have cloned parts supported by a common
kernel driver so that shouldn't be a problem.

Only thing to note is we can't necessarily expect Denis to be able
to review any changes to the driver that might affect these parts.

If Denis is willing, we could add an entry to MAINTAINERS for these
and add you as a reviewer so that you should get any future patches
sent to you as well.

Denis, what's your view on this, or can you shed any light on
these parts?


> 
> Daniel Palmer (2):
>   dt-bindings: vendor-prefixes: Add vendor prefix for Silan
>   iio: st-accel: Add support for Silan SC7A20 and SC7A30E
> 
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  drivers/iio/accel/st_accel.h                  |   4 +
>  drivers/iio/accel/st_accel_core.c             | 159 +++++++++++++++++-
>  drivers/iio/accel/st_accel_i2c.c              |  10 ++
>  4 files changed, 174 insertions(+), 1 deletion(-)
> 


