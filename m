Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8D426962
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 13:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbhJHLg2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 07:36:28 -0400
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:47333
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241368AbhJHLe1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 07:34:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXB3aMxz/impjsmZZY698M/Te3TvfEn+oL3woDVtHgd3oGfAaqXV3wIju8FQ2qU1tZRt6mWbKJ7JHMnz9KO/tft/4wxWEW7GEJQUBQEaauqJVhAjvGZ4f9t0hYT1bGQBF8l1q9VCAu26YW3rrk731Eo/2iF26ffJs57/xIFep8eAXeMcRdC2RW686jeWubxfVuFwtrOhIcFgyPDBHHS9FaizQFdqmCWy+5WUN3BPIdp/LdHLXz3ITS276kCvXyb4JVjxznCqiiw12UNY8rQ/JNmSAe9JJjPXz+wTaXcAmEFsXxz+ln+Dfnk185GzNZTOkHwAe5DiIhUuFP0lodIwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9UpQI07DqKVjfiKgQ+WQgOJM2VTXqRpiJtvDbxN25s=;
 b=D42X8BK8SHy+zxR1jyN3Vpv2tbkrWuCmOswYAUmpbSK31EbAGOE602NsOIvH+dECh8h9LNYSQiGgWdzJvuyHmWWpt67ZA+mhmvD5nhQg1IOqiQHtA/0uuaa/zF9MKwA+NT2VkYF0woMUTZ765rPMT8S2g7a3m3voQVt8RZXlI+84Sxc7EbwInOfdCGSrGW3sSO1AsCEzAPYU9d/XcrsPUITgnmhe3BrlxtHzRWR22IsnelIYX+IWcZDdgMQ7TNKtlN2aZz3NIb1IK6ZJhyvp8yUt2f2ZbONiFHGCAyuuT/bJ2Ghojw6MI5Vd51AgehbWfaIw6g8PCtEuyEQ4hLxLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9UpQI07DqKVjfiKgQ+WQgOJM2VTXqRpiJtvDbxN25s=;
 b=QinPp9TroWCHAuen4Id/1jnHmP4QgZZzPZqOqZGQik+qM6LgZU1A9/ZskT98kvqx0yYW0URYdxyFMCqpiPGsOWd3eCq4Xnk0HFB3u+Lvyk5xvqVtHbLNMP7ZfpiWkcs1/ZjuWkN1qOUPnLiwZ/oXkoLp0/IdFoc1vpGnzT1eemc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
Message-ID: <93323bab-c000-4a2b-ecad-9f3f6dc72c69@opensynergy.com>
Date:   Fri, 8 Oct 2021 14:32:27 +0300
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Subject: Re: [PATCH v3 0/1] iio/scmi: Add reading "raw" attribute.
To:     Jyoti Bhayana <jbhayana@google.com>,
        Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <20210928161957.24628-1-andriy.tryshnivskyy@opensynergy.com>
 <20210930174043.0845f6ed@jic23-huawei>
 <CA+=V6c34+VtYbUDG=NuY6YeyML23Tth2+fTjhvXpwMvrtkM5_Q@mail.gmail.com>
 <650ec3b8-c970-604c-9be6-577c46d3e762@opensynergy.com>
 <CA+=V6c10xE-1uUzGWusBiGVMV2Fwy93dGGHA9FH0PC4tYggVUQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+=V6c10xE-1uUzGWusBiGVMV2Fwy93dGGHA9FH0PC4tYggVUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::29) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d4c604d-f624-4562-3dda-08d98a4f4f9c
