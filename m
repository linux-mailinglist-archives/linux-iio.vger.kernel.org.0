Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741C9438741
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 09:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhJXHhh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 03:37:37 -0400
Received: from mail-eopbgr80123.outbound.protection.outlook.com ([40.107.8.123]:18501
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229527AbhJXHhh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 03:37:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLJN91JFvoQNfWhtfHpyo0WyYe12hYpVWfwWVheual/YDjR6YxuJe6TT0H3sj8z/SGk6CiCuCQqezndLkECodJYzqblCDKfbtXrBrVlKm4J+sF03GgCttqHJWIlTHgPmrV9dZLBfBlekX0Xdib7B5eon2VjMKidSPp65FZJu2zJJ8JKjkIciJsZYetycNmC8vbzc0tppyqmmikCSsY/EwOZcT05dElcjIGwxJ+bAXA6oKo6JM7Ut59r/YEQs7pr/qix8RnenoyJYpCbUTvZuCyjaOOM/PD0lc4ZHaQ4FO5BDqaGLAtyg8QoVE9e/hWppXtw+VAn2ueKaelBkKqQEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMJpBGdBwpezosvcttFjqofeG9bbTrslA/wGYm7Vwv8=;
 b=kRvhxf5Y12IRIooLCmBZEZepnPmw1dxPcCZnVM8ZfjjqiWsXpDNfGMI39HWEY6qMcOB2PdhsifOU4cC1Y6zSu4qfmqb/7I4B/KBLy+VdJvgw81+EkrDyBuupFv65Pgo8Y06b7RC3EgThpjqtC40r6FkCRHUU3uATZMfwLlDpTKkwkbzAzkzBMR+tMg48mwkQ+rAZH+fes4fau/Qr3X1nONzk9VgZHIpdIl14NQOuCx9eznLvThc1KzgO3nyhcEbllVqGJO7YuYrDYCdUM+aqUusukzMcjzNwdQolFDZcMjG/N46lp7TZu4kjzsdE/BccXCTdzXNey67ZA5WBxh08cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMJpBGdBwpezosvcttFjqofeG9bbTrslA/wGYm7Vwv8=;
 b=iNe29ho8ShVkkc46uSlAgLx4+v6tWy7s9/3ixqZ1ynPgAD9F1dNjdDqASe0q/dLOgc3TmKyt7LNx8upfUJHmgnbcxjfxSR3GAmwSrRO5zNUHMgk2Wdhx5VCqtRJ871+X3e69j3Kp8yBoT07msmPXs26VtrdNrWXOomrJu+yG3pE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <db00c65f-1253-38a6-9fb0-9ee3a1d5ce4f@opensynergy.com>
Date:   Sun, 24 Oct 2021 10:35:13 +0300
Subject: Re: [PATCH v6 1/1] iio/scmi: Add reading "raw" attribute.
Content-Language: en-US
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>
References: <20211019075949.17644-1-andriy.tryshnivskyy@opensynergy.com>
 <20211019075949.17644-2-andriy.tryshnivskyy@opensynergy.com>
 <20211020185118.7a02cbf8@jic23-huawei>
 <4e73398f-126a-0e1a-6eed-88d2d37778c2@opensynergy.com>
 <CA+=V6c1N8d6bB_2xKHjhygg_+45Grj9J2Z5UrdQAt6gDOtO=yw@mail.gmail.com>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <CA+=V6c1N8d6bB_2xKHjhygg_+45Grj9J2Z5UrdQAt6gDOtO=yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::22) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18edc643-4cc8-467c-c78e-08d996c0d199
