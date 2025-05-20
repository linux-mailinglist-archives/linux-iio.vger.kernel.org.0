Return-Path: <linux-iio+bounces-19735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B7ABD794
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 14:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166EA8C0DCC
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277CE27FB0E;
	Tue, 20 May 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qRCkg+3U"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22527E1C5;
	Tue, 20 May 2025 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742466; cv=fail; b=MaTPRaag0Ng51ar3us+Isu9gVjBxHIUsqIugbKkQ9wDxCAeQyoreVR5hkeXVII5WoxfHrIEczMSnbMS5OweT1FPf/cowgxlfNw8GcpGQFczywW2VIel5mmO+YWTnU10C2FHmoZtVVKSFWU2KX7plK8K4JP9vx8Ir6k9sWlkWshE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742466; c=relaxed/simple;
	bh=LSt9BAXy2m0LHLzUdSPkgiuMY/1l/0AvOkcGf9cabzg=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ta4YdIJ9Qt4qHG/qEfAfRb2ciOi3hSSPvX1AzczSwxzJUzaAudVYISlPuOpFQEuFWSx5PT8fhz07R/39AU61OspAMdoRrzA7dvru8hY4KEHH4JTjoTumuYikG4hw5mOZwmC1clkoAhdzdKlG377TbpLpAmno4rXzLJbqqfH3obA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qRCkg+3U; arc=fail smtp.client-ip=40.107.247.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKxR262qwmtbPuSBicGmF4tYoUWFzW06+n+p0nUtdr7Yn8HA/qyaymdE382Mu5xl0is4ifuJQJKoQDDQWS5mbYj66WM6W0+FuvRRaYcqv/AzUgAlK/9H9h5KsvgI+W3A+1V4eTFKssrdQIHLwoa4t6Kpz0OAXDchrCj7H719BXrkvVMlolRcFSsxXuO05COJ/4SKu1KLmp7gbPnC2k8eJ8FnPls/bGHnwBcbapbW6Ujpy5U+NT0gunqez2mkcjXsQM52yc1BqaMuIFGVHE3URzvme+yvzIByJyP8jOI+eC5N11N6sorHSQZ0QIVz+0WBNre/tApA+i77kJK1HONPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfT+jNKWVPQGAJk1JGZlTfMxyxYRrDseCkLF+4XgeGU=;
 b=i5Ip/GGGHzRnXoywGxoK9cTcPujzVvSV11yLn3QHE49+0XWxEL2EetoDYdHdjgQ+WbtiuhB1HXtLvkMHBoYBE3xuBsiZ2vrWJlfNtCN8eLBT/c21lpA9KAF6RmTaF3hnelVbAe/KjVTKhCSeLSt7Fn9Tl3IpSyKgG0FISU9kug4tkYKksYgR8TxNWO411hHI8moGy1Td2vU06tiJB89I3RdQ7gqNcYG5PdIzhzKahKBH5btj2+LVsvjyomNcguqhT6Sfmf0fuoU2gvAzdmJJlJsgMTXRu6jLAPJQjxuUbwpAJZISayk6W6zFGNbKcG+oypzqtNvS25l/+PifFtrERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfT+jNKWVPQGAJk1JGZlTfMxyxYRrDseCkLF+4XgeGU=;
 b=qRCkg+3Um+iaQgYK3GmnZOwwL8KQDVd2fOTKIIzjwMePGxHM2UVxjcqrcUikKTolMqg46H3QuPoCv4rFqWregu0F4Lv3NXbz0Q1SJHnqJTEbCwavZHKZcWpsWZKAAmapnNhMPmBEERadJhd8RRiDgdCYZ8ggENKQETMFPpOMHe4=
