Return-Path: <linux-iio+bounces-9158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E296CC36
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 03:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9DC1C224C6
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 01:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4572D9463;
	Thu,  5 Sep 2024 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="S3tK56U4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CEB666;
	Thu,  5 Sep 2024 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499535; cv=fail; b=VJqC817cKltiTUHI8+ttJ3pjrhQ3fw8l+tZmuVBySXHlZiO88i4MJrGTohYuBbaH5reMjDNyNUn1Ye8wmw9+7JdXdzfTrtNGz/JvWkoiCjX8cJwZrNY3cJZjb1Fy7L3LX5YmgTlE+7tVcXsxaKfznTzV9jj7Kqd4Ip1rtqXx9qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499535; c=relaxed/simple;
	bh=CDi8a7Nr0RJ4x4r2LDxILyCbiHTlK/iU5uOqrdTD+40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kfVndb0tosIz47jghdRQVKrvoz/Ep5/4bg7rJUQ7l0UArEqKBt2eUZpQPlu11eKp347ZjESYBnd6gQsdtKKWDRGCbglNPYBeZKFVTaLwmVPLCddMNMDteLTcQTcXwAr5AuKILSXASKAIffK5azitU06ktP/idRz0T2BSVRKIlJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=S3tK56U4; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484NcQmN028342;
	Wed, 4 Sep 2024 21:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CDi8a
	7Nr0RJ4x4r2LDxILyCbiHTlK/iU5uOqrdTD+40=; b=S3tK56U4D8EWO4GGIweDn
	ptrRpGKtAJcoMeh1cGY9NoeMtTZCM4PBlGZtArn6ZD86Hkjjtp+3eFTi7q/Tolaf
	OJOCn1Ph21YIh+8Qt6vYe+A1BO09N+7sZRgrWAx57n9YTLTGDaQk+jN2FM5Oh6bl
	CxVDYts57FFUk0FXO0RI94zqT5O3yd9wOgKKcWcZYtoCcKkpL/0Wk9acWyE/r/8E
	WNWbVCDB7h6e8g3Ev4kia6RBpoptXslxmzfqZb2B5x3Ur04G47U3jSeqFgYXHIlt
	Al1SFWLS355+MQJk/DUbFnN/k3CD8MD84AbpmHY41DRsJoLurgOx/h+gsYTzSeTM
	g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010006.outbound.protection.outlook.com [40.93.13.6])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41f1d2r8r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 21:10:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwbgA384R72Oa4cKk4j6J34bdh9CDCVNsUb1dkoINDRfLHloqFncm/Xqt5l36P5v2iDP4WMrMfNlEmRS1jXkDHIYMbKirk6o5S2FfqWv9zLiaCaV397G9RCtt2Ry1WyZHDZmeuygx2Vi8QsbI0ahKYZ5GTFWdfOeQxtogoMO3QH0MPaKrBzIxnGG3wXbC0OtEVhGTGDRGuc8WZPgdKmZUZAspWSfd91/bw1M4pxq1yv19AKnAEYm8cM/L01s5rGXcCfJE5OOZtXGudXa5Hf9UPhJJzVzLEjrQdK4e3RhZhwzjURiDBd8kVyupOoFcO+W+FECOce0g7dS8yhbCrRVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDi8a7Nr0RJ4x4r2LDxILyCbiHTlK/iU5uOqrdTD+40=;
 b=xt4PRCIZIugUgwtULgF7IBlC/gt1/Xee/TACroKfARlBy1t4LBX9p0hqUlzK3LhMefmlQ52OchXYlo8vfNmexeHdqXgfZgOsKs+uQvE4OqnGstih+CI/+0lNOo/phKDVx88oy0dc3GjivHvJLvwIg09mqEQSBNiD20qxpGvvCumvoK3v4cK51s6BG7HdEZuviAIv7/dlHdLasYmPQlGVN/LgBPQgabIZZzHjJ2XbIus3QQ6YgfLPt0GGvseoJh1zYpPokGdfhBpmlOnkmGnclX8SqWcvaMquj2DtciG/7GmL1B+woc+bxA7Dzs/JFrfhbo2P/2sxPAmASk0u5T5YUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by SJ0PR03MB6747.namprd03.prod.outlook.com (2603:10b6:a03:40a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 01:10:34 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%4]) with mapi id 15.20.7897.021; Thu, 5 Sep 2024
 01:10:34 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan
 Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Subject: RE: [PATCH v3 0/2] Add support to AD8460 Waveform Generator DAC
