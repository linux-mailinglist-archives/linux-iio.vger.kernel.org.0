Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2E1D61A8
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgEPPD1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgEPPD1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:03:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B25220709;
        Sat, 16 May 2020 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589641407;
        bh=vmqjWNPF3wBSUqNyxlTElGLKLTWtQdztUyIEeSwpXpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RdC8chvRhQY35hYmCfpLD6mRFctSXzCG57wWyR4xleM3rzhG1a8+oQLP7nmD7xrCU
         kPlsUQp3ddcB3LSLYcDmubANx/sVvanyGYwftVS087Ouhllk3QyL4s9Xv2TmNO9kJZ
         k0Of9ewgQuRIhpZQsb1gh4CgKvUVF5Q8au2e40+8=
Date:   Sat, 16 May 2020 16:03:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: iio: accel: Add required regulators
 to bma180
Message-ID: <20200516160322.14be7ee9@archlinux>
In-Reply-To: <BN6PR04MB066073FD4A47219484D9C258A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
References: <20200514204901.3199-1-xc-racer2@live.ca>
        <BN6PR04MB066073FD4A47219484D9C258A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 13:48:58 -0700
Jonathan Bakker <xc-racer2@live.ca> wrote:

> The bma180 and related chips should have two registers attached to
registers-> regulators.

I'll fix that up.

J
> them.  The IIO driver currently uses them, document them here as
> well.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
> Changes from v1
> - Added A-b and R-b tags
> ---
>  Documentation/devicetree/bindings/iio/accel/bma180.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bma180.txt b/Documentation/devicetree/bindings/iio/accel/bma180.txt
> index cfbfc6276b3c..33da4a6fdb39 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bma180.txt
> +++ b/Documentation/devicetree/bindings/iio/accel/bma180.txt
> @@ -14,6 +14,8 @@ Required properties:
>      "bosch,bma254"
>      "bosch,smb380"
>    - reg : the I2C address of the sensor
> +  - vdd-supply : regulator phandle connected to the VDD pin
> +  - vddio-supply : regulator phandle connected to the VDDIO pin
>  
>  Optional properties:
>  

