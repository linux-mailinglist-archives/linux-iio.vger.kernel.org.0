Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69EE1B6D94
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 07:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDXFyh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 01:54:37 -0400
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:9888
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbgDXFyh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 Apr 2020 01:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LljQ9mSeYvwRiYARD2L2SLj2sKhSo6rGCjreMhNke1w=;
 b=kRZ1Co9+KT4Y3rgR85sfzPDfo7YZ45KDwKD9Z8Jc/PZlV/aKQMZyL/+2nHQoq1pubM1GG6iNC9T8F0q2IPH9ynQVWiAV8S9ERbp3PuIBR5Iwom7WfsTR8Qop0fJKYin2OHpNyR2AEfL7qfMeyEADI7Wbzx6GKgQYm873c/COjLg=
Received: from DB6PR0801CA0066.eurprd08.prod.outlook.com (2603:10a6:4:2b::34)
 by AM0PR04MB6643.eurprd04.prod.outlook.com (2603:10a6:208:169::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 05:54:30 +0000
Received: from DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::9f) by DB6PR0801CA0066.outlook.office365.com
 (2603:10a6:4:2b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 05:54:30 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; arm.com; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;arm.com; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 DB5EUR01FT064.mail.protection.outlook.com (10.152.5.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.15 via Frontend Transport; Fri, 24 Apr 2020 05:54:29 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (104.47.10.51) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 24 Apr 2020 05:54:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqsgn2yEfErLERcpfc+SOojoNa5T1ANig8fahmcjQpsUbxU24UsMeeJZZiCRxtAEDdERyXDjup53VRcqTHd6/D2OBY+tDUVxlhmR+3RWxN46maakPoD1HYmCWwkpO+3IN+CW7Uh29pkfOiL+ir9QcMUtZZfooaZ1q/U6qEWEm+wrpKUBQ7nsKhtCer/3J7Z7sL8hKGCit+KpgGP7/6NfdBWaDgpzLwF62ZRPPHKLQznT5v57yfy+SX3lqLaPfLIiN+Fb3KWnv4PC2BfXRn1+eSG8Cy1PzeLA/uanGW7DWyD/7nktlutr3aa2AjFttkZKs+MQDMxHQLBjQKl1AZ3l7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LljQ9mSeYvwRiYARD2L2SLj2sKhSo6rGCjreMhNke1w=;
 b=Lq5gktFA5YTdX6m9nXdo9WfDX1/6tHJ3GPyhna/2G0LhFaOM1eq2VxWGdYLyDD8qfSzYNYG0ndWQ9F+TZKf72fJRiHN6EkCVGRVj+QgPI6PHbC0bD5pi/awGGb68WiTmYc66jacRHZEBGaPmH/7ofDM1PacZLoMfu58pXTjeSXYYylyC4FK3u91oKyMzRk3w8793KxK9wXV4Kmi74hW9XPfCqIT9WaV0M9fx9kUXaWAUxZQd6rzvz3647tcztmUj6rZlwkM8sNENMBTex0jBPyFfti/wzaGuoLmGxApI+8qr4HuNU+GX8UuEHVc2W/Zzry0kih6jYRo2Masud+HSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LljQ9mSeYvwRiYARD2L2SLj2sKhSo6rGCjreMhNke1w=;
 b=WkhSrwJdtjkrXzeWrg2z06hAHYjUpzPNr09K91UI5B8r7J3rrV0iF1gKKjcpDnF1x+8+vZ4I5vRUfFyCy8pbS7XOG7j1gMh98pFrAkKu09EjXehmB7UBQeZemP7tQqHJsggECD3EI++mTghB4qo88i+dnbh4WXQ4Lp8BHW5+SQg=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB5738.eurprd04.prod.outlook.com (2603:10a6:10:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 05:54:24 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::1ed:921f:1b:4f0f]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::1ed:921f:1b:4f0f%7]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 05:54:24 +0000
Subject: Re: [PATCH v5 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
To:     Jonathan Cameron <jic23@kernel.org>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
References: <20200324080309.12171-1-mike.looijmans@topic.nl>
 <20200324080309.12171-2-mike.looijmans@topic.nl>
 <20200328162044.7b9992c3@archlinux>
 <51d63f6b-a561-88f3-3718-b04539a7b3be@topic.nl>
 <20200404154847.62a4a35e@archlinux>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <efecaca9-9150-ada3-561f-1eb8a37727b2@topic.nl>
Date:   Fri, 24 Apr 2020 07:54:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200404154847.62a4a35e@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM7PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::28) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM7PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:20b:110::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 05:54:23 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 687d3ee8-98d1-4743-a65d-08d7e813f421
X-MS-TrafficTypeDiagnostic: DB8PR04MB5738:|AM0PR04MB6643:
X-Microsoft-Antispam-PRVS: <AM0PR04MB66433EB9B62BE733811E4EE996D00@AM0PR04MB6643.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(346002)(376002)(396003)(39840400004)(136003)(6486002)(26005)(2906002)(44832011)(66946007)(66476007)(66556008)(5660300002)(4326008)(31686004)(83170400001)(6916009)(31696002)(8936002)(53546011)(16526019)(8676002)(36756003)(81156014)(186003)(316002)(36916002)(52116002)(2616005)(42882007)(508600001)(16576012)(956004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vgql90YWTUaPxQ6bEwXRTPZS2lLQ8lqwkytdNNh3o/VBU1o1mfEQ5+a+GhUZs0Ic56GjW96LQRlnQn91X5k6dTFO332fY6MIub/7eT08m3s0I5lrYk/kQcC1skNJR+3lsHcpYi8O/RcAv925U3SHPmgg4N5fbUGo4L2Sa7CVDkTtA042MCjYyUWgnGnY9KBrTNcS/ZXIqaF+/t4EmhF3zo1j7xBzaPao/SGeeikYFQ+MOt+TbOF/mR47ipne80+jZaVRE0kFaOzA5oxA2ot2jr3OZT9/OlKSzkDjOxO2L8oU3s6KDJYpyDO73Hp0WDrRqS9nJlqIDEuhsEtrotx0hF4KSMXWZiOeUC89m+vqz/De6TeemFCCk3VKIzb40NqS4VC5rM8OBamR7orbKL+Vv+bJWs4MS3lOWwevvo+FmwXqOlRWQ9as9ZuHChN9GHuF
X-MS-Exchange-AntiSpam-MessageData: 7u9BACQYl9iV0yZrL/W1QM1iOQnQ/eBw8dyyfkZsLLimJzt21cgZ5XCNS9+S3fW9y9Oz2JFvsbx2TguGK1YdGyI2U8W32e0PB/7FUbGyRNc+BeJtYHbheqypYoDPEeHIdGQxJXjcNf3WvNARM5lQvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5738
X-CodeTwo-MessageID: fa4a5c92-7b20-4f4e-9101-76e53d652197.20200424055427@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu13-emailsignatures-cloud.codetwo.com;PTR:westeu13-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(376002)(39840400004)(46966005)(47076004)(36916002)(186003)(336012)(356005)(42882007)(16526019)(83170400001)(4326008)(7596003)(2616005)(956004)(31686004)(44832011)(508600001)(70586007)(82310400002)(26005)(7636003)(70206006)(36756003)(31696002)(8936002)(246002)(6486002)(53546011)(6916009)(316002)(5660300002)(16576012)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3f63e5b6-3774-4cee-9cec-08d7e813f0da
X-Forefront-PRVS: 03838E948C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ac0L5AK83r8OUa0HOtjXKjjtnca4yn4pvv/UDJfYX4wUCXsXNQNinm7N9KsDntdea1PwDyZ2HZLnQ65vj7Im8MALVV5AH3l1E2GHfS3tI/8vQTTfZVLLEDDWG/MgWqtyYgPark1rYd3udXhucB1/7ZBCitUU/BrO+LTnpAhmQUSedKIOgdYQVzANVr+yPqbUbOahF7cpwOO86VKa6cuTY9y4PlGqGVjnXrMtFEVO+8f8rlPmX+cNSqFuIwmICOZUlksxQ8EBms7NOoMnUTJJ1wBgvm2bRjhVpCRyrWgeK/gwFN+YAWdRl91BVgg1FxVlZeuGInsjUMAaLSlXmJZAqPAUh+AyzgWmLl8PbmZpllNCi6BOnfPacdMOoHVwhquO6IfYE7dUqMqyE7E2NnvrH1G4hG/O3THD0YF1SwmTvNh6MWTXZkzY8MulJ2+wCkBOkFzP54yDM+0EEmrD9bV5S/17MA3Qg6MTXxSCb37rg/RT90t5cX4gC8WmVrRBjnzLzGjnLb06uQ/QonCFnSmr1Q==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 05:54:29.2333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687d3ee8-98d1-4743-a65d-08d7e813f421
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6643
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Just an update, there'll be a v6 but I currently don't have access to 
the board for testing.

On 04-04-2020 16:48, Jonathan Cameron wrote:
> On Mon, 30 Mar 2020 10:07:00 +0200
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>> On 28-03-2020 17:20, Jonathan Cameron wrote:
>>> On Tue, 24 Mar 2020 09:03:08 +0100
>>> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>>>    
>>>> The BMI088 is a combined module with both accelerometer and gyroscope.
>>>> This adds the accelerometer driver support for the SPI interface.
>>>> The gyroscope part is already supported by the BMG160 driver.
>>>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> Hi Mike,
>>>
>>> A few tiny things from me.
>>>
>>> For the sampling frequency, I wonder if we are better off going back
>>> to the list of values, but then also using the read_avail infrastructure
>>> to avoid having to carry them as a string as well?
>> The frequency range is just a simple power-of-two formula, so my take
>> was that a table would just be a waste of memory and resources.
>>
>> A table lookup costs more resources and requires more code in this case.
> True, but the table is still there be it in string form  in order
> to provide the 'available' list.
>
> For reasons of simplicity in the IIO core, the read_avail callbacks
> deal with tables of numbers like was originally the case here.
>
>
>>> Thanks,
>>>
>>> Jonathan
>>>    
>>>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>>>> index 5d91a6dda894..7ed9c82b731b 100644
>>>> --- a/drivers/iio/accel/Kconfig
>>>> +++ b/drivers/iio/accel/Kconfig
>>>> @@ -151,6 +151,23 @@ config BMC150_ACCEL_SPI
>>>>    	tristate
>>>>    	select REGMAP_SPI
>>>>    
>>>> +config BMI088_ACCEL
>>>> +	tristate "Bosch BMI088 Accelerometer Driver"
>>>> +	select IIO_BUFFER
>>>> +	select IIO_TRIGGERED_BUFFER
>>>> +	select REGMAP
>>>> +	select BMI088_ACCEL_SPI
>>>> +	help
>>>> +	  Say yes here to build support for the Bosch BMI088 accelerometer.
>>>> +
>>>> +	  This is a combo module with both accelerometer and gyroscope.
>>>> +	  This driver is only implementing accelerometer part, which has
>>>> +	  its own address and register map.
>>>> +
>>>> +config BMI088_ACCEL_SPI
>>>> +	tristate
>>>> +	select REGMAP_SPI
>>>> +
>>> Hmm. So we list this driver even if SPI is disabled.  Generally we try
>>> not to do that, as it makes for lots of things to pick on devices that
>>> don't actually have an SPI bus.
>>>
>>> Hence, please add a depends to the first Kconfig symbol so it's hidden
>>> if no SPI.  When I2C is added it can become at least one of the two.
>>>    
>> I'm okay with a depends on SPI. Adding the I2C support is not difficult,
>> but I don't want to release something into the kernel that I cannot test.
> Agreed.  Just add the depends on SPI.  I was just looking forwards to yourself
> or someone else adding I2C when they do have a platform to test it.
>
>
>>
>>> ...
>>>    
>>>> +
>>>> +static int bmi088_accel_get_sample_freq(struct bmi088_accel_data *data,
>>>> +					int *val, int *val2)
>>>> +{
>>>> +	unsigned int value;
>>>> +	int ret;
>>>> +
>>>> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
>>>> +			  &value);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	value &= BMI088_ACCEL_MODE_ODR_MASK;
>>>> +	if (value == BMI088_ACCEL_MODE_ODR_12_5) {
>>>> +		*val = 12;
>>>> +		*val2 = 500000;
>>>> +		ret = IIO_VAL_INT_PLUS_MICRO;
>>>> +	} else {
>>>> +		*val = 25 << (value - BMI088_ACCEL_MODE_ODR_25);
>>>> +		*val2 = 0;
>>>> +		ret = IIO_VAL_INT;
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
>>>> +{
>>>> +	unsigned int value;
>>>> +
>>>> +	if (val < 12 || val > 1600)
>>>> +		return -EINVAL;
>>>> +
>>>> +	value = fls(val) + 1;
>>> This leads to some 'novel' rounding to my mind.
>>>
>>> (12,16] = 12.5
>>> (16,32] = 25
>>> (32,64] = 50
>>> (64,128] = 100
>>>
>>> Generally we want to go faster if anything when talking about sampling frequencies,
>>> so I'd either like to see round up or precise value matching only.
>> I went for simplicity. The driver reports an "avail" range, so users
>> should not expect other values like "70" to actually work. The above is
>> the shortest inversion of the get_sample_freq function.
> That's a bold assumption to make about userspace doing what it should
> and checking _avail before writing crazy values.   A not entirely stupid
> optimization would be to write without checking _avail and only do the
> handling of that if the write fails (indicating that whatever value was
> provided by some user isn't fine).
>
>
>> Just wanted to make it so that obvious things would work, and I feared
>> that a range would require one to spec "100.000" in decimal format just
>> because of the existence of the 12.5 value. So the driver is a bit
>> forgiving in that specifying "12" or "13" will also work.
>>
>> For a more exact match I could also add something like:
>>
>> if (val > 13 && (25 << (value - BMI088_ACCEL_MODE_ODR_25 ) != val)
>>      return -EINVAL;
>>
>> this would return -EINVAL for values like "26" or "1599".
> Given the way the IIO core works, it will be perfectly happy to present
> you with precise values.  If the val == 12, then check the val2 == 5
> For the rest just check if the val is correct and val2 == 0.
>
> If decimal part is not provide val2 will be equal to 0.
>
> I'm still falling on the side of thinking a table of values is simpler,
> less bug prone (because it's just a case of linear search for a match)
> and if you use read_avail callback can handle that case as well without
> needing to repeat values.  Memory cost of the
> table is tiny 8 * 4 * 2 = 64 bytes.
>
> It's not exactly a huge list of possibilities.
>
> Jonathan
>
>>>    
>>>> +
>>>> +	return regmap_update_bits(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
>>>> +				  BMI088_ACCEL_MODE_ODR_MASK, value);
>>>> +}
>>>> +
>>> ...
>>>    
>>>> +
>>>> +static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
>>>> +				 struct iio_chan_spec const *chan,
>>>> +				 int *val, int *val2, long mask)
>>>> +{
>>>> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>>>> +	int ret;
>>>> +
>>>> +	switch (mask) {
>>>> +	case IIO_CHAN_INFO_RAW:
>>>> +		switch (chan->type) {
>>>> +		case IIO_TEMP:
>>>> +			return bmi088_accel_get_temp(data, val);
>>>> +		case IIO_ACCEL:
>>>> +			ret = iio_device_claim_direct_mode(indio_dev);
>>>> +			if (ret)
>>>> +				return ret;
>>>> +
>>>> +			ret = bmi088_accel_get_axis(data, chan, val);
>>>> +			iio_device_release_direct_mode(indio_dev);
>>>> +			if (ret)
>>>> +				return ret;
>>>> +
>>>> +			return IIO_VAL_INT;
>>>> +		default:
>>>> +			return -EINVAL;
>>>> +		}
>>>> +	case IIO_CHAN_INFO_OFFSET:
>>>> +		switch (chan->type) {
>>>> +		case IIO_TEMP:
>>>> +			/* Offset applies before scale */
>>>> +			*val = BMI088_ACCEL_TEMP_OFFSET/BMI088_ACCEL_TEMP_UNIT;
>>>> +			return IIO_VAL_INT;
>>>> +		default:
>>>> +			return -EINVAL;
>>>> +		}
>>>> +	case IIO_CHAN_INFO_SCALE:
>>>> +		*val = 0;
>>> Why?  In error paths it's not used, and it's set in the other two paths.
>> will remove
>>
>>>    
>>>> +		switch (chan->type) {
>>>> +		case IIO_TEMP:
>>>> +			/* 0.125 degrees per LSB */
>>>> +			*val = BMI088_ACCEL_TEMP_UNIT;
>>>> +			return IIO_VAL_INT;
>>>> +		case IIO_ACCEL:
>>>> +			ret = regmap_read(data->regmap,
>>>> +					  BMI088_ACCEL_REG_ACC_RANGE, val);
>>>> +			if (ret)
>>>> +				return ret;
>>>> +
>>>> +			*val2 = 15 - (*val & 0x3);
>>>> +			*val = 3 * 980;
>>>> +
>>>> +			return IIO_VAL_FRACTIONAL_LOG2;
>>>> +		default:
>>>> +			return -EINVAL;
>>>> +		}
>>>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>>>> +		mutex_lock(&data->mutex);
>>>> +		ret = bmi088_accel_get_sample_freq(data, val, val2);
>>>> +		mutex_unlock(&data->mutex);
>>>> +		return ret;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +}
>>>> +
>>> ...
>>>    
>>

-- 
Mike Looijmans

