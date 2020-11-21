Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2BA2BC04D
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 16:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgKUPp2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 10:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgKUPp2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:45:28 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF92D221FE;
        Sat, 21 Nov 2020 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605973527;
        bh=SuvFSM+Ytt5yvE7ydkkTHna+m3aHwAZcL9WAYrx31mY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yL1kiu9nnVxAvyOH1wVMDJw+KSInuG7nzthXHWvxyHjH9Lc3lL/RbaTJM0fNsxidS
         QtuozvvKf042vPVTN8ss1/6nU3FON2vteRUcm2ar6qp5OStdEWV0US3qkLzhLPk3rU
         w7IbXQ+tsHJMwp5JKZ9NTTwgXI/J2S6RUG6Nu2c8=
Date:   Sat, 21 Nov 2020 15:45:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: humidity: hts221: introduce vdd
 regulator bindings
Message-ID: <20201121154523.0c0421b6@archlinux>
In-Reply-To: <5e8009b293f1d5160ecbcdd33e7332ba0192b96e.1605777052.git.lorenzo@kernel.org>
References: <cover.1605777052.git.lorenzo@kernel.org>
        <5e8009b293f1d5160ecbcdd33e7332ba0192b96e.1605777052.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Nov 2020 10:13:35 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
I'd drop the description as kind of obvious.

vdd-supply: true

will work fine.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml b/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
> index 396451c26728..53df083b3de6 100644
> --- a/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
> +++ b/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
> @@ -26,6 +26,9 @@ properties:
>        The interrupt/data ready line will be configured as open drain, which
>        is useful if several sensors share the same interrupt line.
>  
> +  vdd-supply:
> +    description: if defined provides VDD power to the sensor.
> +
>    interrupts:
>      maxItems: 1
>  

