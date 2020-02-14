Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F074A15D91F
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgBNOOO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:14:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbgBNOON (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:14:13 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F12E5217F4;
        Fri, 14 Feb 2020 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581689653;
        bh=aGy3vRwDnfElh7WcX6W3vs4JKizJixxKi32nDEI0dJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wYj1fU2fcpZOOppAhcRP2/WLzPvuTE5E6JqO6qCezPEiY+ceTH1FpRH643+JFYa25
         mcfp5pP3eNxC4b1WRD3wWdmVw0uxk3BxGy9J1U9wVDtHBm38RY9rhzHZ1Pca5goYir
         MY/MSiOTOnpQIKBi0GD2VlznkKKEqPRMxs5R0fL0=
Date:   Fri, 14 Feb 2020 14:14:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] MAINTAINERS: add entry for hmc425a driver.
Message-ID: <20200214141407.22d0cbf5@archlinux>
In-Reply-To: <20200206151149.32122-5-beniamin.bia@analog.com>
References: <20200206151149.32122-1-beniamin.bia@analog.com>
        <20200206151149.32122-5-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Feb 2020 17:11:49 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Add Beniamin Bia and Michael Hennerich as maintainers for HMC425A
> attenuator.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied.

Thanks,

Jonathan

> ---
> Changes in v5:
> -parse_maintainers runned
> 
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e699fe378e71..12e39dc0dc93 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1063,6 +1063,15 @@ F:	drivers/iio/adc/ltc249*
>  X:	drivers/iio/*/adjd*
>  F:	drivers/staging/iio/*/ad*
>  
> +ANALOG DEVICES INC HMC425A DRIVER
> +M:	Beniamin Bia <beniamin.bia@analog.com>
> +M:	Michael Hennerich <michael.hennerich@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	http://ez.analog.com/community/linux-device-drivers
> +F:	Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> +F:	drivers/iio/amplifiers/hmc425a.c
> +
>  ANALOGBITS PLL LIBRARIES
>  M:	Paul Walmsley <paul.walmsley@sifive.com>
>  S:	Supported