X-MS-TrafficTypeDiagnostic: AM7PR04MB6952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6952FA2450BB6BBFA20C7BC9E6B29@AM7PR04MB6952.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDiH3FcYmD6Iswu9jEN5aQGQvpIAblSVlWP5jdvi1dAAokvxtdRl7dOdHDcZwT0I6lZ9HD1MRNXrDOQevfJhwYf5oLPGWMzz1090u/fZLQ6GqjGi177afFDHmMfG6HKbJmpFKgsuYlby7tSB+yYrl3qd8qtesGQ1Jhjf0H8PaimZt+aJUrWSkqUPjaGentMDYIkqid+ijhp1EY72gHjO9ZYFIbcWgQTIwuqD86hbMBxGP86KuHrw4einupiYLUrjt0NgpJAKNUq/ga0iSaRbj/UwqenTKYz7eHCoQgeWZkkviyGU6dEzr7iN6ey3RKyXAmmwAwDCFJlcASS+1cb4DoJg9fnWJ1+WnkLBeY2Ku8l1ic57Pv9jFw3JjKoBf9WQBVqy2h6OvRF469FsoymvII+AcqNM9GLkm97vY1n4MK5I6ym+CU7aQ1byMhFDJST/kOyW4yodDrYWVnsgnVFYzzWDSXlWL7KtB9leoD/I0b/ykzLdJe4wZhvhbwrc45YXbwPf4SHTGhBcQ3Z+1ZtrPzl7Nm8HZUaSbD9SP10tFvBMNzZ6jouxleGxth2tuJcUUhTdJn34v1nEsIImebQbuYU7nMFUDYrliS3Rkod+MeEhCeJpNN+mU0hoZxmEEFDQRl9uGA9ogjVw9tt9TI6F71CFo1CLAUiWqkJ4janS5AJIcQpDCiTlFsz/ZimqznWKXGfFFSSV6zoA/E0Vl/g3LhmEvRUlj9VGSBlJkuNsHi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39840400004)(346002)(136003)(376002)(396003)(31686004)(316002)(5660300002)(4326008)(54906003)(110136005)(31696002)(8676002)(6636002)(42186006)(66556008)(2616005)(36756003)(26005)(8936002)(86362001)(2906002)(66476007)(966005)(38100700002)(53546011)(44832011)(186003)(508600001)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXlZVTV4KzNPV3Eveno2aitwdXBnRTUveHpMWVV2S1lHSnFPUGFhUkszclEz?=
 =?utf-8?B?WVN6cnlhcU9GUHE5Z1JjdVNmcUJzRVRlSkJsWk9oMkkwOGVPUlA4L0VsNWxp?=
 =?utf-8?B?WHE1YVdNRlpRZytDaFUvc2RIWXZSaVNCbExDT2NrMDBUL3hUWW1PM05FSU1w?=
 =?utf-8?B?R0ltNlBxampEYXVHYUl1c25OY3o1M0dBSElDVndDYk9yYW50cGFhNkk2dGdy?=
 =?utf-8?B?UHFxZ1cwajJJOWhycEFIU3gxOW5zbW5yVTlqVzdUMWVPZmlJWVE3Qi9VZGxm?=
 =?utf-8?B?VTNFTmhIRnVmNTJqaVRGanMvaEFtdFo1VTZEZ0VCRkk2aFJ0U2ZaVnVleDlY?=
 =?utf-8?B?cDF1aUgyeDh2MWo4M0pVd3V1QnkzaHQzQUtUc0dYZDIzZnpTLzhyZVBobmZO?=
 =?utf-8?B?QkFscFkxc2lObHdtNFRSNmdrekVtZ1pRMjJITDBLb2hPb01jUzVXQXo2blg4?=
 =?utf-8?B?Tk1BVk5KYzkremlVVk9xbXNkY3FVMzNabHA5SzVJcm16V1NJQTBVS1ZVRzA1?=
 =?utf-8?B?OXJjTzRjakNUOTFSNlZYUlJKc1BLTGxaQmJkV0p6cUlqZWxSTldRaGd0ZjAw?=
 =?utf-8?B?VmNUcGlRcWd0SW9GUEVOSkJPNHhzNis3WU8xVHdkM2dMblZGTTVsYmpyMDdJ?=
 =?utf-8?B?TmgrR0xHejJkdGRHSndMWmFZRjlBdzltM0cxV3hleExIa0Q0Qkl4WFA3Tm9E?=
 =?utf-8?B?ditjZWRmMTRsS25ya3dCRUpuU2UzWWo1WkllZ0RrTW5sS0QrTWZZVEk1TFFF?=
 =?utf-8?B?Smp6SVZEa1g3Z01SN3hXNXNUNGJsdnhZZVF6VEdNeG5aTklJUlAzdGRNS2dH?=
 =?utf-8?B?RU5zcEF5NFBoeFljOE5sWkQxR3FjbkxveDg2RmJTR3pQUW1JeUNTN1JjUkxV?=
 =?utf-8?B?UVRjZXRMVlIyVVc3b2xyOHd6YytlcjFxZ0FSSTZ5WUplUDlGRXhrWHNnS3VP?=
 =?utf-8?B?bkltL3p5NEtDWHBiWngzUnFLcXFVNksvUXhvR0RyT2ppLzlwV1JOSUNiRHFX?=
 =?utf-8?B?bVhJZnRQYjlPRW5jNVJEVmVFRU91UXVQeisrT2xtMXBSZGJEWVFNdS9rQm9N?=
 =?utf-8?B?OGhpaElUcGRrNHY5bnZwL0JTTW5GdTl0UkhUUHFnYTEycmdReXg5NkRabVdt?=
 =?utf-8?B?ZTE0a2NZOTFXQ2QzaHIyanRHajNSU3BwenY4NEJvVENicExZbGFqS0hOaTRa?=
 =?utf-8?B?cnJCbk5Nc3RGYnRnZXNXUlRYWVY3N1I4VXFCbjZtQkhhdDd0a1dBTm1wRXpo?=
 =?utf-8?B?Z0V6dUNMWi9tOUZXV3lGbVRKWExLNGx0NXU0VU8zR1VQRE50QklUTmtQNmpI?=
 =?utf-8?B?SUhwRmh0eGIyVE4zcDBvcDlrM094Y3JiTnVobWtUZGtvQ29RSXE5SWEvYXo4?=
 =?utf-8?B?U0FsYk41Z0M0ZGhadXJmV3VZVFdZSWJVNnB6TzRWeEFvQ1RJcUVTLzBCdzJo?=
 =?utf-8?B?dklYNElmbTdhNmtGdjlLWFhCd1E2R1FDek5qdDA3QUJoSDZoeUR5ekhFSDFm?=
 =?utf-8?B?NjVlRWZHZDRqUmFZSmUyYTJYL1N2V2hiWWJjV25sRU5RRDJDa1JXOVAwSzl3?=
 =?utf-8?B?Z2g3NWJ6Z2RRMHRSeHVHcVJSL0FGa0JZZ1NFSUFibllNQmtLd0RYU1JrTEov?=
 =?utf-8?B?cWhaQXg1eEZENkswMzRIWWlubkhRbGUrZ2xrNFZrNFB2NFVZdEk5YnhvbkJD?=
 =?utf-8?B?U0FqR09RU2xma2p5amF5ekg2SmM5Wlk5Qm9kRFlYOHBWdlpLVUNubWR4a0tZ?=
 =?utf-8?Q?+mf70soNDWTKkEX6HLeQnQxni+fUsKxEju+9y4W?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4c604d-f624-4562-3dda-08d98a4f4f9c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 11:32:29.3054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3siluktW7Zx1YhXvHhza56Pth3G2NlDTwBPn4+Kq9ZJyfBVBOW8CBLg3Mqf/nV3dn//TQQQgruwAbLHmN6pYSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jyoti and Vasyl,

