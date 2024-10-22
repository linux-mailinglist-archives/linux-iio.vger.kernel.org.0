Return-Path: <linux-iio+bounces-10919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEDF9A9D77
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 10:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7223A28384F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D57187864;
	Tue, 22 Oct 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y+uUNYIT"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446351547C0;
	Tue, 22 Oct 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587175; cv=fail; b=tnfOdiVSPPTzj/fxUu9qpYHokF5qk21SwcvHZr2tKtJKturQedaZmwh1UJikTJD9e60ukwUi5oKV4Aeit0wFCXewPattO3Xkz+QxAxU3oV6iWsfyoMYSFEj9DOziSs/rUqY7LBE4dJSqDv1RCt+sWb2mBBI2/01no0OLUwmUtL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587175; c=relaxed/simple;
	bh=WXrHSPo7cB3WfHkKRRTXllEfZFwW1OmwT3mmPtGz+lA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R7kPRVlPfpronr0dsXddCEpa56ALc76fn5ob/Cz9TP/spVdfUcUq1czYxvkKz89VcwdGG59B6vpxzKMQNsPa1xgNXt/stTOIRBFrmn1R0k0ODdu+GzjKx8LsC/E3Qt7b271q20Y2YgU5wa//fl7tcfigpq7qmIFmCCD7eMFliMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y+uUNYIT; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBpbxRgfy5sHg0cLsLz4w/4LrVHeufvAhKbFSr5DQZweEhiEYAqv3XZ6S+fS63FjmIrLD2iz8Pxp2O3lUPRzCRicTwu7GOpRvViFWxm1bN8Qdw62j8ydSZ07L6nfSSv+Xr6ZfNJLGciU5MAsAxvrNR4eE87Sy5Gq++f8W3ahkkYSOMYRh66dDPk5br14WH7fIbWk7KwJLWzcr2i0Cpwn8WOruoLdKBvlg2fb0X5mIah31dF5abwuFQY0QW/su6bsMYtpHZcn+X+hLm8MsqxfeDzoPyBmmW0IAzRjV3NmODwdrRS9wydmi1p5aPpKwTq34gfZ0dbmEbSgf5QuSDrfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXrHSPo7cB3WfHkKRRTXllEfZFwW1OmwT3mmPtGz+lA=;
 b=BAFooGNK+ZiakHrEB3501Y6EH8pIA7dmA1K2k7Pku2+pTms18lY1KEwh3WqcYL5HtpXbrwaOfGJhSB1wpREB4RbwSohoMyiz25X/pHiGeuxJ2NGKfrUB9C04reVM3Hj+VBlEFWtcvv90TdNjl86P2B8zRtLFaDRnEOz4tnW7YLazes22X7bqYLHjfIku9C/EA+OIdbYuhUBsSLaNDlOkWNQPSViyfEIT+nPucBzRc9LuWYW1xyULhcVKwFzOMVIXu1CZNVlr2zIBcs3iqFWFflvmAMO3uWBZd0sR0zVbvwGZcc7HfoHFV8CbIXQYDDwvSpOAPYkwvqhmvu+FeDdQjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXrHSPo7cB3WfHkKRRTXllEfZFwW1OmwT3mmPtGz+lA=;
 b=Y+uUNYITXkg7D1eM0EyEegGLueaR3yKK/Kjznafck3LZj5J8Y9E4mONnl7UZWBMJkOiyOA3qBESSiogqlAQc13PnRMMIcKysazFSLMTGvjYlPbL4RXaZ51YxsAOV/UsRmxuyDDMqpl7G9skBiGzy2OvdsYngfSEAnW/3wkItv9acE0fMICMt22+hnnxSJKGGo+FqxklQoTQGYr1J40w1we85icEd0zvP/oUS4f6yL1NovdvYWJ//Wgy+fzVkQQe/mgIDAC+zmx2GCSluqeiXHX8nFE90hhpI6GWawFOpyZBBytP35+wTH+3TUWMunMGlVUcFP4kkwE8XtJadP7d/VA==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by SA1PR11MB8793.namprd11.prod.outlook.com (2603:10b6:806:46b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 08:52:50 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%5]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 08:52:50 +0000
