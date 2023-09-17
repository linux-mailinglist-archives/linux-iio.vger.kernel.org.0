Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19847A35F0
	for <lists+linux-iio@lfdr.de>; Sun, 17 Sep 2023 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjIQOoe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Sep 2023 10:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjIQOoK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2023 10:44:10 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF498133;
        Sun, 17 Sep 2023 07:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFk89QYkHACgNwvzY320sX77bEcdZjg/7H+K1lHTY3+NWyNGYGKJgbfwdTu6d6U/NlX1lps2bsciX7GemS2wkFY6YLaLlGjFEfLnXamnS3SBJgNgT7MsU61ELca6MxtBqHrSIe2voCXMYUAZfKsoT4Jzqk2D4KLrKHm2rZj2D3uhx3pFOiETIoe/xr19hN5/w4DANffAHOoZIVOCKGu9TmqSCfXv59sI/RZnpCxx53Kiemg+XxXGIMSp7l5hLvDgPR4+nFMnwKxy3oBrVm4iZKNG3rO62LNea9lHXZnWTYh4NLhgOkIF7NQXJzEEui0aYsOY6SyThCo4sllJXL8KYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sDo6GC6vI6vqcppyxXa88l+5jOry7GG1e8J3HD868c=;
 b=SsyBXXiB0kk6gdIcwnMNI6d6PcBYuNnRBDSp9FfEms8Ix46IzY/27ItJtmcrto0+cD76W4oi72z28AtzZPNlFJI1qCEuNoAwPjCs2e5lQAgcyx1JIYf9RUdnE0iptMREpdbdTQ/NFQFsF0chD1onpeI5eBAAYWZ3pX5OFlrxb4njMulm9us3jG1XK5mhoJfHITT1hn9hhATFHbBGbBLrRhe/x1ZMiPQ0kbGMc653/3TVl4xO9Y6+GBZ30q07NTSnAQj9nwxEMVSY/2iGFOYFGMduRZkwcquSjYm18jqmEdKyU1SF9dSacfhn11TIvwkyIndNRLlfoPAtajsU7oWMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sDo6GC6vI6vqcppyxXa88l+5jOry7GG1e8J3HD868c=;
 b=Sj1Bo0UPgWnK6MuWbIkBOPo+M5wKQ1yAuKQdscvnQA1tX0sIyi7uhOK1y/5LZqjvPpQTOu2uckgDQ6HdBe43oDneUEfQNbL+6W2jKnK5jhfigX4VFh3sub+pPqiqbKbK/y2/UhC7mibi7hymbls9v1l0VZMzdpehQSVWY2aywvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Sun, 17 Sep
 2023 14:44:00 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4bf4:b77b:2985:1344]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4bf4:b77b:2985:1344%4]) with mapi id 15.20.6792.026; Sun, 17 Sep 2023
 14:44:00 +0000
Message-ID: <dbc3d5ed-f824-d428-923e-3f44011c44ad@amd.com>
Date:   Sun, 17 Sep 2023 20:13:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/8] iio: hid-sensor-als: Add light color temperature
 support
