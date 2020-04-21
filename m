Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F11B2890
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgDUNxs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 09:53:48 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:6164
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728884AbgDUNxs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Apr 2020 09:53:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhgbC5/hldhBd1h8i+HxiJ/xkg1abO/I4PCRx+vBQ4fCl5QIsI6J0xdFDyB9uoK1eTCWLrRbtrJzf6g/76l9+Ix0va2qHi/+knoIyOFpRFNBwK8MPuw6CbgDy6KCOkVf9Wks8pHcItNiYEzN87wPH6vygn2UIu3e3MUrN9aIyF1JMACQErdRv8d4SCXZjZOA0SsBQlE0ocabrR8glDXobJG92FTpX6DEZ0UIsxOlOd7MWjBO6fEQRsCahRgb3V0a2Snr4y0TtzOo7vyfZQulk9sYLCRHPRPZEQD4Swwq/KoCVAgCyiluzXNmtjIYsatVw0TOsPml4grMrTbsP7taeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTYuNA2ZeQiwC8psNUKP6WObL8WOfLb6adkhmfnszDU=;
 b=R6D5MhtZkQyFdztkpDC99Byw6SUdRs915xao+nIMJvWnCM5dNzfeyJ8TKGXdE5wWWkJnzozAwbupCDBgDoK+tCFuUDaR+d0RAtXAv9eu9QNOwYWmcqW8w+4mkMvf2fNoVxeJo3CrESwdnZz87k0bISrudrYt+Z/lx85CkYhfEoApdic5Sw2DY2XiA5b4xwqGv2n7mtuny/jkL1NW+s5KbZILQOsubigWs1wnrahj//cF40ateRS9fOfLRjscubEYTqqTs5Eo2MG0B+ZEkXl+FeunibwfV4MMjH3G4XPv96JcCPA45r5ZormwS7XMLM2N+3BcbgrKkw2z/G1Q694TMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTYuNA2ZeQiwC8psNUKP6WObL8WOfLb6adkhmfnszDU=;
 b=E52biTKiSnhhPQriRDOvsf7FrPW6iIQsrTxxkvDTv3yjeBQvQZyPc56jSxYiGNs7wKTnZGMHemNiakmLMEmyeGDTEtxnTGiAWQ2Hk+GjVl6JkL1yG0AXqsE1Pr0wqv3R4+f183Qi+kHFDU4anuBPw0zh0beZwgkkJ1iQQsSUklQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 by BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Tue, 21 Apr
 2020 13:53:45 +0000
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759]) by BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759%12]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 13:53:45 +0000
Subject: Re: ucsi and DRD controller interaction
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-usb@vger.kernel.org,
        Jagadish.Hadimani@amd.com
References: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
 <20200421074353.GE3768833@kuha.fi.intel.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <1d4fd9f3-8ea6-c054-0ba4-d50d78226fae@amd.com>
Date:   Tue, 21 Apr 2020 19:23:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421074353.GE3768833@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::13) To BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.38.85] (165.204.159.242) by BM1PR01CA0119.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 21 Apr 2020 13:53:44 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86776501-fc60-43c2-e42e-08d7e5fb68cd
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0212:|BN6PR1201MB0212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0212C3EFF4440643C2907CBFA0D50@BN6PR1201MB0212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB2467.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(2616005)(31696002)(26005)(956004)(16526019)(186003)(31686004)(6486002)(316002)(2906002)(53546011)(478600001)(16576012)(86362001)(6666004)(8676002)(4326008)(66556008)(66946007)(36756003)(5660300002)(6916009)(52116002)(81156014)(66476007)(8936002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeF3WGPisfMtIN1j2VoKPrD6TSJPnQqNVuWbixxu9yYs9lTtxBcppKfcJ52OJ0607/RO+7mghj57vKtzwTvapY9lsqd6rsQ6OCUka+5YYVlbobzr4P1Uz9gPvD9wQ/agE+Ueq46EzK9tMsUfQhK9oVL09IMPaQtxbIEZYBtVH152Z8JkucAGXiKtIsTJ5bKfpUAqpU8DXEhCnmPGUJ+JqBYUxEEqljWhmeHXzU22/6U6Axp7Xpk2gb6nk8/L1daDKQryYuKi+ief8+gAxoIJhQ20UGFdN/kjuIaWwej/gvoKdmrSScXN/xWy/KVchqbEeGaJNN90EeazXPfT236eZ2KK7HM5fmvJMxvX8LaP+Slr1XUSgv4beWw+GDf5wP+pLw+mtZ+YMhQS2NwdGhR9LVylAMmbHlc39QtfC2C6R5WyEVTtAX9EjuOTDvvHji4d
X-MS-Exchange-AntiSpam-MessageData: WqGSuLPgW+n+ga10T5VY0NGvw0xgp4WL8rvJkTzU67v7TEOLtr9GMe8dozwDOpmbB/a5FNo22HJXaMEBJa/K5CRpy8jRK5LBAP+sq1DUPmHXL3ueanvV/6LHNoKmB2XiZH1Z0maOw+4P8CLRi7BtmQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86776501-fc60-43c2-e42e-08d7e5fb68cd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 13:53:45.6139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxS70i+A2XP/2QvtFJ/utGopJEHXH3Mwul2Ulgj+k6iR70eseYcx9jH51Gt40BkL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 4/21/2020 1:13 PM, Heikki Krogerus wrote:
> Adding linux-usb mailing list.
>
> On Mon, Apr 20, 2020 at 07:09:17PM +0530, Shah, Nehal-bakulchandra wrote:
>> Hi Heikki ,
>>
>> I need some pointer from you, so in a system where I have UCSI driver for DRD
>> Controller, then how call stack will be?
>>
>> I am unable to comprehend the flow from UCSI infrastructure to DRD controller
>> code base.
> Do you need to tell the negotiated data role to your USB controller
> driver from the UCSI driver? For that we would need to know which USB
> controller, or more precisely, which USB port is connected to the
> USB Type-C connector in question.
>
> That would require ACPI tables to be able to describe the connection
> between the USB Type-C connector and the USB port (and the connection
> between DisplayPort and the USB Type-C connector etc.). Unfortunately
> there is currently no documented way of doing that, however, there is
> a proposal for a document the defines how the USB Type-C connectors
> should be described in ACPI in general. The proposal does consider
> this problem as well. For this the solution is to use _DSD device
> properties "usb2-port" and "usb3-port" that have references to the
> correct USB port nodes as values.
>
> Which USB controller are you using btw?
>
> thanks,

Thanks for the mail.

Here is the configuration

1. DRD Controller (DWC3 controller)

2. TI PD Controller

3. TI PD Controller and Host has I2C as transport layer. So ACPI mechanism wont work here.


Hence i was wondering, is there any way from UCSI Driver we inform to DWC3 driver stack about Role change. I can understand one point that,

DWC3 controller can work without UCSI Implementation i.e Only PD firmware. But i want to understand  if there is a role change, PD interrupt will be generated

and UCSI Driver will come to know about this role change. But from this onwards , i am  unable to comprehend how it can be propagated upto DWC3 stack.


Thanks

Nehal Shah




