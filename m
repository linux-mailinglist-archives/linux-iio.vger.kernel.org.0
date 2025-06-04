Return-Path: <linux-iio+bounces-20200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C73DACD7C4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 08:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43FA3A55E8
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 06:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538931D8E07;
	Wed,  4 Jun 2025 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ciPEsTe/"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201312B73;
	Wed,  4 Jun 2025 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749017737; cv=fail; b=ZNoIV+87XP1j4Yy0tP5dgAFKo8pkhTO8B0HRX2riBwzzs0i85X5Fz4qtkGP66gGzEfzquFTr2a3wJKhNP3GjBBZPnL1oc8hKF78RxD2E2j6apUvZ4dNNS4zZnwthVj9hIwS7xPXxKm22Ph/yw0K93Psuu3tC/UoZDFgF4S3cWvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749017737; c=relaxed/simple;
	bh=u7Vuf+v2pXKsRpC+gMJQWjiZIyoes0BsLfjMPXLxJ+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rquscVVKpa8v5aKIqYqZpf4ErrDrlSd+K6UTJRwYTPuL181lXQbC4nHJXrBenhIZSNKeUY4JBPuTdZ4DdDT4tr3US/q7JrIcchdvQihUGdAG9ZI9mMOn4ew7WHVQ5YltwgPB+VFPxSDbiLW5rWS+2NA41gth1QRU7+mqW6dQL4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ciPEsTe/; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnapH69re7dab9LoULTJ6RVJ10MPWEra+dRz+UeETB5/T0bqI21ln6kHx5JdqMp+2qbuscy4sPYrutigPfzqv64EOSACzXulShweRAVR/5ecXmU6+9dOX9i4y4i5GEwEH5YL2W1sruJntudMrWWY+Bi6o8PF9X4YlW8Ig9FVFIv5LS1Ja58CTauyA6Hi1SoF8T+z+tsK0e6nKkGcMU/xtl01TxlcpRFhcAA3Yh6x3d+ASkatcTClJU7s0VD9YZ/veXjMLIELvmGnRuVz5Om5A5b/Ov/CLnxQMCLPe5CXfN+Mlz5IutUCZOXwnXuU2TLfwjcQCIussUANabnEXLSr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7Vuf+v2pXKsRpC+gMJQWjiZIyoes0BsLfjMPXLxJ+w=;
 b=jROqkgsJ8nYMqDCWoE+u6x8NsVrkYHImfy/Y33/KoASMLCAnfokvXdyfe6/WXu3k2gdLTIXTMzn+Dun7IyJkrUg2CX7uAhe9M4Se00P3XnPeETG1s3xOnWP+W3mrl/q5kxmHkms1W24SyxL326rwWyamXyfva94XewgkJ4igY8p4Y6egcgohdXyhMvppJqvJinaruqdaVzbp88YQNOhbYUkzmThfkvXELd2rEMOygMuQx7wVdqtwv6lroiDNSCHz2gn7dEt3j+fV3VPfQS2q1RaaEdeHno82paobuDVt6bybJtFLOG2xx6dBFj9UOkHb3Qj+uVF7whMjzNc7pFG8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7Vuf+v2pXKsRpC+gMJQWjiZIyoes0BsLfjMPXLxJ+w=;
 b=ciPEsTe/i6I44XqT28GMifIkTIS0w7DifZAyiA4zBE/K9gXJRIHkdHsJFHwJ/apdJWP9yIPopCvO7zS/OPCk8xww6qmy/vvqEGDv/dGmTvkCQJUXn6cAo+qGOI6ZXVYWp/ifbTTPkXMqB9Y3hsT39u+5Sd5CcONLA922X5mI4/vNYE8/YWti6soqpucnfYZKe6bB8zjFB1o/KuBkpa+WCXoXYBs0iepJ8cKxaDsA+C6bsm7tWPlAnRgBcbichkpPa2SXYG5proRB3I+y5n2W4YKDNbJ+7rwZnry8bBsaLPKkhsG5DBkPvYh+iquL6fV5pFfvtol2GoMUkNowgHtNfA==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 06:15:31 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%5]) with mapi id 15.20.8769.033; Wed, 4 Jun 2025
 06:15:31 +0000
