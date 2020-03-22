Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5A618EAE7
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCVRhK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCVRhK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:37:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814FD206F8;
        Sun, 22 Mar 2020 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584898629;
        bh=Lgovlxg7dFbPO/P+o/rnIrwfYlOLF/A2RWcibjrilSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oYUcvBg5CpQFHeK6Liw6ik7cNSfw93xu6MvnG0PDvdqv1JGdVmSjPOzsGKZ4dtDDG
         VmpjUJCVgQc5+j9kncqQjWELS8ztwauU3TZJgf+a2ZJw0J37fbMLbWKdZOUlYp8XAK
         zSqT3QsCgMoRtbFiNo79Km/7lxlSXIuAvuheBSC8=
Date:   Sun, 22 Mar 2020 17:37:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
Message-ID: <20200322173704.5cc497c1@archlinux>
In-Reply-To: <20200316065218.4103-1-mike.looijmans@topic.nl>
References: <20200316065218.4103-1-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 07:52:18 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
> the accelerometer part.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  .../devicetree/bindings/iio/accel/bmi088.txt  | 23 +++++++++++++++++++

Sorry.  All new DT bindings need to be in yaml format.

Please put this in the same series as the driver.

Thanks,

Jonathan

>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bmi088.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bmi088.txt b/Documentation/devicetree/bindings/iio/accel/bmi088.txt
> new file mode 100644
> index 000000000000..691a47726dbc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bmi088.txt
> @@ -0,0 +1,23 @@
> +* Bosch BMI088 IMU combining accelerometer and gyroscope
> +
> +https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
> +
> +Required properties:
> +
> +  - compatible : should be "bosch,bmi088_accel"
> +  - reg : the I2C address of the sensor or the SPI chip select number
> +
> +Optional properties:
> +
> +  - interrupts : interrupt mapping for GPIO IRQ, it should be configured with
> +		 IRQ_TYPE_EDGE_RISING
> +
> +Example:
> +
> +bmi088_accel@1 {
> +	compatible = "bosch,bmi088_accel";
> +	reg = <1>;
> +	spi-max-frequency = <10000000>;
> +	interrupt-parent = <&gpio>;
> +	interrupts = <90 IRQ_TYPE_EDGE_RISING>;
> +};

