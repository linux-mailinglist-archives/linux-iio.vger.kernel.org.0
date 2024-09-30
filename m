Return-Path: <linux-iio+bounces-9913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C4989BF5
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870391C212F8
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 07:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7B166307;
	Mon, 30 Sep 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ojIycvE2"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041A208D0;
	Mon, 30 Sep 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682892; cv=fail; b=AWPEpsOlC+5ghyrl0TUPDXE3HNUijXikgMPUu3XbScDe4AG7qD+n+rxiWx/QZzBu27sCNGpxamGRt/iD6iG8sujas8cpQxMV4TF8umejBuKlA4iUlqUKJhB+1pSM3Ojo0+nAjagFDyQylSosWYljv6yks83yt7+tv0MPH1sbZLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682892; c=relaxed/simple;
	bh=f+SXfWwy2gMhJmJhX8j5xrfBO8ymZyVKYIxg2DKZncc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pQatWAhJRODi4aDs5PPwVXSiMVhANC3o3n8xpfVFps4CQroNb+nQI8FLgX3XLLpuILQAJjkyX/btOR1zqMYSmlk2gipEfuK+eGO23o1Fl0vH8kbmXlZ6UY5RiNiw4bTGq1WE5MAPBmlZELlrtbnZOJDJtW4mwsbVKUcfvn/71aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ojIycvE2; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJbOpJw/JXvu9YFXpu3sVscWr1+d6ftX8NB0Ls6ZndO8/2p+anVSTmTRQKLLt66H4YYDCMjgfHhTmFzUSkvf/iqzSGNlL6g7G0wagkCyPcKC0Dg9b1Au3uHP/OCLeIQXUeyaOLJZy8hOkQR/NhvkxfqBH4jRnbW23DcWVwfR6jV2xIyo8dnKfRss+p3frTTrEgjfN0Tk6jKL4X+JW3G2/Z+0vW2pGjHFXz3euIKsnIk2K97axifyETOBz1XFfvEWJxNaZP3UyBk5pP3BTPBOwal+yRgPchVtwbXv9AA0tmdpw64QBcI2fkWcm3DlADU6HO0Q6E2cidjBe4cUl/I7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+SXfWwy2gMhJmJhX8j5xrfBO8ymZyVKYIxg2DKZncc=;
 b=STJEQdYTS371cvXFYG9ek7vc7egSlgngEytRiXS3co6Equ37cilWm55/BokQAPw5yq2BYxDP5AXX1x6zM/NAOTYYlckFUD7OW5RJccvpHt1FuW3yHUBz9/hdTK+QeUFh/7Oh6Y3DdjOSmR57/icdBhErwEYPXwi81khcr7PREPPY0Xdd/3l9Vb8Aev0ztUUgwogwma+DcsWZQzdkHit55L4kyc5wfPhFQdso1CIk++ESyY3zTFp/nej5dIOLGgTf0ovXdld2S+x96NnVL6HYdofBtPzOCQjyOn9xCsWtUipIkjW4liSx4sVsUqiq1gZtzhblrEtAjXZgXTAr77Bdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+SXfWwy2gMhJmJhX8j5xrfBO8ymZyVKYIxg2DKZncc=;
 b=ojIycvE27R5diVy8p9T6UD2fZ/2ra4T7fyNaESiFFDb+XmdhBm3K7eG/tK0p1lB/uCotmo4mwxBuV1L8IhQlcHTE7m7n9hRM6i2rSvHcOItyqbXhgNrervIMsje9WRg6TtFetZS72cExnK3DVcyqA7YchHrNUYPA3HNTwlkIz38=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by DBBPR02MB10700.eurprd02.prod.outlook.com (2603:10a6:10:53c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 07:54:46 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:54:46 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH v3 1/3] iio: light: opt3001: add missing full-scale range
 value
Thread-Topic: [PATCH v3 1/3] iio: light: opt3001: add missing full-scale range
 value
