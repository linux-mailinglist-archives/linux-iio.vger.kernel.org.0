Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7554310D4
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 08:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhJRGvt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 02:51:49 -0400
Received: from mail-eopbgr80135.outbound.protection.outlook.com ([40.107.8.135]:45189
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229847AbhJRGvs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 02:51:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKDpZK3OLOx+I9mJoFTgAHClubVdCWrGX7bifjKX4bMTCG12xdXug8FZrx7Crb0xuMIhR+kDxll/3jsIjnrY/dQCzYjPWRptYn5byctwIKkEeAAHqwbIfPllmcBmZc4Jhsz4Fftcp9Oi4G/WMc4ID3NZAZgLXwoxKJEWVlI2Krv67+ev5vkhDbL0ZTMRHlvd8SUCaqQZ8mtZfeiklZP8yxPqTNULcxfk4L0sFvIGnk5eU7ZH9+lRStHAsY9jNAOQRKIqEBxG/QvnwLcQXUjGfsbkzkeq56tSym/Y4vgz5KfX5nU0YefxwI6Xj5fajg4rTj5efpyzubRFU+IQNVrcJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDydd1P+DxbC8mze/DQEWuqYi3mfxRcSISxbUUJuph4=;
 b=SIFCC0LWNcpEOt5awv5dBa49OGLA/uE+lmnkPYJRM6/4JctyK50f7GmpG3vJjMYEdj3KXq6gL8+1CnojZx/gCNjpDYwCUCLdMKwD1UW2nX2ELn4MV6pemisYGlgVqTurAieKchQat5tlyi08OJX/DMkXDt1LVEMhNd7h0vwas1YFWo9wt33SAfFE3SjJVn4dGI3zn7aphz1WO2mnQC+1T2K6UzNdPI+0nDggr1zzpzOofuys/af+ghD/hSrubMvICoSIwzknLsQqI6Ie7AG+86Tw5cHCrNpF4PFXHXwPbtMby6TT4YjwRnSC37gYdh/psA/EgHqG7FrlrbWeChNERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDydd1P+DxbC8mze/DQEWuqYi3mfxRcSISxbUUJuph4=;
 b=BXVRv4oAwrwRraAr3Rjz5RsXQy0xpRZL3cpv07TfDLST/ocTgA6vDgkfCEe+eh/xXh6I8SzxWA8ocIvkV31pWOBpMK5SMrY/whwBByVLg7MVFtz9kPxXtFWT7tCGFhpHEJMMLkQkNCWk0M+2O5m5n7IuSiHuXDnABABTfSZ59/I=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=opensynergy.com;
Message-ID: <1900fc73-c57b-5001-6aaa-7b85214da267@opensynergy.com>
Date:   Mon, 18 Oct 2021 09:49:32 +0300
Subject: Re: [PATCH v5 1/1] iio/scmi: Add reading "raw" attribute.
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
References: <20211008182826.24412-1-andriy.tryshnivskyy@opensynergy.com>
 <20211008182826.24412-2-andriy.tryshnivskyy@opensynergy.com>
 <20211017125138.4f5bbc4d@jic23-huawei>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <20211017125138.4f5bbc4d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::7) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6dfb6b3-fcda-47bf-89e7-08d9920371c4