From: <Victor.Duicu@microchip.com>
To: <jic23@kernel.org>, <matteomartelli3@gmail.com>, <lars@metafoo.de>
CC: <Marius.Cristea@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Thread-Topic: [PATCH v5] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Thread-Index: AQHbIVY5VX28rGo6906pIkRHjfsQ3LKMp1qAgAXVhIA=
Date: Tue, 22 Oct 2024 08:52:50 +0000
Message-ID: <0fb0ddda50f7b204a28973933189993da42a8318.camel@microchip.com>
References: <20241018120624.15409-1-victor.duicu@microchip.com>
	 <172926643961.69047.11194012379257398256@njaxe.localdomain>
In-Reply-To: <172926643961.69047.11194012379257398256@njaxe.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|SA1PR11MB8793:EE_
x-ms-office365-filtering-correlation-id: 83c76897-b06b-4256-a79a-08dcf276e89f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnQ1VHlidU5lK3VNNkI3cndtL2QrOEh4dFNOSzNpZ1NDaXVsK293QTFWdnhm?=
 =?utf-8?B?ZVFHRVhUSk1GbXh4cXVySHRZR1IzWkRoM3Y3NzNCNFpOVWJWWFJyRjF4NWVO?=
 =?utf-8?B?bnpDNWVJZWZoQVNPZWx6WDNFTWxFbmlUN0xjYjc3dkRLQlovUGpIOG80R2pl?=
 =?utf-8?B?S3RNYUJST0R2NFFOam5HMVlWMTc0SmJoTTVjNm53THVUMXRtaWdUUTU1cTZ2?=
 =?utf-8?B?YjFLWG1xbFVROFRaK1VFdHA2cEc2a25WTE9kNUFKa1RoQnRsSGRwdU4wU2FV?=
 =?utf-8?B?ZFQ1VkN0ZnRVWXI1STVEL1FtQ3dhOWR1cXBySTQ2RXRzVjgvQjFpeXFHUitL?=
 =?utf-8?B?VmptREk5bXhLU1BlMWZEZjIxRDFoSURsTk01V2dxNTFxSFJLYjhMRTRaY1Bt?=
 =?utf-8?B?TzBwckFVK2tubG4zdExWZDlLTS9MblZPdXNCajJjck1hRzJLVFVTclhId2M5?=
 =?utf-8?B?eVg0QSt2TTVkUFRsckUveUNPMnEzMEs3OTVPWFBkcyt5YmxiSVVuSzkwTnYv?=
 =?utf-8?B?b0JlWHZNZUtvajAwN1VyZ0hldDRjQ0tlamdqb2Fmd2tDSUFwM3AvbFVxOHZ2?=
 =?utf-8?B?RjZ2dEpKdFRpd253TFppSUdocjdjeU52Y0owNnkzY2d2NmpPYVIweEc3Wkpn?=
 =?utf-8?B?aXI5WGVPZGVkTHkvTXFUVEYxTzhsMTByWGlxZCt2VWJUMlNlMWg5Z2tZNTk1?=
 =?utf-8?B?OWRnNE5NeHk4MEp0VWMwQmNUd1J6UHRrK2V6cFVrci9XOGpJSmhkM2t4STBT?=
 =?utf-8?B?aXVvSEZvejVzbkwwY0dtM1FxeWh1ckJuZmNiWTJ2U1NHU0RFZXF2SzNqOFBq?=
 =?utf-8?B?cXNjcHpHUTVEaGFWblNRUGdKQVZQMWJOV29iQWVtdUUrSnVYTlFYaHJhUkdB?=
 =?utf-8?B?ZHRPSmwyeFY1aG04c0tKRElHRSswMnc2L0k3ODhPUURuZ0ZPdXl2bE1seWhz?=
 =?utf-8?B?OWVLYWZhSHp1RnQxNDlnNFZ3UlJzZzVDN0FqSER5WVlaZ1RKYlZ0dER4NUF6?=
 =?utf-8?B?WnRuMUhDVkFYRGUwVHFPdTFFMVdIRkFYZ3lKZ1VZQ1NPTWNhZmZteWZQY0ta?=
 =?utf-8?B?ZzE1TW5hQWZ1Tk1xbmdFN1BDdlRVUG11akJMSEpsek9naVE5Y3VVR3F0Mk9i?=
 =?utf-8?B?UzRPZWM5SElaSlBNVjYrUUJnN1lSUzlIK1l2WVNGK2hMSWZVb2VTNjZOQ0ds?=
 =?utf-8?B?dVN6TDNLR3VxTm5ZZEZEZ3lLM1ZqMnpzL1UzWnRNRkFkTWx5NXd3eERaeHp5?=
 =?utf-8?B?UWJGV2NRSHNETGk5eHU1YjB4RThSbTZlb1lEM2NYcTUrdzY0eHV0eU5oODFt?=
 =?utf-8?B?Y3hCaVdiOFhGQXJsc3EyWUx5emdGaDZTU3BqTThpTzc2S0ZQMHQyYktLWEdS?=
 =?utf-8?B?UUpqdU1HNWVFeUwzaG90Q0JBNFdLTzlaOUd5ZHhmbHJudnNRNzBhTFBJM0x1?=
 =?utf-8?B?bTNScGN6K05kb2pKQnkvSnA4WmZvSEcwU3pTbXRuZkFNU2dQVEpIcHhIVWZQ?=
 =?utf-8?B?VktQcFRNUk4xOWtvYWlEVXQ1VVdrTG5qMGdMWVc5S1dpb1BMYjBiWUpaWkR3?=
 =?utf-8?B?WGJHTk1QYlIvNWRVNWRiY3JOTXFoaUtIa0NGTE9MZE1zOXhYMmFZOVlsOGtB?=
 =?utf-8?B?M1NVVGlmcTZuRDJGR1dMZjJFektKL2IxRVNpQjZYVDc4RzNjWVNmVTYwVW0v?=
 =?utf-8?B?T0x3N0RVemtQVVF4SzJMZzc0T2FVWVVVaExVdnkwem1XZWdSRXJKY0lBY1ph?=
 =?utf-8?B?U084K1hRL05aM2Z1RG16QWgyU08yNEFrK1JIZEtXNTZLeXI5My81T3J3UmdQ?=
 =?utf-8?B?ektGNldtd0Vmb2NURHRVUnNzUERCMTNNN244RXVvYktrSkJZRkR1ams1R3ly?=
 =?utf-8?Q?N5dJhpvx+kN6C?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDlmWFgwLzJPSEhnZWJVN2tXZVpFdndyMk1rbm5uK0VxK3o1UXlES3Z5OXpv?=
 =?utf-8?B?TjU2YmI0NGdRSldUcHJjMkVZZ0c2elYyNXE0WEdjNSsrcXVER01mRHBHYkov?=
 =?utf-8?B?MmlZZnRjY0ZFMFlCZ0NTVzZRcTNVY0JTZEZ5S2FWc0V6U21MSlZPSDBtUDMx?=
 =?utf-8?B?dFhPbTR2dzhDZ2xERnk3U1lxU0RaQmtsWW9OMTEyWnlaWW82K2lKTXIzclV6?=
 =?utf-8?B?UWxIUEw1alVDbmZPMzRYYXJoS1cxODh1SW8xRkpyczBmRGZvN2RYVCtYMDQ0?=
 =?utf-8?B?VHJOOFo4U0Vac2h4WlFGZVVWQmN2YWpNQzFBTG1RbzVqdXhzQm85KzJNVGZR?=
 =?utf-8?B?U2RsaUlSb0tKYXRQYkFEQ2hGR2ErMTRBNm00S29kY2Jmc3BPYi90ZWhSN2lG?=
 =?utf-8?B?OUJjNWlUUjBkbTBrYktZMDdtTm9pNkhQeVlHQWZ0UzhQSVcvbEpTUjJXdkxH?=
 =?utf-8?B?elRvVjJIc3drQTZaRzg2ajZ4T1BycUZ3MURkT3lJMTZSTmtvOFJWTlBNL1Fh?=
 =?utf-8?B?N0VaL095bFl2RGxhdFM2eUlWc3ptSWUvNnRET2Q1M3ZQSklTNSttRCt6SEZ6?=
 =?utf-8?B?aFZlS016Y1dLWUlxdU9YNXIvaG5rck1PN3R0eGFveGgxSnNBWk5sZ2V5MXBU?=
 =?utf-8?B?THJIRnFmNFQ4dE1PQ3U4S1BEREhJNkVtbnRaMEpYOGpqYkNRUkZJdTNOQUFk?=
 =?utf-8?B?Qlo0aXBweVhwdkIxWEVWTjlZY2RtN3VOWUJ6UEFzcHJHaHZySUgwWHF6dVlS?=
 =?utf-8?B?WjdhRGovVE1PQ3J4M0IycnAvWURrODR3S1A0SmROZExsRjQ4OGd5RFEyVm45?=
 =?utf-8?B?eFQxRmh2Sjk3Y201RHdBVVNjVFhUMXA3M2x4WWs3TzVRT0g0SG9ETEV4NDhJ?=
 =?utf-8?B?K0FMWmQxTWpXYXNCYXZFQmFhaUVYNTZ3OC92Rk5kdENkUW1UVnZ2YmhUWHlQ?=
 =?utf-8?B?bjZlM3F1U0wrS3dRK0VHL0g0NHpnR0x1TGVDZkZqWk9oeWZHY3I5MkJ4bDR5?=
 =?utf-8?B?UzJ2RlVrbnZRdXkxMVdjcDFKVHNDemdTUzNvT0NNeEVCNTY1b1hYZDQ1YTZo?=
 =?utf-8?B?L21RTnNaMk5GNzE4ODdFUXhxUHFSck0ydnR2SXQzYmlQYzJ4YjVBZU9uMjNW?=
 =?utf-8?B?YVVlZlhmeUNuWi9aSGJvMHM5aHhENU81RFNEOTVvNXN3RzFkeERNU0lJMkc3?=
 =?utf-8?B?TzVKT1N4bE0xRzVzcmZkVnZtcDhPeXliU2hnYTRhb2dZa2R6Q0J3MDRuTjJx?=
 =?utf-8?B?Z2xPMzgvYml6VkpvaHluUXI4WU81d0xtajNQWldEd3BpSUxqVXc0UEQ3QnJ5?=
 =?utf-8?B?UWI0dEVPcVh3clp6U0VVSGNENFlWMm5xVGdQUXFTdjdXallHV1NRK05kMXhJ?=
 =?utf-8?B?OU54ZEh2clIrWkcyNy81dmVlUlRoTkNkRzl5Nk4vWFovNkFrL2hTeW5DYTVT?=
 =?utf-8?B?ZjVmam9WS3UyS2FwNllTZS9GbkJCVDJKRU5yMEVmamtMWkJIWFp3di9oTE54?=
 =?utf-8?B?RWw3QjJyRWYyWmVhMnZNOVJXMHJVK01id1p1cnRMRWlBYzdXV1FiS1VnOWpw?=
 =?utf-8?B?TXFXamVjSnY4am0zWDlzaGFtNFVBSkVtSFVZY3NIbnRONGYyV1ZSeDBkSk5O?=
 =?utf-8?B?a0RnNFhtKzVoblNNcWtWZFh0VFh2aGFWWk12SFQ4cVFIVlFBdFdUNE5VRTFt?=
 =?utf-8?B?NWs5MjlFZHJjSVJsR3lNRDdOQzM0N3pCTUZKZVFHWVJ6QmF1bHhjWHQvcmFD?=
 =?utf-8?B?dC9PK1lVQkE5TG8rZ3ROWFRZUGpHWXhKK0ZQdHN5cVZGVHE5aDNIMlpHUElE?=
 =?utf-8?B?eVBEYU1zaWVVTGJVbHp2dWFNRnhWeGFFYlBFcDRHRCt1TFVDRy90aThhS21R?=
 =?utf-8?B?Z1FiV3dCd09qR0QwRWZ3Y2M2VllybGpZb2k4QTk4cHhEWDBmOHJBOXJvNTJ1?=
 =?utf-8?B?anF3bE9LRW9OdnVZUHhXWnlaMzZsa0V4TThmaUkzWGpvbTlYSU15emxySTNM?=
 =?utf-8?B?ZTdDbW9pT0FYZlZnLzd2RkFaaS8ybEdOVnV5M0JQV0ZhRzNKMzYyS0twcVhU?=
 =?utf-8?B?YXREemtBWVBIZUtlRVhHVHYvQUN6Ujk1dUZHV3ROL0laRjVLWmdLWCsrZXBV?=
 =?utf-8?B?elA5V0xZMmtvSnprdHlzY2k4emZ1SkZScWdpYUdoWUxiTkNBRGFIckpVUGJ1?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F810038FBB0566489AE2651DA397B0D1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c76897-b06b-4256-a79a-08dcf276e89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 08:52:50.2335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SFQXMj4TlitHIv1g2YtXQiBMJX7rFIx7y0TRWhozlwnUwc/Ucd4aESWDR1jT21kizPJtxl8s5FFZ706m47jLfV1WqtLcs6Ge+MSrsYYe9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8793

