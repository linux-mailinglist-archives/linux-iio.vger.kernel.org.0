Return-Path: <linux-iio+bounces-6526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692C790DA60
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 19:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFF21C2252D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28ED13CF9C;
	Tue, 18 Jun 2024 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kZ/Gq5g5"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2045.outbound.protection.outlook.com [40.92.19.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847CE13B7AF;
	Tue, 18 Jun 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730740; cv=fail; b=mw6c0SeR8TmE/AqKyAcEhJAqFcCwzAg3x/i5JILRsZEr/RtVJNaVCf11bkbJgXo9noSBj/WxBgoeN3IPKhHHK/96TP2w5MfbFDQKeHjGHIj4ElzO6JyEHtvejAPZ5AK3TbrHZHnSxYnvqse5bqLLZUxMOvN9L/aiuTic5BU0BJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730740; c=relaxed/simple;
	bh=Wtuk93NQ9DGgVQD12C9AHVpaYYF99SsPTJh1OP4ZQFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DgfpDUL89uLDHJTilrNkXzZG2WVK8E5p5c6KGN1syKQPIBH8T6Hrk+Jno2yT3ckEc+B21G4Ew1ceXuBxMM+gnk9QTpDQsILZEBvC6rAZuQkDGqy/9RVfM5ktpj4kM09qvRk8mBdEZNf2n76TuM6FzTy7GR6VLdhVBPb/8KLqLLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kZ/Gq5g5; arc=fail smtp.client-ip=40.92.19.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtd85llY+yIRBy/mOTxL8syLP6QiuV1I471/i8LjZ6Ewji7/vbeJNRqm9uO1j9db8Eir2diiIKrZLIapz9HyJzqcwbkIxLtlDUJarTJxLYYMU3MxRc1kmouyvjuVzBTRhdSlhomF8p25pXK0M4/vxQmiP/+YTxPDE+KMixdnmVciMgLNSBb+axo33jaDhWnhTilQ5/Tn0RFRuefYCBf9AR+JGpXEAy1+80aOaUmAnN8Ybz6ZN0lEFnGosrTXIx1V6S/oXH1Zb1CXdHeZK5MqYX6vzIKtG2ABxuTZKbsB8lnRi2tDnfu9nywnc0O4Jb24sBMxtvxo6liKs8tjhOr9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZplItcQ3cfdekLNEea3dtNrdkftIVEJLh5H2J2g0nxE=;
 b=iEnW6YZF5tzadjHbBsxGoAgRrUqE6HyH6Qpf1FWGjzJjTED/luGH0vRowLg2JyiRTpGSr6X03+kBvI+nXhRR6H99C2Vw1I8FHk+yqeUBTKK3OyIpzyn8V9ECWrUZ4kCeuNQGr2v7jy8HjOa0RiAW/VkDqVxU5oE2GGfdt+QR9LIq4YQt6iuA4oiGHzYMBTT0ALxeSayTBHKcfU5vm1Isn6GFxxH8iWncyUh/tkaCXpl+72awtXCThmt8onKTyaNcW/Zu3y6l46vlv2TwJAjoSrR+hk0aidKzTFe9qNHWefDvAtV8/gB8gQfC0ebeYDudxFTyYsEuUVrykh80Fcj4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZplItcQ3cfdekLNEea3dtNrdkftIVEJLh5H2J2g0nxE=;
 b=kZ/Gq5g5OKeJtCSQ+lM8R4R1Hb+HUqAyEdI14drIiJZgahx+1yr0VPkrDgfIQzlld76A5icw5YCifIqjF5n5fLwTAhEyHK0ENqDPJsRS+h1jYVpaEs+4Wyvk/kX/AXsWqlyCxh9PsJgATw+u0wEGU3s7Isp+AP/ENHxsl+wrT2+YXoZuxl883mgtvToKgTk9WiUkDOr68Hs/wqGeJckHsSt4DS9sY4MFR8UqGz7NuhUTyogpjY0H+c/RpyKgC1Y/qNW3KFyXWAxc7/SRzSHMsT8AuzMNA/X6SdKxlXgHmLzJq35W9oKQzcNox6tjgEz14sfnZkaNpH8YbSfHjlzwtg==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 17:12:13 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:12:13 +0000
Message-ID:
 <SN7PR12MB810188621BC91FBA3406048EA4CE2@SN7PR12MB8101.namprd12.prod.outlook.com>
Date: Wed, 19 Jun 2024 01:12:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
References: <20240607114138.390272-1-yasin.lee.x@outlook.com>
 <SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
 <CAHp75VdYYGe7rXJm1z2a=r7ZnSU0-y+3N8juoNF-5xXi5=z5nA@mail.gmail.com>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@outlook.com>
