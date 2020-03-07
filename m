Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC4E17CEA9
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 15:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCGOZ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 09:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgCGOZ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 09:25:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82EF206D5;
        Sat,  7 Mar 2020 14:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583591126;
        bh=O+87n042lk3PkORkXovI5bSszMbNt147sH09kFHUQZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I5+9DXhZkr8Q/Qh/JRatBSfcgpqDpdE4nT5OlH06Vu6sWh3alDs6JOsejOOMgFlAM
         uy4Tb+I4ZuSOS9ZlSMGzAbQ53WDPIQmiHLEsCb6R0wDRE5miJ+Fzy1DPdLrkJE8dP8
         Iz6SGy11IzGMSfQwCS9N+ZVLiNw0DNWRd9Mv1dng=
Date:   Sat, 7 Mar 2020 14:25:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v8 1/8] include: fpga: adi-axi-common.h: fixup
 whitespace tab -> space
Message-ID: <20200307142521.3efbe4a4@archlinux>
In-Reply-To: <20200306110100.22092-2-alexandru.ardelean@analog.com>
References: <20200306110100.22092-1-alexandru.ardelean@analog.com>
        <20200306110100.22092-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Mar 2020 13:00:53 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The initial version use a tab between '#define' & 'ADI_AXI_REG_VERSION'.
> This changes it to space. The change is purely cosmetic.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Whilst this is trivial it still needs an ack from relevant maintainer
for that directory. Moritz I think...

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