T24gRnJpLCAyMDI0LTEwLTE4IGF0IDE3OjQ3ICswMjAwLCBNYXR0ZW8gTWFydGVsbGkgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gUXVvdGluZyB2
aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNvbcKgKDIwMjQtMTAtMTggMTQ6MDY6MjQpDQo+ID4gRnJv
bTogVmljdG9yIER1aWN1IDx2aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNvbT4NCj4gPiANCj4gPiBU
aGlzIGRyaXZlciBpbXBsZW1lbnRzIEFDUEkgc3VwcG9ydCB0byBNaWNyb2NoaXAgcGFjMTkyMS4N
Cj4gPiBUaGUgZHJpdmVyIGNhbiByZWFkIHNodW50IHJlc2lzdG9yIHZhbHVlIGFuZCBsYWJlbCBm
cm9tIEFDUEkgdGFibGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVmljdG9yIER1aWN1IDx2
aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiBUaGUgcGF0Y2gg
d2FzIHRlc3RlZCBvbiBtaW5ub3dib2FyZCBhbmQgc2FtYTUuDQo+ID4gDQo+ID4gRGlmZmVyZW5j
ZXMgcmVsYXRlZCB0byBwcmV2aW91cyB2ZXJzaW9uczoNCj4gPiB2NToNCj4gDQo+IEkgdGhpbmsg
djQgd2FzIGNsZWFuZXIuIEFyZSB0aGUgZm9sbG93aW5nIGNoYW5nZXMgbmVjZXNzYXJ5Pw0KPiAN
Cj4gPiAtIHNldCBtYXhpbXVtIGFjY2VwdGFibGUgdmFsdWUgb2Ygc2h1bnQgcmVzaXN0b3IgdG8g
MktPSE0gaW4NCj4gPiBkZXZpY2V0cmVlLA0KPiA+IEFDUEkgdGFibGUgYW5kIHVzZXIgaW5wdXQu
IFRoZSBjaG9zZW4gdmFsdWUgaXMgbGVzc2VyIHRoYW4gSU5UX01BWCwNCj4gPiB3aGljaCBpcyBh
Ym91dCAyLjFLT0hNLg0KPiANCj4gSSB3b3VsZCBwZXJzb25hbGx5IGtlZXAgSU5UX01BWCBzaW5j
ZSB0aGUgbGltaXRhdGlvbiBpcyBvbmx5IGdpdmVuIGJ5DQo+IHRoZSB0eXBlcw0KPiB1c2VkIGlu
IHRoZSBjdXJyZW50IGNvbnZlcnNpb25zIChzZWUgcGFjMTkyMV9jYWxjX3NjYWxlKCkpIHJhdGhl
cg0KPiB0aGFuIGJlaW5nIGENCj4gc3BlY2lmaWMgUEFDMTkyMSBoYXJkd2FyZSBsaW1pdGF0aW9u
LiBPdGhlcndpc2UgSSB3b3VsZCBleHRlbmQgdGhlDQo+IGNvbW1lbnQgb24NCj4gdG9wIG9mIHRo
b3NlIHR3byBkZWZpbml0aW9ucyBleHBsYWluaW5nIHdoeSB0aGF0J3MgdGhlIG1heGltdW0uDQoN
CldpbGwgc2V0IG1heGltdW0gYWNjZXB0YWJsZSB2YWx1ZSB0byBJTlRfTUFYLg0KDQo+ID4gLSBp
biBwYWMxOTIxX21hdGNoX2FjcGlfZGV2aWNlIGFuZCBwYWMxOTIxX3BhcnNlX29mX2Z3IGNoYW5n
ZSB0bw0KPiA+IG9ubHkNCj4gPiDCoCByZWFkIDMyYiB2YWx1ZXMgZm9yIHJlc2lzdG9yIHNodW50
Lg0KPiA+IA0KPiANCj4gSSB0aGluayB0aGF0IGluIHBhYzE5MjFfbWF0Y2hfYWNwaV9kZXZpY2Uo
KSwgdGhlIHU2NCB0ZW1wIHZhciB3YXMNCj4gaW50cm9kdWNlZCB0bw0KPiBhZGRyZXNzIHRoZSBw
b3NzaWJsZSBvdmVyZmxvdyBjb21pbmcgZnJvbSB0aGUgdTY0IHJlei0NCj4gPnBhY2thZ2UuZWxl
bWVudHNbMF0uaW50ZWdlci52YWx1ZQ0KPiBhbmQgdG8gc2FmZWx5IHBlcmZvcm0gYSBzYW5pdHkg
Y2hlY2suIEkgZG9uJ3QgdGhpbmsgd2UgY2FuIHRydXN0DQo+IGJsaW5kbHkgdGhhdA0KPiB0aGUg
QUNQSSB0YWJsZSBhbHdheXMgaGFzIGEgdmFsaWQgMzJiaXQgdmFsdWUgaW4gdGhhdCBmaWVsZC4N
Cg0KSWYgdGhlIEFDUEkgdGFibGUgaGFzIHJldmlzaW9uIHNldCB0byAxLCBhbGwgdmFsdWVzIGhp
Z2hlciB0aGFuIDMyYg0Kd2lsbCBiZSB0cnVuY2F0ZWQgdG8gMzJiLg0KDQo+IHBhYzE5MjFfcGFy
c2Vfb2ZfZncoKSBkb2Vzbid0IGxvb2sgY2hhbmdlZCBjb21wYXJlZCB0byB2NCwgeW91DQo+IGFs
cmVhZHkgc3dpdGNoZWQNCj4gYmFjayB0byBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIsIGlmIGl0
J3Mgd2hhdCB5b3UgYXJlIHJlZmVycmluZyB0by4NCg0KWWVzLCBpbiB2NCBJIGNoYW5nZWQgcGFj
MTkyMV9wYXJzZV9vZl9mdyBhbmQgaW4gdjUgSSBjaGFuZ2VkDQpwYWMxOTIxX21hdGNoX2FjcGlf
ZGV2aWNlLiBJIGNoYW5nZWQgYm90aCBiYWNrIHRvIDMyYiBpbiBvcmRlcg0KdG8gYmUgY29uc2lz
dGVudC4NCg0KPiA+IA0KPiA+IHY0Og0KPiA+IC0gY2hhbmdlIG5hbWUgb2YgcGFjMTkyMV9zaHVu
dF9pc192YWxpZCB0bw0KPiA+IHBhYzE5MjFfc2h1bnRfaXNfaW52YWxpZC4NCj4gPiAtIGZpeCBj
b2Rpbmcgc3R5bGUuDQo+ID4gLSBpbiBwYWMxOTIxX3BhcnNlX29mX2Z3IGNoYW5nZSBiYWNrIHRv
IGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMi4NCj4gPiANCj4gPiANCj4gPiDCoGRyaXZlcnMvaWlv
L2FkYy9wYWMxOTIxLmMgfCAxMDkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
PiA+IC0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspLCAxMyBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL3BhYzE5MjEu
YyBiL2RyaXZlcnMvaWlvL2FkYy9wYWMxOTIxLmMNCj4gPiBpbmRleCBhOTZmYWU1NDZiYzEuLjk2
MjJiMGRhNjE5NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvcGFjMTkyMS5jDQo+
ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL3BhYzE5MjEuYw0KPiA+IEBAIC02Nyw2ICs2NywxMyBA
QCBlbnVtIHBhYzE5MjFfbXhzbCB7DQo+ID4gwqAjZGVmaW5lIFBBQzE5MjFfREVGQVVMVF9ESV9H
QUlOwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAgLyogMl4odmFsdWUpOiAxeA0KPiA+
IGdhaW4gKEhXIGRlZmF1bHQpICovDQo+ID4gwqAjZGVmaW5lIFBBQzE5MjFfREVGQVVMVF9OVU1f
U0FNUExFU8KgwqDCoCAwIC8qIDJeKHZhbHVlKTogMSBzYW1wbGUNCj4gPiAoSFcgZGVmYXVsdCkg
Ki8NCj4gPiANCj4gPiANCj4gPiANCj4gPiBAQCAtNzkxLDkgKzgwMywxMyBAQCBzdGF0aWMgc3Np
emVfdA0KPiA+IHBhYzE5MjFfd3JpdGVfc2h1bnRfcmVzaXN0b3Ioc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldiwNCj4gPiDCoMKgwqDCoMKgwqDCoCByZXQgPSBpaW9fc3RyX3RvX2ZpeHBvaW50KGJ1
ZiwgMTAwMDAwLCAmdmFsLCAmdmFsX2ZyYWN0KTsNCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAocmV0
KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiA+ICsN
Cj4gPiArwqDCoMKgwqDCoMKgIC8qIFRoaXMgY2hlY2sgaXMgdG8gZW5zdXJlIHZhbCpNSUNSTyB3
b24ndCBvdmVyZmxvdyovDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAodmFsIDwgMCB8fCB2YWwgPiBQ
QUMxOTIxX01BWF9TSFVOVF9WQUxVRV9PSE1TKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIHJzaHVudF91
b2htID0gdmFsICogTUlDUk8gKyB2YWxfZnJhY3Q7DQo+ID4gLcKgwqDCoMKgwqDCoCBpZiAocnNo
dW50X3VvaG0gPT0gMCB8fCByc2h1bnRfdW9obSA+IElOVF9NQVgpDQo+ID4gK8KgwqDCoMKgwqDC
oCBpZiAocGFjMTkyMV9zaHVudF9pc19pbnZhbGlkKHJzaHVudF91b2htKSkNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gDQo+IA0KPiBJbiB2
MyB5b3UgYWRkZWQgdGhlICh1NjQpdmFsIGNhc3QgdG8gc29sdmUgdGhlIG11bHRpcGxpY2F0aW9u
DQo+IG92ZXJmbG93LiBXYXNuJ3QNCj4gdGhhdCBlbm91Z2g/IEhvd2V2ZXIsIGlmIHRoaXMgaXMg
Zm9yIGJldHRlciBjbGFyaXR5IEkgYW0gZmluZSB3aXRoDQo+IGl0Lg0KDQpUaGUgY2FzdCB0byA2
NGIgd2FzIHJlbW92ZWQgaW4gb3JkZXIgdG8gYmUgY29uc2lzdGVudA0Kd2l0aCBkdCBhbmQgQUNQ
SSB0aGF0IHdpbGwgcmVhZCBvbmx5IDMyYiB2YWx1ZXMuDQoNCj4gPiDCoMKgwqDCoMKgwqDCoCBn
dWFyZChtdXRleCkoJnByaXYtPmxvY2spOw0KPiA+IEBAIC0xMTUwLDYgKzExNjYsNzEgQEAgc3Rh
dGljIHZvaWQgcGFjMTkyMV9yZWd1bGF0b3JfZGlzYWJsZSh2b2lkDQo+ID4gKmRhdGEpDQo+ID4g
wqDCoMKgwqDCoMKgwqAgcmVndWxhdG9yX2Rpc2FibGUocmVndWxhdG9yKTsNCj4gPiDCoH0NCj4g
PiANCj4gPiArLyoNCj4gPiArICogZG9jdW1lbnRhdGlvbiByZWxhdGVkIHRvIHRoZSBBQ1BJIGRl
dmljZSBkZWZpbml0aW9uDQo+ID4gKyAqDQo+ID4gaHR0cHM6Ly93dzEubWljcm9jaGlwLmNvbS9k
b3dubG9hZHMvYWVtRG9jdW1lbnRzL2RvY3VtZW50cy9PVEgvQXBwbGljYXRpb25Ob3Rlcy9BcHBs
aWNhdGlvbk5vdGVzL1BBQzE5M1gtSW50ZWdyYXRpb24tTm90ZXMtZm9yLU1pY3Jvc29mdC1XaW5k
b3dzLTEwLWFuZC1XaW5kb3dzLTExLURyaXZlci1TdXBwb3J0LURTMDAwMDI1MzQucGRmDQo+ID4g
KyAqLw0KPiA+ICtzdGF0aWMgaW50IHBhYzE5MjFfbWF0Y2hfYWNwaV9kZXZpY2Uoc3RydWN0IGky
Y19jbGllbnQgKmNsaWVudCwNCj4gPiBzdHJ1Y3QgcGFjMTkyMV9wcml2ICpwcml2LA0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ID4gK3sNCj4gPiArwqDC
oMKgwqDCoMKgIGFjcGlfaGFuZGxlIGhhbmRsZTsNCj4gPiArwqDCoMKgwqDCoMKgIHVuaW9uIGFj
cGlfb2JqZWN0ICpyZXo7DQo+ID4gK8KgwqDCoMKgwqDCoCBndWlkX3QgZ3VpZDsNCj4gPiArwqDC
oMKgwqDCoMKgIGNoYXIgKmxhYmVsOw0KPiA+ICvCoMKgwqDCoMKgwqAgdTMyIHRlbXA7DQo+ID4g
Kw0KPiA+ICvCoMKgwqDCoMKgwqAgZ3VpZF9wYXJzZShQQUMxOTIxX0RTTV9VVUlELCAmZ3VpZCk7
DQo+ID4gK8KgwqDCoMKgwqDCoCBoYW5kbGUgPSBBQ1BJX0hBTkRMRSgmY2xpZW50LT5kZXYpOw0K
PiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgIHJleiA9IGFjcGlfZXZhbHVhdGVfZHNtKGhhbmRsZSwg
Jmd1aWQsIDEsDQo+ID4gUEFDMTkyMV9BQ1BJX0dFVF9VT0hNU19WQUxTLCBOVUxMKTsNCj4gPiAr
wqDCoMKgwqDCoMKgIGlmICghcmV6KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBkZXZfZXJyX3Byb2JlKCZjbGllbnQtPmRldiwgLUVJTlZBTCwNCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAiQ291bGQgbm90IHJlYWQgc2h1bnQgZnJvbQ0KPiA+IEFDUEkgdGFibGVcbiIpOw0K
PiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgIHRlbXAgPSByZXotPnBhY2thZ2UuZWxlbWVudHNbMF0u
aW50ZWdlci52YWx1ZTsNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgd2UgY2FuIHRydXN0IHJlei0+cGFj
a2FnZS5lbGVtZW50c1swXS5pbnRlZ2VyLnZhbHVlIHRvDQo+IGFsd2F5cyBiZQ0KPiBpbiAzMmJp
dCBib3VuZGFyaWVzLiBCdXQgaWYgdGhhdCdzIHRoZSBjYXNlIHRoZW4gdGhlIHRlbXAgdmFyIGxv
b2tzDQo+IHVubmVjZXNzYXJ5Lg0KDQpXaWxsIHJlbW92ZSB0aGUgdGVtcCB2YXIgaW4gdGhlIG5l
eHQgdmVyc2lvbi4NCg0KPiA+ICvCoMKgwqDCoMKgwqAgQUNQSV9GUkVFKHJleik7DQo+ID4gKw0K
PiA+ICvCoMKgwqDCoMKgwqAgaWYgKHBhYzE5MjFfc2h1bnRfaXNfaW52YWxpZCh0ZW1wKSkNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZGV2X2Vycl9wcm9iZSgmY2xp
ZW50LT5kZXYsIC1FSU5WQUwsDQo+ID4gIkludmFsaWQgc2h1bnQgcmVzaXN0b3JcbiIpOw0KPiA+
ICsNCj4gPiArwqDCoMKgwqDCoMKgIHByaXYtPnJzaHVudF91b2htID0gdGVtcDsNCj4gPiArwqDC
oMKgwqDCoMKgIHBhYzE5MjFfY2FsY19jdXJyZW50X3NjYWxlcyhwcml2KTsNCj4gPiArDQo+ID4g
K8KgwqDCoMKgwqDCoCByZXogPSBhY3BpX2V2YWx1YXRlX2RzbShoYW5kbGUsICZndWlkLCAxLA0K
PiA+IFBBQzE5MjFfQUNQSV9HRVRfTEFCRUwsIE5VTEwpOw0KPiA+ICvCoMKgwqDCoMKgwqAgaWYg
KCFyZXopDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGRldl9lcnJf
cHJvYmUoJmNsaWVudC0+ZGV2LCAtRUlOVkFMLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJDb3VsZCBu
b3QgcmVhZCBsYWJlbCBmcm9tDQo+ID4gQUNQSSB0YWJsZVxuIik7DQo+ID4gKw0KPiA+ICvCoMKg
wqDCoMKgwqAgbGFiZWwgPSBkZXZtX2ttZW1kdXAoJmNsaWVudC0+ZGV2LCByZXotPnBhY2thZ2Uu
ZWxlbWVudHMtDQo+ID4gPnN0cmluZy5wb2ludGVyLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNpemVfdClyZXotPnBhY2thZ2Uu
ZWxlbWVudHMtDQo+ID4gPnN0cmluZy5sZW5ndGggKyAxLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0tFUk5FTCk7DQo+ID4g
K8KgwqDCoMKgwqDCoCBsYWJlbFtyZXotPnBhY2thZ2UuZWxlbWVudHMtPnN0cmluZy5sZW5ndGhd
ID0gJ1wwJzsNCj4gPiArwqDCoMKgwqDCoMKgIGluZGlvX2Rldi0+bGFiZWwgPSBsYWJlbDsNCj4g
PiArwqDCoMKgwqDCoMKgIEFDUElfRlJFRShyZXopOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKg
IHJldHVybiAwOw0KPiA+ICt9DQo+ID4gDQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPiANCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gTWF0dGVvIE1hcnRlbGxpDQoNCg==