Thanks for your review.
I will provide new patch version soon.

Thanks,
Andriy

On 06.10.21 03:16, Jyoti Bhayana wrote:

> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> Hi Vasyl,
>
> Regarding below question, yes reading raw attribute should be blocked
> if buffer is enabled for that sensor.
>
>> 1. Should we block reading raw attribute and IIO buffer enabled, for for
>> SCMI sensor it can coexist?
>
> PLease see  https://elixir.bootlin.com/linux/latest/source/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c#L667
> as well. It has
>
> case IIO_CHAN_INFO_RAW:
> ret = iio_device_claim_direct_mode(indio_dev);
> if (ret)
> return ret;
> mutex_lock(&st->lock);
> ret = inv_mpu6050_read_channel_data(indio_dev, chan, val);
> mutex_unlock(&st->lock);
> iio_device_release_direct_mode(indio_dev);
> return ret;
>
> Regarding the question below, the answer is yes.
>
>> 2. Should we wrap reading raw attribute implementation in iio_dev->mlock
>> mutex?
>
> Thanks, Jyoti
>
>
>
>
>
> On Tue, Oct 5, 2021 at 5:52 AM Vasyl Vavrychuk
> <vasyl.vavrychuk@opensynergy.com> wrote:
>> Hi, Jyoti,
>>
>>> In the code below, why is the logic of enabling and disabling the
>>> sensor in this function?  Generally the function to read the sensor
>>> value is just used for the code to read the sensor values ? and not
>>> enable/disable the sensor
>> But to read sensor value we have to enable it first. Other way to enable
>> sensor we found is, for example:
>>
>>     echo 1 > /sys/bus/iio/devices/.../scan_elements/in_anglvel_x_en
>>
>> But, this command is related to IIO buffers use.
>>
>> Other sensors drivers enable/disable sensor in read raw too, for
>> example, drivers/iio/accel/kxcjk-1013.c has:
>>
>>     case IIO_CHAN_INFO_RAW:
>>             mutex_lock(&data->mutex);
>>             if (iio_buffer_enabled(indio_dev))
>>                     ret = -EBUSY;
>>             else {
>>                     ret = kxcjk1013_set_power_state(data, true);
>>                     ... reading ...
>>                     ret = kxcjk1013_set_power_state(data, false);
>>             }
>>             mutex_unlock(&data->mutex);
>>
>> But, after looking on this code I have some questions:
>>
>> 1. Should we block reading raw attribute and IIO buffer enabled, for for
>> SCMI sensor it can coexist?
>> 2. Should we wrap reading raw attribute implementation in iio_dev->mlock
>> mutex?
>>
>>>>      case IIO_CHAN_INFO_RAW:
>>>> +               sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>>>> +                                          SCMI_SENS_CFG_SENSOR_ENABLE);
>>>> +               err = sensor->sensor_ops->config_set(
>>>> +                       sensor->ph, sensor->sensor_info->id, sensor_config);
>>>> +               if (err) {
>>>> +                       dev_err(&iio_dev->dev,
>>>> +                               "Error in enabling sensor %s err %d",
>>>> +                               sensor->sensor_info->name, err);
>>>> +                       return err;
>>>> +               }
>>>> +
>>>> +               err = sensor->sensor_ops->reading_get_timestamped(
>>>> +                       sensor->ph, sensor->sensor_info->id,
>>>> +                       sensor->sensor_info->num_axis, readings);
>>>> +               if (err) {
>>>> +                       dev_err(&iio_dev->dev,
>>>> +                               "Error in reading raw attribute for sensor %s err %d",
>>>> +                               sensor->sensor_info->name, err);
>>>> +                       return err;
>>>> +               }
>>>> +
>>>> +               sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>>>> +                                          SCMI_SENS_CFG_SENSOR_DISABLE);
>>>> +               err = sensor->sensor_ops->config_set(
>>>> +                       sensor->ph, sensor->sensor_info->id, sensor_config);
>>>> +               if (err) {
>>>> +                       dev_err(&iio_dev->dev,
>>>> +                               "Error in enabling sensor %s err %d",
>>>> +                               sensor->sensor_info->name, err);
>>>> +                       return err;
>>>> +               }
>>>> +               /* Check if raw value fits 32 bits */
>>>> +               if (readings[ch->scan_index].value < INT_MIN ||
>>>> +                   readings[ch->scan_index].value > INT_MAX)
>>>> +                       return -ERANGE;
>>>> +               /* Use 32-bit value, since practically there is no need in 64 bits */
>>>> +               *val = (int)readings[ch->scan_index].value;
>>>>
>>>> +               return IIO_VAL_INT;
