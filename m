Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBAD1BA60A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgD0OPV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 10:15:21 -0400
Received: from mail-eopbgr680069.outbound.protection.outlook.com ([40.107.68.69]:45316
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbgD0OPU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Apr 2020 10:15:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOqpFLF5ihiGeOFeIRPOugmMFLgzxaxXkHgw880F1TnrUVyF3kLArx0yiConG4LixGZeBaDr41EovDVmTQu/Ic8LDckaJmSfRg+TTwqXpM9wI3BtytdrQ81c7/21NQEJpeZrFjoyauJrfxa760f9iZm8qjg/6XLwmQWQkExUkftbv8bCtsTjyeygwkmPXm0CbP4uUOWW+xJxpbZVbuFb+Cxk2MlOGd/XzTRXGQSBpQnl0Sni2sgDNy/GGGpxAHPhsBOs76TirbyiWzAWfrvZ/7RUSXv7PA/N3IgH0Zuq1+RDhX2P4ixPhr5JWL8JgI+zrFnWPGjGa0aphCE9IZ3b1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQfX34gKT8jweAH8TjWJtSYAllPeosxGAJJnZwMArEE=;
 b=fVGp1/ApxNBe/+cpVSI+mk4oyzaofkN7JOvjkHPOmZ79+WVD0ar9rSIW9WDqyQp/VJGspf3uBWrcUI5e1VsIisSQN4nzaauLPNdgomqBlzJ8En8zrQyei4/nv+BF7i2C9VuEYA0qi+Pi9pLeFh6s+8DnKjeuxMGbHJINySisZzUXf/Ryt1HtM+UvIeao62won+e09AXhCsSwKLMAfiH6g8nLGi9ecEqVEvgHdq6tOIcquIVDruM/4ZmCujKCyMhkyBx/RE6pzcm0m5nN2ijiGdaj1ypMtVWLh7Sb69rtIXhaFiuuqZuzrhn2jxkOFiSuq5/KcX45Ap6/XfYe893v1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQfX34gKT8jweAH8TjWJtSYAllPeosxGAJJnZwMArEE=;
 b=sRy4zXskF/DtkBfbdirAqlV8EpysTRo0uIvJ9H4kkq6WBXeUO/0jVngeIMNFbANSKF5ukcaV4RMXbc6V1nLdG5SsgwNBnC8fs4jnbbCulWH2LrneHVILIp3tmxBg7otHD11syOOI+orqN9K2kcoBU0sXweHArogaoPyDMGLfbO4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 by BN6PR1201MB2464.namprd12.prod.outlook.com (2603:10b6:404:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:15:17 +0000
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759]) by BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759%12]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 14:15:17 +0000
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
 <e85cefec-2731-65e8-f0f5-8cdc5d9e3773@amd.com>
 <20200427120032.GA2351955@kuha.fi.intel.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <b139b18c-0452-d717-856e-14b9dd03910a@amd.com>
