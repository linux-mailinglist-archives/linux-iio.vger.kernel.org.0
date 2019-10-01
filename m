Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB41C32A7
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfJALjI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 07:39:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32943 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732944AbfJALjG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 07:39:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id e18so14100257oii.0;
        Tue, 01 Oct 2019 04:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8YiTod9K8O9GPcKF5VY5ZHEme9jFCDH+v37G0Q0Kn6g=;
        b=s4+wiThD1RF1csTp80qem7PDNAxR3S2R3hcPuqypVAPFkhgKYS1TGZghlkUENKBm8o
         SXZhd00yGZZkNLT09Tp5nvAycEDUPap15JnFsXqS3JZyo8FioRRLe2v6xJNr70LffAtP
         u3k3/zDXVq5HRT0JmOot//tb/VSYr49JGtFue5PkJtrJ7RQYmih7KR4w+juxo9614p+d
         P192ey4QnfDZzQFbv6wRRxIIgFr219fMBxQmVXV9DQeOe3brDhYnNaHD5CAA240VINt4
         2mj4eQbJDz4TTz89C5q2xJRAxvxgMNYrgIwAkrEoJykumPgVivcnsBDTVtmQ5cNFg24U
         rLOw==
X-Gm-Message-State: APjAAAWOA2Yja7ddzms5jmCXmU7Jh0sTCs3bj/8zipE4Bs7R76WOd9H7
        SW1uAScSbs9/VyehA4uoRw==
X-Google-Smtp-Source: APXvYqzvbbUawcihDPbdyBBpvF790LwcR11FDYkTD3jb8+dN+4VHSzsLR6gxdKoSgzEVn6pi8JkC+w==
X-Received: by 2002:aca:50c2:: with SMTP id e185mr3190553oib.152.1569929945803;
        Tue, 01 Oct 2019 04:39:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x140sm5238929oix.42.2019.10.01.04.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 04:39:05 -0700 (PDT)
Date:   Tue, 1 Oct 2019 06:39:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
Message-ID: <20191001113904.GA1293@bogus>
References: <20190918012856.18963-1-rjones@gateworks.com>
 <20190918012856.18963-2-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918012856.18963-2-rjones@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 17, 2019 at 06:28:55PM -0700, Robert Jones wrote:
> This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
> device-tree bindings.
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/fxos8700.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/fxos8700.txt

Please convert to a DT schema. See Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/fxos8700.txt b/Documentation/devicetree/bindings/iio/imu/fxos8700.txt
> new file mode 100644
> index 0000000..770605d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/fxos8700.txt
> @@ -0,0 +1,15 @@
> +Freescale FXOS8700 - Inertial Measurement Unit with Accelerometer and Magnetometer
> +
> +https://www.nxp.com/products/sensors/motion-sensors/6-axis/digital-motion-sensor-3d-accelerometer-2g-4g-8g-plus-3d-magnetometer:FXOS8700CQ
> +
> +Required properties:
> + - compatible : must be "fsl,fxos8700"
> + - reg : the I2C address or SPI chip select number of the device
> + - spi-max-frequency : set maximum clock frequency (only for SPI)

Looks like the device has 2 interrupts, 2 supplies, and a reset line. 
Please make the binding complete even if the driver or you board doesn't 
support some things yet.

Rob
