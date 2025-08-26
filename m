Return-Path: <linux-iio+bounces-23299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6220BB35D41
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 13:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC8B2A6388
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 11:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C894A34A333;
	Tue, 26 Aug 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HBQcu1/J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7B338F51
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207935; cv=fail; b=QANY7ReJ70FdhyLIHPg/LNP2tgdUjgaFLiHA3qiaSDwLvsACu6YHRb4xszm9Sq/PxqxSNU0thJLSgU+hYgfIu5woguK/QwKx4PlAzdanvXw0ZyGDtF1ni5F7TDpa1ZLmti/yvIRRHXbSQqVhVLEdBSu7hqpN820o3Q4OL5f42yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207935; c=relaxed/simple;
	bh=e/0ga8c1sh/NUrQugmC5jdsOvqoU3kuzOn4+B10ml5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9ZBvQrA7vTUui5C3t1g/CRnR5k7fpKVoz/P60HMOUAlLlWbYC7jiAK5vRiNaB9JlUG2CuqKY+ZbVWbDnekN1Rz4YC3IrfWcBnx5YH+2N0qHyR70nkUQmbyJVezcRoQ0RDcOeCfO42sOi7IZRXt0rF65RyYP9w3c0//cHIS3Lng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HBQcu1/J; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q7SwV7001896;
	Tue, 26 Aug 2025 05:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=e/0ga
	8c1sh/NUrQugmC5jdsOvqoU3kuzOn4+B10ml5I=; b=HBQcu1/Js3seBGG1FdlH8
	J3iXCforpG37OsN71agqRgjSWx6314He8I/GuqQdVpQ7y1T9WsEqyXu8Er8tHpBr
	VQ2swV+S07iGh1NpTKk5jNi4d6hf20xPGHUvAOHM4doUDVJe2R9OwJOgARiPnCz9
	g2cPvxTBbXRRRMhrXSB87Iyq4hCo/f/KtgDfrKrg8O7lhrvqWwgObPeEkZdlfkCr
	sljJBg2NNEi7OLv/ykN9n3Bai5Sjtpe3mYxrsJOk4tEXKHeM+YMxGJp0SEzgLDzw
	55kteQ5PuFizcxkSNF8XUuq+fllT2G8LY2SI3h1j4FMCnccbYRA8nT0w/6l4X6LX
	g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48rwm22vwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 05:24:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imgwErli5jnbvEdl+A57fiNXq2/lSAH5YPNSdB854L0IjIhQIs5+5mxMd4qd1hJRgUq2GRflCJAUHGkKZeJhsCSp/qjFRWhVbyZsRSDDhLz6Owhx2ewHkHM6JGCGQgAhW+V1MxfBAHAqaJxhHog5aVL8lvIgc9OyNCVVNfPl7j2rxV+kRNe7AulkuKTb7Kmyc6IQjuycOgJB4nAFKQMJT6Mjllgj9iF6k9anz9NWcBPNLE1pOijKsWj2K8pnoa88iKMqcnZSnm+m0j1VvY+VO9QVj8avOHSw64bsucQAyQcxWSrJ6OGru+hMShHfNPKQN/3ez6onrDFoMdsStKjxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/0ga8c1sh/NUrQugmC5jdsOvqoU3kuzOn4+B10ml5I=;
 b=jj91d+ZJAHDTqEkvjm2KqBqmZ+7H99uocTyvgMXbcBlcRwKC/vlYkDVLMvwNKYvHUMmqGJbEswUtmqYaQ2xDujZQEMZ0Av07T7e3tKv0dq2B0vMUJhi/Q7OTov6R3MVJzOBsgFYFS6/mjwWtZ+aCwbCV3aAa4cF+Gv9Gp+l9XvLPj8jVnl8utzPiD3gScdvQtkEGZ8Ma6vTSSZ0rzwVBH1b4r3AuJcH3Z3hUnstS0x93UojFFzmCceclZldEIoCel/YualZzcWGHHPuhQCHfuDC/k7tPr6sWIRZeq8+dipRLpWZSfPGuA1I6C9KmyTa2s6wMsG17WKJ5Tlb6k3q7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by BLAPR03MB5587.namprd03.prod.outlook.com (2603:10b6:208:286::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 09:24:06 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 09:24:05 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "marilene.agarcia@gmail.com"
	<marilene.agarcia@gmail.com>
Subject: RE: [PATCH v9 2/2] iio: adc: max14001: New driver
Thread-Topic: [PATCH v9 2/2] iio: adc: max14001: New driver
Thread-Index:
 AQHZsubiZVm2aMsLPUi7mLF9xAsvxK+y39eA///AI5CAAHWzAIABAMaggAB1MwCACChNgIAGmCMAhLYkcZA=
Date: Tue, 26 Aug 2025 09:24:05 +0000
Message-ID:
 <PH0PR03MB714176D11BC31FC20DF8F106F939A@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20230710042723.46084-1-kimseer.paller@analog.com>
 <20230710042723.46084-2-kimseer.paller@analog.com>
 <CAHp75Vd386P9xM_+wLahp6B_XwYVq1AZxaFQeWvZ2pnk-tFGHA@mail.gmail.com>
 <11c30a02df784ca78be271fdf9190dad@analog.com>
 <CAHp75VegvKFUXoJoJnuXstJa_L66M2Ah9yf1aEQ8-ET1QczDtQ@mail.gmail.com>
 <fe0cd5348f864a6392a7e0e5ca93bec5@analog.com>
 <CAHp75VcpguSN9DkuCtpaB+_=sY7+Ot1MGPWToe-2pYjFXC9=4Q@mail.gmail.com>
 <20230716144223.0d9260d3@jic23-huawei> <20230720192428.2faaaf68@jic23-huawei>
In-Reply-To: <20230720192428.2faaaf68@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|BLAPR03MB5587:EE_
x-ms-office365-filtering-correlation-id: 5b8dc753-ccc8-44a7-a024-08dde4824dce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkdpOVVIQ3VrVDdZczdYa0QxU0pDdDJMajhoTXUvL2p4RmZWL0hEMlQyRllY?=
 =?utf-8?B?VDVYOHZrSnVvOXFSUHUzVEdjZ09wYUduSDJoa1JVelI5eEFhMUtXZ2VvTVp2?=
 =?utf-8?B?NU8veUx0bWFWUXBKaGdNNXVrZGlHZSs4Z2hEc1BNUXlmZjJXMi9sbGNUakk4?=
 =?utf-8?B?bGhkZkVUNndjY2ZPRnFMTjRFRktINHl6WkJiYWdrdi9NNzFRenVHR3pRRThz?=
 =?utf-8?B?S0tuSExsMEExQkVOT3hRTTQ0TkRLcGdmb0t2NHhaV2pXNnk0Ukg1a3hEY1pX?=
 =?utf-8?B?eGJtOEVUQjYxUUpVSUJWbDY4WER5NXpueVhPNWFTUXBzeUdWc3ZsTjJkUEo2?=
 =?utf-8?B?RkR2cGk1SE5WK3hKVGdmWVZtaWgwZ010YWloZm0wSGNUcGZiYTBrU2JDaThN?=
 =?utf-8?B?YlU0Q01OaHpsM3Y2NmtRc0w2ZXA2cmZ3TVc2a1cycHk4UkdqMTNzemN1cUU4?=
 =?utf-8?B?MG9tY09jRy9RTDEzQTZrMGpCeG9vb24xcVdWRXJQczF0WmZzMVh5OGhPRDJu?=
 =?utf-8?B?SUVsWjlyaFl6SnkwSzJWRGkrNTdGV2t1R29pRW1odG9KNDR6d01DL1ZMK3NX?=
 =?utf-8?B?VCtRZjMyYWV2NjFzQmZWS09ncGZnSzdqL1RHS1V6YTlxUC95dTZuaFgvcXZP?=
 =?utf-8?B?a1h3a3BzTTJrbnZPeWhLVzR6R2VkUlUwcTJVUU9ZaS80ekJOUGk0MGl4WS9t?=
 =?utf-8?B?S0FiY2VJdHh4Z3oxS2R2TWx3QWkxaWFKa1JpRUtGRXpUNTV3eGpJN1VxU1Na?=
 =?utf-8?B?WWdBd3A5eUFWRTlNMk5yU3RKeENSUDZ6bWR4SGdFL0w1cGRrVlAzREhINmFy?=
 =?utf-8?B?SHZ4OFBqTFczSnlySi8zZG1kRXozT1FuQ0VKQ3NJNTVqTHk3ZUJkNTIxVDg2?=
 =?utf-8?B?WFZldFRUL3l6dHdsMWN6RjZmSXg3OWFabDFLVDh5aG10UUVxRnMwZjJVdnJ2?=
 =?utf-8?B?a3JrTXdzQnJ2Uk5CaTlMNER1cmRsOHhva1FEczdrV1dUUC9vNG1EdllEcE5y?=
 =?utf-8?B?dnFMcXhzYmtCQ1hCRkFBc1lQVXl2aWxQVlZVY0pCMjdEeUkzYWliSFNWQWhQ?=
 =?utf-8?B?RGlldndYQ2JqcWhDTjQxQXVoODU2OUl1a2tsY2t0VjZjUnNWcmt2NVlKR2sv?=
 =?utf-8?B?VFV1OUhIZFU3a1RKYytqdGRLSzlkYkhML01DNHhrU3RPeDAyb3N2elBYMkZS?=
 =?utf-8?B?MmV2R2ZzT3FrdDBMd2UzYVpsdUR6ZmkybUZqMU9tTnRMcGNUV3pJeFk3cGFI?=
 =?utf-8?B?SWRhYjdoWmliY2Q3YjV4bmtCbTlFRk5DOHBZTExtODJ1a0RrcVVlME5iTnlL?=
 =?utf-8?B?a2xrT1lBbGozaGdkdnhEM0tEeWpYWU9mNTNBWEdZU0U5RWRxZnlGUllWWC95?=
 =?utf-8?B?NG11NjhidEJ1U0xTeitRQkdtOTZsb1llL3ZWREdudEpjYnIwS2Z2Nkh3bkl3?=
 =?utf-8?B?blpWWks0RHB4eGZSSkhwU2w2MnZxdXFMRXVHcDhsZlJZdEZvNE5XZitGdUh0?=
 =?utf-8?B?YTFRdThMRGR0OTZkMnI2OTRBTGZJWUtBWmxBV2F3b2JEVTdHQ3VMVEJuVTdm?=
 =?utf-8?B?OVRZdUlZdENUMFplMEJKbDAxSzFkYm1QcDV4d0cwbnZRdWZkTElQRDAwL0Ra?=
 =?utf-8?B?UDZqTjUvS2luREt3dXJla0F3alJiL1RNOHB0U0xEZ2krUThDVlluNXBtR0VQ?=
 =?utf-8?B?dFIydXFrRWNZaFNPUE9PRnlXanNIekZsalE4ZmVyR2Y2Y29xYmk3V2JvQ0hp?=
 =?utf-8?B?WVFGZVlxUXFyK2JUTndsd3dLTnlYUGt2eFRuUStpZEovS0pBL1VXcTRScVMv?=
 =?utf-8?B?Y1hDZ2xTSzNSZ3dBV0VjMXBTbkZDeitkdVl2UzQ0TUpkSEZ2Y3Q1VCtRc1Jq?=
 =?utf-8?B?bm1iQUVhZHVhZytSSjN1RzBmUFBScGZhTzVWU254b2NjNHBseHVJNVFHbWZt?=
 =?utf-8?B?bWRkdlFBK3lERmxvUDlTQjVaNTJIUzVIUDM4ZHo2UkFkb3pPZXg3Y2hlNkpS?=
 =?utf-8?B?enViVFNTYWJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWpnSHdRM2NGMnRhbE0vRDVRMHBiZVZUaklCVU4rUEhxZGNGaExmOW14THVv?=
 =?utf-8?B?Slc4Wmhrc2RkZURHRGpiSlNMZHVET0FseUJrbjcvRks0a2J0NktxV0V0TFFP?=
 =?utf-8?B?SWdpTUU5TWNVZmlraUc0UFFZTmY4NXRrVnRvSHhUL3ZiazNkN0w3UkI3aVND?=
 =?utf-8?B?ME1WbFJONjFpOE5ON0dBRE50ZjN1Vm4rY1Ivd3VkVXAxd0g5UXlmZ2RBMWFC?=
 =?utf-8?B?NEZPMWU1azFBczc0TzA4N056N2NhbGRwN0dKYnhQN2xscTl1emRnQnplcFIw?=
 =?utf-8?B?ZzZpQlhBTitUOFRZSEJRS3ZsV3VWaEpjOTlRR0dJVmRRWkkzRlBjaWFMK0p3?=
 =?utf-8?B?cnlueVFPZkpqck1TSjIrNDVNTUlSQVJUZFQrUDBiSThMeVJ0UzB2MzRZbkxB?=
 =?utf-8?B?WnhLUk5LYkVRVjZvU0ppU08wZXdLZ0dHbWRPcDNTZUJGWlpxc1VFcjN2Skl6?=
 =?utf-8?B?TW43ZmhObitWbzlZcGdHL0VsMFd0YmxiUlhqV3JUejZtcDVUb3FaUXB6TmZM?=
 =?utf-8?B?VmR4ZlVYOUw3SGRTb2RId1NadFZCTU1HbVZsSHV0dDAxYml1NFZVcWRmYXZT?=
 =?utf-8?B?VjdLVzB3b0luSVd2REJmTk9Dem52NlpnZTV4dTc1RSszVFY3OWZ5UU1ESEd4?=
 =?utf-8?B?eER3bGhGOHFpV29QczEzZmh3cXdEbmRHbXd0MEZKdWI2YW1PVEtFZ3QwSXJO?=
 =?utf-8?B?dUdZdDE1T3dOYjVWODFLSlpONU0yaENuOElUNE1TdGE1NVNYRHQ0ZGwrYmwr?=
 =?utf-8?B?dlEvd2hESDBiUndlQlhXVEZZZHgyeU92eE9HczNibkhKaTdZNGxsbnhyWTJO?=
 =?utf-8?B?K2FQODU4Y2dYZUdjWkY2N3p4WFliSzR0YTVmRVJ3SGJVWlpGekJMTWpkOHYy?=
 =?utf-8?B?Z29BaCtVQWQ5eWlFdWNXV2ltblcrSHozVUphL1JZbUgrVjdwTjZZWXI1NFZZ?=
 =?utf-8?B?QnNzK1cvNDVpdmYwMU4reGxsRlQ1MkQ4K0lLK04vcmdYZUtlNmhSaFBNbWtJ?=
 =?utf-8?B?QUROSWRzWEtoRXNQMG9CdGt4T0ozbC9ISVg0a29HNU5WOGx6dXVjblNNT21G?=
 =?utf-8?B?ZFZKMnQ0d3NXK2xXZEgyRExoZDdLNjlpRzBHcFkvTmQyNEptNFhqL2RFUHVB?=
 =?utf-8?B?OFZJcGFDUmN2UnFuODBhUE9kdzBxRUVianByeTdmSjRHcnU5SXBPNUVBalhF?=
 =?utf-8?B?UmpKemhFcHM1RHJacGNXVzNQYWk2bjY0amU0cHc0VktlVHN1NTNqZ3BWYisx?=
 =?utf-8?B?VGNGRDdHSFhBZWkwNWZpYzY5cUNtNkExcUFadVFrdkszRTBOTFJVVWZLWXY1?=
 =?utf-8?B?M3V5eC9weXF1V3VzTzdDcVVIWEpxRmpQMHZQMCswcnZDUEpFaUpvRm56V0gr?=
 =?utf-8?B?TjlFR2VBNVdLM0Z5ZGJCYXdPbnUwdkZQZm5aZHdINDYrYWFYQnBwQVNiQXBM?=
 =?utf-8?B?UHFpOFNQMU1DUVdwOWRuNVhuNlMvSnZkSTdjMXU5cHdQQ08vZHRhVHpkbmpx?=
 =?utf-8?B?Q0c4aU93R3Z4WC8zdnJiMG1BeUw4KzNmZSt2eUVVeElFYnZhdzhtbXJVZVhx?=
 =?utf-8?B?TVdRY2ZkU3RWWTF4blZZWWxYRmZHQWpJRHhBemVrNng1bTVVOG5qdmxOSWJI?=
 =?utf-8?B?eDVjemNxelJ5MEwvTlVHa1d0M1A5MXY5TmtoTU5rR1VuMDNhWXErRnZ3ckZE?=
 =?utf-8?B?a3BabGxZZUpjRUdEcmRhaEVObmtUWmExcWdFSDJQM1RKdzB6aVNWaTFZY25Q?=
 =?utf-8?B?U3hwR0NQeHVkcUdlNkNSdFl0OHRkb1FvQjIxcjg2QkVXUUM1OXlUditicHBt?=
 =?utf-8?B?Z2dCM1hFNUZ6dThPdVowYmN5VDhRa2NwY2FXWTFrYzN3UVdFSmF5R1JEN0Y0?=
 =?utf-8?B?Q1gxYVN5bmliaE9DWHRXQWdzQmJ3WmdoanllTTlIdTlySk9FMGF3ZE1xWkw3?=
 =?utf-8?B?OFR4WEgrd2J5N05QWVdjSC81T2dMQ0k5eUlGS1NCUzBJZ2V0QWpUMDFaUFAx?=
 =?utf-8?B?c0pHZHZUQ1N6MWRRdjRCemp4S3B6OFAveDFJZDdiUTNoTDVQQVFaL2xBM0tY?=
 =?utf-8?B?d0dEZGhUZitJZjcraUxuME0zUkpsYjhlQjN1bFhqVyt1c1h2alVwV2dOajdk?=
 =?utf-8?Q?ciKbBGRc3SStb7o/TiPVe3p0D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8dc753-ccc8-44a7-a024-08dde4824dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 09:24:05.7628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMtkJfazmPfiM8QUuqlmw2arEu9jSKWm2IctdAt7gOa1CKs+Z1AW6UWUHlWSkLqV65z/F6KU0LYUht5wv/NWpsHcwpUlXKnWbEXVU1+l/oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5587
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=68ad7d3a cx=c_pps
 a=AUi/O1gD07nBRLizZNiypw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=TzCBEuXQXAN_zqIHb4MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE3MiBTYWx0ZWRfXyjcKY0mxXOvW
 ewMxaaRtMeOhUB0CCLtXiGfJlFTB2H3A6EMwRsvxlcTy+nNXXRVfoZVUloLhJidePlLK0fzMbPL
 OPnXAQ6a5UreAgQ873kbNeC2RKwZOoCZ2rxZyrOVlLUCuPA/3uxMeSLu4d1owMelt0BBqUwhNgF
 JaYCR2Ytgva3s4m59sJoBG29tNiCSThxgwRnQL613a4bQnPD1wt+XWbmWQsc8hzn7t8KoBOXtyZ
 V6kQQkgbbabICaFe//9drVGYiJVzoNsZLf6MUiGMR81ZMdfBQjz4C0kkJaKTHHf3naQzeKvQLmu
 tY+9y7h8HQ5M5AJ8jzHlBQoblmjjv/sWDCPx+LrRRhXBFUSoDbDrkNJSbUfCan8QN79cJRwTO/Z
 ck+5Xx5d
X-Proofpoint-GUID: 13Xpsg6Iocy3pEozl5Bbvi4ebvGlJLGu
X-Proofpoint-ORIG-GUID: 13Xpsg6Iocy3pEozl5Bbvi4ebvGlJLGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508250172

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyY2VsbyBTY2htaXR0
IDxtYXJjZWxvLnNjaG1pdHQxQGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAy
MywgMjAyNSA5OjUwIEFNDQo+IFRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3Jn
Pg0KPiBDYzogUGFsbGVyLCBLaW0gU2VlciA8S2ltU2Vlci5QYWxsZXJAYW5hbG9nLmNvbT47IEFu
ZHkgU2hldmNoZW5rbw0KPiA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IEhlbm5lcmljaCwg
TWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IGxpbnV4LWlpbyA8bGlu
dXgtaWlvQHZnZXIua2VybmVsLm9yZz47IExhcnMtDQo+IFBldGVyIENsYXVzZW4gPGxhcnNAbWV0
YWZvby5kZT47IG1hcmlsZW5lLmFnYXJjaWFAZ21haWwuY29tOw0KPiBtYXJjZWxvLnNjaG1pdHQx
QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDIvMl0gaWlvOiBhZGM6IG1heDE0
MDAxOiBOZXcgZHJpdmVyDQo+IA0KPiA+IE9uIFN1biwgMTYgSnVsIDIwMjMgMTQ6NDI6MjMgKzAx
MDANCj4gPiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0K
PiA+ID4gT24gVHVlLCAxMSBKdWwgMjAyMyAxMjowODowNCArMDMwMA0KPiA+ID4gQW5keSBTaGV2
Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+
IE9uIFR1ZSwgSnVsIDExLCAyMDIzIGF0IDk6NTXigK9BTSBQYWxsZXIsIEtpbSBTZWVyDQo+ID4g
PiA+IDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+IEZyb206
IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4gT24gTW9uLCBKdWwN
Cj4gPiA+ID4gPiA+IDEwLCAyMDIzIGF0IDExOjE34oCvQU0gUGFsbGVyLCBLaW0gU2Vlcg0KPiA+
ID4gPiA+ID4gPEtpbVNlZXIuUGFsbGVyQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+
ID4gPiAuLi4NCj4gPiA+ID4NCj4gPiA+ID4gPiA+IEhlbmNlIGluc3RlYWQgb2YgdjEwLCByZXBs
eSB3aXRoIGEgZHJhZnQgb2YgdGhlIGNvbW1lbnQgaW4gdGhlIGNvZGUgKEkNCj4gPiA+ID4gPiA+
IGhhdmUgYXNrZWQgYmVmb3JlKSB0aGF0IGV4cGxhaW5zIHRoZXNlIGJpdCB0d2lkZGxlcnMuDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBJbiBwYXRjaCB2OSwgcmVnYXJkaW5nIHdpdGggbXkgYml0IGFy
cmFuZ2VtZW50IGNvbW1lbnRzLCBpcyBpdA0KPiA+ID4gPiA+IHNvbWV3aGF0IGNvcnJlY3Qgb3Ig
ZG8gSSBuZWVkIHRvIHRvdGFsbHkgcmVwbGFjZSBpdD8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkg
YW0gbm90IHlldCBmYW1pbGlhciB3aXRoIHRoZSB0ZXJtaW5vbG9naWVzLCBzbyBJIGhvcGUgeW91
IGNhbiBwcm92aWRlDQo+IHNvbWUNCj4gPiA+ID4gPiBzdWdnZXN0aW9ucyBhbmQgSSdsbCBkZWZp
bml0ZWx5IHNlbmQgdGhlIGRyYWZ0IGZpcnN0Lg0KPiA+ID4gPg0KPiA+ID4gPiBJJ20gbm90IHN1
cmUgSSB1bmRlcnN0YW5kIHdoYXQgY29tbWVudHMgeW91IGFyZSByZWZlcnJpbmcgdG8uDQo+ID4g
PiA+IFRoZSB2OSBkb2VzIG5vdCBleHBsYWluIHRoZSBhbGdvcml0aG0gY2xlYXJseS4NCj4gPiA+
ID4NCj4gPiA+ID4gV2hhdCB5b3UgbmVlZCBpcyB0byBjaXRlIG9yIHJldGVsbCB3aGF0IHRoZSBk
YXRhc2hlZXQgZXhwbGFpbnMNCj4gPiA+ID4gYWJvdXQgYml0IG9yZGVyaW5nIGFsb25nIHdpdGgg
dGhlIHByb3Bvc2VkIGFsZ28gKGluIEFOIGFzIGZhciBhcyBJDQo+ID4gPiA+IHVuZGVyc3Rvb2Qp
LiBCZWNhdXNlIEkgaGF2ZW4ndCBnb3QsIHdoeSBkbyB5b3UgbmVlZCB0byB1c2UgYmUxNiArDQo+
ID4gPiA+IGJpdHJldiBpZiB5b3VyIGRhdGEgaXMgbGUxNiAoYW5kIHRoYXQncyBteSB1bmRlcnN0
YW5kaW5nIG9mIHRoZQ0KPiA+ID4gPiBkYXRhc2hlZXQpLiBJcyBpdCBiZWNhdXNlIG9mIHRoZSBh
bnN3ZXIgZnJvbSB0aGUgZGV2aWNlPyBJIGRvbid0DQo+ID4gPiA+IHJlbWVtYmVyIGlmIGl0IGtl
ZXAgdGhlIGJpdCBvcmRlciB0aGUgc2FtZSAoaS5lLiBEMC4uLkQ5KSBhcyBvbg0KPiA+ID4gPiB0
aGUgd2lyZS4NCj4gPiA+ID4NCj4gPiA+ID4gRm9yIHRoZSB0ZXJtaW5vbG9neSwgdXNlIHdoYXQg
dGhlIGRhdGFzaGVldCBhbmQgQU4gcHJvdmlkZSB5b3UuDQo+ID4gPiA+IEFsc28gZ29vZCB0byBw
dXQgdGhvc2UgVVJMcyB0byB0aGUgY29kZSBhbmQgZGF0YXNoZWV0IGFzDQo+ID4gPiA+IERhdGFz
aGVldDogdGFnIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBB
YnNvbHV0ZWx5IGFncmVlLiAgVGhlIGRhdGEgZm9ybWF0IGlzIHdlaXJkIGVub3VnaCB3ZSBuZWVk
IHRoZSBpbmZvDQo+ID4gPiB0byBiZSBhdmFpbGFibGUgZm9yIGFueW9uZSB3aG8gdHJpZXMgdG8g
d29yayBvdXQgd2hhdCBpcyBnb2luZyBvbiBpbg0KPiA+ID4gdGhlIGZ1dHVyZS4gIFRoaXMgaXMg
YSBjYXNlIHdoZXJlIEknZCByYXRoZXIgc2VlIHRvbyBtdWNoIGRldGFpbCBpbg0KPiA+ID4gdGhl
IGNvbW1lbnRzIHRoYW4gdG9vIGxpdHRsZSENCj4gPiA+DQo+ID4gPiBKb25hdGhhbg0KPiA+DQo+
ID4gTm90ZSB0aGF0IEkgaGFkIGFwcGxpZWQgKGFuZCBmb3Jnb3R0ZW4gSSdkIGRvbmUgc28pIHRo
aXMgZHJpdmVyLg0KPiA+IEdpdmVuIHRoZSBvdXRzdGFuZGluZyBxdWVzdGlvbnMgYW5kIGEgYnVp
bGQgaXNzdWUgd2l0aCBjbGFuZywgSSdtDQo+ID4gZHJvcHBpbmcgaXQgZm9yIG5vdy4gIEhvcGVm
dWxseSB0aGF0IGRvZXNuJ3QgY2F1c2UgYW55b25lIHRvbyBtYW55DQo+ID4gcHJvYmxlbXMgKHRo
b3NlIGJhc2VkIG9uIG15IHRvZ3JlZyBicmFuY2ggd2hpY2ggcmFyZWx5IHJlYmFzZXMpDQo+IA0K
PiBJdCBmZWVscyBsaWtlIGluIGEgY2FydG9vbiwgd2hlbiB0aGVyZSdzIGJhbmFuYSBwZWVsIG9u
IHRoZSBmbG9vciBhbmQgc29tZWJvZHkNCj4gY29tZXMgYW5kIHN0ZXBzIHJpZ2h0IGludG8gaXQu
IE9oIG15LCBob3BlIGF0IGxlYXN0IHRoZSB0aXRsZSBvZiBtb3N0IHNwZWN0YWN1bGFyDQo+IHBh
dGNoIHNldCBmYWlsIG9mIHRoZSB5ZWFyIGNhbiBiZSBvdXJzLg0KPiANCj4gSm9rZXMgYXBhcnQs
IHdoYXQgd291bGQgYmUgdGhlIGJlc3Qgd2F5IHRvIGNvbGxhYm9yYXRlIHRvd2FyZHMNCj4gcHJv
dmlkaW5nL2ltcHJvdmluZyBzdXBwb3J0IGZvciBtYXgxNDAwMT8gSSBzdXBwb3NlIHRoZSBvbmx5
IG9wdGlvbiBsZWZ0IHdhcw0KPiB0byBhcHBseSBzb21ldGhpbmcgb24gdG9wIG9mIEtpbSdzIHBh
dGNoIHNldCwgYnV0IG1heWJlIEtpbSdzIHdvcmsgY2FuIGJlDQo+IGltcHJvdmVkIHdpdGggYSBm
ZXcgdGhpbmdzIGZyb20gTWFyaWxlbmUncyBzZXQuIEhlciBkZXZpY2UgdHJlZSBkb2N1bWVudGF0
aW9uDQo+IGlzIG1vcmUgY29tcGxldGUgYW5kIGZvbGxvd3MgZGF0YXNoZWV0IG5vbWVuY2xhdHVy
ZSBmb3Igdm9sdGFnZSBzdXBwbGllcy4gSGVyDQo+IHNldCBhbHNvIHVzZXMgbmV3ZXIgcmVndWxh
dG9yIEFQSXMgYW5kIGFkZHMgc3VwcG9ydCBmb3IgbWF4MTQwMDIuDQo+IA0KPiBLaW0sIHdvdWxk
IHlvdSBtaW5kIGlmIE1hcmlsZW5lIGdlbmVyYXRlcyBhIHYxMCBvZiB5b3VyIHNldCB3aXRoIHRo
ZQ0KPiBzdWdnZXN0ZWQgaW1wcm92ZW1lbnRzPw0KDQpZZXMsIGl0J3MgYmVzdCBpZiBNYXJpbGVu
ZSB0YWtlcyBvdmVyIGFuZCBpbnRlZ3JhdGVzIHRoZSBzdWdnZXN0ZWQgaW1wcm92ZW1lbnRzLg0K
SSBoYXZlIG5vIGxvbmdlciBzZXR1cCBvbiBteSBlbmQsIGFuZCBJIGFwcHJlY2lhdGUgaWYgc2hl
IGNvdWxkIGNvbnRpbnVlIHRoZSBkZXZlbG9wbWVudC4NCg0KU29ycnkgdGhpcyB3YXMgbXkgZmly
c3QgdGltZSB0cnlpbmcgdG8gdXBzdHJlYW0gd2l0aCBsaXR0bGUgZXhwZXJpZW5jZSBpbiBkcml2
ZXIgZGV2ZWxvcG1lbnQsDQp3aGljaCBsZWQgdG8gbWFueSBpdGVyYXRpb25zLiBMb29raW5nIGZv
cndhcmQgdG8gc2VlaW5nIHRoaXMgbWFpbmxpbmVkLiBUaGFuayB5b3UNCg0KPiANCj4gQmVzaWRl
cyB0aGF0LCBJIHRoaW5rIE1hcmlsZW5lIGhhcyB0aGUgZXZhbHVhdGlvbiBib2FyZCBzZXQgdXAg
dG8gZG8gYW55DQo+IGFkZGl0aW9uYWwgdGVzdHMgaWYgbmVlZGVkLg0KPiANCj4gTGV0IG1lIGtu
b3cgeW91ciB0aG91Z2h0cy4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IE1hcmNlbG8NCg==

