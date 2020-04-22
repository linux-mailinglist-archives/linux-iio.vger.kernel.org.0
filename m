Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C664F1B45D9
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 15:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgDVNHb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 09:07:31 -0400
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:10878
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbgDVNHb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Apr 2020 09:07:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp4yhMwB3cJsyShvMYamQMP/znropGJXeOGTCAS+PwYRzetbl0oOiIZLNF3K7B40lLRDZXG8LJEiXt3EL5sNpmKKaod/YGk8EdRXnK5y05COz/w0PRts1Mf0ZLpw8sSS9z4RwtsXNp7rvNeVQn0rvG5aba640o6u3ovhGkmG4gjMNarScpKfiQZPu+EbUZdZstTjTAm23KHeUsoVS/ogMl5Sc8QerVulGnMQCaS7YZJiJ49h/SOJbSDdhOq9NEWAskDiAgSMVU1kXU2aM8/W3cTnyahL0QtNI2Mmf59ObrsVH1fDliVh8F6PcdqOhP1/gfGvbqaCG7rhF55Xg3LEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4bpvdz5V9jtSjE+DbqHfp8lsqJtMkdFMRvo1cEzeWo=;
 b=KHkTr/L9lcjQbHqC0lw8t/laY6/YdBJHwEq2ilb2r7HetWfaWb1ysgPkB2ywH2nQ9x4WeeI7JeL7OI6QdiSCx2uz8madHvHxJeK4sicyAkijI8VKp+huXGzmLQ3yTlxrfj1eYX2Bar5M2xPQP4usbw7Nd46LUhhdmt0J5aVdHe4++Tkih+MOt1ZnrNoLfNBq8Fgn3iErYzp+b9JWwgpLebtG5mMMEatYFCj2mMfYyzQ1nYCGtdBDCkbQAP/95F9Hv2d+lxWQNgooU06X+0LVMG33bM70b9HqJygmmwA8/TfjwCfN6PLOsFyJv2QJvUo18bdOyr0/lNfWygAvOIfovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4bpvdz5V9jtSjE+DbqHfp8lsqJtMkdFMRvo1cEzeWo=;
 b=RN9dfSp9qDONy7eFbCwjBd5VeibXaAUI/t24scWUDDkEXMxoXFSZFHzbncByOmgu+vrRfZeoUTqQ4/ET5+qgox3Z6HwzJaI1dmySHAwwMuHshqThMPh/jiKs3VOqFn7CTGYyON1DhbUWAAxXsE0ie9TNa2IxTY1QI0Clh0GapSQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 by BN6PR1201MB2465.namprd12.prod.outlook.com (2603:10b6:404:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 13:07:23 +0000
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759]) by BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759%12]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 13:07:23 +0000
Subject: Re: ucsi and DRD controller interaction
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-usb@vger.kernel.org,
        Jagadish.Hadimani@amd.com
References: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
 <20200421074353.GE3768833@kuha.fi.intel.com>
 <1d4fd9f3-8ea6-c054-0ba4-d50d78226fae@amd.com>
 <20200422110056.GB618654@kuha.fi.intel.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <841d88c6-e08b-72d3-6884-0aa51805e3be@amd.com>
