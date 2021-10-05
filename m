Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4579A42270B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Oct 2021 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhJEMxw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Oct 2021 08:53:52 -0400
Received: from mail-eopbgr20098.outbound.protection.outlook.com ([40.107.2.98]:35328
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234165AbhJEMxv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Oct 2021 08:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIzRlnuMySVisXrfxycw/9yqAkA6ofEaeA/bVDJW2XKp5qsXIAxTleAtO8vAab78Ky6Zc4J9flit27mTa3tGitbw6a2FPs4AF+sWOz3Rqy0EQd+1xcYayZDcWhQqxGp3HJXFB88DtZ1B5D3GFuLNcPx3RalZN2mZFYPLihlX0qPJDyo3Wc4tzkKlpNo7jtTReoRnoyokk5uz0vhSjm3HZgnGtQsP1JpKMRjTOzWFneejd5Yua05HMWvAlJKLCgdNB+/+tvm/bJmx45MqFxVBQuiWValPkVXvfedD/P+kW0fSPjEd6Kmc8dZndsDsU7+BAiA3FOXPw1CQifpKNFRAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PiSJWR83FUPST09acvvBmFl3etf4U4uOgbBJL/ruHo=;
 b=oNhQ+6Q7yabu3ihIYOUfob3X1Y9ELbrker6WUpGvgfaFJ5OfTpWuxB7TeLSskuGFNeu+XKywh9BcYXR7FtRnFX3Qw25R6oO/7sqRUBweUWyaTc8ryJxPnEeUiugGYaeBsNdJqAu8+uGxPjgkGviFCuv5yNVHZQBZjW6inlFrVMwznsOXmrMBoE4QXLutGxTFiANFzAUAiTzEnvUdaw9VzWKXCOyVx0lNE7SPU2VqemB64bCV8ufOO2cDPx161XbxqFVSXsCDFIfJDZgAO/oGg+jkMnJL0BowG9oKdpP31jpKbjssIR+njlO5u7spUMQWMFNcq6yEUYkItomAkVGV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PiSJWR83FUPST09acvvBmFl3etf4U4uOgbBJL/ruHo=;
 b=K4pN6efhnHyAPxePkvM4vuJkf8e+XvflOfNdEsoxr1Lto4cdFRe9BoAHg7Fo/3tRGcyR71XUJfdB+1zz28l1k29WeVKX3RNAuYPOfb07qLRs8q4NCpWY6/7UACuPf+ejMLjuXpzpMv7lG/7wsdw0m0V1uiiHpD3vYb0q178n/zg=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
Message-ID: <650ec3b8-c970-604c-9be6-577c46d3e762@opensynergy.com>
Date:   Tue, 5 Oct 2021 15:51:57 +0300
Subject: Re: [PATCH v3 0/1] iio/scmi: Add reading "raw" attribute.
Content-Language: uk
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
References: <20210928161957.24628-1-andriy.tryshnivskyy@opensynergy.com>
 <20210930174043.0845f6ed@jic23-huawei>
 <CA+=V6c34+VtYbUDG=NuY6YeyML23Tth2+fTjhvXpwMvrtkM5_Q@mail.gmail.com>
From:   Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
In-Reply-To: <CA+=V6c34+VtYbUDG=NuY6YeyML23Tth2+fTjhvXpwMvrtkM5_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0301CA0026.eurprd03.prod.outlook.com
 (2603:10a6:206:14::39) To DB7PR04MB4140.eurprd04.prod.outlook.com
 (2603:10a6:5:20::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f089fe84-eb1b-41ed-198d-08d987feeb3e
X-MS-TrafficTypeDiagnostic: DB9PR04MB8234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB823455B418CFCD0B4BBF98DBECAF9@DB9PR04MB8234.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNvzmwc4cdl25xy4AGD0h0N4YVQ1f/NmjSqQoaHMAeg/Iuw0jKnRQpHeCnJwnzmx1N+TguE1WpRuBWyXl4ZwoL5LjirHROwlHSwAAynDzP7OqyCC/xE+IC9MPMTSiAsh+TN2MhB7dwQebrqKSF8UAf1D/CZkytGRbz9yAcTzFqOvewz7YsjetfZwEFAZOs9BJ/QtCatSFEVbHaoY6F537WzSVrRMSylHI6LVwemaDzQU7qWQaax3vE7C1PEBQNPKbfLfZpyaEffLJHswEcdn2Xsrg+lRLVjV5VunQzTnCyZLGLD2gdqLTbTdVOrUmfwS1LM7EnZ1NdHyKnjh5694RShb7XzAMly+dKGnp83i7fkS5p0nypRKKdBkhg7WxDcaKkbb5qW60YQpAVQGoNPhAmzknAplC5pxsnYf7anXszkuspcOT36fnhCQotrYGlVWq+DNj9A4Uw8SMaxtOp2Wn226l1vuLagEoRQAEVnVJ0Xc5IAN9Fuil29tdworbKhX8azBwxLguNqxKkggVYxV7d2ZV+HLr4VOk+c5vjWd8KlPpT03704wxH8X2XsLGXTf7CK2qN1qnPGY5EfE/rWQDdLsbLWMtDiu31Foyaffz5pBMHrKagrh25PSZemJQGNstCigF55r3BsgB1x5G4Eoa7NDxrSh4KGYr9KDvg3FdV/8bcoqV/KbousKJw8ZmeitU/28gjoSlIvTR0CSxaZGpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4140.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(39840400004)(346002)(6916009)(26005)(52116002)(2906002)(66476007)(42186006)(8676002)(8936002)(316002)(86362001)(66556008)(38350700002)(66946007)(38100700002)(44832011)(31686004)(54906003)(5660300002)(36756003)(4326008)(31696002)(2616005)(508600001)(186003)(83380400001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmV5alpkMmJNV1lvaXNCY002NUN1RzUxeWxORTR1b2xmLzNYdDVQZUx4ZEZI?=
 =?utf-8?B?ejdZdXVtYkx2OEdEL1NIa2lEdVl6ZHJHVWc5UUpVOFBTSVRkMzdVVzFNMUNw?=
 =?utf-8?B?SHpyNE9EMUthc0NjdmdVdXdvbkt6THAvdHdNZkg0RFk4aHFtT0JvYUQ5OWdx?=
 =?utf-8?B?OGxPSHEwT2x3ZkdrTU0rcmYrK3YwZVJmL0hqQ09qQ3dhOXhidDB6eFFNdExC?=
 =?utf-8?B?a1VXbkp1ck9NOXE4R3ovVktBdGlacWRpTFZMOU9rcGNMdC93Wm8zTm5VRG5n?=
 =?utf-8?B?OU5MZS9PaWhtaDRraHJ0SDJtblI5aUtBQXp4cWp6MmpRbjRMVTY3eko1ZnFH?=
 =?utf-8?B?NW1uSUNzdFRaTkFZQmVZZWF6Z2JNekMrckNyMXBBeGc1c3lzK3p0d1k0N3pC?=
 =?utf-8?B?NDIvTVdwNjd6bVZwSE5RZk5DeVRlTGlFUDhZcWd2ODdkN1BmdnhlRTMySExY?=
 =?utf-8?B?TXFHTS9wS3BPK2wraHcraWpZZlJ6alN3UXNjcUFML01WSjBZNlFwM2U5NTRR?=
 =?utf-8?B?WWozWmVUbDlEMW9CakNSZUxkSER3VTNQNEJpVTBidGFwK05YK05vNnd4ZEk5?=
 =?utf-8?B?WWYwVUk3RjRwSEdxVjVFdGVGY3llRWZ6TGJiRXh0YWF5WGY5cmExOVVFNU5m?=
 =?utf-8?B?NHcydnJGZ0wvTjRTWmVtbGF3M3VhS01idVRMOUYrRUF6aFhoVTlXZlV4K0hK?=
 =?utf-8?B?VDdXdUZiU3E3OUhodTh3L09Xbm96bFJTZlViZ3ZXOG1saWszcERWY1JjYVFz?=
 =?utf-8?B?VzNRdVE2S3F3YTJMWktSa1pqRGNTLzR6eGRoWnhiamNWZEsvQUxiZzhBT1dk?=
 =?utf-8?B?dmh1anoyRC9HK1RMckRPL0JZS00vTnN4UzZlYWV2cjZjWmUyc1lhMjNzNjVi?=
 =?utf-8?B?b2tZc1RtVHlQc01XdVdZWDFOd28xWlJ2Ty9HYmFDbGcrVVQ0c2pSRjk1Z1Zo?=
 =?utf-8?B?Mm5qT2dGMmR5WGFXNWVpanFqUGVOenc0TXJYVU53a3NWemg3VlVDOXk3R1or?=
 =?utf-8?B?Q2pCMVNMbDFSUmNBa2c0YlJRaUsyU0NVRXZncHV1NE1BM1g0RjR3d3E2bjVw?=
 =?utf-8?B?SGQ5Q3JqUFRGeG1BbktOVHpEZ1hVNXpseFc4YlU3SDNSZ1ZUSlBMU0YyU3h2?=
 =?utf-8?B?UktGUVE4UFRwdWlYSUdaV3FMeUlKTWhEV1pDenY4eEk1aGd6Z3BGOEptQ0Z2?=
 =?utf-8?B?SklmQVhLUnd2c3UzUTZVeEFKZ1F2ZzVmZU9VN1QreHpiTU9LWW1UN0pVdGRx?=
 =?utf-8?B?SnhzSUNmaTNpNmhYbG15QSswL0Nhei9OQ3VBSFdndnM3WWFjcldJNURmc2xX?=
 =?utf-8?B?YWwyYkwwRlpVM1gvTGF3bXB6aHp3K2xheFloN29PWVF0b2NlUVNBM0IrR010?=
 =?utf-8?B?MlIzN0c5T0F5Z25jem82cllvWDdsMnJ6NU5vNlJ0V0JqRnVNT0dacXVrQlAv?=
 =?utf-8?B?dUN6Z21IaE4vWjZpQ2Y5dEllU054bzg2NmRKV2t0YkJ3UVV5L25wQVgrVStB?=
 =?utf-8?B?bytzUXhYQnRTR2lJL3Nxb2tYakJuYmUxemdoTE1wZ3d4TW01QjV4cGtEWU9r?=
 =?utf-8?B?cDZaTDUyTExLSlJGQ0N2NjNDMzA5M04wNHN6TUtCSlZEREdmWE04UnhJUWpF?=
 =?utf-8?B?QVB2b3F3UG13YWY2Tm9BVnRtUkFJWTd6WlE3SlNaYVdkWFRmNnN4RUxlaWFj?=
 =?utf-8?B?K1F1eWZDY1kxdHZSTTJkby8vZmZlMFVzWStOY1JkaW84THRyeGRYRGlsSXhv?=
 =?utf-8?Q?A1NhcUMJ/SN/8gerN2uDbLUpwT9qBPFKD0n7YS6?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f089fe84-eb1b-41ed-198d-08d987feeb3e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4140.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 12:51:58.9983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GhOr/fQv7yTRlY21jN3Jgrux0MpTkRz6bs5Uou87UZEMxrAM6kMBON3hGu2JHf6uEGdr7rL7gucOAi7EAy4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi, Jyoti,

> In the code below, why is the logic of enabling and disabling the
> sensor in this function?  Generally the function to read the sensor
> value is just used for the code to read the sensor values ? and not
> enable/disable the sensor

But to read sensor value we have to enable it first. Other way to enable 
sensor we found is, for example:

   echo 1 > /sys/bus/iio/devices/.../scan_elements/in_anglvel_x_en

But, this command is related to IIO buffers use.

Other sensors drivers enable/disable sensor in read raw too, for 
example, drivers/iio/accel/kxcjk-1013.c has:

   case IIO_CHAN_INFO_RAW:
           mutex_lock(&data->mutex);
           if (iio_buffer_enabled(indio_dev))
                   ret = -EBUSY;
           else {
                   ret = kxcjk1013_set_power_state(data, true);
                   ... reading ...
                   ret = kxcjk1013_set_power_state(data, false);
           }
           mutex_unlock(&data->mutex);

But, after looking on this code I have some questions:

1. Should we block reading raw attribute and IIO buffer enabled, for for 
SCMI sensor it can coexist?
2. Should we wrap reading raw attribute implementation in iio_dev->mlock 
mutex?

>>     case IIO_CHAN_INFO_RAW:
>> +               sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>> +                                          SCMI_SENS_CFG_SENSOR_ENABLE);
>> +               err = sensor->sensor_ops->config_set(
>> +                       sensor->ph, sensor->sensor_info->id, sensor_config);
>> +               if (err) {
>> +                       dev_err(&iio_dev->dev,
>> +                               "Error in enabling sensor %s err %d",
>> +                               sensor->sensor_info->name, err);
>> +                       return err;
>> +               }
>> +
>> +               err = sensor->sensor_ops->reading_get_timestamped(
>> +                       sensor->ph, sensor->sensor_info->id,
>> +                       sensor->sensor_info->num_axis, readings);
>> +               if (err) {
>> +                       dev_err(&iio_dev->dev,
>> +                               "Error in reading raw attribute for sensor %s err %d",
>> +                               sensor->sensor_info->name, err);
>> +                       return err;
>> +               }
>> +
>> +               sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
>> +                                          SCMI_SENS_CFG_SENSOR_DISABLE);
>> +               err = sensor->sensor_ops->config_set(
>> +                       sensor->ph, sensor->sensor_info->id, sensor_config);
>> +               if (err) {
>> +                       dev_err(&iio_dev->dev,
>> +                               "Error in enabling sensor %s err %d",
>> +                               sensor->sensor_info->name, err);
>> +                       return err;
>> +               }
>> +               /* Check if raw value fits 32 bits */
>> +               if (readings[ch->scan_index].value < INT_MIN ||
>> +                   readings[ch->scan_index].value > INT_MAX)
>> +                       return -ERANGE;
>> +               /* Use 32-bit value, since practically there is no need in 64 bits */
>> +               *val = (int)readings[ch->scan_index].value;
>>
>> +               return IIO_VAL_INT;
