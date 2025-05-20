Return-Path: <linux-iio+bounces-19724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20573ABCE21
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 06:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23154188FAA3
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 04:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E0256C95;
	Tue, 20 May 2025 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="3SMeyuCd"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B137160;
	Tue, 20 May 2025 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747714120; cv=fail; b=CKYDYtcQhWYPSKm0O4ELVuF0A0ydTZBotw46cSl9Balp5IWZxbVmmpX9FS/kJxx6aZA9k+amc2TUXYbV9gXJYMuY+94eHWgvxub23q6Cn/Wj4ula5ml0wsnMchx0UgMW1bhswLHEwOmuxgQgg7q59CEpT5X26OAf0Xiqzz9N1xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747714120; c=relaxed/simple;
	bh=X6hpaJ1/pk0RL9Z5P0XrPHtdNobd/5Z4U2mdZtIj2y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SamuON847bx55rhi6pQch0UEANnx/tYy/IKCb3/NjX1dFU5Z8sevpAKWWkaZuj8yvUoCFV0ylHuj8NK/fDL2AxIOo8FwiI7jUD1Up4rNZ5zqcutbwK7h+wWsguUW43s/YfGcn3hrQopuocuh886RRTxbR41LEhu33IX+kjejvGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=3SMeyuCd; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM6lXpbfhRj2zfoQ5d79MPYRbSeLC0mTR65nzAW55fr2H5T8c5jKTm/H5H0RMDWi5yNMtwBTZAmZppUks82zEpzogV1ykLCmJQ69wOIxNyhyY63SYBFkwyWSjcuEq5TOPTCgGETpzQ9OvXSxFdo8+v8p/Zv8/Y9HExO2GX55vbGzxF/y9yPZ3cNrl/Uzfuts/eWrUbGSXB7rB2tT46uG3FI8KbPAiEgy4bzrDJJ86mulF9c04vcJ92EZFrlspqD2g/TNY2N3EtjO6R86nO4n75NAJbRw1YA0hVeQBrieFmdQez1Dp56dKgmEcZ3ywJmj3NUf8NemxuebfSMnRfVrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6hpaJ1/pk0RL9Z5P0XrPHtdNobd/5Z4U2mdZtIj2y4=;
 b=o6MRGrVl3jICxG7NKpYs8GrH4fZBj4W4b9sDwGWPixTtIWCHRNIfDX+gl29JabG4MNcrSuvSJNQQGllCqpAJGE6ULXnrsgmhWvhpzFE3IUl541n6Ifzszu+55E7CKPRKmfNJayhglCQXzkQ7yMUgk4YfnXFBZqk/xvhjaOUFfYJukSwxOYkQxfCOQeW+uqzbR4jLVXFPMyPqwkOmUSSUmub+sgAvbEWjr/ooNY5GCjzRo1b407L7DDRtJqcxG4hTOnZA9BpzsIfjo2A7wdg4KnIQwCkD0+sgrFaFhWef6B536+dPtqgmjht/rkcRye//8hzT/hV7GhqRy22A5B51Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6hpaJ1/pk0RL9Z5P0XrPHtdNobd/5Z4U2mdZtIj2y4=;
 b=3SMeyuCdMhpYVqrjwM8ychusbHFN/hvtZWnSBAf3xJa21kINDA+vxlkKXLKjxfZRgQi4+N2WHVl8J1zqBm3tfLVPPpUZ/ZlmiyV8BU6o4g7AyhIh7B/gugrP3puzEuBlOI+nN+gHRLuEJhtHbI3cyV7unkezvxpEaEb2lHZyrw7jWwYjTz5Xnax1CnYJgMBYDWX9qR2jD8WS0BCtVlztkKM+ArOIrIe+ECkD2ZDVgeOho+lwMPwIuXHEPcS/fcFUFN2monHrmRt9ZDojY/ZXy8pmZBpLMyB5HychQ+uUDmPFF5Q+CJ/F9f937NSw7Ih8UlTZPI9QX+Kc0IFloJ/xEg==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 04:08:35 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 04:08:35 +0000
From: <Dharma.B@microchip.com>
To: <wbg@kernel.org>
CC: <kamel.bouhara@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] counter: microchip-tcb-capture: Add watch validation
 support
