Return-Path: <linux-iio+bounces-8436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F995016A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 11:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8750C1C2431F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC131898E6;
	Tue, 13 Aug 2024 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="p95qmAvh"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0917F505;
	Tue, 13 Aug 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542121; cv=fail; b=qCbVBzOeiYENzOE+AqFDKHLPp7rLoLA2cT7fsxT8DBjwnJOGrV7Sco4TwKiQIWCa+M2syy7EZ9kK78jH2yXjOmZ2QMddY7qwk2ngOzz1u8nrTYdKzZCtC/kzgUzt8nitLTuFaBmxMag+NsvMRH44k3R7VRgsvdhjz/OB/2iUne8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542121; c=relaxed/simple;
	bh=PYmdQlpkXi/FvD66CJnaGg1PsCceg7vjeEq2PXqY/DY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X4wQJpUbaA+ja+2oeMpkAwFlNLfqvxhP1LLZpDfqVdADHHyvqVmFKjyv9DeMoO1kK2t/R6oUNpwJY13Z14WSFGl4zOe77ISa6RsDxLxT6ha52qYVDqm9nZaBoNWrhxrlMKs8UP6ibiAZjC6tqSRg+xahbfUNjzdjBQfH9LjL2VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=p95qmAvh; arc=fail smtp.client-ip=40.107.103.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHU8UWDgRQ+dnKl6ZBathjmHAjywS4+PumEY6RojkOIycZyxm+9/hNIa8vJmAXi0TB+69Z82YkxWPvOWehgEmdmmlymtiduvT7qRp+uaSM899Nleomcccmxs3YBf1T5j4iHe6wP35KyJvJTv913y0ehLcn5btcwET4Gsd1BK+LdQU49j7RwsQz+5q4UeOpfnLEIi//KjbzuK+4BhlukWBkb536iZnhze3runCTyVDcbA52o9Bzj22cMy2NvWftevc9LHjA6osJ7TR2utUVn27S9FrEiF9VQSNPwx4SxIIE76szTWqOsaNlYeeo0IKpZm/Asr+HowklIJdZcVfpj6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYmdQlpkXi/FvD66CJnaGg1PsCceg7vjeEq2PXqY/DY=;
 b=ESfkgpGqhTskLXhkUbf0NMOG4eTF6EcYVRhMrgy/rXbVJxvbAiEj7hAYRiSZVfEhbtuQuo6KlbMyg87gkzZx7NsDpXIi20tJusdVC5+slww7RI1iAqswyRa8aPRcjFmbLDV+9MQIncoCOi7gQDJz5Sa7LNaJ/dRXuNqJ8k+REkD1oNJ+lNm2H5w+DU0ehVij59RRBDM6ltv/cOVqWiktGZhZTev45NER9s6Z+1ZIjaRqlePUxYlxNX0ZxHnpv9W5Rd4GGCe95YIJa17aYF+1GoELkuHW7zb9qrkAdMjVh0Vpwmif1ewAPJVKlER0S2YO2yTrYQfZsBm8YPknE4SOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYmdQlpkXi/FvD66CJnaGg1PsCceg7vjeEq2PXqY/DY=;
 b=p95qmAvhtq6+hOkLqOmWQRkI8qsNOMfp1rsiC1bSTcxpto5VYPclgZBoBDbM3xU+jwF8nNHBPQUKfY9Ur44U0gyok3gAeIY6YciodH0CcrZWqxYPmxJg8TGleeS8RhSeMJN/e0ufe8aBD39ccZItlYTZD78dUhrTTaxBi9lDENpIDY7PH3cMoZkReJurIOjLK4AzfjnuFzeOlt1Ijw62uKZx+An+uPX8cqBdbYuCuy4xX+fsP5OsQ2I+3yEUz3ill1pwLzHkDXIYniwxxrbtBCbvc0n0iY5V1GfkWiDC73eIeHwPYByJIOfSNY1mts4Fpa/hADb9Pq+1Qph5jWqesQ==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by DB9PR10MB7241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 09:41:53 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 09:41:53 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
	<dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
	<Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: RE: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Topic: [PATCH v2 2/2] iio: imu: smi240: imu driver