Thread-Index: AQHbCEjHuGBg+pINBkW9qMRbg4si07JtbbWAgAKdwgA=
Date: Mon, 30 Sep 2024 07:54:46 +0000
Message-ID: <bf39ddb73f2c0f823f9712a38614964e9b308822.camel@axis.com>
References: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
	 <20240916-add_opt3002-v3-1-984b190cd68c@axis.com>
	 <20240928165737.6ed1e4ff@jic23-huawei>
In-Reply-To: <20240928165737.6ed1e4ff@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|DBBPR02MB10700:EE_
x-ms-office365-filtering-correlation-id: 0a50dc13-9ab1-4df7-faa7-08dce1252729
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ui94dkxLWVFnNnM3QXJUWVluVXZQMm5PTWlGTno1VldsQ3V5cXNtM3J1ZmVk?=
 =?utf-8?B?Q0VJV3puaTlXMk5PRFRkUUxaZFpIcGwyd0ZmYW1UM2hjWktkTisrQnFzOUtR?=
 =?utf-8?B?WC80RFIrS3VSYlRuRkZEV3hZUjFLUno3bnplWjlhR3lRUktWVDJCU1JUdHhs?=
 =?utf-8?B?U2NZYUtrbDh4bGtXWS85WFRqbUg5bkkvR3puVUNIUTZNd2VMK0Z4WVYrTnhS?=
 =?utf-8?B?eXdlcnQrQ2VGUlVwSVpRdkxQRU1NRlpLa1VmV0taUkpnL2Y4ME1LTmY1UHlr?=
 =?utf-8?B?Y0gwTzBKdVIrcHRteHRJR3NsZ01lcU1wdVlmUFlUditkSkdyL091cDYwdVFH?=
 =?utf-8?B?ZGxHaDU2bzJMK0Q2cVBCOGVGYmRpY2NHS0xla1lqeW9nWHRmbkRZODBmWFFU?=
 =?utf-8?B?MGlwOXYybXI3RDVDaXpoV3BLNkxYZ04zVXhXMTZkeVJCTlNLcGxySjlndzZO?=
 =?utf-8?B?dnRjZGtnemJjVHhxVXJYcFdHNDRONTAxbUw2UStEOWFmNE1rVlpNTERPU2Fi?=
 =?utf-8?B?aW5ObTZoSGtSVlc1QkxkMk1Yb3FvQkQvaWFOdGlzalZiaEZqMUxsQzdwdlQ0?=
 =?utf-8?B?aDlKVlpoSU5wZFlKbkNWd0hvdElFVzlPVGx4WVlBUzZoTDZ3UHVTNFlXeUZL?=
 =?utf-8?B?cEZqcHpOUkx2QnVnVFdYS2tOZkRuVXBnWkttQzBqODFaV3MzRklQZFN4VmpC?=
 =?utf-8?B?bTdOK3NkZURrM1RzUXpqWnBiaTB6dWlQVi8zYkpMRGNFc3hxV1pzbGVYdWNw?=
 =?utf-8?B?cnlWVzhaSDkrS1JVUFFIUGl5d3E2aitVSFN2RFZZU1Y0aGNGYUdCdm5YZGl2?=
 =?utf-8?B?Y2JLZE1HLzREM01tYVl1aHlTdy94OEIxYnRZTXh1L1Zvb3l4dDhqMWJIczRh?=
 =?utf-8?B?b1BYNjd4NE9SUGR5Sm5Cdkh3NUdmZXFWUndPUVo2Z2I4QnRlR2RrbFg3SjhZ?=
 =?utf-8?B?a2h6VmsxenVqZVp1cTNtd0QyVzdFMlNZY0dXNy81RzRrWHZHZm4rUjJkSjhi?=
 =?utf-8?B?TVhVWDNGNHl6RnA0UWpPWGR1Rm1iT084eEhldHVrazlWZUxzbUd0TlVhSC9v?=
 =?utf-8?B?QlQxQ0tHTlRKY2xIdGNkeStNSVArbmdYRDBIRlB6UlQ1Z2ZkZXJVMG10S2o2?=
 =?utf-8?B?SnZQbzgrS1pMWU9qYTJ6ZEppajBCd25rSjR4Z1RaK0Zoc3RKM3BMZkZjVXpy?=
 =?utf-8?B?b09uY1I4VjFxQlFkcEpNdHBicHFEeU9DMWN1bVJXcm82VU1yNC84VDRxZmlq?=
 =?utf-8?B?ays5dHJ3MEpEbGdVQUY4aEQ5RStRa2xlSDEvdERYeVgzcU1hTE1LMlY1MnJN?=
 =?utf-8?B?V2ZUSng4MFhkUFEwZ25ucDkyS0Jxc0w1bnRKTlpaSk9WMjI1Y0E2OE1oNE50?=
 =?utf-8?B?Uld0aVkzcGpmL01yWHJiUWpBUzJUMHp1M25XZGpWemdhVjgzTk1lZktyc1VY?=
 =?utf-8?B?dUFVVUR0YW5RSE1WZmdNMjFHTENFTU12WGlJMFdFMmgrKzR3cTB0RWdmQ1NY?=
 =?utf-8?B?aEZDR29tRXQ4VS84YnFJRFBzVjhxVU1tdmhCanRZSmlRamJLVUxtZ1I5OElH?=
 =?utf-8?B?OVlUWk8zTGRjUWM0UDBYcHdqNVJQRDYyZzFvNVJUZ0tCOVpCQjRTTjAyUTJV?=
 =?utf-8?B?N0pSMml2WExUcFRxaUVlRUpLVGNhZ0lscjEwbGk4aVF0bkQ4TksvVVNOOFhC?=
 =?utf-8?B?WldpWnAyL1pMV1N6RTVtTi9xVVgwNHdRVzJ0YlNCYmRGMlU4L3dNNU9SWnlV?=
 =?utf-8?B?QzRPTHJHdjdrTkhBUlpVYzNvZWM4ZDdkdEVIWDVmVUZzQ2Y1YUppM08zZ0RP?=
 =?utf-8?B?Zi9ETys1VlFFREVDa0h5Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGdHTkg3MTFpWU41QlYwVzRMZTRoamp6dXVQWDdQdEN5UXR4bE9PK1RYUlF3?=
 =?utf-8?B?RGtWYkk2N0tVRm0xVWE0eSs5dnJscTFhdmcxWGRWZlpuMnY1UmZQeVFGTUlL?=
 =?utf-8?B?TVNwRlJITnBVVDRpVUJzOFJiNGNrVEZLWXE3ejF6b3Nod1dDV2oyT0hGVXNl?=
 =?utf-8?B?SG1DUk1zMHh6NnlscldoVThJaTRQR1RxRktQSlpBb1MzclNYZmdyM1hhdDNa?=
 =?utf-8?B?UDB5V08wSTlZS29tbVhHcVJnNHlWeERjMkpTV1djTG9sQXh4NCtHQkVSZWJh?=
 =?utf-8?B?VmlPQU5rVTlicW84MFIvc1pIYWxvQlE5Mys1OVU4WndrdC9QUHZ5NjN1VXNv?=
 =?utf-8?B?R1AwQ1VEMmJxY2tFVDZ2SkdkNUREVGYyU2dWMFZqa2R0UkI4RlR3WEYwTnVZ?=
 =?utf-8?B?WnRMUmhqZHdWbWFhK3g5MmduNXlhczdkaTZ5QjVoWTQxUUIrR1BGenZvMmdY?=
 =?utf-8?B?R1FpK1NDTGJlYnB4VmZHVnpKa0Z4VU80OEdlbldBU2FvNkFFaGQ0QTRVWFhh?=
 =?utf-8?B?R3g3c09nSFJWM2ZhN0czSmxzL09LTktRV3FVeGlXblB6dmR4SEdwc0ZNcUxj?=
 =?utf-8?B?T1owNnFDakk3NFN3YjNGT29zazViRXZrNUQ3QXkvSHAyNGtyV1NvSDNKYVJV?=
 =?utf-8?B?NXJnd0NHb2JsWlRoNnEyM1lZRTVhZ1RYaTE0U21tc0xLbUFnbTlvZjlIcXln?=
 =?utf-8?B?QzF6MjBsR2lFK2htaXJCZVJzV3FTcG02TmRnNGVES2x2MzYzTzFBWXNDall4?=
 =?utf-8?B?QjlPS05YYmQ4Q2dzQWZYSmJRVVM5Z2orY21IdGxlR1hGazk1QjNQUGEvZFd0?=
 =?utf-8?B?UUtCSUJMSGlKdmkzNkh1N2poQlBKOXROcjFlbExKUXJKWEtWTjFIWHBpWHJh?=
 =?utf-8?B?cGhTcTR2cFpNSVFrMlQwVndITTZXbG03dGZjNEJablVKbFFwZ0pEUEVrRzhD?=
 =?utf-8?B?MDhXTWNXUGZLdXNkL1E2alJYd3VnNE5SazNaSXhTOG5pVE0xN254VHZSeDRp?=
 =?utf-8?B?VFZMZDBpeTZOUUVwMngrWWMyKzF3TjZDeWh5dmdHTDRoYmhNanNIOU9WQTls?=
 =?utf-8?B?eVBMMDR4bjhyNXJwUjhvcFZUSHhPR3A1MTJoUFhHUU9qcXRIMXpDZmg5aS9q?=
 =?utf-8?B?eFJ1djh4eG5rbzZtQUNLd1UwaWw5d1BEQ3BGK1QvdE8vTE5TM0tlRkZNWndF?=
 =?utf-8?B?M21wMnlNa09ZY2M2SEVzcFRXaFlyMGxTZWQ5UWFTRmNtdjBIQ2NPQlhzYklB?=
 =?utf-8?B?QldYdHRWNHBaN0s2ZVN5U0NQT2JrdWp4bGYvUVFvNFZ0WmZMOEc0WUNuVGQ0?=
 =?utf-8?B?VlZnaDlENXBUQzZQTnFRZXErZHphenFqdlV5VnlWVHRvNkp2MjVvbXhSVXUv?=
 =?utf-8?B?SFozYzR1K3FjUHNSZWFYTFM4TkZzSDBYYVhtUjdvaEsvSXJBYWFiQXZybERk?=
 =?utf-8?B?TlV3dHRMeXM0ejZzblJ4NHoweWJYWnBETHNIV0ppdzVNMnIzV2g2SXkzSDAx?=
 =?utf-8?B?U0h6NlhFZUJwa0lGODIvR1dWemhmVXhEUnVnNCtnY1pOdkdvZjFWbmhzYmRQ?=
 =?utf-8?B?Z3N5aklXMEMvdEpORzh5NXZjOXNPWUFLNTJ0eUxQeW5XcGhoQ1U2Q2RhaWpO?=
 =?utf-8?B?bmVodFpBZjBrWHJ0OTQ5emlDZ216Q2t4MTk4ck1yTEpXblFoOVRpK2FZTENP?=
 =?utf-8?B?bmNwQUliSkpNK056OG1mVjk5OTdOcUVWZ2thckNtQnZRN0NWdk8veVFFNHJ1?=
 =?utf-8?B?NWhYeFFFZUpYZ20wL0VRTjAycWMxS1RJL0pmMXdSWnRMb3crQk1oemJoeUI0?=
 =?utf-8?B?YktnWStsMEtheHJVRzFhUE9qdjZFWUJOYjR4RHFjRGNveXIyazNTb05YUWZE?=
 =?utf-8?B?VVB4UmxHWFd3TkhQZU8ycFVaTFdNSTZaK0xyZkVUZTNpS0srODdxR1EvOXVO?=
 =?utf-8?B?VzRnTXpvL2tYTGtvYlNCYTBpejNKRmhJZmZ2UnhpOU5ReUoySTZRQmh1dDE0?=
 =?utf-8?B?TFp3MDk5dWtSWTVva1VVVEpvRWFUOVI2QUptSGJLT1VBd2RiUnJ2ckl1bWVm?=
 =?utf-8?B?NTZTZHVzcnl1cnc2bHpvWEJIRC9YZEg0VDhURzd2ZWQyRDNXNXhSUjZ0N2Qz?=
 =?utf-8?Q?v9hfXDQO6zbw0ylwwQoCW0QkP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <858EE5862B478043A1F9E9C9202CB344@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB5784.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a50dc13-9ab1-4df7-faa7-08dce1252729
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:54:46.6273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syYRvQdJFvR7ii7NLRO/b1ash/rx72DaITVdRBIDsJ6kPubKoE5Huj89ELDT5Idr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10700