Thread-Topic: [PATCH] counter: microchip-tcb-capture: Add watch validation
 support
Thread-Index: AQHbxVYHRivDm+CKUUG+7oFIi18WIrPYBeIAgAHGYYCAASLEgA==
Date: Tue, 20 May 2025 04:08:34 +0000
Message-ID: <1b49de43-5504-4c0b-b1ca-996495f3cd3f@microchip.com>
References:
 <CV37uwi-rAqU3els0ckl4KLz5ortFAdc7XXy7ex6-MMhxvptyeMh8vTBXQuZliairKQ1Dy4yM3MyE8o7EZ6VfA==@protonmail.internalid>
 <20250515-counter-tcb-v1-1-e547061ed80f@microchip.com>
 <aCmPLn16Ykabvhjv@ishi> <823cefaf-b225-4531-8733-5d90d3ccceb3@microchip.com>
In-Reply-To: <823cefaf-b225-4531-8733-5d90d3ccceb3@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|IA4PR11MB9204:EE_
x-ms-office365-filtering-correlation-id: 3c8545c2-dc69-40a3-3ec1-08dd9753fda8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1MxVWhuWllNUDR4VXZSWkZEdmtjeW9MR2Y5a2tsZjJvUGgrU3h5ZDJQdlN2?=
 =?utf-8?B?WTdxK01mWEd6ZGNMTWNiRXQxMjVFQ0g0N1Q2TlUrMjYrcHI0UXNHN0VXM0xV?=
 =?utf-8?B?bHhEQXU5VmplSldGcVVZNTBycXh5NWxGTUhONmJKR0JZeHNiMjJrT0pqZlBX?=
 =?utf-8?B?YWd0VHFDdEROZWlFL3V4Rmh3V01lLzNreHpaMUVHb1djQ3NES2ZWc0pmSGs4?=
 =?utf-8?B?a0R3ZzIwa2xOdFlYd3pFQ08xOGJpZzZDd21mTk1abkR4UUpVR0tvMWgyczlE?=
 =?utf-8?B?Q1FDcTVSZk91UFBaL2VHLzVTL3BnYmptZU9ka0o5Y29zd3lHd3dGdDJjUFVw?=
 =?utf-8?B?cnY2V3drcEppQitWM3BUVThiajBXV3E3MGo4Kzdxb001WUZHTkpGM2tTbHNh?=
 =?utf-8?B?cFdVNkpkR25GUFgvM3d6Qy92bVlIS0liQjVBcDQrTFUxcFNLcmEwTHVSamtW?=
 =?utf-8?B?aFVoeGFtV3JlbHMzbHNHZnNLdmFFemJRQkpqcTc0NXVKK2RKdnV6Z1hwVHYv?=
 =?utf-8?B?TG9iMXd1VHVXOVNZRlI2Y0orNGxGcmh6a3hFejU2UTl5d2NDKy9UYlB0dVhh?=
 =?utf-8?B?V1lwWUFOakVrMW5qVFFQN2gzZzZHaEN6Q29mdUE0S0JzRCtkOGIxU1YwSkFX?=
 =?utf-8?B?LzRNUWpUZ3psNTUyNUNseC9lbk1vZ01HZjJkSnQ3MmQ2SkZBSTVycU1GbGds?=
 =?utf-8?B?S3pFamhWM3g1RTVEaFVKUTJFcERkRnlSMFNnTFAxS1ltWTd3WkZ4dUt2YzlB?=
 =?utf-8?B?ci9wb2JvelZQdTRBTW5vemVvak02cE5WaElMbTF1ZWFDN2NxTjRqSGY4VWFp?=
 =?utf-8?B?a2N2WjAyNUxiVTVPaTgxdDRqUndCdVlQNDRBVjViYitQbjEyS3g0YXQvOXFO?=
 =?utf-8?B?UnVrSjBWWXFnOVpKa2dQZ3cvSjREQ3VtK1RWNkcvQnQyWVNXVG9ZbE1iZlV2?=
 =?utf-8?B?ejNjdjBTSVVyM3JVbFNmVUo3Q0FCa2dVTU1WQkRjQUdQSEVSVFRXczIyQUt0?=
 =?utf-8?B?M3hBZitzKzQrTVk1M1JqRWpCQVVKbjJ0a0p3UmQ2bFJZM0EwZ3Q3N29pRzJ5?=
 =?utf-8?B?NXkzamp5ZXA0aTQxbVNleVZqQm1CemJCVSt0NWZWYjNDL1M2bStXNHp3TEJF?=
 =?utf-8?B?UksxYnhZUVA3dmswR1Y3VXdwZS9ZM0JRZ1djVnN1aDg2RHJEZjJBT0hsblFU?=
 =?utf-8?B?bTFxWURDejN1RnNUbkhQa3JoWlB4Sm5FV3AxUVZ2T0tnOFNDVzVCa1diTDVV?=
 =?utf-8?B?aEREcUgvUEJmRjE3MlB5d0tnemY0ZXk2Wlk5QllWalVGM0dXVGF3eTlvN3Uy?=
 =?utf-8?B?OU1qdFFLNUVHcjliQnlBUnpwQkxlS3duVFBRV2lXcmhTejZtUHBCM29zY2pu?=
 =?utf-8?B?MmxxOURtQVlXSTlvSmhpaWpQVHV0eWhtNS9QY0NrQnVWV2JIZG1tUTA5Vk5R?=
 =?utf-8?B?dXgzYXpxMm1kRXg3YzZpNTBUYlh5akJKUU1DdXIxR05GNVlvTWwySFo1eTRr?=
 =?utf-8?B?dzFyVEVod0FHeDdKbHBaN0txOGpqMUpPaXVuc3NOUGxhcDkybTdCVXo0TFA0?=
 =?utf-8?B?bTNUNFNGNWJ4N3NCVGcxZXRPZE5aRWU4UFo4ZHo3alF2d1JaMDFrRFJJb2to?=
 =?utf-8?B?SlBJaVhmVmRUZ2xUcDZ0UGdRallnZ21iODYxdFpjbkJIQ3U4N2NzZCtFbVU4?=
 =?utf-8?B?aExtcG5FMlp5WU9wUWduTU1tWnQ0aUFMelV4Vk1iZEp4TjNpd2JpVEV6VUE5?=
 =?utf-8?B?SFRkbHl4WW5KdnR5bWV0TFA5YzcyTXNuU2FValpvdGVzWUtjeVluN3pyL09P?=
 =?utf-8?B?dGdjMVYyS1ZJR2ZObFZWOHU0VWZnOXhQdUF1b2ZIY2hsVHZ6WklhUUxGdm9h?=
 =?utf-8?B?YW5rUllZZTRVVUdMZlhpOGd0SE1FeWxVVDFGa21KelBuVUV2d0NVMDl5eHRR?=
 =?utf-8?B?dHBOb0hMeEI3S255VmJ2a0twWG9tbC9UT3hVSE5meUhVV0VPYkw4SHlqQ2M2?=
 =?utf-8?B?WlptQjMzbUtnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnl6SFhacjQwUVBJQWxxVmV4dXZUTEhtZW92MVl1N1RGYlJRaEZleG5FVXVN?=
 =?utf-8?B?UWdUOCs3NXFEZDRJYmdSUkNnT3UrY1poQy9NYTFmMGtWbTI3aFJDNHk4aFNy?=
 =?utf-8?B?QVNQQ2xraEdGOVo3bWVJd3U4WEtIOGU1L0RFeUtXL3pTTk9uYkhvWEJINnF0?=
 =?utf-8?B?UTU2dDJUdnEzOUpRcG1Ja01Xa0tZZjVNd1JoR0hCWTNiMFNDVW1pZTVyVEIy?=
 =?utf-8?B?ZlhOZ2VpQ0JQdWdONU40UUpGOGt1YmxSUFY0ZTZDb1JCT0FGRFo0OE9QbjhE?=
 =?utf-8?B?RUl3YXYvZngyY0FXTXVTTC94dVUrWHNDUHR5a2MrSkgwWWpJb05FQldJdEoy?=
 =?utf-8?B?cS9lcjh1RHkyVlUyS2pvVFQrNDZwWVREVFo4YzNndDF0WjFSenQzVzNkV1NY?=
 =?utf-8?B?eVNwcjk3UHp3MUNKUWRqeE9FbmwrVk9CSUh2a3g5dmJLakJVcTViTjM1Szll?=
 =?utf-8?B?RGxnY2VmRmNtcG8zNmdnTVJYOGlpV1MzYXVOdVRBTGFwWG56UE05cllIa1Rs?=
 =?utf-8?B?ZEVJTVljTXJXOHVmR2tSVUxKNWViVFlqSzBsK0RpZXdIbUxOZVZhQjlaWXdF?=
 =?utf-8?B?SCsvNFpIS1A2elByUzExZFBZN1ppN09HQ01mL2tkNHNlcFZNeVBUSjBzUUFT?=
 =?utf-8?B?MmhoV2Ewcnh5VjM0bUxyMUxRaDVBazF1S0JFdGU1emhmMzNSTEtMd2pTMzNj?=
 =?utf-8?B?MmFmUDdsd0ttS0JXdDJyOXpvdUpyVUVFcDl6SDloSnBVU0JiTktCQnVQajRL?=
 =?utf-8?B?UHB6TjhtUW5vNnBSS3R1WS9zREtUWkJ1THd5SThtSFlBc0pJckhvTEV3WXdr?=
 =?utf-8?B?SnA2NW1pMnAwM3pSb012L2FIVVRCL1dWSXVENHRlcGwyeDdZOVRxNGJlY2ha?=
 =?utf-8?B?UGdLZ1h5aExvc3JvYkZPckgyR2NGdU01RlZ6ZXpudWgyS0R4ZG95U3N5MjAx?=
 =?utf-8?B?ckljWWp0UjI1MGpZQTBHU1pXTC9XNnRqSlRVRkJ5R2FLR29aT3pLQ2pXMlRm?=
 =?utf-8?B?bDZFcnJTRm1MTjY2OThNUURPNzBhd1BpRVYyRHBzUnM2L2UrSGpuNWt6M0RY?=
 =?utf-8?B?U09DQyt3Z2hEYnpndXdGSTZSNnk1VXhyNlRPWlZvMGQxSlU5NWFVSzFHUXJ5?=
 =?utf-8?B?VUc3VkVIeXlIVG4wazh3Q0pKdHcrd3hOUVJqZnFSTGhudmtFMUhscTF0R2RN?=
 =?utf-8?B?TW0zMWdYcFN4cEFqdWhXNmxHNUVZSFFFZWJrUnhzUVpOOXZGMDM5WCtqbzhW?=
 =?utf-8?B?aWhwb2YxRitDaGxob3EzeVBuSUFmb29iM3o5TmRtQ3VObkpTSVZjYkxMVzgv?=
 =?utf-8?B?blZQclVIcWl5V3Z5V3B6cE92QnVqMjBtM2VYc0RPeHUxNEpUQ202Q1gzRHU4?=
 =?utf-8?B?UllheW96OEo4b2pYVmd4Y0pzeVd6NC8xWWNUVmxKaW4yUGJTZTY3NS9tVnlZ?=
 =?utf-8?B?d2Fxb292NE00VVVCSDNFWGNUMjhyYUoyUkVMQjc2aVI1TU9DU0FvMFdjenA4?=
 =?utf-8?B?QTd0VXlzd1NWVTAyTHJoNFhxT29ZNWdjazBXQ2xZdEFLRk1KQjZ0V0d3aHB1?=
 =?utf-8?B?NjdTQllZY1lrSGpvZytkT015UEJ3Z3dSaXZNRHJTa3BnVkE5eHZuWDR2MGkr?=
 =?utf-8?B?d3E4UDY3bithQTdZRzdGWXRMOHo1MXJPMXFpcHpSN1BCYlV6a2cwaDNsYWUx?=
 =?utf-8?B?d0Z3dEZ5WmRQVG1MalNCQUFySis4QmZUYlJVWnRGazcvVzRWZ0s0SklKRVRK?=
 =?utf-8?B?NXZjMnFhbDNaMWdLVFdRdGhQclFTVk5lK1JETHN1WU1mNTRtdm55azF1U3VR?=
 =?utf-8?B?K0U5UlZxS2trS0VEdThpTDVyVE45RTdhN0dGaFIyVm16Z2RBOThvcnEzNFVC?=
 =?utf-8?B?UUlpSmIyNGlkaXhFZUFrZ3FEKzBOY3JsTmF2ZGJlSXE5MlAraXF0eldUQVVF?=
 =?utf-8?B?ZWdqSktZa09VWW9JZG9NRHRNcVQyUVBtU3JBMVRnc3NYWUFPREcrTDdJbHA0?=
 =?utf-8?B?cWdTMWNkWnZwN1ZXbHloVDQ3N1NRbGdVSndNWjEyQ3R4V0d4SUpMakU2QW5s?=
 =?utf-8?B?djIvcWlCUktJdkNqaEJEUVBVUXRMZm1xMmVmZzhIMGJuNlpWSjBVcEtBMGFa?=
 =?utf-8?Q?9Mvpx2HXCIL10dDd48aNGe5SH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D02B0743372F7B4483F6C94020841F6E@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8545c2-dc69-40a3-3ec1-08dd9753fda8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 04:08:34.9900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoQN58NtS98cLX2T/BYR86EtgkOyGcThUvClqqpXJ24bejAe9M27RROUTAHwwMhP16LL7lls7mRcvE+m5zb4hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9204

