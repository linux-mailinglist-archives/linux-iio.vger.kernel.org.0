Return-Path: <linux-iio+bounces-384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892D17F9143
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 05:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD75AB20F0F
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 04:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9517C0;
	Sun, 26 Nov 2023 04:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORG5796793.onmicrosoft.com header.i=@NETORG5796793.onmicrosoft.com header.b="utMIr6Pb"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0DC10D;
	Sat, 25 Nov 2023 20:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZCQChWLuwYxzqLuvmUhgdC8t7HaYcwDEP+nUv2HOPio4OO1absa1dmKjEAlkMbbqCZ+YaO0njSirNxlO5Xsy6WIoSyEazS8EYlW+rEVA61dh9jutFjbJQnmoyoxbYK27vfs+H0afjDAe1vJJ4hgUUj2Xuo6RQwqDrIQbH7YjZlDmsXEo+GJ1YaVqGgEVc2IAb1vdP4Ed+gW6HrVZuWKIl4qAIfi2pzT6FpTGtEIfR9VUZbgoGNgFqx82ieCfjYWclziae8tulzPqYHGxjqsFNCuK4XB3c/ef8Mq/Jo+QPvnKSfGcDDTGdCuXoD4WWKxac3LAwK9SNPBBR36u+W0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTtQW01j3UBOvM1ANiiwJxetPoPGFuGTqaXoelac0No=;
 b=T4ZQ3I7dimNsrPK3yY+OXRsjo89wR1IO8LYT6EoOhayHY7x98TBz4PRR6Sdc6ZIuDufWylTiJeDjxoqBw24bN8FvfczR5Dim3Ev95Ny4Q9dPYLTAF9O7N84Ngjbk7oJ6BUBby+riDDKPKFM6clqqDHfrzkx8L8tA3eiYLdC1tvYXVU6pRpx3qzO2jMHAKzOP8J83T2C+Lx0JWZs1RyuHB7fEqXBLOwYvWAEbbA9UPO0eODA3B81NTDRL7FApQkGA5gdum9SoMj2aNgHDvTm57aB7GP5ns79IulSp+gnR8RF1vqxuh8t+OrW0dHECsYvRVhZMMD0ZodBDKWBacQ47TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTtQW01j3UBOvM1ANiiwJxetPoPGFuGTqaXoelac0No=;
 b=utMIr6PbZYbZ8+lUBxxuYRgB9jQGJDgR2b0c1N6dnvXX6900l0j39fUoILMH7eubRrAkK37LxLG8cdGzH0P/KVmgiocUYJfWJb+9P1hKcyAib6lOgQ/A4VzFnQ9B46/KzWQxklDuciVO0OxEiXCiye55ID7EyGChaiR3MpCDH2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH7PR08MB8229.namprd08.prod.outlook.com
 (2603:10b6:510:12c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sun, 26 Nov
 2023 04:33:59 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::36f2:78d1:ad7d:66da%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 04:33:59 +0000
Date: Sat, 25 Nov 2023 22:33:53 -0600
From: Jeff LaBundy <jeff@labundy.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Sicelo <absicsz@gmail.com>, linux-iio@vger.kernel.org,
	maemo-leste@lists.dyne.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	linux-input@vger.kernel.org
Subject: Re: supporting binary (near-far) proximity sensors over gpio
Message-ID: <ZWLKsVu/v8m9nA0U@nixie71>
References: <ZVevR_ajeB1jfDS9@tp440p.steeds.sam>
 <CAMknhBE5A3w7ntdWC9cFDYSrPQNPoH7sQ5PVXKEy6MAJmZ93SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBE5A3w7ntdWC9cFDYSrPQNPoH7sQ5PVXKEy6MAJmZ93SA@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::22) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH7PR08MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb7b1e9-0ab5-4ada-7c0f-08dbee38e887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kujE0rHHBEP/ebBzWoQln0Cu0bBgMMBsKH01b1252x1Ir1B7Q4QUrGgAAQNpkONTjvKLY1Ikga1laD4gFEtXoAj/dqg2KaWvTBHemTwgM4BXuEkqSCCETROIppqXDuPfK/8iTC/0ICiTW48T/pr3P1olWY77hSykTMfKxXAitQzSBVwudZgnJ1AH79kUU27PEeqCx/mBXeZXFc3izp+Taoc+cpYwYdB1tMoCjwCn4B0bdQZM5/9GpJqlJHYSQpiLNaF8Ip/7jGQct6OOkZBLztAHFXaNQWsiMKypOnQWBYsOZKhinEY5masZtS7JlTGi3ybSQexCYMZU+Q22nZasGRxNgzLmUHIfy3kJZpZ+rQQRyymTk+seOcc+Oc/i8xJI/TAsmFATG47w4vUgPVG35h3WXRaAhpg56UnvZcnqAFAw21sPHT/KYofsWyQImTwG1tNkWdN8FXExSx89b6UyhCx38IFC3+6sm76LfjWwZdMGxw4ifrQ5KSxDY8AfBDwHL3BfnNr0tYhuBQac0yjTGGCa/7fYZdMZFp2XCoMZdh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(376002)(39830400003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(54906003)(6916009)(316002)(66476007)(66946007)(66556008)(8936002)(8676002)(4326008)(478600001)(6486002)(966005)(86362001)(5660300002)(41300700001)(2906002)(38100700002)(6506007)(6666004)(53546011)(9686003)(6512007)(83380400001)(26005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzZUZzRaZVlyZ1FZVzhYZGN4UW5MdERkRVdTREE2NTIyTUZvdmlxdkYySGwz?=
 =?utf-8?B?VHJVRnRZVjdGQXVhdXpMcitscmx5cWNBY2JvZ2pkRWp6ZlFMT2RBU083bkhG?=
 =?utf-8?B?OW1DckRVdUJVbnd4Z1NjV3l0UjJoMDhGRFdnYnczTE1EbUtpZzlKQXoxWkJq?=
 =?utf-8?B?RmtuUVd6YnRPVGYzS051S3N0Yy9HTGhtSXNIdGVLK3puVHBicUc5dWg1VEMr?=
 =?utf-8?B?OEt0dTFTcDYwcHVkdE9Ub2YwTlIzaGc1UnFtUTY4RXgxZHQrYk5PMDRodDg5?=
 =?utf-8?B?R1VhR0UrVEdtZU1aaGZ0QVQ5R05BNDcraUhwRDlRcWV3MkFuOFFMS1drNHNz?=
 =?utf-8?B?dWpVR0FybDNDQWxCL2UrZEdGWGlYUGdFUWhIYWdSdWZyZFlENDd2NGpQRlll?=
 =?utf-8?B?RVBSam53QXNVZ3M2L0NQOEJsQjZKUXoxTWc1cys1SjUyQlV0RFowS21ocXpF?=
 =?utf-8?B?cU42NEl0cVJKWU1GVXdaRFhkVDJYdlJlbmdRZGZnTCtDT1lpbW04Y2dYdWVj?=
 =?utf-8?B?OE9JYkdMcnZtR3VDVk92dHM5SzZtQWZWc24wQ2FqUkdJaEtoNkVTWFZSOTUw?=
 =?utf-8?B?a2xtSHRyeEJkeXlxR1dGODBmWUxJd2c4WkYzVXNidnVzNnN2WFJ2NTQ4dUly?=
 =?utf-8?B?TDlDcXNNM1FaeTRmZHphWXZYdldBclFYMHBUWm8vdUlPRTV3UTgzY2ozWE1B?=
 =?utf-8?B?ZEY1T0U2SWFORUxQMWlCeHVDTFlhR0l6SVlPbWV1Q1RaUzJRVytYaWEyWjMy?=
 =?utf-8?B?TUlBSXNVRHdGcWh2bXlPU3llU0lOMHIwZFAySzRmSGdHOE53Ykd5NVREOTNu?=
 =?utf-8?B?bDJEeG81N2MxdUVId0hwMm9oQzZ0YmNzLzUwek9BYzdFTnNQNXR3eGgrMndG?=
 =?utf-8?B?RVFKMmFzYkNuZmNGOWNvYXZDWWMxcWhSeExVMHJmbExBWFU0WEJOWEMzZkJM?=
 =?utf-8?B?OGNYUjgvZ1ovd2toN1EyTWU5MGRSV3NRVFJwMFJLRDhjTC9Fd0NldWJBOGli?=
 =?utf-8?B?SVRwZkRBSkFBVTYwUHA1Q2drcFVhazdicDB4QStuM2tvRzY2c0hlWUprMXZy?=
 =?utf-8?B?Wllxa0p4WWMzYTBBdUVIZjRsYW5DdndlNEJCRjZjcDNIU0xpR1Q3ZDU3ZnRD?=
 =?utf-8?B?aUYrdFpMS2orTGNVYUxJenlNZHBQU2tGcU1SVGlDdFlvU3ZUTG0wZERleDll?=
 =?utf-8?B?VFZLMVhLTlNJZjdrTUkzd3NiR3VkOU5DbTFMU1NJMklYNnJxcXdHWTJ1aGpJ?=
 =?utf-8?B?R01jT3ZGdlpaYXdzUUVaMi9mT3VCNWpvSTNYU2FzWUV2SDhLN2ZDWStUamtZ?=
 =?utf-8?B?ZXJMZW9TaUxXY2M4RmtoMzMrcVY5c0FFTGNSbnVvbEtkREpod2o2ZnJqblJq?=
 =?utf-8?B?aUJ2VDVFSWpDUmpHTDhHZW45RHVZN2UvZU9TN0ZIeGZlVTBnaHpsMzdxOVdT?=
 =?utf-8?B?MjNJU0JhekdiUDh5M241cmhJeUZqRnZwVmRxc0xCbnVteU1oM3p0L21sV2h2?=
 =?utf-8?B?b3V1TVFZSWxUZVZtRlVVTGhTS1lMSDNOdzJmSlgzWUhpKzhyOFJPbDJUYnMv?=
 =?utf-8?B?R0F2VmoxSGJXRmRqWU9LRS9yc2ZnbVMrVUZKckFhcWRTWVJITTMwVVdZRTJ3?=
 =?utf-8?B?MEkrQVNjZWRmVW9lTkZIajJUbmkyKzUxUDBWWHhETmMzV3pSbWlMVmN6Njkv?=
 =?utf-8?B?enR2WnhiK3EyeG96U1pqVCtXOWEzU01wdVlCMFRXY2xKRnViNDFIQkNYQ0dQ?=
 =?utf-8?B?LzJKU0QrWjE4KzVNbmZieGRNc1NXTGY1SFdoZE03U0h2cFFPbmNQVDNQM3FT?=
 =?utf-8?B?REZIQ3dzNFlZYUhsWVB0eDJLb3FPa1FxQ3B4eisvOWp6V1dMZWFHcEFCQ1dB?=
 =?utf-8?B?MGxuSHp6TlFpcklrbDFCY21tU0U1eHpldkRlV0hpd0tFVjAyNnlqMFk3aDIy?=
 =?utf-8?B?NXg1ZzFGN05iTmZWTmE0L3lXVlY2bVE1RUI5YmMxOUxzaGN0U0dGaDg1a2h5?=
 =?utf-8?B?Tk9JcER1Smx0M1dEWWZaUXJzdTlQeHBmUmRrYk5WNlpZbFdvZG92MVk2UGE4?=
 =?utf-8?B?WEZ4S1FFTVpqVzY0QTFjOU1oRGZOcHNwQWdZcm1mU0N3WFN3VFdwK3ZsUjdx?=
 =?utf-8?Q?Nkr7OMEy+MiF57Vxz92NmqFVg?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb7b1e9-0ab5-4ada-7c0f-08dbee38e887
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 04:33:59.3637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsCnKRubQrQku+CXDjyAPj77d8fbQnGqAfkmP9vd7LNlxXgfOWpOaObnaqABAStoLjY28Oe7atTbWpNOXVK5nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR08MB8229

Hi Sicelo and David,

On Sat, Nov 18, 2023 at 06:09:18PM -0600, David Lechner wrote:
> On Fri, Nov 17, 2023 at 12:22 PM Sicelo <absicsz@gmail.com> wrote:
> >
> > Hi
> >
> > Some phones have 1-bit proximity sensors, which simply toggle a GPIO
> > line to indicate that an object is near or far. Thresholds are set at
> > hardware level. One such sensor is OSRAM SFH 7741 [1], which is used on
> > the Nokia N900.
> >
> > It is currently exported over evdev, emitting the SW_FRONT_PROXIMITY key
> > code [2].
> >
> > So the question is: should a new, general purpose iio-gpio driver be
> > written, that would switch such a proximity sensor to the iio framework?
> > Or evdev is really the best place to support it?
> >
> > There are a couple of people who are willing to write such an iio
> > driver, if iio is the way to go.
> >
> > Regards,
> > Sicelo
> >
> > [1] https://media.digikey.com/pdf/Data%20Sheets/Osram%20PDFs/SFH_7741.pdf
> > [2] https://elixir.bootlin.com/linux/v6.6.1/source/arch/arm/boot/dts/ti/omap/omap3-n900.dts#L111
> >
> Since this is really a proximity switch (it is either on or off)
> rather than measuring a proximity value over a continuous range, it
> doesn't seem like a good fit for the iio subsystem. If the sensor is
> on a phone, then it is likely to detect human presence so the input
> subsystem does seem like the right one for that application.
> 
> More at https://www.kernel.org/doc/html/latest/driver-api/iio/intro.html
> 

I tend to agree; if there are only two discrete states as is the case for a
GPIO, then this is technically a switch and not a sensor. Therefore, input
seems like a better fit; that is just my $.02.

FWIW, a similar discussion came up a few years ago in [1] and again the key
differentiator was whether the output is discrete or continuous.

Kind regards,
Jeff LaBundy

[1] https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com/