In-Reply-To: <CAHp75VdYYGe7rXJm1z2a=r7ZnSU0-y+3N8juoNF-5xXi5=z5nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [Afo0J5e8HFYn73kKClrFBGLTYU+2TLzNv1m3FVZXiHAsUbrZZTjh6NFaG2NX/5uR]
X-ClientProxiedBy: TYBP286CA0037.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::25) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <29dcfc3e-21d8-446f-95db-8ce376393afa@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 6065e51a-1421-43ab-de88-08dc8fb9cc03
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|440099025|3412199022;
X-Microsoft-Antispam-Message-Info:
	23geQQHnvpkcpJTnEELtvhxYiOzyNWThnLSu8MyR+Vlm9Ze7Zjzya7DU/4QIPjZuW5S2i2IQ/3MOni6lYuX4EtpCPJs4QAyARgfWKakLS3lMAfvZOKSPoZJGRs+r7IgivvNF6I12u91pCqq1+CNefAyoWUuuK9nxTs7IlGUhqERRrCFo/WFb8EHadDbDNgqgawFpEzjXvpQKzn8kaifW0r3O9tXbZVDUmLmmC38QURol17/KYG0B21s/+33cPo/OeKxj0j6Zd67cUjqVQ9YDESEuOea3kK/13ABCsh/cWnSIl7xFNAVODc25vMsdhyhKAtVfhslN+PPPTeB475HXTK7km8EuURazE2U7xJp7H7noCpylQbuQA4Skh7DcJj1qeWm5vVmx2AZ0/hY8A/1df3J6McFBowN9GU7KlPNECc1RQmXM5Z6ZVSlTtV7u9WkPgmsRi78lrw6mFDY2Zqrdc4UM8kWiQv/bIful2lXFqevVBbsnuTACwel/jBk0yMZX+Rn+vG5bE0zlZ8HO3ti3FQOHQhmnKJz4BEIsCN97mvgerYn1gDemP0rginO4uPKR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnZzZzd4R2IvT01EUzYrMXF6dWxEQnZuRzdKaE1ZZmhyY2tPanpuSDlMVlFG?=
 =?utf-8?B?VDZtalFiNE1IL05LSHdPdWdMN3NlMWtVTmRhUFpHajdhNklmTUNxeDNvdy9X?=
 =?utf-8?B?ck9xUzg3eXlIUEE2dEpZc0hKMURFWFA5SUU0WjNjZ1VOLytrSnltbHJKdGxh?=
 =?utf-8?B?enpYbHN3SUE0NllnMjJXZzFOVi8wejJSd29kTm1oNC90RmNrSGFKd0gzZmNB?=
 =?utf-8?B?V1JUalU2QmlQZTQwMVIyWkRSWEZzUzBsOUp5WkI4cWZhUEZRbnZrd2ZudW5N?=
 =?utf-8?B?T1Q0QUswNlJPVzhld2MyRU1SYnJyWWFLRmRqZXpILzFudS9FVzZqZ0FSL0pG?=
 =?utf-8?B?NThDeUQzTkNqM2lEbUppRDBWSXdvdHUwSG85UE1ZdmJYRmg2d2o4dHkxRjMx?=
 =?utf-8?B?anpidnhTWDFYc0taWnF6WXoxanhWOXpvR3pNZXZESS96KzBCWFl2Q0hjZWNu?=
 =?utf-8?B?UjJFUWx5ZFF1RmxVeHRMR1d0TU5kZzBFaEIyV3VGZDdTSVdoQW80YmFMZlM3?=
 =?utf-8?B?UDhINTFVN2tlWnNqcGUwbEtaVUJ0MkFyNjlVQi9xNDYzSHZRWnI0L1JGQWdr?=
 =?utf-8?B?MVRvZ01RVDI4aWZIVWM0dTlPOTFFNjZoSEVMTkdtaFpDdHJhWFRvckdidXFD?=
 =?utf-8?B?dUxDNHVBcFRRK1pnNUlBbngxTkRBY2ZmaGo5ei9zTW1OaUVmZjhnbHpPQ1Jv?=
 =?utf-8?B?STFIMEJwZmc2SE5uTHdUT0llcDBBYUxzdGFCTzUxQ1dkdUIvTk5CU09GbHVQ?=
 =?utf-8?B?TmlPUjNqc2hZU0FDMll0TU9ER25MVE90ZjdMVXdndWVwN2ZJaGFOSWM5UXZQ?=
 =?utf-8?B?Y3ZVb2hIejhyMFlmc2ZaVU1HdENzY3I5WmpHd0JyNEhqaVNmZzdXZDBHMWpS?=
 =?utf-8?B?ZE91VFMzK2NVMnhtTTl4QVA5aDFPd3ZxWkkrUy9KK2ZKWXpnRUhCQ3VDbXN4?=
 =?utf-8?B?SGkyWWxWWDJZc0hDVExiR3J1bXhvZzYvVmE4cy9MaGRqNFpoZldTbDFtQ3U0?=
 =?utf-8?B?aW9yNDRJVnNMVVN2dW43SmhBMm16WmJBUCtSaXFsS2RVQzJXUjE4bUtITVpN?=
 =?utf-8?B?MzZTTUVXQlRpMDBBTDNxSzkxNXY1azJXcllrRllTVGRBNFlZNVJsNHdRbDE3?=
 =?utf-8?B?cGlPdnpxbXNUVWNGOTRQWXhrVEQ0YnJhOGZaM1V5TklNN2cyeGlCK0hTVnJK?=
 =?utf-8?B?dWRBZDlSOUxmbUxzeUZrZjExZWRxdHRSVm5MZFU2cndOcVd2TDdIYjlSNFVI?=
 =?utf-8?B?S3ZMaFB6Mk1aWWg4bkVVRk50TWVTUHNkYkhKVStwTXVURHUxbnlhTEV6WVhr?=
 =?utf-8?B?Sy9BOFJEaXJjMjRlbUxNZzZDRm9EaFZvd3FwNUZQVUZrQWF4cFBKODBnOUhB?=
 =?utf-8?B?YTRyeVpzNEQ2ZU52VHBWczZldkcxL0N5WlVpcGFMZ1UvdlkvNTJZaUJpZmNn?=
 =?utf-8?B?SGxDb2ZidlQ3dGlab1c0YktBSUpaOE9aVGhHWG1MeFdJV1k1aHdjRHAzaXZL?=
 =?utf-8?B?ZmIwY1FtVHlVb3dsOXFSR1B2S3lkK1VwTVkvYm9kTlhhcEtGMkJXaDk0OWM2?=
 =?utf-8?B?aVFVUnB5TGZhanNPMjBDcG1MN2JibktLK3Q5M29xY1BDZVBmRWIyN3BBd2VH?=
 =?utf-8?B?dDQ3TWR4NjkrQS9uS1ZhYW1IU2wyUlVkb25IMlBPTFVGOWU5RXdPUnhPYzAy?=
 =?utf-8?B?ejl5K2M0bmN0NzgrZ0l5QitVNGVSZW50alJNMW5FYXorTytQUXdxd09sa0RN?=
 =?utf-8?Q?7GOKacC4lFGP7vWSoycSSBAnackiuhRLQ1Ci9su?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6065e51a-1421-43ab-de88-08dc8fb9cc03
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 17:12:13.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760