Thread-Index: AQHa6k2uA9cl/09kzkKzfXi0qtLeGbIgcW+AgAR0C2A=
Date: Tue, 13 Aug 2024 09:41:53 +0000
Message-ID:
 <AM8PR10MB47217665274B9848EB21FA65CD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
 <561b467a-58aa-471c-8ea6-cd6ef927c287@kernel.org>
In-Reply-To: <561b467a-58aa-471c-8ea6-cd6ef927c287@kernel.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|DB9PR10MB7241:EE_
x-ms-office365-filtering-correlation-id: c7fe6a34-862a-4a5f-df31-08dcbb7c2a0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?dDZrUHBOQjVEakRsbC82dzhaWmxQbkFudlByVjFndXBhZUV0M1ZYVk1JeGt3?=
 =?utf-8?B?YzJIWmRMUDRnb2ZmM1ZJSjBEK3dLZXBTeU1FM0pxUVZtL0hHZ3ZOK0dZeUxi?=
 =?utf-8?B?TXZqbk5EbnN1ejhZdVNUSjdtRXZkOXlTbHY4b3o4SjBxNjY5ck4ybU1BRTJC?=
 =?utf-8?B?amNiNDRUbjErcmJCQ1Y5VTd1NTIvVXkrZnJDbmRYNVNPdlNKSDhDR2VlenBr?=
 =?utf-8?B?ais2VHJzbWJmZ1ZCTkY2b0N1TzFCTkR6eHhGQzU5TURoQkpRN29MMjg0UmtQ?=
 =?utf-8?B?L0NLT0NMallxWEdZU1pMeWJLQXBrdnUzTVAwRjg2cUlNQkhaL0JZRjRvS0Ir?=
 =?utf-8?B?czhIRFRYc2E2cDhQRzFXcDliYjFqd0ZkZENmZWVhaEoydHhSY0J3NEZsa0pC?=
 =?utf-8?B?bDY4dHl0Z2w1WG1qZWZaQUFETGxKYUNEdmdveFdMM3I0ODRlRkpuOEZmeFRP?=
 =?utf-8?B?SnpqdXhtNGNUSDlRWjdrZWJ5clNJUGdhdzE2WUUwaTRpbThVT0x1UEF2LzhV?=
 =?utf-8?B?azM4V28yeGJUM0h1MXZSeWQ2Q1BoVDRwMjM0bW45dm9LYlVPYWdLekw1RVU3?=
 =?utf-8?B?YjQ4dG00Umc4SCtwTkR5Y2JMcmV3bVV4QTB5R1V3ei9wNWo0TEpXdjVqMVFL?=
 =?utf-8?B?bXJsNHRnWm1Rb1BUTndwdzlSTnZsN0ttMTUwZUlhejdmRVJCZ0RrdE1vQnJr?=
 =?utf-8?B?ZkRjVmJBblRGVVBTb3lkOUV0cGNmUXd5T3MxelZ1eEgvMlZnOGpHTFVvbVIy?=
 =?utf-8?B?SU52d1djWFFlUXFXMTluUE4xN2xaY09iTjB2WWNIcWlrSFh2TldUSHVTci95?=
 =?utf-8?B?TUJGZ01xU1oxZ2Z3Umk5YStNaTByallqcmFXN2hyTkRUZ3ZFQmtTYXpTbE1V?=
 =?utf-8?B?Z0ZHWU9Kc0dyMmhWWmVISDk0WndaeEJsREpCMkF3Y3l0NnMrTlJ5MkxSZ0Ix?=
 =?utf-8?B?WHo3dlpncUpXS2U5M1dhSWkwZElUVmpONEQrOGlwR0FzQ1N0d256RGNMYVp6?=
 =?utf-8?B?c0tiY0pmSTh3aDd3cWl1NGJ5MFZJSXIrM3pZSk5ETGNZdVRuam8xNldSUExy?=
 =?utf-8?B?RDN6Kzg2MDFXSFJJRTA2R3I3b0R3azdtcENyVmZGd3Y5SHVuQXZGenZ0Qi9l?=
 =?utf-8?B?VGxXcFJLNU5jRUdJcmx6R2I5dUVXSS94UXVERFJ3K1pEMWwyQmpDa1l6ME1o?=
 =?utf-8?B?WDhxR1hzUFRKeC9uQUZsZXd5ZHpvNUU1VFBZdTZjNVFhTTNhNGh4UkVwM0hY?=
 =?utf-8?B?NUZkV3BidWZMalUweWJvaG5sazI3cVJ6My92VXJUVjdwS2ppcDlVMjdzRHF6?=
 =?utf-8?B?dDZqSURvQm5yWjZPUkhEVmlEVzlVN1Q5L0RCS2J5OTZGeXJlNzJJRHFIMUVZ?=
 =?utf-8?B?VFBFUGdrdDU5Z3JlT3ZyRWN4UUNGenpNMGNnbXhRWWJQY1dCS0g0VzF3NXI3?=
 =?utf-8?B?NlJRNDM3Q0pNSkZUbEFENlNZcnAzVXZKN1dhMjZ3eDBybzlHd0NrU1pjTGk4?=
 =?utf-8?B?RWZuR0s0RVB2Ulo0Rm9rNXA0NHZjQ2V6Ukw4Qm92bUFjNUx3N09TZGN6Tk9S?=
 =?utf-8?B?dityaVhDVEVNbVJRMktuRkRtakxoREpZNnY2NE1KL3QyazdOS2JEelZtY2xj?=
 =?utf-8?B?bU1yN1lZK0xEN25LOVFTVWhhRU5GNlArN2tXSUVNWFFqS3ZqOE82VkJ5R2ZS?=
 =?utf-8?B?a0F1ZUtMQllSZmphTFhMZzJ6VGtZejRQOFN1RkVLdDhaTHg2VUU4YzRZZ1NX?=
 =?utf-8?B?U1JMUkdTekN5NEFjb0dJdTZEMVl1QnVrWDN2ajV5dy8rSjl5K1Z5M2N2bEVw?=
 =?utf-8?B?WG53Njl0Ym5oM21sTnZ5WDNIS0NEK2RqZnlmQStQSURBWHNBdlVNWEwrR3FW?=
 =?utf-8?Q?qZEvssxqi4URO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2dMa0JRS1liUmxoejFCdFZlMVFJbXhEUmx5T2JxMEdDMkZTZEFCRHF4SlRl?=
 =?utf-8?B?WFV4a01vRjA1M2U0aDNGSUNqUU1ZQWtiVWNGZGlMMEp5UEFFSUw1eHBxNlhn?=
 =?utf-8?B?VjRkVnFqMTR1UXJWUUtVRDRkM3VwdHJPeEdFQzVxeU5sR01UT2x5UVR4Rjk5?=
 =?utf-8?B?ZDlldGdQZlJKVlM3aGMzcUlTUWJRN3FleUNIWk1XU0dmYVYwSnNUTlpnb043?=
 =?utf-8?B?KzV4bVZVT0VheGVLT0t0RGlTakd5azlmZzdwNk1RTEtweHNwZWcyTnJKemtV?=
 =?utf-8?B?ODhsNWJpV2R6ci8yZ1lnclRpNXRQV0dPa1FYNW1qS2Z0RUJSYUVRSGRjdWVS?=
 =?utf-8?B?N29lWm5oZ1ZrV0doTUVMbm9aMmtHblg4cG5Hd2FlN0ltVHRMa0FMVnkzaVFP?=
 =?utf-8?B?SmdsUFJvQ0NLQ0FMdkJtMGsweUZ5bFgzeXJ1WkxVK2h1V0VNTUZEQ2c3SGhV?=
 =?utf-8?B?aXlGTUZHQUpCWHJQdGZ0NXVDdjlWY0ozNDZ2Vzg2dk1mYVFDOTBFT2Z1WHkr?=
 =?utf-8?B?NlhheTNzYnpBbjdsR3dQNEMva0VJRURUL21GSXF4T2hoMGk1M25xamVuLzVD?=
 =?utf-8?B?UUROOHBvKzBtbkRMQ3U5RlVhaFMraVRnSVpWT0pDNkJBdC9UOXp2ak92UnpB?=
 =?utf-8?B?MTAyL2tWZ1VPNVNTQ1UyUUIwS3NSeEw5UHhxRnlnWHVTdDhZbDlvR0JvT01a?=
 =?utf-8?B?M3B3OFpGdFNXMnkwUFo5K2lYcHRNd25CekZYOXVpUGxIYXZRRTMyN2gvY1c2?=
 =?utf-8?B?Nkh2OU1zQ2RBWkRPNlgvNUI3Ulc1UjhWeXZxZ2UzQk9JWHI1c1BMU2dkcGNv?=
 =?utf-8?B?eUJ5cm5qWitCME9wQjZmY3BtTkFjVGQ3SmE4S1RBZVBUdnVzYThueStsTytH?=
 =?utf-8?B?SkdPVHhCYmRmT2NLV2xhMDVEb3RvejFkTVMyS3g1cGdhbXJ4NDByYkt3WnA0?=
 =?utf-8?B?UituNnYwZlNld2IvbzNlU1lCWkRqRFRnTS8zQ3doMzVVSlJZSGNTdTNLSjFH?=
 =?utf-8?B?U1lOWENDRi9LZzBodFZucHY0Y0NXanVlSFJZcXhLbHBrRnRuK0x4amZIaFhB?=
 =?utf-8?B?UllnTnpMUjZhbytieFlVNnYrSjNJMTJjdGpoSFArWmdsSnExV0hWWkpvY2V0?=
 =?utf-8?B?d29BRW5lWGJCR3I4MVlPcnFoRm05K1JFaGZHdWJKVnZuM2ZnRzhLa2g0VnA2?=
 =?utf-8?B?blFFclppRDlEbjhGc0pnMnFSQjRNTzVzdno0Y1M5QnU1OXl6Vjg1ZWdlSHNN?=
 =?utf-8?B?VEZxYWdHUWt4bXMyakJwdFVTZHNjdTJIaFFFdnJISUdpZWQxMVNRdzhpcXI5?=
 =?utf-8?B?cEJpUDBYWnkxQmFGRFlBQUM1ZzhMR1pKbGtWci9pZk1yc2dHbTdRZ0cwTW02?=
 =?utf-8?B?bEZZQjhTZTF2T2JUVU5tQmlZb0U1YzNPQXVLYmhQL0dLNUZYdmpES0lMTkRx?=
 =?utf-8?B?ZEM4NllPYWFDWWs1SFA5T1ZtL3BqcWZKOWFqRkNlNlhOZncydnVsKzJ0WXk4?=
 =?utf-8?B?ZjVGeGJWakNRS1puSXFaTTloaGc4RTEzT2R0UHVSZ3I4U0lESzI3UHRROUhH?=
 =?utf-8?B?LzA0YXFKSm44N3R2dEtKZzNGeXZORTVnVEdBRXdaNjF0RVBsOE5tSHZTMUxQ?=
 =?utf-8?B?SUc5UGRxU3ljWVROVmc1WDFidkZYRnFvVGlsWS9NeFBTSFBvRElxcnVaRGxN?=
 =?utf-8?B?bDV5cGtiVUZidVRLOEh3U0hvck0xZ1ZtWU1jaUhzc0FCVXJlN3pyMlFyZFF3?=
 =?utf-8?B?TldhUXdzMWRqVFJSR2F4TklZcnJ3NWxpbG9MZHVnc3ZnS3prQ3AzaUk5TExs?=
 =?utf-8?B?VEtXbFcvZXRsaWFMWGtabkxNc2ZVVXZrcFdBOElOeW5QSXFRRzh0RGpka1p1?=
 =?utf-8?B?bnQvb2pPRUgwUWg1c2VMVmNrNXhtaXdteHJTWGFyVDc1L1ZxekZpd2R2cVpu?=
 =?utf-8?B?czhxaDdLYVk4cE1DTHYzQVdlZXVWK3Bpdkk0UzNpUUlpeFZ2ZllKbGlBQVVs?=
 =?utf-8?B?RXJsT24zOXNpMEhjQ1ZHNE1zYkFoUThmckxNQzF2YVZydEFGVCsvWkFoOUFy?=
 =?utf-8?B?V2VxcFY1NmJWVHZaVEFsZm1BRDg3WmhJYVpMTE4yak9PZkhWOWNramZFUWlj?=
 =?utf-8?Q?9c10=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fe6a34-862a-4a5f-df31-08dcbb7c2a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 09:41:53.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDkB1ffx+VKnr8PSR7mKLHJH5JgHAni1Nq3Yx88fwKf4XKennAjSeDrH3SeCWczxBX0ixHsPOB0z2QJBCRT5hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7241

