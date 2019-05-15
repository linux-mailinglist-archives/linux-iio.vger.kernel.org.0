Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7B1FA34
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2019 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEOSq4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 May 2019 14:46:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726466AbfEOSqz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 May 2019 14:46:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FIgbaP031526
        for <linux-iio@vger.kernel.org>; Wed, 15 May 2019 14:46:54 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgnshqw5b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Wed, 15 May 2019 14:46:54 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.ibm.com>;
        Wed, 15 May 2019 19:46:53 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 19:46:49 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FIkmGI10092890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 18:46:48 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BCB4BE053;
        Wed, 15 May 2019 18:46:48 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A52B6BE058;
        Wed, 15 May 2019 18:46:47 +0000 (GMT)
Received: from [9.85.187.56] (unknown [9.85.187.56])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 May 2019 18:46:47 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] iio: Add driver for Infineon DPS310
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de
References: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
 <1557344128-690-2-git-send-email-eajames@linux.ibm.com>
 <20190511102236.4c5f9585@archlinux>
From:   Eddie James <eajames@linux.ibm.com>
Date:   Wed, 15 May 2019 13:46:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511102236.4c5f9585@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19051518-0004-0000-0000-0000150F21D2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011102; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01203786; UDB=6.00631896; IPR=6.00984712;
 MB=3.00026906; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-15 18:46:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051518-0005-0000-0000-00008BACCF8F
Message-Id: <cf108058-dd50-4651-6c97-a5c7e82ef085@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150113
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 5/11/19 4:22 AM, Jonathan Cameron wrote:
> On Wed,  8 May 2019 14:35:26 -0500
> Eddie James <eajames@linux.ibm.com> wrote:
>
>> From: Joel Stanley <joel@jms.id.au>
>>
>> The DPS310 is a temperature and pressure sensor. It can be accessed over
>> i2c and SPI.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Hi Eddie,
>
> Ideally we'll get a sign off form Joel as well on this.
>
> A few comments inline.
>
> I 'think' this is probably fine without any locking to prevent simultaneous reads
> and /or writes to the registers because the few functions that do multiple reads
> and writes look fine.  Please do take another look at that though to confirm there
> are no corner cases.
>
> Otherwise there is a race in the remove path that needs fixing.
> Various minor bits and bobs inline.
>
> thanks,
>
> Jonathan
>
>
>
>> ---
>>   MAINTAINERS                   |   6 +
>>   drivers/iio/pressure/Kconfig  |  10 +
>>   drivers/iio/pressure/Makefile |   1 +
>>   drivers/iio/pressure/dps310.c | 429 ++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 446 insertions(+)
>>   create mode 100644 drivers/iio/pressure/dps310.c
>>

>> +};
>> +MODULE_DEVICE_TABLE(i2c, dps310_id);
>> +
>> +static const unsigned short normal_i2c[] = {
>> +	0x77, 0x76, I2C_CLIENT_END
>> +};
>> +
>> +static struct i2c_driver dps310_driver = {
>> +	.driver = {
>> +		.name = "dps310",
>> +	},
>> +	.probe = dps310_probe,
>> +	.remove = dps310_remove,
>> +	.address_list = normal_i2c,
> I'm fairly sure the address list is only used along with the detection
> infrastructure.  As such it doesn't actually provide any value unless
> you have a detect callback.  Please remove.
>
> I would like to see a DT and/or ACPI binding though as that is the
> means most people will use to find the device.


Somehow the device is already present in the witherspoon device tree 
where it's currently being used, so I don't have anything to add. 
arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts

Thanks,

Eddie


>
>> +	.id_table = dps310_id,
>> +};
>> +module_i2c_driver(dps310_driver);
>> +
>> +MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
>> +MODULE_DESCRIPTION("Infineon DPS310 pressure and temperature sensor");
>> +MODULE_LICENSE("GPL v2");

