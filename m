Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC46267ED9
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 13:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfGNLgp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 07:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbfGNLgp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 07:36:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8869A2064A;
        Sun, 14 Jul 2019 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563104204;
        bh=O3S0nwHkIC6+jIgqPz53hmvYyEBZ3IBORoOqH2VQRWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e6tXcRxzvDlXVuu8F8xEhJoifz60lVjV0Xajm+HXhz9ItxdCGoT3q/PeVta6n3mve
         iSGdq5iRqAdo6K0865QrLwdNzseDeqMxRJkQ7smemSCN6oXgcn5t+ZfXLsCec10jFj
         nRuT1a3ZTONcPhf9M804RaFsajCw+ZtCGFQoGIlY=
Date:   Sun, 14 Jul 2019 12:36:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: add entry for plantower pms7003 driver
Message-ID: <20190714123640.7c21034c@archlinux>
In-Reply-To: <20190710192155.11489-3-tduszyns@gmail.com>
References: <20190710192155.11489-1-tduszyns@gmail.com>
        <20190710192155.11489-3-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Jul 2019 21:21:55 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add myself as a plantower pms7003 driver maintainer.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied,

Thanks,

Jonathan

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad498428b38c..771de33ef737 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12548,6 +12548,12 @@ F:	drivers/i2c/busses/i2c-puv3.c
>  F:	drivers/video/fbdev/fb-puv3.c
>  F:	drivers/rtc/rtc-puv3.c
>  
> +PLANTOWER PMS7003 AIR POLLUTION SENSOR DRIVER
> +M:	Tomasz Duszynski <tduszyns@gmail.com>
> +S:	Maintained
> +F:	drivers/iio/chemical/pms7003.c
> +F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
> +
>  PMBUS HARDWARE MONITORING DRIVERS
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org

