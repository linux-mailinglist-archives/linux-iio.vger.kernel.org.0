Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA218CCB
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 17:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfEIPRX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 11:17:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726448AbfEIPRW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 11:17:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49F4ijU033810
        for <linux-iio@vger.kernel.org>; Thu, 9 May 2019 11:17:21 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2scn6b4yuu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 11:17:20 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 9 May 2019 16:17:20 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 May 2019 16:17:16 +0100
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x49FHFVh52953304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 May 2019 15:17:15 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DE656A047;
        Thu,  9 May 2019 15:17:15 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C366E6A051;
        Thu,  9 May 2019 15:17:14 +0000 (GMT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 May 2019 15:17:14 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] iio: dps310: Temperature measurement errata
To:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Eddie James <eajames@linux.ibm.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, joel@jms.id.au,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
References: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
 <1557344128-690-3-git-send-email-eajames@linux.ibm.com>
 <CAJCx=gn0Yv+oP56HQQNm-9JbH2aoZuEQ-73b1grLTVNfbYsDsg@mail.gmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Thu, 9 May 2019 10:17:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJCx=gn0Yv+oP56HQQNm-9JbH2aoZuEQ-73b1grLTVNfbYsDsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19050915-0016-0000-0000-000009AFBDAF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011077; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01200873; UDB=6.00630127; IPR=6.00981763;
 MB=3.00026812; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-09 15:17:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050915-0017-0000-0000-00004325D175
Message-Id: <5217daa3-4f43-0fce-5d1f-438f8c9e47bb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090088
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 5/8/19 10:09 PM, Matt Ranostay wrote:
> On Thu, May 9, 2019 at 3:36 AM Eddie James <eajames@linux.ibm.com> wrote:
>> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>>
>> Add a manufacturer's suggested workaround to deal with early revisions
>> of chip that don't indicate correct temperature. Readings can be in the
>> ~60C range when they should be in the ~20's.
>>
>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/iio/pressure/dps310.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
>> index 7afaa88..c42808e 100644
>> --- a/drivers/iio/pressure/dps310.c
>> +++ b/drivers/iio/pressure/dps310.c
>> @@ -221,6 +221,9 @@ static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
>>          case DPS310_MEAS_CFG:
>>          case DPS310_CFG_REG:
>>          case DPS310_RESET:
>> +       case 0x0e:
>> +       case 0x0f:
>> +       case 0x62:
> What is with the magic values? Are they not documented to what they
> are, and hence not defining enum values for them?
>
> - Matt


Thats correct. These don't show up in the data sheet so I left them as 
raw values. Chris, do you know what the source for these values was?

Thanks,

Eddie


>
>>                  return true;
>>          default:
>>                  return false;
>> @@ -237,6 +240,7 @@ static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
>>          case DPS310_TMP_B1:
>>          case DPS310_TMP_B2:
>>          case DPS310_MEAS_CFG:
>> +       case 0x32:
>>                  return true;
>>          default:
>>                  return false;
>> @@ -314,7 +318,7 @@ static int dps310_read_raw(struct iio_dev *iio,
>>          .writeable_reg = dps310_is_writeable_reg,
>>          .volatile_reg = dps310_is_volatile_reg,
>>          .cache_type = REGCACHE_RBTREE,
>> -       .max_register = 0x29,
>> +       .max_register = 0x62,
>>   };
>>
>>   static const struct iio_info dps310_info = {
>> @@ -322,6 +326,47 @@ static int dps310_read_raw(struct iio_dev *iio,
>>          .write_raw = dps310_write_raw,
>>   };
>>
>> +/*
>> + * Some verions of chip will read temperatures in the ~60C range when
>> + * its actually ~20C. This is the manufacturer recommended workaround
>> + * to correct the issue.
>> + */
>> +static int dps310_temp_workaround(struct dps310_data *data)
>> +{
>> +       int r, reg;
>> +
>> +       r = regmap_read(data->regmap, 0x32, &reg);
>> +       if (r < 0)
>> +               return r;
>> +
>> +       /*
>> +        * If bit 1 is set then the device is okay, and the workaround does not
>> +        * need to be applied
>> +        */
>> +       if (reg & BIT(1))
>> +               return 0;
>> +
>> +       r = regmap_write(data->regmap, 0x0e, 0xA5);
>> +       if (r < 0)
>> +               return r;
>> +
>> +       r = regmap_write(data->regmap, 0x0f, 0x96);
>> +       if (r < 0)
>> +               return r;
>> +
>> +       r = regmap_write(data->regmap, 0x62, 0x02);
>> +       if (r < 0)
>> +               return r;
>> +
>> +       r = regmap_write(data->regmap, 0x0e, 0x00);
>> +       if (r < 0)
>> +               return r;
>> +
>> +       r = regmap_write(data->regmap, 0x0f, 0x00);
>> +
>> +       return r;
>> +}
>> +
>>   static int dps310_probe(struct i2c_client *client,
>>                          const struct i2c_device_id *id)
>>   {
>> @@ -383,6 +428,10 @@ static int dps310_probe(struct i2c_client *client,
>>          if (r < 0)
>>                  goto err;
>>
>> +       r = dps310_temp_workaround(data);
>> +       if (r < 0)
>> +               return r;
>> +
>>          r = devm_iio_device_register(&client->dev, iio);
>>          if (r)
>>                  goto err;
>> --
>> 1.8.3.1
>>

