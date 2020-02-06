Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975581543DC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 13:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgBFMQ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 07:16:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBFMQ3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 07:16:29 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6401420730;
        Thu,  6 Feb 2020 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580991388;
        bh=e9k4VD5l8Tc5YqbMhZQlcEdHRELkx4+zkAd148iC+/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hA9VvVN0ZFsEXiSeBXZYrmx8vNR2gmJoEYxHQJI9IVzuaIXjRVXo0yEFWZRK8U68C
         y7u+ErcqBrFVkxZZqvH/I6jrN9qeUUHMOPouMv7dej8K4E+GawoeJS3uijk5ez6bV/
         6ZzoRSvHeepUNxrDzuAkJq7usAyNxxv8QKX0NZKA=
Date:   Thu, 6 Feb 2020 12:16:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: add description for new supported
 chips
Message-ID: <20200206121624.489ca051@archlinux>
In-Reply-To: <20200206103105.23666-7-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
        <20200206103105.23666-7-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  6 Feb 2020 11:31:05 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Add missing mpu6000 and new icm20609, icm20689, icm20690, and
> iam20680.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Applied.  Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> index c5ee8a20af9f..f2f64749e818 100644
> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> @@ -4,6 +4,7 @@ http://www.invensense.com/mems/gyro/mpu6050.html
>  
>  Required properties:
>   - compatible : should be one of
> +		"invensense,mpu6000"
>  		"invensense,mpu6050"
>   		"invensense,mpu6500"
>  		"invensense,mpu6515"
> @@ -11,7 +12,11 @@ Required properties:
>  		"invensense,mpu9250"
>  		"invensense,mpu9255"
>  		"invensense,icm20608"
> +		"invensense,icm20609"
> +		"invensense,icm20689"
>  		"invensense,icm20602"
> +		"invensense,icm20690"
> +		"invensense,iam20680"
>   - reg : the I2C address of the sensor
>   - interrupts: interrupt mapping for IRQ. It should be configured with flags
>     IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or

