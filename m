Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C111A8A00
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504269AbgDNSo5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504270AbgDNSo4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:44:56 -0400
Received: from Mani-XPS-13-9360 (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4B52074D;
        Tue, 14 Apr 2020 18:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586889895;
        bh=oMbI+vt8Em625llNVbyJzSoSXiN6bAXE8KfBVvF18nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ol3Q/qI4y0XWlUteUtqOpWGcqR7/YGWZ9ZfgbJoqSr4yrE8Bygoxmnn1A3P7sDEHR
         TXLTgGKZ61VF+LiQ9V7ZN+38mnWW6nqYQ95r4CtJOaDOFRVSJXZ0uGGcJA0LWVS14Z
         cER7Yp7IfUb5Zn6hPYI91xCbt15M6MHy3ShTW2h8=
Date:   Wed, 15 Apr 2020 00:14:44 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 0/3] Add Reset and Wakeup support for CCS811
Message-ID: <20200414184444.GA5041@Mani-XPS-13-9360>
References: <20200414184147.4857-1-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414184147.4857-1-mani@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 15, 2020 at 12:11:44AM +0530, mani@kernel.org wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Hello,
> 
> This patchset adds external reset and wakeup support for CCS811 VOC
> gas sensor. The nRESET and nWAKE pins available on the device are
> utilised to provide these functionalities.
> 
> The patchset has been validated using CCS811 connected to STM32MP1 based
> board over I2C.
> 
> While at it, the devicetree yaml binding and OF match table for this sensor
> are also added.
> 
> Thanks,
> Mani
> 
> Changes in v3:
> 
> * Added ccs811_set_wake(false) to all error paths before calling it actually
> * Added Andy's reviewed-by tag
> * Added comment for reset procedure and dropped error print for gpio request
> 
> Changes in v2:
> 
> * Fixed DT binding schema and switched to dual license (GPL/BSD)
> * Returned actual error code from devm_gpiod_get_optional()
> * Dropped of.h include and of_match_ptr()
> 
> Manivannan Sadhasivam (3):
>   iio: chemical: Add support for external Reset and Wakeup in CCS811
>   iio: chemical: Add OF match table for CCS811 VOC sensor
>   dt-bindings: serial: Add binding for software flow control in STM32

Err... please ignore this series. I'll resend it.

Thanks,
Mani

>     UART
> 
>  .../bindings/serial/st,stm32-uart.yaml        |  15 ++-
>  drivers/iio/chemical/ccs811.c                 | 112 ++++++++++++++++--
>  2 files changed, 115 insertions(+), 12 deletions(-)
> 
> -- 
> 2.17.1
> 
