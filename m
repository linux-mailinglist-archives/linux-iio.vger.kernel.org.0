Return-Path: <linux-iio+bounces-5638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872CB8D76DE
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FFC281B14
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A615482FA;
	Sun,  2 Jun 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TOUyYp2d"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2135.outbound.protection.outlook.com [40.107.7.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D133998;
	Sun,  2 Jun 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343385; cv=fail; b=aTIPOOka8VpXDAEnW9XP5r2xorADwAEnU8vyuQs65xNoFowwt04FPNvnHmIQH+r3bzZXVAFj/r7bsWrJPlFtEfXaIYMWDxznanCuhmqcIth6FsRddSgVEIXx7vrAgaSztecYTwLIztPXsdjq7/Gfb0xH2i2/h37LrcTvoDUjxUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343385; c=relaxed/simple;
	bh=I8c5Dmd/REgDEwT4s3aisaE/9M8JScc8cTBTcH1aYW0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jDZJy0cuwHs+XWO8YKdlWOtqtcnXKYAHWW/4sgHc7cLQTQISy53fDySsRN/XHAqELxCM6fXjDG9/AXweUansTw05YS/DOkNeYc8lMRrtC0sTKPJ/VGsCLLmOPO0EK30P6oMtlTWwrv5x/3YcGOJYSKARj9EOyM7Lpv443a5z8xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TOUyYp2d; arc=fail smtp.client-ip=40.107.7.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTBiZojMrdXa6eMRsq+iZ8Iv8XbDxZ8iE4rDkhFUkdOXJ0i0I+XrAKsw4BCVgiYuzUuoWuyG89qW8Ub1ZXzXuN5JwKdp4ODkpJiDaAclPO/ZzCLuQMzuVEyxVirMWX6GzDYg//E+NCaI0l7cDOC3syzTd/0OFIub9UFw0BafFPt7hKM12LUu06pe0Dli2dit559eK5WeEo7Io7i60yhSw8TQSmWnKFmE3mgbFZFSz7rIAIRALoe4A8T8pEru0LHJtll/fd8VcUJSQmKCUoocZjTQwWmFhtroqJ7hx6p11JR2jhAEIcFC6k7Pp6Dcm12SPxXAi0nJSREwTfe653X5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHuDlE4bz3Ri64XL5zF4+GOIm5j56U6XO6oNEWy+k7s=;
 b=K1G/N/apj2o2J/Rq7Pyee6QhT9acvc3tA3QwZO3opQu3bHiE3D6/OPJQjIbHbCeYaM61/AXedHXfbpHjkb3ZTyplzg1dWxBQ6Hl+qpw7zFdeflje1JHWpk+1+TdwWejQnhPWFF22kiWvIlq8JrscmVoAQFIJP/QyjjKipSiArJbwYkSz0RDVuPPBsTBlXkzU6GiSs4fLi6P71uoNp8Dlx7snQdPhnL9mnz+KjvhKrH8aA4yqNRpo1LmdAyVbgNFwmR5QBfu1HMyJGGRR6FPEgA7zQnNHgtwNbQ09nS9mfo9Mfmk4bu0cDF4Dviwc+YDaw1jU8at8Lpv9lm192/w9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHuDlE4bz3Ri64XL5zF4+GOIm5j56U6XO6oNEWy+k7s=;
 b=TOUyYp2dlLpurNhDYYQHN93l5WcGc0lct9JzUNnKdNMsYItsY/5ABDf+aUpzyUxLCWh/vMv0dmPI4bLmHtVtsm1hWrAw0dldTykAB3ruqhv7SQFtf9UKwmKD6pVeJg3R6cYqh8ghZkdpXO3WbGltS1Q7qvpjjp5GCZVrVoMipSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7512.eurprd04.prod.outlook.com (2603:10a6:20b:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Sun, 2 Jun
 2024 15:49:40 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 15:49:40 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 02 Jun 2024 17:49:36 +0200
Subject: [PATCH v6 1/7] dt-bindings: arm64: marvell: add solidrun cn9130
 som based boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240602-cn9130-som-v6-1-89393e86d4c7@solid-run.com>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
In-Reply-To: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Konstantin Porotchkin <kostap@marvell.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: e899a37d-3afc-42bb-4d80-08dc831b9ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjJhTk94WnlkdDVoSDBkTE1nS2l1KzFFMUJ0UGoyWDAvb0Jwb0tFZCtMbGZr?=
 =?utf-8?B?R3QrTXhXV2FxL1JkWFM2Rjl1Z1dQUTdtVGdWMzJKOGFjdlFRNTM0c0FaL1Np?=
 =?utf-8?B?TnlBL1owd1ZkRXlVY0I4YmtINzc2VzlPd2J2YVpGT2E2WUU5WUVGbWVpTCto?=
 =?utf-8?B?ZjloY1lad28yWngwSGducHFpSUMyTWl1WStFTWxyek5wcXNCdVNqSmIyRlow?=
 =?utf-8?B?RzBJOTBiT1E1Zyt3TWgwYkY1dU83VDUvRC9mdTdFZUpRWlkvNDBwRk9Fd21i?=
 =?utf-8?B?eFRtemIxRm5wZjVpY1ZHV1gvT0prRThLVGdqL3VDU2ttTTFmMGJpY2orYjJT?=
 =?utf-8?B?dWgzZjEycGpBWG5sb0J4RThLY1RMWkxpZU9MSGNZNGdDaU82QWlaOWhEL2pu?=
 =?utf-8?B?VHlOb0piN0wzcDBwQ0VnMi9weTVSNFFXUkhqeHZ2SW9GeWREMDBmMWh0Wnpk?=
 =?utf-8?B?SDJNMExmUDNaRDdtdllzZG5qcW9lNW5JSm03NlJON0dEaGpRUTYvSkRyRFhC?=
 =?utf-8?B?WE5zRmU5K1p1REpTOWM1OXFzNHNBTGJxZFIwSXNGTlREYzJ1Q09LcHNFVjV4?=
 =?utf-8?B?aTFuOGE4Ym9MWncxbGZ1L3NlblRKSG1ZWG5MMTJMWGtCdngzY2FwcEp4Z3FE?=
 =?utf-8?B?bGRsOElSeVVNNDBPdER3b0RpVGVvQ09WQjk2QWhKQzlwYzhEUnloUjRCS3pa?=
 =?utf-8?B?N3dRcktudXU5TVBXSWJ0czRXN1hlQWlaYUcrbmlMdXVvTG83bVppOXZFTklM?=
 =?utf-8?B?bmVYbG05SXpSK29UQlQxWThXd21nNlNIVzBsVVJucWo1c1pwdkdPSU4zR2wy?=
 =?utf-8?B?dktwT2JMT0tSbGNhZE1mWTFqRVdIdS9KaUJQSDZYWHhqMlFTaUkyRVVBdG5u?=
 =?utf-8?B?bEZKT0JLVGtXOEIwcXB0R2wrdTBsYXJ5NFpUNkFrbXh0eWFxbjRHMFdRaHV5?=
 =?utf-8?B?QTR1bTF1SlFxOEl4ZjVyOU9TbWNIdzYrMkVob1ZlWi9mZ0luaWRMaGtBbmZQ?=
 =?utf-8?B?SWhKalR1TGQwRWpKbUFUbzJmL2lGUkUrSStQNWZPWkczNHFxR0VJSllUVXpr?=
 =?utf-8?B?OTRjcmtyRzZBbjZ6bG5ieHBxNFFFMEE2bEZmc2xPY0NURC83Z0sycTAveFBu?=
 =?utf-8?B?ckN4dm5qVSthSVVEb2xTNWxxL0d6SERwNGtVNTgwSjB0RUpkQngxRjMwNm5H?=
 =?utf-8?B?MjRmY1BnQmRlWGtPVTIvaEZJcnpRRldML2I0em1HbFJKQTk0RndnNmpIbEhB?=
 =?utf-8?B?ZVdDOUhJUG1PNmx6Q1VxYWt2UEdRV1hMaHpTc1phNnd6aTdrRU5OcmhnWW42?=
 =?utf-8?B?N3JHR2w0M3MyQTJCYUszM1Y4VGg3SzVObml5SGN2NXRBNGtSZ3NVaVA5UkNJ?=
 =?utf-8?B?UG5aYSt5Z2hPNC9nZXFaRENqTkFzc1d5aGpzUUVvYTNGcUNlRE9YQS9tbFJ3?=
 =?utf-8?B?cUNmelJ4QlJqQ1B1MkxBcFd6bEFhQ1NiVXBQcGw2ckRDeVVDenl3MkMyVjBN?=
 =?utf-8?B?dE00WnpXaGZ5VzJPNS9IZlk2bmtrc2RnK3FqY0xMSEdLZXBmMmVORGl5U2Fz?=
 =?utf-8?B?TFJjR1U2WWRnWTdvblhYVjFSazlRWE1PdTFZNS9VcTA2MGh4YXhXdHorenpj?=
 =?utf-8?B?SWdOWjU3bkkvWlorRkxneDZ2NzdCSGRFYjZ5WFBPZWdjOW50RXJHU1NDWWZm?=
 =?utf-8?B?eG1yNWhFQ0YvcGZCQ3hraXFaYlFaQXdsRVJBRWxQNnMzYS84bkhFYlhDYmYz?=
 =?utf-8?B?MjlqQit5ekowN1h3SGdLem9sbHJQTnNWaFBBWE9IUkJjN3VkN3RqUCtUT01Z?=
 =?utf-8?Q?hE+GjWDuwgYn/CeXGx555nH8C57SzJsx0inro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHlXOUJBN012bHVMVWNqSW4xbHM1azZpTjNhSHlIU3d2Qno0RE5wQzduZkE2?=
 =?utf-8?B?WTU4MkwwdFBXdEJNNjdRc1hBZUhjSDRuZkx4aHU5UXhxQnN3LzljQ1ljUWRr?=
 =?utf-8?B?aW1BTHM0aUFlR1BCK2VZa3RBQTBRT1VxL1ZYT0hMN29hbGtaenh2a1FMU0tF?=
 =?utf-8?B?UE5YVXI1TE10SElvK0QvaWpNSVIxWncxRVhwZVNVMW44a2NBZld6dXJwcHpn?=
 =?utf-8?B?ZTR6RXZvb21zTGN3TGtJNjBpUzN2MmYwajRqVnNDVUF0UHRmMlA3cXFBdmU5?=
 =?utf-8?B?T2U3U1IwRDVIeVFvdjN2ellsUmRXNDlhYU4xUjMvcU03bWI2Wmg3ODZOM0lu?=
 =?utf-8?B?NVJpZDFXUFZ4QkdmVDBOVUM5REQ4TGRJeVVGaThUakxCcEFRRnNBdlJyOXY0?=
 =?utf-8?B?V2dTWDJIMDc5Qm5NREVBYi9JKzNwTHFqa0VTVGY2Z1NxaEhZUlJ5OWZ4SlVh?=
 =?utf-8?B?VGhNdlovZUp6MFNJNGx0akVOQnhTM2NTUWd1MlNIa0lDU29lOFVsNndHa1R3?=
 =?utf-8?B?eDErM0xrb0NUclFJZEgrc2FEZjl6RnRDU3FzT3UrdTN2OHlLYVpXY0UvTnRQ?=
 =?utf-8?B?czJZa0h2NUFCTTJsSldWRVFyZmVkTmd2a01ieWFSNzNmVzR6MmU1WDNUOW4w?=
 =?utf-8?B?WTJ3UDUxUjF2aENDbDA3d0tkS1FCNGRtR0tXTGVlenJXMm9xSGd5YnhNdnRX?=
 =?utf-8?B?N0VwVlhjT2twTVRIeEtwSng5Z3FKUnBQYXU4RkRMUkRsVmJnanMxVVlWb0Rx?=
 =?utf-8?B?ZjE5WHlZU2U4QzNHbGhrWDQvWnJlZW1MMjQzYThQMzJXYVBhN0FaQTExWW5C?=
 =?utf-8?B?RExBYURzOW5iK3ZGTEVzMTVXLy83N1I5RG4yRTNHeXQ0cTdUdUtibVNGSXQz?=
 =?utf-8?B?dDN0a0ZGUGpHSmRRRjVEbDFSWkREalo5U0JTdTNCQkllazFkaEJ5TjhLZDJU?=
 =?utf-8?B?VDNNZzNsSDluN2Q1ejFHSmt1d0V6aU9tNmE1L0ZwS09tNHdTeVFhYmJOcUlX?=
 =?utf-8?B?N0M2SFV0UmpLbEhjVCtWdzY1cUxrMDJWQmIzYXlGL1crNGdZMU0zOVhwdEZK?=
 =?utf-8?B?c0w1czUzYnVacHFwZElsNUYvcU5DOEVSQkNUMDJ6QzZ6VVd5MDdmdGhrenB1?=
 =?utf-8?B?T3lTbzRBQ3lRMUFYcVhIWngxaFRkRWVYaUlPUXQ2U0d1UUo1c0lkYmh3RHcv?=
 =?utf-8?B?Q3VFRDczdzQwY1BvbDFWTkw1VG5oWjJvTWNEQ0QwSlpRcEJCY2JqYVNOY0FH?=
 =?utf-8?B?NHdEVW01R0l4UE5GMFl0ZWFhak13TFFydkdrM1ZweU50Q0FJMWgvOVNTMU03?=
 =?utf-8?B?Kyt4SVUrOUFmVVliUGhYdVZ5anppODVRdmt0S1JhRkFoc3Z3Kyt6K3JydlF5?=
 =?utf-8?B?MHBQQVRKTGFtK0JqVXJvb3ZhVjFHTUl2MS9YTkRmWUE5NlYzR0EvK21zK0RN?=
 =?utf-8?B?MFJUaFZ2NVhoUG1ucGM3SWtabVNxblZTRFQ2S1grK1RrYkw3c1JQSGRUOVF1?=
 =?utf-8?B?dk5RYlFLUFBQeDdrODl1QlorSUg4dzNLdWdPVzQ3ZEtPejcyejFQQmhqaEFU?=
 =?utf-8?B?cWp2elR3YzlZeEVWRmFOV0NxV1pmSXhSYmdpekFlT2dnbUVkMXBreHZISkxC?=
 =?utf-8?B?a1VFTHhVMTI0Z2dLYnl1WExCKzcyV2h0SHFhS3hSRGxzbW02RktuMmpnZldu?=
 =?utf-8?B?SHdrNVFQT1dESEhZMExtQU9uM2FUbFRmakhGdFhYY04xZEN6M0VsMmFIb2I2?=
 =?utf-8?B?NlhLOW5ZV1lQV05iV3l0YnAzK2FWYy9YYnVMYmI0Ung2SUNkcFJXZ2drc0o3?=
 =?utf-8?B?OS9qRGNueWVuQ2U5UGtzYm42TEFKU0x2ODV3NEJQRFRPY25CL3dOMTIvd3Jk?=
 =?utf-8?B?VEIrRDRTbXFPRjhZV3V2USt0Z0hXbzA1ck4rUjhOQUdaeXp6bDZhRFNVWXRp?=
 =?utf-8?B?UGhVSFI3YnBsYU5QRzl4cGxaU3NYdXJuYUZUVDF5UVdaSlJjcDNqMys0ajI3?=
 =?utf-8?B?a2RaNkwxd2tLMzE4OUJTUElvMGRYcmxKWEUycFZLRGZHTHZ5d2YxNlpiQ2tI?=
 =?utf-8?B?RXBMUG0vWi9vMi95K3o0Skg1eFg1a1crdlAzd1VUSnUzRnZkc3BtRDdQVHVo?=
 =?utf-8?Q?YhBuXKNEmhXkAty4oHb9MCijr?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e899a37d-3afc-42bb-4d80-08dc831b9ce8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 15:49:40.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lKkpfrEt2qugn+cvlFCtpaUdtqJPIja/FnVwHJWQbthgJScD9t+K1B3CRQz1fINW6IiJbySi33IzcQzk1M0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7512

Add bindings for SolidRun boards based on CN9130 SoM.

Three boards are added in total:
- Clearfog Base
- Clearfog Pro
- SolidWAN
The Clearfog boards are identical to the older Armada 388 based boards,
upgraded with a new SoM and SoC.
However the feature set and performance characteristics are different,
therefore compatible strings from armada 388 versions are not included.

SolidWAN uses the same SoM adding a southbridge on the carrier.

Since 2019 there are bindings in-tree for two boards based on cn9130 and
9131. These are extremely verbose by listing cn9132, cn9131, cn9130,
ap807-quad, ap807 for the SoC alone.
CN9130 SoC combines an application processor (ap807) and a
communication processor (cp115) in a single package.

The communication processor (short CP) is also available separately as a
southbridge. It only functions in combination with the CN9130 SoC.
Complete systems adding one or two southbridges are by convention called
CN9131 and CN9132 respectively.
Despite different naming all systems are built around the same SoC.
Therefore marvell,cn9131 and marvell,cn9132 can be omitted. The number
of CPs is part of a board's BoM and can be reflected in the board
compatible string instead.

Existing bindings also describe cn9130 as a specialisation of
ap807-quad. Usually board-level compatibles stop at the SoC without
going into silicon versions or individual dies.
There is no programming model at this layer, and in particular not for
parts of an SoC. Therefore the ap compatibles can also be omitted.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 16d2e132d3d1..74d935ea279c 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -82,4 +82,14 @@ properties:
           - const: marvell,armada-ap807-quad
           - const: marvell,armada-ap807
 
+      - description:
+          SolidRun CN9130 SoM based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9130-clearfog-base
+              - solidrun,cn9130-clearfog-pro
+              - solidrun,cn9131-solidwan
+          - const: solidrun,cn9130-sr-som
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