X-MS-TrafficTypeDiagnostic: AM5PR04MB3220:
X-Microsoft-Antispam-PRVS: <AM5PR04MB3220BAAFD5F12FBB77F65D13E6829@AM5PR04MB3220.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8IYkBPQg6qkkkJNLn5o9cIP1hMs5EkhfhUBrzrwXQXAvLNJwzy5iiUHcnLSuUK5iq3g3YfvN7jAx9DesC7tsP0Oxxfl9wCQYhyO/3qyNHJO3XBwv9SqNoQtboB69/Q/eFcKqs0UGCPnNcG0o2GA5o2ilbd2sDKS8MwwdbjMIF1qvlZP0D6CFgQmbQ67MjI8NzrSyDD0/DEXUsQDV/Mfqpva+EuGuHA7Y4X5moXvUlrniXdDi+OGFUT1KUVfrmQU4PKK3qwomSt5Lqvu+KFGBtFc1iYLeMn0s2PQdNJoaosSlnk0HJpLfGYIXnnMMozsuOCDW79bfzv3bzklv+umE2Y3fFZ2V1SdQ21vCtMGt+TWgH1MnQaT2SUxPMZr3GFgi0M60W7qm5H2a8aUtP4lG3V/ax+ucxjNMcKiEZF/cLYvXvOoqMK0ZT/9h7LMPL+FH7/Bt2nAq6OcnQWpCq084HurgbF/p/lJxxcbvDlAee/YjId5VznB6BeCYGWFnVc3QHGDpzJhUCqXtLC4LHvVf83w/YBQYMZBosydP8R82ODVx6r9gHN0m6vT8miVKLl3l+7hBBLanIK0GK0+gphXKv1cEQeeG6yhSTZ82CW8wA1pxensNmQMzmhc16Lgtpr8QwuLAn+PCbfAoE+OSU+AUZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(376002)(396003)(346002)(66946007)(4326008)(83380400001)(107886003)(54906003)(42186006)(316002)(6916009)(66556008)(186003)(36756003)(2906002)(44832011)(38100700002)(5660300002)(2616005)(8936002)(8676002)(86362001)(53546011)(26005)(31686004)(508600001)(55236004)(66476007)(31696002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1k5dGhQcitpdEFmSWcrcmtPVldZMnhIeHNUZXJYb0RIT1hLcDZCY2pHVHNj?=
 =?utf-8?B?VUh2U1pzYmRSRHFLSUIwMnQ5U1UzdFgxN3NkWEl4RkdwYm1OZ1lGM2lhQVN2?=
 =?utf-8?B?TldBOXlPMVpkSWhTdEovR25kTTlvWmhJTUZmWUc4d25FbmZBNmo3Mk1jMGUy?=
 =?utf-8?B?eU1aVkp5dzdFQVpkUjZUaisxMm55MCtmM1RIUnJrMHVUb25EUll2d0oyZXI0?=
 =?utf-8?B?VVhZR0lvbFZ3SmJySHVZQmJQMUI4c1NpR0lqbWE1QWVrUmw1UzJNdHMwTnhL?=
 =?utf-8?B?SDltNHhDb1NSMHVnR2RMbUU1QjllQVluRHJPZmlhOW50d3JmbkVlK3JTUUo0?=
 =?utf-8?B?N0cyZGdEUWFKdmR0cmJLZEJud1ZONE8wKzlJZHVwZkJTSmtScEFIN3RlalAr?=
 =?utf-8?B?cHM3bmlkVVdXVEhHaXYzNVpnRlhrVTJZa051UmRvSGxBbXNXcDNOZXQzMi9T?=
 =?utf-8?B?YlJYa09SY3A0MFpsc3VKeGlPWXpBMGJMV3hiNmZFejFzWGM2ckNUNzB6cEo3?=
 =?utf-8?B?emdvczRaL3VDckl2WXFwalV4elUvZ2pyVVN4cVZWWEZZSGlGTVg2TXBPV2Fl?=
 =?utf-8?B?THRkc2dQdTFRemNlNHdTenFZZEFEVzI2QThsZFRxSXlnTUNnUE5xZzliLysr?=
 =?utf-8?B?aWxNazJvU2RWVUI3RGlsdWxBSElSMnc1UnVKZitnd0ZkMTVXN1A3K1FUYXVU?=
 =?utf-8?B?TXE4T2xsN1ZMbDlheDNXeVg4aG91dXlqdk5NSnV3YjI3NVdvYk5EaUFFT2x0?=
 =?utf-8?B?UU5aajZoeGt5cHB2NmVtWWUzZU1hcW9tajcyaVhvU1BXclk2TFZwdFhyS1FD?=
 =?utf-8?B?UHJmdzhicVFPWk5lNmF0OVJwRlRmMUc4YmNFMXNlMjVJc0dRUjZPNHpiMXh5?=
 =?utf-8?B?bGVqck5SRUk5UDhyUnl5ODBsbFZWbUZxVHJGcmxRRG5NYzRhVElpKzY4WCt1?=
 =?utf-8?B?WnBkNGV6MDFBckNEb0syVzFHMnRKeUNFdTBhNWhBU3dOZU9pVmlMR3J2VmJ1?=
 =?utf-8?B?V25ha0RycnNnWmVrUVJEUGNra01jaXZuTXpKZCtkT2JRK3U4dURrT2c1VllR?=
 =?utf-8?B?ZGs1N3BqS2NMck43MzZ2aXZsY00vaTdZZ21kV0YydjBTaFJ2ZTA4eEQxMWJQ?=
 =?utf-8?B?RXozQk0xQ2hlVWVITHF1elpMQnAxUnRTVWhORGFGTHZkU1Q3THJ0L2JGeGRL?=
 =?utf-8?B?TWhFK09ORUMxemFZa2VlV04xMWNZbm9MR3RmelVQSWRZd3VMamUrVUpUR3ZM?=
 =?utf-8?B?YWdrTkMvQ1pWU0ludlRoWVBOd0NveTNyMVdmaGNKV25aOHpwOEpwOFAremps?=
 =?utf-8?B?VEhlN1ptMkorYWgzVVlvNjBqQmFDTmkzaVBnWFo4bkwrdVVMcWpmZUhmbDVC?=
 =?utf-8?B?SjJ5SjNDeU0wUHFOQVczbDFVUjh2N0Y1V2NDZ2VUQmpVd2JjeHVJb1VGUkpF?=
 =?utf-8?B?RGxmSzlKRGJ4QytpUFRncFp0MkxCTzMxdlZWeWtMMDdiUEhZOWhTcXBBRzZ4?=
 =?utf-8?B?eXBVVWJmVEVYZ21FN1Jta01vV2pjY0xxS2pVQlh1bW1PSHFkcW1vSjRHNEdM?=
 =?utf-8?B?ZG5sa0t2bnYrYXUvZjQ1cTNxejMvbHhkRTJ3Q2pDUmhZc1c5RlRuL1dIQU5R?=
 =?utf-8?B?U01SbGRnRmdOUGtINlc1WVF0Wkx6L09nb2FlVVN5bWtnaHBrbVRPQU1SZ0tt?=
 =?utf-8?B?V0Q2WHFiZE14cGo4UVpicjF0WDRPSG9VOFBBYTRGUHlVZm1pRjFVQ2ZTUUZD?=
 =?utf-8?B?SXc1ampQYTE4QW5QNmN4VDQyaDQrR2FTelQwUGdteVY3VFFVbEk4enkwQXEv?=
 =?utf-8?B?blJYSzhFRlJHVnFMZEdvelBpYm9uK0lZTElPMithOU1SRXRXbEFSdE5BMWEr?=
 =?utf-8?B?Ykk2T3l0WjNwRzJ1UUNON0tBYjdPK1FUM0YvVkk0TVdNZEZjR1lJSGIySFRC?=
 =?utf-8?B?aWVQb0swaHNXVWt1N0ZXbG9DdTVZcU9PcVNlRUx1bUFXRkZjelZNMkJqaW5F?=
 =?utf-8?B?ZGtscTNYYmtpVTZUa0NBVVBCQmttd0Z1anBGbjhpNFduQy92RFdPcGNDRVJQ?=
 =?utf-8?B?WFZMeFN1dzdOMjh2WjhsYS93NkptRStvUXhuczEwdkNIOXIxVGowbFMrNElk?=
 =?utf-8?B?aTBRbXNBRy9ZTkFWNG1XNXNlK0xrNlBCUHFXam1kckdPcyt5ZFQ4d0NSRFR1?=
 =?utf-8?Q?v1dIb5XSMBuoocUUdLuBsaY=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18edc643-4cc8-467c-c78e-08d996c0d199
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 07:35:14.5038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03YiT9+649kCxRZC3qo2j+V2hwyQ4v2GHKpm8foIdAU/jwT3W8Y44eyR8AjR+x1qfof7p65TfHC/8mW7igohTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3220
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jyoti,

Thank you for your review.
As was discussed with Jonathan, I will prepare new version with 2 patches and additional comment.

Thanks,
Andriy.

On 21.10.21 03:40, Jyoti Bhayana wrote:
> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> Hi Andriy,
>
> Technically, the changes look good to me.
>
> Thanks,
> Jyoti
>
> On Wed, Oct 20, 2021 at 11:57 AM Andriy Tryshnivskyy
> <andriy.tryshnivskyy@opensynergy.com> wrote:
>>
>> On 20.10.21 20:51, Jonathan Cameron wrote:
>>
>>> CAUTION: This email originated from outside of the organization.
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> On Tue, 19 Oct 2021 10:59:49 +0300
>>> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>>>
>>>> Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
>>>> reading "raw" attribute in scmi_iio_read_raw.
>>>> Introduce new type IIO_VAL_INT_64 to read 64-bit value
>>>> for "raw" attribute.
>>>>
>>> Change log needs to be below the --- otherwise we'll store it forever
>>> in git.  A linked tag (which will be generated when I apply)
>>> is sufficient for this sort of historical info.
>>>
>> Sorry, this is my first patch, I was not aware of that.
>> Thanks for the explanation.
>> Quick question: since next version will include 2 patches,
>> I guess a change log should be moved back to the cover letter, right?
>>
>>
>>>> Changes comparing v5 -> v6:
>>>> * revert v5 changes since with scmi_iio_read_raw() the channel
>>>>     can't be used by in kernel users (iio-hwmon)
>>>> * returned to v3 with direct mode
>>>> * introduce new type IIO_VAL_INT_64 to read 64-bit value
>>>>
>>>> Changes comparing v4 -> v5:
>>>> * call iio_device_release_direct_mode() on error
>>>> * code cleanup, fix typo
>>>>
>>>> Changes comparing v3 -> v4:
>>>> * do not use scmi_iio_get_raw() for reading raw attribute due to 32-bit
>>>>     return value limitation (actually I reverted the previous v3)
>>>> * introduce scmi_iio_read_raw to scmi_iio_ext_info[] which can return
>>>>     64-bit value
>>>> * enabling/disabling and reading raw attribute is done in direct mode
>>>>
>>>> Changes comparing v2 -> v3:
>>>> * adaptation for changes in structure scmi_iio_priv (no member
>>>>     named 'handle')
>>>>
>>>> Changes comparing v0 -> v2:
>>>> * added an error return when the error happened during config_set
>>>> * removed redundant cast for "readings"
>>>> * added check if raw value fits 32 bits
>>>>
>>>> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
>>>> ---
>>>>    drivers/iio/common/scmi_sensors/scmi_iio.c | 57 +++++++++++++++++++++-
>>>>    drivers/iio/industrialio-core.c            |  3 ++
>>>>    include/linux/iio/types.h                  |  1 +
>>> Two patches needed.  One to introduce the new core functionality then
>>> a second to use it in the driver.
>>>
>>> Actual code looks good to me though I think I'd like a comment next to
>>> the #define as not obvious which way around the two parts will go.
>>>
>>> There are some other places we will probably need to ultimately handle this
>>> to allow for in kernel consumers but those can come when someone needs them.
>>>
>>> Will need an ack from Jyoti on this one though as driver author.
>>> Thanks,
>>>
>>> Jonathan
>> Sure, will split the current patch into two patches.
>>
>>
>>>>    3 files changed, 60 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
>>>> index 7cf2bf282cef..2c1aec0fd5ff 100644
>>>> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
>>>> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
>>>> @@ -279,6 +279,52 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
>>>>         return 0;
>>>>    }
>>>>
>>>> +static int scmi_iio_read_channel_data(struct iio_dev *iio_dev,
>>>> +                          struct iio_chan_spec const *ch, int *val, int *val2)
>>>> +{
>>>> +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
>>>> +     u32 sensor_config;
>>>> +     struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
>>>> +     int err;
>>>> +
>>>> +     sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>>>> +                                     SCMI_SENS_CFG_SENSOR_ENABLE);
>>>> +     err = sensor->sensor_ops->config_set(
>>>> +             sensor->ph, sensor->sensor_info->id, sensor_config);
>>>> +     if (err) {
>>>> +             dev_err(&iio_dev->dev,
>>>> +                     "Error in enabling sensor %s err %d",
>>>> +                     sensor->sensor_info->name, err);
>>>> +             return err;
>>>> +     }
>>>> +
>>>> +     err = sensor->sensor_ops->reading_get_timestamped(
>>>> +             sensor->ph, sensor->sensor_info->id,
>>>> +             sensor->sensor_info->num_axis, readings);
>>>> +     if (err) {
>>>> +             dev_err(&iio_dev->dev,
>>>> +                     "Error in reading raw attribute for sensor %s err %d",
>>>> +                     sensor->sensor_info->name, err);
>>>> +             return err;
>>>> +     }
>>>> +
>>>> +     sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>>>> +                                     SCMI_SENS_CFG_SENSOR_DISABLE);
>>>> +     err = sensor->sensor_ops->config_set(
>>>> +             sensor->ph, sensor->sensor_info->id, sensor_config);
>>>> +     if (err) {
>>>> +             dev_err(&iio_dev->dev,
>>>> +                     "Error in disabling sensor %s err %d",
>>>> +                     sensor->sensor_info->name, err);
>>>> +             return err;
>>>> +     }
>>>> +
>>>> +     *val = (u32)readings[ch->scan_index].value;
>>>> +     *val2 = (u32)(readings[ch->scan_index].value >> 32)
>>>> +
>>>> +     return IIO_VAL_INT_64;
>>>> +}
>>>> +
>>>>    static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>>>>                              struct iio_chan_spec const *ch, int *val,
>>>>                              int *val2, long mask)
>>>> @@ -300,6 +346,14 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>>>>         case IIO_CHAN_INFO_SAMP_FREQ:
>>>>                 ret = scmi_iio_get_odr_val(iio_dev, val, val2);
>>>>                 return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
>>>> +     case IIO_CHAN_INFO_RAW:
>>>> +             ret = iio_device_claim_direct_mode(iio_dev);
>>>> +             if (ret)
>>>> +                     return ret;
>>>> +
>>>> +             ret = scmi_iio_read_channel_data(iio_dev, ch, val, val2);
>>>> +             iio_device_release_direct_mode(iio_dev);
>>>> +             return ret;
>>>>         default:
>>>>                 return -EINVAL;
>>>>         }
>>>> @@ -381,7 +435,8 @@ static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
>>>>         iio_chan->type = type;
>>>>         iio_chan->modified = 1;
>>>>         iio_chan->channel2 = mod;
>>>> -     iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
>>>> +     iio_chan->info_mask_separate =
>>>> +             BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_RAW);
>>>>         iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
>>>>         iio_chan->info_mask_shared_by_type_available =
>>>>                 BIT(IIO_CHAN_INFO_SAMP_FREQ);
>>>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>>>> index 6d2175eb7af2..49e42d04ea16 100644
>>>> --- a/drivers/iio/industrialio-core.c
>>>> +++ b/drivers/iio/industrialio-core.c
>>>> @@ -702,6 +702,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>>>>         }
>>>>         case IIO_VAL_CHAR:
>>>>                 return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
>>>> +     case IIO_VAL_INT_64:
>>>> +             tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
>>>> +             return sysfs_emit_at(buf, offset, "%lld", tmp2);
>>>>         default:
>>>>                 return 0;
>>>>         }
>>>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>>>> index 84b3f8175cc6..e148fe11a3dc 100644
>>>> --- a/include/linux/iio/types.h
>>>> +++ b/include/linux/iio/types.h
>>>> @@ -24,6 +24,7 @@ enum iio_event_info {
>>>>    #define IIO_VAL_INT_PLUS_NANO 3
>>>>    #define IIO_VAL_INT_PLUS_MICRO_DB 4
>>>>    #define IIO_VAL_INT_MULTIPLE 5
>>>> +#define IIO_VAL_INT_64 6
>>> Possibly worth a descriptive comment. The other
>>> types tend to make it easy to assume the role
>>> of val and that of val2, in this case, val being
>>> the lower 32 bits isn't obvious...
>> I will add a comment here.
>>
>> Thank you for your review!
>>
>> Best regard,
>> Andriy.
>>
>>
>>>>    #define IIO_VAL_FRACTIONAL 10
>>>>    #define IIO_VAL_FRACTIONAL_LOG2 11
>>>>    #define IIO_VAL_CHAR 12
