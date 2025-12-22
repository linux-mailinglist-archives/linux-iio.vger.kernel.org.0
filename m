Return-Path: <linux-iio+bounces-27308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43401CD52EB
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 09:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2D91300DFCD
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45A21322F;
	Mon, 22 Dec 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="JkQBbLn9"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010063.outbound.protection.outlook.com [52.101.84.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53119755B
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393576; cv=fail; b=Ttobxr0t+4lo9TS0su4luTL+LkYxHufCvfHdIU2DIlqnTO1bFLTFMa3y2J+8m2FZ6yoKi6zwBCji6MvW4Vphtdr5v4wG2GVTUdUPppuGtcwBAucySufce663z0URjKXJrs3i6W7Wkxg9x3op4N0uDTy+sKRt32lRtBZU29tqamI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393576; c=relaxed/simple;
	bh=+/k7a5DBjTOBT3QYvaCA4AGjV34Zkq4dv4lf310ZgFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=abLej2xZHOGSuZTubXQXs5NBI1cK1BGZcWrYWmTPdeZ13kuCqhnsveK6hy77vBotEHNMFDm05m54pajhf++8wXTnAZ4gzA1dz4J6mj18QiZCVeZCoUAhfIJUSBXPCJXbYipJ9Lsqk43Wa0aEckXivFr3W066d/uKShCGfWCX5WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=JkQBbLn9; arc=fail smtp.client-ip=52.101.84.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4v1Qw/aacsza90/Xb53F4JxS6gyFEMFWq8H5qhywNKuPLYusMrtWEqN3SLy6xyES5vTj46lhjeF/yvEd0T8ZK0Y1hv1t2RJSlKaVn1KF2I+NM9wa1k7YWROOiG8fh1gY/X+66ETIsPrBcoi5HnTg5OnAnjfpUi5g4JrOsJxocjK1IGDCJklGRAoPd2y70I9h82Nfn3CpnoC/jyuxMqPtCMZbBR1QNrWcHJWkm4u4xDeJGvwRE9CIjclHbXa/CyTOYtNgghJjpOJjYs0c82ujEHBP4NoaD1ozQMpnG5W6i60WRIJgFwdMp1U8eha3IIayuzrNiXEUNRlk7HdHYV6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd6tCftnK4MfvRGmPVvWHcXpmNFuMDHDEGzyErHSR7M=;
 b=WDdgQu3FXCQFO92GSi8CBm4DH/oEZivMcHM5kchzMcqpfKk3brKK/xNDpCHjwg6H6zXMOVzRnlNGY0lBZXIJgktWT0355kVuoFS1mtvpEwOnFWVCiuxJXAcGqnvUTcXHVF/fS+sPe8qsChuEN0kSyrlhSSw8VOgn71wKa4L8OYFoNelEs8Gm4sn/zxSvolZAn/ReH9E3YBNCnPZQ24bdD8mEOqz/77Q/m5caLGuqIuatEnIfqggAJD91gMm3CGw8s0maGoc2rb1Tkg7zw2TQpZWWtYTiOaD0iBY+I1JYi0toRMIIXE+db58N+a5P/Smi2b3w6LQ1QNTIja5qiUV0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd6tCftnK4MfvRGmPVvWHcXpmNFuMDHDEGzyErHSR7M=;
 b=JkQBbLn9Md+npg+sGk1ecPTyFygQpFU+hZ2iLRcUFcRCYM412GOY0dL454nunsWflAyPnZL2G+3oAXFx3a8kqMXFcV7tgj9CavRPNTF0oMetUJyAmicjctJiaZp5tPpy8VZCif3ITgmzWFqLgg+3maXlrUkqyNGeT3fQwq/A0ow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI0PR10MB9169.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:52:44 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 08:52:44 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Rosin <peda@axentia.se>,  linux-iio@vger.kernel.org,  Guenter
 Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] iio: core: add separate lockdep class for info_exist_lock
In-Reply-To: <20251221190645.5d5d1b32@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 21 Dec 2025 19:06:45 +0000")
References: <20251215131723.4130826-1-ravi@prevas.dk>
	<78de7c11-5724-c3ba-4a32-0dd0f8b4d74f@axentia.se>
	<20251221190645.5d5d1b32@jic23-huawei>