From: <Dharma.B@microchip.com>
To: <dlechner@baylibre.com>, <kamel.bouhara@bootlin.com>, <wbg@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] counter: microchip-tcb-capture: Add DMA support for
 TC_RAB register reads
Thread-Topic: [PATCH 2/2] counter: microchip-tcb-capture: Add DMA support for
 TC_RAB register reads
Thread-Index: AQHbz5fGMO69rCJ6GEy7rBv2EWT12bPpvtMAgAjSOIA=
Date: Wed, 4 Jun 2025 06:15:31 +0000
Message-ID: <27407669-a580-482c-8c60-226b56562ce6@microchip.com>
References: <20250528-mchp-tcb-dma-v1-0-083a41fb7b51@microchip.com>
 <20250528-mchp-tcb-dma-v1-2-083a41fb7b51@microchip.com>
 <b45ea46b-3e17-4cb9-8e69-9eea0a3f8241@baylibre.com>
In-Reply-To: <b45ea46b-3e17-4cb9-8e69-9eea0a3f8241@baylibre.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|DM4PR11MB6144:EE_
x-ms-office365-filtering-correlation-id: 21790e7a-1cd7-4332-3e2e-08dda32f356a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QU9WeGhsWDlXS3daR29kWXczQkV1TU5INlh5RDVzMDNBWG0zN1VJRE5CTWR0?=
 =?utf-8?B?Z0xUcnJrUTdVckxSWElQRExQSC9Ed3F4QkU2dmtYQ1NOK3lBbU1uSW12WDFS?=
 =?utf-8?B?YkpQNDVOc3VSaHVtY3ptOHRmQ0pZeDNNcGUrTFh1bnBBeWtaWlR1UTZXakVu?=
 =?utf-8?B?blZ5REoyblpWeThTWVFZY1c3TnIzRy9OcE9OdElHUVlERDNmNmxVWE81NlNy?=
 =?utf-8?B?eExlS2FNSzNRZVYvNTduNDBHN1B1WlRWdEVnK0ZpTWNSUjc3aENLU0tSTk9h?=
 =?utf-8?B?YlFieUx6U21ST0FWakRFaUY2M0J4R1NiWmpFVERBQzR2RjVjbnBVNlJlakVV?=
 =?utf-8?B?WXoyQ0pYNG04a0RkTlAreVY2bmdCM3B5a29CMzI3QnpRbHpjL0U0VTh3SW9H?=
 =?utf-8?B?TzlCU0ZwRFN1NlBmK3FRaGF2cDA5Z3hnK3QyaEt6a1hncnJEelFNUDlqV2R2?=
 =?utf-8?B?WnNNZXl5UndJa0JINDljaUh1N1l0OTVmZDlvUkU4NGw0clhaSGo4VlhtK1Zn?=
 =?utf-8?B?TU5VRWVNMnhjcEVQWXdGbTRWSnJ3WTIrOTYyWUgwZm5rUjMvcjdIZEs1NFZ2?=
 =?utf-8?B?dkpRbVh4WmpsaU5EN2RMOEsrYUtEMnlFQWQ4ZnRxVS9FSHMrYngvaXRvQzJV?=
 =?utf-8?B?dnFzYzBEMjRVZHVmbDRmMGdsc0JRWG5iUVg5SFNrMStpYXdQeDhZYW5rUlRG?=
 =?utf-8?B?M3IxM0ZkUEF3N3lFOVJrNzdqaTVtTTczSUlMelVPV3RVQUtGV0dFZFpDaVVC?=
 =?utf-8?B?NFR6ck5NdjI5cXFkYWpkbU1paU85eVFxS3hrUVlEd3g3UWhQOHNmUUgxUWZE?=
 =?utf-8?B?bFJNVjJYT3k4UUVaYzgxb2w2TzZETGhhZUE1UW01emJsSkhoSThZMUYwV3dN?=
 =?utf-8?B?cWZHSmJ5ZzMrcUpMU3dWNWU2dHh4MSt0UzM2WFdLVDVSVXRtSG1OUzZmazdQ?=
 =?utf-8?B?ZDg3Ry9OUEwxWFU5dThiUm9BU25DN3NTeVRLVk9sVjhWOTQva1Jib2JEY2F1?=
 =?utf-8?B?elRiZG9FM29oa2padlNhSTFwcnFYWFVObjZweUNYZ1lvbGRyakZKdnNZWTVl?=
 =?utf-8?B?eFZmdVNiVzViUUo2RVI3MUdqOTlaaVEvMU1idGZpSk16UUJBMHhUWVZoaEtY?=
 =?utf-8?B?U3FNVkVDMS85N3FpemVJSXR4bSswUmROb0RmaldkWTYrSi94azNkK01vLzIy?=
 =?utf-8?B?OXhDZTN4ZSt2TFVvTU1vSVJHdW5xOVJ1UmVWWmNoeGlyZ2cvSjlOU3VxekNH?=
 =?utf-8?B?bXlkTS8rbG5GRUxUdG5YRTdCT0xCeUVBZzltOHUvbXRiU1R1SXp1cEhNaUJR?=
 =?utf-8?B?Q2YrS29FT2lzcGNkbS8xcnZac2doWFVBdSt0d090M0JkRS8wRWN5QThrNG1N?=
 =?utf-8?B?c21OK2RXb3RZdmhURlBtdlJ0R0p0SmdJcjZldk83L2tqZ1lpZXBza1pnVDlF?=
 =?utf-8?B?VEVLTURURmVOVmplL0NjY3QyRzBWSkt3cHlwOHJuVjhyeVFCRFZwdXo5Nm83?=
 =?utf-8?B?a1E4ckNjbEwrd1czenB4ek5XRkJCLzNET0t4dXAxODdxRFg4WXk5cXo1dDdo?=
 =?utf-8?B?cTF4ckFldmNjNFdOMXVJMzk2ZXh0bWwxRDRDazFVSnp5enNvdC9rMDU4NTdx?=
 =?utf-8?B?K3E4ZDNzTUEyb3JLSkY0eUhpcWN6ODBBclZDNnFlMEp2UGkxdXh1WTdaYzR6?=
 =?utf-8?B?NVZ5UGl0cElwWFRsa1RxNlN6ZktCYVVBanA2MFBOUVAwK1ovVVZ5SkxVRy90?=
 =?utf-8?B?dEJmdWdRZUlrcEVIWHRYVVpXMFlvbGdKcEZaL2ZRb1pBek5WOU9DR1F1M1Vr?=
 =?utf-8?B?TUlLSjdyVFJScVZ4OGNnM3h1M3NvQW82ZHRPZjRNSTdUbkI3ZWU4bG1YVG92?=
 =?utf-8?B?dzdvZFlvdi92c1Qwd2pxNC9PNWtuTGxhbzdlaVFWRzF4TEtWZS9QUGRIL0o3?=
 =?utf-8?B?Z2lyUFhSd2tIRXMySmxNblNUQldqUUlRVlhTM1ZaV1FzVnNpdXB6dTFTK0dL?=
 =?utf-8?Q?0uN2NdlAlTouZhtu16or0fHvOeIFtc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dU54Qkc5L21PVGRxZm96VlAwWDNJbUJVZjhhNS9WalZzemgrYXFZVkdRVVhH?=
 =?utf-8?B?Ty8zaHJMZkt1ekhLRkZJNmhEVjBVdXFsbWhGMGVDT1pieWFZRlFtQkw3VjFO?=
 =?utf-8?B?bVg4U3ZuZk1lRFpiQlNUKzhVRkkrR01YRjFzQ1JSUXgrQzJlNFMxb2ZiREo1?=
 =?utf-8?B?U1VpeWhucHBoNlFBYWVCYzk4dGVuOURzY3FDYVM1eURuTDZydmxmaHJtN0RU?=
 =?utf-8?B?cDlDRjVnUzdkZEx2QzdEcjhaSmZHTzNiYWRnelhiNnd1TFIweDBUZk9MZTlM?=
 =?utf-8?B?SkhQeG4rTmJOcVplNkJNREtveXF5ZVBpUWMyOGlHZlF4MDNMR0g1YVRUVE4w?=
 =?utf-8?B?djREUnVFc1FjcnpKb0lEQjRJY1hza1cxVWNnSzFaMnJKT2tETDEvQjRhVjZj?=
 =?utf-8?B?RlZiY0dGaHFEYjdEWGRWc2JsM0w2RXJyV21MaEU2QUZnelZwL0lqK0N0S29M?=
 =?utf-8?B?dW5wWmpkQlZha2RHWTZjOUovWjlOWVNvMlVMeDEycHpHeGpETUR1bGdvNklD?=
 =?utf-8?B?Wm5jZENQS29zWThJa3NFaWRDTmRiamJXSlE5UWFiNFZETkN4R044NE5hQzJt?=
 =?utf-8?B?NGpOaENtTTBLU2NiRTZzWkhFbDR5RnBTZzVQNHZDUUNHc0VRUWdFTTYvc0N3?=
 =?utf-8?B?eHloVTdqenRoVDJhYTZWVS9mM2paWjlyaEQ1RmhOeDZEdFZnOFpsUnptZ0sz?=
 =?utf-8?B?Y0oycGlGNFk0YnhxM0lKU1lQaU83MTZzY3dYRUNXMzZVbG1aS1pTaGM5ZkhX?=
 =?utf-8?B?R1BYSVVaSUhTL01rcEtRalRicnVieEdXYm1BMUtpOG95THNyaWFsdy9VdTF4?=
 =?utf-8?B?ZmJRbHloZldJT0FjSmhCRHpUMHJNc2pVVkNkQkd6UHV3RnNRZXZIQnFYV28v?=
 =?utf-8?B?WWVycFBFK1MxamFxTjBaVW1xSzJTdVE5YWhIUnZRQm5CT29nSkhRcExRanpP?=
 =?utf-8?B?cUViV3k2Njc4cXBzMWduOTREVE45aklKOXc3Smh4SXZsVndRMHhpeFdOVm1X?=
 =?utf-8?B?RzhWSTU0SGt5cEM0MlY5OHNwUEE3WDlQMmEwSXlpano5UnMzYUpUUlhWQkM3?=
 =?utf-8?B?T21PcHFLUVFzbzZxeU05MmY4U0UxZHdNSFdsdDRNWGh2NzFXY3VRcGgwekhp?=
 =?utf-8?B?WG1OaTVoeUxPbThSTWhrQmV3REFiZStRNkFTRklmc3RhZ2NYUUEwV3VQbEZI?=
 =?utf-8?B?QUJTZ2hSdW1KWDZJMWZRNzh6MzJmYkFlck8wYTlNQlFZZVhRZFJ6SGc5TlA3?=
 =?utf-8?B?WDV0bTVVLzhkc1V4ZkVyQnZQb0tJRG1EeUpoZUlyUm5NblI3OW4ycG8vSHQv?=
 =?utf-8?B?N0M1RVlKRmpHRlE0bUpsZDZoRndGQy9lWTJNWXJqMlRvckVTRmV0VHljZHJx?=
 =?utf-8?B?TTBPakI3a0d1MGtlcGo2YTBzVk1LRXlOU0k3K1ZPZXpjL3hObGtKMFdOVVZY?=
 =?utf-8?B?dm5zajdjVWtRS0lwalN0MVBadlhSWTVkcGRKRWZhcUo0eFpYZllmMlhMVVZt?=
 =?utf-8?B?UWNQWE9rNnRBZlg5N29RZ3JkblIyZVQ0QWR0dGo5d3pybWFoVnJ0L2hGbDV5?=
 =?utf-8?B?bi9lWGorKzRpNnYzVGM0RCt3QmNNb3NGMnRqUjN2aXZBNDVoWC96SGxObExI?=
 =?utf-8?B?S3QxVGhDMVZhVng0OXZUNk5vRjdYaVM5WG9jUWxZZ2g1alV5djEyNkVsbXB5?=
 =?utf-8?B?YllBdFE3ZU5pM1BLNTdGc2JNUFV6Mmh4akdaS0lGNWJxRituWWovSlpjdVNB?=
 =?utf-8?B?aGF3L2ZaQ0NEQ3hSQjV5UGdodUNDMUZPYzAvTk9LbkxOeEFoRUxWYzRFdEJE?=
 =?utf-8?B?ZUxMeVhyZXFHZHNJVUludWxTbFV4MHVlcFVNcUNlbS85WWZ1NDFjZmg3K0NC?=
 =?utf-8?B?cDJwMlRxUGVLdE9HYkJQNlNOTU4wWGdzVElrQjZ2N2VPaTBZV3BvRmJvcVlH?=
 =?utf-8?B?bUxGZkVOcWxKRFFHSGwxS0xtTGZYVjJHQUdpa2RFNHJOeldlb253eFFLREhG?=
 =?utf-8?B?OUNtcytKK1BuZkE0THJReDhuM1dJSWJBYmFheU1UdnJkQWJ3MXhZVzg2bjBP?=
 =?utf-8?B?MVVZaWtnMjgzT2tjTGQ3NjJLRnhmOVM4dno3Rzg2ODJFSXB4Y0I3b2Y4eWxn?=
 =?utf-8?Q?60emlManKVOrg0XDtVcpajkbM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ECB9DC0C258044AAAA90B8FB3529050@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21790e7a-1cd7-4332-3e2e-08dda32f356a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 06:15:31.1005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiiVlH3CdWi2nwM8rFMlqe31dl9kxhgrj+dJ0UiRvaL/2nrQh1gvmgkPuqmPJ1XV1aNIjs4t9A3wKSb3SiFqBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144

