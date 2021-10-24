Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BAC4387B8
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 10:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhJXIvp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 04:51:45 -0400
Received: from mail-am6eur05on2117.outbound.protection.outlook.com ([40.107.22.117]:19196
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230249AbhJXIvo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 04:51:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaAoaHeYHcNojbBAsJ3fdt+G4WD5EIHokTWMrbmXL4Z39MKfHFdNex8ZGdIIab8HAnZuUdv8XBdsxGikZ+TXZ22DSPphksrK15QCd2FP8wBcMyZHsUkBrROBA4rBtCIiQf8Jqai+yCwoB4k5ijWX13ZIDmr3+FP8LyPy+zt7Yf2ekhHu9x4o9FdH1EtrBXAcUYPMDycg0xAe3RT9+I9DVJMpIkV/nOIOAq3Sf6N07tFLE5AZMHmM73J4Z5TCR699jSYF8TMiuK8R7oO1e3qVeIVck67loghyajGjNM8o7vRHPR9oq6cvN520VeBuHDSg8PfZytFgaby9NfIM0b1nkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRlfhoNq16kQwm+U78IYKn5rVEZzKoSVV28AVnsuky4=;
 b=g2h97zCWzPDsbxE1ITOOpiSNn2e3ecOuiIFocxw1Qtmly4/T/ZXj957KMvwOkcoAWt0GsYIbM76FUC1TT+L33me+GxrI2Alu6mETBbgt7s2d6mUC/iRdVHK+/4/nOqPRFIPjbTvKwSVoZRQQajXVHqHRkhibE1X57hAEs0aICVmL5iRyQqTOAqqPqoBrYETrDbw4eIgZvwr7Vwvtk0yQXsPSfvbFpoziOEOgZg7jWu+GaQsVRvNZrfeMbzGVI9SJiXj9KHF4hQpYPIkN9QBQj4/+0tYIkr7Yyxs+rqERn3+5FbmUnDbj7zC0kraYsIzaxZrCLluVxIpiXQU2mlyp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRlfhoNq16kQwm+U78IYKn5rVEZzKoSVV28AVnsuky4=;
 b=ZBYE1gM8E2YBxVURWeY7gW76MFai5RMLPcyItcn/euldP0d+aO5blNeH+CDpcL1uKEN4rdGGUYt+OV4UKbotwTL0WbMapHDtrZGLf2Ye5KwA1B3pzE0naCaKbNVBpWZXjps5fm/aU8KdDN4aEg9tu6ycGUaDf/I2ZQV/DYdFW1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <924022d1-ab56-795f-2384-616e53c800bf@opensynergy.com>
Date:   Sun, 24 Oct 2021 11:49:19 +0300
Subject: Re: [PATCH v6 0/1] iio/scmi: Add reading "raw" attribute.
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "jbhayana@google.com" <jbhayana@google.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vasyl.Vavrychuk@opensynergy.com" <Vasyl.Vavrychuk@opensynergy.com>
References: <20211019075949.17644-1-andriy.tryshnivskyy@opensynergy.com>
 <20211019075949.17644-2-andriy.tryshnivskyy@opensynergy.com>
 <CAHp75VeZ5=T8N50PoZQVsWjf5ZWjZ4kwHAxUp=pyuK6ioUrQog@mail.gmail.com>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <CAHp75VeZ5=T8N50PoZQVsWjf5ZWjZ4kwHAxUp=pyuK6ioUrQog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0069.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::18) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1ea285-58a8-4c0f-2d1e-08d996cb2c25
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3400:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34009EA5F53C72F2AA773867E6829@AM6PR0402MB3400.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtw1FV67Q8xP6ybbJUdjGex2UzmlGiWGlFMlF54FSk5cajPbi5nxFkWcFSkyfA9EZ79eidmMS0+hSCDBwdxWsF7uTJ+5eEOm8rH750H/0A9yMs8RttFqcT+PU0YWk9zRQIkvMssnDZrKItOHymUPsaCmogqQ3H3m0zdd5CzcR/GcE5koAl9vWTxy3LETVeW9XntnqXnzCm52RHtR2QxTytRifROXIqVLtu67duaw9dV04ho/tOAVl+6wi6B0QhObWtNCCEe267CPLru2flL/k6TkjjVHSIw3gqco+ShZqSWuBeVI63+FOmoZcJLqR7SSTxlqa9nJ4sYJ1Ey46qZabL2OPf6dEZo5A7diZCXVyi8aKBIAqQqxiw+h2pMZ3wGfdYV2mfJWluDLqSO8Jnkgj1ZHt335mPht0oiPtFY9sQaHBea4v7KfM17PmKBrNWsaloTn9/tsJuYEta9DgG7LI4Pvg3XxDd2TnU6sugf5sVouEfRjKMjgf16nkSveosWdeqErjGa787MsHE2vhrF/y+TFAgzyT8wf4KnohdmmrEw8SdpnVveZht92igoD4Mw3J3wS8A9U+7t4baToq6dAZ/INFV6apvOe8npdKe6EBSv0N4IWGmIbxwGygZrYoYApqq+yIAc0HFkS9xDbQmB0yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(39830400003)(136003)(346002)(8936002)(83380400001)(54906003)(26005)(44832011)(66556008)(38100700002)(316002)(42186006)(2906002)(31686004)(36756003)(8676002)(4326008)(2616005)(66476007)(186003)(6916009)(107886003)(5660300002)(55236004)(508600001)(31696002)(86362001)(53546011)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDZWNTN0VHBqb1RBM1NKcFFZcjgwbEJCbWlLdUNvQTZKeENCNTZpcUpWYmRY?=
 =?utf-8?B?VzI5ZGpDdWloNHhoOGljT2ZvTHRJU25KVlhyMkdCbStpN3RnaTRoK0VxR2Zo?=
 =?utf-8?B?K3ltQjAwUHQ3KzIvblFlbVcrTDh6ZlE5KzJPaER6aE5wS2JuUENhcnNTQUZV?=
 =?utf-8?B?WFZDa2pTRGlBNjR3ZFc5ZVZIVnpyS0swRW5CRFg2QUZnclFheFRWaHBSeXV1?=
 =?utf-8?B?d0xpUlB3Um5PL3IzV0pVQm1uWEo4MXB5WjFqM0VHdWc3NzIrZkNia2k1ZWE2?=
 =?utf-8?B?MGlqR3FaeThZNCt3MHF6TDk3UDlLRmVKQjFRZDZ3SE11N2RJSFYyTXFUZEdx?=
 =?utf-8?B?VWo5aWdnUFNoOVZqNHF5cTloa0NUWERRQlJ4a2tlTXJvRzNUZmFRTElaMXBi?=
 =?utf-8?B?aXNzekNqUXQxTGpNWEV3d3lzZDhhODN1c0NYejlVWXJsT2YyaUtqNUxjZlpE?=
 =?utf-8?B?YUhDUFc5US9VQ25yYWNIbUNtWDhqeDkxbXlvMzZQZTFucWVvdWFqT2dIZ1Zm?=
 =?utf-8?B?RkJLS3k1c2tid1lXTkRLTnRmK2JmM1QyMnZXakZDZWl0NmlQOTh1b3lKaXJw?=
 =?utf-8?B?RCtmRjNjaUlFMmJEanV6bzVCMHRvaFFhUzBZR0VLVG1DWE52QVlYR1diOC9E?=
 =?utf-8?B?L3p5MFRDUmVWQWJEb1E4UVRCQmVwLzdNSmpyMnFtNlVKVjhkc3RLQUMzQnI4?=
 =?utf-8?B?d3QyU0F1M0tEZm4zVnhydW9FaEwzNUkvMXN1Tlc3WHpxWGMzWTBtL2k4NFNv?=
 =?utf-8?B?T1A1YUY0L1FJQkNjWmVuNlBjWXBjYjdxNGhXcDJVdllieUZWcktKZjJNM2kx?=
 =?utf-8?B?NXM5Y09semtpVUY5NmVHNTZ0Qm5MRmdyMzlYU0VIUFJyRlFISnFSSmZreGtv?=
 =?utf-8?B?cDFZbnlqdlNQc0FEem9XUG9kOTBVQW0vS1B1dXJ2NVBDZGZSbmlQdTVsS1lB?=
 =?utf-8?B?VGtYdEgrbUhNdEFUa3lxOStXWTQ4VEo2TE40Ukx0REtpT1d3SHNyejhObDhr?=
 =?utf-8?B?UVB1Z3E3TGdLcXpZa1R0S0kvSHB6NmZBN3hPWDZwQ1paa0FneCtMUk5GL3Nv?=
 =?utf-8?B?WTJYUG5HUzcwUjQwSWxkQlV1cGZ5bW9WWGlOeTdLNmZ3VUJXM3BRZUZmczEy?=
 =?utf-8?B?MXlrbjVyUytscmZVWGNZR1diYjUrZDV2bzJxVXNYdTBsWEduWHA2KzJZTTlT?=
 =?utf-8?B?T1NHdk5ZZVFOMkhEV2ErTGRRb0owbmlSclVhbmdWYXZxZE50U3FJSncvdUtH?=
 =?utf-8?B?bklnVHo5bzZZSXdIS2RIOFZINlNLNFlialR5dHFibVhrL3RHTWcrOWpsWDYy?=
 =?utf-8?B?KzVCK20zaW9RTFFyajloc2NpNEd4N2NmUGlnSElBdVV6R0QrTEROUEhPeGpM?=
 =?utf-8?B?bTFORytsYnkwY2VEQ3FBdVpqUnNjZXFnQ291d1ZxcnNwU25BMkpzRnQyb0lG?=
 =?utf-8?B?QVJFcVo3S09IUGFmSDBIQk4zWUFWSyt2bElqY2dDNlllN1VSa0hreU45ajlL?=
 =?utf-8?B?SjIxK21iTWFVR00yZUhzZ0VtTW9idlR4N3U3VHRTYnRpWW0zcUE4WFF0V3Zk?=
 =?utf-8?B?QlBscCtqbXhDRUdWczY4ZDh6M0p5aEJjeDVmdm1saHJOVkE3OFF4UWNrVzRF?=
 =?utf-8?B?TkViSjA1SUg1cXVlNFNTVDE3djJnd200bTRPS29nZXlnS3ZmQ2drOGxqclNY?=
 =?utf-8?B?b0YzU2dHRUNYQkQ0Q2YxWFdscWpVQXVUUHR0VWcrTlorYVlqWUJ0WjFJNXNR?=
 =?utf-8?B?VE5naDBrZ2VRcXVIRUlneW4zNFZpR2tHMkF6QXNxT015d1ZjVHNOTWtEL0R2?=
 =?utf-8?B?ZGVaTVBiRmV0WmMvR21OM25nMG9jRndGSGMyWmpZR3pRYkpxU0lyaFNUTWVW?=
 =?utf-8?B?Rm1vT3BGSkttNmp4RFNZQVRqUlEwSUc0Q2NHUU4zQ1dwYkxON3FhenlPenk3?=
 =?utf-8?B?Z2Z2c2ZOTE03aDRzNGlqaHJZbzB0RTVNRGpiQjZDVWtpUDlteVQrWEpadzB2?=
 =?utf-8?B?RFdkTkVQeE5JTDl6bkoyZzQvMy81amZMUktZbkhsdy9Ed0llUnpibWF0OCt4?=
 =?utf-8?B?YitUZDVMbW1XTWc2emhoNjZXZXZxQ2lBVFFndTN4RHhLR1JXWnhpWDdCTWMx?=
 =?utf-8?B?aFVZTHZUZWd5U3hOWGJOb2tCSWJwSFgxb2Y3ZnR0ekdVYW1JQzFhMGg0ZXZy?=
 =?utf-8?Q?SJCS1j27Jyoxdhl+5A59pjA=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1ea285-58a8-4c0f-2d1e-08d996cb2c25
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 08:49:21.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0LML16lmhrKRvdu5xAaocf4JxsOiXrUf1/V9xBRM0ZGQWwihyhoozpY9nndselu1hWGdh9CQFprpc2vHq5ReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3400
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 24.10.21 11:33, Andy Shevchenko wrote:
>
> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
>
>
> On Tuesday, October 19, 2021, Andriy Tryshnivskyy 
> <andriy.tryshnivskyy@opensynergy.com> wrote:
>
>     Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
>     reading "raw" attribute in scmi_iio_read_raw.
>     Introduce new type IIO_VAL_INT_64 to read 64-bit value
>     for "raw" attribute.
>
>     Changes comparing v5 -> v6:
>     * revert v5 changes since with scmi_iio_read_raw() the channel
>       can't be used by in kernel users (iio-hwmon)
>     * returned to v3 with direct mode
>     * introduce new type IIO_VAL_INT_64 to read 64-bit value
>
>     Changes comparing v4 -> v5:
>     * call iio_device_release_direct_mode() on error
>     * code cleanup, fix typo
>
>     Changes comparing v3 -> v4:
>     * do not use scmi_iio_get_raw() for reading raw attribute due to
>     32-bit
>       return value limitation (actually I reverted the previous v3)
>     * introduce scmi_iio_read_raw to scmi_iio_ext_info[] which can return
>       64-bit value
>     * enabling/disabling and reading raw attribute is done in direct mode
>
>     Changes comparing v2 -> v3:
>     * adaptation for changes in structure scmi_iio_priv (no member
>       named 'handle')
>
>     Changes comparing v0 -> v2:
>     * added an error return when the error happened during config_set
>     * removed redundant cast for "readings"
>     * added check if raw value fits 32 bits
>
>     Signed-off-by: Andriy Tryshnivskyy
>     <andriy.tryshnivskyy@opensynergy.com
>     <mailto:andriy.tryshnivskyy@opensynergy.com>>
>     ---
>      drivers/iio/common/scmi_sensors/scmi_iio.c | 57
>     +++++++++++++++++++++-
>      drivers/iio/industrialio-core.c            |  3 ++
>      include/linux/iio/types.h                  |  1 +
>
>
> Usually we separate changes for core and for individual drivers for 
> the sake of bisecting and, if requested, reverting.