Hi Andy,

Thanks for your guidance. I have already incorporated the modifications 
you mentioned and have replied with the details inline below.

Best regards,

Yasin Lee

在 2024/6/8 03:40, Andy Shevchenko 写道:
> On Fri, Jun 7, 2024 at 2:42 PM Yasin Lee <yasin.lee.x@outlook.com> wrote:
>> From: Yasin Lee <yasin.lee.x@gmail.com>
>>
>> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>>
>> The device has the following entry points:
>>
>> Usual frequency:
>> - sampling_frequency
>>
>> Instant reading of current values for different sensors:
>> - in_proximity0_raw
>> - in_proximity1_raw
>> - in_proximity2_raw
>> - in_proximity3_raw
>> - in_proximity4_raw
>> and associated events in events/
> ...
>
>> +#include <linux/acpi.h>
> Unused.
>
>> +#include <linux/array_size.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/byteorder/generic.h>
> It should be asm/byteorder.h after linux/* (you have already
> unaligned.h there, move this one there)
>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irqreturn.h>
>> +#include <linux/kernel.h>
> Why do you need this?
>
>> +#include <linux/math.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pm.h>
>> +#include <linux/property.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/types.h>
>> +#include <linux/units.h>
>> +
>> +#include <asm/unaligned.h>
>> +
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/types.h>
> Do you really use all of these iio/*?
>
> ...

The modified header file is as follows, and I have checked line by line 
to confirm that all the listed IIO-related header files are necessary:

#include <linux/array_size.h>
#include <linux/bitfield.h>
#include <linux/bitops.h>
#include <linux/delay.h>
#include <linux/device.h>
#include <linux/errno.h>
#include <linux/i2c.h>
#include <linux/interrupt.h>
#include <linux/irqreturn.h>
#include <linux/math.h>
#include <linux/mod_devicetable.h>
#include <linux/module.h>
#include <linux/mutex.h>
#include <linux/pm.h>
#include <linux/property.h>
#include <linux/regmap.h>
#include <linux/regulator/consumer.h>
#include <linux/types.h>
#include <linux/units.h>

#include <asm/byteorder.h>
#include <asm/unaligned.h>

#include <linux/iio/buffer.h>
#include <linux/iio/events.h>
#include <linux/iio/iio.h>
#include <linux/iio/trigger.h>
#include <linux/iio/triggered_buffer.h>
#include <linux/iio/trigger_consumer.h>
#include <linux/iio/types.h>

>> +struct hx9023s_ch_data {
>> +       int raw;
>> +       int lp; /* low pass */
>> +       int bl; /* base line */
>> +       int diff; /* lp-bl */
> Decrypt the comment.
     int raw; /* Raw Data*/
     int lp; /* Low Pass Filter Data*/
     int bl; /* Base Line Data */
     int diff; /* difference of Low Pass Data and Base Line Data */
