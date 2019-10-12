Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19265D4EA2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 11:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfJLJbe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 05:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfJLJbP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 05:31:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954B320673;
        Sat, 12 Oct 2019 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570872672;
        bh=Y6OC/p/wgeNKTKvc8WYHh2ibSI9GqMt9Elyazz51CMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MDi1XW6nhQmYtd4LuEb++Uvuni/TseH2j3yc0YPPrkmmAw58DmaD7wLZlDeuLfztp
         MzSWxK0iwcD3dqBAxN4f3v3MvfMASxCkaUx4zDFYckcncDwJ+uUQFhfxyJtv6JA07k
         v5ZghQzP6KpO3xjv2YBecS032ZXmeQLser+o9vvU=
Date:   Sat, 12 Oct 2019 10:31:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191012103107.61eeb350@archlinux>
In-Reply-To: <20191012035420.13904-2-dan@dlrobertson.com>
References: <20191012035420.13904-1-dan@dlrobertson.com>
        <20191012035420.13904-2-dan@dlrobertson.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Oct 2019 03:54:19 +0000
Dan Robertson <dan@dlrobertson.com> wrote:

> Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> accelerometer sensor.
> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
Hi Dan,

Apologies for not pointing this out in V1 but all new IIO bindings need
to be in the yaml format rather than plain text.

Please convert this one over for v3.  Content wise it's fine btw!

Jonathan


> ---
>  .../devicetree/bindings/iio/accel/bma400.txt     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bma400.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bma400.txt b/Documentation/devicetree/bindings/iio/accel/bma400.txt
> new file mode 100644
> index 000000000000..abba4f104941
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bma400.txt
> @@ -0,0 +1,16 @@
> +
> +* Bosch BMA400 triaxial acceleration sensor
> +
> +https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA400-DS000.pdf
> +
> +Required properties:
> +
> +  - compatible : should be "bosch,bma400"
> +  - reg : the I2C address of the sensor
> +
> +Example:
> +
> +bma400@14 {
> +	compatible = "bosch,bma400";
> +	reg = <0x14>;
> +};
> 
> 