X-MS-TrafficTypeDiagnostic: AM6PR04MB4232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4232C6FE3A68A9C6F97DE8BAE6BC9@AM6PR04MB4232.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRt9q8X9mxTmD1nAnh3DUqv2VqXwLDsFH+dywIJxyk8SOUpfhMefSk/k9V+ZeIvdA2PC+vP79hTsvCHl6HQZXAwuKrI7ZHCZ8JVt5wB2V0Geq606QwaMJV5z6SZqEalEgE3E7vLPDPC0Ia6NQZKYm3XPQ9ZTsJQ3UNc+ZHSRZpWxR7Gjayr5T+mFkotUEeNXxUSlgDntncgxc+2xyDv34su/XS5LnRt5uptyux6QL9ShIH4N/ebn2Lj34xjO9TsSunzjCo/B5uuvyo7kSIUhs2TxAIpf270jtFKNTPLKLCGQITzvjDD/YFAHmlbl8qKqh4fb/z0iAEwXT+tSqDOdPau5szLEJUr8NDLdMvo/fOPW2u4bWOakVJvUA17c6uYwAg1Wfxh4JvnYQUuoo58ING+p5NZITtPEkcemsMowLDVfslJLoRajE30KjdnypCo2kscCUddBlJCfr+6taRSmoULy/gp7R7fxPKuYH592Yybbupr2ckrgySrcpCX3w0W+AZD+aWoMy7Lk/D7MtDvYh3MwoPCUfs5h3udFxnYI0tWf5934yEmBPv03yycdwbSV3mOHDd+IPT9XU/jpbYRLsX0nnTKErOtXw1rrEqY4szLKPZwWcujtckdMt8MKyMrAw92BiMyrfER63q5+x3B37Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39830400003)(346002)(136003)(6916009)(53546011)(55236004)(107886003)(5660300002)(186003)(86362001)(31686004)(42186006)(508600001)(38100700002)(26005)(2616005)(31696002)(83380400001)(44832011)(66946007)(8676002)(2906002)(36756003)(8936002)(66476007)(66556008)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzh4VytlWXB5MXZoVkZOcWVFYmp3aGZ3SE9GZ0hPdkh0Y0IrVHV3RW0rWll5?=
 =?utf-8?B?Vm13L1B3SFVzbmtYQ2drSmY2aEsyZWQxLy9DaWFCUVJvYmtCcHk0NVpuYWRz?=
 =?utf-8?B?ckI0YmlqbGhCTERXU2ZIZW81M0dCbStLSHZpTjhlKytwUlk0U3FKeUxQb3JR?=
 =?utf-8?B?cCtJcEg5U0JlUWVIZkxEYmt0NnZubzQyVkx3QXhoN1RFL05YdDZ0ZUU3RXN0?=
 =?utf-8?B?dUZ2cm0yMjI5eDZPQUxMVUdKaHA1OUlxL2pSZ0VFWDF1SHVPSWs4cmFCai80?=
 =?utf-8?B?dm5mZWg2NDVPdjhIYjhhcTVOT3RUSnVEcVV5MGFJR2plRTdWbTI0a1ErSDNa?=
 =?utf-8?B?alN0S2tTNHB6OHRnbTJreUF0V3RVeWVkSWFYZDF1ZGpWam93K0pEOWRJSkE5?=
 =?utf-8?B?c1pReVhHdGlyYlRjRFNoWSs2KzhpRFVuRVhabWgvdkVnNVFIU09nSU5KSkdY?=
 =?utf-8?B?UVcrbGZaSFIzTnRIS2VnU21QRERibWNUdEpkNnhTTDM0ald6NDU5aklUVStB?=
 =?utf-8?B?WFYvVkVjUXhaVzRmUFR5a21WdVBqZDVOSUR6Sjc5Z0g1b0FjOVc1S3Z3akJl?=
 =?utf-8?B?MS9lV0lWaGE3ODFRVy9OOTloQmY3VjFaQ1Fhc0Y4bjZyemc5eTlUMlBDdk00?=
 =?utf-8?B?UnhVeXdXTG44UitRL05GclU0MEJCMUlpOUwwRzF6bjFnYzAzYkNuV1VUNVNH?=
 =?utf-8?B?TFdHUjVJUUE4dk9zTWJuWG1BUjVsMlJCZlhqY2pNL1B4QTNuMERlUWo1Rmk1?=
 =?utf-8?B?NUlVTFpSUmtHVXBjdkxvM1JNa1RHMnRzbDNJZ1g1cklYMFVPZTQ3K2VDeUdv?=
 =?utf-8?B?TldoeUV0UlhSSytmTVFXS3piL1A4OGxNVUREWUE3cWVyb3hIcnk2VTRGbzRa?=
 =?utf-8?B?eUcxdUJidkUxZHFHYXhzNmx6cWdJMjdpMUx3R2lsanAvck4xOHFKMUtrNHNn?=
 =?utf-8?B?OVE2VCtFaTlQN05leGtKQ1hZY1pRYzgzdC91aGlKVy9Ea3VNbVdIckxydEVj?=
 =?utf-8?B?aWQ3KytYYXVvTGltbTFId1FOdURwNklhSEFpcTNIc0tHYXkxTTdKUVlLOWow?=
 =?utf-8?B?OGhMSGdsYWFsSlBvTjA1YmR1WkVLUnNWWnZ0WE1UWHY0VUI2Yk9TeUYybnFi?=
 =?utf-8?B?NEpFQ1ZPdS8wNlppWWVuWGN2MFMyemkxSFJpekNIbG1nUU13M3FtbkRuWjlO?=
 =?utf-8?B?cjV6ZFhvRmp2b0Y0T3NJUEV3RU43QkFQQzk1aDZzbVNYNU9rd1hDZ0Qwbk1y?=
 =?utf-8?B?eUdPQkhRekJZQ2YzMjVmQThkN3B0Wml4NWE1NUt1dmMwdTlnZnI1ZXRQZkxJ?=
 =?utf-8?B?L3dQRU15ZDFEdWJJNU91SCtJNlR4ZE55N01UZGpLOVBSY2FwN1h0Q2Y3TUo2?=
 =?utf-8?B?VzVoWmVUQkVxSEtSNnhYUlhFK1M2YmFRVTlPOTNhUUdxalVkK0lHb1JIQXl3?=
 =?utf-8?B?SlVwUTZSV01udHZxT2N1MnZZRjYzTjNUQWE4M2RPK2xvclRNU2JYL0piaFlU?=
 =?utf-8?B?VXk1SDBrYUhZY0dYbGJNWGh3RVZVaHBmeGovVWdvVVVZalNsclFzYXFVVmpp?=
 =?utf-8?B?b3h5L1QvOVI3VzhPSnNGaEl2OCtDb2lId0xZekRYSFYxd2cwYTBMTWw3bGdk?=
 =?utf-8?B?SCt5ZWdneHhodzhQT1V4WmdBUnNwTzIwV1FaNlZrRVgxWVJxMDE2U3lhQm1I?=
 =?utf-8?B?VjZWTG14c2lLNEZ0TDJOTDNrTmRtSm10QS9oZVpDQ3lKZ3F3MElwTktpeXcy?=
 =?utf-8?Q?6kaWweK4rEm4sEtHXmW6P0XMk2GN61twNTOC9O6?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dfb6b3-fcda-47bf-89e7-08d9920371c4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 06:49:34.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kihAAQ9EQwrjkigCJzUi0/8Mtsm9Bm4A0RY/4YWxfArccs4wpuV7RoDLo4+3nsqfB00nwcvVt6Jd6ssizObzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4232
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 17.10.21 14:51, Jonathan Cameron wrote:

> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Fri,  8 Oct 2021 21:28:26 +0300
> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>
>> Add scmi_iio_get_raw() to read "raw" attribute.
>>
>> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
>> ---
> For a single patch series, it is better to put a change log in the patch (here)
> Whilst I can see why you would use this approach rather than the read_raw callback
> there are significant disadvantages in doing so.  The channel can't be used
> by in kernel users such as iio-hwmon.   That may cause you more trouble than
> it is worth in the long run.
>
> Note that you could also define a new IIO_VAL type to still use the two
> (possibly) 32 bit values and return a 64 bit value. That way, with appropriate
> additions in the consumer drivers the channel could still be used.
>
> IIO_VAL_INT_64 perhaps with val as the lower 32 bits and val2 as the upper
> with appropriate care around the sign.

Hi Jonathan,

In the past I also was thinking about introducing a new type to return 64 bits value - IIO_VAL_INT_LONG.
However since it requires changes in

     include/linux/iio/types.h
     drivers/iio/industrialio-core.c

I thought it will be harder to get approval for this approach.
But now it seems there is no other way. So I will prepare a new patch version soon which introduces IIO_VAL_INT_LONG.

Thank you for your review!

>
>>   drivers/iio/common/scmi_sensors/scmi_iio.c | 61 ++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
>> index 7cf2bf282cef..691cbbd61e3a 100644
>> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
>> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
>> @@ -311,6 +311,62 @@ static const struct iio_info scmi_iio_info = {
>>        .write_raw = scmi_iio_write_raw,
>>   };
>>
>> +static ssize_t scmi_iio_get_raw(struct iio_dev *iio_dev, uintptr_t private,
>> +                             const struct iio_chan_spec *chan, char *buf)
>> +{
>> +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
>> +     int err;
>> +     u32 sensor_config;
>> +     struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
>> +     int len = 0;
>> +
>> +     err = iio_device_claim_direct_mode(iio_dev);
>> +     if (err) {
>> +             dev_err(&iio_dev->dev,
>> +                     "Error in claiming direct mode for sensor %s err %d",
>> +                     sensor->sensor_info->name, err);
> It's not an error, it just means the device is busy, so at most dev_info()
> or just rely on userspace correctly interpreting EBUSY.

Agree. Will use dev_info().
Thank you!

>> +             goto err_release;
>> +     }
>> +
>> +     sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>> +                                SCMI_SENS_CFG_SENSOR_ENABLE);
>> +     err = sensor->sensor_ops->config_set(
>> +             sensor->ph, sensor->sensor_info->id, sensor_config);
>> +     if (err) {
>> +             dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
>> +                     sensor->sensor_info->name, err);
>> +             goto err_release;
>> +     }
>> +
>> +     err = sensor->sensor_ops->reading_get_timestamped(
>> +             sensor->ph, sensor->sensor_info->id,
>> +             sensor->sensor_info->num_axis, readings);
>> +     if (err) {
>> +             dev_err(&iio_dev->dev,
>> +                     "Error in reading raw attribute for sensor %s err %d",
>> +                     sensor->sensor_info->name, err);
>> +             goto err_release;
>> +     }
>> +
>> +     sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>> +                                SCMI_SENS_CFG_SENSOR_DISABLE);
>> +     err = sensor->sensor_ops->config_set(
>> +             sensor->ph, sensor->sensor_info->id, sensor_config);
>> +     if (err) {
>> +             dev_err(&iio_dev->dev, "Error in disabling sensor %s err %d",
>> +                     sensor->sensor_info->name, err);
>> +             goto err_release;
>> +     }
>> +
>> +     len = scnprintf(buf, PAGE_SIZE, "%lld\n",
>> +                     readings[chan->scan_index].value);
>> +
>> +err_release:
>> +     iio_device_release_direct_mode(iio_dev);
>> +
>> +     return len;
>> +}
>> +
>>   static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
>>                                          uintptr_t private,
>>                                          const struct iio_chan_spec *chan,
>> @@ -355,6 +411,11 @@ static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
>>   }
>>
>>   static const struct iio_chan_spec_ext_info scmi_iio_ext_info[] = {
>> +     {
>> +             .name = "raw",
>> +             .read = scmi_iio_get_raw,
>> +             .shared = IIO_SEPARATE,
>> +     },
>>        {
>>                .name = "raw_available",
>>                .read = scmi_iio_get_raw_available,
>
