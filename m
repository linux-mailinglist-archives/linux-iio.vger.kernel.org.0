Return-Path: <linux-iio+bounces-27046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1BBCB8DF7
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 14:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9C8E300909F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6504322B88;
	Fri, 12 Dec 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="QT45J5K+"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC22E6CBC;
	Fri, 12 Dec 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765545180; cv=fail; b=rmePo2uSzVtJ4ufk7uTipn00+cXgRuNEMVhOXHQ/3HHFXT+2Ll5zt0BKgox24pCoq6GZls5+RJJc1JT30Eikf9k3DaXrf1hxxI9tarj/1GZyLBm9igE5Ly/8l75GWWw9C5HcwjNNSjmVTmkAppT1rB/1eErTbVzM1M+xFZB/PC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765545180; c=relaxed/simple;
	bh=b8WUh8B136ybR82+nzULOcOhEe7NBdBx4/yBxk7gKfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=n2OnyWjI37yp8UCD8hSaMbWC/ALA3ByTh8F0aAGnOsts4GvZ/ykwXZGpLPh4r6H83J7bRwXEkF2kQfR/QEhUqrGGhqUbAp75BhmMZC9hygNUkio9lLBiVb5IukSpH54xybRlyX1tDkV9AIl8VaaV4wQQ4372ihMIiGNRy6WeD9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=QT45J5K+; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOpmH41r7NIbvIq4LNbLiA8fZgX9QzcW0FdrQpNJZ/pTb8+mqi0QYfOuL/ZySsKTgXlaSc+W5oNno3wbsQCRMxXCgz0CuO5WlC2LDM/kvYmiJgCA/fkmukKamMwuCU5//jPZkPnJI2/KrHX7OqWueZvblExdsfhATEuZY1NcuuzMrDz5NeNWj8EQXuqUWL54o9tL8SF/qQgERKSqSewNrf9E9S6qkwOZYdhQw+pDLCeeXV876pPRbdWiSSnI24BH1sDEIhaSuER/EiR+mQSpGwhX1ciCU0LBnxM3XiSXpLykRGb/jp73zIqqIaNDdcivglIszdVknDcBtUimaLzd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAetIOs0vy1D0acWn7KXfnlTMKVbLKwtQXOVU32wVpQ=;
 b=eodM2/m/ZVTlvQU7eQhnkxhzYk6ktsFrXXAImtud9uoOVF5BXclTjZTwJI19UV0KaljRvAFst8MpdNWk3+CctQgsYhrbgBxCkVpocCLIp05AcBk5NcYrnyY5XdlKbSyRKK49T2wxfGW8zc0cIJb7elKmmgTCGT4Zi4jWYNXUAtou6ef8gIMWnjCrrtwttpte7cUBYKb6+PIsZ3DWh6EsVqLeLII61QN6pskfYZy5M6AyrxkEfw4PmM64dMzO5b2qoDxeIPudaRWYrjYXyO2dOR++68pGiGAISc6AY2tuHs3jpK/Zm2Lzp3u+1lzG0WRP2JO/skP1No96/xJOnCDkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAetIOs0vy1D0acWn7KXfnlTMKVbLKwtQXOVU32wVpQ=;
 b=QT45J5K+0wrCXvQUrdRqT68GrVSgofEwXm8sWoifDmivuZYt7QJkoKqjkyRu0wQ5ZVthFwCrRm52QHRMlTPYAdt6nfrdpq1Wg1HNxPW4px80auFhzUpjnzShKFoGnJev3KcdTvaC33isU6VvlzKe94Du2gFvT3aPh6ZwiDGqZiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7900.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 13:12:51 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 13:12:51 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Peter Rosin <peda@axentia.se>
Cc: Guenter Roeck <linux@roeck-us.net>,  Jonathan Cameron
 <jic23@kernel.org>,  <linux-iio@vger.kernel.org>,
  <linux-hwmon@vger.kernel.org>
