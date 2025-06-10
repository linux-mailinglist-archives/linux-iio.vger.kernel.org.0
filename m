Return-Path: <linux-iio+bounces-20368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A9AD3E31
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 18:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903F018840C8
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8823AE9B;
	Tue, 10 Jun 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jM6Lst6O"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377D15A85A;
	Tue, 10 Jun 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571447; cv=fail; b=W0puFaXFHKGig5h7eMv6iFeFNFxjnviYbBm50sA95qQ6dyPCSwJShRPHhWIEF3c4pFcllKDlXBPp4+URqehsm1rvLSvxWwugQmmbQvgfCkvb233rD7trJnTO/nffFeYfEHOuvSc4/qdL/ZW9WKDivTWZ6AGnSB8YyfLaaUDRPCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571447; c=relaxed/simple;
	bh=V7AMw8npoezisiuYHGYIYP4807ZqqW4EZ9e+3VPi0WQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yg0FDL6MZ2vGlr9vdY4piz9WHbNhycwTz+6mbxwR+u93MHcwwAczSOL7uKoAIs75LPgJ8VxQd1KM3rULYhGEwmjWFz56MN26Wa2R8Fhm/1k+QYqJstvk0ypq4XuK/Ue/EShn8vgHYXpgNNzWzA2mTsgU/lnE2GmYTt24ERnTAAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jM6Lst6O; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEJ5u1mkrKe5kfNI/R6So8/oB7DNXOSf+EG6DynTX86qEG4v3gI8VgbnVbYvEzhL40iNK7THahgmKLT1TDBfHbjpyHIN1+KCOStdrHvvFqXzVjnjSWmuZrUOEJ4Ua4b3Mh33FrCab8NnsimbcnJg8KvGEZHwrjlkBqAzGRmn5SpkIT4SjImc88EZR/TOz+ZfFGo9Ub2o3z0ZDfeKK7QwPYy/mTXNSSBJxHTSgy/daoTXJlxu2njiaXczhnrTO8RGqf9aKJ0ur9EYq9IBr+u/zsIJotPX1hh1tPV6dcOmEyWih7/mImgvqLx1ZoeaIIOfTPObIswlZt6l9ChxB128kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7AMw8npoezisiuYHGYIYP4807ZqqW4EZ9e+3VPi0WQ=;
 b=vi7liot2NEYPs4MknO8ntvCoZmzwtqx80feD9IFl9LMqm20PpVt7JaxgqnNxw7KzsJwNU0iLE5ALMpLjnONc2xT8AKvFf7lv0YXILWWJhGOGHuVfyQ9EdaNUMz3sv34j7NzkJk44qxFH4NO2Wq0uRym1eX21OXdwtwWJN4fcbISMyk2OwZJUBCt0apGB4W2zq8Yjrrk+ee41aViFeFBuBNAT4iltwmHNQbAwMF1lt8885QiXx01KVIA+ElYPT2jP2J+zCKAwb+EIDaWNsRKckfPRYt5MCfujnL5wVWZNezuXyAWGx5xTWav0kTK2/fCJe1iedycke10Bpe6LGIjx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7AMw8npoezisiuYHGYIYP4807ZqqW4EZ9e+3VPi0WQ=;
 b=jM6Lst6O36dyj9ekCI3vE83jEWrvfmmmJKq+8ft/XuECPFVZo21xWuBtYqw/frcp61p5ChtvFTh2KqPaT1OwdtpdiBG2WjqTbMx2F2G2d6NS28XNWaOB7I6DBnO7J4DUSLqYDLzFr8J0jDZxeLCwa1ifUyif1oE4wdfhLsF9HFSWRdSnX5PRB9VWlQ/D8BlF1cYSNLCWMVKmSRATU4dwr6eSmWDkBYQJXDXV0RLTJwrbcouZQD1xgT8atxQdbTX7SksTFSVPD7y9jGU4d3cs7RWF7pp0GZdPlNQRj3ve4J3IzkgP+5sZh4ZdvVI3o+k/8ie2HlEmVQGOYGtYeUtEqA==