T24gMTkvMDUvMjUgNDoxNyBwbSwgRGhhcm1hIEIgd3JvdGU6DQo+IE9uIDE4LzA1LzI1IDE6MTEg
cG0sIFdpbGxpYW0gQnJlYXRoaXR0IEdyYXkgd3JvdGU6DQo+PiBPbiBUaHUsIE1heSAxNSwgMjAy
NSBhdCAxMDoyODoyNUFNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6DQo+Pj4g
SW50cm9kdWNlIGEgd2F0Y2ggdmFsaWRhdGlvbiBjYWxsYmFjayB0byByZXN0cmljdCBzdXBwb3J0
ZWQgZXZlbnQgYW5kDQo+Pj4gY2hhbm5lbCBjb21iaW5hdGlvbnMuIFRoaXMgYWxsb3dzIHVzZXJz
cGFjZSB0byByZWNlaXZlIG5vdGlmaWNhdGlvbnMgDQo+Pj4gb25seQ0KPj4+IGZvciB2YWxpZCBl
dmVudCB0eXBlcyBhbmQgc291cmNlcy4gU3BlY2lmaWNhbGx5LCBlbmFibGUgdGhlIGZvbGxvd2lu
Zw0KPj4+IHN1cHBvcnRlZCBldmVudHMgb24gY2hhbm5lbHMgUkEsIFJCLCBhbmQgUkM6DQo+Pj4N
Cj4+PiDCoMKgIC0gQ09VTlRFUl9FVkVOVF9DQVBUVVJFDQo+Pj4gwqDCoCAtIENPVU5URVJfRVZF
TlRfQ0hBTkdFX09GX1NUQVRFDQo+Pj4gwqDCoCAtIENPVU5URVJfRVZFTlRfT1ZFUkZMT1cNCj4+
PiDCoMKgIC0gQ09VTlRFUl9FVkVOVF9USFJFU0hPTEQNCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6
IERoYXJtYSBCYWxhc3ViaXJhbWFuaSA8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4NCj4+PiAtLS0N
Cj4+PiDCoCBkcml2ZXJzL2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmMgfCAyOCArKysr
KysrKysrKysrKysrKysrKysrIA0KPj4+ICsrKy0tLQ0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY291bnRlci9taWNyb2NoaXAtdGNiLWNhcHR1cmUuYyBiL2RyaXZlcnMvIA0KPj4+IGNv
dW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmMNCj4+PiBpbmRleCAxZGUzYzUwYjk4MDQuLjE3
OWZmNTU5NTE0MyAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2NvdW50ZXIvbWljcm9jaGlwLXRj
Yi1jYXB0dXJlLmMNCj4+PiArKysgYi9kcml2ZXJzL2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0
dXJlLmMNCj4+PiBAQCAtMzM3LDYgKzMzNywyNyBAQCBzdGF0aWMgc3RydWN0IGNvdW50ZXJfY29t
cCBtY2hwX3RjX2NvdW50X2V4dFtdID0gew0KPj4+IMKgwqDCoMKgwqAgQ09VTlRFUl9DT01QX0NP
TVBBUkUobWNocF90Y19jb3VudF9jb21wYXJlX3JlYWQsIA0KPj4+IG1jaHBfdGNfY291bnRfY29t
cGFyZV93cml0ZSksDQo+Pj4gwqAgfTsNCj4+Pg0KPj4+ICtzdGF0aWMgaW50IG1jaHBfdGNfd2F0
Y2hfdmFsaWRhdGUoc3RydWN0IGNvdW50ZXJfZGV2aWNlICpjb3VudGVyLA0KPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCBjb3VudGVyX3dhdGNoICp3
YXRjaCkNCj4+PiArew0KPj4+ICvCoMKgwqAgc3dpdGNoICh3YXRjaC0+Y2hhbm5lbCkgew0KPj4+
ICvCoMKgwqAgY2FzZSBDT1VOVEVSX01DSFBfRVZDSE5fUkE6DQo+Pj4gK8KgwqDCoCBjYXNlIENP
VU5URVJfTUNIUF9FVkNITl9SQjoNCj4+PiArwqDCoMKgIGNhc2UgQ09VTlRFUl9NQ0hQX0VWQ0hO
X1JDOg0KPj4NCj4gSGkgV2lsbGlhbSwNCj4gDQo+PiBIZWxsbyBEaGFybWEsDQo+Pg0KPj4gSW5j
bHVkZSBDT1VOVEVSX01DSFBfRVZDSE5fQ1YgYXMgd2VsbCBmb3IgdGhlIHNha2Ugb2YgY29tcGxl
dGVuZXNzLiBJDQo+PiBrbm93IENPVU5URVJfTUNIUF9FVkNITl9DViBhbmQgQ09VTlRFUl9NQ0hQ
X0VWQ0hOX1JBIGhhdmUgdGhlIHNhbWUNCj4+IHVuZGVybHlpbmcgY2hhbm5lbCBpZCwgYnV0IHdl
J3JlIGFic3RyYWN0aW5nIHRoaXMgZmFjdCBzbyBpdCdzIGdvb2QgdG8NCj4+IG1haW50YWluIHRo
ZSBjb25zaXN0ZW5jeSBvZiB0aGUgYWJzdHJhY3Rpb24gYWNyb3NzIGFsbCBjYWxsYmFja3MuDQo+
IA0KPiBUbyBhdm9pZCB0aGUgY29tcGlsZXIgZXJyb3IgZHVlIHRvIENPVU5URVJfTUNIUF9FVkNI
Tl9DViBhbmQgDQo+IENPVU5URVJfTUNIUF9FVkNITl9SQSBzaGFyaW5nIHRoZSBzYW1lIHVuZGVy
bHlpbmcgdmFsdWUsIHdvdWxkIGl0IGJlIA0KPiBzdWZmaWNpZW50IHRvIGluY2x1ZGUgYSBjb21t
ZW50IGluZGljYXRpbmcgdGhhdCBib3RoIHJlcHJlc2VudCB0aGUgc2FtZSANCj4gY2hhbm5lbCBJ
RD8gT3Igd291bGQgeW91IHByZWZlciB0aGF0IEkgZHVwbGljYXRlIHRoZSBsb2dpYyBleHBsaWNp
dGx5IA0KPiBmb3IgdGhlIHNha2Ugb2YgYWJzdHJhY3Rpb24gY29uc2lzdGVuY3ksIGRlc3BpdGUg
dGhlIHNoYXJlZCB2YWx1ZT8NCg0KSSBqdXN0IHJlcGxhY2VkIHN3aXRjaCBzdGF0ZW1lbnRzIHdp
dGggaWYgY29uZGl0aW9uIHRvIHJlc29sdmUgdGhlIA0KY29tcGlsZXIgZXJyb3IgYW5kIGFkZGVk
IENWLCBSQSBmb3IgY29tcGxldGVuZXNzLg0KDQo+IA0KPj4NCj4+PiArwqDCoMKgwqDCoMKgwqAg
c3dpdGNoICh3YXRjaC0+ZXZlbnQpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBDT1VOVEVS
X0VWRU5UX0NBUFRVUkU6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGNhc2UgQ09VTlRFUl9FVkVOVF9D
SEFOR0VfT0ZfU1RBVEU6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGNhc2UgQ09VTlRFUl9FVkVOVF9P
VkVSRkxPVzoNCj4+PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBDT1VOVEVSX0VWRU5UX1RIUkVTSE9M
RDoNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+DQo+PiBUaGUgd2F0
Y2hfdmFsaWRhdGUgY2FsbGJhY2sgaXMgdXNlZCB0byBlbnN1cmUgdGhhdCB0aGUgcmVxdWVzdGVk
IHdhdGNoDQo+PiBjb25maWd1cmF0aW9uIGlzIHZhbGlkOiBpLmUuIHRoZSB3YXRjaCBldmVudCBp
cyBhcHByb3ByaWF0ZSBmb3IgdGhlDQo+PiB3YXRjaCBjaGFubmVsLg0KPj4NCj4+IExvb2tpbmcg
YXQgaW5jbHVkZS91YXBpL2xpbnV4L2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmg6DQo+
Pg0KPj4gwqDCoMKgwqDCoCAqIENoYW5uZWwgMDoNCj4+IMKgwqDCoMKgwqAgKiAtIENWIHJlZ2lz
dGVyIGNoYW5nZWQNCj4+IMKgwqDCoMKgwqAgKiAtIENWIG92ZXJmbG93ZWQNCj4+IMKgwqDCoMKg
wqAgKiAtIFJBIGNhcHR1cmVkDQo+PiDCoMKgwqDCoMKgICogQ2hhbm5lbCAxOg0KPj4gwqDCoMKg
wqDCoCAqIC0gUkIgY2FwdHVyZWQNCj4+IMKgwqDCoMKgwqAgKiBDaGFubmVsIDI6DQo+PiDCoMKg
wqDCoMKgICogLSBSQyBjb21wYXJlIHRyaWdnZXJlZA0KPj4NCj4+IElmIEknbSB1bmRlcnN0YW5k
aW5nIGNvcnJlY3RseSwgY2hhbm5lbCAwIHN1cHBvcnRzIG9ubHkgdGhlDQo+PiBDSEFOR0VfT0Zf
U1RBVEUsIE9WRVJGTE9XLCBhbmQgQ0FQVFVSRSBldmVudHM7IGNoYW5uZWwgMSBzdXBwb3J0cyBv
bmx5DQo+PiBDQVBUVVJFIGV2ZW50czsgYW5kIGNoYW5uZWwgMiBzdXBwb3J0cyBvbmx5IFRIUkVT
SE9MRCBldmVudHMuDQo+IA0KPiBTaG91bGRuJ3QgaXQgYmUNCj4gDQo+IC8qDQo+ICDCoCogQ2hh
bm5lbCAwIChFVkNITl9DVik6DQo+ICDCoCrCoMKgIC0gQ1YgcmVnaXN0ZXIgY2hhbmdlZMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCDihpIgQ09VTlRFUl9FVkVOVF9DSEFOR0VfT0ZfU1RBVEUNCj4g
IMKgKsKgwqAgLSBDViBvdmVyZmxvd2VkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIOKGkiBDT1VOVEVSX0VWRU5UX09WRVJGTE9XDQo+ICDCoCoNCj4gIMKgKiBDaGFubmVsIDEg
KEVWQ0hOX1JBKToNCj4gIMKgKsKgwqAgLSBSQSBjYXB0dXJlZMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAg4oaSIENPVU5URVJfRVZFTlRfQ0FQVFVSRQ0KPiAgwqAqDQo+
ICDCoCogQ2hhbm5lbCAyIChFVkNITl9SQik6DQo+ICDCoCrCoMKgIC0gUkIgY2FwdHVyZWTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKGkiBDT1VOVEVSX0VWRU5UX0NB
UFRVUkUNCj4gIMKgKg0KPiAgwqAqIENoYW5uZWwgMyAoRVZDSE5fUkMpOg0KPiAgwqAqwqDCoCAt
IFJDIGNvbXBhcmUgdGhyZXNob2xkIHJlYWNoZWTCoMKgwqAg4oaSIENPVU5URVJfRVZFTlRfVEhS
RVNIT0xEDQo+ICDCoCovDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgbWUgdW5kZXJzdGFu
ZCB3aGV0aGVyIHRoZXNlIGFyZSBsb2dpY2FsIGNoYW5uZWxzIA0KPiBvciBoYXJkd2FyZSBjaGFu
bmVscyByZWxhdGVkIHRvIHRoZSByZWc/DQo+IA0KPj4NCj4+IEFkanVzdCB0aGUgY29kZSB0byBl
bnN1cmUgdGhvc2UgbGltaXRhdGlvbnMuDQo+Pg0KPj4+ICvCoMKgwqDCoMKgwqDCoCBkZWZhdWx0
Og0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPj4+ICvCoMKg
wqDCoMKgwqDCoCB9DQo+Pj4gK8KgwqDCoCBkZWZhdWx0Og0KPj4+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLUVJTlZBTDsNCj4+PiArwqDCoMKgIH0NCj4+PiArfQ0KPj4+ICsNCj4+PiDCoCBzdGF0
aWMgc3RydWN0IGNvdW50ZXJfY291bnQgbWNocF90Y19jb3VudHNbXSA9IHsNCj4+PiDCoMKgwqDC
oMKgIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLmlkID0gMCwNCj4+PiBAQCAtMzUxLDEyICsz
NzIsMTMgQEAgc3RhdGljIHN0cnVjdCBjb3VudGVyX2NvdW50IG1jaHBfdGNfY291bnRzW10gPSB7
DQo+Pj4gwqAgfTsNCj4+Pg0KPj4+IMKgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY291bnRlcl9vcHMg
bWNocF90Y19vcHMgPSB7DQo+Pj4gLcKgwqDCoCAuc2lnbmFsX3JlYWTCoMKgwqAgPSBtY2hwX3Rj
X2NvdW50X3NpZ25hbF9yZWFkLA0KPj4+ICvCoMKgwqAgLmFjdGlvbl9yZWFkwqDCoMKgID0gbWNo
cF90Y19jb3VudF9hY3Rpb25fcmVhZCwNCj4+PiArwqDCoMKgIC5hY3Rpb25fd3JpdGXCoMKgID0g
bWNocF90Y19jb3VudF9hY3Rpb25fd3JpdGUsDQo+Pj4gwqDCoMKgwqDCoCAuY291bnRfcmVhZMKg
wqDCoMKgID0gbWNocF90Y19jb3VudF9yZWFkLA0KPj4+IMKgwqDCoMKgwqAgLmZ1bmN0aW9uX3Jl
YWTCoCA9IG1jaHBfdGNfY291bnRfZnVuY3Rpb25fcmVhZCwNCj4+PiDCoMKgwqDCoMKgIC5mdW5j
dGlvbl93cml0ZSA9IG1jaHBfdGNfY291bnRfZnVuY3Rpb25fd3JpdGUsDQo+Pj4gLcKgwqDCoCAu
YWN0aW9uX3JlYWTCoMKgwqAgPSBtY2hwX3RjX2NvdW50X2FjdGlvbl9yZWFkLA0KPj4+IC3CoMKg
wqAgLmFjdGlvbl93cml0ZcKgwqAgPSBtY2hwX3RjX2NvdW50X2FjdGlvbl93cml0ZQ0KPj4+ICvC
oMKgwqAgLnNpZ25hbF9yZWFkwqDCoMKgID0gbWNocF90Y19jb3VudF9zaWduYWxfcmVhZCwNCj4+
DQo+PiBJdCdzIG5pY2UgdG8gYWxwaGFiZXRpemUgdGhlIGNvdW50ZXJfb3BzIGNhbGxiYWNrcywg
YnV0IGl0J3MgYWxzbw0KPj4gdW5yZWxhdGVkIHRvIHRoZSB3YXRjaF92YWxpZGF0ZSBpbXBsZW1l
bnRhdGlvbi4gTW92ZSB0aGUgYWxwaGFiZXRpemF0aW9uDQo+PiBjbGVhbnVwIHRvIGEgc2VwYXJh
dGUgcGF0Y2ggc28gdGhhdCB0aGlzIHBhdGNoIHJlbWFpbnMgZGVkaWNhdGVkIHRvDQo+PiBqdXN0
IHdhdGNoX3ZhbGlkYXRlIGNoYW5nZXMuDQo+IA0KPiBTdXJlLCBJIHdpbGwgZHJvcCBzb3J0aW5n
IGluIHRoaXMgcGF0Y2guDQo+IA0KPj4NCj4+IFRoYW5rcywNCj4+DQo+PiBXaWxsaWFtIEJyZWF0
aGl0dCBHcmF5DQo+IA0KPiANCg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhhcm1hIEIu
DQo=

