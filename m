Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F6D3713C5
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhECKuc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 06:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhECKua (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 May 2021 06:50:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4153610A5;
        Mon,  3 May 2021 10:49:35 +0000 (UTC)
Date:   Mon, 3 May 2021 11:50:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v3 0/3] iio: sps30: add support for serial interface
Message-ID: <20210503115026.06ee3d04@jic23-huawei>
In-Reply-To: <20210503060014.7632-1-tomasz.duszynski@octakon.com>
References: <20210503060014.7632-1-tomasz.duszynski@octakon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 May 2021 08:00:11 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> One can communicate with sensor either over i2c or serial interface.
> This series add support for the latter. And in order to do that existing
> codebase needs to be separated into core and interface specific
> components.

I've taken the view the dt binding change is trivial enough I don't 'need'
to wait for Rob to take a look (though of course any comments are welcome!)

As such, I've applied the series to the togreg branch of iio.git and pushed
it out as testing for the autobuilders to see if we missed anything.

Thanks,

Jonathan

> 
> v3:
> - add i2c device matching based on id table
> - constify structure
> - rephrase comment regarding reading serial number
> - check serial number length
> 
> v2:
> - simplify Kconfig by hiding core component selection
> - export symbols as GPL compatible
> - drop excessive ops wrappers
> - rework ops to use __be32
> - rework polling for measurements, sensor produces measurements within
>   1s so instead of polling just wait 1s
> - simplify frame ready condition (serial)
> - don't mix char with unsigned version
> - calculate checksum during frame validation (serial)
> - uncomment return status in frame validation (serial)
> - pass part name to probe instead of KBUILD_MODNAME
> 
> Tomasz Duszynski (3):
>   iio: sps30: separate core and interface specific code
>   iio: sps30: add support for serial interface
>   dt-bindings: iio: chemical: sps30: update binding with serial example
> 
>  .../iio/chemical/sensirion,sps30.yaml         |   7 +-
>  MAINTAINERS                                   |   2 +
>  drivers/iio/chemical/Kconfig                  |  27 +-
>  drivers/iio/chemical/Makefile                 |   2 +
>  drivers/iio/chemical/sps30.c                  | 269 ++---------
>  drivers/iio/chemical/sps30.h                  |  35 ++
>  drivers/iio/chemical/sps30_i2c.c              | 258 +++++++++++
>  drivers/iio/chemical/sps30_serial.c           | 431 ++++++++++++++++++
>  8 files changed, 804 insertions(+), 227 deletions(-)
>  create mode 100644 drivers/iio/chemical/sps30.h
>  create mode 100644 drivers/iio/chemical/sps30_i2c.c
>  create mode 100644 drivers/iio/chemical/sps30_serial.c
> 
> --
> 2.31.1
> 

