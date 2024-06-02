Return-Path: <linux-iio+bounces-5642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB508D76EE
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1A61C21030
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919F16EB73;
	Sun,  2 Jun 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="N9PREV9q"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2131.outbound.protection.outlook.com [40.107.7.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5665C8EF;
	Sun,  2 Jun 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343392; cv=fail; b=Xqa90XJR3/R1hjyISqqPTC1yipN1n6Ho1PIx/o7wAdoto8Kmc96xpZLOsWYt29F246JiHFOSVCvE3PqOOIz+4wTe4Z/35mT3o4CTGPuy4ANh6wZI2QNMBcFYvbC3EzH7UQabuL+nXaZHtCceuJZJA8dB5sS/ChS+3hY1FLFHMUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343392; c=relaxed/simple;
	bh=CEIBsEFljojeZjz/s+YDMmYSmFeOV02bIg97iowxDfY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CXSmUQEA8ghbEOTakheim4J+y/j9M0dYOvsq7qd/ajBp0/oMbkmm3z/yed9eHrERR4LCBB+KwYau1nGjSoqvHezQPVCtws6GEeVsM09O95XuQ+X7RczkZNMC7yEDYFx3NV9v0Sy3Bhzoy+yyfemZzRksODg/eLwYCFPxqoTawxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=N9PREV9q; arc=fail smtp.client-ip=40.107.7.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp8pqivAUYYw2/2IpQHz6WGJYs7txi8+UWOJnWDxLF7Ijh39cVCNgVjsVVDBPg4vU8kQRo4dkbm+uV76NYNzUByOlODWGm8CNsm40LlLK69+rJiE3v7DOO6WfGOeS06Sq0rHafQuiFzmJMhm/bzNs+bAHVgIyE5SGSIMdhnawpxq3IVvcutWxy+dl3SuxVPEYycaz5VUAkMfoUTc/7yJF8bUpsulLuhZPduV4ZTkxo9FO0E99LgNcI2JuvVmrDoq8WH8fl3W2oCiWdvxk4AkGRq57J/+o6R7y+TZVxLON7h8BYLHzMH9j8to1a2WaMJNJWeFNpM16by5vAgpq2LXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsQ2tPYDa/IflA4OktRsyhUESw5IPzrDFP158irF8wk=;
 b=Id0RdSOuRVHeuQN4YUHpqO7pkQCj1+02iSFFuMNcWJau8JSjjydNpw141RCQwiRsx40L/e/KzAqyWrVG1oZ5fdbAcmGpgko6bW0ReQCowJkV5BebxaJdXnRxaT14EU6LzR2djpFzZsVWndKyn8jyGzG+rqNc5yNa29yRbn1YFqDTBQLnrgjThp2kpyC8cGU//P3wAItztlGDJylqTW8Smw0izt2owk9Qaz8aq0jRlnxOWw1ZU24jnzma0Nc9sHvsBI22qY9cqj9Yq5eCPzfL8JKvmIeFoacRinI+1DWVLFpfvM8eyDh6pWn1a+6ql1gGZhj3mPWl0uKN+CPSmdRvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsQ2tPYDa/IflA4OktRsyhUESw5IPzrDFP158irF8wk=;
 b=N9PREV9q/QOGOBY1f58+6V39ZnSjqP1RRRpfUBRqwAuMfCqVev0N2tHXIBVpF2TCTUi0oaGjJV/pwaJz+N3b8elTDjl4rvvxBZyVWgr107xYQQ0nOgeVzjTycSB3AapUMks5rqUh8BoOB1z4te71+GrmmRLdp8BMHYGM32gOWBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7512.eurprd04.prod.outlook.com (2603:10a6:20b:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Sun, 2 Jun
 2024 15:49:41 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 15:49:41 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 02 Jun 2024 17:49:38 +0200
Subject: [PATCH v6 3/7] dt-bindings: iio: adc: ti,ads1015: add compatible
 for tla2021
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240602-cn9130-som-v6-3-89393e86d4c7@solid-run.com>
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
 Josua Mayer <josua@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67b8dc65-7832-4a5c-aed2-08dc831b9dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkVqbEVmTnZUaWtpckI2cmc5a0ZRbjlIQ0IxQUtoNjZkM25CVmlaZGFFNFVW?=
 =?utf-8?B?Snp2dWEwMEtWQVBMNlY5cTlWQjNkcDNPVG1uTHdzNEpUU2VSQ3cvMVN4cFky?=
 =?utf-8?B?RFMzYXZTTmQzR2YwZDF3VjZsdDFTSmh6ajV2K0dSZDRCTk9nQkVHRmVmaTZF?=
 =?utf-8?B?THI2RHRYY0RFQ3U1K05KTVcyb2t4TGs2UWQwSFExUmQrZGt6KzBHbG1ETHdV?=
 =?utf-8?B?cXg4MUpkS1lrSGswdGhjUE5KNS9VQUl1VUFadHplVjJWd3BBWmVzWHlBT2ts?=
 =?utf-8?B?TGFHVXFNeGErUnFhTGRLTnVNNXUvdTdyeDJLbVg3dU1NZ01YcGVCOVgrckxY?=
 =?utf-8?B?Y0pZUVozWGhUekt6czBDQk1xTkxvdldOQ3FJdzUwUk9xbVVSK3lLNU1BSnBH?=
 =?utf-8?B?dmV1RUgyNVNSOGl0K0E0TEdFOG9EWUYzQ1RsQlpvNFU2a241UWhndDlIalpy?=
 =?utf-8?B?TTIzNWdjUERPdzhmVCtaQitMaEkxV0JaclU3N0hmNjREWVI5RkJCTTNsekxx?=
 =?utf-8?B?VGlUVXk1MG9aRFhib3loNjFTZ3hkakR0R2VMZE9aTk9zYVZYUlFWbzFHNzlX?=
 =?utf-8?B?RFNqS1l3TW5kREtXbmkrbVRKQ0grZ1hDcUd6NEpoTHpJRWpXMHFYVWRmVkt1?=
 =?utf-8?B?d01PL3hyR3dHd1d6Nml0TWdMbjhzWkRWY2dvV3lBMGtHbzdjM050UXNlRzBR?=
 =?utf-8?B?dDAwSExpZ2xvTm8ycFV3MTBGekpHbWIwOEI5K29xR0V1VnZoOWUyeEdrVjFH?=
 =?utf-8?B?Z1VRT25YWW1YaDR0NkswNFZLeitWWVpGUHJWalNEdElodlQ0aitkMm5YajV1?=
 =?utf-8?B?YmdNVDA2ZTdEUWRaZnh0eDgvN0VmRlc3TkpFUkRyb0tsQmJ1YzZvRFJhcVM1?=
 =?utf-8?B?ajc1aVVNNU9rRjVJSVZINS9jTzVMdGtBWmpDeDRhRjdwdG8rQkhXS3p0aW5z?=
 =?utf-8?B?cUlDRmRWWHVSNk5ob09LMmNoQlYxTlloWFRvSWFhUGhoZm4wdFJHQ21La1VB?=
 =?utf-8?B?UFd3S0ZpdDQ4SU5yRGE0azJnSS9xSDhuUXFPcXVUT2N2eElXOW1UelJLVGpZ?=
 =?utf-8?B?S2FZMDZEWENiSU5oRk1BSTUzVzNyelAyNTBhNW94cENHTTc3QkZxaEFqalhy?=
 =?utf-8?B?VG55VnRCSmlOT2NUSzFQTW05WXY4QmhmM1ozRWthZytrWC9RVnhCYnpVRlp5?=
 =?utf-8?B?S1R2TFpyRUxSRUZuQUtZaGQwNGRKeWhTWVNxUG5VM2R2aUxkUHZ4akh4N2Uz?=
 =?utf-8?B?RWVabVVLbTZyZ3VnVFdtSjJ6M1RuWlFIMDF5cy94WE5sYzh6aFJmdExCRHA0?=
 =?utf-8?B?R3JUOHUrSWlkRjBpTEdHd0czZVF0U1dySllRZ1F4NjlQOURLeXM0RFN0bXZv?=
 =?utf-8?B?YnBIKzBxRldybTlleHFnZUVpRFBwLzBuOGNoR1ZDajR1c3ZyR1NlcHVQSDQ4?=
 =?utf-8?B?eUVkS0hBOFdHaGZsdFRIb2Z5RUNqcHIvRXUzSmprVWd2Vmh0ZTk3cFdJVDJY?=
 =?utf-8?B?bmRvY0pVN2pxZ2N1aStncnA3TjdWd3dsQ0x0RkJ4b0ZXU292SEdHa3hFYUNv?=
 =?utf-8?B?ZUZWNkNjY0xqenNyNjRkZWh5V0w1QXZoSXRhQnlzZlhRTVpaTHNGbzF6dUE2?=
 =?utf-8?B?bU5Wamt6dGdURTdlT1VzbEdOODhFQVNURVpabGZ1NGZ6cHJ0LzFmNFBjdHBk?=
 =?utf-8?B?dnhHVDRDYVBHSlNOSWZ5UzBTRXY2U0tsTTUzWStCSHR0ODFlSjFicS9LRWlL?=
 =?utf-8?B?MDIreWhjaHVxZWhnTGJMRFlTMUFjdGsvWnYyTWFKYVhvTnBqQWNsUGRuQzBr?=
 =?utf-8?Q?Stjf0J2cfq78+ISLAaG052iBGvVfhNIoQmX9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWhBSW53RjdlL0xmMWt6YkJjbUFucWZ2eStRcDBGRXZpUEk2L25aN0VBM2xD?=
 =?utf-8?B?b2s1M1ZyNXBZVTJ4OEV0TEJKM1pZTjhQU1BkQk9HeUJtREtqZkdVMlRrOFl1?=
 =?utf-8?B?amJLeDNEMTBWR2dNblFNWjg5REhEMFd2SzR5cUQvZDJQNk9Iemw0VHUxZUZt?=
 =?utf-8?B?cTFCRFJUc2IrVHZETHFqSHR4N0crR3BFYm1vcm05cE9jK05MU3Ircm5leWV4?=
 =?utf-8?B?UzN0N3kxQTNxa0JCRS9pc3gwMXF0Z2Z2UDBtUnpLMkIrUHRKNmpHUFlQNkM0?=
 =?utf-8?B?a3hsUVRIM29iSm05Qm0welF6OU1vcllQdWlNYnR0aUo2dHpvN3pwYWRscmxo?=
 =?utf-8?B?VUIxTmdhWFhMMm03ajRvL1JFMGl5UmdZUitzcWcwY3REMGs4anJnZU41cTFJ?=
 =?utf-8?B?T3lvbDE4OVFJYTZMTy96Qi9YUnJKaGZQeWdWWFZGWkFNVzFFaHFBMGVFNHFP?=
 =?utf-8?B?L3VyN0pEa1kxOE1VeVB0R3BkTFF3MTM3N3NMS0tFU2YveG5EK2VVMi9SUm11?=
 =?utf-8?B?MGlqNHp1YWNTWThra3FZVjgwcVVzT3BvdTRRTWZCYnlFK2l5QW0vaWJ1d1cw?=
 =?utf-8?B?MnhkV1YvRHZ6U01veGtHc3NXQThxYnVLWU4wWFhJLzI1NERDeTQ4Sitwb0RD?=
 =?utf-8?B?M1F5aUFlaGpwdWNtY1NIcVp6MHdTSWx3MW8wenJ0OTcyc0xobXdKcExSSjB4?=
 =?utf-8?B?a1NlZjBLK1VsSkVNanBpRGFHZTdQZzQ2UGdFVjdFc2FRclFoUDhCcHpTYjR1?=
 =?utf-8?B?eVRicExvaEhVSHAzKzZkcjYrTWxYOHNLSDBMTmM2NU9CV0l3Y1JnTjVyRGlu?=
 =?utf-8?B?RVdUcEQ4VXIzMDBFYk9kdzNTU2Y3ekZuUTJnWFBySjdNVC85b3ZQVmN4VS9F?=
 =?utf-8?B?aUFCSkszQkt6bnFGWHM0RzNuNDVwTGFBWU82bFNTRFFvS2lZY2RLSlBia0Va?=
 =?utf-8?B?Vm1IVVVreWFNZ25Ccy9sN0F6dEhTNnM2dmZSS043b1JOTlFxRDg5MTAxMDNy?=
 =?utf-8?B?S1FTZlp5em45ZE5VR09OOENXWVBVYVd0cjJwOXRIR0lITEZOR1ltWTRPdW5x?=
 =?utf-8?B?T3NpMk9zeUY4QkxLODhORzFjcXlEcW5HNno0UERTdk94NElGRGxxcGVhc2pi?=
 =?utf-8?B?c205Wk5LT1Y1VFZ5bDdJNDJTa04wTlFkaTFZZldHU01SOTFTOFRYc1lXYmxM?=
 =?utf-8?B?cGpJZ3BwRGVMTnNhcldySGRGamMxNkJVRkhDNlh2bkVETlUwYklwNGJ5bUZ1?=
 =?utf-8?B?TzFkcSs3YTI0RGsybmZNb3JlY0xrZFJpeHhKV1M3U3hrY3ZKbUtEWFlDTU02?=
 =?utf-8?B?WTBydWZybU91UmhVNkc4cWlCMWVYRkkreFRtTDJHOWlYUFJoSm5xdHBvaHB2?=
 =?utf-8?B?djZjZys1Z1VLdjEwY092cFN3T0R1bDR1eDJ3aUw2ZU95dHhaS1U2a01ZUC9P?=
 =?utf-8?B?QTZOM09IWTE5cC9ycDhYM0R3RmkzUVV0dW5IMnZSQzgyY2ZjSGZXLzBGSlFX?=
 =?utf-8?B?WHY0ZmllSlpQQnZXbkpXdlg1N2tRWkxuUENpZVkzWFd0bWM2aVBLdFBSOXdj?=
 =?utf-8?B?UDNYWTFlMFlqdTZhKzdLT3libC9zUjYraktPeE9Pay80STRNK29PVXQ0Y1Bo?=
 =?utf-8?B?M3VMK1N2anI5cUZPZ2R1NlF5K1FyK1NtYUIyZmxpME9WbnhOdVdqUVlsNTJn?=
 =?utf-8?B?SVV6THVYRlMyUWZIRllTTVN3WStCNlo4TWk3M0xYMU9RODhqdHZ5cE1DSXZr?=
 =?utf-8?B?RXJBVWJjVVAvcUxiazZhQzFRNWxtN1JCaDdjSGJtVHczZWZZcnhEMGE3aEVF?=
 =?utf-8?B?QlYwN2ZSYWIwVDNjMjRlT0VZL2JsK0E3OVkxRUVuSFNwYjVndWRwTjd3U3BN?=
 =?utf-8?B?SXhGNEg0SGFmOE5iQUE5bzBsTlA1ZlNxQTU1dFdua2lTLzJCb0ZNQUVBczFK?=
 =?utf-8?B?NDIwRDBZRzNYU1R0TVYycGxNVzRBU2NlQ3FyWDBnZ2xGVHFRcUJNUDRiQyta?=
 =?utf-8?B?M0g0R3BjVTJCTGFVc3hqRXNOT25kczNBVlFacFlCcXBzNWViZkx0SzJMUm81?=
 =?utf-8?B?KzgvKy9qb0llVFNqZDZ0SEhuZWxZVEszUlNGeGJDRDlncnk5dmQwdUxFaUor?=
 =?utf-8?Q?o1MXW6eFGNjrjeXKtsy+G5wAj?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b8dc65-7832-4a5c-aed2-08dc831b9dc1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 15:49:41.4579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9yqIDor9xKR5mcSz+aUTqrstP6RQms6EdglRY9f/4AA02mUsg6QqqwN3JxlREiL0fl7dmGQDtcalqRFti4vCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7512

TI tla2021 is a limited single-channel variant of tla2024 which is
similar enough to be easily supportable through the same driver.

Add compatible string for tla2021 so boards may describe it in
device-tree.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
index d605999ffe28..718f633c6e04 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - ti,ads1015
       - ti,ads1115
+      - ti,tla2021
       - ti,tla2024
 
   reg:

-- 
2.35.3