Received: from AS4P195CA0037.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::26)
 by DB9PR02MB6683.eurprd02.prod.outlook.com (2603:10a6:10:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Tue, 20 May
 2025 12:01:01 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::f9) by AS4P195CA0037.outlook.office365.com
 (2603:10a6:20b:65a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 20 May 2025 12:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 12:01:00 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 20 May
 2025 14:00:59 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: proximity: Add Nicera D3-323-AA
 PIR sensor
In-Reply-To: <98bd3e50-c379-4229-bdb0-ee4ff491c451@kernel.org> (Krzysztof
	Kozlowski's message of "Tue, 20 May 2025 08:36:21 +0200")
References: <c57675d505e93549bfca5f9909d67822ab304a44.1746802541.git.waqar.hameed@axis.com>
	<02b0dbc2-e8fd-419a-b546-5910b3fd0e0c@kernel.org>
	<pndtt5kiij9.fsf@axis.com>
	<98bd3e50-c379-4229-bdb0-ee4ff491c451@kernel.org>
User-Agent: a.out
Date: Tue, 20 May 2025 14:00:59 +0200
Message-ID: <pndiklvfq4k.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|DB9PR02MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab205e2-05b8-426c-42f1-08dd9795fd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aB7PBeE9E45yiK7JvsTkqVehSqyD11tP/smYimtAX/oTDbRjfuPmObCItMjj?=
 =?us-ascii?Q?iA5YleSKPNLKnb9qZOPLBlh2L7j+iwQXYePHCFEnCaJlP1O4zj6kL0aLkUTr?=
 =?us-ascii?Q?mrH8cNgwtBY1mdt/XAZrfXmWk8HJ9st8KParOPkVhNAMcxrdWpUmRGSJaUjG?=
 =?us-ascii?Q?kG7h4CJ6iXIg8BVOZkhMbPIjJ8qMgC4xkUKW6ezG937H7s/ahScubvhlRCN+?=
 =?us-ascii?Q?yGvTK3YQzCDAS9rpSaYbt5Rz1vpMmR9kN83eYZdQEVXpsKfpq5tHwxciDcSc?=
 =?us-ascii?Q?f3seg6IAjjfvt/cNI6RBzN/k1UuCuCzAPeejmuJ4XnXbZf4DyeJv+dlWKPwv?=
 =?us-ascii?Q?TfpykYFEc8b9xUx4gi93oE+ZpwSu6qLXI+ngYJFluq8KsHAUz1dQRxynqcfg?=
 =?us-ascii?Q?u/g/lOzV0PfuITBE+eLgt8B0ozIlhqIVVeN3dZkmbWKdCHEF+4+NdkrllOP7?=
 =?us-ascii?Q?eYgtEHLc2ZPPDaEs2Mq1+IJJGMsqImaQOHM6RaFkdapS8TfTANz+JMgBuTd+?=
 =?us-ascii?Q?tm0cZGJ3Dibr+kw+YEMAgh2r5DkJrLljxOhMa/7T/Hh09B6Phid/S0xdVt0w?=
 =?us-ascii?Q?XjVeffB9RmTKrqxJjU4AXJANiRpcRwTVo6ITWBHY/N3VtBbio+HR/1AvwSx5?=
 =?us-ascii?Q?Voo/8gwivSuAUhJB7OYroKVIPnLdetzDPd2zVRGhcAf5j+MINh8WcILqdhMU?=
 =?us-ascii?Q?iSNElHMHEgMyVeBq5NnthX27nZsDHxr6CPVAZPSo9Odl5u7eSbwGNNzkl5ae?=
 =?us-ascii?Q?KmZCUaOwJwLdzLc/FynGnQXztrhcjtmstVd0hNn4YLBoyNIvmeguPfQDP1SN?=
 =?us-ascii?Q?kqeoejz0g9amkX0rEqDmlO2EclW/OfAXdeaNvxBmCI1o8S/0lW72xUSorXeH?=
 =?us-ascii?Q?HMZ9XccoaYoJnefZRGTghsARyF/ntSVLPWza0DC98hzZudq763Bh+ZqIma3P?=
 =?us-ascii?Q?S4kKdfh4y252or37WYN0lAYf5pg8A7T/DdE07uZqNiZrUlox3dp5OPs0fJss?=
 =?us-ascii?Q?oMQRKgtA4QKaoiQi8bpOLPPtkMSVJm9ykuDc4UtKfiYH/jZIBxZhx/kZuHCg?=
 =?us-ascii?Q?ICuvXnNNHZOff/1oTqxo2PnKoEOqBjaEzDVhOYPKAR/L+XQbGQqfOVkSCCq8?=
 =?us-ascii?Q?+dt4gPk9Sv6QfR8EynrtuubofEPF7QwHHtm6Krs6HZTTbir8EDNBTPpI+UD0?=
 =?us-ascii?Q?LinomQ+9jq645t+TxP7O5PvmiFJZLfrDnnY3geWeSkTO8r2FeR88u1CxNAZh?=
 =?us-ascii?Q?elY9HZiVxDsLpAXYXusjD55X44O2OOFA1cdUcENqdWNdibBKejthA6Yjk0Us?=
 =?us-ascii?Q?tLH67Tb3p6+U0xTbEuWBTPw3vJgLglETFFY3kzCl+tTeDVEKBJFJthFc7wdN?=
 =?us-ascii?Q?dXQ+3YyyH57qLx1MdPIhpMU0LuERyHWtgSOyiH98JvfnPTlZHDLOOxPsbSx5?=
 =?us-ascii?Q?wnnUU+sLRsbjRO0/05ZBNEBya35Q66TOYgohywOH08POcbes3hlEDx9XgxqY?=
 =?us-ascii?Q?pFowjpPZgoMacT+xr6b1KTwr4ZCQM2j+Ss9Y?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 12:01:00.8607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab205e2-05b8-426c-42f1-08dd9795fd1e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6683

On Tue, May 20, 2025 at 08:36 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 16/05/2025 19:15, Waqar Hameed wrote:
>> On Fri, May 09, 2025 at 17:06 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> 
>>> On 09/05/2025 17:03, Waqar Hameed wrote:
>>>> Nicera D3-323-AA is a PIR sensor for human detection. It has support for
>>>> raw data measurements and detection notification. The communication
>>>> protocol is custom made and therefore needs to be GPIO bit banged.
>>>>
>>>> Add devicetree bindings requiring the compatible string and the various
>>>> GPIOs needed for operation. Some of the GPIOs have multiple use-cases
>>>> depending on device state. Describe these thoroughly.
>>>
>>>
>>> Drop redundant parts of description. Describe the hardware. 
>> 
>> I'll reformulate and incorporate some information of the pins and how it
>> is used in the hardware.
>> 
>>> Entire last paragraph is pretty pointless.
>> 
>> I'll remove it then. (Some sub-system maintainers want a description of
>> what the patch does, in imperative form. But I can see why it might not
>> add any value when it comes to dt-bindings.)
>> 
>>>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: nicera,d3323aa
>>>> +
>>>> +  vdd-gpio:
>>>> +    maxItems: 1
>>>> +    description:
>>>> +      GPIO for supply voltage (1.8 to 5.5 V).
>>>
>>> This is not how pins are represented in the kernel. Either you have here
>>> regulator (supply) or reset gpios. 
>> 
>> I'll change it to `vdd-supply`.
>> 
>>> Plus 'gpio' suffix is not valid, btw.
>> 
>> I actually `grep`ed before writing this to see if there were other
>> dt-bindings with this suffix. Because the GPIO framework supports both
>> `gpio` and `gpios` as suffixes (see `gpio_suffixes[]` in `gpiolib.c`).
>> However, since `-gpios` are clearly in majority, we should go for that.
>
>
> One is deprecated. It is always, always gpios.

Ah, ok! Good to know.

[...]

>>>> +    maxItems: 1
>>>> +    description:
>>>> +      GPIO for clock and detection.
>>>> +      After reset, the device signals with two falling edges on this pin that it
>>>> +      is ready for configuration (within 1.2 s), which the driver listens for as
>>>> +      interrupts.
>>>> +      During configuration, it is used as clock for data reading and writing (on
>>>> +      data-gpio). The driver drives this pin with the frequency of 1 kHz (bit
>>>> +      banging).
>>>> +      After all this, the device is now in operational mode and signals on this
>>>> +      pin for any detections. The driver listens for this as interrupts.
>>>> +
>>>> +  data-gpio:
>>>
>>> There is no such pin.
>> 
>> You mean to change it to `data-gpios`? (There are some using that, e.g.
>> `sensirion,sht15.yaml`).
>
> No, I meant I opened datasheet and found no such pin. Unless you meant
> DO, but then mention in description the actual name of the pin, if you
> are using some more descriptive property name for it.

Got it! Let's do that.

>>>> +    maxItems: 1
>>>> +    description:
>>>> +      GPIO for data reading and writing.
>>>> +      During configuration, configuration data will be written and read back
>>>> +      with bit banging (together with clk-vout-gpio as clock).
>>>> +      After this, during operational mode, the device will output serial data on
>>>> +      this GPIO. However, the driver currently doesn't read this.
>
> BTW, drop all references to driver here and in other places. If driver
> change, you will change binding? If my driver behaves differently, why
> binding would be claiming something else?

Understood, will do that!