Thread-Topic: [PATCH v3 0/2] Add support to AD8460 Waveform Generator DAC
Thread-Index: AQHa/pH/WY2ExzO/FUiTDxJAcjk/l7JIYf6Q
Date: Thu, 5 Sep 2024 01:10:33 +0000
Message-ID:
 <SJ0PR03MB6224400140AE07445D78D55C919D2@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
 <36nd2cbka2oeht73eadgsftpq6uq2de4ip4qddh46zo6fuwppn@ok7topfbmsys>
In-Reply-To: <36nd2cbka2oeht73eadgsftpq6uq2de4ip4qddh46zo6fuwppn@ok7topfbmsys>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzEwYVc1aFkyOWNZWEJ3WkdGMFlWeHliMkZ0YVc1blhE?=
 =?utf-8?B?QTVaRGcwT1dJMkxUTXlaRE10TkdFME1DMDROV1ZsTFRaaU9EUmlZVEk1WlRN?=
 =?utf-8?B?MVlseHRjMmR6WEcxelp5MWhNMlk1TmpnMFpTMDJZakl6TFRFeFpXWXRPR016?=
 =?utf-8?B?TUMwM05EQTBaakUxTWpOalpUaGNZVzFsTFhSbGMzUmNZVE5tT1RZNE5UQXRO?=
 =?utf-8?B?bUl5TXkweE1XVm1MVGhqTXpBdE56UXdOR1l4TlRJelkyVTRZbTlrZVM1MGVI?=
 =?utf-8?B?UWlJSE42UFNJME5UYzJJaUIwUFNJeE16TTJPVGszTWpJek1EZzFNemd3TlRj?=
 =?utf-8?B?aUlHZzlJbXRzT1hnMEwzaFhWR0Z2UTNkVk9IVkdRVTlXYTBzdmNsQlNaejBp?=
 =?utf-8?B?SUdsa1BTSWlJR0pzUFNJd0lpQmliejBpTVNJZ1kyazlJbU5CUVVGQlJWSklW?=
 =?utf-8?B?VEZTVTFKVlJrNURaMVZCUVVSblJFRkJSRXA2YzFKdFRWQXZZVUZqVm1wc2NW?=
 =?utf-8?B?ZHFXREY0TW5oWFQxZHdZVTVtV0VoWlJFRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGSVFVRkJRVVJoUVZGQlFWTm5TVUZCVHpSQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZGUVVGUlFVSkJRVUZCTTB4b1UyWm5RVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlNqUkJRVUZDYUVGSFVVRmhVVUptUVVoTlFWcFJRbXBCU0ZWQlky?=
 =?utf-8?B?ZENiRUZHT0VGalFVSjVRVWM0UVdGblFteEJSMDFCWkVGQ2VrRkdPRUZhWjBK?=
 =?utf-8?B?b1FVZDNRV04zUW14QlJqaEJXbWRDZGtGSVRVRmhVVUl3UVVkclFXUm5RbXhC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIwVkJXa0ZDY0VGR09FRmpkMEpz?=
 =?utf-8?B?UVVkTlFXUlJRbmxCUjFWQldIZENkMEZJU1VGaWQwSnhRVWRWUVZsM1FqQkJT?=
 =?utf-8?B?RTFCV0hkQ01FRkhhMEZhVVVKNVFVUkZRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZCUVVObFFVRkJRVmxSUW10QlIy?=
 =?utf-8?B?dEJXSGRDZWtGSFZVRlpkMEl4UVVoSlFWcFJRbVpCU0VGQlkyZENka0ZIYjBG?=
 =?utf-8?B?YVVVSnFRVWhSUVdOM1FtWkJTRkZCWVZGQ2JFRklTVUZOWjBGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkNRVUZCUVVGQlFVRkJRVWxCUVVGQlFVRlBORUZC?=
 =?utf-8?B?UVVGQlFVRkJRVU5CUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUZCUVVGblFVRkJR?=
 =?utf-8?B?VUZCUVVGQmVtZEJRVUZCVFVGQlFVSlBRVUZCUVVGQlFVRkJSMFZCV2tGQ2NF?=
 =?utf-8?Q?FGOEFj?=