>> +       struct {
>> +               int near;
>> +               int far;
>> +       } thres;
> Do all of the above have to be signed? Why?
I'll get rid of signed integers and use unsigned integers instead.
>> +       u16 dac;
>> +       u8 cs_position;
>> +       u8 channel_positive;
>> +       u8 channel_negative;
>> +       bool sel_bl;
>> +       bool sel_raw;
>> +       bool sel_diff;
>> +       bool sel_lp;
>> +       bool enable;
>> +};
>> +
>> +struct hx9023s_data {
>> +       struct iio_trigger *trig;
>> +       struct regmap *regmap;
>> +       unsigned long chan_prox_stat;
>> +       unsigned long chan_read;
>> +       unsigned long chan_event;
>> +       unsigned long ch_en_stat;
>> +       unsigned long chan_in_use;
>> +       unsigned int prox_state_reg;
>> +       bool trigger_enabled;
>> +
>> +       struct {
>> +               __be16 channels[HX9023S_CH_NUM];
>> +               s64 ts __aligned(8);
>> +       } buffer;
>> +       struct hx9023s_ch_data ch_data[HX9023S_CH_NUM];
> I would suggest moving this to be the last field. It might help in the
> future if we ever need to convert this to VLA.
Okay, I'll revise it based on your suggestions.
>> ...
>> +
>> +       /* adc avg number and osr number of each channel */
> ADC
> average
> OSR
Fixed
>> ...
>> +
>> +       /* sample & integration frequency of the adc */
> ADC
>
Fixed
>> +       { HX9023S_SAMPLE_NUM_7_0,             0x65 },
>> +       { HX9023S_INTEGRATION_NUM_7_0,        0x65 },
>> +
>> +       /* coefficient of the first order low pass filter during each channel */
>> +       { HX9023S_LP_ALP_1_0_CFG,             0x22 },
>> +       { HX9023S_LP_ALP_3_2_CFG,             0x22 },
>> +       { HX9023S_LP_ALP_4_CFG,               0x02 },
>> +
>> +       /* up coefficient of the first order low pass filter during each channel */
>> +       { HX9023S_UP_ALP_1_0_CFG,             0x88 },
>> +       { HX9023S_UP_ALP_3_2_CFG,             0x88 },
>> +       { HX9023S_DN_UP_ALP_0_4_CFG,          0x18 },
>> +
>> +       /* down coefficient of the first order low pass filter during each channel */
>> +       { HX9023S_DN_ALP_2_1_CFG,             0x11 },
>> +       { HX9023S_DN_ALP_4_3_CFG,             0x11 },
>> +
>> +       /* output data */
> What is this supposed to mean?
Modify to: /* selection of data for the Data Mux Register to output data */
>> +       { HX9023S_RAW_BL_RD_CFG,              0xF0 },
>> +
>> +       /* enable the interrupt function */
>> +       { HX9023S_INTERRUPT_CFG,              0xFF },
>> +       { HX9023S_INTERRUPT_CFG1,             0x3B },
>> +       { HX9023S_DITHER_CFG,                 0x21 },
>> +
>> +       /* threshold of the offset compensation */
>> +       { HX9023S_CALI_DIFF_CFG,              0x07 },
>> +
>> +       /* proximity persistency number(near & far) */
>> +       { HX9023S_PROX_INT_HIGH_CFG,          0x01 },
>> +       { HX9023S_PROX_INT_LOW_CFG,           0x01 },
>> +
>> +       /* disable the data lock */
>> +       { HX9023S_DSP_CONFIG_CTRL1,           0x00 },
>> +};
> ...
>
>> +static const struct regmap_config hx9023s_regmap_config = {
>> +       .reg_bits = 8,
>> +       .val_bits = 8,
>> +       .cache_type = REGCACHE_RBTREE,
> Why not MAPLE?
In my test version of the kernel, MAPLE is not supported. Now, I am 
modifying and submitting it to support MAPLE.
>> +       .wr_table = &hx9023s_wr_regs,
>> +       .volatile_table = &hx9023s_volatile_regs,
>> +};
> ...
>
>> +static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
>> +{
>> +       int ret;
> Unneeded, you may return directly.
Fixed
>
>> +       if (locked)
>> +               ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
>> +                                       HX9023S_DATA_LOCK_MASK, HX9023S_DATA_LOCK_MASK);
>    return regmap_update_bits(...);
>
Fixed
>> +       else
>> +               ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1, GENMASK(4, 3), 0);
>> +
>> +       return ret;
>> +}
> ...
>
>> +static int hx9023s_ch_cfg(struct hx9023s_data *data)
>> +{
>> +       int ret;
>> +       int i;
> Why signed?
>
Modify to: unsigned int , same below.
>> +       u16 reg;
>> +       u8 reg_list[HX9023S_CH_NUM * 2];
>> +       u8 ch_pos[HX9023S_CH_NUM];
>> +       u8 ch_neg[HX9023S_CH_NUM];
>> +
>> +       data->ch_data[0].cs_position = 0;
>> +       data->ch_data[1].cs_position = 2;
>> +       data->ch_data[2].cs_position = 4;
>> +       data->ch_data[3].cs_position = 6;
>> +       data->ch_data[4].cs_position = 8;
>> +
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +               if (data->ch_data[i].channel_positive == 255)
> Magic number! Should it be GENMASK()? U8_MAX? Something else semantically?
Replace with  #define HX9023S_NOT_CONNECTED  to indicate an unconnected 
channel.
>> +                       ch_pos[i] = 16;
>> +               else
>> +                       ch_pos[i] = data->ch_data[data->ch_data[i].channel_positive].cs_position;
>> +               if (data->ch_data[i].channel_negative == 255)
> Ditto!
>
>> +                       ch_neg[i] = 16;
>> +               else
>> +                       ch_neg[i] = data->ch_data[data->ch_data[i].channel_negative].cs_position;
>> +       }
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +               reg = (u16)((0x03 << ch_pos[i]) | (0x02 << ch_neg[i]));
> Why casting? What are those magic numbers?
>
Delete the casting & Replace the magic number with:

#define HX9023S_POS 0x03
#define HX9023S_NEG 0x02

