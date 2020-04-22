Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B6D1B47B8
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgDVOyK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 10:54:10 -0400
Received: from mail-bn7nam10on2062.outbound.protection.outlook.com ([40.107.92.62]:50368
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbgDVOyK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Apr 2020 10:54:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FicYhxW8kyYFSbFnREhJ8Ho4Vhh3o2+2txtCXtYOUT7DmT6aGSdD+CbRiBbSGIpMLF4gz8XsJJYTSc3A4mMLx7xXmtg3eH9JfUzPvu+RyBF4hg3np6Obr1XJvhD6VH6QZUnVdVKYXZYhSGuyvN3/mnxBlsIUVpTzeyQeCRjc53tmlJr6HnX99XmZ6+px9UKvbMmsLwftwZcpA2Gvl0nDa7EbSePhU/4H0apzQkQqi5cdntRahJJRpfdcmaUHbWBPWbKTjfKSoxruhxOX4MeWF4YAtOlQICV59vY44LS+ARlJXhFm+kpdsG1XgonzIc1xrcn/HN19eTItjXIQZveuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4ca220RjMA7cXNTp+UL+R6W/5p6IyDsNPu728mc3kM=;
 b=iJ5vUhpwiK1Dq7zV4Qia7js9wLPGEEYbdEHZjLn+OUceQ6KAB/812LY5VHPQUCtWmWeesVC9ijzd9P4zcbKsMf3epRJVZqXL3EwuY4XCzq/uFfzPDF2T21l6JN4vijMoLfF4av/oFDo6rddDEDV4EHuRZIxVA7mk56S2pIxaakjtDQIHeZB6t+gxDXWxW3+FD8gfRbfUrWliUjM6e7XPJrC0QKgboNkrT+Crb9J44QhpZFvhM8vQIqBdYHRfQ4FcoScxbGRgysKjbgbJxgl1QkzNbXyqBA6H6jbc868G34HzyZ4kDTIKhA70yqhJDUO3LSRCWpyyGMTtXPxZF7uAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4ca220RjMA7cXNTp+UL+R6W/5p6IyDsNPu728mc3kM=;
 b=kdMsSu1vrab59y30zCZ4bWykDZEK9t64IWQywj2AzN66WU5/GGHfISpalAj9bOtrFfK3an8OzMIi9yVq+KrldEq0nvSLjGxQ/8Bx0PKv0Iz87ON32qfoH4pF/25EVnsFALgpO5WLf7EhdZVLm6LQ1++t895xfV3rXFBYN6Ob1EU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 by BN6PR1201MB2528.namprd12.prod.outlook.com (2603:10b6:404:ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 14:54:05 +0000
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759]) by BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759%12]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 14:54:05 +0000
Subject: Re: ucsi and DRD controller interaction
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-usb@vger.kernel.org,
        Jagadish.Hadimani@amd.com
References: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
 <20200421074353.GE3768833@kuha.fi.intel.com>
 <1d4fd9f3-8ea6-c054-0ba4-d50d78226fae@amd.com>
 <20200422110056.GB618654@kuha.fi.intel.com>
 <841d88c6-e08b-72d3-6884-0aa51805e3be@amd.com>
 <20200422142808.GE618654@kuha.fi.intel.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <e85cefec-2731-65e8-f0f5-8cdc5d9e3773@amd.com>
