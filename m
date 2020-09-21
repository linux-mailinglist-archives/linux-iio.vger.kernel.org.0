Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E21273173
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 20:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgIUSGO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 14:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgIUSGO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Sep 2020 14:06:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 491E5206FB;
        Mon, 21 Sep 2020 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600711573;
        bh=rHoWzRKW+POsO0WNbLWHZo+8S+cikA0E8G/DaBPUXc4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=geVr7+dx+athusSJXMiQoBGWaqZm+AGDKlkjtcQcKS2uRwaV4mNmy1aNWY+Jx4OeG
         H/UbPFozNOxLFEqF/zNVKQjFZLvg/mT3tfrWui9QDa1dSCloc7Ni1LRlKa4xcaOkJu
         2XCucuBntp1kgT5V7Vu9vCMHgO1yfW6CbYhTAugU=
Date:   Mon, 21 Sep 2020 19:06:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: vishay,vcnl4000: add interrupts
 property
Message-ID: <20200921190607.5f98f133@archlinux>
In-Reply-To: <20200920203845.17758-1-krzk@kernel.org>
References: <20200920203845.17758-1-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Sep 2020 22:38:45 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The dtschema should list all properties, including the common ones like
> interrupts.  This fixes dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml:
>     prox@60: 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Trivial enough that I'll just sneak this one in before I do a pull request.

thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> index 58887a4f9c15..4d1a225e8868 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> @@ -24,6 +24,10 @@ properties:
>        - vishay,vcnl4020
>        - vishay,vcnl4040
>        - vishay,vcnl4200
> +
> +  interrupts:
> +    maxItems: 1
> +
>    reg:
>      maxItems: 1
>  

