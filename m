Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE32DD4F53
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfJLLef (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfJLLee (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:34:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175BF21850;
        Sat, 12 Oct 2019 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570880074;
        bh=W4NC8632bGz/c1s9iiMhYVGkCQw4mSPBogNjkzVISYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VztAou9dJZ/QG8h9Xhxo/g9avXs5IPbCYRZNnYOWmJO0paq0EUYD4MqHPqLtudTGz
         g3iE6VnqJ2xGTUCQz6gJT1TQkRfrgtGD7QP2sVQ4QkHCM88Jtlt8/BXQTI0qSmvmEx
         wgZ/Cm2lp1+1PvqOn2lrErXL0qis85LutGMIWvOk=
Date:   Sat, 12 Oct 2019 12:32:58 +0100
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
Subject: Re: [PATCH v4 8/8] dt-bindings: Add max12xx SPI ADC series as
 trivial devices
Message-ID: <20191012123258.67734ca7@archlinux>
In-Reply-To: <20191011144347.19146-9-miquel.raynal@bootlin.com>
References: <20191011144347.19146-1-miquel.raynal@bootlin.com>
        <20191011144347.19146-9-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 16:43:47 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Update the compatible list with three Maxim ADCs compatibles.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index e0095ecb472f..765fd1c170df 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -120,6 +120,12 @@ properties:
>            - maxim,max1029
>              # 10-bit 16 channels 300ks/s SPI ADC with temperature sensor
>            - maxim,max1031
> +            # 12-bit 8 channels 300ks/s SPI ADC with temperature sensor
> +          - maxim,max1227
> +            # 12-bit 12 channels 300ks/s SPI ADC with temperature sensor
> +          - maxim,max1229
> +            # 12-bit 16 channels 300ks/s SPI ADC with temperature sensor
> +          - maxim,max1231
>              # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
>            - maxim,max1237
>              # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion

