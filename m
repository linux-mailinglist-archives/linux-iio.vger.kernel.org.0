Return-Path: <linux-iio+bounces-19603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C73ABA1C0
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 19:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BAE505598
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CED31FF5EC;
	Fri, 16 May 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rBEQq7WQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6FA31;
	Fri, 16 May 2025 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415734; cv=fail; b=CYQWI84p3mL6dzI1Wv3Q/fqPkZ1onMvwH1mqs4k97MjrHM5Tkb7wGKTy7bgDnlmsbms0mjapuTc+dM9mxOsfJK4IiS8+Hgxv8mMz2b0Pi8hO8sYxHppelIab3CPCek5bwZJxDXhI4iRDLq7cg5VLXnhc+4zdqfK9Aby5L7086i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415734; c=relaxed/simple;
	bh=fJ09g9IykD1Zh61pmhideoy/eYo8+PWkCIWghOC89f0=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cw4gqoEgdnzb9qyk04pZzzaeBGMW9xoihuNb6gtp1mDa6lrKBpQlkDNLmE6H8rEBa4skDNTqSWFqjXy55luIQHCdLhCKI14F1ZuXwbdK/Lz5F3tsJU4PNSWadMGgC9m3LKqWmZg6VXDbyFjeQC74DLpgDNY/LxkoeSLZVZ65jlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rBEQq7WQ; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycWMPxpgu/n2/ZzlrLbPbkIjLEyj4FyhshkQXimmRa7vL/RxfVa8+TtCAPxpb0YcW00kj4urybGQhNT0wFqbn0korBSge3tmqs1GCh2IrLCp+aCbJdmafuueaK4I4CrPbctomGdpsbpv4S7ABTuVde5laOT4rGx25Oi5SpARaR4EGH7niH4yCxiWQxQ1ZYICN4poYmwcKlsZYzLPMuyTaFbeNk/K3u/Yn9ZVyU8iuzApJXtWJmDwAICqnVgIJIeAmX71M+o4M/2WF4pXZVsffIX8OVu0/xQaN6nD/1H4au83QQsAqf9iUapenC4t4nspWhMPIZ5lCE9G3nzCFDqL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKD6H0v/vIaM3f4lZkLX6m3B5AuVOm/qSD63udP0nm8=;
 b=B627o5KaScJqjnkQZfJhPqb2Rcw3HrsSYI0pWQLaUcY0mCLc6c6ICGbZ22pyXHHoj+Mqun9wJ5gXswS5lW/wYbri3L9BQjR1HN60kqNKBmLqWjEm9Qi+ZxCzeDsO9UNlnzcEewQYR9nKMz0zsnfKcKGpFBS3hXE49JKFsYJXVVRldc/3qf+UP+60Y9TLnoxc2ijkxi/CFiIW6zSmE8em2e4oQXLmiFjTcB8OnpHztB6/F6cKt0B7H6MMxcmzsTSNAEGVDADSH4DgUXcCzlJH5P+AX4ctUljpgzM2xcy3xr2300iVMzpYhempAnstR8xhaA2TZvjMKIB96dI6USOcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKD6H0v/vIaM3f4lZkLX6m3B5AuVOm/qSD63udP0nm8=;
 b=rBEQq7WQ7hcocQgp6lqEgnV1DnPJ9yd3rLnvXP9Hjx8RWzumGk1Mh/kbO45hB70kDdOYHKMP9Tm41sTGfxU77W0HMjBGTg8/Aex5+VG6qQSJoSlcsb78c+DmVDyRJP4e7adYT6XdQ0g2hLtgey4DhEqZtgrvDivDFyKutz9+P2s=
Received: from DU7P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::22)
 by VI1PR02MB6239.eurprd02.prod.outlook.com (2603:10a6:800:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.26; Fri, 16 May
 2025 17:15:23 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::fe) by DU7P190CA0005.outlook.office365.com
 (2603:10a6:10:550::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.21 via Frontend Transport; Fri,
 16 May 2025 17:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 17:15:23 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 16 May
 2025 19:15:22 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Krzysztof Koowski <krzk@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: proximity: Add Nicera D3-323-AA
 PIR sensor
In-Reply-To: <02b0dbc2-e8fd-419a-b546-5910b3fd0e0c@kernel.org> (Krzysztof
	Kozlowski's message of "Fri, 9 May 2025 17:06:56 +0200")
References: <c57675d505e93549bfca5f9909d67822ab304a44.1746802541.git.waqar.hameed@axis.com>
	<02b0dbc2-e8fd-419a-b546-5910b3fd0e0c@kernel.org>
User-Agent: a.out
Date: Fri, 16 May 2025 19:15:22 +0200
Message-ID: <pndtt5kiij9.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E4:EE_|VI1PR02MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: e159b666-60e3-4d2a-9053-08dd949d3e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODwOCH+jSJxou1Vxw159uuHOIfKLbBCKHM2il+3aTkLYzWu9gdcGgcVGvX4i?=
 =?us-ascii?Q?YJpBF2i5uDEdPLWdVVi74th1Rl3wGTZjZpzvQf5NxRwJbVjKBdfaS6aaGKkz?=
 =?us-ascii?Q?CRvaZUAtzGRSWnYtS8hDXD8Pct2X4bKGC+ItXgUfSIXq7RU9eSXyX5TfVG+K?=
 =?us-ascii?Q?O/pF8oz9FZoreQc2IzYB3snAQnmUzZf1Eq0GahOFNOwk0dPNsHztF+jiwHJd?=
 =?us-ascii?Q?V0FGbNQ8qe0MYnSALTb74L+L/FaUZdcxXcidi+3C945Rr2PlDedtCZYqwGxJ?=
 =?us-ascii?Q?yTq3ds+e7BksfTXC6sxEaqpzvkZV7mm2RPzRs5L5H0XzdC5Wx+wM/B+E3E5j?=
 =?us-ascii?Q?By+nwXTnkPSCM9nxsjAkh/SZoZ2fSSQryWtCHAJzRpysV5Mi9k0vlnQUrZRp?=
 =?us-ascii?Q?RbEl06L0p/H4dkf+qnaz4quwYuYjJ7BIZkn63QJZ/I13qpaygs1n7VHVEfB4?=
 =?us-ascii?Q?o7JznRXPnpBm2mC/cHs5OYXphcF6aLb+e8V59C3HydDyo2MdugJPMYeuVW+C?=
 =?us-ascii?Q?fc4zXHZaeNvaylwTZPttcrSKNSXjw2vYe3F/vA6Wf1swFnC5DHsPCeVh2zio?=
 =?us-ascii?Q?7tOQlCdL0qccuIZDIWFiBx7hHhetqmARsAheH8+w4hSdOC35gKxePRfxBdQb?=
 =?us-ascii?Q?XCS7BM4vJN5pYv9LDPDOhZl2/Vr83mRPUcPWNuwI8tS4GCIjz+WMOKb1B+0W?=
 =?us-ascii?Q?DTBv35k/xZh+6RZ4yUjaT4n1efNlEC/3/4vEDIV0VPuK1PbXGHWxjbMynfsp?=
 =?us-ascii?Q?IRyTlV6auwefKu0r6PSlJT9nDmCKGkyTvI0ywwWSO9IYknK8nRVtyrn4zslj?=
 =?us-ascii?Q?ZsF/K/+M4MavqdjmJCsqzrpiANb6kZnKz0xuikKxAFXDGrW1Gq3vdI1MD8Ww?=
 =?us-ascii?Q?5HV7dhs2BwU7P9DSIV5Jr5jBICGVZZU/Mjt1pbu6HhRfYU/p2Y8pgOvjoYCq?=
 =?us-ascii?Q?tKrnRwdj/IcBRVr2f4DF5jDIg21ErD81AHOkKdGlsTS3ZIeBd8dudOi5l9qS?=
 =?us-ascii?Q?HIQlSM/mFTS5DV1Jg+1LtcltKO61xc5j+yu8LOgJwwM/cRQyK9ExAwXcK03i?=
 =?us-ascii?Q?mk8uxJTLTdD2xX/n8y/jK/Tjz2XpwQYMkMYH9gGG4qY/r3fbZupU1iQ7IhLz?=
 =?us-ascii?Q?YRB5/p3cQU7wcz8vHIZ5+rNdA75dUj1biJN1roFjJY7PwGyV4hPj5R18gv0S?=
 =?us-ascii?Q?GLbvkXbQu29AEMICjOLqQRCqENyinQmp9nE6xDCnsP98jYH/xxP8aZmDbcbs?=
 =?us-ascii?Q?jI+BMHDboVGlGV0sPE85m1oRL2kOmdLL898SC/f2yoOQOdINch6Lzhwnqg3c?=
 =?us-ascii?Q?xrVJjp/iLHUucxg/hil+Tm2Ph7Sv96DuzOGJZNCPFH7hjxpmgqf9Rlij2nA4?=
 =?us-ascii?Q?lF4AdYeGn+/ErHvbo7MUPBFrNDQGJNGRN2o87sQVOvrGNiBd/Tmu+dQU2FUz?=
 =?us-ascii?Q?7SlJQEJ8mv1eDLtNxGGKbF/++dvqpo08SY9DzFu2BBRuS4IBeK62tmzTrDr/?=
 =?us-ascii?Q?zMZ4iatuU6HQwPvkImGqAMr1W84xxOez4X7D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:15:23.1978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e159b666-60e3-4d2a-9053-08dd949d3e4d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6239

On Fri, May 09, 2025 at 17:06 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 09/05/2025 17:03, Waqar Hameed wrote:
>> Nicera D3-323-AA is a PIR sensor for human detection. It has support for
>> raw data measurements and detection notification. The communication
>> protocol is custom made and therefore needs to be GPIO bit banged.
>> 
>> Add devicetree bindings requiring the compatible string and the various
>> GPIOs needed for operation. Some of the GPIOs have multiple use-cases
>> depending on device state. Describe these thoroughly.
>
>
> Drop redundant parts of description. Describe the hardware. 

I'll reformulate and incorporate some information of the pins and how it
is used in the hardware.

> Entire last paragraph is pretty pointless.

I'll remove it then. (Some sub-system maintainers want a description of
what the patch does, in imperative form. But I can see why it might not
add any value when it comes to dt-bindings.)

>
>> +
>> +properties:
>> +  compatible:
>> +    const: nicera,d3323aa
>> +
>> +  vdd-gpio:
>> +    maxItems: 1
>> +    description:
>> +      GPIO for supply voltage (1.8 to 5.5 V).
>
> This is not how pins are represented in the kernel. Either you have here
> regulator (supply) or reset gpios. 

I'll change it to `vdd-supply`.

> Plus 'gpio' suffix is not valid, btw.

I actually `grep`ed before writing this to see if there were other
dt-bindings with this suffix. Because the GPIO framework supports both
`gpio` and `gpios` as suffixes (see `gpio_suffixes[]` in `gpiolib.c`).
However, since `-gpios` are clearly in majority, we should go for that.

[...]

>> +      This GPIO will be driven low by the driver in order to cut the supply and
>> +      reset the device (driving it then back to high to power it on).
>> +
>> +  clk-vout-gpio:
>
> No, for the similar reasons. Which pin is this?

This pin is a little weird actually. As described below, right after
power on, it is used as an interrupt to signal "ready for
configuration". Then, it used as a bit banged clock signal for
configuration. Finally, it is back as interrupt pin for threshold PIR
sensor detections.

So, I'm not really sure what to call this (just opted for what it's
called in the data sheet: "Vout (CLK)"). Just `clk-gpios` wouldn't be
correct either, right? Should we prefix it with the vendor `nicera,`? Or
any other suggestions?

>
>> +    maxItems: 1
>> +    description:
>> +      GPIO for clock and detection.
>> +      After reset, the device signals with two falling edges on this pin that it
>> +      is ready for configuration (within 1.2 s), which the driver listens for as
>> +      interrupts.
>> +      During configuration, it is used as clock for data reading and writing (on
>> +      data-gpio). The driver drives this pin with the frequency of 1 kHz (bit
>> +      banging).
>> +      After all this, the device is now in operational mode and signals on this
>> +      pin for any detections. The driver listens for this as interrupts.
>> +
>> +  data-gpio:
>
> There is no such pin.

You mean to change it to `data-gpios`? (There are some using that, e.g.
`sensirion,sht15.yaml`).

>
>> +    maxItems: 1
>> +    description:
>> +      GPIO for data reading and writing.
>> +      During configuration, configuration data will be written and read back
>> +      with bit banging (together with clk-vout-gpio as clock).
>> +      After this, during operational mode, the device will output serial data on
>> +      this GPIO. However, the driver currently doesn't read this.
>> +
>> +required:
>> +  - compatible
>> +  - vdd-gpio
>> +  - clk-vout-gpio
>> +  - data-gpio
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>
> So you included that header
>
>> +
>> +    proximity {
>> +        compatible = "nicera,d3323aa";
>> +        vdd-gpio = <&gpio 73 0>;
>> +        clk-vout-gpio = <&gpio 78 0>;
>> +        data-gpio = <&gpio 76 0>;
>
> But where are you using it?

True, I'll add `GPIO_ACTIVE_*` to the properties.

[...]


