Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FBC40AED0
	for <lists+linux-iio@lfdr.de>; Tue, 14 Sep 2021 15:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhINNW5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Sep 2021 09:22:57 -0400
Received: from mail.kernelconcepts.de ([188.40.83.200]:45450 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhINNW5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Sep 2021 09:22:57 -0400
Received: from [217.146.132.69] (helo=[192.168.2.34])
        by mail.kernelconcepts.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <florian.boor@kernelconcepts.de>)
        id 1mQ8NR-00033j-4r; Tue, 14 Sep 2021 15:21:33 +0200
Subject: Re: [PATCH v2 1/2] iio: adc: ad799x: Implement selecting external
 reference voltage input on AD7991, AD7995 and AD7999.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com
References: <20210908152525.2946785-1-florian.boor@kernelconcepts.de>
 <20210911174306.16779384@jic23-huawei>
From:   Florian Boor <florian.boor@kernelconcepts.de>
Message-ID: <bda7156d-bf75-65c2-e2b5-b42eca5e0915@kernelconcepts.de>
Date:   Tue, 14 Sep 2021 15:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210911174306.16779384@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: de-AT
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 11.09.21 18:43, Jonathan Cameron wrote:
> On Wed,  8 Sep 2021 17:25:24 +0200
> Florian Boor <florian.boor@kernelconcepts.de> wrote:
> 
>> Make use of the AD7991_REF_SEL bit and support using the external
>> reference voltage if 'vref-supply' is present.
>>
>> Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>
> 
> Hi Florian,
> 
>> ---
>>
>> Changes in v2:
>> - Check if a provided external vref regulator is provided.
>> - Drop unused setting
>> - Add ad79xx documentation (second patch)
>>
>>  drivers/iio/adc/ad799x.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
>> index 18bf8386d50a..2ff926a4e9b3 100644
>> --- a/drivers/iio/adc/ad799x.c
>> +++ b/drivers/iio/adc/ad799x.c
>> @@ -770,6 +770,8 @@ static int ad799x_probe(struct i2c_client *client,
>>  				   const struct i2c_device_id *id)
>>  {
>>  	int ret;
>> +	int extra_config = 0;
>> +	bool vref_external = true;
>>  	struct ad799x_state *st;
>>  	struct iio_dev *indio_dev;
>>  	const struct ad799x_chip_info *chip_info =
>> @@ -797,7 +799,15 @@ static int ad799x_probe(struct i2c_client *client,
>>  	ret = regulator_enable(st->reg);
>>  	if (ret)
>>  		return ret;
>> -	st->vref = devm_regulator_get(&client->dev, "vref");
>> +		
>> +	/* check if an external reference is supplied */
>> +	st->vref = devm_regulator_get_optional(&client->dev, "vref");
>> +
>> +	if (PTR_ERR(st->vref) == -ENODEV) {
>> +		vref_external = false;
>> +		/* get dummy */
>> +		st->vref = devm_regulator_get(&client->dev, "vref");
> 
> Why?  Instead of doing this add if (st->vref) around the regulator
> enable and disable.  We don't want to pretend there is a regulator when
> there isn't one connected and we are using VDD as the reference.
> 
> If we are in that mode, we need to change which regulator is read in
> read_raw()

I have to admit I wondered about how this is handled as well. My idea was not to
change it at this point and improve this later in a separate patch.
But I see the point - I'll add this change as well.

Greetings

Florian

-- 
The dream of yesterday                  Florian Boor
is the hope of today                    Tel: +49(0) 271-338857-15
and the reality of tomorrow.		Fax: +49(0) 271-338857-29
[Robert Hutchings Goddard, 1904]        florian.boor@kernelconcepts.de
                                        http://www.kernelconcepts.de/en

kernel concepts GmbH
Hauptstraße 16
57074 Siegen
Deutschland
Geschäftsführer: Ole Reinhardt
HR Siegen, HR B 9613
