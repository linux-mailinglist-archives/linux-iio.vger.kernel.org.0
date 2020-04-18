Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538F21AF3CE
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgDRSxK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 14:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSxJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 14:53:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E66C21D93;
        Sat, 18 Apr 2020 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587235989;
        bh=6Z96Ro4J8eng7mjTKTrohKq7lCiEJvmaqF+1CM5f0AQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cKnWoTG0IkKW0ofQ9Nq4hVMgRQX9VSEZ+LazEa+NX1mTkCXFSVX+PKs/cSyVlm5lP
         QqHc6kNEfW88oWdk97kszhhlMc/IpVEOFZfzNpdLm8+aluT1MPewHxWF1rbBTY8TfM
         0xhGYP24Nf1NRiE6ndWi85k0dltXMsJDLyuSceBY=
Date:   Sat, 18 Apr 2020 19:53:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     mani@kernel.org
Cc:     robh+dt@kernel.org, narcisaanamaria12@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [RESEND PATCH v3 0/3] Add Reset and Wakeup support for CCS811
Message-ID: <20200418195303.5ddf7939@archlinux>
In-Reply-To: <20200414184930.5576-1-mani@kernel.org>
References: <20200414184930.5576-1-mani@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Apr 2020 00:19:27 +0530
mani@kernel.org wrote:

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
Looks good to me. I'd just like to give it a bit longer to allow dt
maintainers to take a look if they wish.

Thanks,

Jonathan

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
>   dt-bindings: iio: chemical: Add binding for CCS811 VOC sensor
>   iio: chemical: Add support for external Reset and Wakeup in CCS811
>   iio: chemical: Add OF match table for CCS811 VOC sensor
> 
>  .../bindings/iio/chemical/ams,ccs811.yaml     |  51 ++++++++
>  drivers/iio/chemical/ccs811.c                 | 112 ++++++++++++++++--
>  2 files changed, 152 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> 

