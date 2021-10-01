Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5F041E813
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 09:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhJAHO0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Oct 2021 03:14:26 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com ([40.107.20.117]:55777
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231209AbhJAHOZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Oct 2021 03:14:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eai+PuRQ6qe6uF1x32lvleIlaapnq0g9deDlHe8O4p+ORHaV+yOlqwd3/qvhfZoY+/EJiTJTUizyF9U1C1glh1KjpOsnW8T3gKwbR8JxjDn9tDIAY8PaMbTvnusYoYCwxtxSfKIvb/joq0inHlcND7iP0vL98O7WldQJ/rhBTi18EJJ5lz5U92DaNxqm4sJsxJhRPaLmeWm7EtIKBjLezoPCWpINrIFMLsHhqtE1bDF35/pCNxljPIQuQWNExYs0XKWYPsBloWF+8To914EuDKpI/1/0bcnfTeuxY/WxH/U9XKtYVOpoqCsYVlfTwlu1XtaJ5OamXqOhRtLI+HcjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcdkLN3gS9GbQmhw2X7GlCbMZg0/onQMe+tjuSj4M+E=;
 b=Vy3R9+ZgHS73UlAqD+dYcIDcFEyGcD6mBkry1yZKsRcc5xddgjrRU0ELjidLEi2sq607rLBqdzfuFXo4gGptfh5MnQODXcbSRQt1sL7Si7o0lXpj55Zt9cujdkbA7lgRIh24uzXkj385uFv0y+4j62/q6iGqTTjCdYF8nvJohLw+02tk7pQEdmr4XjJCEIpv3J3wHX1SQGvcYggQXHJNxpQN7dDjWss9ggciOvV0FX5gli+3WouWz6g4gcxQDW438A2gB65/TZAJ99XF+rQ25eE7VR/9YOEjbKft8+Q7ZatZhMfH+daZY0kwWO92+3uyFTVIAN773ti7RJWI2sKQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcdkLN3gS9GbQmhw2X7GlCbMZg0/onQMe+tjuSj4M+E=;
 b=Sn9fLS7S/lHSk16RhyJSmY7rjQsEcA4QKJhIxdY6tQlT8No9OU53WBl0eWaHa7358R9WHKO2RLSVJPt+xKs6V713qeO3ABftghcuPsoLk5Q7wHTQRqu3XL1PWZwFrzh2zBtRT8xe5GlcdOgNVvA4xmm2K6qCD5PheWtxW/a/q2A=
Authentication-Results: opensynergy.com; dkim=none (message not signed)
 header.d=none;opensynergy.com; dmarc=none action=none
 header.from=opensynergy.com;
Subject: Re: [PATCH v2 1/1] iio/scmi: Add reading "raw" attribute.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
References: <20210927132202.17335-1-andriy.tryshnivskyy@opensynergy.com>
 <20210927132202.17335-2-andriy.tryshnivskyy@opensynergy.com>
 <20210930173316.3a111130@jic23-huawei>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Message-ID: <efca1c2c-f000-df20-171e-34f7e97877e4@opensynergy.com>
Date:   Fri, 1 Oct 2021 10:12:38 +0300
In-Reply-To: <20210930173316.3a111130@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25ca4106-74b3-433a-66d6-08d984aada8e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB50475D1EA4BE44E9B325C051E6AB9@AM6PR04MB5047.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vQfoUYRYHBYBSArxzKthShlbTk5Adf8DNwNE3uq1ZcK8RfkH07Bwb6x5x67P+EfmhCodRDpRml620r8GePtaYJr1EHqSx8LTvAZwVoIz1rS49tEG/aMHl7ji6WNxNTsdjDQjI38QNVpV2v/EOqupUFs8YP/5klnozsk9N7oPxnwjVGGu0SuntGgcJ+XE8yFQZ/7DAS8mcBnbVhuFuSCjMC7eig+hPG2qSfhdaMpP7obGVh+HYCLu/NrkVgo1/fRSKgk8zjINq+AYwS70P5at5ANoMx0gumQyWbuoy0eJgEWEZ5poqEA0QLTbrYQhZPNx6zprGN2XK5F7TpNu9N/JePjB4/dziTSjkhLDR1Xc9Z9g+V4RDc+o6kmCR+coXY/k7FW+gulqIFMxM9w22FMaJ9PKHLyVjwkJ3cEKbmtEfDmo9LletDdCrksZyxHR/6xfqOtyPiyXbKQwyXKczac+MZtW0oGujkX2m8BcHjrNy5pZYZ7fuRCdfGIS6RJhEATemu/R2MqfxHXtt9z3ekTR1usrGxqFW/2lJVQpVYOkFZUyrFT0QcW4XTDiPaLyo38heKsmZGhqJHFNS0lb17foOhn7WhzXJRC/ixUNQYzl+KLPW3G/ZYKwHGwlTSwpr61Ww45iJK3VMBDm6u/NS86Ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66476007)(66946007)(5660300002)(6916009)(31696002)(31686004)(316002)(86362001)(8936002)(2616005)(2906002)(26005)(36756003)(186003)(53546011)(83380400001)(8676002)(38100700002)(44832011)(55236004)(42186006)(107886003)(508600001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxRL00xREJwdjllcEJXdThIM2VoUVFDaDVranBhVkRTUk04c3pDK3VVNmFt?=
 =?utf-8?B?UURidGtRRFhBNTVIdm9Eb0ZUZFRQNVFDQzBzeFAyNzVJTHZFQVFjQUNoN2Q3?=
 =?utf-8?B?ZVVmQ1BnNTRqbGxLbGkxMWRlNXN4TGN0akdtMFJzWktlRXJJbE9MN3dQYnU2?=
 =?utf-8?B?MTU3azlpQjdra2pzRzlESk5VNFJXT2NzSHEwU1dUckpJYlQ2N1NaSVN3V2py?=
 =?utf-8?B?ZllyMk9ObVBCSEVxMHRBSXhGVktSYVVYb1RzOEltTHE4SlNOemFtbm5zQlNQ?=
 =?utf-8?B?TS93ZXhPZUppVXgrZ2ExdEtJblFZdUFxaVVCdXFPVVlPY2lBMlhIcDBqd3dp?=
 =?utf-8?B?LzJoRUx0MmxNY1RibFJHaDNHNnpZWGQzM3lCVVQxQ3AzM2UwK01KamNqaFBK?=
 =?utf-8?B?bnFMMjhMR1E4aDZFTm1KazkrcEVZZXRIWG15Y2VBeE9LaUhlNDJWbEUzbS9E?=
 =?utf-8?B?ci9heHFpbnQ4dGxFdXNlUnlBY291WHJpU2x6aDdLb2E4RHR1aVJMc0Jjc2dH?=
 =?utf-8?B?ZmpXWU1BWnhPM2xHd1NTWjVMQkZHaWZFNUxreXFlYWZRWkYrU0U2K3R4TUZD?=
 =?utf-8?B?U2IxZ1Bnem5ZMFNSUW9Ub1Z6NjRhVldUSXpzVXViQXFTdVNkZGU3eEgvVE5T?=
 =?utf-8?B?MlYvWXMvWmdMWThRdTcyUjUvb3NXRzIyUzdVWEk5U05XQ294M0w0NjNHdWlm?=
 =?utf-8?B?YjZqZE8rOG1FT2VRb0w3aHhyNnFORU84R2l2OTNWeWk3dlZDT0hoYnpDWFVk?=
 =?utf-8?B?TkdhRTYvQjdJalIwdVNzVlZsaUQ3cFc3cURyYTJCUFZRclFrTzBJdmEyRjRi?=
 =?utf-8?B?WXhCQ3FOZTBrQnFQb0lIKzkxQWE0NWVDTTMrVGxSVS8rOFFYcFdLcVZ0WW1T?=
 =?utf-8?B?U0VZRjZTMGl1VFkrQ0JPS203ajliT0NOZXVUVW1ZRDE0VEMyOHRrTkdtZysy?=
 =?utf-8?B?R0lYRWJhemtjOWZHMkhWUDVwakw2UDc1QkZUQlhlczl2TkhRc2Nhb3JFSzVU?=
 =?utf-8?B?R211Rk9pV2JSa2hMZkZGQVNRbE5WUUZJTzEySmt5cjV5MnNOelV0WGJ6TWZt?=
 =?utf-8?B?YTJiSS9CQnBKVTdMRHZFQWlCa1djdTVCbitVR1pVajNVbTlYaU1HMmxwNGw1?=
 =?utf-8?B?S1BmM2pLRGVkNGVzK3dpazV0TW1ieVZkcnRod2RobkVkOGUrWjBTUWFGQ0NL?=
 =?utf-8?B?RzkzeThVQTBJL1ZFWkR3TXprdCtaY0xNellDUWUzWXNQTVptSzdZWFN3ZWFT?=
 =?utf-8?B?d0dnYnNmQy81dEtOUDdnV3hCMHRMY2hXYU15Uk1oQnY4cmZxcUhYL1dMcHlM?=
 =?utf-8?B?WG9IOEhQVVNEUzlJVkFvck5DblE0TFdnQXNUcGRiNkFCcDlHZFlaWTdsR0hv?=
 =?utf-8?B?YkJYOGxIa3NoZ1k4L2R1ZEEvbTZJdzJkSVVHMU8yUVZOVjJiNzY3LzJxdDJK?=
 =?utf-8?B?MWJNcHM5d1ZQcks4aUhHOVUyclp2MWtsMHF3R1dsWmpna2hzS01oYVJPbW41?=
 =?utf-8?B?V0hDejBwR2pjOHlVaHpPQkpZWVdRTGVNdVowREorcVB6UmpOSFpkamVQZVV2?=
 =?utf-8?B?QkdHTHNFYVA0dVdhc0NWaWt6cWVvUnBwUWw0K1RnWWlVdUV1MVVzZTFlY1RW?=
 =?utf-8?B?N1pZQzFuRk5QWVE4STAwK2cxUjMycjdjTUQ1Wi94RUZudjJaK053RS9rY0lM?=
 =?utf-8?B?Z25XdlNpM0VlZ3ViRjhtbmcxU0dlTEdEak9hRSs0SjlTSVNhYmMycSszZ08v?=
 =?utf-8?Q?9D97g+FrDLeIZZlBoGEu5Ya90KU6AZ/EKscFTcM?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ca4106-74b3-433a-66d6-08d984aada8e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 07:12:39.6707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2xQMGgJJKktlzAwgOX/oTBpDsxqTiANScWtnWqCgxXbXbbvDYZpPEmTjzbP340YaFGs7i7+F+KezsNLxeVkDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5047
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thank you for review!

Regards,
Andriy.

On 30.09.21 19:33, Jonathan Cameron wrote:
> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Mon, 27 Sep 2021 16:22:02 +0300
> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>
>> Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
>> reading "raw" attribute in scmi_iio_read_raw.
>>
>> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
> Hi Andriy,
>
> Looks good to me, but I'll leave it on list to get feedback form the
> driver maintainer for this one.
>
> Feel free to poke if no reply in next 2 weeks.
>
> Thanks,
>
> Jonathan
>
>> ---
>>   drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++++++++++-
>>   1 file changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
>> index 7cf2bf282cef..c6a9dc6ad140 100644
>> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
>> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
>> @@ -286,6 +286,9 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>>        struct scmi_iio_priv *sensor = iio_priv(iio_dev);
>>        s8 scale;
>>        int ret;
>> +     int err;
>> +     u32 sensor_config;
>> +     struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
>>
>>        switch (mask) {
>>        case IIO_CHAN_INFO_SCALE:
>> @@ -300,6 +303,45 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>>        case IIO_CHAN_INFO_SAMP_FREQ:
>>                ret = scmi_iio_get_odr_val(iio_dev, val, val2);
>>                return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
>> +     case IIO_CHAN_INFO_RAW:
>> +             sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>> +                                        SCMI_SENS_CFG_SENSOR_ENABLE);
>> +             err = sensor->handle->sensor_ops->config_set(
>> +                     sensor->handle, sensor->sensor_info->id, sensor_config);
>> +             if (err) {
>> +                     dev_err(&iio_dev->dev,
>> +                             "Error in enabling sensor %s err %d",
>> +                             sensor->sensor_info->name, err);
>> +                     return err;
>> +             }
>> +
>> +             err = sensor->handle->sensor_ops->reading_get_timestamped(
>> +                     sensor->handle, sensor->sensor_info->id,
>> +                     sensor->sensor_info->num_axis, readings);
>> +             if (err) {
>> +                     dev_err(&iio_dev->dev,
>> +                             "Error in reading raw attribute for sensor %s err %d",
>> +                             sensor->sensor_info->name, err);
>> +                     return err;
>> +             }
>> +
>> +             sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>> +                                        SCMI_SENS_CFG_SENSOR_DISABLE);
>> +             err = sensor->handle->sensor_ops->config_set(
>> +                     sensor->handle, sensor->sensor_info->id, sensor_config);
>> +             if (err) {
>> +                     dev_err(&iio_dev->dev,
>> +                             "Error in enabling sensor %s err %d",
>> +                             sensor->sensor_info->name, err);
>> +                     return err;
>> +             }
>> +             /* Check if raw value fits 32 bits */
>> +             if (readings[ch->scan_index].value < INT_MIN ||
>> +                 readings[ch->scan_index].value > INT_MAX)
>> +                     return -ERANGE;
>> +             /* Use 32-bit value, since practically there is no need in 64 bits */
>> +             *val = (int)readings[ch->scan_index].value;
>> +             return IIO_VAL_INT;
>>        default:
>>                return -EINVAL;
>>        }
>> @@ -381,7 +423,8 @@ static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
>>        iio_chan->type = type;
>>        iio_chan->modified = 1;
>>        iio_chan->channel2 = mod;
>> -     iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
>> +     iio_chan->info_mask_separate =
>> +             BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_RAW);
>>        iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
>>        iio_chan->info_mask_shared_by_type_available =
>>                BIT(IIO_CHAN_INFO_SAMP_FREQ);
>
