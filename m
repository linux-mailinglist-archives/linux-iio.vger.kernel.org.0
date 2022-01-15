Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC548F892
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 19:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiAOSC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 13:02:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58586 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiAOSC2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 13:02:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E713CE0932
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 18:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E787C36AE5;
        Sat, 15 Jan 2022 18:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642269745;
        bh=FGRuuu0DTLqMBDIhkqyAxqRHZyd8382E6ihtHlQGKgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gZPf6cnxfCQb/R6f5hMf1iDnX3F0oToaLCRJJ7gc8PYtnWzg7ehdQF4rqVSim69X+
         3TFeSP6bcz9Sa9P8EMCvnpayNnbbVG/6/DfVpRMK4VcVlg2Iu3m6D3Vr2pRd+yWd7m
         VHL8IMRdBE3FqWLuL9wCwCg4CBULg88tUEQ8Jc7TcXDvWpmnTGvcYVJ1Qd1dkO+sfA
         2IpQUeLbnmpezne2ZKVJWR/2wSE/oVcVuG0Y7Yd32tR4ktHpIVxel1OsooRp2Rdrlp
         z9k44NJX7zwbxCdzUk7oU5AivfsP9dUKwNZ4b//d7Vq5IwmmmaHTE4pqy9AODGvtRA
         3cXx8gGs2/aww==
Date:   Sat, 15 Jan 2022 18:08:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add maintainer for ADRF6780 driver
Message-ID: <20220115180827.4c414a97@jic23-huawei>
In-Reply-To: <20220103111624.82262-1-antoniu.miclaus@analog.com>
References: <20220103111624.82262-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Jan 2022 13:16:24 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add myself as maintainer for the ADRF6780 driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied, thanks,

Jonathan

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7168aa..ffeb0cc83ee5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1127,6 +1127,14 @@ S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
>  F:	drivers/power/supply/adp5061.c
>  
> +ANALOG DEVICES INC ADRF6780 DRIVER
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> +F:	drivers/iio/frequency/adrf6780.c
> +
>  ANALOG DEVICES INC ADV7180 DRIVER
>  M:	Lars-Peter Clausen <lars@metafoo.de>
>  L:	linux-media@vger.kernel.org

