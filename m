Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F956414947
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 14:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhIVMqT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 08:46:19 -0400
Received: from mail-am6eur05on2130.outbound.protection.outlook.com ([40.107.22.130]:10497
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235991AbhIVMqT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Sep 2021 08:46:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOdyAcjR5THYlNyk8ZHYSjzK2/TN1+qsLSNKcusmwWrzvnyc13ThNtHqAUKA5xhalLwByxlXsGA9sOR1cObP8aqNjltHbAjKLnbNyiWpq2c1WUSAtCo6aNqFK3x7/3tuQtocuRiFjDiRx6+DQUSq5ltACnBROOyP114wWs8d35syWokOyIfkqmSFTFx1CJE64VhocqjE0azZj1qzAn9nEu2Toeh00uCm0YpdQae/jq84nONoKr3+/N2FzP42lGCUXPDUzmhA1qAJ0Cm2pwwf0MwtaEsvNjO5WCH+CynOQ0Jqs+tovMX0GjYVsUFO0NvurH2RXQatht+V4YFsm4YXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XzHWI4REt1ivF6womhjrO2ECerCph4FHeWlvs7yBXzY=;
 b=nCHfExTSVk7LCP+Vr4Eceqej5BwQ/8IAJISClLnTkarDULoyQWlkjNboF9+DpdjAbc6PGtQ/UzDgQCumxiI7CwnDBfy2ddZeG+bvVrWZMC6YJqVT9IyZDzIOkdBXTJZel9YVJryFqDshn0D2C6m/j+PQE1cXE/Iq8AOvsLkJ0uimZJs7HlmrrFm88WFYk1rLYVuRP6eoGJhYJfF2EJQXUEmMc1Ej9Sq0wU0WN/NDOZkGURUcELzBs7vmkrNrKWEEJG7HdxDuyWlbQJNIgQI/ATeVg2DxK1IL7M1U+gFn5rixlYbWyskeRvF/TCTX10Kj16jbH7rFnEqizYNLIGuZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzHWI4REt1ivF6womhjrO2ECerCph4FHeWlvs7yBXzY=;
 b=Nsv2g1KEzVpuZineUHjiRCUy/BxQEbhdjRl6Ynm65ZLKOPsKMOrHdmIfdiH2AWdaGOH0GGoyr47mLRhyT5a1ZZd/TOTL0v8M/W4hjoq/n5n4+smYRGKQDX++yat32+vjMcswbK+1Jib7J0Yl26DGY97j0ZFSgH15A3/UKRgjkAE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6651.eurprd02.prod.outlook.com (2603:10a6:10:218::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 12:44:47 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 12:44:47 +0000
Subject: Re: Reading ADC that comes from a multiplexer
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-iio@vger.kernel.org
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
 <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se>
 <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <799fc96d-b09f-be3b-9c7c-8e1365f3afb2@axentia.se>
Date:   Wed, 22 Sep 2021 14:44:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::16) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0027.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Wed, 22 Sep 2021 12:44:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df1b5fe4-c78a-46f7-7899-08d97dc6c2e8
X-MS-TrafficTypeDiagnostic: DB9PR02MB6651:
X-Microsoft-Antispam-PRVS: <DB9PR02MB6651FBA25126AD471DD7719DBCA29@DB9PR02MB6651.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ds+BUC5WuD8C9GDSme9Kq1b96Sl+qCXBwpPLXr/KPFz0a3fctgt5gwjTooRdgdebW3I8XysJpmvSz8DGReCJZDBSvyPsZ3yvj38aHj4hpIaTrb76+gLCeNPmji2rMgrWHh+XCSujLUnwn+RAQ40O/X4yweO21m6+meQ3aZQxfg6zhO9s1L6bAjRFi2fBWGmAjI0M+QNmIrckhWKmoxXiU7G2y13las1iM/GcRWuTJVmpuXvXRBe/+3GlAHNQf6qCjJ/KZSVOcF2vzXcoLlV9anL9XZgVg1zpm5AyLIZWmeeeUCof3uyFTvOwBZPX4HtlWQiFHEtJToDh1VNhIAnSFNZt5vpKk3SIqAxnB6NupaiJYA7L9HV0hMmt4Bo+nbdkH3DGb9M3zEEizL+kF9kideNz6TTlErJ4b+7tLISU6C0owyVjsXb/toBEKAV0tKdydLvbc00UNe6DHbKqdCYRvtV9SmbCmX0kP6Yn6sh4iK+Sar56RtI/gdBQafj+Eu8bAhApgljB11oY+OT5FNMIFyJTIHhsmNMceVnVh9jh3ZFF+6XxGqi6CddqqPOENRzZ9iK82BrA0VLgzMrPec9N7UAeOvPTG+b/+y/HvVl/44GST2a/nO7ycsUr74TCgHIperTRi3YBas8UWceBzZFXVnPPip6MiOoCqn233G7v9pk6K8ZpWE25sA8DG9EGltkIP29wta/8dnoYcfIT5r9oD7NlMU9EHSMbUzjKZhK3yxv+pkfWK8yHhxA2kGThKEkrd2Sts8XRJ5Ic9MZlIYF9Fghh7Apzy9P0undzBbCrkrTV7EhcOS5Kz6XD9pKgXH9+mk1BgNnfdpNmRxEO822qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39830400003)(136003)(396003)(346002)(366004)(966005)(316002)(2616005)(16576012)(53546011)(38100700002)(5660300002)(8676002)(31686004)(6486002)(508600001)(31696002)(66476007)(36916002)(8936002)(4326008)(83380400001)(86362001)(6916009)(186003)(2906002)(66946007)(956004)(36756003)(66556008)(26005)(10126625002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0M4T2IvWHNsYU1sUWNiNlFXZ2REWnZueWVUSDdKOTVIQWV1OTVHUGcrMnBT?=
 =?utf-8?B?a3d4TjkzZy9lUTgvZ0RLd0hHWTFoT2IwN1BPNVd4VEpramptdHpDLzY0ejBT?=
 =?utf-8?B?N1ZGeVlRdEEzdTgxRmtXUDNJT0dJUWE2bE9qQUJ0V1gvaXhUZ1Z5NVFSc0tw?=
 =?utf-8?B?ZkhEVWdSR1NvMm92MDNDNml6S1VJL29Pbktqck1PSVVSTHNEVmU1Z3JOSkg4?=
 =?utf-8?B?RTh4UXJHaXErQzFPMGVrZDk0QzZSQlNKVHdmaUlsbFNpY01PK2xxQjVzTGtw?=
 =?utf-8?B?bXUzKzRxenZhVy9MVG5iUXVPdExVNTJIZ2cvcGgvV3RvcXNIUUl2Z0h4Q1Ft?=
 =?utf-8?B?Z1RjMFcwTkJaWFQ0SUJTeUYyQ0FXYisxV3FGQ1JPamZCb0p0azBQQXVHQ0pJ?=
 =?utf-8?B?cXI0UWl2eTJ6cW52RFEwdjh3MHZmQWJFK1Z3N0wvMFlEQ0tlb2J4MXIrNDAv?=
 =?utf-8?B?YU5LTy9qR3pPbThYTVBERkhXc3l6cTVxa3gycTBwa2RUVDR2dzA1TmhjelNl?=
 =?utf-8?B?cmZkWk1Idi9oK0tNa0diWGgrTzNGcmZzb1FiSXFYOG4wNzRJWHptSFUrNW9R?=
 =?utf-8?B?dTQvN3pyR3ZXQm9kUWIwOHdEUnFOQnQ3WmEyTVN5Rk1MVDJxNWRBM0xEcTVo?=
 =?utf-8?B?UDhqdHlJV1lLTHc5NDJMS3l5ZE94U3UzWlZiRkhXb3ptZ2NoV1huR3dKZ0Ry?=
 =?utf-8?B?YVZzSTJzMXdFazhUZHBCTll6M3dZN2V5WmR1ZndNUjRKbFJvcVRmRVBYMnov?=
 =?utf-8?B?RXYwWTlFK2JXc0gyTjFEUlUvaitLT3dUY2xrOStJQmZBbllzRHR3ZmhIZEph?=
 =?utf-8?B?NWdmdEZISWxoUW1ZMmFJU2I3eFUvM29qalJncnUxWXR4OHZsczl6Y2Z6NkpG?=
 =?utf-8?B?alVrTWZTR3V3bmdZbXRtSDFiYys3eUh2UkJieERSellTVlphQVFDbjZ3dzNN?=
 =?utf-8?B?MkRKdmptMU9sYXg2TkJzYW1jTEhYbEM4L2tGWm9BRzhKYWpHYzY1TDJEM1RJ?=
 =?utf-8?B?cWQ4L0R6eGttTjg0WUh5NC8yM2JsUk5ialBMYWlGUzU0RFBqTHFzUEZmQm8w?=
 =?utf-8?B?N1dUY2RXYlRFR2NrRSsxZU9wYjlGVVhqS0FCS1dLUXVONU1SVWVhNjM2ZWlW?=
 =?utf-8?B?cHVOTnJGUjBtOUlRZWJrT2N1YUlwQmtkbDJ0STI5YUwxbU9rWHA2NS9zQ3lS?=
 =?utf-8?B?aFdYU01QZ3JucnRSOERsSkNxRW1MU0ducjVXMHFmZzRJNnZsM2RMWmNHNjBl?=
 =?utf-8?B?QnhuNEl1ZlJjenJiSU1QZTIyZCtqRWVDdnN0YlJQK2tXUURBSkpabVBlQzFk?=
 =?utf-8?B?clBEQ2FKK1l4a3F3N0xFRHd1aVhIRHMyVzk2OU1Hckxab3pjMUM1MmdyOUp0?=
 =?utf-8?B?aVNDK0d1VmZpbG9LSzl1aDJjZWtoNWxqVXZLMWRUZkpSc3JDczE5TXBBQi84?=
 =?utf-8?B?NDByVXFaNjgxcEhMaXlLZlJRbFE5Ym11bXFlYlhCQVB3SjQ5V0Rqc0JRSjZT?=
 =?utf-8?B?MW9GMGFacVorVk5sT2NmK3FzRmhpWmp3TS9OelRoL3ZIcENBTm9TVVA4NTUw?=
 =?utf-8?B?SkFubURvZFVpdDNVUzNZSmp5RDVzZk1LS0RtZ1duekZiU2s0K0Y5bG5nUHA5?=
 =?utf-8?B?UmdVVk4rODVOejVpN09xeEV3T1lXSWZWbDNncWQzdExHSXZ6eGJLOXhNNG1B?=
 =?utf-8?B?YXArbzRKdGZ3clZRc2hsTHhHNFF1UVI2TDVHbkQ4SmlKYW5OMkpJOFlKelhU?=
 =?utf-8?Q?eMOuLKarUSoS4LuX0HDMLCXPXSqVnlf2PBkwnSF?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: df1b5fe4-c78a-46f7-7899-08d97dc6c2e8
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:44:47.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTjZHScgw2n9LMRa0O5yB214LaEjMPmt79/DXxYgCyEUd+aFjtP/JjyijKDVGCrE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6651
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-09-22 13:37, Fabio Estevam wrote:
> Hi Peter,
> 
> On Wed, Sep 22, 2021 at 4:27 AM Peter Rosin <peda@axentia.se> wrote:
> 
>> Basically, the whole point is that you simply don't. The iio-mux exposes
>> the channels as 8 new ADCs, and whenever you read a value from one of
>> them, the iio-mux operates the gpios for you, giving you the impression
>> that you have 8 independet ADCs. They are of course not independent, but...
> 
> Thanks for the clarification. It was helpful.
> 
>> That's exposed to user-space as:
>>
>> $ ls "/sys/bus/iio/devices/iio:device3"
>> in_altvoltage2_compare_interval  in_altvoltage5_scale
>> in_altvoltage2_invert            in_altvoltage6_compare_interval
>> in_altvoltage2_raw               in_altvoltage6_invert
>> in_altvoltage2_scale             in_altvoltage6_raw
>> in_altvoltage3_compare_interval  in_altvoltage6_scale
>> in_altvoltage3_invert            in_altvoltage7_compare_interval
>> in_altvoltage3_raw               in_altvoltage7_invert
>> in_altvoltage3_scale             in_altvoltage7_raw
>> in_altvoltage4_compare_interval  in_altvoltage7_scale
>> in_altvoltage4_invert            name
>> in_altvoltage4_raw               of_node
>> in_altvoltage4_scale             power
>> in_altvoltage5_compare_interval  subsystem
>> in_altvoltage5_invert            uevent
>> in_altvoltage5_raw
>> $ cat "/sys/bus/iio/devices/iio:device3/name"
>> envelope-detector-mux
> 
> Ah, so that's my issue then. I don't see a new device inside
> /sys/bus/iio/devices/.
> 
> I only see the original stmpe ADC:
> 
> ls "/sys/bus/iio/devices/iio:device0"
> dev              in_voltage5_raw  in_voltage_scale  power
> in_temp8_input   in_voltage6_raw  name              subsystem
> in_voltage4_raw  in_voltage7_raw  of_node           uevent
> 
> Maybe my dts is not correct to make the mux appear under
> /sys/bus/iio/devices/iio:device1.
> 
> Here is my dts that shows more context with the STMPE811 ADC:
> https://pastebin.com/raw/7Nn2aAtN
> 
> stmpe811 is an mfd device that can be used as a touchscreen and as a normal adc.
> 
> I only use the adc functionality.
> 
> Any suggestions are welcome.

Don't you get any output from the iio-mux driver during probe? I'd expect
a "failed to get parent channel" or something like that?

I don't know, but looking around a bit makes me think you should
investigate /arch/arm/boot/dts/am5729-beagleboneai.dts and/or
/arch/arm/boot/dts/exynos4412-p4note.dtsi.

I think you need to move the adc: label in the dts to the stmpe_adc child
node, or something like that?

Cheers,
Peter