T24gU2F0LCAyMDI0LTA5LTI4IGF0IDE2OjU3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDE2IFNlcCAyMDI0IDE2OjU2OjM3ICswMjAwDQo+IEVtaWwgR2VkZW5yeWQg
PGVtaWwuZ2VkZW5yeWRAYXhpcy5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGUgb3B0MzAwMSBkcml2
ZXIgdXNlcyBwcmVkZXRlcm1pbmVkIGZ1bGwtc2NhbGUgcmFuZ2UgdmFsdWVzIHRvDQo+ID4gZGV0
ZXJtaW5lIHdoYXQgZXhwb25lbnQgdG8gdXNlIGZvciBldmVudCB0cmlnZ2VyIHRocmVzaG9sZCB2
YWx1ZXMuDQo+ID4gVGhlIHByb2JsZW0gaXMgdGhhdCBvbmUgb2YgdGhlIHZhbHVlcyBzcGVjaWZp
ZWQgaW4gdGhlIGRhdGFzaGVldCBpcw0KPiA+IG1pc3NpbmcgZnJvbSB0aGUgaW1wbGVtZW50YXRp
b24uIFRoaXMgY2F1c2VzIGxhcmdlciB2YWx1ZXMgdG8gYmUNCj4gPiBzY2FsZWQgZG93biB0byBh
biBpbmNvcnJlY3QgZXhwb25lbnQsIGVmZmVjdGl2ZWx5IHJlZHVjaW5nIHRoZQ0KPiA+IG1heGlt
dW0gc2V0dGFibGUgdGhyZXNob2xkIHZhbHVlIGJ5IGEgZmFjdG9yIG9mIDIuDQo+ID4gDQo+ID4g
QWRkIG1pc3NpbmcgZnVsbC1zY2FsZSByYW5nZSBhcnJheSB2YWx1ZS4NCj4gPiANCj4gPiBGaXhl
czogOTRhOWI3YjE4MDlmICgiaWlvOiBsaWdodDogYWRkIHN1cHBvcnQgZm9yIFRJJ3Mgb3B0MzAw
MSBsaWdodCBzZW5zb3IiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEVtaWwgR2VkZW5yeWQgPGVtaWwu
Z2VkZW5yeWRAYXhpcy5jb20+DQo+IFRoaXMgb25lIGlzIGFscmVhZHkgcXVldWVkIHVwLCBzbyB5
b3UgY2FuIGRyb3AgaXQgZnJvbSBmdXR1cmUNCj4gdmVyc2lvbnMgb2YgdGhpcyBzZXJpZXMgcG9z
dGVkIGZvciByZXZpZXcuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KDQpPa2F5LCBJ
J2xsIGxlYXZlIGl0IG91dCBpbiB0aGUgZnV0dXJlLg0KDQpUaGFua3MsDQpFbWlsDQoNCg0K

