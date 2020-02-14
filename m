Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E958915D52A
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 11:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgBNKGO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 05:06:14 -0500
Received: from mail-eopbgr680066.outbound.protection.outlook.com ([40.107.68.66]:50565
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727965AbgBNKGN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 05:06:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwYnuzj3Y6lEJ0WHBVI4Dk8tSj5Crd1P7tF1sYCCCEexQlUnftJiySoOytwWsZM3eXagOg4cusqORQEKn+Dp8j3KSR5Myp2/GQbrZxru2nLp4p8HoTZnJEmzVgXmUGXAEzlCzBh4miRcTwyZLk0OheOO6I1rVHRCzaKJ5+PdAz8g1dVNlys1UpbENHvpaWuNufQVgop05VrCSqPVSOdN/dSYEv3FtqQ/vQ8V+cq0wx1hEk/m2+2QUQ+XwoujxlUDqTnMDO2hGRz+Z05KUBar/mMETxfRPfue0GzSxbiepUPs+Dzz/34plEpamhL69/4eXH4yXILQaiAH94Yu/dHpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS7HK4dcFR+vFIcR77GZ0XDaL8i2L+9QHmdjfpsf+hk=;
 b=goEfF57FeHhUEOlGTk1rdFP/WJQbON4mb38RhWhiOQ+bF4ekXsF4UTchgQEIux+syZBzV/mGo7Lv2T+lHZAJtEev3rEY2kh/QCvP27aPzvdTpHZJAIY7VKyi9OxC6aIXo4qiy5t4cZo1yMV50t/6Tlyh6zOkVS6WSpjYkZgOHLu/GLFn3gm/B/x9Z/n1jlEAvKA1djYT1ncBSdBCXkjegzLLD7mQsGBO/dr17MPNI902b8NgkOwgZZYSwB/dkzK5Tgk8GgS4ycYWlS3dQWFM7/M2F4ereUsJluybOYdmwgkxzN2zDqyEXxTgtsSDwGZZdaPMcp8TArBSlZ7lbkbXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS7HK4dcFR+vFIcR77GZ0XDaL8i2L+9QHmdjfpsf+hk=;
 b=IVqkgIEPFV0ajkqsOlqzwRkweLy51ewmsBZXHLaGdz91bD0NTzYvPsljmK1OZC/J+5hdogcFcqG+PFNhksI3uxH0r46wDGRuv3lESjV7KcBe+V59gYR/2ik2zjCyUo2m0OfuOH6ZcJzJJazldEl+upS/YaMThkvOenRSsJL6RX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (52.132.194.142) by
 SN1PR12MB2525.namprd12.prod.outlook.com (52.132.196.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 14 Feb 2020 10:04:30 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::91ea:acda:e830:2e21]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::91ea:acda:e830:2e21%3]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 10:04:30 +0000
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Subject: Re: [PATCH v3 0/5] SFH: Add Support for AMD Sensor Fusion Hub
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Sandeep Singh <Sandeep.Singh@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Shyam-sundar.S-k@amd.com
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
 <1ce6f591-1e8b-8291-7f18-48876fd70e10@redhat.com>
 <CAO-hwJJkWkpApB-i0tHxEb0BeWcMpFLwSsOWKKdzGKnJEbHA_A@mail.gmail.com>
 <719b929927ce76dd7dda3a48319b5798aced591a.camel@linux.intel.com>
Message-ID: <7a9b6f51-ef50-9078-325c-28e8cd17c182@amd.com>
Date:   Fri, 14 Feb 2020 15:34:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <719b929927ce76dd7dda3a48319b5798aced591a.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::29) To SN1PR12MB2575.namprd12.prod.outlook.com
 (2603:10b6:802:25::14)