>> +               reg_list[i * 2] = (u8)(reg);
>> +               reg_list[i * 2 + 1] = (u8)(reg >> 8);
> put_unaligned_le16()
>
Fixed.
>> +       }
>> +       ret = regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
>> +
>> +       return ret;
> Return directly.
Fixed.
>> +}
>> +
>> +static int hx9023s_reg_init(struct hx9023s_data *data)
>> +{
>> +       int i = 0;
> Why signed? What is that assignment for?
>
>> +       int ret;
>> +
>> +       for (i = 0; i < (int)ARRAY_SIZE(hx9023s_reg_init_list); i++) {
>> +               ret = regmap_bulk_write(data->regmap, hx9023s_reg_init_list[i].addr,
>> +                                       &hx9023s_reg_init_list[i].val, 1);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
> ...
>
>> +static int hx9023s_write_far_debounce(struct hx9023s_data *data, int val)
>> +{
>> +       int ret;
>> +
>> +       if (val > 0xF)
>> +               val = 0xF;
> What is this magic?
> Shouldn't you use clamp()?
>
...
>> +       guard(mutex)(&data->mutex);
>> +       ret = regmap_update_bits(data->regmap, HX9023S_PROX_INT_LOW_CFG,
>> +                               HX9023S_PROX_DEBOUNCE_MASK, val);
>> +
>> +       return ret;
> Return directly. Really you may reduce your code base by ~50 LoCs just
>   by dropping unneeded ret and this kind of code.
>
>> +}
Fixed:

static int hx9023s_write_far_debounce(struct hx9023s_data *data, int val)

{
     guard(mutex)(&data->mutex);
     return regmap_update_bits(data->regmap, HX9023S_PROX_INT_LOW_CFG,
                 HX9023S_PROX_DEBOUNCE_MASK,
                 FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val));
}
> ...
>
>> +static int hx9023s_write_near_debounce(struct hx9023s_data *data, int val)
>> +{
> As per above function.
>
>> +}
> ...
>
>> +static int hx9023s_get_thres_near(struct hx9023s_data *data, u8 ch, int *val)
>> +{
>> +       int ret;
>> +       u8 buf[2];
>> +
>> +       if (ch == 4)
> Instead, make a temporary variable for the reg and use only a single
> call to regmap_bulk_read().
>
Fixed
>> +               ret = regmap_bulk_read(data->regmap, HX9023S_PROX_HIGH_DIFF_CFG_CH4_0, buf, 2);
> sizeof(buf)
>
>> +       else
>> +               ret = regmap_bulk_read(data->regmap,
>> +                               HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES), buf, 2);
> Ditto.
>
>> +
> Redundant blank line.
>
>> +       if (ret)
>> +               return ret;
>> +       *val = get_unaligned_le16(buf);
>> +       *val = (*val & GENMASK(9, 0)) * 32;
>> +       data->ch_data[ch].thres.near = *val;
> Better to have a temporary variable and do something like
>
>    unsigned int tmp;
>
>    tmp = (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
>    near = tmp;
>    *val = tmp;
>
> See the difference?
>
>> +       return IIO_VAL_INT;
>> +}
> ...
>
>> +static int hx9023s_get_thres_far(struct hx9023s_data *data, u8 ch, int *val)
>> +{
> As per above.
>
>> +}
> ...
>
>> +static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int val)
>> +{
> As per above.
>
>> +}
>> +
>> +static int hx9023s_set_thres_far(struct hx9023s_data *data, u8 ch, int val)
>> +{
> As per above.
>
Fixed all of them.
>> +}
> ...
>
>> +static void hx9023s_get_prox_state(struct hx9023s_data *data)
>> +{
>> +       int ret;
> Are the 4 LoCs just for fun? Or why does the function return void?
>
>> +       ret = regmap_read(data->regmap, HX9023S_PROX_STATUS, &data->prox_state_reg);
>> +       if (ret)
>> +               return;
>> +}
static int hx9023s_get_prox_state(struct hx9023s_data *data)
{
     return regmap_read(data->regmap, HX9023S_PROX_STATUS, 
&data->prox_state_reg);
}

> ...
>
>> +static void hx9023s_data_select(struct hx9023s_data *data)
> Why void?
>
>> +{
>> +       int ret;
>> +       int i;
> Why signed?
>
>> +       unsigned long buf[1];
> Why an array?
>
>> +       ret = regmap_read(data->regmap, HX9023S_RAW_BL_RD_CFG, (unsigned int *)buf);
> No. Why do you need this ugly casting?
>
>> +       if (ret)
>> +               return;
>> +
>> +       for (i = 0; i < 4; i++) {
>> +               data->ch_data[i].sel_diff = test_bit(i, buf);
>> +               data->ch_data[i].sel_lp = !data->ch_data[i].sel_diff;
>> +               data->ch_data[i].sel_bl = test_bit(i + 4, buf);
>> +               data->ch_data[i].sel_raw = !data->ch_data[i].sel_bl;
>> +       }
>> +
>> +       ret = regmap_read(data->regmap, HX9023S_INTERRUPT_CFG1, (unsigned int *)buf);
>> +       if (ret)
>> +               return;
>> +
>> +       data->ch_data[4].sel_diff = test_bit(2, buf);
>> +       data->ch_data[4].sel_lp = !data->ch_data[4].sel_diff;
>> +       data->ch_data[4].sel_bl = test_bit(3, buf);
>> +       data->ch_data[4].sel_raw = !data->ch_data[4].sel_bl;
>> +}

Modified as below:

static int hx9023s_data_select(struct hx9023s_data *data)