x-dg-rorf: true
x-dg-refone:
 d0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCbUFHRUFiQUJ6QUdVQVh3Qm1BRzhBY3dCcEFIUUFhUUIyQUdVQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFESUFBQUE9Ii8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|SJ0PR03MB6747:EE_
x-ms-office365-filtering-correlation-id: f3a71b43-7a08-4810-8677-08dccd478b14
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTNyYXBoQ0FXK25pNFdBTmlSRmVEN2xLaWNnS3hoL2QyOTRBaHNORzR2dmIv?=
 =?utf-8?B?ajVkR0hVbXo1d2NRQWlPNjFrN25IZEZ0Z1NjRjM0b1NPRlEvdkw5OFVxRnlW?=
 =?utf-8?B?bVFDNTJXQmMxZXQwZTJISDMvNFlzSlBxRHlJTXFLVGx1UVhHdFlMOVJMWDFj?=
 =?utf-8?B?eUhhdUxKUTJyV1NLSzlIbUNqdHZUbTZ4RXU1T1dBekNQUDJveDRBeDUwTjFy?=
 =?utf-8?B?eW13TWdwaENuRjVWOHljYXg4cXNZRGxNNjQ4SmdaRWNuSE1UbFZ1dnE4d1Rj?=
 =?utf-8?B?YWF3K1pSbzAvSUYwSW5oK0lGUDR3ZG5oNzZPT0ZRRUZST0pHaTFLTjVaK2ZL?=
 =?utf-8?B?ZWJYdU01Y1ZSOUQ4aklUQzhpTXhzb2xrVXhmdHFYc1JkUW5jQU9rYmhTckhU?=
 =?utf-8?B?Tm4wWEdPV3Zna3FqbmNEZDZ3R1J0cXZTa2VBcjVSQ3JnNlg3NmNsKzNOZlBH?=
 =?utf-8?B?eFdwOThTVDdiR2hxVE1JaFZnck5yNFd0eU1qbmNiQzZrODh2YVJQdEJzSlVR?=
 =?utf-8?B?ZERUYWNYVWdyeDEzSVZ1RmtUdzlzVWF0MitJME4xM0NoNkoxRWJTOXlLQnN2?=
 =?utf-8?B?c1QwdzN4akE1cThZSUZlbmUyc3NqSFF1V2VQdElkZjJhOEl4bGlhbEZGdnVz?=
 =?utf-8?B?KzB2cDA2TjZSZ1k4TG9YcU1mS0JYODhFV0lVbGVkNXM3TE9zSVlUWW5raWJE?=
 =?utf-8?B?Zzg0R0paU3NBV1RDN1J1dDRJUGFmUnJkRkZmNjFvcnVWa2FLVk5GS0FKOUNl?=
 =?utf-8?B?NUR0cHVYV1NNclNHdzkwODhDaTh0UlNEQkxnU21DYjhGeFRXVDU0cnE3Ylk5?=
 =?utf-8?B?YTYxZWIwdkp1eGh6RDlXOW5FYllVTytvaVNPemkzUEtmMk54cFlsSm9McWFw?=
 =?utf-8?B?RTdHaFJZUXFpMzkyUFUzY3poa0U3bWQzZG9KOFlMSlA5UHBkZGtTZzhJOWlh?=
 =?utf-8?B?TGU0Z1M2SDcvOVdsM2JoQmIvYmlzSnBIUXpzNzV2dEprN1g5dWp6cmRnWUNZ?=
 =?utf-8?B?QTVRR3pYRStJOXpxZENOb0RRb1FiTUNXYklSNFV1bWhrV1BVVDNOczVsVXRC?=
 =?utf-8?B?RzhFNGdaVnoyaUhJUzU1ZS9iNURDdld0anovY3VESlByYno1MWR3VlN0bVZB?=
 =?utf-8?B?NEhWMS9vWURYVno1OEFtK0lEY1F6TllZQTZKa2R3Z0RzNVFwb3dFVkQwNVpq?=
 =?utf-8?B?Mi9waHRrSDl6U0tKRXR1aVNiYTlkU2VZOUlwWEhoa2tRT1JtR2JEOEY1STJx?=
 =?utf-8?B?ZnA1VUlSVC96ZklYSXRpUWlOMlFqY2Z3WTBPemxBOFVabWVhNkszWG9VcXlE?=
 =?utf-8?B?Z2NoQm1yNEgxWWs1aDVqenk4KytqUnpubkQ1Y2FUdUlucGpaeTZBVGJqMlhD?=
 =?utf-8?B?VzVUYU9mcTFXSnZxcnNxQ0lYb3JpMC9hZEsxQ0J6c1AzRFlpaWZ5UnpSWUJ5?=
 =?utf-8?B?L283SXM4U3FrQ0VrUkRhb2phWnFQY1N6TzYxa3Vid1EzdEpITzBvU3Q4aFpG?=
 =?utf-8?B?aWRQOElYcWxaSy9yYzZHajNla2FsNzgwMEtzMjJUZjJIRGxSRUpRV2RpSGZ4?=
 =?utf-8?B?MmxUOE5TSmRTOGQzQU1VTXBtNEZVVThrZW13bzdFd01Xcm9Qb0hyYy9rN1Fj?=
 =?utf-8?B?OHJ2MlM3VVJ6WEhJWUxIL0lUZDZ1T25KUHp3SVZGWXlyWXhxN1V2dGVkbUtO?=
 =?utf-8?B?UERNTW5TaURmaHN3NEk1OUFRVHBFUDRTcnBxelBuOE1DYVJLTmNSdUpGMFFC?=
 =?utf-8?B?UmJOemp3VHl5cEdLcDBXNDgyYXRoOGtCK3E0VFVmL3VjOXlVc0xNN1dOSTNi?=
 =?utf-8?B?cDF1bitYSFl3bXVwdWxNWDhjbGhsL01JdExwUGN3RC9JYXJtNW1VNlVlMFM4?=
 =?utf-8?B?cTlZdDUxSTJpeUxMbjJ1UEtNaytTb1hkNDIvUE9VR3B5ZVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWhEaGk3S2NYQkZvQUNRMEtwRTNYZEErY09SRFpYRU1hWlF0Q3JBaXIrT25a?=
 =?utf-8?B?M3hzQlltZjdlQW9Hb2hlUmxiQ0poOVl6VE9jaFQ0WnR4dk5WTlRMbzF6b0ZD?=
 =?utf-8?B?ZDkzZjVCR0M3QmJFeWpwRDdORGkveFJLSzVGVjNLVDd1RnVpMFBBTUZQemE3?=
 =?utf-8?B?ZVZkTDJxa0ozVWRrVUZxSU84R29RS25EMFlZNW9XNExVT0d3UFlHMmZsdGJH?=
 =?utf-8?B?NmJyeklYNkE3d2tzQXJYSGFoRk9ENWRJcTk0ZTQxaWd0MFowVnlhZXo5VXFQ?=
 =?utf-8?B?aVBManFKMnpaOHk5WStWaWRSZVJFeE9iQ0RiQVRaWGFBRHBKbnM0S08wQ3RD?=
 =?utf-8?B?Wk5oZU8wR3lVWEIyTXhmbDJISjlJeDF3L1RYWStJT0Zjcnhwb01qZ2dIY3Aw?=
 =?utf-8?B?cFY4NWIzbWd3QnZKbk5oamZzYXkyaTNJYXczL0pnT1JNTndoVHZlTnh0M01S?=
 =?utf-8?B?b29xTXl5dlNsSmNxMGhwN3k5ZGxDY0c4aDErSEpqUlg5dFdpcWlwU2J6UHN6?=
 =?utf-8?B?bzIxaTdsQy9KQ1Z1ZUpEWWsraHpwU05DSllYZndRd2diQWtNS2FZU2VvUVhh?=
 =?utf-8?B?d242Y3JVZnlZWWNzQjFUMEM3MUY0VnNPc0w2M080QlFkR3lacU45RStxMitN?=
 =?utf-8?B?N1AvOG5Md09ubTVyVmwxamE2TTVjVThsRGd4bUhFSFhmZDRSVWUvZW13dHR6?=
 =?utf-8?B?K2YxN09JZVMvYU8raE5PcmpLN0l6RlVQMm9xNS9LV1BRUmNMb041akpCYnFm?=
 =?utf-8?B?bEVOYU9ZZEVCZXI1VlRQdTE3RGgzNkZrNCs0UDJHRjN2aHA3TnhvZzMxNE5P?=
 =?utf-8?B?UkFYL1RzQXJBNUFCUUVORTRtdXRTVzhySlArR1pITitkS3ZmMU5EcFZnNWFl?=
 =?utf-8?B?VHlHNWp3Mm5mZHhSeUVtRFZYT1ZFVHhEMTRZZVFwM2duNUZVTnF4bGpSSjJY?=
 =?utf-8?B?QTRHbkhORFlwT3E4eVZablR0aVdlQTlvWDdtckZhQ0FnSHkyUTR5Y0M2MHAr?=
 =?utf-8?B?R0duVUdjZGI2R3pWZll1NWNLVURiS2YwTmUvMDRUSzJPQlhKMXRHVVBRejBF?=
 =?utf-8?B?SDEwV08xaXliekd2VGRQMEJoM01RWnQwT2pQc0tJY29LZmlxOHZ0aWRVNzE5?=
 =?utf-8?B?MEZBblJtOG8zaTZFSUNiTHpEN2RCNUQ5U2M1Mk1WUDRnSnZpNzlCY3VyZ2xt?=
 =?utf-8?B?R1h3YStWaHM2a0xNL3FJWVFOM0tQME1QNEVKSWo2eEk3dVFXR2lFb1UyS3NR?=
 =?utf-8?B?ek5Ya1htUDhicHhiSEtrYk4rYVZhYmNrUkFwMEhYbE9YWDY2RXh5Mmd5SEtD?=
 =?utf-8?B?cUlTZUtuTStySjM1eTlyemRqWmViSVA5aG5NcHUwYndwQUpVaVFMK3M1Wlhn?=
 =?utf-8?B?UEVkRFlSUk9XdFczRjcvdHA2RmFFTmlvN2FpdkFzZ3pKR0VockUvS1JLaStJ?=
 =?utf-8?B?ejRGTTB4NC90aHlMV1oxSU9rQWpBRTAwZHQyVDIreWpBeHNVekdDZzlQMEFO?=
 =?utf-8?B?Wnk3bmdhMFlFd0h3dUxRc0VDOGJ4SHVMSDdsc1VMNllxTVFUa0s5N0w3UUNE?=
 =?utf-8?B?OUROcnFBRUdxeXJXbU1VenFYcnZFVHdPb3htdlQvWkRRU1JmcnpVUEloQjN3?=
 =?utf-8?B?ai9ZMFNoWE1ZaFJ0YTFUTmdTVHcrejl4cTMzcVNMSTB1VitUWktVaE90QU01?=
 =?utf-8?B?cE5SWlVoYzZNRUlQYlN3OTNWQ2VkdXgxSUhFQUsrZzNQTmowNDE5SkFBUVgr?=
 =?utf-8?B?Y1NHU2NjTmVuTHFvc1h5N1lJNWVKS2lCV04vZzVjd1FjbVdiVXdHTEtrdWd5?=
 =?utf-8?B?NVZnZjBDQVJHWXRZY1ZkM3hKUjR0NlJ0UXBSeXpsN20zUXNwUFo4aXQ4Y2sx?=
 =?utf-8?B?anZaQ1U5eHZXQ0tLeFBLK0pmOHExSnVmVkNIK283WDhUTitCcEJINytGbzdt?=
 =?utf-8?B?Y3pkSkxMc0FaMzc4cVAxY294ZEhsdXJLaHh6dktHaHVWMERlVnB3NHlGc2ZJ?=
 =?utf-8?B?QXhucnRJaHZmd011M1grVTJoV2R2SUVNNHdsYVdSTmpHSmlZK0gvcUpPY1dP?=
 =?utf-8?B?bnpGaDZvVlM5c2NLWXFXWVlRaDdXWVc0bGxTN1RYZzJVQ1VqV1ZSZkFaekY2?=
 =?utf-8?Q?OyZyLYqIezjriX6+yI8AmiBN8?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6224.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a71b43-7a08-4810-8677-08dccd478b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 01:10:33.9410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fd80ynF7Nhp0phPgDJdacGLTfHgDIfKjBPVpxhh005csIQefYBOhx1kBG49a0A8s0Oj7s5GxTTYo5WnZs7IT1WbzrsDnmhgPE1GMVjIAhGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6747
