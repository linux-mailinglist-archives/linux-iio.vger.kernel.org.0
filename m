Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7DB4F477
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfFVItr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 04:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfFVItr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 04:49:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFA19206BA;
        Sat, 22 Jun 2019 08:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561193386;
        bh=AsIYpJcZllGSdfvs99k81iivw+rZl+7oeN3G7FA99dg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hh5oWNFeFISOlEU1rFNC1TIFJkkl5Ok1AjW3dJbXSXfPo+QOOWDeOs8vHRFv7on9T
         KR0Sxc6vekesn3gptOUXDyOzb+tBUOXBzPgGOWRMXTy0YW26Muhqui5aHx1K5bQYzy
         rQOFkzCcdKkK8pUNmJCoIhSORu4kjr79aJFHY+Ok=
Date:   Sat, 22 Jun 2019 09:49:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: add entry for sensirion sps30 driver
Message-ID: <20190622094940.3f869029@archlinux>
In-Reply-To: <20190620195011.30942-3-tduszyns@gmail.com>
References: <20190620195011.30942-1-tduszyns@gmail.com>
        <20190620195011.30942-3-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Jun 2019 21:50:11 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add myself as a sensirion sps30 driver maintainer.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1eb971608ac4..dafa02ba161c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14172,6 +14172,12 @@ S:	Maintained
>  F:	drivers/misc/phantom.c
>  F:	include/uapi/linux/phantom.h
>  
> +SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
> +M:	Tomasz Duszynski <tduszyns@gmail.com>
> +S:	Maintained
> +F:	drivers/iio/chemical/sps30.c
> +F:	Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
> +
>  SERIAL DEVICE BUS
>  M:	Rob Herring <robh@kernel.org>
>  L:	linux-serial@vger.kernel.org