To:     Jonathan Cameron <jic23@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, lars@metafoo.de,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20230915051703.1689578-1-Basavaraj.Natikar@amd.com>
 <20230915051703.1689578-3-Basavaraj.Natikar@amd.com>
 <20230917120054.04e040e4@jic23-huawei>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20230917120054.04e040e4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e5d0f0-feda-468e-6986-08dbb78c86f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pjHrpvU22CvkzgqShV4Jp//9xh+W218QgLzqcda5/hReLDBNlqyVaGKuObd6ItwFZhdkqwfZrcbjJ+bWk9514F/YlpsVfvS0osS2vsh77SGCl7vJKv+WNr4k+te6dZEQUt+ROOSOsSVyDeIL7dyH1420EkhI3FMSx7DkxKyWs/wpb35H5Fp1/p2l1HUkTeKK8RHHfAJUMjSnfBXNId//NtjbeCoirH8LOfWpBemDinDeVHekFIXMYP0EpQ5fqRpdCVLSPP6loAarYX+e6WZO/GQxW5HDHknNcTSdoPdGH0PTYZBr6SfBl3c6WCcbsTN0zpa49nKvCtOKtqi1zUMqpTuFMbX8DDBpH/l6e8DyXaWpk6MW3rtC39Bq6qJFlDDAqunjX2jMrPsXnLSrFzAWMR/xPK6ohXyz9+eEUvlHkqiLwMYQtB5gvo0uUkxyDpGHnsDDOPKgJLv5i2R3vgi8hmezvA5b/Y78cGCqHtqljHvhrou4VvZo3Gu1boR0s4WhdoEccbkA2m94D4O/t15o/0mT0lac8J2/pB63OCh4T+PVwb16w/Wg22tXgrgOZYZVkz6HPQDUh9kff7HyUSl6Z58yl1gWAraJyrpMkQZ1xcq/kqoE6SbQeSXxVpMSaDG/onw29L4zeSS1VEUh1aoFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(1800799009)(451199024)(186009)(2906002)(36756003)(31696002)(38100700002)(8936002)(53546011)(2616005)(26005)(8676002)(4326008)(31686004)(6636002)(6512007)(41300700001)(66476007)(66946007)(110136005)(66556008)(6486002)(316002)(478600001)(6666004)(6506007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJ3UERzaE9LQjJqR3AyY1N6bjlVNzJ2b1Z3V1N6NS9kWU5SVU52YURGSno0?=
 =?utf-8?B?U1BnbVR2LzVtbmZZZXozUUZxcStDQ3V6OHN6YzhRNitwbnIvNVk3OW04WkZh?=
 =?utf-8?B?c2NZYUxFbTNRdXU1MnFqa3NvWXY2elBEdHhiRHRpUjZyaURraC83Z2ErME9X?=
 =?utf-8?B?MHF3MUpOQ0RxWmw5cmlnbkhsOTJ3REMxczBTSk9kT0VUVWVkSFV6K29IWFZK?=
 =?utf-8?B?UmNXMVVOZm9IMXl3S3hCeUExbEVzdmZ4WUVQL2NualB4VHE4aCtmMjRRYWRa?=
 =?utf-8?B?ays4cHU4VGRrOGVvaklvd2JvMWRXV0gzL29qVEtkcUZ1amluSEMwNG1ud1da?=
 =?utf-8?B?eUwwb0RzU0xZSnMxNEtDdVU4eWw5dVBGRkVUeTJMM3dZWWJIWmwwNkc1WGRZ?=
 =?utf-8?B?L0tXVWppQjByT0xjYlZ4VTZvaXFuUnhGbFRWS2Y2THVjSVZ4THlDV2VWSU8r?=
 =?utf-8?B?VHBLRWUwc0N2Zkl6R0NibzA1NFZJKzB0aEhOcXVPcmI4RnluMXZWdFhGQW9P?=
 =?utf-8?B?SnVuNTh1cGwwNWkwT3VpaDAzMEFmK0hJSWZOL1dVeEhCUGk1dzBhMk1TWU9S?=
 =?utf-8?B?SmdIcldTai8xKzBiMU1zYzYyZmRYTnlNY0pBTmxXNkZGc3N3RDV6eUMvUnpE?=
 =?utf-8?B?VzZ1eFNFKzY2aXFFWVRaUlNzWWR5L1Fyd2FTdFFMYm8rQnl1YkxWYmNXZmc3?=
 =?utf-8?B?aHdnUFdrVlV5dndFekxSOXdsRDhNVWE3ZDZNSGJBbE5CbXgvY1VWMyt5OUZJ?=
 =?utf-8?B?V29POXZWWEx4b0t0Mkl6TU5JSEtKWnh3eHJzK09Uc25oSm5wSFdtZmNJdkl1?=
 =?utf-8?B?THJFQmZHUmxWTHVPamlRUWlFVit3QnpOd1dmVnhzVHNWaUprSm9rSHAxNVhG?=
 =?utf-8?B?UXRkNW1WTStmaXkxL3dqVTBTTVZieFZZVDhxV3VHZGw4MHhvNkR0VHRWb21n?=
 =?utf-8?B?ZFV0Zi9IODVzQlBuekU0T2YzcHljUENpVmZ3M1NvQ2dSQW53WjR1c2NrYnB4?=
 =?utf-8?B?ME5mUVFKS2E2dDdKd1dKVnlpNlBRSmI2dHpmZVBGUUUxUmFROGVZNGZoZmxs?=
 =?utf-8?B?bk9ubENJaWsxSmMzVGpBRHFjdnladFB6QlBDcWNtdyt4Tnc4VGJzRHQ3c3Zy?=
 =?utf-8?B?ZVBLemlOa090ZzdxZExFRXJ2b3JwdnNPVWR4dzVvcXRKMUI2eVpuTm5EaWVv?=
 =?utf-8?B?eGNZWks1NjdiQjlmbGR3MS9tRktJbTlPQ0NvNzNhZTVuenI4MVlUb3dqSk8y?=
 =?utf-8?B?Z1pVZWxDSEZ3NHJ3Y0ZjM2x2R0dycllqQ0FwVTAzTkJkYXNPa3dUaUxwamcy?=
 =?utf-8?B?TUlGZmJvTnpobHV4OGxjendkWTdLUGdRb2JNT3FPQlR4Ly9FMXJId3M2M0FT?=
 =?utf-8?B?Z2lzT3pmN0VIRGpHY00rSCtpdWZna3NEbGRhS0gxREsxY0hNRFhMMnVZeHBF?=
 =?utf-8?B?Kys5a2RmWEJTTjJrMjQwODZXWC9TMXZUeExRaEhBOFluZ3lPSk9NUWYrZlQ5?=
 =?utf-8?B?R1Nnb3IrT0xPVk5HUmlGTUFvVnpjMEN0bHJFeWEwZTVVbFdSOS9FQnlEbUQr?=
 =?utf-8?B?dEdDdExDZ200YVJDQXIvek5lSmhXb1FzbFpkL1lhTFdvWDFpUW9DVlhaOS9E?=
 =?utf-8?B?elplWlhFY2tWaFptY1h1QW9pOGdKZ0tHbHZEUHNTRldvWWJkVjFRMHB4VEUz?=
 =?utf-8?B?K1BBdmxBbTVpaUVMTzE3bExlcDJmd0dycVJJV01YaERiSUo0OUd0Qk5lYVR1?=
 =?utf-8?B?bjlXa2p3VVVNMWxwaVRwZHQ2U2xaZFJybDRJL0d0bnNRMDVSQm0rQ3EwWm9D?=
 =?utf-8?B?bmlRU3FGcDY5Um9Md1BNaXFlakVZOTBkTTAzRVczV1ErOTFuRitDaUNHVHk1?=
 =?utf-8?B?TDRlZWo5a09RWitEMlFsejlUUjBCSXF3YjFoT0JQaVdYb3FSYWwxS1BLY0l2?=
 =?utf-8?B?MTMwSjBvM3drMTBraUp1YnZUYjZ4Wno1YTRGd0ZQMzlVc1oySDhhWWg4dUNQ?=
 =?utf-8?B?L3dPVU9XazZlMEtsbWtXQTdmOFAwbkw3YmIzbWZ0YnphYUdGNHJiSjVoZEZL?=
 =?utf-8?B?SFBQeHRFbXN1L01ZZy9BTkJXN1FzVnZzSG9IdU5HcUlHSWJrTVFadHliSmd4?=
 =?utf-8?Q?3aQWLsUM/Skehd+gEX+6Mkdmj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e5d0f0-feda-468e-6986-08dbb78c86f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 14:43:59.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbOkh3dVD2PYKoGI5qEB3fSzlRO0P1K0tTnLBYnb0HaHEoxAKeEKsYUFCVz/KfRxOuuGMetKEnb4vnmmvHGOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 9/17/2023 4:30 PM, Jonathan Cameron wrote:
