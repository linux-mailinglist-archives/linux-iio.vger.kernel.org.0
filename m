Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36F77EA8
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfG1Ipa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 04:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfG1Ipa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 04:45:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D44A2085A;
        Sun, 28 Jul 2019 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564303529;
        bh=/5r3rYZjAroH9klgA3A3a0rKTbHeBYnKF2HDF1+EAzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=em3yfMQjkjLr7fBs+kgwtzRpXzjQmy4heVAtAqHs4GXaffz3PpYrdderzejYuejwS
         cP4TsQd06lza6cbSqVueJcAT+coNAZRiolIEvYJcIGcccVIi3mrojQ1G60Jr9Y8YwR
         2Hp0vvfRjrJxV1ywuSKxIcNFUXZK1CL6HvgOMYIc=
Date:   Sun, 28 Jul 2019 09:45:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio/adc: Add a compatible string
 for JZ4770 SoC ADC
Message-ID: <20190728094523.2a161231@archlinux>
In-Reply-To: <20190727195940.14010-1-contact@artur-rojek.eu>
References: <20190727195940.14010-1-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 27 Jul 2019 21:59:38 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Add a compatible string for the ADC controller present on
> Ingenic JZ4770 SoC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Reviewed-by: Rob Herring <robh@kernel.org>

Hi Artur,

I'll have to hold this series for a few weeks as the fix for the
clock rate divider isn't in my upstream for the togreg branch yet
(as I haven't sent a pull request since the merge window).

Give me a poke if I seem to have forgotten these in a few weeks
time.

Thanks,

Jonathan

> ---
> 
> Changes:
> 
> v2: no change
> 
>  Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> index f01159f20d87..cd9048cf9dcf 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
> @@ -5,6 +5,7 @@ Required properties:
>  - compatible: Should be one of:
>    * ingenic,jz4725b-adc
>    * ingenic,jz4740-adc
> +  * ingenic,jz4770-adc
>  - reg: ADC controller registers location and length.
>  - clocks: phandle to the SoC's ADC clock.
>  - clock-names: Must be set to "adc".