Date: Mon, 22 Dec 2025 09:52:42 +0100
Message-ID: <875x9yucdh.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0070.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::29) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI0PR10MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ff97c0-0ded-43cb-9e24-08de41377932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pOEh7b8XC1u8fAD76LOB3o3GKa2/YKO+Tteks4QYePyOCWvKzwW6MeYqAx2y?=
 =?us-ascii?Q?FJvs07ioe2tLIZAFZmRNSv/JGzlj0KZo+fohX99jQ2/GgTPy62qSCH9kFfx9?=
 =?us-ascii?Q?lr+EDqU6MTRQDEb5uQPecSOmONR8BCWO2CpQQrbmOZKJAPKuvWI36SzI7204?=
 =?us-ascii?Q?jvZ4WZo66c3JiCEVYQX7/TWBye6hYePva9tgOTUKpKR9u9P/ZcolCvWoLcQj?=
 =?us-ascii?Q?V18SznjIhT7XkNWCVovnZnxMjLt4MR64Cv9JqGBbXDmDADAsqKKhIrRooNdp?=
 =?us-ascii?Q?kKfb0e/AtXpIpKpInIC0fMUNlbXUNznplaaDYADa6ZtIETG4HFDdAD9zdgCY?=
 =?us-ascii?Q?xJxn8WM07ZjCEP1l3vcX4CfmhpP0KAgOA1dmbEDXUp8lJhn2xOMJFghjXzhX?=
 =?us-ascii?Q?hiQMrNcncO+AgWGfGLGcnFVB5xNlHcQO+NLc+H7uqrA3lq6DhG0x3Auinc1J?=
 =?us-ascii?Q?y9SlVGd6uIRkt2AnmPUNDWrsSgtM5lNLQ/mRw/SeAzQrt5R0+CNWN2jvJkUU?=
 =?us-ascii?Q?IJiKexQ9zBnvjuaYbZrBHODynAw7OsdybdguxPBf3n/CDN3No3vYLpMuhj85?=
 =?us-ascii?Q?6g5nspZAb3JImR+K9vcb+Td2GpdQnUi8UbxI5K4zE1XaEbef9VtS9um3tJls?=
 =?us-ascii?Q?xMKszL7fZQnLVW/wqWPJK/Qw6NT0i3zs7sC/wtSeAk/NZ+9SAr67NanBrWnI?=
 =?us-ascii?Q?4D2psFgtml6LPd7a0Asel8qax41+ppdPknATgXqyBjaDk86V9PSVwqw0iD+4?=
 =?us-ascii?Q?NOxybWzxsDlGyMMephCuvQlG2nflBH0FzKPTJulrV/vyaw2KJr3xpftnEpP7?=
 =?us-ascii?Q?ALhYvw/xR2nBcpuHmWeF7u3rRvJTHMNADVyTeZvFGOhfGKHeZfbRKFC30mf0?=
 =?us-ascii?Q?xSBPZJoOssUdgQ/4IOhnZIeG1zPzJhYWIHk5BCzu4ZpA+TTke1AdpG+h9b84?=
 =?us-ascii?Q?pYAgLFI404WbZrSMq7GQsZlHdTvdwnTdlsSn6/pz6zYwzOXHi83i58NUKvBp?=
 =?us-ascii?Q?JgXVBLl3o90XQH2+HUX1SXFAB474wEEqcZWsPOBVz3KJQjnuAXozWcrD3p+g?=
 =?us-ascii?Q?Pegl5qMMNbvt+AjmeoeD8vgU3U8PNWGEEtor5e2q5WJAZSRjawERSy7a03n5?=
 =?us-ascii?Q?2EHwlX8YWhNEK0ehO/TzZyd2wGCmYBkx+Fr3ZB6tBSFI5nLZQHlpro/HZ8U5?=
 =?us-ascii?Q?8oZwlvae4DzbF1FPtxRwPYrGCFXezi2XvI0iAyPNlaBDOIwhACtrUcmlmmjI?=
 =?us-ascii?Q?3iY1BE319hz0hJLK63ikAguVRNR6dkgCcX9/3s3BXZz/jGM8htd37v6ZutQk?=
 =?us-ascii?Q?oH+8VR1jWah+quX3OQ03Q3z7eRoFLlPtj2xzKOYbYeHuJk5pLiiYrWS7uJcY?=
 =?us-ascii?Q?8mS1lyOy9f+jT4IFI2asWaj5Sc05mxRokoKmLB1j3HaNSjrdTCL2hRp8Olo0?=
 =?us-ascii?Q?ga23zntdO0Hubq17CcXendnDgUEhUZwBpnHBOdAd5C1RpQQSqUjY60zr2rbr?=
 =?us-ascii?Q?8YmJ65n3eLb4GkF5SHar9op+GePIrD6RSYRe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Ew+o+RxEiXxn9yPgDkNZqeaPB9qjb8uNIw/0aoVRqvSV0vXz3iOWC9DMR/s?=
 =?us-ascii?Q?OEneIwz2YMCpTDqneCMH2GDWSo58afHsEvPNgEBZrheP0MfjhKgjO19+HwQU?=
 =?us-ascii?Q?DqBxK/2Kgcbt1oqWz5BTIXq03YOQPH3eHPL2vXl0VO6rLP/KBxXwPYcN3k5W?=
 =?us-ascii?Q?gImbW9GgDMJkfZhdc4OcORqdvZ6pV8/qkmbJ60icp180o06A1Jddf5XQdWmj?=
 =?us-ascii?Q?74D0xhTrqdSxkgVFwMxinCsny/yy/LpABFakNwBXuu1QXxDm1nA8qdYXAypF?=
 =?us-ascii?Q?iVEh098WMGdzoyIdvRrg0OAoiyniB7egyIn1W9KLjRNe/YgmaLQzVII+amld?=
 =?us-ascii?Q?sRqEBHJyeYYg2ED0sNIkpYeK1TLxVxwKA1ByAdt2H9YB3q09UC6FR+RhDHCb?=
 =?us-ascii?Q?k+zXvso/G9ZHw7Y+jtg+6FyVAb3ThO1iNvU7Rs0unc3VhsL9iQwIZLq44uF4?=
 =?us-ascii?Q?pbqkgFzjaT3G8qVTRTXsyfq4DAtV8RZaRSsbc+3yhNRF0QFqWt7RWXFAkAoO?=
 =?us-ascii?Q?9scDd6MUUHud4Cl2eUB/Ofs0zywnXx6LoURRFEBLQlDp2asdBMzdN9G2eDhV?=
 =?us-ascii?Q?pQBjsFQYDZgLSMg24hzYECRicorO09Hs04ejPshGadPpHCq5EMpMmdYtvDyl?=
 =?us-ascii?Q?URvN7IkJ5r6yGhjT9qwnbafFkDTrbvHp7JLv1Q9wevlJMxMmGcT2hQzKNdp/?=
 =?us-ascii?Q?9onpiCBdPpT4PAngZKDP5mDRgEYL0I7RvZKz4JqXEt/C0658ijwR5rpU9pWe?=
 =?us-ascii?Q?dwYThikurW/a3iaXjQMabRgCPRtFPPYbeYFpJDNqIwwbgfu+hSynmg4SuGVd?=
 =?us-ascii?Q?akP2Rwb+I94WQ/PDdEybhJ6lLlxIdiKjUD+nYTtD7Ph+be6hLJN9sTFCU8mf?=
 =?us-ascii?Q?8OoaC5ezGSURV9XzvlO3N3XlJzpnVJYge112SdtqIPvEtPmPr9GoYt5PumpD?=
 =?us-ascii?Q?xraWm7zg/p08DXlP0W3mTP/vrWI82K1S+TDyjOthUtjXgnuzhOLI1GqNnoA+?=
 =?us-ascii?Q?zvOw2p3PQMqC4zHEE1cX3GVoA/k1gNXSGFAOvnmdXe35fKyEhDJCjjcWFPlz?=
 =?us-ascii?Q?a+XOTp/Wlkk3vyCO23GKYhtF7DnNPTFr/qnJ4Ob1YQIlxmwpRuW/AuS02+Bh?=
 =?us-ascii?Q?1AfOBiSpRNP85Y7MkiT0jKE4h1Y9zThtfFWzoSBXnR3qYEirJJZVveCmsqDu?=
 =?us-ascii?Q?6t36/D25dtCMi+UE6a+p6pcM6HTJ40YZqYfwOGu9dAp18Y+FJlL1ZkGOOtTQ?=
 =?us-ascii?Q?f9d5GZKTZy5t30f8uemp/PtfITaLLI4Eei3PwXOHkRz83h6bwTvkGSe4JHdv?=
 =?us-ascii?Q?yc+HobaaeEK3WrfQWoz+sAVvNAg9sv6FZ8tvzvcAfJyuz/SUGpKDOLcUFphD?=
 =?us-ascii?Q?SLejLGb4AJ18lXhd4HwntobdLPITBDnl/jIUxcqmObNskCRYLY08srqH7S+y?=
 =?us-ascii?Q?VtMrxbmUN+HQzGW41B+vDFjgsekuZExdEaBEK2Fw9KZyg0ziV39K/MDfOV9E?=
 =?us-ascii?Q?zArzX2Jpn3Y93mz3Y0S6HSu1XQyiOBHa45wtriZbj+f37OTdKZahjUD3QkK8?=
 =?us-ascii?Q?B8+sCmZhI/bWwhz6fTTVyKo5XPbzbYDJ/1y4tTxklPT8rZO4igINLwNkJ8P2?=
 =?us-ascii?Q?ZbOfbcYE2ns3a+jdv2tGNGZDonNmEz+AC/B6qCA996ChgSo2/MNLPdEO5JZs?=
 =?us-ascii?Q?v/PuTbgFfr+WF/zdYocFWn7gGppoQbSTcX2kGUcWYgCXsU/nBMVepE4nQ10I?=
 =?us-ascii?Q?gj01ZWrTW4B5ezG9o3MobG949P8cmWY=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ff97c0-0ded-43cb-9e24-08de41377932
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:52:44.7155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGelI6h5AR4UtksQYU1d+XUfbxhzJypV896A+MnrxsOFf9Xj+5t4sNibdzG4Y7Rp1ckFRzWlIc2GEBLPJ7djClJsUUVpL1IVKbH50kjs6dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9169

