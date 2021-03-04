Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A433C32CFB4
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 10:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbhCDJcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Mar 2021 04:32:14 -0500
Received: from smtp2.macqel.be ([109.135.2.61]:18164 "EHLO smtp2.macqel.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237532AbhCDJcI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 Mar 2021 04:32:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp2.macqel.be (Postfix) with ESMTP id 48514130D36;
        Thu,  4 Mar 2021 10:31:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
        by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ykgT+V8jnGE1; Thu,  4 Mar 2021 10:31:19 +0100 (CET)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
        by smtp2.macqel.be (Postfix) with ESMTP id 098CE130CB5;
        Thu,  4 Mar 2021 10:31:19 +0100 (CET)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id E7D1EDF009D; Thu,  4 Mar 2021 10:31:18 +0100 (CET)
Date:   Thu, 4 Mar 2021 10:31:18 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: invensense mpu9250 ak8963 and devicetree
Message-ID: <20210304093118.GA29240@frolo.macqel>
References: <20210303153145.GA30260@frolo.macqel> <BL0PR12MB50118E81AC1B92F530C4A7B0C4979@BL0PR12MB5011.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL0PR12MB50118E81AC1B92F530C4A7B0C4979@BL0PR12MB5011.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jean-Baptiste,

thank you for your answer

I work actually with a nvidia-provided 4.9 kernel that I cannot change.
Up to now I have incorporated the mpu9250 related patches up to v4.12.

Do you think I should simply replace the inv_mpu6050 driver files of v4.9
by their v5.11 (or newer) counterparts ?

Thanks

Philippe

On Thu, Mar 04, 2021 at 09:12:47AM +0000, Jean-Baptiste Maneyrol wrote:
> Hello Philippe,
> 
> I would recommend letting mpu9250 chip drives the magnetometer instead of using the ak8963 driver.
> 
> This is simpler to use and guarantees a good synchronization between all sensors and no possible latency coming from kernel scheduling when polling the magnetometer. And it enables the use of spi bus for connecting the device.
> 
> You just need to define mpu9250 dts without an i2c-gate, and delete all definition of ak8963 chip.
> 
> Best regards,
> JB
> 
> 
> From: Philippe De Muyter <phdm@macq.eu>
> Sent: Wednesday, March 3, 2021 16:31
> To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> Subject: invensense mpu9250 ak8963 and devicetree 
>  
> Hello,
> 
> I am trying to use a mpu9250 imu, but I have trouble with the ak8963 part.
> 
> Currently, ak8975_probe fails in this code :
> 
>         /* Fetch the regulators */
>         data->vdd = devm_regulator_get(&client->dev, "vdd");
>         if (IS_ERR(data->vdd))
>                 return PTR_ERR(data->vdd);
>         data->vid = devm_regulator_get(&client->dev, "vid");
>         if (IS_ERR(data->vid))
>                 return PTR_ERR(data->vid);
> 
> but Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> says :
> 
>   vdd-supply:
>     description: |
>       an optional regulator that needs to be on to provide VDD power to
>       the sensor.
> 
> I have no vdd or vdd-supply property in my ak8963 description.
> 
> Is that unrelated ?
> 
> What should I write in my dts file for this ak8963 embedded in a mpu9250 ?
> 
> Thanks in advance
> 
> Philippe
> 
> -- 
> Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
