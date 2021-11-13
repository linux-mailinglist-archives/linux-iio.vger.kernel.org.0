Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC344F473
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 19:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhKMSPq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 13:15:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233656AbhKMSPq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 13:15:46 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C13660F46;
        Sat, 13 Nov 2021 18:12:51 +0000 (UTC)
Date:   Sat, 13 Nov 2021 18:17:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Add support for AD7293 Power Amplifier
Message-ID: <20211113181738.2ee8e043@jic23-huawei>
In-Reply-To: <20211105112930.122017-1-antoniu.miclaus@analog.com>
References: <20211105112930.122017-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 5 Nov 2021 13:29:27 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The AD7293 is a Power Amplifier drain current controller containing 
> functionality for general-purpose monitoring and control of 
> current, voltage, and temperature, integrated into a single chip 
> solution with an SPI-compatible interface.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD7293.pdf

Wrong cover letter.  This had me rather confused for a few moments as I had
two copies of this in my inbox with different patches underneath!
> 
> This series of patches provide an initial implementation of the
> driver with access from the userspace to the:
>  - ADC channels (read raw values, set range, set offset)
>  - DAC channels (set code, set offset)
>  - Temperature sensing (read raw values, set offset)
>  - Current sensing (read raw, set offset, set gain)
> 
> Antoniu Miclaus (2):
>   iio:amplifiers:ad7293: add support for AD7293
>   dt-bindings:iio:amplifiers: add ad7293 doc
> 
>  .../bindings/iio/amplifiers/adi,ad7293.yaml   |  49 ++
>  drivers/iio/amplifiers/Kconfig                |  11 +
>  drivers/iio/amplifiers/Makefile               |   1 +
>  drivers/iio/amplifiers/ad7293.c               | 794 ++++++++++++++++++
>  4 files changed, 855 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
>  create mode 100644 drivers/iio/amplifiers/ad7293.c
> 