On Sun, Dec 21 2025, Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 15 Dec 2025 14:33:38 +0100
> Peter Rosin <peda@axentia.se> wrote:
>
>> Hi!
>> 
>> 2025-12-15 at 14:17, Rasmus Villemoes wrote:
>> > When one iio device is a consumer of another, it is possible that
>> > the ->info_exist_lock of both ends up being taken when reading the
>> > value of the consumer device.
>> > 
>> > Since they currently belong to the same lockdep class (being
>> > initialized in a single location with mutex_init()), that results in a
>> > lockdep warning  
>> 
>> ...
>> 
>> > Just as the mlock_key already has its own lockdep class, add a
>> > lock_class_key for the info_exist mutex.
>> > 
>> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>  
>> 
>> Looks sane from here.
>> 
>> Reviewed-by: Peter Rosin <peda@axentia.se>
> Hi Rasmus,
>
> Thanks for doing this!
>> 
> We should probably merge this as a fix and get it backported.
> Whilst fairly rare anyone hits this it is also safe enough wrt
> to very low chance of causing any problems.
>
> Would be good to have an appropriate Fixes tag though.
> Ideally please reply to this thread with an appropriate one.
> If not I'll try and figure one out, but not today!

I tried to find one, but the problem goes way back, probably all the way
to either the introduction of info_exist_lock or the ability for one iio
channel to have a dependency on another, whichever came latest. And I'm
not really very familiar with the iio subsystem, so I couldn't find one
single commit to name.

Commit 2bc9cd66eb25d ("iio: Use per-device lockdep class for mlock")
which introduced the mlock_key referred to 67e17300dc1d76 ("iio:
potentiostat: add LMP91000 support"), but that feels more like a "this
driver is what first exposed the problem" and not really "this is where
the problem was introduced in the iio framework".

Wrt. backporting, it's probably worth mentioning c76ba4b264442 ("iio:
core: Replace lockdep_set_class() + mutex_init() by combined call") as a
prerequisite, as that is needed to make it cherry-pick cleanly.

Rasmus

