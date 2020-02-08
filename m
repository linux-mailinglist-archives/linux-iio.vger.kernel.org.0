Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75231564C1
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 15:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBHOYj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 09:24:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:46620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbgBHOYj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 09:24:39 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799B121775;
        Sat,  8 Feb 2020 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581171879;
        bh=yZS7rDA1lVLxvBQ/IIRaQnT1dkCWL6MTsHpAghdNl5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vCbMN70Rnrck2p7OPQHpDMjlUJBX/e91fCfSGRJvLqe7Tn7dq3JaNqsMDcOkEZg4J
         L6FjAIlmSLVJ9a8H8qJ2aPc6rmdXYkONOrQZoRIJrrhgT8xnP2TFUAMYbpgj5vUFS5
         /OZou4TqXsE+r6vhrC8m/33cOebPDcSyruQIvfO0=
Date:   Sat, 8 Feb 2020 14:24:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: dac: AD5770R: Add support
Message-ID: <20200208142435.1f64a863@archlinux>
In-Reply-To: <20200206092313.18265-1-alexandru.tachici@analog.com>
References: <20200206092313.18265-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Feb 2020 11:23:11 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This series of patches adds support for the AD5570R
> 14-bit current DAC.
> 
> It contains changes discussed in:
> https://patchwork.kernel.org/patch/10549129/

Should have been marked as v2 in the patch titles.

Jonathan

> 
> Alexandru Tachici (2):
>   iio: dac: ad5770r: Add AD5770R support
>   dt-bindings: iio: dac: Add docs for AD5770R DAC
> 
>  .../bindings/iio/dac/adi,ad5770r.yaml         | 176 +++++
>  drivers/iio/dac/Kconfig                       |  10 +
>  drivers/iio/dac/Makefile                      |   1 +
>  drivers/iio/dac/ad5770r.c                     | 662 ++++++++++++++++++
>  include/linux/iio/common/adi_spi_regs.h       |  44 ++
>  5 files changed, 893 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
>  create mode 100644 drivers/iio/dac/ad5770r.c
>  create mode 100644 include/linux/iio/common/adi_spi_regs.h
> 