Received: from BY5PR11MB4088.namprd11.prod.outlook.com (2603:10b6:a03:185::32)
 by DM4PR11MB7277.namprd11.prod.outlook.com (2603:10b6:8:10b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 16:04:01 +0000
Received: from BY5PR11MB4088.namprd11.prod.outlook.com
 ([fe80::cd6c:df72:8d4c:16fa]) by BY5PR11MB4088.namprd11.prod.outlook.com
 ([fe80::cd6c:df72:8d4c:16fa%7]) with mapi id 15.20.8813.018; Tue, 10 Jun 2025
 16:04:01 +0000
From: <Marius.Cristea@microchip.com>
To: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
	<andy@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<broonie@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC194X
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC194X
Thread-Index: AQHb1sb7EyODSGnwD0KxSyH5e3G/VbP2SOCAgAY2XYCAAAoyAIAAC5CA
Date: Tue, 10 Jun 2025 16:04:00 +0000
Message-ID: <a9902463d1f29993f13ce0bc87fcfb05472624d5.camel@microchip.com>
References: <20250606093929.100118-1-marius.cristea@microchip.com>
	 <20250606093929.100118-2-marius.cristea@microchip.com>
	 <92c36ad9-5f8e-4ba7-9af4-9cb640f0aa5c@baylibre.com>
	 <d364524bad53f5c665071287f55a96e28dc9b231.camel@microchip.com>
	 <db78ac20-9b58-49d1-ba38-cc269eaff254@baylibre.com>
In-Reply-To: <db78ac20-9b58-49d1-ba38-cc269eaff254@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4088:EE_|DM4PR11MB7277:EE_
x-ms-office365-filtering-correlation-id: 546a2f76-9fab-4b14-5e1f-08dda8386a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?LzVxSUFYelplY2hGN3NkUGpWS3FJT1EzbDVhTit0V0NpTkpGcUhxUlV6MDVI?=
 =?utf-8?B?Z0l5VzhFaVJ1YnQ0SFcydE5JZHJEMEt5SjFVZHlLT3llUjYvb2ltS1VpUENW?=
 =?utf-8?B?QU5Fa0UyVERJZ0RZZzEyZzIwTGtyeVpVNHRwNGFmWDhJVVFQUExYdEYwVFpO?=
 =?utf-8?B?blFuMFYvbGllTW9UYlU4ZHlPK1NCZlBWZERma01GSWMwL0tPb2lnUXhzWFVj?=
 =?utf-8?B?YXpCWGc3NHBuUlJsTW0rcG9MclNnemF1bnVvWVdkcWtjbVh5MURCMmNUeXVF?=
 =?utf-8?B?elJXYWhla2ZSL3JkTWswd2k5YW5HSkRJc0NqRG1yMWRiVUFoWjZDeXBhTVpP?=
 =?utf-8?B?RHI0bW9zQ05aZFBaR2FFa2psaE5QeGdBSTFVUUxEWEQ2ZW16RVczYmIwRnhz?=
 =?utf-8?B?RzNwMFN6ejNzaERLVC9CVW1jTCtxZjk0dm5xcmxBYUtqaENxc0NnanNqS0sr?=
 =?utf-8?B?VnlWZStNS1hwRzlRYUJVcTFlc3E3bTNoWWV3N1Iwd2RqNUQvNVdDQnYzdjVu?=
 =?utf-8?B?MUFGZjk3aGZnaUFXMGEvdmtIS3BMempaN09EK3FCRm5kblF1bzJlcHMreTFn?=
 =?utf-8?B?REt1dGc5VXNlRGZQR2VxUnJmQVNyelpHUk0vSVpJdC9OTnhEaDc4OWV5SmZw?=
 =?utf-8?B?Zy9ocGwvbXpmb0ZsS3JiNE5jdUlrSm1BOVN5SWNsc29hN2l4dGdwVjN4ODE4?=
 =?utf-8?B?RFc2UnRTNS9icjJFZXpFRnpOUG5TK0didzFuY2NQWGl1MDdsWTNEYjgxeEFn?=
 =?utf-8?B?T1F0Rm8xR2lmVU01VmNLcjJvWlpvYThxVWtybXVpZUppQlJiaDZuNnZxckFM?=
 =?utf-8?B?NEhaVUFjaGJOdGgrSytIUWtLRGZ3VXpyODd1TVBUa3l1S2dIWFBDeEJ5Y0Q2?=
 =?utf-8?B?Y3VtbTNvWnAxNHNpSVpBU3prd004NmZhWDNJSW9nbHFCNEsveW13OElnTDZI?=
 =?utf-8?B?ZFZ1aU9QZ3NqdENqS0VYSTZxRUZoMjJranNkS2tjMnpyZ1R6Y0ZqS3IvN2Y3?=
 =?utf-8?B?S2dWTHdaY3duMHhDdGZqdWY1b3d5azd1MWJWYnNkL2d6VHh0TkNEVmRMaTFP?=
 =?utf-8?B?eHMxclJnT0ZyekF0ZU11M200cDdEcXVUVjJBeVQzUlBVS0lXcUI0d0hrSU5m?=
 =?utf-8?B?M2xZS3QzVmc2c1JMVlVyMWc5T0dEQ3Y4bUlLS3hsTHNEV3dVamw0cHZsTlJQ?=
 =?utf-8?B?R0ZxNGVXcEwzS1lBMHAxeHo5K0hYdG5UY1dLUUdtcWRTM0VoNFNySGc0b1Fr?=
 =?utf-8?B?dGJxMDQ3b0JIUDhGOTlLbElwa2YraGE3REpUVGR3ZDYwM3p3UFEwQXpkYjVS?=
 =?utf-8?B?cVlpUFU5QndSMTF5NERmWmFZcWRoR1kwZ0lDQ21zOUNYeGJ0US9wZ0hHM0VE?=
 =?utf-8?B?d3ZKQ2U1djU5SE1QRVpJUDdMYXNiTmEwYVFDeWtxNUhBUm1GMGI3OEZuSGRi?=
 =?utf-8?B?eDFxTDFoUFlTdXBMaENyU0UvQ1U2dzhNdVpOTng1dXBwU0N1bWtlUS9aUVNC?=
 =?utf-8?B?WlBocTEyVitBN1FNOUxKNFhLZVdZK0tPYmVjMUt6clJsZXRVcElPaUxsVXFZ?=
 =?utf-8?B?VVFsWDRhMlJ2bFRIUW1sS3lsVG9QZGxHS25BdTlZU3ZZUHN6QW9haUxNV0c4?=
 =?utf-8?B?NUVJVld6eDU5dFdvOUluVjM0RkVWQUJ3TDlCYjRKQWtwbys3aUp1cUExcWtn?=
 =?utf-8?B?WW5jM05iNHQ2YXJpc2l5R1dxMmpNbW54ZVNDQjFKQUNRd3NhL0lwNXR2T2M5?=
 =?utf-8?B?c09wZmJ4c2FPdFYzSmR1S3duOU92U2ZsTmxQdlBodmNCNlFycEt2S1NUYlhQ?=
 =?utf-8?B?WWl3bTRQbFRxODdQbmhPeXhZQ0lkY1d0NUdrclZVMDE3Z0lEbzh5ZkkyLzVW?=
 =?utf-8?B?eUFpWGV5TGhUMkRYZDk1dTIyOGtQR2l3ZEJXZUFNMWFkTWdncEhtdWFYVmpH?=
 =?utf-8?B?Z3ErNnpGb2ZqV2VKN1JFSk53TzFqL205YjdoUTRjUERGb2tpVWZJbHlvYkhk?=
 =?utf-8?Q?SjoEgWYsUfFbTzVRN8dCLS8KJJHo3M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4088.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUlRRWhaSlFPSzR5SGFwd3prZFd5RHRXV1ppR0YwV0N0cXAwa0tNaHpNUDBt?=
 =?utf-8?B?ZXZacHJ4QzJIWmRzMlozeVNrS1BTV09PcElZTjY3MGRCcmg4Q0pwNk1pcGFr?=
 =?utf-8?B?dHduL3FBcXdNVjk2czVkKy8vZHl6RFh3a2w5ajZDWEtMSFBDZEJIdFBkZDBN?=
 =?utf-8?B?WjNrbWM4UE5WcW9WZUtCMGxYNEc4dkkrYXI3MENXUG5EemRsSk1ReHRBNWNO?=
 =?utf-8?B?SkNrRXZxcWJSNW44U0UzMjNTT1FLOW1FR0V2MWpiNmNVdkxSMHlsL0xNa09v?=
 =?utf-8?B?ZHhBWUw4VG9aZzNVTXU2dGpyTi9qYkxvZDdWTnNRS2J1ZlBYaENsZk81RG42?=
 =?utf-8?B?cXZCSk50RzUvMjRYdG1oT1NabE5oK2lmcHF4bU5uTFRxdDlaRTdLNXhoejc3?=
 =?utf-8?B?RGQ4OHF1UDJNejhFOTd3cFIxd2RLUFpveENNVnZraWl1MHphdzl4d1lQUC93?=
 =?utf-8?B?UlgvaGxxdGczM1UvOTgvUGdtTkVvdFVQNEV2bnE2eUtaNmRuTGxiblRwZE5D?=
 =?utf-8?B?TWtJR1R3Z1Z2TzFYS0UwcFlYc1RoMFB4Nk1mZlFUU3ZCcHR3Z0NrdjNjQVNy?=
 =?utf-8?B?Tmg5dkU5N2pNS0xTeWpPM2JZdVRjK3crdE4vNk9ScVhPZnJybGxRZ2ZTK2VU?=
 =?utf-8?B?bjhNakFMSnVwdHdoWGFVbmlkRWRiajljeE9KL1BJTUw3WjFNOTZseWFTWGVk?=
 =?utf-8?B?MHNuQmVnY3dPTDhuN2U5U0wzUTV2dXJvT2tVVnM0SWw1YlIxMTZneWtqdmpy?=
 =?utf-8?B?eEtDTkRlUmhhQnd1dE1WdkZhdk9CbDdSbjJIMDg1N3FnOU5BYmc0QmJVTHJ4?=
 =?utf-8?B?QXorVnJPbWVwZFhWMnNGTTJqbStaS0t3dHA3WWpUUTA2NW9aNWM2Uy9lU09k?=
 =?utf-8?B?NlliSXhtR0JPS0hudVI3YjgzRjI5UktLQSs2MmFXZGxuTTNPQ1h1amVzOWdR?=
 =?utf-8?B?TWZsTEhBdFk0dGZqelNIQk9mTGhZbmNONUNpRG56OEx4REhtejh5U2pqVStC?=
 =?utf-8?B?OUprTW1hMVF4UFQ1NUpMMUNOVWJ0OVlaOXY1b2RETXRKQzBucGxMdjZuWitq?=
 =?utf-8?B?SFUwdkR0Mmx0eHJmY1c5RjBvbldVbndVNmRLNlVLODJKc3pFMjNPMmFxSWpG?=
 =?utf-8?B?bktQbWxTQTRSR0pCMnc4dElLN0pNSUUrOEtiSWtYSDNOVEJsUVYyTmRyS3Ba?=
 =?utf-8?B?RFdQQURjMmp0WnJKWjZxbWs2MUo4eG5BallzVEFRTmhFNTFneFFLdDZvU0Nh?=
 =?utf-8?B?U0xyQmpjZXBxNStTZWFzNFJINnh6RGhRc290TGNxZGF4Z0JlaGx6VXBieXh1?=
 =?utf-8?B?TmpWTEV2WEUzRkZ4MXh6VXo1ODJ1UmJRN0dvNTFtM2RYejhROHVpNXpoWFQv?=
 =?utf-8?B?cFBCVGxXSHF5dGlrT2lhT3hYQ1hxOVcrSHRVOFlza2h5RWxmcmk4NnIvNjEy?=
 =?utf-8?B?NW5wRjVxT3BQaWtFdHQwVnR2WGMvSzNIcGF0SVZIY3hubTlET3EzdzlYNkZW?=
 =?utf-8?B?KzlHMGNpYU9ESGI3QjY2TCtTSC9lYU1WVUpSZERUY2NXVlkxUFl1SUc1NzQz?=
 =?utf-8?B?S1M4dVRia2tUK1IxamRnYW1uU3VSNXg4Z244bEtiVUdWTzlvUXlnNnVjUWht?=
 =?utf-8?B?MzBnWkdQV0VQakM0U1N5a1lMNkdGV3hCVnZ0amV2NUtQQlYzM2s3eFpvSEZC?=
 =?utf-8?B?L282MUxCWDVGVkZtU09DbjkyQk5VQzVMZDBVZzZWUDJIdTZiK29JVWNTM3Yz?=
 =?utf-8?B?V0xUeVYxU2Y0Q2pPdDNiclNPK2pMVnRiT2lwNEo1ak5hQjFYOTkzK1cxZXMw?=
 =?utf-8?B?U0E0M3llQ2Vwb0NLY1FYQ3F6dlJuTDRMZlFaVTRqNlFmMk9lc1NxdkZRMUJM?=
 =?utf-8?B?YjZEWmNGTm9wY0VnTWIzME0wb1lDUHMycVdqS0k2NmNVaWxOLy92LzdXK0hN?=
 =?utf-8?B?dE1OQWg3L1g5ZjhOaW1FRUxrdWtoeUJENCtNVlZ1S3lvTFkzOEswbHNkdERs?=
 =?utf-8?B?WklxTmNXWjFmRGdTcXB5dVlVaGF6VHJ6OWZlejRBL1c0ZG9RcFdaQWRSRS8x?=
 =?utf-8?B?ajRPUGZPZXRxSUh5VC9PcTUvRUlqT1NJRFlYRmdZc0JLMHVQQ011MXF6dkU2?=
 =?utf-8?B?R2RkLzF5UC90MmpSM2xoeTkrbk9LS1FYQ3dCeGpEL0JVQll5d05QZmxnRkZz?=
 =?utf-8?Q?nygQRycFzvMzL5Q4UKnjBzc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C52CB7645F5AA54497E6300D449A1057@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4088.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546a2f76-9fab-4b14-5e1f-08dda8386a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 16:04:01.0148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRA51u1JeVtnlXzpowlBZM730w9mR0xYoqURf7PXSCIa3czQep1joLhRp4W/II/JPNs0Frf+bs2hOVb55blhokcsPFaJlAoQbVsnhwdGax0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7277

T24gVHVlLCAyMDI1LTA2LTEwIGF0IDEwOjIyIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDYvMTAvMjUg
OTo0NiBBTSwgTWFyaXVzLkNyaXN0ZWFAbWljcm9jaGlwLmNvbcKgd3JvdGU6DQo+ID4gSGkgRGF2
aWQsDQo+ID4gDQo+ID4gwqDCoCBUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4gUGxlYXNlIHNl
ZSBteSBjb21tZW50cyBiZWxvdy4uLg0KPiA+IA0KPiANCj4gLi4uDQo+IA0KLi4uDQo+IA0KPiA+
ID4gPiArDQo+ID4gPiA+ICvCoMKgwqDCoMKgIG1pY3JvY2hpcCx2YnVzLWhhbGYtcmFuZ2U6DQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy9mbGFnDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBkZXNjcmlwdGlvbjogfA0KPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgIEluIG9yZGVyIHRvIGluY3JlYXNlIG1lYXN1cmVtZW50IHJl
c29sdXRpb24gYW5kDQo+ID4gPiA+IGtlZXBpbmcNCj4gPiA+ID4gdGhlIHNhbWUNCj4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoCBudW1iZXIgdGhlIG9mIGJpdHMgdGhlIGRldmljZSBoYXMgYSBj
b25maWd1cmFibGUNCj4gPiA+ID4gVkJVUw0KPiA+ID4gPiBmdWxsIHJhbmdlIHNjYWxlDQo+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgKEZTUikuIFRoZSByYW5nZSBzaG91bGQgYmUgc2V0IGJ5
IGhhcmR3YXJlIGRlc2lnbg0KPiA+ID4gPiBhbmQgaXQNCj4gPiA+ID4gc2hvdWxkIG5vdCBiZQ0K
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIGNoYW5nZWQgZHVyaW5nIHJ1bnRpbWUuIFRoZSBi
aXBvbGFyIGNhcGFiaWxpdHkgZm9yDQo+ID4gPiA+IFZCVVMNCj4gPiA+ID4gZW5hYmxlcw0KPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIGFjY3VyYXRlIG9mZnNldCBtZWFzdXJlbWVudCBhbmQg
Y29ycmVjdGlvbi4NCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBUaGUgVkJVUyBjb3VsZCBi
ZSBjb25maWd1cmVkIGludG8gdGhlIGZvbGxvd2luZyBmdWxsDQo+ID4gPiA+IHNjYWxlIHJhbmdl
Og0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIFZCVVMgaGFzIHVuaXBvbGFyIDBW
IHRvIDMyViBGU1IgKGRlZmF1bHQpIGZvcg0KPiA+ID4gPiBQQUMxOTVYIG9yIDBWIHRvIDlWDQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoZGVmYXVsdCkgZm9yIFBBQzE5NFgu
DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gVkJVUyBoYXMgYmlwb2xhciAtMzJW
IHRvIDMyViBGU1IgZm9yIFBBQzE5NVggb3INCj4gPiA+ID4gLTlWDQo+ID4gPiA+IHRvIDlWIGZv
cg0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUEFDMTk0WC4gVGhlIGFjdHVh
bCByYW5nZSBpcyBsaW1pdGVkIHRvIGFib3V0IC0NCj4gPiA+ID4gMjAwDQo+ID4gPiA+IG1WIGR1
ZSB0byB0aGUNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGltcGFjdCBvZiB0
aGUgRVNEIHN0cnVjdHVyZXMuDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gVkJV
UyBoYXMgYmlwb2xhciAtMTZWIHRvIDE2ViBGU1IgZm9yIFBBQzE5NVggb3INCj4gPiA+ID4gLQ0K
PiA+ID4gPiA0LjVWIHRvIDQuNVYgZm9yDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBQQUMxOTRYLiBUaGUgYWN0dWFsIHJhbmdlIGlzIGxpbWl0ZWQgdG8gYWJvdXQgLQ0KPiA+
ID4gPiAyMDANCj4gPiA+ID4gbVYgZHVlIHRvIHRoZQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW1wYWN0IG9mIHRoZSBFU0Qgc3RydWN0dXJlcy4NCj4gPiA+ID4gKw0KPiA+
ID4gPiArwqDCoMKgwqDCoCBtaWNyb2NoaXAsdmJ1cy1iaXBvbGFyOg0KPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqAgZGVzY3JpcHRpb246DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqAgSWYgcHJvdmlkZWQsIHRoZSBjaGFubmVsIGlzIHRvIGJlIHVzZWQgaW4gYmlwb2xhcg0K
PiA+ID4gPiBtb2RlLg0KPiA+ID4gPiBUaGUNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBh
Y3R1YWwgcmFuZ2UgaXMgbGltaXRlZCB0byBhYm91dCAtMjAwIG1WIGR1ZSB0byB0aGUNCj4gPiA+
ID4gaW1wYWN0IG9mIHRoZSBFU0QNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3R1
cmVzLg0KPiA+ID4gPiArDQo+ID4gPiANCj4gPiA+IFVzaW5nIEpvbmF0aGFuJ3Mgc3VnZ2VzdGlv
biBmcm9tIHYyIHRvIGp1c3QgaGF2ZSBhIHNpbmdsZQ0KPiA+ID4gcHJvcGVydHkNCj4gPiA+IHdp
dGggMyBkaWZmZXJlbnQNCj4gPiA+IHJhbmdlcyB0byBjaG9zZSBmcm9tIHNlZW1zIHNpbXBsZXIg
dGhhdCB0aGlzLiBJdCB3b3VsZCBvbmx5DQo+ID4gPiByZXF1aXJlDQo+ID4gPiBvbmUgcHJvcGVy
dHkNCj4gPiA+IGFuZCB3b3VsZCBiZSBzZWxmLWRvY3VtZW50aW5nLiBUaGUgZGVzY3JpcHRpb24g
Y291bGQgYmUgc2hvcnRlbmVkDQo+ID4gPiB0bw0KPiA+ID4ganVzdCBhIGNvdXBsZQ0KPiA+ID4g
b2YgbGluZXMuDQo+ID4gDQo+ID4gSSB3YXMgdGhpbmtpbmcgdG8gYWRkIHRoZSByYW5nZSBmb3Ig
dGhpcyBwcm9wZXJ0eSwgYnV0IGl0IGxvb2tzDQo+ID4gKGZvciBtZQ0KPiA+IGF0IGxlYXN0KSBt
b3JlIGNvbXBsaWNhdGVkIGZyb20gdGhlIGNoZWNraW5nIHBvaW50IG9mIHZpZXcuIFRoZQ0KPiA+
IGRyaXZlcg0KPiA+IGlzIHN1cHBvcnRpbmcgdHdvIGZhbWlseSBvZiBkZXZpY2VzIHRoYXQgaGFz
LCBlYWNoLCAzIGRpZmZlcmVudA0KPiA+IHZvbHRhZ2UNCj4gPiByYW5nZSBhcyBhbiBpbnB1dC4N
Cj4gPiANCj4gDQo+IFVzdWFsbHksIGhhdmluZyBhIGNvbnNpc3RlbnQgYmluZGluZyBmb3IgdGhl
IHNhbWUgdGhpbmcgYW1vbmcgc2ltaWxhcg0KPiBkZXZpY2VzIGlzIG1vcmUgaW1wb3J0YW50IHRo
YW4gaG93IGVhc3kgaXQgaXMgdG8gaW1wbGVtZW50IGluIHRoZQ0KPiBkcml2ZXIuDQo+IA0KPiBT
aW5jZSB0aGlzIHNlZW1zIHRvIGJlIGEgY29tbW9uIHBhdHRlcm4sIHdlIGNvdWxkIHByb2JhYmx5
IGp1c3RpZnkgYW4NCj4gaWlvX3Byb3BlcnR5X21hdGNoX3JhbmdlcygpIGhlbHBlciBmdW5jdGlv
biB0aGF0IHdvdWxkIHNpbXBsaWZ5IHRoZQ0KPiBpbXBsZW1lbnRhdGlvbiBpbiBkcml2ZXJzIHRo
YXQgd291bGQgbmVlZCB0byB1c2Ugc3VjaCBhIHByb3BlcnR5Lg0KPiBUaGVuDQo+IGluIGVhY2gg
ZHJpdmVyIGl0IHdvdWxkIGp1c3QgYmUgYSBtYXR0ZXIgb2YgbWFraW5nIGEgc3RhdGljIGNvbnN0
DQo+IGFycmF5DQo+IGxvb2t1cCB0YWJsZSBvZiByYW5nZXMgZm9yIGVhY2ggZGV2aWNlIGFuZCBj
YWxsaW5nIHRoZSBoZWxwZXINCj4gZnVuY3Rpb24uDQoNClNvcnJ5IGZvciBub3QgZXhwbGFpbmlu
ZyB2ZXJ5IHdlbGwuIEkgaGF2ZSBpbXBsZW1lbnRlZCB0aGUgcmFuZ2UgaW50bw0KdGhlIGRyaXZl
ciBhbmQgSSB3YXMgd29ya2luZyB3ZWxsLCBidXQgSSBoYWQgaXNzdWVzIGRlZmluaW5nIHRoZSBy
YW5nZQ0KaW50byB0aGUgZGV2aWNlIGJpbmRpbmcgYW5kIHRoZSBjaGVja2VyIHdhcyBmYWlsaW5n
LiBUaGF0IHdhcyB0aGUNCnJlYXNvbiB0aGF0IEkndmUgZHJvcHBlZCB0aGUgcmFuZ2UgZnJvbSB0
aGUgYmluZGluZy4gQWxzbyBJIGhhZCBzb21lDQppc3N1ZXMgZW5mb3JjaW5nIGEgY2VydGFpbiAi
YXZhaWxhYmxlIiByYW5nZXMgZm9yIGEgcGFydGljdWxhciBwYXJ0DQppbnRvIHRoZSBiaW5kaW5n
Lg0KDQoNCg==