> On Fri, 15 Sep 2023 10:46:57 +0530
> Basavaraj Natikar <Basavaraj.Natikar@amd.com> wrote:
>
>> In most cases, ambient color sensors also support light color temperature.
>> As a result, add support of light color temperature.
>>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>  drivers/iio/light/hid-sensor-als.c | 33 ++++++++++++++++++++++++++++++
>>  include/linux/hid-sensor-ids.h     |  1 +
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
>> index 48879e233aec..220fb93fea6d 100644
>> --- a/drivers/iio/light/hid-sensor-als.c
>> +++ b/drivers/iio/light/hid-sensor-als.c
>> @@ -16,6 +16,7 @@
>>  enum {
>>  	CHANNEL_SCAN_INDEX_INTENSITY = 0,
>>  	CHANNEL_SCAN_INDEX_ILLUM = 1,
> Either drop, the = 1 or keep consistency for TEMP. 
> I don't think the = 1 is useful so I'd drop it.
>
>> +	CHANNEL_SCAN_INDEX_COLOR_TEMP,
>>  	CHANNEL_SCAN_INDEX_MAX
>>  };
>>  
>> @@ -65,6 +66,18 @@ static const struct iio_chan_spec als_channels[] = {
>>  		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
>>  		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
>>  	},
>> +	{
>> +		.type = IIO_TEMP,
> Using a temperature channel for color temp is a bit of a stretch,
> Particularly as it's likely we will see light sensors with actual
> air temperature sensors in them at somepoint even if we don't have
> any already.
>
> So this needs a new channel type
> IIO_COLORTEMP or similar.
>
> Units for this probably want to be kelvin unlike the mili decrees centigrade
> used for IIO_TEMP.
>
>> +		.modified = 1,
>> +		.channel2 = IIO_MOD_TEMP_AMBIENT,
> I don't really see the modifier as useful here. That exists for thermocouple
> type systems where it is necessary to know ambient vs sample temperatures.

Sure Jonathan, I will address all comments in this series in v2.
Also, can i add new channel type IIO_COLORTEMP with following channel index
for light color temperature ?
       {
                .type = IIO_COLORTEMP,
                .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
                .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
                        BIT(IIO_CHAN_INFO_SCALE) |
                        BIT(IIO_CHAN_INFO_SAMP_FREQ) |
                        BIT(IIO_CHAN_INFO_HYSTERESIS) |
                        BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
                .scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
        }

Thanks,
--
Basavaraj

>
>
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>> +			BIT(IIO_CHAN_INFO_SCALE) |
>> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>> +			BIT(IIO_CHAN_INFO_HYSTERESIS) |
>> +			BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
>> +		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
>> +	},
>>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
>>  };
>>  
>> @@ -103,6 +116,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
>>  			min = als_state->als_illum[chan->scan_index].logical_minimum;
>>  			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
>>  			break;
>> +		case  CHANNEL_SCAN_INDEX_COLOR_TEMP:
>> +			report_id = als_state->als_illum[chan->scan_index].report_id;
>> +			min = als_state->als_illum[chan->scan_index].logical_minimum;
>> +			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
>> +			break;
>>  		default:
>>  			report_id = -1;
>>  			break;
>> @@ -223,6 +241,10 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>>  		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
>>  		ret = 0;
>>  		break;
>> +	case HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE:
>> +		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
>> +		ret = 0;
>> +		break;
>>  	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
>>  		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
>>  								    *(s64 *)raw_data);
>> @@ -256,6 +278,17 @@ static int als_parse_report(struct platform_device *pdev,
>>  			st->als_illum[i].report_id);
>>  	}
>>  
>> +	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT, usage_id,
>> +						  HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
>> +						  &st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
>> +	if (ret < 0)
>> +		return ret;
>> +	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
>> +				    st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
>> +
>> +	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
>> +		st->als_illum[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
>> +
>>  	st->scale_precision = hid_sensor_format_scale(usage_id,
>>  						      &st->als_illum[CHANNEL_SCAN_INDEX_INTENSITY],
>>  						      &st->scale_pre_decml, &st->scale_post_decml);
>> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
>> index 13b1e65fbdcc..8af4fb3e0254 100644
>> --- a/include/linux/hid-sensor-ids.h
>> +++ b/include/linux/hid-sensor-ids.h
>> @@ -21,6 +21,7 @@
>>  #define HID_USAGE_SENSOR_ALS					0x200041
>>  #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
>>  #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
>> +#define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
>>  
>>  /* PROX (200011) */
>>  #define HID_USAGE_SENSOR_PROX                                   0x200011

