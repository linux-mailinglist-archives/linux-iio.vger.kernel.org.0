Return-Path: <linux-iio+bounces-9912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C5989BF2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BECB2146C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D159161328;
	Mon, 30 Sep 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="U1fijPWt"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE17208D0;
	Mon, 30 Sep 2024 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682847; cv=fail; b=DDLlpAvjzfEUz7RHEE4l2J6UQx8cysPvvkjoCfrZYCSUY32p9/yXGIJu0wAMjt5qG7bJsZSTQj/hc3uglJlbLYio24660hVIsPjy94Q4SHsJWI9+mkAsme5PnVwpqreQ/b0xU4gvgId9yAfxYvJoCf0B//+FPan7i11g/mdG8+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682847; c=relaxed/simple;
	bh=EWBgUKH9sJ8GiY1fmhwiOgtG31ZksjkgFNNhkv0brFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i/gHdWpi9YG/mICUfV0+4jXv4IhQyt0EySm/iLh0C2ftlK6KEwqfhaaY4scmvaGv8QrWWNEGajZOVecjl7RZHkXjEu4s0440E7nEL/6n3BftrAhInMI1bQxOOe4fVB+8kudBJk04Q4u5CodjM6qe9WyfooVAi3v7HUlOSlqaJAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=U1fijPWt; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJJgOY8uuL9r27m2TUG7SBNvv3HTF1UB1Ackq7ofeILY9MVZnPK4ALWwR8rXTmBDqgXZ4/f8hh4zkMFus/KZq2ZRQzMw70DxIPLdRxdVczeV5qxluc1tjy5HOkSIZ0x5OEsHCKFm+cFbQE/KJA0Te+6hMrucgYCmVVHGQFR8P115M4zZfQfU+lCwfsyRiiy7uoewU5isTL5fXDFcNksbkN3Yz+hNAd9hpvj6TWe6Sf6z8mXHXR5I+okAOwMDTJgairKCEYG6IbqYdj6QIdm2l9j/JMJAnebi2ZVFWxUs4A7/qWuuNtnKARJnzX78fxM0HaHbtnB6xeu3tiRCnqHj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWBgUKH9sJ8GiY1fmhwiOgtG31ZksjkgFNNhkv0brFc=;
 b=nKhsFacyBvqFbs9S7iPiXEmk0nr5aRgSCyPcDPIOF2ghrkjWJvFILrW9Zy01yhxaSZmREs8SX3tecmDcLk/IrhCJ3/XXOCCCnc5A0pNTC5z/KbRNIqbxFmpJc1GD6sIsjfkysX2T2OKK7aip16iDPKR2xqp4Y6DarUGB5HgaKkW7Ug7Y8lHiotgzNRw33F+V3f1f4Ollr9MaqeI1UNXGbtYm+rGLt4V64d3/kNVII3q9MlxFnzslbXSwIsnD7fwvMB2qagOPZPvGODsOYbmBm9Tm18lk8EVFcyisruJmc94hNxyCWK9WGznoPAa4nKYcbdySKO1I/TULopra6S73Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWBgUKH9sJ8GiY1fmhwiOgtG31ZksjkgFNNhkv0brFc=;
 b=U1fijPWtbyuIB8zUpVsTk0MxWyOgV5liuVeqS4tBh0CBiiMqKlJhsJCDNL7w5enUAvjI/Ep/CWRD8ccfpcDhfbbhXJlZksexeGi9L1DvTCkDE79R3J13fpinOq6b5HnnBJB6WRSODT/ved4Ax7O6C1BgkIPYp34ZNfXaae4OMpc=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by DB9PR02MB9731.eurprd02.prod.outlook.com (2603:10a6:10:45a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 07:53:59 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:53:59 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH v3 3/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Topic: [PATCH v3 3/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Index: AQHbCEjHyksUL51B8E2b/8Xaz+VzSrJtb90AgAKbYYA=
Date: Mon, 30 Sep 2024 07:53:59 +0000
Message-ID: <150ebd3af04045efe4d4ee7f298a57044e0f448e.camel@axis.com>
References: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
	 <20240916-add_opt3002-v3-3-984b190cd68c@axis.com>
	 <20240928170520.02a27690@jic23-huawei>
In-Reply-To: <20240928170520.02a27690@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|DB9PR02MB9731:EE_
x-ms-office365-filtering-correlation-id: cf89671a-2cd3-4375-6b2a-08dce1250b2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVRITGJUeVF1OTdJcS9RSUJDY1ZKQy9qT0FHTEZLM051RG13dVlhK2hub1ln?=
 =?utf-8?B?VUVVWm44SkpFZzdXR0ltb3lXL0lGRTJBT1QzTEEwVE4ybnRQd0cvYzA3SUtj?=
 =?utf-8?B?ZnJkWGRMSlJVZkVoTXAzSFcwdTQ5SG9VeGFRcU5ucmxPSnVUaHk4c01EWlZI?=
 =?utf-8?B?WlZaQXNLR24vcXhDc3pXcVp5TEpIampsRURTeWVCUklJWjdxVnNkRUFGSWty?=
 =?utf-8?B?d3dzQ3JaenkrQndHd09GZzhoS01BOXF6M1pqcmxlSlhpZ09RL1dVcDNsTm14?=
 =?utf-8?B?NFZHRVVoNzVZWENzRit4bmxKWlZrKzhyOUZjeXg0eEVzWWdIY1dFLzJVRnAw?=
 =?utf-8?B?SFV1Z0ZQL0Yra0hOZlN0Ty9EUStKNXh1djFvR0dOTkhYdDh3MEViQlBsZTc5?=
 =?utf-8?B?TlNXZXc4YWdyWWh2MjE0Rk5hNVhhS0tNSiswY24xTmdXRVd2eXQwcHVyM2k5?=
 =?utf-8?B?VWxlSGxIWEVrUzlpbkVINnVlTlVXSVU4VmtXdUpZVmNpM2lRTG5kTlp1dVpH?=
 =?utf-8?B?d1UwMFB4ZFpKdlBOT0pvc0NxaUowZmpDZlRQWW9hWHZGS1VOV2FydFpxWWxX?=
 =?utf-8?B?aVU1K0JOLzBGZ0NGQy9NRFZPc1dUSDA4TjJrMnVydWFUeUkyZUd6aXJuWjRR?=
 =?utf-8?B?MVNkaW5jdGtOaVRwNVFMYmRpOU95K2tYRzI0ekMzQ1VXZTVhWkZKQ1dGMHBs?=
 =?utf-8?B?SlpFTGZJWmhLVmk5YjIyT3dxdzZWQmF0a2daQmFtcUh1YzVWLy92TWhTN0R4?=
 =?utf-8?B?OGZINUl4WG5La3MrYWUwd3dFL0VsWG5tQUw4eFVvUVBlZytpQ2JWdWh5VjQ2?=
 =?utf-8?B?eVNQWG9OS0lGSmptT2g3WnBoZXJxcER3dmtTMmd3WGdvdzd3blhoTG42eVky?=
 =?utf-8?B?NGVnMmJKMCtiSUdUK1JIcHBCUWphZ2p3OGw1ZU42NDNJcXhmMWZGVnd2VVQv?=
 =?utf-8?B?NVhIS3NBbEY2ZUluV1BEeW1aN1AwM1VuTmlLR2pZT0hQRysrbWR2eXdIVWh3?=
 =?utf-8?B?N3NobzQzSlh0dmpVUnF3Rm8rcThkNzIyOG85S213WDdpNHIxZkxDU0lxTndZ?=
 =?utf-8?B?aEZZSW5FQ2NVVmNPRXFLd3QrMjVQSFZLQm5aUlNhdWoyc0Q2VXJETzVMMGF2?=
 =?utf-8?B?Si94SCtIa2U1OE1vOC9ZWHpGQzFmMlFXTmphcnM1QkV5a3puNHcvTmVXa1Fk?=
 =?utf-8?B?eUluMHJ2YUZlOHZzdDdMaDJpTHlzREE0Ym94ckVVKy9IY3E2eFpkQXZ0ajFH?=
 =?utf-8?B?RTdmdGhoWTZETlAvSmV0bUhzWUtkYUE0MTNWVEFJUUVpWVBRRG9hNkZNYmh4?=
 =?utf-8?B?Z2JTZzlqMERNTWNWUDYrOTM0UjhXMzlRNUQvQ0lCL2l3R0lhZTZCUjBva2cy?=
 =?utf-8?B?WEZrYjNHNnZSMHAyZ1V3N3FFeVg0aTlGZVp5Q3NrQ3VsSStqeFNHa0RldnVJ?=
 =?utf-8?B?RTl1azdXTXJ1UGhIWm1WVHltVmkwaEIxQUx6cThyVXJKY3ZXT2tWUXFNbnpz?=
 =?utf-8?B?Z1QzZ2tXS3BwdzhuYnlpdDBMR2JCWUE5TGM3ZXQzL3NGVDRGVnVHTXNDbG9w?=
 =?utf-8?B?NGprblVHVHFjSmF3Vk5oeHVrZHZseUZqY3RqejRCZXJRVWwwZnRuaTJXT20x?=
 =?utf-8?B?NzNDV0xabzc1ZHpmVWpKRm5HYmVqUzRrYTJteU1EYkVvaEZ1dVM3U3VYb2xD?=
 =?utf-8?B?dlRJNkNYTXc5UkQvTWhRUVR4S3oxWCtYTHpzUnRMUmg4KzhOb2Y1YitqUG9H?=
 =?utf-8?B?bVdOOGFDNytJaVBmcDd3WUlFMkRzWDlmL1Q3ODRIdXpRd2QwVkhDZ1RST0pQ?=
 =?utf-8?B?Z3Q5anhjb0s1SmdRNmdFUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0tGK0xzdkZXeU9scTZBL2hxVVdzUUlQTVh3ajkydnMvNXBRbzRIUXYvbUw1?=
 =?utf-8?B?SHRzU3NSeFh0VC9JN0h5NE5YVFZrNTh5c0xTayt6SDNPV2I1Q2I0dkR5Z1dF?=
 =?utf-8?B?Nzd0QnpqMjNtVDlrbU9JRm9mVWpwOGRmUU9jdUVzSkVhQWhFT3F0eEpRajZj?=
 =?utf-8?B?djJkODlvZW1QcExnQklmVjVJNmFGUWVobW1XdFRTVmFMQ0JMaFF0RW9lVnJy?=
 =?utf-8?B?dGEyYWdwbVlqOGFOSHlPejNZamluNVhTbkp3N3FmWUQ5TjFmUFlBeXUvZElS?=
 =?utf-8?B?azd3ZDFyQ09TK2RjOUUvdjRKZmUrY0ozV1VUVkVkRm96b0VRMUtaeTlmUWcy?=
 =?utf-8?B?ZUJnUWs0dmtnbXFnUXE4Z0dVeDYvb2ZuVjNFMGRNTVJxYU1hYWU0Z1R0R0pO?=
 =?utf-8?B?VGcxRU9Pa0VYMkZvZGhhTDdlSnFBS1ZKMGhkTEQxaHdVUWpHS3p0RUNJOXhX?=
 =?utf-8?B?WlRESHdoOXdEZVUxRzZ6WDRLNGthQWVUamRhU1llWkFDa2R1VnhiODc2UDQz?=
 =?utf-8?B?V3V2VmlCVWRYa3RJNURhZ1JpVGVuSnAzVzRBcmdaZFM0NW9CNDllTzBmVWx3?=
 =?utf-8?B?a3FTTlZZOURQRlZGclJmSU9SNmxQTEZQbTNxM1dMNEEwWE5mY1M3dkhTZWY2?=
 =?utf-8?B?MHJvZHBDdEpLOW1PN2NPYllsRUVudWVGZlN2VTZ5U09OcnZBSnNSTEwxeDdZ?=
 =?utf-8?B?bUlmMk9hQmZOMUsxTGs1WTNZUzNoWHBMb3hLOEgrU0dabVhrek1jaHN4V1Ux?=
 =?utf-8?B?Ykg3aTJ2MTZOQWVXQnBBdEwrWlBYekJZNjUvdWUwT2FxVVJHRDZpSGFucmVU?=
 =?utf-8?B?T0cxMys4aHJBWllDczJzRXo4K1kyQ1o5L0hobVViYkh1NGF1NUZhb2plODVW?=
 =?utf-8?B?UElvUG1ORDhmZWdyRUNVQk5GUE1NQmlPVi9paEtJM080cWQ2NXFZTE1hMmRW?=
 =?utf-8?B?aUY5Rmc5TjhpWWc5MURJSmpyQ1lZSXYyaDNaK0ZxRFltekpsZVk4OUtydG5w?=
 =?utf-8?B?N3JPY05lSHA0U2tMbGY3dFpMODFTR2RuRWdFY2h5ZE9FK3loRm9CRXZRTzhB?=
 =?utf-8?B?eS9TbkN2RHNld2c0N0R3UlpMUThKNEpXZStKVlVIdXdMSW5xS0I5OXBkL08y?=
 =?utf-8?B?ckNWdnNkMDc3cUE0VlpCMTZ4RlNhU1QwdllJYysrTmlyLzBMYlhla2RobnlP?=
 =?utf-8?B?Ukd4YTdGRDd5ZWJ6YXRPaVY1Y0h4Y1BXQlFxY1gzandUZUZsYW9SSWwzMThB?=
 =?utf-8?B?c0dHc0ZFc1hUcjJFcVA1aEh1UzB2bmlqM0dWbnIybXlDQW1HVGR2ZmZSbFUz?=
 =?utf-8?B?UWw1anBiOVFyMllmM3FYUWcyZE12RTlNMGVBL3F1MWRWbGNzNVV1OU1NWWpa?=
 =?utf-8?B?OTNFZWxXRmtQanFNSkYvTlhxMzhTcWpOVTdRMWZpRjRlTDFZWVBncnpMSVdz?=
 =?utf-8?B?bThJbGFyUkpCYUU0MlppTGtHb1ZNZU5WczlDd2NYOFlVTGZuY1J6WFZxVVlF?=
 =?utf-8?B?empaVmdYYm9rSytadE4vZWhBTDBUZnF3YUZiMVd2ZW1qZlJJcHhZWTR2SWtK?=
 =?utf-8?B?R3lHNS9qcmxmbVdxWmxDTXlXeS9hYjVZTVlhTVQxVjdtQUw2c3Nsb0N0cEhS?=
 =?utf-8?B?QU44YnV1OS80SnBEV2ZWc21mZ2dRem9zaTVNV000cldGblpYVzFYS0dCYjE4?=
 =?utf-8?B?Vk45d3Y5dEc5aEdETDJvTThZQkQwZXdLSGQ3UGZ5ZUs2OFpvSHZyZ2o4SVRV?=
 =?utf-8?B?Zms5STdRb2lhVUkxck1vSHF4UnpaSmZhdlI1UU45THlua3V2WlRDdms5T3Bt?=
 =?utf-8?B?aVJoQWt2dS9ucnhnSjBZZ3dpQmhZa1ZNU0JpMW8wWXNQR0ppelA4STJBL0lx?=
 =?utf-8?B?SHByZkhSWlpwV3ZPSFdjY1o2K3VlYUdQanFsTW50RXNURVNrb2huTjY1UHJJ?=
 =?utf-8?B?cjBsZDNqOFAvY0dIUDQwMkVQdHZmeGEyNkd1UFJET0NKRFo0alB2TzBGMUdT?=
 =?utf-8?B?OEJuRVArRm1WUjZwdXR0dVJvenFBTXJwV1BPNnpEVlQzbW5ZZEpoOE9KcVRu?=
 =?utf-8?B?ejJqaUJlRktVTitQeTR0ZWdGUzhHa3dSM2pPVVIwNWlRZ3czdTBWbmJVRmFL?=
 =?utf-8?Q?qPONK0mRAyWjBEi/uT61ZfSSt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B054C0B571602A4CA387ABEE15EECCB3@eurprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf89671a-2cd3-4375-6b2a-08dce1250b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:53:59.7272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4/M7mOIbHUKAP2eULuuxPEvNw7EkUCHqNZh7c1nIEf2dQnCHpCQLZueDdf1U/5k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9731

T24gU2F0LCAyMDI0LTA5LTI4IGF0IDE3OjA1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDE2IFNlcCAyMDI0IDE2OjU2OjM5ICswMjAwDQo+IEVtaWwgR2VkZW5yeWQg
PGVtaWwuZ2VkZW5yeWRAYXhpcy5jb20+IHdyb3RlOg0KPiANCj4gPiBUSSdzIG9wdDMwMDIgbGln
aHQgc2Vuc29yIHNoYXJlcyBtb3N0IHByb3BlcnRpZXMgd2l0aCB0aGUgb3B0MzAwMQ0KPiA+IG1v
ZGVsLCB3aXRoIHRoZSBleGNlcHRpb24gb2Ygc3VwcG9ydGluZyBhIHdpZGVyIHNwZWN0cnVtIHJh
bmdlLg0KPiA+IA0KPiA+IEFkZCBzdXBwb3J0IGZvciBUSSdzIG9wdDMwMDIgYnkgZXh0ZW5kaW5n
IHRoZSBUSSBvcHQzMDAxIGRyaXZlci4NCj4gPiANCj4gPiBEYXRhc2hlZXQ6IGh0dHBzOi8vd3d3
LnRpLmNvbS9wcm9kdWN0L09QVDMwMDINCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbWlsIEdlZGVucnlk
IDxlbWlsLmdlZGVucnlkQGF4aXMuY29tPg0KPiBIaSBFbWlsLA0KPiANCj4gQSBmZXcgdGhpbmdz
IGlubGluZSwNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQoNCkhpIEpvbmF0aGFuLA0K
DQpUaGFuayB5b3UgZm9yIHRoZSBjb21tZW50cywgSSdsbCBzdGFydCB3b3JraW5nIG9uIGZpeGlu
ZyB0aGVtIGR1cmluZw0KdGhlIHdlZWsuDQoNCkJlc3QgUmVnYXJkcywNCkVtaWwNCj4gDQo+ID4g
DQo+ID4gQEAgLTYxMCw3ICs3MDQsNyBAQCBzdGF0aWMgaW50IG9wdDMwMDFfcmVhZF9pZChzdHJ1
Y3Qgb3B0MzAwMSAqb3B0KQ0KPiA+ICAJcmV0ID0gaTJjX3NtYnVzX3JlYWRfd29yZF9zd2FwcGVk
KG9wdC0+Y2xpZW50LCBPUFQzMDAxX0RFVklDRV9JRCk7DQo+ID4gIAlpZiAocmV0IDwgMCkgew0K
PiA+ICAJCWRldl9lcnIob3B0LT5kZXYsICJmYWlsZWQgdG8gcmVhZCByZWdpc3RlciAlMDJ4XG4i
LA0KPiA+IC0JCQkJT1BUMzAwMV9ERVZJQ0VfSUQpOw0KPiA+ICsJCQlPUFQzMDAxX0RFVklDRV9J
RCk7DQo+IA0KPiBVbnJlbGF0ZWQgY2hhbmdlIHNvIGluIHRoZW9yeSBzaG91bGQgYmUgaW4gYSBz
ZXBhcmF0ZSBwYXRjaCBidXQNCj4gbWVoLCBpdCdzIHRyaXZpYWwgc28gbGVhdmUgaXQgaGVyZSBp
ZiB5b3UgbGlrZS4NCg0KR29vZCB0byBrbm93ISBJJ2xsIGtlZXAgaXQgc2luY2UgaXQncyBtaW5v
ciBidXQgSSdsbCByZW1lbWJlciB0aGlzIGZvcg0KdGhlIGZ1dHVyZS4NCg0KPiANCj4gPiAgCQly
ZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiANCj4gPiBAQCAtNzU1LDIyICs4NTAsMjUgQEAgc3RhdGlj
IGludCBvcHQzMDAxX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpDQo+ID4gIAlvcHQg
PSBpaW9fcHJpdihpaW8pOw0KPiA+ICAJb3B0LT5jbGllbnQgPSBjbGllbnQ7DQo+ID4gIAlvcHQt
PmRldiA9IGRldjsNCj4gPiArCW9wdC0+Y2hpcF9pbmZvID0gZGV2aWNlX2dldF9tYXRjaF9kYXRh
KCZjbGllbnQtPmRldik7DQo+IA0KPiBVc2UgdGhlIGkyYyBzcGVjaWZpYyB3YXkgdG8gdG8gZG8g
dGhpcy4NCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTEvc291cmNlL2Ry
aXZlcnMvaTJjL2kyYy1jb3JlLWJhc2UuYyNMMTIwDQo+IGkyY19nZXRfbWF0Y2hfZGF0YSgpIGJl
Y2F1c2UgaXQgd2lsbCBhbHNvIGhhbmRsZSBmYWxsaW5nIGJhY2sgdG8gbWF0Y2hpbmcNCj4gdmlh
IHRoZSBpMmNfbWF0Y2hfaWQoKSBwYXRoIGFnYWluc3QgdGhlIG9sZCBzdHlsZSBtYXRjaCB0YWJs
ZXMgaW4gYSBmZXcNCj4gY2FzZXMuDQoNCk9rYXkhDQoNCj4gPiAgDQo+ID4gIAltdXRleF9pbml0
KCZvcHQtPmxvY2spOw0KPiA+ICAJaW5pdF93YWl0cXVldWVfaGVhZCgmb3B0LT5yZXN1bHRfcmVh
ZHlfcXVldWUpOw0KPiA+ICAJaTJjX3NldF9jbGllbnRkYXRhKGNsaWVudCwgaWlvKTsNCj4gPiAg
DQo+ID4gLQlyZXQgPSBvcHQzMDAxX3JlYWRfaWQob3B0KTsNCj4gPiAtCWlmIChyZXQpDQo+ID4g
LQkJcmV0dXJuIHJldDsNCj4gPiArCWlmIChvcHQtPmNoaXBfaW5mby0+aGFzX2lkKSB7DQo+ID4g
KwkJcmV0ID0gb3B0MzAwMV9yZWFkX2lkKG9wdCk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJ
cmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiAgDQo+ID4gIAlyZXQgPSBvcHQzMDAxX2NvbmZpZ3Vy
ZShvcHQpOw0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICANCj4gPiAg
CWlpby0+bmFtZSA9IGNsaWVudC0+bmFtZTsNCj4gPiAtCWlpby0+Y2hhbm5lbHMgPSBvcHQzMDAx
X2NoYW5uZWxzOw0KPiA+IC0JaWlvLT5udW1fY2hhbm5lbHMgPSBBUlJBWV9TSVpFKG9wdDMwMDFf
Y2hhbm5lbHMpOw0KPiA+ICsJaWlvLT5jaGFubmVscyA9ICpvcHQtPmNoaXBfaW5mby0+Y2hhbm5l
bHM7DQo+ID4gKwlpaW8tPm51bV9jaGFubmVscyA9IEFSUkFZX1NJWkUoKm9wdC0+Y2hpcF9pbmZv
LT5jaGFubmVscyk7DQo+IFRoaXMgd29uJ3Qgd29yayBhcyBpdCBoYXMgbm8gd2F5IHRvIHBlcmZv
cm0gYSBzaXplb2YNCj4gdGhyb3VnaCBhIHBvaW50ZXIuDQo+IA0KPiBBZGQgYSBudW1fY2hhbm5l
bHMgZmlsZWQgdG8geW91ciBvcHQzMDAxX2NoaXBfaW5mbyBzdHJ1Y3R1cmUNCj4gYXMgdGhlbiBp
dCBjYW4gYmUgQVJSQVlfU0laRSgmb3B0MzAwMV9jaGFubmVscykgd2hpY2ggY2FuIHdvcmsuDQoN
Ckdvb2QgY2F0Y2ggYW5kIHRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24sIEknbGwgZG8gaXQgdGhh
dCB3YXkhDQoNCj4gDQo+ID4gIAlpaW8tPm1vZGVzID0gSU5ESU9fRElSRUNUX01PREU7DQo+ID4g
IAlpaW8tPmluZm8gPSAmb3B0MzAwMV9pbmZvOw0KPiA+ICANCj4gPiBAQCAtODI1LDE0ICs5MjMs
MzYgQEAgc3RhdGljIHZvaWQgb3B0MzAwMV9yZW1vdmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVu
dCkNCj4gPiAgCX0NCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvcHQz
MDAxX2NoaXBfaW5mbyBvcHQzMDAxX2NoaXBfaW5mb3JtYXRpb24gPSB7DQo+ID4gKwkuY2hhbm5l
bHMgPSAmb3B0MzAwMV9jaGFubmVscywNCj4gPiArCS5jaGFuX3R5cGUgPSBJSU9fTElHSFQsDQo+
ID4gKwkuc2NhbGVzID0gJm9wdDMwMDFfc2NhbGVzLA0KPiA+ICsJLmZhY3Rvcl93aG9sZSA9IDEw
LA0KPiA+ICsJLmZhY3Rvcl9pbnRlZ2VyID0gMTAwMCwNCj4gPiArCS5mYWN0b3JfZGVjaW1hbCA9
IDEwMDAsDQo+ID4gKwkuaGFzX2lkID0gdHJ1ZSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRp
YyBjb25zdCBzdHJ1Y3Qgb3B0MzAwMV9jaGlwX2luZm8gb3B0MzAwMl9jaGlwX2luZm9ybWF0aW9u
ID0gew0KPiA+ICsJLmNoYW5uZWxzID0gJm9wdDMwMDJfY2hhbm5lbHMsDQo+ID4gKwkuY2hhbl90
eXBlID0gSUlPX0lOVEVOU0lUWSwNCj4gPiArCS5zY2FsZXMgPSAmb3B0MzAwMl9zY2FsZXMsDQo+
ID4gKwkuZmFjdG9yX3dob2xlID0gMTIsDQo+ID4gKwkuZmFjdG9yX2ludGVnZXIgPSAxMCwNCj4g
PiArCS5mYWN0b3JfZGVjaW1hbCA9IDEwMDAwMCwNCj4gPiArCS5oYXNfaWQgPSBmYWxzZSwNCj4g
PiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCBvcHQz
MDAxX2lkW10gPSB7DQo+ID4gLQl7ICJvcHQzMDAxIiB9LA0KPiA+ICsJeyAib3B0MzAwMSIsIChr
ZXJuZWxfdWxvbmdfdCkmb3B0MzAwMV9jaGlwX2luZm9ybWF0aW9uIH0sDQo+ID4gKwl7ICJvcHQz
MDAyIiwgKGtlcm5lbF91bG9uZ190KSZvcHQzMDAyX2NoaXBfaW5mb3JtYXRpb24gfSwNCj4gPiAg
CXsgfSAvKiBUZXJtaW5hdGluZyBFbnRyeSAqLw0KPiA+ICB9Ow0KPiA+ICBNT0RVTEVfREVWSUNF
X1RBQkxFKGkyYywgb3B0MzAwMV9pZCk7DQo+ID4gIA0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBvcHQzMDAxX29mX21hdGNoW10gPSB7DQo+ID4gLQl7IC5jb21wYXRpYmxl
ID0gInRpLG9wdDMwMDEiIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gInRpLG9wdDMwMDEiLCAu
ZGF0YSA9ICZvcHQzMDAxX2NoaXBfaW5mb3JtYXRpb24gfSwNCj4gPiArCXsgLmNvbXBhdGlibGUg
PSAidGksb3B0MzAwMiIsIC5kYXRhID0gJm9wdDMwMDJfY2hpcF9pbmZvcm1hdGlvbiB9LA0KPiA+
ICAJeyB9DQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG9wdDMwMDFfb2Zf
bWF0Y2gpOw0KPiA+IA0KPiANCg0K

