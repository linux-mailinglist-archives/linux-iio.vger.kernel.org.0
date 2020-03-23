Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133DB18FA16
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 17:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCWQlL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 12:41:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2585 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727494AbgCWQlK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 12:41:10 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id D63237D085BF1E6A7091;
        Mon, 23 Mar 2020 16:41:08 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 23 Mar 2020 16:41:08 +0000
Received: from localhost (10.47.90.106) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 16:41:07 +0000
Date:   Mon, 23 Mar 2020 16:41:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
CC:     Jonathan Cameron <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: Re: [PATCH] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
Message-ID: <20200323164102.00005abb@Huawei.com>
In-Reply-To: <d9105fb7-fe0b-d432-fb12-d595c364f83b@topic.nl>
References: <20200316065218.4103-1-mike.looijmans@topic.nl>
        <20200322173704.5cc497c1@archlinux>
        <d9105fb7-fe0b-d432-fb12-d595c364f83b@topic.nl>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.106]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Mar 2020 10:56:41 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> On 22-03-2020 18:37, Jonathan Cameron wrote:
> > On Mon, 16 Mar 2020 07:52:18 +0100
> > Mike Looijmans <mike.looijmans@topic.nl> wrote:
> >   
> >> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
> >> the accelerometer part.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> >> ---
> >>   .../devicetree/bindings/iio/accel/bmi088.txt  | 23 +++++++++++++++++++  
> > 
> > Sorry.  All new DT bindings need to be in yaml format.
> > 
> > Please put this in the same series as the driver.  
> 
> sooy, I noticed this too late, patches are underway in separate mails 
> now. Hope that isn't a blocking issue?

For next version of either pull them together.

Jonathan

> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >>   1 file changed, 23 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/iio/accel/bmi088.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/accel/bmi088.txt b/Documentation/devicetree/bindings/iio/accel/bmi088.txt
> >> new file mode 100644
> >> index 000000000000..691a47726dbc
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/accel/bmi088.txt
> >> @@ -0,0 +1,23 @@
> >> +* Bosch BMI088 IMU combining accelerometer and gyroscope
> >> +
> >> +https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
> >> +
> >> +Required properties:
> >> +
> >> +  - compatible : should be "bosch,bmi088_accel"
> >> +  - reg : the I2C address of the sensor or the SPI chip select number
> >> +
> >> +Optional properties:
> >> +
> >> +  - interrupts : interrupt mapping for GPIO IRQ, it should be configured with
> >> +		 IRQ_TYPE_EDGE_RISING
> >> +
> >> +Example:
> >> +
> >> +bmi088_accel@1 {
> >> +	compatible = "bosch,bmi088_accel";
> >> +	reg = <1>;
> >> +	spi-max-frequency = <10000000>;
> >> +	interrupt-parent = <&gpio>;
> >> +	interrupts = <90 IRQ_TYPE_EDGE_RISING>;
> >> +};  
> >   
> 
> 


