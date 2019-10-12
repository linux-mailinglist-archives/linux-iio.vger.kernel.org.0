Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E725D4F5B
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfJLLeo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbfJLLen (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:34:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2652089F;
        Sat, 12 Oct 2019 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570880082;
        bh=BCxxTG4TWZSsQkLAgEQ+idXegdIsvgmu3X/imdZBric=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PTWcoD6SUQ++iL/Ug8wSa9TUJi63y43ywd+tCJXhA1hXp8192HZbI5L9AkZPh4PnY
         GRNNIp5MIWqHXD0yC+MHZKBdF552a3tydA09TpBIgKYvWq7SXxBFCs952CYOlCQ9xi
         n60rvrRwCa86RyBJs7v2DfKiaBcmF+uSrrOkOuxs=
Date:   Sat, 12 Oct 2019 12:31:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 6/8] dt-bindings: iio: adc: max1027: Mark interrupts
 as optional
Message-ID: <20191012123155.1a0df894@archlinux>
In-Reply-To: <20191011144347.19146-7-miquel.raynal@bootlin.com>
References: <20191011144347.19146-1-miquel.raynal@bootlin.com>
        <20191011144347.19146-7-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 16:43:45 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The chips have a 'start conversion' and a 'end of conversion' pair of
> pins. They can be used but this is absolutely not mandatory as regular
> polling is supported by the chip depending on its internal clocking
> setup.
> 
> There is no physical reason to force the use of interrupts so turn
> them optional.
> 
> Also, once the interrupt turned optional, these devices fit perfectly
> the "trivial devices" described in the generic (yaml) bindings file, so
> instead of converting this text file to json schema, we can just add
> the relevant compatibles in:
> Documentation/devicetree/bindings/trivial-devices.yaml.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
I guess this keeps things consistent event if we are about to delete it ;)

Applied.

> ---
>  Documentation/devicetree/bindings/iio/adc/max1027-adc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt b/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
> index e680c61dfb84..7b23d68f655c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
> @@ -3,6 +3,8 @@
>  Required properties:
>    - compatible: Should be "maxim,max1027" or "maxim,max1029" or "maxim,max1031"
>    - reg: SPI chip select number for the device
> +
> +Optional properties:
>    - interrupts: IRQ line for the ADC
>    see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  