Noted. Thanks!


>      3 files changed, 60 insertions(+), 1 deletion(-)
>
>     diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c
>     b/drivers/iio/common/scmi_sensors/scmi_iio.c
>     index 7cf2bf282cef..2c1aec0fd5ff 100644
>     --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
>     +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
>     @@ -279,6 +279,52 @@ static int scmi_iio_get_odr_val(struct
>     iio_dev *iio_dev, int *val, int *val2)
>             return 0;
>      }
>
>     +static int scmi_iio_read_channel_data(struct iio_dev *iio_dev,
>     +                            struct iio_chan_spec const *ch, int
>     *val, int *val2)
>     +{
>     +       struct scmi_iio_priv *sensor = iio_priv(iio_dev);
>     +       u32 sensor_config;
>     +       struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
>     +       int err;
>     +
>     +       sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>     +  SCMI_SENS_CFG_SENSOR_ENABLE);
>     +       err = sensor->sensor_ops->config_set(
>     +               sensor->ph, sensor->sensor_info->id, sensor_config);
>     +       if (err) {
>     +               dev_err(&iio_dev->dev,
>     +                       "Error in enabling sensor %s err %d",
>     +                       sensor->sensor_info->name, err);
>     +               return err;
>     +       }
>     +
>     +       err = sensor->sensor_ops->reading_get_timestamped(
>     +               sensor->ph, sensor->sensor_info->id,
>     +               sensor->sensor_info->num_axis, readings);
>     +       if (err) {
>     +               dev_err(&iio_dev->dev,
>     +                       "Error in reading raw attribute for sensor
>     %s err %d",
>     +                       sensor->sensor_info->name, err);
>     +               return err;
>     +       }
>     +
>     +       sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>     +  SCMI_SENS_CFG_SENSOR_DISABLE);
>     +       err = sensor->sensor_ops->config_set(
>     +               sensor->ph, sensor->sensor_info->id, sensor_config);
>     +       if (err) {
>     +               dev_err(&iio_dev->dev,
>     +                       "Error in disabling sensor %s err %d",
>     +                       sensor->sensor_info->name, err);
>     +               return err;
>     +       }
>
>
>     +       *val = (u32)readings[ch->scan_index].value;
>     +       *val2 = (u32)(readings[ch->scan_index].value >> 32);
>
>
>
> We have upper_32_bits() and similar for low part.
I will use upper_32_bits() and lower_32_bits() then.
Thank you for review!
>
>     +
>     +       return IIO_VAL_INT_64;
>     +}
>     +
>      static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>                                  struct iio_chan_spec const *ch, int *val,
>                                  int *val2, long mask)
>     @@ -300,6 +346,14 @@ static int scmi_iio_read_raw(struct iio_dev
>     *iio_dev,
>             case IIO_CHAN_INFO_SAMP_FREQ:
>                     ret = scmi_iio_get_odr_val(iio_dev, val, val2);
>                     return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
>     +       case IIO_CHAN_INFO_RAW:
>     +               ret = iio_device_claim_direct_mode(iio_dev);
>     +               if (ret)
>     +                       return ret;
>     +
>     +               ret = scmi_iio_read_channel_data(iio_dev, ch, val,
>     val2);
>     +               iio_device_release_direct_mode(iio_dev);
>     +               return ret;
>             default:
>                     return -EINVAL;
>             }
>     @@ -381,7 +435,8 @@ static void scmi_iio_set_data_channel(struct
>     iio_chan_spec *iio_chan,
>             iio_chan->type = type;
>             iio_chan->modified = 1;
>             iio_chan->channel2 = mod;
>     -       iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
>     +       iio_chan->info_mask_separate =
>     +               BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_RAW);
>             iio_chan->info_mask_shared_by_type =
>     BIT(IIO_CHAN_INFO_SAMP_FREQ);
>             iio_chan->info_mask_shared_by_type_available =
>                     BIT(IIO_CHAN_INFO_SAMP_FREQ);
>     diff --git a/drivers/iio/industrialio-core.c
>     b/drivers/iio/industrialio-core.c
>     index 6d2175eb7af2..49e42d04ea16 100644
>     --- a/drivers/iio/industrialio-core.c
>     +++ b/drivers/iio/industrialio-core.c
>     @@ -702,6 +702,9 @@ static ssize_t __iio_format_value(char *buf,
>     size_t offset, unsigned int type,
>             }
>             case IIO_VAL_CHAR:
>                     return sysfs_emit_at(buf, offset, "%c",
>     (char)vals[0]);
>     +       case IIO_VAL_INT_64:
>     +               tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
>     +               return sysfs_emit_at(buf, offset, "%lld", tmp2);
>             default:
>                     return 0;
>             }
>     diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>     index 84b3f8175cc6..e148fe11a3dc 100644
>     --- a/include/linux/iio/types.h
>     +++ b/include/linux/iio/types.h
>     @@ -24,6 +24,7 @@ enum iio_event_info {
>      #define IIO_VAL_INT_PLUS_NANO 3
>      #define IIO_VAL_INT_PLUS_MICRO_DB 4
>      #define IIO_VAL_INT_MULTIPLE 5
>     +#define IIO_VAL_INT_64 6
>      #define IIO_VAL_FRACTIONAL 10
>      #define IIO_VAL_FRACTIONAL_LOG2 11
>      #define IIO_VAL_CHAR 12
>     -- 
>     2.17.1
>
>
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>

Thanks,
Andriy.
