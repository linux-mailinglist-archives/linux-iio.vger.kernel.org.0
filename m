Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC36BFBE0
	for <lists+linux-iio@lfdr.de>; Sat, 18 Mar 2023 18:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCRRgA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Mar 2023 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCRRf7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2023 13:35:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0F31BF4;
        Sat, 18 Mar 2023 10:35:56 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.18]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mgf4k-1q9Kq51Vfw-00h9iT; Sat, 18 Mar 2023 18:35:21 +0100
Message-ID: <c0b0929c-41b5-6b9e-8667-e76ac9305981@i2se.com>
Date:   Sat, 18 Mar 2023 18:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 5/8] iio: accel: add support for IIS328DQ variant
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>
References: <20230317103323.7741-1-stefan.wahren@chargebyte.com>
 <20230317103323.7741-6-stefan.wahren@chargebyte.com>
 <20230318155811.0bcf85e1@jic23-huawei>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230318155811.0bcf85e1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dHLkmQBUUBfuNICi6lW+Y88CFIl7yl3WDnzKeRq0UO7C0b91y9g
 2G8Z7vHaxdiIbJ7OgrktXJjegzGeULbkGZb5hnMcXpk5bwjNX4KoCbuOgYQkgs7G87DvVKO
 o1ZUanrHfbB9E3vh+9uGnfp8U7OuCHSnbJ9EN9kc8O/3cANaZkLeqv9o8hwtgDUGjWLg4lj
 vVlFt6jB5kpdPVUHlPXnQ==
UI-OutboundReport: notjunk:1;M01:P0:dcx4nZPZQ9g=;2oy2bb6pk2vcr8L6q7wJeGC3nr3
 KJuBnfBAcIs7Eopztt90O2xitOiH3MuMTNnEszSXQLjYJzn9Lna150O5aMS5lbVHxMLtkweBt
 gCnrKbP7ASitGDxn86tXKDrk5ZVrmTDxxh3AIefuvmAFprwTTvzacxcXomrmg+bCMtzzxD5Cl
 vfghDkQ/51VYSW5ktt+Sut77DIdoI2GQIf0XI8NCqGaopNn3nY28pwz/g506mUgJO8wv0Rm8S
 K0+Zw+Uvn8toxhneSTXBFzBAACYDiaYnhiicMM5Lj6L43A3QQ3RBbexdMJgnGXDx3QQDGA/I6
 63YpTyEGp3mbWODqjZnNt0XCwxEg5nPXmApk8qt2ebFCcVakoYw2hrznv8C2R3oaxueKN0/oL
 MDmLaqhDhGChEXdtKSbpvidqQDyPcKjRR24mRZyU3bSRkStJFktcJ8DnF5PIP9jDRsVkCzXaC
 jt209fUEEf0HJn9DDlePKBy6nAXiMHkwrRmIiqf4z7IuPt9gDuTASgLT+YllRKHWbp/VT6hcq
 /cAxfd9wpijKc6802T2c8y41WMVzl6y5tqvEf7vSL/S6aUTaCHz51YbbQtHnqUg5x06p33Eru
 Z6C941GgXPtDhJ0U7wixrDriRIX7Xw+dNsuM+ubOT5EgBw4X/MF5O4WzVT2DBrYHjEgAzykIc
 7Rrk5xD1EXeY4tPkIwOoB0FssUrV91JZSRI+5v3/Jg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Am 18.03.23 um 16:58 schrieb Jonathan Cameron:
> On Fri, 17 Mar 2023 11:33:20 +0100
> Stefan Wahren <stefan.wahren@chargebyte.com> wrote:
>
>> Since the ST IIS328DQ accelerometer is compatible to the ST LIS331DL,
>> just add the new compatible to the st_accel framework.
>>
>> Link: https://www.st.com/resource/en/datasheet/iis328dq.pdf
>> Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
> Hi Stefan,
>
> Assuming the DT binding is fine with the DT maintainers, I plan to
> pick the pair of IIO fixes up through my tree.  Is there any strong
> reason they should go via another route?

