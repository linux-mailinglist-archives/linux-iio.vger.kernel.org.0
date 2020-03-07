Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8989317CEAE
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 15:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgCGO0J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 09:26:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgCGO0J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 09:26:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBCBE206D5;
        Sat,  7 Mar 2020 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583591169;
        bh=R10XMZPnBvU7IEe5DhBHjIeZp6ovpiPSVdQ11F9vIUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bX61VUnzwU7BHmKBRED5vsxrD4Mx8Zliu4qfr+Ys3aQtVzOjpnDu2jz2tdZq5VmwV
         5S8Hq8FFbOkI5nehAYWPPQfuCsqQLIBqndG9ezwKOoCbCWWg6ucNUt6REjaBoqfxrg
         lFSyDJTLuB4xjed4zMZ4g4Jk1DPKVAivzYUOrQA8=
Date:   Sat, 7 Mar 2020 14:26:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v8 2/8] include: fpga: adi-axi-common.h: add version
 helper macros
Message-ID: <20200307142604.7d597667@archlinux>
In-Reply-To: <20200306110100.22092-3-alexandru.ardelean@analog.com>
References: <20200306110100.22092-1-alexandru.ardelean@analog.com>
        <20200306110100.22092-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Mar 2020 13:00:54 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The format for all ADI AXI IP cores is the same.
> i.e. 'major.minor.patch'.
> 
> This patch adds the helper macros to be re-used in ADI AXI drivers.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Again, trivial but needs a Moritz ack as it's his subsystem.

> ---
>  include/linux/fpga/adi-axi-common.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> index ebd4e07ae3d8..141ac3f251e6 100644
> --- a/include/linux/fpga/adi-axi-common.h
> +++ b/include/linux/fpga/adi-axi-common.h
> @@ -16,4 +16,8 @@
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
>  
> +#define ADI_AXI_PCORE_VER_MAJOR(version)	(((version) >> 16) & 0xff)
> +#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
> +#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
> +
>  #endif /* ADI_AXI_COMMON_H_ */