{
     int ret;
     unsigned int i, buf;
     unsigned long tmp;

     ret = regmap_read(data->regmap, HX9023S_RAW_BL_RD_CFG, &buf);
     if (ret)
         return ret;

     tmp = buf;
     for (i = 0; i < 4; i++) {
         data->ch_data[i].sel_diff = test_bit(i, &tmp);
         data->ch_data[i].sel_lp = !data->ch_data[i].sel_diff;
         data->ch_data[i].sel_bl = test_bit(i + 4, &tmp);
         data->ch_data[i].sel_raw = !data->ch_data[i].sel_bl;
     }

     ret = regmap_read(data->regmap, HX9023S_INTERRUPT_CFG1, &buf);
     if (ret)
         return ret;

     tmp = buf;
     data->ch_data[4].sel_diff = test_bit(2, &tmp);
     data->ch_data[4].sel_lp = !data->ch_data[4].sel_diff;
     data->ch_data[4].sel_bl = test_bit(3, &tmp);
     data->ch_data[4].sel_raw = !data->ch_data[4].sel_bl;

     return 0;
}
> ...
>
>> +static int hx9023s_sample(struct hx9023s_data *data)
>> +{
>> +       int ret;
>> +       int i;
> Why signed?
>
>> +       u8 data_size;
>> +       u8 offset_data_size;
>> +       int value;
>> +       u8 rx_buf[HX9023S_CH_NUM * HX9023S_BYTES_MAX];
>> +
>> +       hx9023s_data_lock(data, true);
>> +       hx9023s_data_select(data);
>> +
>> +       data_size = HX9023S_3BYTES;
>> +
>> +       /* ch0~ch3 */
>> +       ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, rx_buf,
>> +                               (HX9023S_CH_NUM * data_size) - data_size);
> Make a temporary variable and use  (CH_NUM - 1) * data_size which is
> shorter and clearer.
>
Fixed
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* ch4 */
>> +       ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0,
>> +                               rx_buf + ((HX9023S_CH_NUM * data_size) - data_size), data_size);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +               value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
>> +               value = sign_extend32(value, 15);
>> +               data->ch_data[i].raw = 0;
>> +               data->ch_data[i].bl = 0;
>> +               if (data->ch_data[i].sel_raw == true)
>> +                       data->ch_data[i].raw = value;
>> +               if (data->ch_data[i].sel_bl == true)
>> +                       data->ch_data[i].bl = value;
>> +       }
>> +
>> +       /* ch0~ch3 */
>> +       ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, rx_buf,
>> +                               (HX9023S_CH_NUM * data_size) - data_size);
> Use a temporary constant.
Fixed, same below
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* ch4 */
>> +       ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0,
>> +                               rx_buf + ((HX9023S_CH_NUM * data_size) - data_size), data_size);
> Ditto.
>
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +               value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
>> +               value = sign_extend32(value, 15);
>> +               data->ch_data[i].lp = 0;
>> +               data->ch_data[i].diff = 0;
>> +               if (data->ch_data[i].sel_lp == true)
>> +                       data->ch_data[i].lp = value;
>> +               if (data->ch_data[i].sel_diff == true)
>> +                       data->ch_data[i].diff = value;
>> +       }
>> +
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +               if (data->ch_data[i].sel_lp == true && data->ch_data[i].sel_bl == true)
>> +                       data->ch_data[i].diff = data->ch_data[i].lp - data->ch_data[i].bl;
>> +       }
>> +
>> +       /* offset dac */
>> +       offset_data_size = HX9023S_2BYTES;
>> +       ret = regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, rx_buf,
>> +                               (HX9023S_CH_NUM * offset_data_size));
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +               value = get_unaligned_le16(&rx_buf[i * offset_data_size]);
>> +               value = FIELD_GET(GENMASK(11, 0), value);
>> +               data->ch_data[i].dac = value;
>> +       }
>> +
>> +       hx9023s_data_lock(data, false);
>> +
>> +       return 0;
>> +}
>> +static int hx9023s_ch_en(struct hx9023s_data *data, u8 ch_id, bool en)
>> +{
>> +       int ret;
>> +       unsigned int buf;
>> +
>> +       ret = regmap_read(data->regmap, HX9023S_CH_NUM_CFG, &buf);
>> +       if (ret)
>> +               return ret;
>> +
>> +       data->ch_en_stat = buf;
>> +
>> +       if (en) {
>> +               if (data->ch_en_stat == 0)
>> +                       data->prox_state_reg = 0;
>> +               set_bit(ch_id, &data->ch_en_stat);
> Why atomit?
>
>> +               ret = regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CFG, &data->ch_en_stat, 1);
>> +               if (ret)
>> +                       return ret;
>> +               data->ch_data[ch_id].enable = true;
>> +       } else {
>> +               clear_bit(ch_id, &data->ch_en_stat);
>> +               ret = regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CFG, &data->ch_en_stat, 1);
>> +               if (ret)
>> +                       return ret;
>> +               data->ch_data[ch_id].enable = false;
>> +       }
> This can be compressed to
>
>    if (en && ch_en_stat == 0)
>      prox_state_reg = 0;
>    __assign_bit(en); // or atomic, but the latter has to be justified
>    enable = !!en;
>    ret = regmap_bulk_write();
>    if (ret)
>      return ret;
>
>> +       return 0;
>> +}

Modified as below:

static int hx9023s_ch_en(struct hx9023s_data *data, u8 ch_id, bool en)
{
     int ret;
     unsigned int buf;

     ret = regmap_read(data->regmap, HX9023S_CH_NUM_CFG, &buf);
     if (ret)
         return ret;

     data->ch_en_stat = buf;
     if (en && data->ch_en_stat == 0)
         data->prox_state_reg = 0;

     data->ch_data[ch_id].enable = en;
     __assign_bit(ch_id, &data->ch_en_stat, en);

     return regmap_write(data->regmap, HX9023S_CH_NUM_CFG, 
data->ch_en_stat);
}


>> +
>> +static int hx9023s_property_get(struct hx9023s_data *data)
>> +{
>> +       int ret, i;
> Why is the 'i' signed?
>
>> +       u32 temp;
>> +       struct fwnode_handle *child;
>> +       struct device *dev = regmap_get_device(data->regmap);
>> +
>> +       ret = device_property_read_u32(dev, "channel-in-use", &temp);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "Failed to read channel-in-use property\n");
>> +       data->chan_in_use = temp;
> Did you even compile your code? The below uses uninitialised value.

Fixed.

It might be an issue with my local environment; the uninitialized 
problem was not detected during compilation.

>> +       device_for_each_child_node(dev, child) {
> You have massive leaks in this loop, you need to use _scoped() variant.
Add fwnode_handle_put(child); before return err;
>> +               ret = fwnode_property_read_u32(child, "channel-positive", &temp);
>> +               if (ret)
>> +                       return dev_err_probe(dev, ret,
>> +                                       "Failed to read channel-positive for channel %d\n", i);
>> +               data->ch_data[i].channel_positive = temp;
>> +
>> +               ret = fwnode_property_read_u32(child, "channel-negative", &temp);
>> +               if (ret)
>> +                       return dev_err_probe(dev, ret,
>> +                                       "Failed to read channel-negative for channel %d\n", i);
>> +               data->ch_data[i].channel_negative = temp;
>> +
>> +               i++;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int hx9023s_update_chan_en(struct hx9023s_data *data,
>> +                               unsigned long chan_read,
>> +                               unsigned long chan_event)
>> +{
>> +       int i;
> Why signed?
>
>> +       unsigned long channels = chan_read | chan_event;
>> +
>> +       if ((data->chan_read | data->chan_event) != channels) {
>> +               for_each_set_bit(i, &channels, HX9023S_CH_NUM)
>> +                       hx9023s_ch_en(data, i, test_bit(i, &data->chan_in_use));
>> +               for_each_clear_bit(i, &channels, HX9023S_CH_NUM)
>> +                       hx9023s_ch_en(data, i, false);
>> +       }
>> +
>> +       data->chan_read = chan_read;
>> +       data->chan_event = chan_event;
>> +
>> +       return 0;
>> +}
> ...
>
>> +static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, int *val2)
>> +{
>> +       int ret;
>> +       unsigned int odr;
>> +       unsigned int buf;
>> +
>> +       ret = regmap_read(data->regmap, HX9023S_PRF_CFG, &buf);
>> +       if (ret)
>> +               return ret;
>> +
>> +       odr = hx9023s_samp_freq_table[buf];
>> +       *val = 1000 / odr;
> KILO? MILLI?
>
>> +       *val2 = div_u64((1000 % odr) * 1000000ULL, odr);
> MILLI / MICRO ?

add comment.

     *val = 1000 / odr; /* odr in Hz */
     *val2 = div_u64((1000 % odr) * 1000000ULL, odr); /* odr in micro Hz */

>> +       return IIO_VAL_INT_PLUS_MICRO;
>> +}
> ...
>
>> +static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
>> +{
>> +       int i;
> Why signed?
>
>> +       int ret;
>> +       int period_ms;
> Why signed?
>
>> +       struct device *dev = regmap_get_device(data->regmap);
>> +
>> +       period_ms = div_u64(1000000000ULL, (val * 1000000ULL + val2));
> Use units.h
OK.
>> +       for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
>> +               if (period_ms == hx9023s_samp_freq_table[i])
>> +                       break;
>> +       }
>> +       if (i == ARRAY_SIZE(hx9023s_samp_freq_table)) {
>> +               dev_err(dev, "Period:%dms NOT found!\n", period_ms);
>> +               return -EINVAL;
>> +       }
>> +       ret = regmap_bulk_write(data->regmap, HX9023S_PRF_CFG, &i, 1);
>> +
>> +       return ret;
> Argh...
>
Fixed all of these.
>> +}
> ...
>
>> +static void hx9023s_push_events(struct iio_dev *indio_dev)
>> +{
>> +       struct hx9023s_data *data = iio_priv(indio_dev);
>> +       s64 timestamp = iio_get_time_ns(indio_dev);
>> +       unsigned long prox_changed;
>> +       unsigned int chan;
>> +
>> +       hx9023s_sample(data);
>> +       hx9023s_get_prox_state(data);
>> +
>> +       prox_changed = (data->chan_prox_stat ^ data->prox_state_reg) & data->chan_event;
>> +
> Unneeded blank line.
>
>> +       for_each_set_bit(chan, &prox_changed, HX9023S_CH_NUM) {
>> +               int dir;
> Why signed?
>
>> +               dir = (data->prox_state_reg & BIT(chan)) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
>> +
>> +               iio_push_event(indio_dev,
>> +                       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan, IIO_EV_TYPE_THRESH, dir),
>> +                       timestamp);
>> +       }
>> +       data->chan_prox_stat = data->prox_state_reg;
>> +}
> ...
>
>> +static int hx9023s_write_event_config(struct iio_dev *indio_dev,
>> +                               const struct iio_chan_spec *chan,
>> +                               enum iio_event_type type,
>> +                               enum iio_event_direction dir,
>> +                               int state)
>> +{
>> +       struct hx9023s_data *data = iio_priv(indio_dev);
>> +
>> +       if (test_bit(chan->channel, &data->chan_in_use)) {
>> +               hx9023s_ch_en(data, chan->channel, !!state);
>> +               if (data->ch_data[chan->channel].enable)
>> +                       set_bit(chan->channel, &data->chan_event);
>> +               else
>> +                       clear_bit(chan->channel, &data->chan_event);
> Why atomic?
>
> __assign_bit()
Fixed
>> +       }
>> +
>> +       return 0;
>> +}
> ...
>
>> +static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
>> +{
>> +       struct iio_poll_func *pf = private;
>> +       struct iio_dev *indio_dev = pf->indio_dev;
>> +       struct hx9023s_data *data = iio_priv(indio_dev);
>> +       int bit;
>> +       int i;
> Why are both signed?
>
>> +       guard(mutex)(&data->mutex);
>> +       hx9023s_sample(data);
>> +       hx9023s_get_prox_state(data);
>> +
>> +       for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
>> +               data->buffer.channels[i++] =
>> +                       cpu_to_be16(data->ch_data[indio_dev->channels[bit].channel].diff);
>> +
>> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
>> +
>> +       iio_trigger_notify_done(indio_dev->trig);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static int hx9023s_buffer_preenable(struct iio_dev *indio_dev)
>> +{
>> +       struct hx9023s_data *data = iio_priv(indio_dev);
>> +       unsigned long channels;
>> +       int bit;
> Why signed?
>
>> +       guard(mutex)(&data->mutex);
>> +       for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
>> +               __set_bit(indio_dev->channels[bit].channel, &channels);
>> +
>> +       hx9023s_update_chan_en(data, channels, data->chan_event);
>> +
>> +       return 0;
>> +}
> ...
>
>> +static int hx9023s_probe(struct i2c_client *client)
>> +{
>> +       int ret;
>> +       unsigned int id;
>> +       struct device *dev = &client->dev;
>> +       struct iio_dev *indio_dev;
>> +       struct hx9023s_data *data;
>> +
>> +       indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
>> +       if (!indio_dev)
>> +               return dev_err_probe(dev, -ENOMEM, "device alloc failed\n");
> We don't issue a message for -ENOMEM.
Fixed
>> +       data = iio_priv(indio_dev);
>> +       mutex_init(&data->mutex);
>> +
>> +       data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
>> +       if (IS_ERR(data->regmap))
>> +               return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
>> +
>> +       ret = hx9023s_property_get(data);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "dts phase failed\n");
>> +
>> +       ret = devm_regulator_get_enable(dev, "vdd");
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "regulator get failed\n");
>> +       fsleep(1000);
>> +       ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "id check failed\n");
>> +
>> +       indio_dev->channels = hx9023s_channels;
>> +       indio_dev->num_channels = ARRAY_SIZE(hx9023s_channels);
>> +       indio_dev->info = &hx9023s_info;
>> +       indio_dev->modes = INDIO_DIRECT_MODE;
>> +       indio_dev->name = "hx9023s";
>> +       i2c_set_clientdata(client, indio_dev);
>> +
>> +       ret = hx9023s_reg_init(data);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "device init failed\n");
>> +
>> +       ret = hx9023s_ch_cfg(data);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "channel config failed\n");
>> +
>> +       ret = regcache_sync(data->regmap);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "regcache sync failed\n");
>> +
>> +       if (client->irq) {
>> +               ret = devm_request_threaded_irq(dev, client->irq, hx9023s_irq_handler,
>> +                                               hx9023s_irq_thread_handler, IRQF_ONESHOT,
>> +                                               "hx9023s_event", indio_dev);
>> +               if (ret)
>> +                       return dev_err_probe(dev, ret, "irq request failed\n");
>> +
>> +               data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
>> +                                               iio_device_id(indio_dev));
>> +               if (!data->trig)
>> +                       return dev_err_probe(dev, -ENOMEM,
>> +                                       "iio trigger alloc failed\n");
>> +
>> +               data->trig->ops = &hx9023s_trigger_ops;
>> +               iio_trigger_set_drvdata(data->trig, indio_dev);
>> +
>> +               ret = devm_iio_trigger_register(dev, data->trig);
>> +               if (ret)
>> +                       return dev_err_probe(dev, ret,
>> +                                       "iio trigger register failed\n");
>> +       }
>> +
>> +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollfunc_store_time,
>> +                                       hx9023s_trigger_handler, &hx9023s_buffer_setup_ops);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret,
>> +                               "iio triggered buffer setup failed\n");
>> +
>> +       ret = devm_iio_device_register(dev, indio_dev);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "iio device register failed\n");
>> +
>> +       return 0;
>> +}
> ...
>
>> +static const struct acpi_device_id hx9023s_acpi_match[] = {
>> +       { "TYHX9023" },
>> +       {}
>> +};
> Btw, do you have a reference to any device on the market that has this ID?
Drop the acpi match