i'm a little bit confused about consider this as "fixes", but i'm fine 
with them going your tree.

Best regards

>
> It's common for the dts files to go via ARM soc in cases like this
> and we tend not to worry that they are 'broken' until the binding docs
> are visible via other trees. Other than that I can't see an obvious
> reason not to split these up.
>
> Thanks,
>
> Jonathan
>
>> ---
>>   drivers/iio/accel/st_accel.h      | 1 +
>>   drivers/iio/accel/st_accel_core.c | 1 +
>>   drivers/iio/accel/st_accel_i2c.c  | 5 +++++
>>   drivers/iio/accel/st_accel_spi.c  | 5 +++++
>>   4 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
>> index 56ed0c776d4a..e7525615712b 100644
>> --- a/drivers/iio/accel/st_accel.h
>> +++ b/drivers/iio/accel/st_accel.h
>> @@ -39,6 +39,7 @@
>>   #define LIS302DL_ACCEL_DEV_NAME		"lis302dl"
>>   #define LSM303C_ACCEL_DEV_NAME		"lsm303c_accel"
>>   #define SC7A20_ACCEL_DEV_NAME		"sc7a20"
>> +#define IIS328DQ_ACCEL_DEV_NAME		"iis328dq"
>>   
>>   
>>   #ifdef CONFIG_IIO_BUFFER
>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>> index 6b8562f684d5..5f7d81b44b1d 100644
>> --- a/drivers/iio/accel/st_accel_core.c
>> +++ b/drivers/iio/accel/st_accel_core.c
>> @@ -517,6 +517,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>>   		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>>   		.sensors_supported = {
>>   			[0] = H3LIS331DL_ACCEL_DEV_NAME,
>> +			[1] = IIS328DQ_ACCEL_DEV_NAME,
>>   		},
>>   		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
>>   		.odr = {
>> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
>> index 3f02fd5d5946..fb9e2d6f4210 100644
>> --- a/drivers/iio/accel/st_accel_i2c.c
>> +++ b/drivers/iio/accel/st_accel_i2c.c
>> @@ -119,6 +119,10 @@ static const struct of_device_id st_accel_of_match[] = {
>>   		.compatible = "silan,sc7a20",
>>   		.data = SC7A20_ACCEL_DEV_NAME,
>>   	},
>> +	{
>> +		.compatible = "st,iis328dq",
>> +		.data = IIS328DQ_ACCEL_DEV_NAME,
>> +	},
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(of, st_accel_of_match);
>> @@ -157,6 +161,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>>   	{ LIS302DL_ACCEL_DEV_NAME },
>>   	{ LSM303C_ACCEL_DEV_NAME },
>>   	{ SC7A20_ACCEL_DEV_NAME },
>> +	{ IIS328DQ_ACCEL_DEV_NAME },
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
>> index 5740dc1820bd..f72a24f45322 100644
>> --- a/drivers/iio/accel/st_accel_spi.c
>> +++ b/drivers/iio/accel/st_accel_spi.c
>> @@ -100,6 +100,10 @@ static const struct of_device_id st_accel_of_match[] = {
>>   		.compatible = "st,lsm303c-accel",
>>   		.data = LSM303C_ACCEL_DEV_NAME,
>>   	},
>> +	{
>> +		.compatible = "st,iis328dq",
>> +		.data = IIS328DQ_ACCEL_DEV_NAME,
>> +	},
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(of, st_accel_of_match);
>> @@ -157,6 +161,7 @@ static const struct spi_device_id st_accel_id_table[] = {
>>   	{ LIS3DE_ACCEL_DEV_NAME },
>>   	{ LIS302DL_ACCEL_DEV_NAME },
>>   	{ LSM303C_ACCEL_DEV_NAME },
>> +	{ IIS328DQ_ACCEL_DEV_NAME },
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(spi, st_accel_id_table);
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
