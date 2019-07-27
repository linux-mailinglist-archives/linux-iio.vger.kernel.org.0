Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD8D77C01
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725263AbfG0VXC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 17:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfG0VXC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 17:23:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EDD420657;
        Sat, 27 Jul 2019 21:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564262581;
        bh=eh8OvF0VESRy2rOeDGmzPK+Ei3PaxUgCOoCB/2LnIxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JSBd0EbAGBpSAAf+P0AQahA5ItTPm4Fsv2n8PmUg67G93Tbocml+GuPHHlxa3CUvS
         1M8t7jXVKxW0aFUpP8r9PeQBvfj90rglE264D7IpWXewvSdiDEIQit2lzNmbwIfwLR
         qLxbP6d1j1vVW4qcV4sqOMKIyl2vOESb8EGNGKGg=
Date:   Sat, 27 Jul 2019 22:22:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: avia-hx711: Fix avdd-supply typo
 in example
Message-ID: <20190727222256.2d451e82@archlinux>
In-Reply-To: <20190716203324.12198-1-robh@kernel.org>
References: <20190716203324.12198-1-robh@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Jul 2019 14:33:23 -0600
Rob Herring <robh@kernel.org> wrote:

> Now that examples are validated against the DT schema, a typo in
> avia-hx711 example generates a warning:
> 
> Documentation/devicetree/bindings/iio/adc/avia-hx711.example.dt.yaml: weight: 'avdd-supply' is a required property
> 
> Fix the typo.
> 
> Fixes: 5150ec3fe125 ("avia-hx711.yaml: transform DT binding to YAML")
> Cc: Andreas Klinger <ak@it-klinger.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Jonathan,
> 
> I have some other fixes I'm sending to Linus and can take these 2 if 
> that's easier.
> 
> Rob

Thanks for dealing with these, I missed this thread entirely in my email
whilst travelling / playing catch up.

Jonathan
> 
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> index 8a4100ceeaf2..d76ece97c76c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> @@ -61,6 +61,6 @@ examples:
>          compatible = "avia,hx711";
>          sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>          dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> -        avdd-suppy = <&avdd>;
> +        avdd-supply = <&avdd>;
>          clock-frequency = <100000>;
>      };

