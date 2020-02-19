Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F611647B8
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 16:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSPFM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 10:05:12 -0500
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:53476
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbgBSPFL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Feb 2020 10:05:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2GcDsr8BBmSVOZyQ+aTcQ4BB3s23UmLgbxOs3xX97diygTL2b3D1YN3+HpIHBJf3bXsS6CdeNFHjBP4ENwJruwjzhZZeiFWh0+F1NlT4TM/6gWIcZKk7aTKRahcYCBThl2RwEGxTFn8Bgy8pJQhf+OTKpnu6y0SeFyt1UDGHEguwR7CLc91rGVAYqT0mHpteRAcWr4H5ctx4m7pnmruH3uEzcfeHLDpZZNNiXQIoZPy5VFuoQE51/auXDhWSgbieikL4+jYF0jzuVPQHZB7dAVCzohL+hupaYXRatRCXSHNveoD7uFHNR3o5gZ5jfzatdg6HnVXZC8KozcNASv8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+0tDCn/6mdK9uR3Gs5KKPrhDNB/oIJl5+JYO6L6OQI=;
 b=l1MaXD2F6b8Sev2kZUjenfPNBZZuWc5gygj6nDBFADBgBoTSW10Y/10H5R/A4scTolHWZSMe70EJfwvOJToJaPt/YtSF5zd3tl5sautm1QLCzJdAWvbcnrPfkHP7CLdcsp9r6rtl6Xf/WACIrRGXkGSK7g4IcaPobiZab8RnI4T30Tmcb8I11e8VAiMBWof+3yCJ615BU4oy6hjfJJdju52U2aZKn2mPFkohHIQZU8DT+2mzDQOkAJweNq/jSR0czT0bkAt62l8bh/Ghe24nT+mJAbGQP2yBvCidoOx8MaAHwBwHQp7ZxNDCfD4OVnBEP9HuM4ZAL+VdPg56NgLyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+0tDCn/6mdK9uR3Gs5KKPrhDNB/oIJl5+JYO6L6OQI=;
 b=QKfmIioU4ze0pkKFjqMCG99JcZ0TFrwSfaA8vTK1I7057ENZD4TgZrJIZa22VGBAzxm2Efw3f7TTtD6/Jl0vtbRiIEDdNsYsfuVtFRqV33Gj6eVU5p2KtOXBwGVr1flsqV1A0/qt3wz4s5vngg4S0jaa1Xlb+D9C6hV06HuUlVU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (52.132.194.142) by
 SN1PR12MB2400.namprd12.prod.outlook.com (52.132.199.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 15:05:08 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::91ea:acda:e830:2e21]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::91ea:acda:e830:2e21%3]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 15:05:08 +0000
Subject: Re: [PATCH v3 0/5] SFH: Add Support for AMD Sensor Fusion Hub
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Shyam-sundar.S-k@amd.com
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
 <1ce6f591-1e8b-8291-7f18-48876fd70e10@redhat.com>
 <CAO-hwJJkWkpApB-i0tHxEb0BeWcMpFLwSsOWKKdzGKnJEbHA_A@mail.gmail.com>
 <719b929927ce76dd7dda3a48319b5798aced591a.camel@linux.intel.com>
 <7a9b6f51-ef50-9078-325c-28e8cd17c182@amd.com>
 <CAO-hwJJj8uHVr_BTG0rcBchiEttuQTr7ovrtTQ=Cp5vJ2eeoNg@mail.gmail.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <79506ad3-5172-be36-cecc-19d97bfa8b36@amd.com>
Date:   Wed, 19 Feb 2020 20:34:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CAO-hwJJj8uHVr_BTG0rcBchiEttuQTr7ovrtTQ=Cp5vJ2eeoNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::19) To SN1PR12MB2575.namprd12.prod.outlook.com
 (2603:10b6:802:25::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.106] (202.62.82.154) by PN1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Wed, 19 Feb 2020 15:05:04 +0000