Subject: Re: lockdep splat involving iio-hwmon and iio-rescale drivers
In-Reply-To: <307296eb-e5b4-705b-6851-53cecb87a69c@axentia.se> (Peter Rosin's
	message of "Thu, 11 Dec 2025 00:29:56 +0100")
References: <87qzt2tnlu.fsf@prevas.dk>
	<17697c17-753e-46a4-8e57-107dc744f18d@roeck-us.net>
	<ced7efb0-02eb-f1b0-9033-e546ca302f1d@axentia.se>
	<307296eb-e5b4-705b-6851-53cecb87a69c@axentia.se>
Date: Fri, 12 Dec 2025 14:12:48 +0100
Message-ID: <87ms3nu9m7.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: d52972bc-dfe3-4d5d-7fb5-08de39802776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NI/n9hGafrTEFnr/kjiUDjJU+2tRm9ex3GZbqixCi9RXdZ/1BgqQjhVrj4Bo?=
 =?us-ascii?Q?qYa6vUdlgPcNmcIDdflhTva9UAC6K0yDJrXhygppmiCLpaRNGbmWzg0ikWuH?=
 =?us-ascii?Q?zS7aTKRXv4beBRUXRtB5rBukzPxdkfNaaO3OvJaPGIhe+VBNHeG9OTvy3s3M?=
 =?us-ascii?Q?LbfeDDeCvDeSkmhzNFE6b52U6UETDnxNHztyIQImPbp/IiV96Y+yhBkK7EWX?=
 =?us-ascii?Q?zJw1Dyo3WMrHbZ/yimdf5mudMQm1PSag4i8yPLQ99xELScLB8ZOBghA7Grv4?=
 =?us-ascii?Q?Rr9PGrWoKE3E6ZLEXbZPvx0nS0j0ZVUx5kd5v2CJvhh9CHkzIPfUDhPdP9LF?=
 =?us-ascii?Q?y+Cr5417zcbvLlDFeYO8SZbVdmJaAymzBJX50CMSXhLNKIoFflSg8GU/RiHd?=
 =?us-ascii?Q?eBKNZHOVuQJj1+7xWDY9V8zdzkrXXkeE/FhHmngo51LevT+eCNX7PNIRmi9W?=
 =?us-ascii?Q?aZnqtlkPq43iTBifqc4TiBc4PE46qZnuzUeS0/CUzdVpRl71OjbOULoyxhy3?=
 =?us-ascii?Q?SCL7aZW4p9dMgcnBcljA/kmfH7jI98ylhbX/w+OoHPNwVo348J1dXiXr/AA1?=
 =?us-ascii?Q?S83pHB5CCPD9nQt2YC0g9J3SIOeZEj+mW86K7Qw96xgwmPYCuJAc6BtU7Fuy?=
 =?us-ascii?Q?YsrdCYtIQhwSnh/kvsGDcau3unGvmXsW+uDCfY03K6C7dRiUSM+sQh3bUTJr?=
 =?us-ascii?Q?YxpJjp2agZtPSWoU9jZR0GcYwMl82gOqZibad8WGy3zdB8bEBaJRvNHR12aH?=
 =?us-ascii?Q?VXfqReX6F2UoCVP2UBeOdZ08wshEE8w0jAHgVmmMBCw12RebijZlxixGb5DW?=
 =?us-ascii?Q?Vzuv2MgpWYuFyDuaJJldhWPpgq/ZPNUVV3D4GiN9BkIZs8H2QKQAg78fiz3H?=
 =?us-ascii?Q?ZR6i9bpGVBJaflUTj1IrYiUWDwc7cYGRJySyRBdqOsNl5i645sdGnI87bZ5q?=
 =?us-ascii?Q?QkMAckn6MX1By/3ObX/9l91yBFRWkiXLzohe1Mrd7/zxf5xWfZ0sfRZU9FJs?=
 =?us-ascii?Q?SGb1WaitqqPjfU4hnlNxAl17YoSVm/CVqsl6t3O7aNf/lTCYxiPX/ns4xUXO?=
 =?us-ascii?Q?2NPRvV/Tw1nimdWGL0j6TnLcoNjZ2lLh+vSztPiy0Tx6riZ0wWAvfRhjO9gP?=
 =?us-ascii?Q?wMB3ezCCKg7MEmBD7YKk9jKLwEdwRG+Ry20XMQ22c1Se+VQxG0age2ikl4qp?=
 =?us-ascii?Q?w9YhyXYO+fdAu6BRk5/p8y1DngYo9E4q+GFCm94Wb/opFFBMWMLQVADOxSiV?=
 =?us-ascii?Q?1S7tK7yZIoxIu5aduyNADh1TxgVypv7qb4+4yaCZOO5e1g2pF6gP2LRb+6uw?=
 =?us-ascii?Q?rbClofDCGR21TfnoVaP+VeD5AmEjlpiNLTySg/mmgrbTuEw5FgczjjAiU1YA?=
 =?us-ascii?Q?FOYqxq59VdzFsn9nsgyTpnA028A/0prcrhNnRn8VlRbTB31JyaD0xEDeDoKn?=
 =?us-ascii?Q?N+oCRT1X5Nz0uD5FOERaIzU5fklu8frNnL43T0L79lUHUxOJo8mrc8XekSpw?=
 =?us-ascii?Q?QYNeG00+0JaFrkb1E7/HIcMLNPCZALpmzh8u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9YiVxquaHgKYzUPqQSbvN6bKnLkssCtroqjgbTrFJfjqEp9jAMt6VxLtXOOG?=
 =?us-ascii?Q?ciW1HCeOApt+YRG4FJpDYG0e9cIBDGGA+sYNoHFRSa62KAPHcFzIue28uwTL?=
 =?us-ascii?Q?QYREqWnBztZyRxKVKlUWJS9sqCvD3UvcAIC1Sfi2RS4fcII9zCr2CjJKbxUX?=
 =?us-ascii?Q?XN/RiYkfDsRTUbZn7hXLAR3FlE+Or4DPQSaxp/iZQ5GpvyCkG6rBwSsLUfuG?=
 =?us-ascii?Q?Jt1M8epNPnTy/c0e14n7En+sX9L8SX8P9UYaQ+JMev++wnrpn4a4f7yXsqk2?=
 =?us-ascii?Q?31HEd7GmI9LvebCC2KulPJz6IhKplU8nTVTb+gFij4U0fAVr7a59x3a14ItU?=
 =?us-ascii?Q?YPozu3JLdGkdy/tsfQG2Og0m+GyPSRs30xEFYd+/sZePW0UYNITc7d6eYzIn?=
 =?us-ascii?Q?ZlIzpWbAUORhaVvhvssfwl6CHfsx70Azyb2WAVyoLQPQjcrb9D2u54iNbGUn?=
 =?us-ascii?Q?+8t7lxbPM6/p7Dl9Kx/XfIjabMonDP4K8+IYf8beXQFESJclR7tCXZrNAhau?=
 =?us-ascii?Q?nDuFRegIIikGxuSkbYJKbrPsuR8G0j49Oi98wy1rPE/XH5QNUcRlcV52W4x8?=
 =?us-ascii?Q?IfdGVacAiRPEjRdxY33RgD7LjLmpoDyNwHow4xj+vh3+Kd+Gh1L4CZwjtLiM?=
 =?us-ascii?Q?hdKXPZs3w5OHE+cI9ooAINzGpzP1greZhsEQJMVKd8+2+R0uu2BWZZnMmPZe?=
 =?us-ascii?Q?cFQjGVjUEaSN3gWUrg6MDy+v3e3BN1zdQuJUdnv7ro8KF5fm4v4P4hjIPemf?=
 =?us-ascii?Q?8W7zt5lIiK2YCItXzfP7usAzUPq5Dn1bbQBySgSLJKEAIJkuA0ATLTt8KKfF?=
 =?us-ascii?Q?QZqorRpBuKIogLARNSVg8IiEOjEWwd5kdacTslnlYiFE3EoXkE0PTQWIDPIS?=
 =?us-ascii?Q?WNY1OYIOInzFwFdWKlNRO/eWN2n5gSSRO/bKT8PVBlZ9sKYzgT/fEsyDdT7i?=
 =?us-ascii?Q?s5fM/6DScNj6SvK1UYmGvt1Him594FA3atWVixxl0UXwEoe8KNgfpi8HtYV+?=
 =?us-ascii?Q?raZbcklbd/Sz5VaBRzfcKedjIwByzW3PBoRBkRPIAuNlycMdMArQhWVbPEVQ?=
 =?us-ascii?Q?7imAiDVgwstUsdZ2aIwzodkNDFn7B8l1XMfpbV6uwuCf2kGoCeOJ8lMH1Trd?=
 =?us-ascii?Q?cClDct5cZaMi19z1PBaDzUfjF2rJJBidtZGpq22xOZs/rQXn47XmOLTWsI40?=
 =?us-ascii?Q?uLZS8Mk3wYweK66/nPb3y0PuOUnYpVkDXcZsX6Sl1lCxnO/MRdlMAlZDeOgB?=
 =?us-ascii?Q?wNRhjNAClUdUlxKPKkci9E5GOMivOawpx2Mw32vcU/M0fP65DxPqDJ4zkiIC?=
 =?us-ascii?Q?ZFv9n6gl1MWaCpA9UQbXFO64sY5V63dTy2yev3Vl7o0DLMG/FcAKSB5jzp9q?=
 =?us-ascii?Q?uMXTocx+rY8+6P6PsSRmm46xLgDBt8P6eZF1dP93tPhrLmZG7IRIe0JB814f?=
 =?us-ascii?Q?XCUQdojrFM+QO/Ux01uOdjXCSayChmLrDpLJvuOcJn0FNjA8Yfhf+SJfwno0?=
 =?us-ascii?Q?dLmX/1Qw/aKJMq4MAeVR5Xl9z+NSgHuayctcGC65W76jKkxW4oL1dsp6m3rC?=
 =?us-ascii?Q?LkzXAP/JJINhQWyRQxGGVuvYgczWrjNlpLhqPV7j7QmF6sZquXWvMU5qqR1n?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d52972bc-dfe3-4d5d-7fb5-08de39802776
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 13:12:51.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ia4XoxAkKeaPfw1XlaJ8Jcbuzjk0A7VVRD+Sgjxo6wtVlp/GF2WdK9NGrdQP4NlsDo5DxKb2aq+nXvLz7ePzeT9QfTWnxi4ggF72zom6chk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7900