T24gMjkvMDUvMjUgOTowMyBwbSwgRGF2aWQgTGVjaG5lciB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiA1LzI4LzI1IDE6MTMgQU0sIERoYXJtYSBC
YWxhc3ViaXJhbWFuaSB3cm90ZToNCj4+IEFkZCBvcHRpb25hbCBETUEtYmFzZWQgZGF0YSB0cmFu
c2ZlciBzdXBwb3J0IHRvIHJlYWQgdGhlIFRDX1JBQiByZWdpc3RlciwNCj4+IHdoaWNoIHByb3Zp
ZGVzIHRoZSBuZXh0IHVucmVhZCBjYXB0dXJlZCB2YWx1ZSBmcm9tIGVpdGhlciBSQSBvciBSQi4g
VGhpcw0KPj4gaW1wcm92ZXMgcGVyZm9ybWFuY2UgYW5kIG9mZmxvYWRzIENQVSB3aGVuIG1jaHAs
dXNlLWRtYS1jYXAgaXMgZW5hYmxlZCBpbg0KPj4gdGhlIGRldmljZSB0cmVlLg0KPiANCj4gSXQg
bG9va3MgbGlrZSB0aGlzIGlzIHVzaW5nIERNQSB0byByZWFkIGEgc2luZ2xlIHJlZ2lzdGVyIGlu
IHRoZSBpbXBsZW1lbnRhdGlvbg0KPiBvZiBhIHN5c2ZzIHJlYWQuIERvIHlvdSBoYXZlIG1lYXN1
cmVtZW50cyB0byBzaG93IHRoZSBwZXJmb3JtYW5jZSBkaWZmZXJlbmNlPw0KPiBJIGZpbmQgaXQg
aGFyZCB0byBiZWxpZXZlIHRoYXQgdGhpcyB3b3VsZCBhY3R1YWxseSBtYWtlIGEgc2lnbmlmaWNh
bnQgZGlmZmVyZW5jZQ0KPiBjb21wYXJlZCB0byB0aGUgb3ZlcmhlYWQgb2YgdGhlIHJlYWQgc3lz
Y2FsbCB0byByZWFkIHRoZSBzeXNmcyBhdHRyaWJ1dGUuDQo+IA0KSGkgRGF2aWQsDQoNClRoYW5r
cyBmb3IgdGhlIGZlZWRiYWNrLg0KDQpZb3UncmUgcmlnaHQg4oCUIGluIG91ciBjdXJyZW50IHRl
c3Rpbmcgc2V0dXAsIEkgZGlkbid0IG9ic2VydmUgYW55IA0Kc2lnbmlmaWNhbnQgcGVyZm9ybWFu
Y2UgYmVuZWZpdCBmcm9tIHVzaW5nIERNQSB0byByZWFkIHRoZSBUQ19SQUIgDQpyZWdpc3RlciB2
aWEgc3lzZnMuIEkgYmVuY2htYXJrZWQgYm90aCBETUEtYmFzZWQgYW5kIGRpcmVjdCBNTUlPIA0K
cmVnaXN0ZXIgYWNjZXNzIHVzaW5nIGEgdXNlcnNwYWNlIHByb2dyYW0gZ2VuZXJhdGluZyBoaWdo
LWZyZXF1ZW5jeSANCmNhcHR1cmUgZXZlbnRzLCBhbmQgdGhlIG92ZXJoZWFkIG9mIHRoZSBzeXNm
cyByZWFkIHBhdGggc2VlbXMgdG8gDQpkb21pbmF0ZSBpbiBib3RoIGNhc2VzLg0KDQpPdXIgaW5p
dGlhbCBtb3RpdmF0aW9uIGZvciB1c2luZyBETUEgd2FzIHRoYXQgdGhlIFRDQiBJUCBpbiBNaWNy
b2NoaXAgDQpTb0NzIGluY2x1ZGVzIG9wdGlvbmFsIERNQSBzdXBwb3J0IHNwZWNpZmljYWxseSBm
b3IgY2FwdHVyZSB2YWx1ZSANCnRyYW5zZmVycy4gSSB3YW50ZWQgdG8gZXZhbHVhdGUgdGhlIHBv
dGVudGlhbCBiZW5lZml0IG9mIG9mZmxvYWRpbmcgQ1BVIA0KbG9hZCB3aGVuIGZyZXF1ZW50IGNh
cHR1cmUgZXZlbnRzIGFyZSBvY2N1cnJpbmcuIEhvd2V2ZXIsIGluIHByYWN0aWNlLCANCnRoZSBj
b21wbGV4aXR5IGFkZGVkIChlc3BlY2lhbGx5IGR1ZSB0byBibG9ja2luZyBiZWhhdmlvciBpbiBh
dG9taWMgDQpjb250ZXh0cyBsaWtlIHdhdGNoKSBkb2VzIG5vdCBhcHBlYXIgdG8gYmUganVzdGlm
aWVkLCBhdCBsZWFzdCB2aWEgc3lzZnMgDQpvciBzaW1wbGUgcG9sbGluZy4NCg0KSSBhbHNvIHRy
aWVkIHJvdXRpbmcgdGhlIERNQS1iYXNlZCByZWFkIHRocm91Z2ggdGhlIA0KQ09VTlRFUl9DT01Q
T05FTlRfRVhURU5TSU9OIHdhdGNoIHBhdGgsIGJ1dCBhcyB5b3UgbWF5IGV4cGVjdCwgdGhhdCAN
CmVuZGVkIHVwIGhhbmdpbmcgZHVlIHRvIGJsb2NraW5nIGJlaGF2aW9yIGluIG5vbi1zbGVlcGFi
bGUgY29udGV4dHMuIFNvIA0KdGhhdCByb3V0ZSBzZWVtcyB1bnN1aXRhYmxlIHdpdGhvdXQgYSBt
b3JlIGNvbXBsZXggYXN5bmNocm9ub3VzIA0KYnVmZmVyaW5nIG1vZGVsLg0KDQpXb3VsZCB5b3Ug
c3VnZ2VzdCBleHBsb3JpbmcgYSBkaWZmZXJlbnQgYXBwcm9hY2ggb3IgYSBtb3JlIGFwcHJvcHJp
YXRlIA0KaW50ZXJmYWNlIGZvciBETUEtYmFzZWQgY2FwdHVyZSAoZS5nLiwgdmlhIGEgZGVkaWNh
dGVkIGlvY3RsIG9yIGNoYXIgDQpkZXZpY2Ugd2l0aCBhc3luYyBzdXBwb3J0KT8gSeKAmW0gaGFw
cHkgdG8gcmV3b3JrIGl0IGlmIHRoZXJlJ3MgYSBzdWl0YWJsZSANCmNvbnRleHQgd2hlcmUgRE1B
IGFkZHMgbWVhc3VyYWJsZSB2YWx1ZS4NCg0KVGhhbmtzIGFnYWluIGZvciB5b3VyIHJldmlldyBh
bmQgdGltZS4NCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0K