X-Originating-IP: [202.62.82.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 205ac5a1-7ed8-491a-ac16-08d7b54d1b9e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2400:|SN1PR12MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24005AB161C641F3C79D86EAA0100@SN1PR12MB2400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(2906002)(53546011)(316002)(16576012)(54906003)(55236004)(26005)(186003)(16526019)(66476007)(66946007)(31696002)(86362001)(66556008)(52116002)(5660300002)(4326008)(478600001)(956004)(6916009)(6666004)(2616005)(6486002)(36756003)(81156014)(81166006)(8676002)(8936002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2400;H:SN1PR12MB2575.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxbpjJa48A+ipxfRjrkxPMGKQtG9JtNtE5Oob4R4xST12LXOghxWp/GAjEUKRL0zLjdiUkdeOcxdOULdRifoDeGH/fyVFfTfJzzkl6TsR8Y39io8nruSB+WezsYLPJ/Iz777q3d3wcfCEeVhsyc8+7DzkyL8uIpBn7uoc1grTLP7uE500426tq17jeD81MrZsvtZOC3JXoyBFPnZaSgLTytXq3PGFxuHt72U+5JJIpGzk1i2T6flpcIfr6DZB5n/S/AOOhnT+PwiQZ/AKScBdgkXbbnkHReg4aDGG5HT9I3r96udVfPdc2eL5EID7BtniSRBMkjJ/aIcSGYxM+SXGvil/Rbssy7MOPApI/hAbAvSLs4JPjMM4dIK3pSafp9zTjBNustNgy+rDBg/FIJVAvhxB30Wyv+wmuaaQXs4I7yskmfApx4k2Cp0EFcK3C/f
X-MS-Exchange-AntiSpam-MessageData: 4fBLBoGOeCpUCJyIVt564QgFtW8Tni//7d7qW6X7dML9qKExsqMvr6hUmjrhQpov+lLU1fREuLM6nfMsdQ8kwMrnv2Q6wOUDGhJ9cdLVOG8quIXpBGNdpbuf54SwSVTlOSaGSA+Oskfxf8qd5CAdlA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205ac5a1-7ed8-491a-ac16-08d7b54d1b9e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:05:08.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mzBs93KNnPLWlRd4uA5ckILCPN4fLTfalHxj7SLHiuzlz/qmSluFNKw4ExG6mNo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2400
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 2/14/2020 4:41 PM, Benjamin Tissoires wrote:
> On Fri, Feb 14, 2020 at 11:04 AM Shah, Nehal-bakulchandra
> <nehal-bakulchandra.shah@amd.com> wrote:
>> Hi
>>
>> On 2/14/2020 10:10 AM, Srinivas Pandruvada wrote:
>>> On Thu, 2020-02-13 at 15:56 +0100, Benjamin Tissoires wrote:
>>>> Hi,
>>>>
>>>> On Wed, Feb 12, 2020 at 3:45 PM Hans de Goede <hdegoede@redhat.com>
>>>> wrote:
>>>>> Hi,
>>>>>
>>>>> On 2/12/20 3:56 AM, Sandeep Singh wrote:
>>>>>> From: Sandeep Singh <sandeep.singh@amd.com>
>>>>>>
>>>>>> AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW
>>>>>> is part of MP2 processor (MP2 which is an ARM® Cortex-M4
>>>>>> core based co-processor to x86) and it runs on MP2 where
>>>>>> in driver resides on X86.The driver functionalities are
>>>>>> divided  into three parts:-
>>>>>>
>>>>>> 1: amd-mp2-pcie:-       This module will communicate with MP2 FW
>>>>>> and
>>>>>>                          provide that data into DRAM.
>>>>>> 2: Client driver :-     This part for driver will use dram data
>>>>>> and
>>>>>>                          convert that data into HID format based
>>>>>> on
>>>>>>                          HID reports.
>>>>>> 3: Transport driver :-  This part of driver will communicate with
>>>>>>                          HID core. Communication between devices
>>>>>> and
>>>>>>                          HID core is mostly done via HID reports
>>>>>>
>>>>>> In terms of architecture it is much more reassembles like
>>>>>> ISH(Intel Integrated Sensor Hub). However the major difference
>>>>>> is all the hid reports are generated as part of kernel driver.
>>>>>> AMD SFH driver taken reference from ISH in terms of
>>>>>> design and functionalities at fewer location.
>>>>>>
>>>>>> AMD sensor fusion Hub is part of a SOC 17h family based
>>>>>> platforms.
>>>>>> The solution is working well on several OEM products.
>>>>>> AMD SFH uses HID over PCIe bus.
>>>>> I started looking at this patch because of the phoronix' news item
>>>>> on it.
>>>>>
>>>>> First of all I want to say that it is great that AMD is working on
>>>>> getting the Sensor Fusion Hub supported on Linux and that you are
>>>>> working on a driver for this.
>> Thanks for the valuable input.
>>>> But, I've taken a quick look, mainly at the
>>>> "[PATCH v3 5/5] SFH: Create HID report to Enable support of AMD
>>>> sensor fusion Hub (SFH)"
>>>> patch.
>>>>
>>>> AFAIK with the Intel ISH the sensor-hub itself is actually
>>>> providing
>>>> HID descriptors and HID input reports.
>>>>
>>>> Looking at the AMD code, that does not seem to be the case, it
>>>> seems
>>>> the values come directly from the AMD sensor-hub without being in
>>>> any
>>>> HID specific form, e.g.:
>>>>
>>>> +u8 get_input_report(int sensor_idx, int report_id,
>>>> +                   u8 *input_report, u32 *sensor_virt_addr)
>>>> +{
>>>> +       u8 report_size = 0;
>>>> +       struct accel3_input_report acc_input;
>>>> +       struct gyro_input_report gyro_input;
>>>> +       struct magno_input_report magno_input;
>>>> +       struct als_input_report als_input;
>>>> +
>>>> +       if (!sensor_virt_addr || !input_report)
>>>> +               return report_size;
>>>> +
>>>> +       switch (sensor_idx) {
>>>> +       case ACCEL_IDX: /* accel */
>>>> +               acc_input.common_property.report_id = report_id;
>>>> +               acc_input.common_property.sensor_state =
>>>> +                                       HID_USAGE_SENSOR_STATE_READ
>>>> Y_ENUM;
>>>> +               acc_input.common_property.event_type =
>>>> +                               HID_USAGE_SENSOR_EVENT_DATA_UPDATED
>>>> _ENUM;
>>>> +               acc_input.in_accel_x_value =
>>>> (int)sensor_virt_addr[0] /
>>>> +                                               AMD_SFH_FIRMWARE_MU
>>>> LTIPLIER;
>>>> +               acc_input.in_accel_y_value =
>>>> (int)sensor_virt_addr[1] /
>>>> +                                               AMD_SFH_FIRMWARE_MU
>>>> LTIPLIER;
>>>> +               acc_input.in_accel_z_value
>>>> =  (int)sensor_virt_addr[2] /
>>>> +                                               AMD_SFH_FIRMWARE_MU
>>>> LTIPLIER;
>>>> +               memcpy(input_report, &acc_input,
>>>> sizeof(acc_input));
>>>> +               report_size = sizeof(acc_input);
>>>> +               break;
>>>>
>>>> And the descriptors are hardcoded in the driver so as to fake a HID
>>>> device.
>>>>
>>>> So going through the HID subsystem seems like an unnecessary
>>>> detour,
>>>> which just makes things needlessly complex and harder to debug
>>>> (and extend).
>>>>
>>>> The HID devices which the current patch-set is creating ultimately
>>>> will result in a number of devices being created under
>>>>
>>>> /sys/bus/iio/devices
>>>>
>>>> And this are the devices which userspace uses to get the sensor
>>>> data.
>>>>
>>>> IMHO instead of going through the HID subsys the AMD Sensor Fusion
>>>> Hub
>>>> driver should simply register 4 (*) iio-devices itself and directly
>>>> pass the data through at the iio subsys level rather then going the
>>>> long way around by creating a fake HID device which then gets
>>>> attached to by the hid-sensor driver to ultimately create the same
>>>> iio-devices.
>>>>
>>>> There are examples of e.g. various iio accel drivers under:
>>>> drivers/iio/accel/ you could start with a simple driver supporting
>>>> just the accelerometer bits and then extend things from there.
>>>>
>>>> Benjamin, Jiri, Jonathan, what is your take on this?
>>>> Hard to say without knowing AMD roadmap for that. If they intend to
>>>> have an ISH-like approach in the end with reports and descriptors
>>>> provided by the firmwares, then it makes sense to keep this
>>>> architecture for the first revision of devices.
>>>> If not, then yes, this is probably overkill compared to what needs to
>>>> be done.
>>>>
>>> I suggested this approach to follow something like Chrome-OS EC based
>>> hub, but looks like in longer run this may come from firmware. That's
>>> why they may have decided.
>>>
>>> Thanks,
>>> Srinivas
>>>
>>>
>>>> Sandeep, can you explain to us why you think using HID is the best
>>>> way?
>>>>
>>>> On a side note, I don't necessarily like patch 4/5 with the debugfs
>>>> interface. It's adding a kernel API for no gain, and we should
>>>> already
>>>> have the debug API available in the various subsystems involved.
>>>>
>>>> Cheers,
>>>> Benjamin
>> Yes today, the  HID Reports are getting generated in driver. But, we would like to have HID based driver as we may go for HID based firmware in future . Hence keeping that in mind current AMD SFH design.
>>
>> So, kindly consider our design w.r.t HID for this patch series.
> OK, that's good enough for me. Jiri, are you fine with that too?
>
>> For the debugfs part,currently it is really handy for us to debug raw values coming from firmware.But if guys feel that it is not necessary, we can remove it.
>>
> 2 problems here:
> - patch 3/5 references this debugfs interface which is only added in 4/5.
> - you are creating a new sysfs set of file for debug purpose only, but
> as soon as we start shipping those, some other people will find it
> more convenient to use that directly instead or IIO, and you won't be
> able to change anything there.
>
> So I would strongly advocate against having this debugfs, and suggest you to:
> - either keep this debugfs as a downstream patch
> - either play with eBPF or kprobes to retrieve the same information
> without changing the kernel.
>
> For reference, I recently tried to replicate the hidraw functionality
> with eBPF[0] without changing the kernel code, and it was working.
> Well, there was no filtering on the source of the HID event, but
> still, I got the same data directly from the kernel just by adding
> instrumentation in a couple of functions.
>
> Cheers,
> Benjamin

If Jiri is Ok, then we will push the next patch as per suggestion here i.e. taking out debugfs.

Thanks

Nehal Shah

>
