Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC5435345
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 20:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhJTS7V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 14:59:21 -0400
Received: from mail-eopbgr20090.outbound.protection.outlook.com ([40.107.2.90]:5753
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230076AbhJTS7U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Oct 2021 14:59:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw9PORKWoWbNUzBgu/ytKMEjsD8Ovczyw4EdANXGwocHRP4h6Vl6lEtfwJyjdiKF40H/60bBNcf1wVtzTEqOXuLAniohejCHAEWT+XkE83qY+euXdZRLJrc6pWV5cQckHUK2DY9G/XkTMaCTwNm1+L+jTnIDEmXqUN/8hrHP10YMPREjEEAWU3vWsgSCbdp/kXLdwBy92NyyOlCBggEpSycVXlgdRrUlZisxeAedzsEyphS3QLfES2R4veePf7Bg6RMNmbQdQxn37Z/EZBW148gyB1axQwwMn9xzzf4CXYuf6cm48Du9RGKHe1l2N7XN7+MbircHCfuIoZPjpAHNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL9e0o3a0fH5+Y5Tq7a4BucqoMf7wRIKeEIqsg24O+s=;
 b=awvYj0cWBU+nQmEJZ3LbuIcpEE/xhbeXnCdqb7b60nfZAObx5z1HhOtlI6IozIw4w4Blwq97XteFPyqcyk7hV6cW6C4IN22v0eHQ0fCXop699pvZUk+k7rV739c79KeiLoE8z7Ed83Op2aYaa7vuad08850EV9hZxbc1IAmFi5tkTvWYRg2ddxsajnVRUsvyNzduAdiJvWSp8K3UQz059WV406zH41Onnb6zz0999v+8LelUojTjom4TdUaeDKTnrSjANKLgGNZX9Gzb03mLxixIthNLKaE5wXXFG1BS1LjuLSKzH3zgL3rPvy897zIETnatfLPcm6epyVkaF6n1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL9e0o3a0fH5+Y5Tq7a4BucqoMf7wRIKeEIqsg24O+s=;
 b=i/Rksa/+6fPyXLvig7WM/WKyP6phio9u2DPFT+4sV95Lh1yH/LK7Pn79D11dBkyQIOLSkIUs+1rrYUS3VsuwtA8PhYEIULEibcy6QDVWj7OXqfXW8Vn4Ql3un/xO1fjhWu/WsPwwmJA/AR3abHRgMYvjAsB8vvePbgJIOAFIxZE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=opensynergy.com;
Message-ID: <4e73398f-126a-0e1a-6eed-88d2d37778c2@opensynergy.com>
Date:   Wed, 20 Oct 2021 21:57:00 +0300
Subject: Re: [PATCH v6 1/1] iio/scmi: Add reading "raw" attribute.
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
References: <20211019075949.17644-1-andriy.tryshnivskyy@opensynergy.com>
 <20211019075949.17644-2-andriy.tryshnivskyy@opensynergy.com>
 <20211020185118.7a02cbf8@jic23-huawei>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <20211020185118.7a02cbf8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64734c79-98ee-478a-3b2a-08d993fb6735
X-MS-TrafficTypeDiagnostic: AM5PR04MB3123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR04MB31235583DCC02707CDCFC1DFE6BE9@AM5PR04MB3123.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcfewUX1OkvmFSeyZXhgGqxdq95z0QZRiYjVnv4OSrggVtRWRTIeP5ULpMXA0fhjZm+7R4oOTRxtcOThS8SS/rgmc18qisC3u12g/9RDTP+FLUluofU5GPX36Enm+R8koKPy9v9H/OIc4noTShGvsDU7ATnaN+r5L5+j0mVA7oCVxFaq2O4k9mED6+kxJZNj5QxdB88IOgOfzOZoo+Qan/XbbQ4lCSoZpjcn+E0EQap1NaCCROBs82p3nS+tS3WqiIRhMoKGk8XydWJ1Ujh96/az10EFQ5HOUu91+WjrcbjaF39t0xaTxSAf6JB2KDWaprEwa8g5pdk39eu1/6LRz/BMF3tJqQS1uvJpdM/RKDHVwdAW9vzoyXhyz83alSpdoq8SHERrpakLQLpYr/Q2ntat4E6yIVDKLkcrFh1d5uMGPENVh/3Tq8FmIN0zs/du0OLfqFGpHEFg2jg8zD7LUfQRGDGOfwbLeJ8hZms+YLEkxNVDFdpVS92QwuFqVF0lNBerTtBCcCrR0fT/Y39z63/mBllFpSVhPPukEV8l6Eb8570TeiFqwlZCkWHCSVGgwvIqoVZP7Al/bs1Dzr6lLZoKb6YnHtr8lvCNz5nu2R4bPyM22DtQ2twf2ZiC3SR6VaEhTSjMTC+s9iJ92J3gDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39830400003)(376002)(346002)(8676002)(66476007)(36756003)(55236004)(2616005)(316002)(107886003)(38100700002)(31696002)(42186006)(8936002)(31686004)(44832011)(53546011)(508600001)(26005)(66946007)(66556008)(5660300002)(6916009)(83380400001)(2906002)(186003)(4326008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtpcldvWTdEYlFtampOemxjM05ZaUF0ei9oaUEraFRYWTdleGQwQndncW9y?=
 =?utf-8?B?M3Vpc0plaFNQL3hlOE5VRWttNW03bXV5dGRwUFpEWlJrWU5jZTI1NUxhQTRZ?=
 =?utf-8?B?UHEvNE1BOHBVNG1Wdk52dkRkazFvMHVzODRTcHRsTGhwT2REdGpRS0w2Y01W?=
 =?utf-8?B?dWIvaENkMURpMThhRHBId2dKMzJvZ1pNenBNTklqNnJ4NWxRVU55L09DV0k4?=
 =?utf-8?B?WS9kc2FJZkFlaktDQThxMXFWZDBQeEFneUFqM1p2WUlSc2JjUStNa3cxU05V?=
 =?utf-8?B?d3JaOW5ITnFyK3lmbzk5L2dXZjY1ak9TQVoxeEp1dHoxVnpGKzZ3VTdnVUxR?=
 =?utf-8?B?a1I1L2FnWHRheWpnODE5cG9wMisxcEZQTEVPaHZlMWNXRnZTbGdsekxMU3ZS?=
 =?utf-8?B?REJaWVFQUFNNR2RySGM0Ni9aMEVwREkyTjNBRkRheFpuVGs1TlZOKzBLbnZm?=
 =?utf-8?B?a0dkTTBWUWZzK0g4L09TcTJwNlR3QlJIQVNKWW5ja1pUOG54R3R0Nm1GNm4r?=
 =?utf-8?B?cFgrZmd1OWlVVEFkTnc3VmRZY3JBZVpUWG1nU0lBcFAzRklzaXBzZy93Z1dP?=
 =?utf-8?B?YzBKQVhKNldMWE1Ca3NtcE9tRWoxQ2ZCZnNLSHVHUTZ5eHV6WmwrMUs2ZkJK?=
 =?utf-8?B?WEpYWFpRejRwbU1HMUZHMkt2cnk3S25GNHZWU01FcjlkdGlrNEpnRXVWM0pX?=
 =?utf-8?B?YUtEdzZBMTQwOXlCaStMYzFucWlIUW1IVkVnOFQxYmE1S3dDWEFwK3F0Qk1y?=
 =?utf-8?B?VDQ2dkFaaytsZitsQ0xRQ2NHRE9jT0U1VzY5UTBRQWE0aE8zajZadkJHWDRt?=
 =?utf-8?B?bUdneExzbEtEczVRSUQwWDBscEQ4QlV2UjBNYmRJVHBXN2VRNnFyM0Z4VWx2?=
 =?utf-8?B?RmZOUkVxb3o5S3dOS0diaVJpb1pPSElIMWNwTVRybngrSmllcmFMRHl0Q2xF?=
 =?utf-8?B?M294ejNPZ3FkNFVOekpSVGR5R0FTQnlONVRINUQ3bjF2aGpWRnVKMUpGQldk?=
 =?utf-8?B?ejJTY2ZTT2ZCbzhpbjJnNWRLcmFISFl2dzlLa1pJdE5pNmRDdEk1VmFSYVln?=
 =?utf-8?B?ZElkcU9yWHBOR3NHWmZvZGM2Y1p2Q3R1ZGNVWVlyVjRlalNQM2xSSGxuVUF0?=
 =?utf-8?B?a051MnJnSVFwMldvZzkvUkdtT2pHL1BpWm83S2xEc1kwRVFxd2JqMnRBbXls?=
 =?utf-8?B?cnY3aUlRekIxdnFzaXl2WGdZQlNnSG9kUDVTS2pYSkE2czQzU2ZSOHRYY0Jm?=
 =?utf-8?B?QWVKVmZYQlB1ZXJPVzNpOVdyZlIrZkVicVo3QnlNWFI5cnQzV3pIbTBWK1JI?=
 =?utf-8?B?WWxFaFNGL0xZd1lPZzF0Smt1bUFYL2JPendVYlNvN29SNnJRcnpRU0NQTExQ?=
 =?utf-8?B?NlFpSEhqZkpQVlEyeXdwajM0UytpQ3ZaTGJ0UURQNWgwMms3c1JvdXY3dXpo?=
 =?utf-8?B?YzNTY0hLNkY1RllMdjFrNWNCcXRET3Y5TEh2RXNTS3hWT2JidXRac1MxZlJW?=
 =?utf-8?B?UlVHWDB2THN2bjVnaFJra3A3NWVNU21SdnIrR3M0bm1Ua2JLeXJrTVU2Rjln?=
 =?utf-8?B?ZytnMG9GQk0wY0gxemZ6M2kzWXkybk41QTJmcFo1TTNZaGttbFF2ZE9UUWd6?=
 =?utf-8?B?R2kyUVp1cVdPdjhCUkVZWTNhb0RyR2tqc1FLTEFoc1cvbTNxMU1RT2haYmR5?=
 =?utf-8?B?RTMxQ2xKNW1qWGpOa2ZrQ0tCaHJ0OGk0ZTFZeURPSDAyeGtidHVEVFMxcmpC?=
 =?utf-8?Q?xdNoJzejYSdmoCfLWs2MdfN8SK6yFAEyOGBKZG4?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64734c79-98ee-478a-3b2a-08d993fb6735
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 18:57:02.8661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glat@opensynergy.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3123
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 20.10.21 20:51, Jonathan Cameron wrote:

> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Tue, 19 Oct 2021 10:59:49 +0300
> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>
>> Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
>> reading "raw" attribute in scmi_iio_read_raw.
>> Introduce new type IIO_VAL_INT_64 to read 64-bit value
>> for "raw" attribute.
>>
> Change log needs to be below the --- otherwise we'll store it forever
> in git.  A linked tag (which will be generated when I apply)
> is sufficient for this sort of historical info.
>
Sorry, this is my first patch, I was not aware of that.
Thanks for the explanation.
Quick question: since next version will include 2 patches,
I guess a change log should be moved back to the cover letter, right?


>> Changes comparing v5 -> v6:
>> * revert v5 changes since with scmi_iio_read_raw() the channel
>>    can't be used by in kernel users (iio-hwmon)
>> * returned to v3 with direct mode
>> * introduce new type IIO_VAL_INT_64 to read 64-bit value
>>
>> Changes comparing v4 -> v5:
>> * call iio_device_release_direct_mode() on error
>> * code cleanup, fix typo
>>
>> Changes comparing v3 -> v4:
>> * do not use scmi_iio_get_raw() for reading raw attribute due to 32-bit
>>    return value limitation (actually I reverted the previous v3)
>> * introduce scmi_iio_read_raw to scmi_iio_ext_info[] which can return
>>    64-bit value
>> * enabling/disabling and reading raw attribute is done in direct mode
>>
>> Changes comparing v2 -> v3:
>> * adaptation for changes in structure scmi_iio_priv (no member
>>    named 'handle')
>>
>> Changes comparing v0 -> v2:
>> * added an error return when the error happened during config_set
>> * removed redundant cast for "readings"
>> * added check if raw value fits 32 bits
>>
>> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
>> ---
>>   drivers/iio/common/scmi_sensors/scmi_iio.c | 57 +++++++++++++++++++++-
>>   drivers/iio/industrialio-core.c            |  3 ++
>>   include/linux/iio/types.h                  |  1 +
> Two patches needed.  One to introduce the new core functionality then
> a second to use it in the driver.
>
> Actual code looks good to me though I think I'd like a comment next to
> the #define as not obvious which way around the two parts will go.
>
> There are some other places we will probably need to ultimately handle this
> to allow for in kernel consumers but those can come when someone needs them.
>
> Will need an ack from Jyoti on this one though as driver author.
> Thanks,
>
> Jonathan

Sure, will split the current patch into two patches.


>>   3 files changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
>> index 7cf2bf282cef..2c1aec0fd5ff 100644
>> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
>> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
>> @@ -279,6 +279,52 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
>>        return 0;
>>   }
>>
>> +static int scmi_iio_read_channel_data(struct iio_dev *iio_dev,
>> +                          struct iio_chan_spec const *ch, int *val, int *val2)
>> +{
>> +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
>> +     u32 sensor_config;
>> +     struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
>> +     int err;
>> +
>> +     sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>> +                                     SCMI_SENS_CFG_SENSOR_ENABLE);
>> +     err = sensor->sensor_ops->config_set(
>> +             sensor->ph, sensor->sensor_info->id, sensor_config);
>> +     if (err) {
>> +             dev_err(&iio_dev->dev,
>> +                     "Error in enabling sensor %s err %d",
>> +                     sensor->sensor_info->name, err);
>> +             return err;
>> +     }
>> +
>> +     err = sensor->sensor_ops->reading_get_timestamped(
>> +             sensor->ph, sensor->sensor_info->id,
>> +             sensor->sensor_info->num_axis, readings);
>> +     if (err) {
>> +             dev_err(&iio_dev->dev,
>> +                     "Error in reading raw attribute for sensor %s err %d",
>> +                     sensor->sensor_info->name, err);
>> +             return err;
>> +     }
>> +
>> +     sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>> +                                     SCMI_SENS_CFG_SENSOR_DISABLE);
>> +     err = sensor->sensor_ops->config_set(
>> +             sensor->ph, sensor->sensor_info->id, sensor_config);
>> +     if (err) {
>> +             dev_err(&iio_dev->dev,
>> +                     "Error in disabling sensor %s err %d",
>> +                     sensor->sensor_info->name, err);
>> +             return err;
>> +     }
>> +
>> +     *val = (u32)readings[ch->scan_index].value;
>> +     *val2 = (u32)(readings[ch->scan_index].value >> 32)
>> +
>> +     return IIO_VAL_INT_64;
>> +}
>> +
>>   static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>>                             struct iio_chan_spec const *ch, int *val,
>>                             int *val2, long mask)
>> @@ -300,6 +346,14 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>>        case IIO_CHAN_INFO_SAMP_FREQ:
>>                ret = scmi_iio_get_odr_val(iio_dev, val, val2);
>>                return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
>> +     case IIO_CHAN_INFO_RAW:
>> +             ret = iio_device_claim_direct_mode(iio_dev);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             ret = scmi_iio_read_channel_data(iio_dev, ch, val, val2);
>> +             iio_device_release_direct_mode(iio_dev);
>> +             return ret;
>>        default:
>>                return -EINVAL;
>>        }
>> @@ -381,7 +435,8 @@ static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
>>        iio_chan->type = type;
>>        iio_chan->modified = 1;
>>        iio_chan->channel2 = mod;
>> -     iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
>> +     iio_chan->info_mask_separate =
>> +             BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_RAW);
>>        iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
>>        iio_chan->info_mask_shared_by_type_available =
>>                BIT(IIO_CHAN_INFO_SAMP_FREQ);
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 6d2175eb7af2..49e42d04ea16 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -702,6 +702,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>>        }
>>        case IIO_VAL_CHAR:
>>                return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
>> +     case IIO_VAL_INT_64:
>> +             tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
>> +             return sysfs_emit_at(buf, offset, "%lld", tmp2);
>>        default:
>>                return 0;
>>        }
>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>> index 84b3f8175cc6..e148fe11a3dc 100644
>> --- a/include/linux/iio/types.h
>> +++ b/include/linux/iio/types.h
>> @@ -24,6 +24,7 @@ enum iio_event_info {
>>   #define IIO_VAL_INT_PLUS_NANO 3
>>   #define IIO_VAL_INT_PLUS_MICRO_DB 4
>>   #define IIO_VAL_INT_MULTIPLE 5
>> +#define IIO_VAL_INT_64 6
> Possibly worth a descriptive comment. The other
> types tend to make it easy to assume the role
> of val and that of val2, in this case, val being
> the lower 32 bits isn't obvious...

I will add a comment here.

Thank you for your review!

Best regard,
Andriy.


>>   #define IIO_VAL_FRACTIONAL 10
>>   #define IIO_VAL_FRACTIONAL_LOG2 11
>>   #define IIO_VAL_CHAR 12
>
