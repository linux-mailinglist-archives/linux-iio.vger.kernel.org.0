Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F31D62B1
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEPQlh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 12:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPQlh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 12:41:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 366BF206D4;
        Sat, 16 May 2020 16:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589647296;
        bh=m15GOjsqCZofcghjojCOp4k6ouOZrB8isgLzQNxlHj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wDxJm9t8Vn27UnYuSNPeGIqagzJQClNr8RuLFcCeD1438bMduIqkBO0ztmfv3pzom
         CFBBdNJ3lgmqZaaLtykjOD8VoE1TvC3DVIWBrcURWVrcl5qRci6eMpEsSE/6Jj0pmy
         JqYatbBk/pCvrzHoj494xO++ZHCwrgwykntr82/I=
Date:   Sat, 16 May 2020 17:41:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v14 0/2] iio: proximity: driver for vcnl3020
Message-ID: <20200516174119.4b8d0137@archlinux>
In-Reply-To: <20200510184537.10335-1-i.mikhaylov@yadro.com>
References: <20200510184537.10335-1-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 May 2020 21:45:35 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Add proximity sensor driver for Vishay vcnl3020. Only on-demand
> measurement is supported for now.
Hi Ivan,

Great and thanks for your persistence on this driver!
All looks good to me.

I will give time or a dt-bindings review as so far only
Rob's bot as commented.  The look fine to me but as Rob
can certify I'm not very good at reviewing those things!

Thanks,

Jonathan

> 
> Changes from v13:
>    1. description change for LED current.
> 
> Changes from v12:
>    1. forgot to change path inside yaml.
> 
> Changes from v11:
>    1. minor changes to yaml.
> 
> Changes from v10:
>    1. add vcnl3020_property struct for optional properties.
> 
> Changes from v9:
>    1. minor changes.
>    2. pass microamps from dts, not register value.
> 
> Changes from v8:
>    1. add vcnl3020 prefix into get_and_apply_property function.
>    2. add bsd license into yaml.
>    3. vishay,led-current-milliamp -> vishay,led-current-microamp.
>    4. add default value into vishay,led-current-microamp and change
>       register values into microamps.
> 
> Changes from v7:
>    1. forgot to add Reviewed-by tag.
> 
> Changes from v6:
>    1. minor changes
>      1.1 remove VCNL_DRV_NAME
>      1.2 add braces in get_and_apply_property
> 
> Changes from v5:
>    1. add get_and_apply_property function for optional parameters.
>    2. minor changes.
> 
> Changes from v4:
>    1. add vdd-supply,vddio-supply,interrupts properties into yaml.
>    2. led-current -> vishay,led-current-milliamp in yaml.
>    3. add possible values enum list.
>    4. add bulk_read for result hi/lo registers.
>    5. add description of vcnl3020_data structure.
>    6. vcnl3020 id table is removed.
>    7. make "vishay,led-current-milliamp" optional in yaml and code.
> 
> Changes from v3:
>    1. minor changes.
>    2. add i2c block to fix dts section in yaml.
> 
> Changes from v2:
>    1. using regmap_read_poll_timeout instead of do-while in measurement
>       function.
>    2. change struct i2client* in vcnl3020_data to struct dev*
>    3. enable REGMAP_I2C in Kconfig
> 
> Changes from v1:
>    1. using regmap interface instead of i2c_smbus_* calls.
>    2. switch from probe to probe_new.
>    3. s32/int32_t -> int
> 
> Ivan Mikhaylov (2):
>   dt-bindings: proximity: provide vcnl3020 device tree binding document
>   iio: proximity: Add driver support for vcnl3020 proximity sensor
> 
>  .../iio/proximity/vishay,vcnl3020.yaml        |  62 +++++
>  drivers/iio/proximity/Kconfig                 |  11 +
>  drivers/iio/proximity/Makefile                |   1 +
>  drivers/iio/proximity/vcnl3020.c              | 258 ++++++++++++++++++
>  4 files changed, 332 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
>  create mode 100644 drivers/iio/proximity/vcnl3020.c
> 

