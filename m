Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C349F37B
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfH0Tvk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 15:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0Tvk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 15:51:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6515C20674;
        Tue, 27 Aug 2019 19:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566935499;
        bh=aMMmd3YGmlvqtDHoRGDNt5SoUS7AWAH8HYMEx0R+19k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SeSLyOqZbaW1nwafb+XoyOORajAqgxyjUTDBWl5RN9dLGbFzOeHXYyq7Xom8Wcuun
         vqchvNvWxcPDbPrW04Phpl9l9ibC8+Cs79F0dgyB7AfLlQTazASy5k0U9zOlIq1THB
         No3WoVE+Tm1s3YtedlBJwZuRwz+A7u7QXpdgXpZk=
Date:   Mon, 26 Aug 2019 09:10:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] dt-bindings: iio: imu: st_lsm6dsx: add lsm9ds1
 device bindings
Message-ID: <20190826091024.50bbf6ba@archlinux>
In-Reply-To: <20190821132520.28225-5-martin.kepplinger@puri.sm>
References: <20190821132520.28225-1-martin.kepplinger@puri.sm>
        <20190821132520.28225-5-martin.kepplinger@puri.sm>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Aug 2019 15:25:20 +0200
Martin Kepplinger <martin.kepplinger@puri.sm> wrote:

Tweaked to add the -imu plus some text in the patch description to say
why.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore.

Thanks,

Jonathan

> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index 87407d110bb7..0b0a74d9ab89 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -13,6 +13,7 @@ Required properties:
>    "st,lsm6dsr"
>    "st,lsm6ds3tr-c"
>    "st,ism330dhcx"
> +  "st,lsm9ds1"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:

