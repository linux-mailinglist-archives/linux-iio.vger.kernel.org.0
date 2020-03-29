Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151F2196C4C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 11:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgC2J5i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 05:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgC2J5i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Mar 2020 05:57:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD3520675;
        Sun, 29 Mar 2020 09:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585475857;
        bh=pyqkwg7+NdzzGNrT9rgcJIqmjn1T/lyVAWcXSX9NTDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PwqCrr7vnz4T0XKia7xKuKD6Al6Exm48qFPgQRTnAIwGlFGf6WQIwO7yuBzBkie5V
         Sgwe/WsUVje38l3MV0usQO243dnTlVYaBDhqe90WbcD3vXhVcn/VFXISHf3X4gn6ST
         6cKa58mv4Ae4qBRv4YcnGl40OIkfTnl6Yzoh/xDk=
Date:   Sun, 29 Mar 2020 10:57:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <Laszlo.Nagy@analog.com>, <Andrei.Grozav@analog.com>,
        <Michael.Hennerich@analog.com>, <Istvan.Csomortani@analog.com>,
        <Adrian.Costina@analog.com>, <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v13 1/8] include: fpga: adi-axi-common.h: fixup
 whitespace tab -> space
Message-ID: <20200329105732.479d090f@archlinux>
In-Reply-To: <20200324134636.64643-2-alexandru.ardelean@analog.com>
References: <20200324134636.64643-1-alexandru.ardelean@analog.com>
        <20200324134636.64643-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 15:46:29 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The initial version use a tab between '#define' & 'ADI_AXI_REG_VERSION'.
> This changes it to space. The change is purely cosmetic.
> 
> Acked-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.  Note this won't make the coming
merge window.

Thanks,

Jonathan

> ---
>  include/linux/fpga/adi-axi-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> index 7fc95d5c95bb..ebd4e07ae3d8 100644
> --- a/include/linux/fpga/adi-axi-common.h
> +++ b/include/linux/fpga/adi-axi-common.h
> @@ -11,7 +11,7 @@
>  #ifndef ADI_AXI_COMMON_H_
>  #define ADI_AXI_COMMON_H_
>  
> -#define	ADI_AXI_REG_VERSION			0x0000
> +#define ADI_AXI_REG_VERSION			0x0000
>  
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))

