Return-Path: <linux-iio+bounces-26267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCFDC644D0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 14:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6688385B62
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAABE257827;
	Mon, 17 Nov 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=spektradresdende.onmicrosoft.com header.i=@spektradresdende.onmicrosoft.com header.b="gFMmF2eD";
	dkim=pass (2048-bit key) header.d=spektra-dresden.de header.i=@spektra-dresden.de header.b="aSMu66uY";
	dkim=pass (2048-bit key) header.d=mail-dkim-eu-central-1.prod.hydra.sophos.com header.i=@mail-dkim-eu-central-1.prod.hydra.sophos.com header.b="LzmMZR45"
X-Original-To: linux-iio@vger.kernel.org
Received: from ix-euc1.prod.hydra.sophos.com (ix-euc1.prod.hydra.sophos.com [94.140.18.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D2645
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.140.18.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384061; cv=fail; b=aDUJaOnepXXgubEe/ORT1MmysMP44/AsIS3ROA16b6P0p6uw/Al4R1jjuIj+8j+Ac7sbN1tI7xz4ithzDKgQg3B7qrUanBsL+o51SVLSBE45VTYfSEUMcW2LCqpFnVwZryidx1FWeJQyOyA9tVjJHxxnpsWR9JnOHu+wq4r1X0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384061; c=relaxed/simple;
	bh=3+xA9Lx8dzYU/Qa5rHjSBUgsoovBpYcKRqzYrdLNdHc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=he0iFNMnUAOWqo6X5w+9f8QgtTwGERoq8aKyFnujnXjB/e/p5vgZECN2XayHsCw+9iSL/3sDcNIqH8W4HYujO684Z03xcYVWjrf/Nb51/hriUpqiHbL+JZK+Dosqx+ahDOSXnGCmhxuvYAsQz/YKnuc/fPDAe8aUqpgTBDRSLsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spektra-dresden.de; spf=pass smtp.mailfrom=spektra-dresden.de; dkim=fail (0-bit key) header.d=spektradresdende.onmicrosoft.com header.i=@spektradresdende.onmicrosoft.com header.b=gFMmF2eD reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=spektra-dresden.de header.i=@spektra-dresden.de header.b=aSMu66uY; dkim=pass (2048-bit key) header.d=mail-dkim-eu-central-1.prod.hydra.sophos.com header.i=@mail-dkim-eu-central-1.prod.hydra.sophos.com header.b=LzmMZR45; arc=fail smtp.client-ip=94.140.18.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spektra-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spektra-dresden.de
Received: from id-euc1.prod.hydra.sophos.com (ip-172-20-1-127.eu-central-1.compute.internal [172.20.1.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ix-euc1.prod.hydra.sophos.com (Postfix) with ESMTPS id 4d96f843N8z6Gy
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 12:35:28 +0000 (UTC)
Received: from ip-172-20-1-190.eu-central-1.compute.internal (ip-172-20-1-190.eu-central-1.compute.internal [127.0.0.1])
	by id-euc1.prod.hydra.sophos.com (Postfix) with ESMTP id 4d96f11nQNzqSJL
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 12:35:21 +0000 (UTC)
X-Sophos-Product-Type: Gateway
X-Sophos-Email-ID: 9ac1fdacfff14058a4257383482c8ff7
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021133.outbound.protection.outlook.com
 [40.107.130.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by relay-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4d96dz5MWJzKm4f; Mon, 17 Nov 2025 12:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1HCw4XW15IAGE658NbPyajn2adqswh25ZQQ7Lc404LyWgGno7lzsJVRZna5MRoz2JsaY2zbIWFyeY2ZewC6ivg/z8E2icgfuHXPslN9RXKMUoDU0uPDNdg9/obxQn0Z8ulB1GNuN5/PLLcWwhLpvDwuoHSctFSruLlUO9oY0aZ9+hcIW6wxKB4/dne4SkpsDJD4btRYfzPbOawg+DPSdFEnuY4GztdLK/8dUP6Gx0xakGuqKVvx+8JDJPfxdVvYQw8PQwZI6Qo3h6VOC3MRbw2vWCCHWnC6C5ok1QsxpLFR+A3bOvfPDr896TyPcsBrkPsM8iqnbKcdFwzPHredxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+xA9Lx8dzYU/Qa5rHjSBUgsoovBpYcKRqzYrdLNdHc=;
 b=FRywHt2PPA2w05KgZ0VlhcUd7trmcg5uEcx5PQIbYStyvuWolyeYivj8sSKPUPJtEaemwQNCGUWM7mFbXx9LXODngWQEGHymbG57aI6837kHJaXUEd6t5JAs1vtKfu7kpDl873iwiFStXzf2TYddz3Yu5ra0rJ4JV36f0KcaRRhHauiY2FQEk7igbShFjdnBfa/yI0hIQQI5nh3yccN7qGnXLUX+RMZAghyhXA5ImasQcbsV1gm3ABU2V8vH0HXg7swLbzgXEZrbhDRSgae2mrHREiLFg58RDlaciUP1GM2ZynvHH+W6uwtBvQt5b86RHWQrAQKi2RZGP/oYbFkRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=spektra-dresden.de; dmarc=pass action=none
 header.from=spektra-dresden.de; dkim=pass header.d=spektra-dresden.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=spektradresdende.onmicrosoft.com;
 s=selector1-spektradresdende-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+xA9Lx8dzYU/Qa5rHjSBUgsoovBpYcKRqzYrdLNdHc=;
 b=gFMmF2eDYLFA+AgWMe/Dpq6GWhhGMOS5r5iFGQMTz3nRDVyS1WCMJ+HP6H6des8Wt7hCTpmxJEaJuV2XFEVFtIXXZsBoMIG7XLbp6waHWlhA0HPoDiSFXq6fyZc+Za11new19rqYUmrsyA2Sc8KQOi6nThDn2ds5DcNCibQYq90=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763382913; 
 s=sophosd47ca55e60634ddf88e33a41e9d317ef; d=spektra-dresden.de;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=3+xA9Lx8dzYU/Qa5rHjSBUgsoovBpYcKRqzYrdLNdHc=;
 b=aSMu66uYLMcpL484xmtJp3g+6FNDQODf6zm5A9jq2ZwHBFAat+M7yDiNeFYTP7uB
 M04Lh5fzpy8WpjN1F3D0xPP7wSTfO+elyI60NQklmG52EbuvseNaLthP8EwAaeIys8g
 jfeEQ4DyiiCj2Am4D+aX0hhdO2QTj6tYs53G+VjudMwI/pjsSKDnDuHPD/vW7vIQddL
 9QRZn4qdgk+qOzeUvfkaV7Bq3hnpEggTqdgdLpfzIUW0ckWf8+BOO3NClQ+plwM4z95
 c/5Vq/nqxkehOdZ2hOPGsvXwGR93G7EJlj0FP824IR6JG2DSkN/4kq+gYX229bm2CWS
 3PA8eKUYqg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763382913; 
 s=v1; d=mail-dkim-eu-central-1.prod.hydra.sophos.com;
 h=Content-Type:Date:Subject:CC:To:From;
 bh=3+xA9Lx8dzYU/Qa5rHjSBUgsoovBpYcKRqzYrdLNdHc=;
 b=LzmMZR45FIPSnFO/eTd7bH/iR7dc5/JI9dLFirOESLKpmZncDG64GUmqgofjmLgF
 2gI8hEsfsgtI/1GOYON3tbx8HOfetSMf6IySzTn5Kdt5f/e3Oz/t7TvMK3Ipx9tlWeF
 Y5TbBDSsGcrvzS//ksQeFJLvH+aAWe9TP6JFCPLo94PO+td1TCloE11Y9GaUfLhzlHY
 BE7SPzehvvlLDxOqK3wsclrgYihdxzHnLNDqEqcv1kx8dBiVPFuT/V45VftCBZna+y9
 U42XqRcIK0mz+6higQGTYynXS3AVpdfkXxkbnD6JDgoF09TLZTIS4vKwEhWi6Ot4urM
 fl+M1NOV6g==
Received: from PAXPR09MB5040.eurprd09.prod.outlook.com (2603:10a6:102:133::7)
 by DU0PR09MB6094.eurprd09.prod.outlook.com (2603:10a6:10:406::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 12:35:14 +0000
Received: from PAXPR09MB5040.eurprd09.prod.outlook.com
 ([fe80::9607:5126:cfdb:6ecf]) by PAXPR09MB5040.eurprd09.prod.outlook.com
 ([fe80::9607:5126:cfdb:6ecf%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 12:35:13 +0000
From: =?utf-8?B?S8O8YnJpY2gsIEFuZHJlYXM=?=
 <andreas.kuebrich@spektra-dresden.de>
To: "'jic23@kernel.org'" <jic23@kernel.org>
CC: "'linux-iio@vger.kernel.org'" <linux-iio@vger.kernel.org>
Subject: [PATCH] iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl
Thread-Topic: [PATCH] iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl
Thread-Index: AdxXo+PhXUZmvITaTsKp4NFvoo0u5A==
Date: Mon, 17 Nov 2025 12:35:13 +0000
Message-ID: <PAXPR09MB5040DBBE59B2BA98F1108581B4C9A@PAXPR09MB5040.eurprd09.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=spektra-dresden.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR09MB5040:EE_|DU0PR09MB6094:EE_
x-ms-office365-filtering-correlation-id: 24e60887-6219-4094-f6d3-08de25d5c170
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?T2hVRUh5ZjZTc1loM1Q1dSsyWUl3aHM3TngzSlY3czBpemxKOG52d1p5N09V?=
 =?utf-8?B?VkliVVA5MnJSRlhkR1dmWHdmQ01ZSFNLRllRNkdWUXE4aDVGbEVicXpMcUtS?=
 =?utf-8?B?K1owazBlQVZrQ09la0FBMjVtWmFEeU9nLzNlYWdGSDV1TjZlZEtMdy9TOWNx?=
 =?utf-8?B?eUJ2VlJEZXRmc1REdFgzYzNRYnY0VnlYTElaMW5OTzZtVDFheW16R2JVWFls?=
 =?utf-8?B?dXhFOWpoNldYSFR1NE95ZkZPUTVhUUFUeDZWcS92NjBqSFZNZk1TTnFFQ1Q5?=
 =?utf-8?B?K0IzSXpZSkZoMTE5T0N0Z1E0Y1lwYTR6dUJJSDR3aHZNN0pDWDhubUxnbE9h?=
 =?utf-8?B?NFovVkxYYWU4MGRiRFBvNHhBWG9kOWdMbGdGTTY1eWV0K1NnandGTkxrbS9W?=
 =?utf-8?B?OENJMWpMa1VtRHdoNGNIb1BRS3N4SG11R1lnYXFIMzZzazFPd2lKV1VDTlo1?=
 =?utf-8?B?dTBTWE9uZHBGSExSelZ4RFBrN25Pci9PYTd1NXBqcWh4R2xuQVBMQldjcEdl?=
 =?utf-8?B?a09SM1dGNjhua0VKcFBHa0IvTm5uZDRKOVpNc1ZSYTFTQW1RSnJYZDVrZ2gr?=
 =?utf-8?B?MjNQM3RaaTAzL3hDV0RUYWtEVmVIYzlLQTdHa0lXZXFvOWd5dWpORlMveWJv?=
 =?utf-8?B?Mkk2MWxYT09IZXViYWpwcjgxbXJKRGp3aldVOHZBdjBVWGdoV0lCTnowa2hJ?=
 =?utf-8?B?eXVUeTNKNGY5MnMxWjRzbkZmcG5MdTJWOE9wQnEvdUJNaDJjTGNyaGNyY1R1?=
 =?utf-8?B?T2phd2Uzb2lJbjlva0lFdkhvTFZwZ3NqT2lNVjJCTXRVMTRIc0h2enNJZnZo?=
 =?utf-8?B?UmUwQkZzQ2dQbnY0SWRleFc1V3VJTnRPeU93ZHdla1BpcHVNU3B3RnJuamha?=
 =?utf-8?B?WUFHbFlmcnl0QVZtUmxtOGNxRGFYSU50MTFXSDJCTzdUTzBVVzYyVVNndWQw?=
 =?utf-8?B?WVlDYTJoRCtKQXhsY2JCMStSMUtLZVZqUUFXREFyTjBiVmVwYUNjR1N6ZlYv?=
 =?utf-8?B?aDFIUzczVjIxTkw0ZEYxOVQ0MDV5VzgvS3NaRU9hanBJU1Fid3hhdjNGbFEz?=
 =?utf-8?B?VVB4b3A0Q0N0T1lraW5obG1ORnp3VCs5RjY0ekI2MVBEdWNYT2ZXWnFmbTh1?=
 =?utf-8?B?cmhpNGVlSGkxemh5VTVsY0pxY2trWkRUZkxvRWlxUS9PZjBjQThZVC9pZ1NT?=
 =?utf-8?B?L1k0eGxlNHdTNFlYa0dRK2dneUp5UnRidlZYTU12dWJzYzZtb0hpOWoxWVB4?=
 =?utf-8?B?bWhtZHlxb09CeHZuUkQvZWtMeGVUeTlhZ0JsZzNPVk5odnh0QzErOE83dTgy?=
 =?utf-8?B?NjhKdmFTWUh6RFR0cFVQbmkra1VHd1B4WjRYYmsrNEU1WUd5d20xaGp5T3lp?=
 =?utf-8?B?S3dRLzF4aExvQXJQSDlaTzhkRURCTXd4R0xsSUh4eGQrVlBVZ1JqT3BEMjVE?=
 =?utf-8?B?aW85TjJscS9JMXQvcStmT1IxZStXckdPbGMzVlFadzlqNnIydkl4bE9XL1RV?=
 =?utf-8?B?U1J5WjdIT0dkR0RNY2QvbnJNbWhnV1RCNmVad3FYTzlRSkgyUUNza3AxYTNk?=
 =?utf-8?B?ZXRMVThWcmhDVEV4WFFLSyttOWJsTS9ibWdBVE14WWQzb09lSzJhcTdMd3dO?=
 =?utf-8?B?QTJUakJSSk9zT1pscXRsRWk1emhVbFJlQlZQdTg2eVJjdWgyK1UxdUlsRGxQ?=
 =?utf-8?B?TzZTY1o5SysySWV1cG5HbWFRcHl2Qk1ka25qUkJUSVBpYkdmdFZ2ck4xb2JH?=
 =?utf-8?B?Z2tTeEpEbDRFZUNyWjY0RDA5YmkrOHZodG1Ra0RKNm1VWm5KaDl6RHhMVGJT?=
 =?utf-8?B?aHY0Vk5UT3FFVy90ZmhNTnlwQTk2VkRTc2JhM2FoRXBKT1hsOUVWQWhITVd2?=
 =?utf-8?B?NlFFZkV4SkJRc3pKbFFOY2owOXBoMFhhclVNTjBkSFIyMDE2S0xJRzhVNXZy?=
 =?utf-8?B?OEdjTjZ3NktMSDVrZ3M1WTQwQlZJcEJNcm4zM2poTE42eVVIZEwwQ0NzdWxF?=
 =?utf-8?B?TnpzZ2dvTjdTQTR5ZXhlekdVWVZjU0FjYUVwdU8wRmQ5WTBLWnc5SUtTU250?=
 =?utf-8?B?TnBGRlZsTVdyQ09KaGlRT1hvd0sxOXhRS1Evdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR09MB5040.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDNDNUtHWldJd2E4V1JMV2Y3TDNKZkphcjNTd0ZldDd2bk5IWkl6TUZzSmdv?=
 =?utf-8?B?NGE0YlU0dEZCclpNVEZ3a1RkaEMrS0FTSHp6MGtKUVVGejV6SHpTSFNGM29U?=
 =?utf-8?B?WkNCbUs3Q1B5TnhLL0txNWo0MDhka3pERDNMQm43alFoSXQ1T242ZFUxZTM2?=
 =?utf-8?B?YUVlY01oN01YTWg2dWtRNVovbFJCRGdCc0ZTeFJkSEZ3WjA0YSsxNkhWWkN0?=
 =?utf-8?B?aGFtSnFUdlBRck80bk9TV2RRT2lrclU5aTlOeHk2MFlSRGpCMVJjUGNxaTlT?=
 =?utf-8?B?dld2OEQwdVlBenhGL2llempiUWkzdDN2Qk5ZVTZRQzFBV24xd1IxYmt5RlZJ?=
 =?utf-8?B?VU1IR3JUMTJRbFl2WUNSTWJDazFjLzI3UjFteXc1aGVFdDVUN3Rxdzd2Nldr?=
 =?utf-8?B?R1ljZmlqdmR1RUs1KzJkTGIrRkJaQzJDcHp4U2I0VUNCbkZVbUxqbE5TbGZU?=
 =?utf-8?B?TXdFeHZhb0FzVEFKcXVSdVMwYkpjeXNhOHh4UGFPZDMxWHFBVlpMbURvWmxQ?=
 =?utf-8?B?U3RTTWdGeXo1M0t3SlpQMHo0WXFyd2FITk5wY0x5SEFIdUxLTWVzcm1uanNQ?=
 =?utf-8?B?ZGd6dERQUjlUWWtvZTB5UzFORVBtWDhMQmlyeVh4azBHaWtCbW92WEltQ2V5?=
 =?utf-8?B?ZEE4N3AyVk51bGVudkV3UXpBZU1CS0hiNTYvaTJYS2NQMzVYNE9icFJTOEZj?=
 =?utf-8?B?NVJXdld0ZWw2V3FEY203Z3JhcEU1dmozTWFSQmx5QXBjdENvbHRMcUNwZTRH?=
 =?utf-8?B?Z1p3MFhwRzQ1bkFMZVU2STJUYlZWb0FYMjZXN1lyaVNHdmZoMUw4MmdZR00w?=
 =?utf-8?B?UVRQTGpSbmYxc0Z0UU5LRmVOT3IzcUhiZ3NDMC9RSk1tSTZ2RS9RV0diRFZ0?=
 =?utf-8?B?OVJ4cXBRTUk5TmJPM3FaSC9aemdCUVJic1B6ME4rU09TaE44Ymw0WDdVZjN4?=
 =?utf-8?B?ZkxoZ2ZFUHdWUmxGWm96VUZlbEJXQThPVHFLbjdhMlZ5VG8wT0dXUVpFcHlS?=
 =?utf-8?B?Unk1Vm8vOUJmLy9mZnpxd1FJZWtuN3htRzlPa1JRTzhYZlpLWHNwMzkzM3g0?=
 =?utf-8?B?NW1hZ0hmSFpFTTRYNzFwenhKRXVlakVuVWJOSVVsOS9TVGFHZDNiUkNoaVFN?=
 =?utf-8?B?VHlnVXMxUFR5SjRvd3lKSTYySTJNZnk4SEo2TmZrWE5qYm1UckRseXJBckR2?=
 =?utf-8?B?OUdESlpIL3V6N0plUTJtZzl5M25naEhWakFESkR0eFFhaFlLYnBpbW9lTU9U?=
 =?utf-8?B?ZDA4SC9vQzViNG9JMjdTTzZBNXpYMmw0azN5ZVYzendFYWF6QTVPWEZMdlVj?=
 =?utf-8?B?M0pqVVVlR0FEenprTVRBK3prOUx3SFpIWkJNdWcyNXB1b0N3SEZsQWRwNW54?=
 =?utf-8?B?c0p2clhrdjZzVURhcnhKcHdKVGhYTWNaL3RXNFh1ZkpIQ3hUQzFhVTRRQjhx?=
 =?utf-8?B?MkQrK2RZWk1JZGxmZG1kelpBclZuRmN2eGQ2dEZ3eWFTQkFoSlVXbVBTcjVP?=
 =?utf-8?B?bTlLaFduRG4vWmNLYll4aURNRG5IWEM1cUJ4R0JuRTVpbWlUNlhsM05wWEdT?=
 =?utf-8?B?QllRWGlpZVdjTEtObzAyVHRxMld0T3lSc1JaYVpoZzd0bnRHV3dOVG9RNkwr?=
 =?utf-8?B?SFlTa1VBNFd6RHQzbVBlZUN5ZTNkbDU5K1NVQlMvQ29rdDFuSGNNSWVUVXAv?=
 =?utf-8?B?ZXFyQ29oeFEzcTY4VGtCdjVZRGR6NmNHQjg3d2c2L25xYTVxaW9ucG5QQ3Zs?=
 =?utf-8?B?QStuVUd4Wm5hR0lNRWg0UXhSbnFPbzlCamx4V1BkWDVCY2s0dWhBaFBQSzhy?=
 =?utf-8?B?WHpUUFZDVTREWnBtOWNwYUJ1MWxSOFU4d0ZhaUFmVUlWV29xM0pwRjZqTEla?=
 =?utf-8?B?TFAzZEc3WTB1VGF2c2tsRTlsdzBna2w3cVVyT09XUXRsNXFWSWZHUFlCc0pr?=
 =?utf-8?B?THJPWnVvRFUwUktpTFIvTTNXbFNJKzRpcFZTT3N1NWh5VGRjODdxV3M5eTVy?=
 =?utf-8?B?UmUwT01EOGQrVlVBUjBFVXFuUk9meUxZUFMzaVUvb0ZrZGxNQm1yM040MjlJ?=
 =?utf-8?B?NDd5a0ROblZLR05Ec1lJUHhSTlRFdzI4bGV4TzRaRXlQRzM3QVVHWXA2aUFL?=
 =?utf-8?B?UlQzNGJ0enozUVYxVHYwRkNoRFhuS1RkTzlPQ252NTZnU0ZYVHZSMlNISnlo?=
 =?utf-8?Q?YMDhi6/MyGSYcTe0EXtaAdk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: spektra-dresden.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR09MB5040.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e60887-6219-4094-f6d3-08de25d5c170
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 12:35:13.6524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f0fc6769-01ad-4c8e-9da9-38ead3013d23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDpLS3mQZldUwPut/cCQl7zghupZiclH7iQM3fDdqXQFddQAZlSJpW5sO5ZZfdqiF2e71fvwX1ojjcw8W1ewDlYYIsQ/SQgAglUZ2/hQFN6pLjkjzo9MCuBDKtwKXVcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6094
X-Sophos-Email: [eu-central-1] Antispam-Engine: 6.0.3,
 AntispamData: 2025.11.17.115719
X-LASED-SpamProbability: 0.079439
X-LASED-Hits: ARCAUTH_PASSED 0.000000, BODYTEXTP_SIZE_3000_LESS 0.000000,
 BODY_SIZE_1600_1699 0.000000, BODY_SIZE_2000_LESS 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 CTE_BASE64 0.000000, DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000,
 HTML_00_10 0.050000, IMP_FROM_NOTSELF 0.000000, LEGITIMATE_SIGNS 0.000000,
 MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_URI_FOUND 0.000000,
 NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
 OUTBOUND_SOPHOS 0.000000, SUSP_DH_NEG 0.000000, TO_NAME_IS_ADDY 0.000000,
 __ANY_URI 0.000000, __ARCAUTH_DKIM_PASSED 0.000000,
 __ARCAUTH_DMARC_PASSED 0.000000, __ARCAUTH_PASSED 0.000000,
 __ARC_SEAL_MICROSOFT 0.000000, __ARC_SIGNATURE_MICROSOFT 0.000000,
 __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000, __CT 0.000000,
 __CTE 0.000000, __CTYPE_CHARSET_QUOTED 0.000000, __CT_TEXT_PLAIN 0.000000,
 __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FROM_ENCODED 0.000000, __FROM_NAME_NOT_IN_BODY 0.000000,
 __FROM_UTF_B 0.000000, __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000,
 __HAS_FROM 0.000000, __HAS_MSGID 0.000000, __HAS_X_FF_ASR 0.000000,
 __HAS_X_FF_ASR_CAT 0.000000, __HAS_X_FF_ASR_SFV 0.000000,
 __HIGHBIT_ASCII_MIX 0.000000, __IMP_FROM_MY_ORG 0.000000,
 __IMP_FROM_NOTSELF_MULTI 0.000000, __JSON_HAS_SCHEMA_VERSION 0.000000,
 __JSON_HAS_TENANT_DOMAINS 0.000000, __JSON_HAS_TENANT_ID 0.000000,
 __JSON_HAS_TENANT_SCHEMA_VERSION 0.000000, __JSON_HAS_TENANT_VIPS 0.000000,
 __JSON_HAS_TRACKING_ID 0.000000, __MIME_BOUND_CHARSET 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MSGID_32_64_CAPS 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PRODUCT_TYPE_GATEWAY 0.000000,
 __SANE_MSGID 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR2 0.000000,
 __SUBJ_STARTS_S_BRACKETS 0.000000, __TO_MALFORMED_2 0.000000,
 __TO_NAME 0.000000, __TO_NAME_DIFF_FROM_ACC 0.000000, __TO_NO_NAME 0.000000,
 __TO_REAL_NAMES 0.000000, __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000,
 __URI_NS 0.000000, __X_FF_ASR_SCL_NSP 0.000000, __X_FF_ASR_SFV_NSPM 0.000000
X-LASED-Impersonation: False
X-LASED-Spam: NonSpam
X-Sophos-MH-Mail-Info-Key: NGQ5NmY4NDNOOHo2R3ktMTcyLjIwLjAuMjA0

VGhlIGNoaXAgaW5mbyBmb3IgdGhpcyB2YXJpYW50IChJMkMsIGZvdXIgY2hhbm5lbHMsIDE0IGJp
dCwgaW50ZXJuYWwgcmVmZXJlbmNlKQ0Kc2VlbXMgdG8gaGF2ZSBiZWVuIGxlZnQgb3V0IGR1ZSB0
byBvdmVyc2lnaHQsIHNvIGFkNTY4Nl9jaGlwX2luZm9fdGJsW0lEX0FENTY5NVJdDQppcyBhbGwg
emVyb2VzLiBJbml0aWFsaXNhdGlvbiBvZiBhbiBBRDU2OTVSIHN0aWxsIHN1Y2NlZWRzLCBidXQg
dGhlIHJlc3VsdGluZyBJSU8NCmRldmljZSBoYXMgbm8gY2hhbm5lbHMgYW5kIG5vIC9kZXYvaWlv
OmRldmljZSogbm9kZS4NCg0KQWRkIHRoZSBtaXNzaW5nIGNoaXAgaW5mbyB0byB0aGUgdGFibGUu
DQoNClNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgS8O8YnJpY2ggPGFuZHJlYXMua3VlYnJpY2hAc3Bl
a3RyYS1kcmVzZGVuLmRlPg0KLS0tDQpJIHNpbmNlcmVseSBob3BlIG15IGVtcGxveWVyLW1hbmRh
dGVkIG1haWwgY2xpZW50IChPdXRsb29rIG9uIFdpbmRvd3MgLi4uIHllYWgsDQpJIGRvbid0IGxp
a2UgaXQgZWl0aGVyKSBkb2Vzbid0IG1hbmdsZSB0aGUgbWFpbCBmb3JtYXQuIEF0IGxlYXN0IEkn
dmUgZm91bmQgdGhlDQpzZXR0aW5nIGZvciBkaXNhYmxpbmcgcmVtb3ZhbCBvZiBsaW5lIGJyZWFr
cy4NCg0KIGRyaXZlcnMvaWlvL2RhYy9hZDU2ODYuYyB8IDYgKysrKysrDQogMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vZGFjL2FkNTY4
Ni5jIGIvZHJpdmVycy9paW8vZGFjL2FkNTY4Ni5jDQppbmRleCBkOWNhZTk1NTVlLi40YjE4NDk4
YWEwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9paW8vZGFjL2FkNTY4Ni5jDQorKysgYi9kcml2ZXJz
L2lpby9kYWMvYWQ1Njg2LmMNCkBAIC00MzQsNiArNDM0LDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgYWQ1Njg2X2NoaXBfaW5mbyBhZDU2ODZfY2hpcF9pbmZvX3RibFtdID0gew0KIAkJLm51bV9j
aGFubmVscyA9IDQsDQogCQkucmVnbWFwX3R5cGUgPSBBRDU2ODZfUkVHTUFQLA0KIAl9LA0KKwlb
SURfQUQ1Njk1Ul0gPSB7DQorCQkuY2hhbm5lbHMgPSBhZDU2ODVyX2NoYW5uZWxzLA0KKwkJLmlu
dF92cmVmX212ID0gMjUwMCwNCisJCS5udW1fY2hhbm5lbHMgPSA0LA0KKwkJLnJlZ21hcF90eXBl
ID0gQUQ1Njg2X1JFR01BUCwNCisJfSwNCiAJW0lEX0FENTY5Nl0gPSB7DQogCQkuY2hhbm5lbHMg
PSBhZDU2ODZfY2hhbm5lbHMsDQogCQkubnVtX2NoYW5uZWxzID0gNCwNCi0tIA0KMi40My4wDQoN
Cg==

