Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985B381EF9
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfHEOYg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfHEOYg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:24:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E42B2086D;
        Mon,  5 Aug 2019 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565015075;
        bh=nwv3kwEBStYDfwhINkS2+14vPtlRw+Xv/2F7kdDaLoA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Poy0LU3Ykw06FRyXUwrpq/3VP79HVS5isD2aMv87iy1xLPS4VzPa0gE4i5eS+tIIW
         1WwEn+3/8m3YYyk6qvpxpbw8eh+uByO477u6LqdBY6VobEvW2B2JnSuoLotmFUfXMm
         dZG0fDMdn3Ms0KjGp6uKcjzwXmGqo97Y0pWx8MoE=
Date:   Mon, 5 Aug 2019 15:24:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add ism330dhcx
 device bindings
Message-ID: <20190805152431.5a7f1a20@archlinux>
In-Reply-To: <0a970fdcd934c940be1af82ecf1fe2a746abcd2a.1564999807.git.lorenzo@kernel.org>
References: <cover.1564999807.git.lorenzo@kernel.org>
        <0a970fdcd934c940be1af82ecf1fe2a746abcd2a.1564999807.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  5 Aug 2019 12:18:44 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Applied,

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index 92b48f242356..87407d110bb7 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -12,6 +12,7 @@ Required properties:
>    "st,lsm6dsox"
>    "st,lsm6dsr"
>    "st,lsm6ds3tr-c"
> +  "st,ism330dhcx"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:

