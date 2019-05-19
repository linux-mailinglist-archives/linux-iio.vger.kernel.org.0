Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B029722794
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfESRRY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfESRRW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:17:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA1F217F5;
        Sun, 19 May 2019 11:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558264672;
        bh=kk7r638p7yvAE0YxJCe0oCbhN7riRAph/7kkz1bmEeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0LSy+rgdh4FHVrxV9GcVitq8XOzwAwQYX9mTWsESHPD/nGK/savNTYKIY20exl5Ij
         Ub6lO/d5LOPdn+uDhnNv5uoqglkfAZDJkrPGz1guXv8MSaiGvndddLB0+zIC6IxqfP
         IDF6+FiHcWjEGB9uVJQ9hGTPosy2Tdnzz8+3hCMc=
Date:   Sun, 19 May 2019 12:17:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tallys Martins <tallysmartins@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.or, kernel-usp@googlegroups.com,
        Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
Subject: Re: [PATCH 2/2] staging: iio: ad2s1210: Add devicetree yaml doc
Message-ID: <20190519121747.0e7b5824@archlinux>
In-Reply-To: <20190518221558.21799-2-tallysmartins@gmail.com>
References: <20190518221558.21799-1-tallysmartins@gmail.com>
        <20190518221558.21799-2-tallysmartins@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 19:15:58 -0300
Tallys Martins <tallysmartins@gmail.com> wrote:

> The driver currently has no devicetree documentation. This commit adds a
> devicetree folder and documentation for it. Documentation must be moved
> as well when the driver gets out of staging.
> 
> Signed-off-by: Tallys Martins <tallysmartins@gmail.com>
> Signed-off-by: Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>
> Co-developed-by: Souza Guilherme <gdsdsilva@inf.ufpel.edu.br>

Hi,

There is no need for a direct relationship between a binding and a driver
at all. As such, we normally don't take binding documents in staging.

Just put it directly in it's final destination.  The driver can catch
up with it later!

I'm still not that comfortable with yaml (haven't gotten around
to doing any conversions myself yet) so I'll be looking for additional
review on these from others.

A few comments inline.

> ---
>  .../Documentation/devicetree/ad2s1210.yaml    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml
> 
> diff --git a/drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml b/drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml
> new file mode 100644
> index 000000000000..733aa07b4626
> --- /dev/null
> +++ b/drivers/staging/iio/Documentation/devicetree/ad2s1210.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/iio/ad2s1210.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: |
> +  Analog Devices Inc. AD2S1210 10-Bit to 16-Bit R/D Converters
> +
> +maintainers:
> +  - Graff Yang <graff.yang@gmail.com>
I would check that one with the Analog devices team.

> +
> +description: |
> +  Analog Devices AD2S1210 Resolver to Digital SPI driver
> +
> +  https://www.analog.com/en/products/ad2s1210.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad2s1210
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    minimum: 2000
> +    maximum: 20000
> +    default: 8192
This doesn't look like a modern clock binding.
If we are going to end up changing this, then we should probably delay
having a binding doc until after that change is made.

We often only do binding docs for drivers in staging just before moving
them out so as to avoid this sort of issue.
 
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +  resolver@0 {
> +    compatible = "adi,ad2s1210";
> +    reg = <0>;
An example is probably more useful if it includes all the optional properties
as well.
> +  };
> +...

Thanks,

Jonathan