SGkNCg0KT24gMDkvMDgvMjAyNCAxMzoxNiwgSmlhbnBpbmcuU2hlbkBkZS5ib3NjaC5jb20gd3Jv
dGU6DQo+IEZyb206ICJTaGVuIEppYW5waW5nIChNRS1TRS9FQUQyKSIgPEppYW5waW5nLlNoZW5A
ZGUuYm9zY2guY29tPg0KPiANCj4gaWlvOiBpbXU6IHNtaTI0MDogZHJpdmVyIGltcHJvdmVtZW50
cw0KDQo/Pz8/Pw0KRGlkIG5vdCBnZXQgeW91ciBwb2ludCwgd2hhdCBpcyB3cm9uZyBoZXJlPyBo
b3cgaXQgc2hhbGwgYmU/DQoNCj4gU2lnbmVkLW9mZi1ieTogU2hlbiBKaWFucGluZyAoTUUtU0Uv
RUFEMikgPEppYW5waW5nLlNoZW5AZGUuYm9zY2guY29tPg0KPiAtLS0NCj4gDQoNCg0KLi4uDQoN
Cj4gKwlyZXQgPSByZWdtYXBfcmVhZChkYXRhLT5yZWdtYXAsIFNNSTI0MF9DSElQX0lEX1JFRywg
JnJlc3BvbnNlKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYs
IHJldCwgIlJlYWQgY2hpcCBpZCBmYWlsZWRcbiIpOw0KPiArDQo+ICsJaWYgKHJlc3BvbnNlICE9
IFNNSTI0MF9DSElQX0lEKQ0KPiArCQlkZXZfaW5mbyhkZXYsICJVbmtub3duIGNoaXAgaWQ6IDB4
JTA0eFxuIiwgcmVzcG9uc2UpOw0KPiArDQo+ICsJcmV0ID0gc21pMjQwX2luaXQoZGF0YSk7DQo+
ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsDQo+ICsJCQkJ
ICAgICAiRGV2aWNlIGluaXRpYWxpemF0aW9uIGZhaWxlZFxuIik7DQo+ICsNCj4gKwlpbmRpb19k
ZXYtPmNoYW5uZWxzID0gc21pMjQwX2NoYW5uZWxzOw0KPiArCWluZGlvX2Rldi0+bnVtX2NoYW5u
ZWxzID0gQVJSQVlfU0laRShzbWkyNDBfY2hhbm5lbHMpOw0KPiArCWluZGlvX2Rldi0+bmFtZSA9
ICJzbWkyNDAiOw0KPiArCWluZGlvX2Rldi0+bW9kZXMgPSBJTkRJT19ESVJFQ1RfTU9ERTsNCj4g
KwlpbmRpb19kZXYtPmluZm8gPSAmc21pMjQwX2luZm87DQo+ICsNCj4gKwlyZXQgPSBkZXZtX2lp
b190cmlnZ2VyZWRfYnVmZmVyX3NldHVwKGRldiwgaW5kaW9fZGV2LA0KPiArCQkJCQkgICAgICBp
aW9fcG9sbGZ1bmNfc3RvcmVfdGltZSwNCj4gKwkJCQkJICAgICAgc21pMjQwX3RyaWdnZXJfaGFu
ZGxlciwgTlVMTCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2
LCByZXQsDQo+ICsJCQkJICAgICAiU2V0dXAgdHJpZ2dlcmVkIGJ1ZmZlciBmYWlsZWRcbiIpOw0K
PiArDQo+ICsJcmV0ID0gZGV2bV9paW9fZGV2aWNlX3JlZ2lzdGVyKGRldiwgaW5kaW9fZGV2KTsN
Cj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIlJlZ2lz
dGVyIElJTyBkZXZpY2UgZmFpbGVkXG4iKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiAr
RVhQT1JUX1NZTUJPTF9HUEwoc21pMjQwX2NvcmVfcHJvYmUpOw0KPiArDQo+ICtNT0RVTEVfQVVU
SE9SKCJNYXJrdXMgTG9jaG1hbm4gPG1hcmt1cy5sb2NobWFubkBkZS5ib3NjaC5jb20+Iik7IA0K
PiArTU9EVUxFX0FVVEhPUigiU3RlZmFuIEd1dG1hbm4gPHN0ZWZhbi5ndXRtYW5uQGRlLmJvc2No
LmNvbT4iKTsgDQo+ICtNT0RVTEVfREVTQ1JJUFRJT04oIkJvc2NoIFNNSTI0MCBkcml2ZXIiKTsg
TU9EVUxFX0xJQ0VOU0UoIkR1YWwgDQo+ICtCU0QvR1BMIik7DQoNCkhtPyBIb3cgbWFueSBtb2R1
bGVzIGRvIHlvdSBoYXZlIGhlcmU/IFdoYXQgYXJlIHRoZWlyIG5hbWVzPw0KDQpXZSBoYXZlIG9u
ZSBtb2R1bGUsIG5hbWVkICAiQm9zY2ggU01JMjQwIGRyaXZlciIuIEFueSBwcm9ibGVtIGhlcmU/
DQoNCg0KDQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX2RldmljZV9pZCBzbWkyNDBf
c3BpX2lkW10gPSB7IHsgInNtaTI0MCIsIDAgDQo+ICt9LCB7fSB9Ow0KDQpEb24ndCB3cmFwIGl0
Lg0KDQpXZSBkb24ndCAsIGdpdCBzZW5kLW1haWwgZGlkIGl0IGF1dG9tYXRpY2FsbHkgZm9yIHVz
LiANCg0KDQo+ICtNT0RVTEVfREVWSUNFX1RBQkxFKHNwaSwgc21pMjQwX3NwaV9pZCk7DQo+ICsN
Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNtaTI0MF9vZl9tYXRjaFtdID0g
ew0KPiArCXsgLmNvbXBhdGlibGUgPSAiYm9zY2gsc21pMjQwIiB9LA0KPiArCXt9LA0KPiArfTsN
Cj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHNtaTI0MF9vZl9tYXRjaCk7DQo+ICsNCj4gK3N0
YXRpYyBzdHJ1Y3Qgc3BpX2RyaXZlciBzbWkyNDBfc3BpX2RyaXZlciA9IHsNCj4gKwkucHJvYmUg
PSBzbWkyNDBfc3BpX3Byb2JlLA0KPiArCS5pZF90YWJsZSA9IHNtaTI0MF9zcGlfaWQsDQo+ICsJ
LmRyaXZlciA9IHsNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKHNtaTI0MF9v
Zl9tYXRjaCksDQoNCldoeSBkaWQgaXQgYXBwZWFyPyBZb3UgaW50cm9kdWNlIG5vdyB3YXJuaW5n
cy4NCg0KRGlkIG5vdCBnZXQgeW91ciBwb2ludCwgd2h5IHdlIGludHJvZHVjZSBub3cgd2Fybmlu
Z3MgaGVyZSA/DQoNCg0KQmVzdCByZWdhcmRzLA0KSmlhbnBpbmcgU2hlbg0KDQo=