On Thu, Dec 11 2025, Peter Rosin <peda@axentia.se> wrote:

> 2025-12-10 at 23:54, Peter Rosin wrote:
>> Before commit 3092bde731ca ("iio: inkern: move to the cleanup.h
>> magic") I think this could have been solved with a number of:
>> 
>> -	mutex_lock(&iio_dev_opaque->info_exist_lock);
>> +	mutex_lock_nested(&iio_dev_opaque->info_exist_lock);
>
> Oops, we need something clever for the (missing) subclass
> argument to the mutex_lock_nested() calls, which I simply forgot
> all about. It should have been:
>
> +	mutex_lock_nested(&iio_dev_opaque->info_exist_lock, *subclass*);
>
> I don't know what sane subclasses there are. One thing could be
> the recursion depth, but I don't think we want to keep track of that
> just for lockdep? Another is to use one lockdep class for every
> info_exist_lock, but that can generate a lot of lockdep classes...

It doesn't seem to me that that info_exist_lock is the proper
mechanism for whatever it is it is protecting against.

I'm not even sure it's needed, because if the device could be
unregistered while somebody has a reference to it, why is it even
allowed to take that lock in the first place (i.e., why is the memory
containing the info_exist_lock guaranteed to still be valid)?

But, since I'm not going to propose just ripping it out, perhaps a
better approach would be something like what the gpio subsystem did in
d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device
with SRCU"), at least superficially it seems to be about a similar
problem.

Rasmus

