Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B6D10E175
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 11:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfLAK6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 05:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfLAK6X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 05:58:23 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B386920833;
        Sun,  1 Dec 2019 10:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575197902;
        bh=bMDPBga8P0mAjQcAV26t11b0Ff2MnJ0WWgWVJMOgEt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dWbZ4NqxI/NnBKssmIqcXOdTZvgip/g+EHPQecLLzJlaxkWKXUDpdfVrFmUOtTAM9
         fM5H7SkN2jkM7oNEhgDVi/3+Nt/A2stXvEbd831n9YbhdPFnrk8qLf3yTUTzueBl31
         7NpCL9T+hVN4kJ9RiybNIXez7gjZltY2oZ+35xds=
Date:   Sun, 1 Dec 2019 10:58:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <tomislav.denis@avl.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: Add asc vendor
Message-ID: <20191201105818.336c02e6@archlinux>
In-Reply-To: <20191129073420.9800-3-tomislav.denis@avl.com>
References: <20191114100908.11180-1-tomislav.denis@avl.com>
        <20191129073420.9800-1-tomislav.denis@avl.com>
        <20191129073420.9800-3-tomislav.denis@avl.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Nov 2019 08:34:19 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> All Sensors Corporation is a manufacturer of MEMS piezoresitive
> ultra low pressure sensors and pressure transducers.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
Please make sure to pick up an Acks from earlier versions.

Only drop them if you make substantial changes.

Rob acked this one.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 967e78c..88247b3 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -109,6 +109,8 @@ patternProperties:
>      description: Artesyn Embedded Technologies Inc.
>    "^asahi-kasei,.*":
>      description: Asahi Kasei Corp.
> +  "^asc,.*":
> +    description: All Sensors Corporation
>    "^aspeed,.*":
>      description: ASPEED Technology Inc.
>    "^asus,.*":