Date:   Mon, 27 Apr 2020 19:45:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200427120032.GA2351955@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::27) To BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.104] (202.62.82.154) by BM1PR01CA0133.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:15:15 +0000
X-Originating-IP: [202.62.82.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea7391d1-94a8-40e8-05ab-08d7eab56900
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2464:|BN6PR1201MB2464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24642D1083E9506987A3103DA0AF0@BN6PR1201MB2464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB2467.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(8936002)(4326008)(956004)(2616005)(5660300002)(316002)(16526019)(16576012)(26005)(6666004)(55236004)(31686004)(186003)(2906002)(53546011)(478600001)(31696002)(6486002)(66476007)(36756003)(66946007)(86362001)(66556008)(6916009)(52116002)(8676002)(81156014);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJx92wjepP1xKJ2XVuXJk8Mt+9NBiYgO5lEMgzRII/pOvf0Htj44toJmEeNeAjPK4nbJ/f4mqmzp0a4PQ7GuH0xsAXBdMkAISxF4ReF/n0oZJwjQ1Rm9/k7sN4wFHx2iJTjpZxJWMao+IHmPDuSwg9sddAMk8xX1nO6C2haiPcFzSAnAjvRJh98OteRaBl1xWnS49t9hgskHEHWiKw90NyuR08ahC4EzJVhpH96iMKKXJYKW3NdFQkXC3L/pecGSUtbEf04BmKzd/k4rbQ+IoimqGYRh4TH38owoqBMQf0O95pBlIo3fOsN6gJx2DB6cSJ9WpKV1+cy39zuyeUi9J0pTUFSHHkh78f321a4BIQWuppkPA2RgCYhfJs66ZgjkWStxiRCZPB/XGQnNMhjEMxTEtJTWlp+Bke5sgRY7XoRqPHfCb8Ko9snfVZct+2qr
X-MS-Exchange-AntiSpam-MessageData: 1LxrTNMi+HFFNCtPbPBGDWeqm6VdD+NLUVl81qNH7gS5DHKRRs4k9xKmfPmShmkcGKJ+flzThrtjM+a7PJJzAw9jtUK2+gHRM3Od2C3Kud/6j5zghZ+1yT/mdJwepz8isLm0PU9SREmvPPaxqixRgZYgkG7AqxRazzd7AmvCV63fpAj0ulYsBYgJ+P32xFvevl/F4Kx/IG6IZnxydUpHoevphkdcmgJZp9I8lHK6YY2oOFp/VIWY+S70qRNvaJxcd+psEhlDTP9x9cK8N2U6hIP2xmkc0FcT7QaU/rgvYuLkFVAVJAJSxAjW85UiCewYdqAP963ztuJXXaeBuoDNVt8m8NxBNhbSSh3JmudW+oJq9Jgly0iw5Wk0HbysnLQFBMIEEiC7YAc7W0xpqjwKpIJtl2kN7b6Drqn2B6R6LJGtVQIsd0eSPn08gvQv0HivkU84bdP9Uenj67kOjihSqAgu9wIZhfBVoXN1G3lR4g2U0L4fY3yKRDX2HEE3EjccTVUB3teNCX5ybYJMis64haPEaQ8cWA7dN13mhpP/iGfuXWHM0NAL201bgczKwMQ3gSVyvB/YrX6LTi4A5OkovTHeJMkj6z+hZ7SNekzRkFif72W3vCf7dapjgdG6/l3gEPYka7KrtWg6k7YfR2fj5tGzZ6x99uVYAsN5eJi2QtZiTx7aG992aKYcABckoUb9peRd1SufEL++kIQG2gaMpDrit7Y5Ts/YT3KNDHK1ksHAffM30F5UUpTzlT7tRDarfHN3hsCfUkpz7q+9M2CCFCJTSR5C5I3Ko4koOtkvnyQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7391d1-94a8-40e8-05ab-08d7eab56900
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:15:17.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9pA62dOupaba5SVgtZJnFdRVIemw5UvUEJmg8ybxInc09dTMG+UYLqi07dqUsZ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2464
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Heikki,

On 4/27/2020 5:30 PM, Heikki Krogerus wrote:
> On Wed, Apr 22, 2020 at 08:23:54PM +0530, Shah, Nehal-bakulchandra wrote:
>>> Can you still influence what goes to your ACPI tables, or are we
>>> talking about products that are already on the market?
>> Yes still it is in development phase so i can work out with BIOS team for the same. When you say description of connection ,something like this should be part of _DSD method right? (i.e from below dts
>> to _DSD of ACPI)
>>
>>  usb_con: connector {
>> compatible = "usb-c-connector";
>>  label = "USB-C";
>>  data-role = "dual";
>>  power-role = "dual";
>>  try-power-role = "sink";
>>  source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
>>  sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
>>  PDO_VAR(5000, 5000, 1000)>;
>>  op-sink-microwatt = <10000000>;
>>  };
> Here's how the ASL for the _DSD should look like. I don't know how
> are all these components placed on your platform, so I'm just assuming
> that your I2C host is under PCI0, as well as your DWC3 controller.
> It's just an example, but hopefully you get the point from it:
>
> /*
>  * I2C1 is the I2C host, and PDC1 is the USB PD Controller (I2C slave device).
>  */
> Scope (\_SB.PCI0.I2C1.PDC1)
> {
>         /* Each connector should have its own ACPI device entry (node). */
>         Device (CON0)
>         {
>                 Name (_ADR, 0)
>
>                 Name (_DSD, Package () {
>                     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                     Package() {
>                         Package () {"usb-role-switch", \_SB.PCI0.DWC3},
>                     }
>                 })
>         }
> }
>
> So that property "usb-role-switch" has reference to the DWC3 node as
> its value. That's what we are after here. If you have that property,
> the subsystem will find the USB controller for you.
>
> If you need for example the properties for the roles, then the _DSD
> would look like this:
>
> Name (_DSD, Package () {
>     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>     Package() {
>         Package () {"usb-role-switch", \_SB.PCI0.DWC3},
>         Package () {"power-role", "dual"},
>         Package () {"data-role", "dual"},
>     }
> })
>
> and so on...
>
>
> Thanks,

Thanks for the details so this will enable the role switch  for drd controller. Now for UCSI driver to call the role make functions it needs the reference of the same switch reference,

so for that do i have to use device_get_named_child_node(dev,"CON0"), in UCSI Driver?

Thanks

Nehal Shah