X-Proofpoint-ORIG-GUID: grekGXcn0XUWuEjrbppoy7r0BpM4arBX
X-Proofpoint-GUID: grekGXcn0XUWuEjrbppoy7r0BpM4arBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_22,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050007

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciA0LCAy
MDI0IDI6MTYgUE0NCj4gVG86IFRpbmFjbywgTWFyaWVsIDxNYXJpZWwuVGluYWNvQGFuYWxvZy5j
b20+DQo+IENjOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEpvbmF0aGFuIENhbWVy
b24gPGppYzIzQGtlcm5lbC5vcmc+OyBMYXJzLVBldGVyDQo+IENsYXVzZW4gPGxhcnNAbWV0YWZv
by5kZT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gS296bG93
c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPE1pY2hhZWwu
SGVubmVyaWNoQGFuYWxvZy5jb20+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+
Ow0KPiBNYXJjZWxvIFNjaG1pdHQgPG1hcmNlbG8uc2NobWl0dDFAZ21haWwuY29tPjsgRGltaXRy
aSBGZWRyYXUNCj4gPGRpbWEuZmVkcmF1QGdtYWlsLmNvbT47IERhdmlkIExlY2huZXIgPGRsZWNo
bmVyQGJheWxpYnJlLmNvbT47IE51bm8gU8OhDQo+IDxub25hbWUubnVub0BnbWFpbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC8yXSBBZGQgc3VwcG9ydCB0byBBRDg0NjAgV2F2ZWZv
cm0gR2VuZXJhdG9yDQo+IERBQw0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24gV2VkLCBTZXAg
MDQsIDIwMjQgYXQgMTA6MzA6MzhBTSArMDgwMCwgTWFyaWVsIFRpbmFjbyB3cm90ZToNCj4gPiBB
cHBseSBjb21tZW50cyBmb3IgYWRkaW5nIHN1cHBvcnQgdG8gQUQ4NDYwIFdhdmVmb3JtIEdlbmVy
YXRvciBEQUMNCj4gPg0KPiA+IGFkODQ2MDoNCj4gPiAgICogRml4ZWQgZXJyb3JzIGRldGVjdGVk
IGJ5IHRlc3QgYm90DQo+ID4gICAqIEFwcGxpZWQgcHJvcGVyIG1hc2tpbmcgb2YgZml4ZWQgdmFs
dWVzDQo+ID4gICAqIEFwcGxpZWQgcHJvcGVyIHdyYXBwaW5nIHRvIGdldCBjbG9zZSB0byA4MCBj
aGFycw0KPiA+ICAgKiBBcHBsaWVkIHByb3BlciBjb21tZW50IGZvcm1hdHRpbmcNCj4gPiAgICog
QXBwbGllZCBwcm9wZXIgcGxhY2VtZW50IG9mIGJyZWFrcyBpbiBzd2l0Y2ggY2FzZXMNCj4gPiAg
ICogUmVtb3ZlZCBjaGFubmVsIHByb3BlcnRpZXMgdW51c2VkIGJ5IElJTyBidWZmZXIgaW50ZXJm
YWNlDQo+ID4gICAqIFNpbXBsaWZpZWQgcHJvcGVydHkgZ2V0dGluZyBvbiBwcm9iZSBmdW5jdGlv
bg0KPiA+ICAgKiBGaXhlZCBlcnJvciBoYW5kbGluZ3Mgb24gcHJvYmUgZnVuY3Rpb24NCj4gPiAg
ICogRml4ZWQgc2V0dGluZyBvZiBvdmVydm9sdGFnZSwgb3ZlcmN1cnJlbnQgYW5kIG92ZXJ0ZW1w
ZXJhdHVyZSByYW5nZXM7DQo+ID4gICAgIElmIHZhbHVlIHByb3ZpZGVkIGlzIGludmFsaWQsIGRl
ZmF1bHQgc3RhdGUgb2YgdGhlIHJlZ2lzdGVyIHdpbGwgbm90DQo+ID4gICAgIGJlIHJld3JpdHRl
bg0KPiA+DQo+ID4gQmluZGluZ3M6DQo+ID4gICAqIERyb3BwZWQgdW5uZWNlc3NhcnkgZGVzY3Jp
cHRpb25zDQo+ID4gICAqIFVwZGF0ZWQgcHJvcGVydHkgZGVzY3JpcHRpb25zIHRvIGRlc2NyaWJl
IGZ1bmN0aW9uYWxpdHkgcHJvcGVybHkNCj4gPiAgICogQWRkZWQgbXVsdGlwbGUgc2VsZWN0aW9u
IG9mIHZhbHVlcyBmb3IgYWRpLHJhbmdlLW1pY3Jvdm9sdCBwcm9wZXJ0eQ0KPiA+ICAgKiBGaXhl
ZCBmb3JtYXR0aW5nIGVycm9ycyB0byBmb2xsb3cgRFRTIGNvZGluZyBzdHlsZQ0KPiA+ICAgKiBM
aWZ0ZWQgR1BJTyBuYW1pbmcgZnJvbSBncGlvLWNvbnN1bWVyLWNvbW1vbiB5YW1sDQo+IA0KPiBU
aGlzIGFsbCBoYXBwZW5lZCBpbiB2Mz8gT3IgdjI/IFBsZWFzZSB3cml0ZSBhY2N1cmF0ZSBjaGFu
Z2Vsb2dzLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KSXQgc2VlbXMgSSBt
aXNzZWQgdG8gcHV0IHRoZSB2ZXJzaW9uIG9mIHRoZSBjaGFuZ2Vsb2dzLiBUaGVzZSBhcmUgYWxs
IGNvbW1lbnRzDQpWMiBhbmQgdGhlIGNoYW5nZXMgd2VyZSBhcHBsaWVkIHRvIHRoZSBsYXN0IHJl
bGVhc2UsIHYzLiBJJ2xsIGtlZXAgdGhpcyBpbiBtaW5kDQp0aGUgbmV4dCB0aW1lLiBUaGFua3Mh
DQoNCkJlc3QgcmVnYXJkcywNCk1hcmllbA0K