MIME-Version: 1.0
Received: from [10.136.132.70] (165.204.157.251) by MAXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Fri, 14 Feb 2020 10:04:26 +0000
X-Originating-IP: [165.204.157.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c9fb4ca-361d-4d55-3367-08d7b1354871
X-MS-TrafficTypeDiagnostic: SN1PR12MB2525:|SN1PR12MB2525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25255C8125B9BE6DA1A2E26EA0150@SN1PR12MB2525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(4326008)(8936002)(36756003)(53546011)(86362001)(31686004)(52116002)(66476007)(66556008)(2906002)(31696002)(66946007)(5660300002)(16576012)(6666004)(26005)(316002)(956004)(478600001)(16526019)(2616005)(186003)(8676002)(81156014)(6486002)(54906003)(81166006)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2525;H:SN1PR12MB2575.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +C5U7eIiMhUkizXwjyhVtU8phqmtsFX+mOEsMtSkVJmU4vsiU5Vw5NzOD2QRA+Asfg6781QtRI9FcBhq48ve8w1TY5her5/ac0elEy3KhDVQ7+dFu36iPhF8m/2Gh62M2eeOAx7bsl1UNsK6WAxSyjMIlakv0qGyRpz0ts4HWZzKKluNuQNRQwLHtU4k+Wy1b9p/Zz7GGDvR3mGbqSvUryz/9njQspR6a4XoCUAAqGKufgheiFgTS96hsl+hC7a8O+7HSc9Ed3XJSw8nFUNUUGhi3hz845xKQh3OvzIVmuJN/KsgttTRds8cuqMghZwBbbeKW80BeYezB9N9MZiSG5lygIMVVlLF+uB/TPLGrP2AiHqx71fE7JSZWYimiVFWYa3ZGOFxoYuW/nw7/R1gKgVY9bp23Pw/te+FXiI+FkaY+jRZyMs7E7O6fV+R7jGg
X-MS-Exchange-AntiSpam-MessageData: E3TRtDTRWlueT4bLet0F70z4Co1GvLvTsq799YqpeASoSofSPC7O19UHDgTbdsMBkwB/c6PCK3zji9eBjkl9DGKdEJrQiO/zSbbDRISuik70P/55LUcpveYZOrx/50sGPPcS05bpVxuqo/HlyAdnUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9fb4ca-361d-4d55-3367-08d7b1354871
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 10:04:30.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DVTH5A/B/oq/mKvOJ9JISlO8WFywDsBn543EdND9ec0e7XrHV2UeU1thnbvBJNy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2525
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 2/14/2020 10:10 AM, Srinivas Pandruvada wrote:
> On Thu, 2020-02-13 at 15:56 +0100, Benjamin Tissoires wrote:
>> Hi,
>>
>> On Wed, Feb 12, 2020 at 3:45 PM Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>> Hi,
>>>
>>> On 2/12/20 3:56 AM, Sandeep Singh wrote:
>>>> From: Sandeep Singh <sandeep.singh@amd.com>
>>>>
>>>> AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW
>>>> is part of MP2 processor (MP2 which is an ARM® Cortex-M4
>>>> core based co-processor to x86) and it runs on MP2 where
>>>> in driver resides on X86.The driver functionalities are
>>>> divided  into three parts:-
>>>>
>>>> 1: amd-mp2-pcie:-       This module will communicate with MP2 FW
>>>> and
>>>>                          provide that data into DRAM.
>>>> 2: Client driver :-     This part for driver will use dram data
>>>> and
>>>>                          convert that data into HID format based
>>>> on
>>>>                          HID reports.
>>>> 3: Transport driver :-  This part of driver will communicate with
>>>>                          HID core. Communication between devices
>>>> and
>>>>                          HID core is mostly done via HID reports
>>>>
>>>> In terms of architecture it is much more reassembles like
>>>> ISH(Intel Integrated Sensor Hub). However the major difference
>>>> is all the hid reports are generated as part of kernel driver.
>>>> AMD SFH driver taken reference from ISH in terms of
>>>> design and functionalities at fewer location.
>>>>
>>>> AMD sensor fusion Hub is part of a SOC 17h family based
>>>> platforms.
>>>> The solution is working well on several OEM products.
>>>> AMD SFH uses HID over PCIe bus.
>>> I started looking at this patch because of the phoronix' news item
>>> on it.
>>>
>>> First of all I want to say that it is great that AMD is working on
>>> getting the Sensor Fusion Hub supported on Linux and that you are
>>> working on a driver for this.
Thanks for the valuable input.
>> But, I've taken a quick look, mainly at the
>> "[PATCH v3 5/5] SFH: Create HID report to Enable support of AMD
>> sensor fusion Hub (SFH)"
>> patch.
>>
>> AFAIK with the Intel ISH the sensor-hub itself is actually
>> providing
>> HID descriptors and HID input reports.
>>
>> Looking at the AMD code, that does not seem to be the case, it
>> seems
>> the values come directly from the AMD sensor-hub without being in
>> any
>> HID specific form, e.g.:
>>
>> +u8 get_input_report(int sensor_idx, int report_id,
>> +                   u8 *input_report, u32 *sensor_virt_addr)
>> +{
>> +       u8 report_size = 0;
>> +       struct accel3_input_report acc_input;
>> +       struct gyro_input_report gyro_input;
>> +       struct magno_input_report magno_input;
>> +       struct als_input_report als_input;
>> +
>> +       if (!sensor_virt_addr || !input_report)
>> +               return report_size;
>> +
>> +       switch (sensor_idx) {
>> +       case ACCEL_IDX: /* accel */
>> +               acc_input.common_property.report_id = report_id;
>> +               acc_input.common_property.sensor_state =
>> +                                       HID_USAGE_SENSOR_STATE_READ
>> Y_ENUM;
>> +               acc_input.common_property.event_type =
>> +                               HID_USAGE_SENSOR_EVENT_DATA_UPDATED
>> _ENUM;
>> +               acc_input.in_accel_x_value =
>> (int)sensor_virt_addr[0] /
>> +                                               AMD_SFH_FIRMWARE_MU
>> LTIPLIER;
>> +               acc_input.in_accel_y_value =
>> (int)sensor_virt_addr[1] /
>> +                                               AMD_SFH_FIRMWARE_MU
>> LTIPLIER;
>> +               acc_input.in_accel_z_value
>> =  (int)sensor_virt_addr[2] /
>> +                                               AMD_SFH_FIRMWARE_MU
>> LTIPLIER;
>> +               memcpy(input_report, &acc_input,
>> sizeof(acc_input));
>> +               report_size = sizeof(acc_input);
>> +               break;
>>
>> And the descriptors are hardcoded in the driver so as to fake a HID
>> device.
>>
>> So going through the HID subsystem seems like an unnecessary
>> detour,
>> which just makes things needlessly complex and harder to debug
>> (and extend).
>>
>> The HID devices which the current patch-set is creating ultimately
>> will result in a number of devices being created under
>>
>> /sys/bus/iio/devices
>>
>> And this are the devices which userspace uses to get the sensor
>> data.
>>
>> IMHO instead of going through the HID subsys the AMD Sensor Fusion
>> Hub
>> driver should simply register 4 (*) iio-devices itself and directly
>> pass the data through at the iio subsys level rather then going the
>> long way around by creating a fake HID device which then gets
>> attached to by the hid-sensor driver to ultimately create the same
>> iio-devices.
>>
>> There are examples of e.g. various iio accel drivers under:
>> drivers/iio/accel/ you could start with a simple driver supporting
>> just the accelerometer bits and then extend things from there.
>>
>> Benjamin, Jiri, Jonathan, what is your take on this?
>> Hard to say without knowing AMD roadmap for that. If they intend to
>> have an ISH-like approach in the end with reports and descriptors
>> provided by the firmwares, then it makes sense to keep this
>> architecture for the first revision of devices.
>> If not, then yes, this is probably overkill compared to what needs to
>> be done.
>>
> I suggested this approach to follow something like Chrome-OS EC based
> hub, but looks like in longer run this may come from firmware. That's
> why they may have decided.
>
> Thanks,
> Srinivas
>  
>
>> Sandeep, can you explain to us why you think using HID is the best
>> way?
>>
>> On a side note, I don't necessarily like patch 4/5 with the debugfs
>> interface. It's adding a kernel API for no gain, and we should
>> already
>> have the debug API available in the various subsystems involved.
>>
>> Cheers,
>> Benjamin

Yes today, the  HID Reports are getting generated in driver. But, we would like to have HID based driver as we may go for HID based firmware in future . Hence keeping that in mind current AMD SFH design.

So, kindly consider our design w.r.t HID for this patch series.

For the debugfs part,currently it is really handy for us to debug raw values coming from firmware.But if guys feel that it is not necessary, we can remove it.

Thanks
Nehal Shah