Date:   Wed, 22 Apr 2020 20:23:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200422142808.GE618654@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN1PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::32) To BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.104] (202.62.82.154) by PN1PR01CA0092.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 14:54:03 +0000
X-Originating-IP: [202.62.82.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e81fb9e-c15e-4934-991a-08d7e6cd0099
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2528:|BN6PR1201MB2528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2528A8BE634CD1DD279597EBA0D20@BN6PR1201MB2528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB2467.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(52116002)(478600001)(55236004)(26005)(186003)(31686004)(16526019)(2616005)(2906002)(53546011)(956004)(6916009)(6486002)(36756003)(16576012)(45080400002)(66946007)(66476007)(66556008)(316002)(8676002)(86362001)(5660300002)(966005)(8936002)(31696002)(81156014)(4326008)(6666004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKdGRSrCOnZhzIsQT7NZE9bR+qjNlB5Y3rBPjlX0Jb2CDDBGehN3//b0pyTLPOa+CXlBkYsoKQ0wgGhseV88ugWp6D60lf7WN2d5yVrTzr11EBIwdaNNgtcgwYk5CN4RgvbmNBQPxVlZXauRPmjEZWxK/66YN13sO0HdbpQrqiVp5TBuxtDmk5v6OsuMQkYxM/V2o0IQtcaN/3+nz4eqMfuDjz5y1oqDUtdIoL8945b7ALyEVtY2zwtM5VA/OtqchlGQ0jF1x/bqzYq/77mLSuga4D6Gk7jwFzBsimTvQ0oH/nBdFamcspq68dx3h/5gvOLs1xa1XuP9a3Stf0pxunL8ARWrB6pLZ5Oxvff/0EO3UlciC35kWGBScKp35nR47n8j620euCrRN+swHrePDyOJKIDbRKWuK4V/nAPJshjVUVhi61q0BGHzn6FyX557+e6PHcCnwFjIkm8qRyKJlXi+LP5ghNeAltPbd+ZbUCpyVPjnpe8TT/tq7rzKvwKqW+JFakw49owsgrVe6gDoUw==
X-MS-Exchange-AntiSpam-MessageData: GH9hvMt6Tj3iNmhYu4RYdrzeHSYY8vu1j8M8IyL/oYfvB952+Wnw3HM+TSQgYBOFDKs5jmPH+kvWkIFhu+6suTfv55iRwglLUl6l+hMIEqanxAQAgt/f7v1dUs0QfLLk2lSLS00YqYqdM2ao7/pTUA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e81fb9e-c15e-4934-991a-08d7e6cd0099
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 14:54:05.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKAHl9G7zNCq+b5/jQRxG54kcWf1GM1XlabZyV6+hQ6Di+yCN7DNENluKcqANoUM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2528
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 4/22/2020 7:58 PM, Heikki Krogerus wrote:
> On Wed, Apr 22, 2020 at 06:37:10PM +0530, Shah, Nehal-bakulchandra wrote:
>> Hi
>>
>> On 4/22/2020 4:30 PM, Heikki Krogerus wrote:
>>> On Tue, Apr 21, 2020 at 07:23:30PM +0530, Shah, Nehal-bakulchandra wrote:
>>>> Hi
>>>>
>>>> On 4/21/2020 1:13 PM, Heikki Krogerus wrote:
>>>>> Adding linux-usb mailing list.
>>>>>
>>>>> On Mon, Apr 20, 2020 at 07:09:17PM +0530, Shah, Nehal-bakulchandra wrote:
>>>>>> Hi Heikki ,
>>>>>>
>>>>>> I need some pointer from you, so in a system where I have UCSI driver for DRD
>>>>>> Controller, then how call stack will be?
>>>>>>
>>>>>> I am unable to comprehend the flow from UCSI infrastructure to DRD controller
>>>>>> code base.
>>>>> Do you need to tell the negotiated data role to your USB controller
>>>>> driver from the UCSI driver? For that we would need to know which USB
>>>>> controller, or more precisely, which USB port is connected to the
>>>>> USB Type-C connector in question.
>>>>>
>>>>> That would require ACPI tables to be able to describe the connection
>>>>> between the USB Type-C connector and the USB port (and the connection
>>>>> between DisplayPort and the USB Type-C connector etc.). Unfortunately
>>>>> there is currently no documented way of doing that, however, there is
>>>>> a proposal for a document the defines how the USB Type-C connectors
>>>>> should be described in ACPI in general. The proposal does consider
>>>>> this problem as well. For this the solution is to use _DSD device
>>>>> properties "usb2-port" and "usb3-port" that have references to the
>>>>> correct USB port nodes as values.
>>>>>
>>>>> Which USB controller are you using btw?
>>>>>
>>>>> thanks,
>>>> Thanks for the mail.
>>>>
>>>> Here is the configuration
>>>>
>>>> 1. DRD Controller (DWC3 controller)
>>>>
>>>> 2. TI PD Controller
>>>>
>>>> 3. TI PD Controller and Host has I2C as transport layer. So ACPI mechanism wont work here.
>>>>
>>>>
>>>> Hence i was wondering, is there any way from UCSI Driver we inform to DWC3 driver stack about Role change. I can understand one point that,
>>>>
>>>> DWC3 controller can work without UCSI Implementation i.e Only PD firmware. But i want to understand  if there is a role change, PD interrupt will be generated
>>>>
>>>> and UCSI Driver will come to know about this role change. But from this onwards , i am  unable to comprehend how it can be propagated upto DWC3 stack.
>>> If the Type-C drivers need to tell DWC3 driver the data role (USB
>>> role) the connector is operating in, then you use the USB Role Switch
>>> Class for that (drivers/usb/role/). The USB Type-C driver (so ucsi.c
>>> or tps6598x.c in this case) that knows the USB role tells it to the
>>> USB role class by calling usb_role_switch_set_role().
>>>
>>> The USB role switch class then takes care of forwarding the
>>> information to the actual switch, which is DWC3 in this case. The DWC3
>>> driver already registers the USB role switch for you
>>> (drivers/usb/dwc3/drd.c), but the UCSI driver, and also tps6598x.c,
>>> does not use the USB role switch API yet. There has never been need
>>> for that before this.
>>>
>>> Adding USB role switch handling to the UCSI and tps6598x drivers can
>>> easily be fixed, but it's still not enough. You still need to describe
>>> the connection between the USB PD controller and DWC3 somewhere.
>>>
>>> thanks,
>> appreciate your input.  So if understand correctly, something like below  patch has to be done
>>
>> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Flkml.iu.edu%2Fhypermail%2Flinux%2Fkernel%2F2003.1%2F04687.html&amp;data=02%7C01%7Cnehal-bakulchandra.shah%40amd.com%7Cafa9696669a74336186a08d7e6c96354%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637231624939620306&amp;sdata=nwwQbBBlAduAOhIfvfYv9UzR%2B478yN%2Fldb9%2FLK%2F6eiE%3D&amp;reserved=0
>>
>> So this patch is still under review?
> The patch is in mainline:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3D8a0a137997448690a642e2325fe73242788b26fe&amp;data=02%7C01%7Cnehal-bakulchandra.shah%40amd.com%7Cafa9696669a74336186a08d7e6c96354%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637231624939620306&amp;sdata=%2BIf%2Bz0Cm7CG32POOf3tdue%2FSamAqWPGjaZQYwBuRFwE%3D&amp;reserved=0
>
>> right, and this will take for "Registering a role switch in the DRD code". So then from ucsi.c we need to
>>
>> call the role class. Also, the above patch is based on device tree binding (i.e for arm platform)but in my case i have x86 so do i have to expose this via ACPI?
> That patch does not actually have anything devicetree specific, but
> you do need to supply the description of the connection like I said,
> and ideally you can do that in your ACPI tables.
>
> Can you still influence what goes to your ACPI tables, or are we
> talking about products that are already on the market?
>
>
> thanks,

Yes still it is in development phase so i can work out with BIOS team for the same. When you say description of connection ,something like this should be part of _DSD method right? (i.e from below dts
to _DSD of ACPI)

 usb_con: connector {
compatible = "usb-c-connector";
 label = "USB-C";
 data-role = "dual";
 power-role = "dual";
 try-power-role = "sink";
 source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
 sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
 PDO_VAR(5000, 5000, 1000)>;
 op-sink-microwatt = <10000000>;
 };

regards

Nehal Shah