Date:   Wed, 22 Apr 2020 18:37:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200422110056.GB618654@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BMXPR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::11) To BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.104] (202.62.82.154) by BMXPR01CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend Transport; Wed, 22 Apr 2020 13:07:21 +0000
X-Originating-IP: [202.62.82.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf7776aa-52e5-46f9-af18-08d7e6be18db
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2465:|BN6PR1201MB2465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2465268669F094ECB3E7907EA0D20@BN6PR1201MB2465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB2467.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(81156014)(186003)(8676002)(16526019)(31696002)(86362001)(956004)(2616005)(31686004)(6916009)(2906002)(36756003)(5660300002)(8936002)(4326008)(66946007)(6486002)(6666004)(55236004)(478600001)(66556008)(66476007)(16576012)(52116002)(316002)(966005)(26005)(53546011);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGEqioMuQTcBcREoZ1OCjzVzEbRFsUcPc2jLHyYcu4YLz/gYUKeTC+f8jptjZ3KNikLgG6py22YzLaDqAIrNcVB0uJePkt6R9RIH2AGiTdcintKUwlMvyPSPcalUbbqXp+uZhJLLvXEB9yVPvYBGhVLg34hZeJpcwmNQHikE7drJER4QiEhg+PJq143yQwpk/qDs7VdH8naXBbUhwZ4ydoNWwBZIkIaxWmw01iAuXqpCF2h28EyP4VWahQH4it8m6R3XtKnKgSUUlrwOfrOsrl4BcOSnGwhhJu6Tq3Iz9PgjpHBWvsFcbe3jqX+WnqbB7jTykg2G9GPWPTSLZHpNKgO9blIM6RUQZECZfK+KMFFk7u8zPVChbF4UOqmo+6h1bcy9xOJ/Bg2pjs+wbGCNAZJPOI/g9L4kzYmyxwFXvHNLe1TjmMheazRlQeU2NdvaL7V8/xsFtfkmzyxXvmP1l9BoworufwOdLjkRoxZ1ZnMbjkveNZlDj6llXievl8GV4scVnkUjvXVifi4WVlySJA==
X-MS-Exchange-AntiSpam-MessageData: nJb7hG83JcqxCD3yEr8MP3u+r72H5q/AcQA7R8zfIeEYwlaxm0hnaL84BSd8YqlDQMlx9ULA/AKVjAbfbWae6i1gAZmDbJd+O+OHtxvTuE6MCZonkIlnnxahTbZCCIYUWnaEb5CLkurbdfsAkZu5rA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7776aa-52e5-46f9-af18-08d7e6be18db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 13:07:23.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cmVAvhwwhNE1FRa7FO2XTym+Sy/8/7hoPj50WtS91f6y7rwRpmbyKT4TV1/emec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2465
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 4/22/2020 4:30 PM, Heikki Krogerus wrote:
> On Tue, Apr 21, 2020 at 07:23:30PM +0530, Shah, Nehal-bakulchandra wrote:
>> Hi
>>
>> On 4/21/2020 1:13 PM, Heikki Krogerus wrote:
>>> Adding linux-usb mailing list.
>>>
>>> On Mon, Apr 20, 2020 at 07:09:17PM +0530, Shah, Nehal-bakulchandra wrote:
>>>> Hi Heikki ,
>>>>
>>>> I need some pointer from you, so in a system where I have UCSI driver for DRD
>>>> Controller, then how call stack will be?
>>>>
>>>> I am unable to comprehend the flow from UCSI infrastructure to DRD controller
>>>> code base.
>>> Do you need to tell the negotiated data role to your USB controller
>>> driver from the UCSI driver? For that we would need to know which USB
>>> controller, or more precisely, which USB port is connected to the
>>> USB Type-C connector in question.
>>>
>>> That would require ACPI tables to be able to describe the connection
>>> between the USB Type-C connector and the USB port (and the connection
>>> between DisplayPort and the USB Type-C connector etc.). Unfortunately
>>> there is currently no documented way of doing that, however, there is
>>> a proposal for a document the defines how the USB Type-C connectors
>>> should be described in ACPI in general. The proposal does consider
>>> this problem as well. For this the solution is to use _DSD device
>>> properties "usb2-port" and "usb3-port" that have references to the
>>> correct USB port nodes as values.
>>>
>>> Which USB controller are you using btw?
>>>
>>> thanks,
>> Thanks for the mail.
>>
>> Here is the configuration
>>
>> 1. DRD Controller (DWC3 controller)
>>
>> 2. TI PD Controller
>>
>> 3. TI PD Controller and Host has I2C as transport layer. So ACPI mechanism wont work here.
>>
>>
>> Hence i was wondering, is there any way from UCSI Driver we inform to DWC3 driver stack about Role change. I can understand one point that,
>>
>> DWC3 controller can work without UCSI Implementation i.e Only PD firmware. But i want to understand  if there is a role change, PD interrupt will be generated
>>
>> and UCSI Driver will come to know about this role change. But from this onwards , i am  unable to comprehend how it can be propagated upto DWC3 stack.
> If the Type-C drivers need to tell DWC3 driver the data role (USB
> role) the connector is operating in, then you use the USB Role Switch
> Class for that (drivers/usb/role/). The USB Type-C driver (so ucsi.c
> or tps6598x.c in this case) that knows the USB role tells it to the
> USB role class by calling usb_role_switch_set_role().
>
> The USB role switch class then takes care of forwarding the
> information to the actual switch, which is DWC3 in this case. The DWC3
> driver already registers the USB role switch for you
> (drivers/usb/dwc3/drd.c), but the UCSI driver, and also tps6598x.c,
> does not use the USB role switch API yet. There has never been need
> for that before this.
>
> Adding USB role switch handling to the UCSI and tps6598x drivers can
> easily be fixed, but it's still not enough. You still need to describe
> the connection between the USB PD controller and DWC3 somewhere.
>
> thanks,

appreciate your input.  So if understand correctly, something like below  patch has to be done

http://lkml.iu.edu/hypermail/linux/kernel/2003.1/04687.html

So this patch is still under review? right, and this will take for "Registering a role switch in the DRD code". So then from ucsi.c we need to

call the role class. Also, the above patch is based on device tree binding (i.e for arm platform)but in my case i have x86 so do i have to expose this via ACPI?

Regards

Nehal Shah

