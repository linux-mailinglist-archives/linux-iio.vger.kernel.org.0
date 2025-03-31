Return-Path: <linux-iio+bounces-17389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730BEA75D98
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 03:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80E43A8EEB
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 01:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9E828399;
	Mon, 31 Mar 2025 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QSJ/H3ip"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8B4A3C;
	Mon, 31 Mar 2025 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743384689; cv=fail; b=QFLIOSzS1ITsWI1WjoKot9ssiGpUB8mq2wDuuqryv1IDEDwu6eqRL2/ZG85o6At0NJZt1p5HH81vwmWXCifuqP2TfCS8748bKkPp7B2H1MO2QW/BajjV8FziVI9Qe9HrVcDuxvwZLfbTduFL6juR12eyaqwz83MKJpQpVDtUaJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743384689; c=relaxed/simple;
	bh=mbKGu8ngQRUXNLBAdNtSJAzFi2koQbbKQXYKDK9A51w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BlQNVFeaGLAxeCUA01iqyA0XgZ0RTB2MTFVKhPUJ7KW5tIkX/8KbuDjbD2HBcYlWlefJ47HBiTFcNkf5skB+OsfYKUbcePARyMpWkwQ2WhuzwVVFB1HY5gAiv+ofQbws2WcmJcmHpWl4wMT35qjTLonGLBSnpd6xeVNiN8tyhuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QSJ/H3ip; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UK8rxn019673;
	Sun, 30 Mar 2025 21:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mbKGu
	8ngQRUXNLBAdNtSJAzFi2koQbbKQXYKDK9A51w=; b=QSJ/H3ipJB0Ky7W8cuCDT
	pwaIygX84lqC7vyaH8v80LnpKvfeD5ZwL5n52ioHG4i6OtK/1AJ4+KOTcVCNW2ui
	eW6gnXwQYYtIVbWxI5+5mPhgbTAmdPnVZrnvzu0WdwuT0Fb7ScssHv4BHnxp+sHu
	EKe0O5m0ieF4Zx/72xeU7UIo/8pwms44p/UJ6tEBh+hLqbsmqkS172gMY+FQUsix
	72D+3UYKSmeFxg+RUUJreCSfQvYtqKuznkFSEi/Zm2MYhPvnLUmIR5X2eMpUFwsw
	DO9wlHufwHyUUEqI7kO5HqJ0Aslq94682oG5a6N73UbdQEMqKOxUF99F5IduG6jf
	w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012012.outbound.protection.outlook.com [40.93.14.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45q2wha27s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Mar 2025 21:31:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrJgBhEXJ6CC1cJaoh7O78RE2/AuqXzOe4icaWH9WmdQkCs3BGH/gjwXXqPNl+li37J2Fo6p4d0DJjhz3gtl6kjzM+CqFphXtThhY/WC8LJOoahVYKV5EP+SZB1vl91E3V/B4BknQnU7mwjfQ4E8BBjAIVi0RkIIkv1/DJraAquk6Grgp0xFokd5nRXous7MIr3BeEYLRiP69yLwSPMpm6mFkwZbDn1Vhwz9x9dfpQoiaP99RtGM6+FrpLbpI+apfNoR/zVYbdXl4Zua2JHJJGGWIQmZNAzX2wrucRqrl+KV0fU5oTiHaknTAbCydB8kI0/Kjr58N9s/fqk6ZZprPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbKGu8ngQRUXNLBAdNtSJAzFi2koQbbKQXYKDK9A51w=;
 b=nExmWMxdV6siygx1JD9lX5o2pfNkmkmQGe/Ig1UfbaRqFgYYPgvR254xfWAEReklEXaCuZWWhAeUnfNppgJFkK4g5ZztRoulYzaF683frKepKPHguOfcUurdGnLXZ2x44zrzJhMYINsditGOhTchMKlE40nX9Gb+dUxqDaoCGS40KoXZa552FCtSG1erzsm6NIFaxjJvB1CFCz/9GaA/q0JDgtfkiBtLne0IsbRiA6o7t/JGg+dUSvq2yPye/D/OIjq/9qnBm9wxkm1F+u3HAlyTYNe6tSQNtd4YnCY0e1E70GglLjY6QfO+a+pJHAkGrZRZ0FhdN1pLa4u5nmHGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by PH7PR03MB7390.namprd03.prod.outlook.com (2603:10b6:510:2ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 01:31:10 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 01:31:10 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Thread-Topic: [PATCH v2 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Thread-Index: AQHbnK9AuE1DHRgR0E2kKUUrLhL6xrOIRzuAgAQ1l1A=
Date: Mon, 31 Mar 2025 01:31:10 +0000
Message-ID:
 <PH0PR03MB71417CFD279F01382D025848F9AD2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
	<20250324-togreg-v2-3-f211d781923e@analog.com>
 <20250328090341.0d213f3d@jic23-huawei>
In-Reply-To: <20250328090341.0d213f3d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|PH7PR03MB7390:EE_
x-ms-office365-filtering-correlation-id: 27f10a81-3383-4d61-0cae-08dd6ff3b7db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWhKZEZscVA1Q3J0WmxpYk5zakZnVXVKOElaVE1RR0xiRSsyMnlEczl5cFI4?=
 =?utf-8?B?Q0pOSEVNL0s3eEw0WDkzWW91ckVRRlo1RkM5amtiS09ObC9oaVRYZU9wUHdj?=
 =?utf-8?B?b05iZFBVb0w0Nk54VnFuWWY0RzJadUlkRnJxdW56RFJUaTNyZjVtUlBReFAv?=
 =?utf-8?B?MWhHQTdDUHZzdnNHazRvSFJIYjFISjNMQXd3K0JkNFhmcjI0V0ZzM09FekpZ?=
 =?utf-8?B?aE9pekdKMmpVbmE1Um1WMkJrdHVkOTFXK1lNN2RoVVdZSFlVckgvNitFcWhG?=
 =?utf-8?B?MUxvQktmSlZna1dRMlc5UjcxSmhSRC9OSFprSERPNjVwdXg0alRiUmFWdjY5?=
 =?utf-8?B?L0Y1ZFcrMzRUalQ0bE9SbUNDYU1TL1UzSWN3WDJvL2dJUzFGK2tJZUZaZEQy?=
 =?utf-8?B?YVU3RlFwVExJd2xMNlFOSkIvYkp1U1Q4NWZ2N2xvanZwL2M5MTNVZ0svZTJn?=
 =?utf-8?B?UEg3ODlaa0ZKUnJhTGlneDVlemZkWlRHQzFxY2xsQVB5SFVJY0Jzd3NzU3BK?=
 =?utf-8?B?dVJEQ2NIS0tmOTJhR2pkUVNsUWhnTXV3M0tBMWhwbDQweUw0aXpUZ20wVHNP?=
 =?utf-8?B?emo4Mmc1ZER2Q3ZGSzNHd1djTWFNMXFPUXFBSEM2QlF4T1hVSVlHa0ZkdHQ3?=
 =?utf-8?B?Nkh1bEJDbXU3M3NBOG8vUm85SW92QUZENkhUN0ZqcGJ4MS9PaGdkdFJtRDNw?=
 =?utf-8?B?OFVDTUZpZjBrMDk5cDZOcWxmclBkWVdGK1BrK1hOelBaa2RoTklLZVMvSmdk?=
 =?utf-8?B?RjZFOVFVVVA3ejV2cSs3Vy9DdFZIWDhGR1VXS0VXeEdaUUtiTGFKQWg1WVJp?=
 =?utf-8?B?ekFoeFZ4S2t0L2k5VlMxV0VLLzhGOUJiazJzdWpIVEpLWEpjbFEzWGRhRUo0?=
 =?utf-8?B?RDQ5NXVmcmM4MWhOY3kyRUhJM3JTNFFueU9ZbnRKKytzcmVpelVGZ1FvY2I3?=
 =?utf-8?B?ZWltbmdoWnR4RVExaW5iNU4vcS9HdVlJQ3JxR1VSMGNBYkt6UmdvQ0s3NzZp?=
 =?utf-8?B?dUJzc2wxZE5Rem9mSWtjSG14TlZ4dUwyVnVSS2ozWllCVnBiWFhEWkZOQUF6?=
 =?utf-8?B?ZGdlTFJQTm5zRzIwMTN3MG1nRGM2Y3hJTlJCRkZ0aVRBbFZaN21IcUwwZ2Zq?=
 =?utf-8?B?U1MwSGhDMUZGSjRIakFBU3dLNkVIYjB0KzhTMWZOTVRlQUY5VHE0ZXJSdVg5?=
 =?utf-8?B?SE1sK0tKQWgya2VxN2ZQZ0VBUzhrV1lqd2kydmg5bXJ2ZFlHRy8wU0dHY0Vh?=
 =?utf-8?B?d1haZnVlaHY4MkVkY2RsQzhXSTIrZWRWRVl4dFhlbWVyV0dtS0loZWRxTXc5?=
 =?utf-8?B?eURJZVlJUG8xWGtZWkdOMjF3c043WTVmbGN6TkRuNlBTeVNNUmNpSFpDckhu?=
 =?utf-8?B?Zlc2ZlBMaVVPZ1ZlN0hpN0kxdlY0VmpyVnVZY2VHMjRhNnFPZTk2WTlqUGth?=
 =?utf-8?B?dk9vZUZQcDgyUG4yTHhKV3hWRU1DTUJwd0FpdkFocnByRWtEeHhmczR5cGtL?=
 =?utf-8?B?TStUOWNuWlErdWxaOGw4ajB6UFpjUmZQUGNMVGpJa1kzOE16VlhYZktlSThp?=
 =?utf-8?B?RzRpNUYxQzdrQ1pvQVgzVk1LOGtDcVU2dTFUTHBHeDBSVEJGRENEZTlkblZq?=
 =?utf-8?B?RWRLU3VqSzdTTEk0WkhGTy94NzZvSEl4eEZKVVJPL2JzWjJjdGxFSXBySTBI?=
 =?utf-8?B?b01nQk53VjRIVTk3bjJVdVZKaVVnajk1V041SElLVEx6WDlYYXRPYTVGak9B?=
 =?utf-8?B?VjJNODk0Z3BEVVU4ajlCWEdWemxkSy9JUUU2MXhOQ0NsckZjZ3FWTWJqVDNG?=
 =?utf-8?B?T25uK0xmV2Z0ejdRWEdkMktTaWhhS0xCQTg0SEhhS1BmcVpJVnB6RFlvd0l4?=
 =?utf-8?B?UzNVZmtnMlRrWTJzUmx3TFdLZlVqN1Zia3BOMFdQTklMY2E3WDBvTEQxeWpE?=
 =?utf-8?Q?uShs7vx4m5U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDNTTFhDNzhWMXQ3Ty9oWHN3dzhlSmNsVU92SWtsNXU3eEY1b1cwSWQ2cU9o?=
 =?utf-8?B?RXQ3RWhPcExYQU9xOTRKNjc4bWx4MXV3eUpwTitpSHFpd1JYOUJYc2tTdDF0?=
 =?utf-8?B?YjNiaXdxNDhUY0ZFd0hjaDFlVytIZGUydFVBWEptTlluY0NPY04reUR4bXJy?=
 =?utf-8?B?OG56Y2JBRHJnVzZ6QkNLM2lDRjh1T0hkSUdLbE1EUWdnUWNvQlB2YjlXZU1i?=
 =?utf-8?B?NEJiYWIyazFpbHFxU25BK3JoOFRtWE1KclJQU1hVcmxTdUxhSTlKb3o3dXRx?=
 =?utf-8?B?WUNwcXlXczg0ajdJR0hqdGE0STNIUHNXblNrMmNFRk9wMGNDREVtNGZmV1NK?=
 =?utf-8?B?bjM3ZnNtTkNXWGgvaEx2VUppLytsMDRUM0FpMXMzb0V1WHQxNFdvSURQRUxP?=
 =?utf-8?B?YWI1dXNIZXRobnAweEtHNWJrNDJyeW1VVlJMK1c3cGJGQS9MSDZsOGMwdENs?=
 =?utf-8?B?eWhsRzVXMncxdnZYSkh5Ulp3bnBqQlI3Q0U2SlBObENqTXN1ZXVsdDR3UFUy?=
 =?utf-8?B?VDNOQlJqNE1Lc0VxSnpwSHRKcjNHYmtEUnBFbjN5SjdCemZ6eEpUbGxObllS?=
 =?utf-8?B?RmRoWlZwTGJJUkdUVUdXUnNob3ljZ3pFZFNMZWY0VzNnK3cxbEVaVVRXU2R1?=
 =?utf-8?B?K3FkOVNGaEQwdEdCU2ErcWo4YkVHWlNMMzJ0a0lKQTIvN3VFOVJ0THl2ZzVw?=
 =?utf-8?B?c0h5TkpDbEdVbUE5NHVtNWx2NmxTM0xTUVZnUFVKaTZBSjk4MjB0SFhsT3VN?=
 =?utf-8?B?Unl1bUY5WVJuUEVxVFZOeVM3YjlFbThPdnVXQUFTWUtSeXkyN3lyZzVTMjlG?=
 =?utf-8?B?SXRzSFhkaThwb3JLanIyTnNBemFhampvYUllb0FVYnVDR2Roa2o4WFd3UDRl?=
 =?utf-8?B?bGpXV2VWeXZnVzB4UkFaanhEQno5VUJxeE1wVjNmYnYzbzY3ckNNTWZTUmVS?=
 =?utf-8?B?cEYrT3hZeURKbXZsSXI2MTA3dFc1Yit0ZllQY2ptMDdNMFIvYVE3RjNnMTMx?=
 =?utf-8?B?YVVmSDVXZXc4aVJsY2dZSXpLYmE2cXU2VTJROElTUnd1V2NzQk44bk1kWVhZ?=
 =?utf-8?B?R2FndGNBbmkxRXYxSGhMV2Fwckw4dFNza2JrUitBN0NhRG9UQzVhTk5tUlVh?=
 =?utf-8?B?R2RrbWR0UkFVenJORUNMOVZweUthUnFMQVZxWjVlY2YzUG5sUUZ6U1NtSXJu?=
 =?utf-8?B?dndaaWp2WklUOHNWSzVqaHlHYWlVZGxRdEQ2OHdUSHZKNU16MHpMZjFMVU5l?=
 =?utf-8?B?aDFiVmxzR3htUkFxQ3NWMlBnYlhnOUwwR0ZqVzdEUjZBNFVmYk9yUTJmYWlV?=
 =?utf-8?B?eXprVm5Jcmh4TTVjOHZNTk9pdjd5M2lhUnRReDFXWXlwbVFCdHdoNXBub2Zu?=
 =?utf-8?B?a3dUOVdiZG9jcjVGS2VZUTRhNWZHMWlXajF5MGFTbEY0SDZVYzVENGh6Q01y?=
 =?utf-8?B?R05TVFJSdjBSdHhIU2U1RTNoUFRzYWcwS1kyOGxIZ2YzL2tDNnFLN0xJcmZl?=
 =?utf-8?B?dXE1YXZPT0NIR0RjR2dLMmpXb3Z5WEoyUGhZRHRGeWVHcnZWcktUY0dWTGxU?=
 =?utf-8?B?czczckNZTlFhTk1JcnRPWTQvMmtpeFE2SXZKSjBKTjlmbmpvZEVib0lJTEVY?=
 =?utf-8?B?Nmh0Skgwc2d5dzFrNWU5aklVdWpxZldXZmVPRkF3bVlTdVN4QlNQaUFuRHlY?=
 =?utf-8?B?WUhIUk9xZlQ5MFhpZ09vTm9EaVQ0NTZvNWFHZ3pyU1VzQnlmQVp2ZDRUcGMy?=
 =?utf-8?B?K0hRWHhOck16enkwUTZNQlNmYU9UbVNPcGRhb1Iwd3RPWDUwZVVmT3RSOHg0?=
 =?utf-8?B?MzhZVVhGNEdXdVF3VmwwNHdGZCtJMDMzWVlldENaVnVxbE5CUzdyRkFkTGFy?=
 =?utf-8?B?YnBzTDhBNFRMMkNZaS9rZUlWVFlkd3JOd01hZVhBMURETEE2bWd6SmxLeS9z?=
 =?utf-8?B?dVlvaGtNcTUxYTh2NXo2NEFKNXhCcVo5Zyt5QXJNb0tWZGk1NURHQzVna3Uy?=
 =?utf-8?B?dVFRckx5NEtzYTIrWEtYc05GaWMxU3hJNGZhVng3VlB2ak5kNSthUlFBNFQ2?=
 =?utf-8?B?L25tVUtRUDJXMXNWaFJSRURjVnhqcHRBbzBNeWcrRmFNbFVZYnJtUVJiNlp2?=
 =?utf-8?Q?OQaUCn99/Z3hZ/rDIwt8qfrZ/?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f10a81-3383-4d61-0cae-08dd6ff3b7db
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 01:31:10.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dU8bzIfIJuWlWJ3STJgsutjCsp822bk6TwDguxdwotFB1dx8SoXZZM08/zv23VWErBG5tkKpy7TPSCnFOdo1DK6+Q/nACDhgXCxC6F/658Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7390
X-Proofpoint-ORIG-GUID: fXD_57qD_XxZ2PzH9NBjUeN64WgQ06Vm
X-Proofpoint-GUID: fXD_57qD_XxZ2PzH9NBjUeN64WgQ06Vm
X-Authority-Analysis: v=2.4 cv=TKJFS0la c=1 sm=1 tr=0 ts=67e9f061 cx=c_pps a=rJOuE113HAlAKDwVaFkQAw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=uherdBYGAAAA:8 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=CYIj-Y6xOQm1mRMj_SkA:9 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310009

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyOCwgMjAyNSA1OjA0
IFBNDQo+IFRvOiBQYWxsZXIsIEtpbSBTZWVyIDxLaW1TZWVyLlBhbGxlckBhbmFsb2cuY29tPg0K
PiBDYzogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBIZW5uZXJpY2gsIE1p
Y2hhZWwNCj4gPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3Jn
PjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgbGludXgtDQo+IGlpb0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy80XSBkdC1iaW5kaW5nczog
aWlvOiBkYWM6IEFkZCBhZGksYWQzNTMwci55YW1sDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBP
biBNb24sIDI0IE1hciAyMDI1IDE5OjIyOjU3ICswODAwDQo+IEtpbSBTZWVyIFBhbGxlciA8a2lt
c2Vlci5wYWxsZXJAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IERvY3VtZW50IHRoZSBBRDM1
MzBSL0FEMzUzMCwgYW4gOC1DaGFubmVsLCAxNi1iaXQgVm9sdGFnZSBPdXRwdXQgREFDLA0KPiA+
IHdoaWxlIHRoZSBBRDM1MzFSL0FEMzUzMSBpcyBhIDQtQ2hhbm5lbCwgMTYtQml0IFZvbHRhZ2Ug
T3V0cHV0IERBQy4NCj4gPiBUaGVzZSBkZXZpY2VzIGluY2x1ZGUgc29mdHdhcmUtcHJvZ3JhbW1h
YmxlIGdhaW4gY29udHJvbHMgdGhhdCBwcm92aWRlDQo+ID4gZnVsbC1zY2FsZSBvdXRwdXQgc3Bh
bnMgb2YgMi41ViBvciA1ViBmb3IgcmVmZXJlbmNlIHZvbHRhZ2VzIG9mIDIuNVYuDQo+ID4gVGhl
eSBvcGVyYXRlIGZyb20gYSBzaW5nbGUgc3VwcGx5IHZvbHRhZ2UgcmFuZ2Ugb2YgMi43ViB0byA1
LjVWIGFuZCBhcmUNCj4gPiBndWFyYW50ZWVkIHRvIGJlIG1vbm90b25pYyBieSBkZXNpZ24uIEFk
ZGl0aW9uYWxseSwgdGhlc2UgZGV2aWNlcw0KPiA+IGZlYXR1cmVzIGEgMi41ViwgNXBwbS/CsEMg
aW50ZXJuYWwgcmVmZXJlbmNlLCB3aGljaCBpcyBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogS2ltIFNlZXIgUGFsbGVyIDxraW1zZWVyLnBhbGxlckBhbmFsb2cu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2FkaSxh
ZDM1MzByLnlhbWwgICB8IDkxDQo+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgTUFJTlRB
SU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgOTIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2FkaSxhZDM1MzByLnlh
bWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9hZGksYWQz
NTMwci55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleA0KPiAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLi5lNTgxNDcyYjUwMDQ4YmVkZGE3NDIN
Cj4gMjc0ODAzNTQyM2I5YjAyMDM4Mg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9hZGksYWQzNTMwci55YW1sDQo+
ID4gQEAgLTAsMCArMSw5MSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BM
LTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+
ICskaWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5v
cmcvc2NoZW1hcy9paW8vZGFjL2FkaSxhZDM1Mw0KPiAwci55YW1sKl9fO0l3ISFBM05pOENTMHky
WSEtYkVxaC1iS3otYS0NCj4gWnpmYkpad1hpOUtXd0tsc2tfUGNhajVYUUxlTGFEQnBPOE1hcnlS
ZWRSSGFMMEdVRmZOejM1dERzRmFKa1Y0NVANCj4gZnlFekEkDQo+ID4gKyRzY2hlbWE6IGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS0NCj4gc2No
ZW1hcy9jb3JlLnlhbWwqX187SXchIUEzTmk4Q1MweTJZIS1iRXFoLWJLei1hLQ0KPiBaemZiSlp3
WGk5S1d3S2xza19QY2FqNVhRTGVMYURCcE84TWFyeVJlZFJIYUwwR1VGZk56MzV0RHNGYUprVjV6
STQNCj4gek1hUSQNCj4gPiArDQo+ID4gK3RpdGxlOiBBbmFsb2cgRGV2aWNlcyBBRDM1MzBSIGFu
ZCBTaW1pbGFyIERBQ3MNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gS2ltIFNl
ZXIgUGFsbGVyIDxraW1zZWVyLnBhbGxlckBhbmFsb2cuY29tPg0KPiA+ICsNCj4gPiArZGVzY3Jp
cHRpb246IHwNCj4gPiArICBUaGUgQUQzNTMwL0FEMzUzMFIgYXJlIGxvdyBwb3dlciwgOC1jaGFu
bmVsLCAxNi1iaXQsIGJ1ZmZlcmVkIHZvbHRhZ2UNCj4gb3V0cHV0LA0KPiA+ICsgIGRpZ2l0YWwt
dG8tYW5hbG9nIGNvbnZlcnRlcnMgKERBQ3MpIHRoYXQgaW5jbHVkZSBzb2Z0d2FyZS1wcm9ncmFt
bWFibGUNCj4gZ2Fpbg0KPiA+ICsgIGNvbnRyb2xzIHRoYXQgcmVzdWx0IGluIGZ1bGwtc2NhbGUg
b3V0cHV0IHNwYW5zIG9mIDIuNVYgb3IgNVYgZm9yIHJlZmVyZW5jZQ0KPiA+ICsgIHZvbHRhZ2Vz
IG9mIDIuNVYuIFRoZSBkZXZpY2VzIG9wZXJhdGUgZnJvbSBzaW5nbGUsIDIuN1YgdG8gNS41ViBz
dXBwbHkNCj4gcmFuZ2VzDQo+ID4gKyAgYW5kIGFyZSBndWFyYW50ZWVkIG1vbm90b25pYyBieSBk
ZXNpZ24uIFRoZSBBRDM1MzBSIGFsc28gb2ZmZXJzIGEgMi41ViwNCj4gPiArICA1cHBtL8KwQyBp
bnRlcm5hbCByZWZlcmVuY2UgdGhhdCBpcyBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KPiA+ICsgIERh
dGFzaGVldCBjYW4gYmUgZm91bmQgaGVyZToNCj4gPiArICBodHRwczovL3d3dy5hbmFsb2cuY29t
L21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtDQo+IHNoZWV0cy9hZDM1MzBf
YWQ1MzByLnBkZg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0K
PiA+ICsgICAgZW51bToNCj4gPiArICAgICAgLSBhZGksYWQzNTMwcg0KPiANCj4gWW91IG1lbnRp
b24gdGhpcyBvbmUgYXMgd2VsbCBhcyBhIHZhcmlhbnQgd2l0aG91dCB0aGUgciBwb3N0Zml4IGlu
IHRoZQ0KPiAnZGVzY3JpcHRpb24nLg0KPiBTbyB3aHkgbm90IGNvbXBhdGlibGUgZm9yIHRoYXQ/
ICBJZiBpdCdzIHNvZnR3YXJlIGNvbXBhdGlibGUgd2l0aCB0aGUgciB2ZXJzaW9uDQo+IHRoYW4N
Cj4gYSBmYWxsYmFjayBjb21wYXRpYmxlIG1ha2VzIHNlbnNlLiAgV2UgcHJvYmFibHkgc3RpbGwg
d2FudCB0byBoYXZlIHNlcGFyYXRlDQo+IGNvbXBhdGlibGVzIHRob3VnaCBpbiBjYXNlIHdlIGdl
dCBhbiBlcnJhdGEgdGhhdCBvbmx5IGFwcGxpZXMgdG8gb25lIG9mIHRoZW0uDQo+IA0KPiBJZiB0
aGV5IGFyZSB0aGUgc2FtZSBzaWxpY29uLCBwZXJoYXBzIHdpdGggZGlmZmVyZW50IHJhdGluZ3Mg
dGhlbiBtYWtlIHRoYXQgY2xlYXINCj4gaW4gdGhlIGRlc2NyaXB0aW9uIGFuZCBwZXJoYXBzIGl0
IGlzIGZpbmUgdG8gbm90IGhhdmUgYm90aCBjb21wYXRpYmxlcyBsaXN0ZWQuDQoNClRoZSBtYWlu
IGRpZmZlcmVuY2UgaXMgdGhhdCB0aGUgciB2YXJpYW50IHN1cHBvcnRzIGJvdGggaW50ZXJuYWwg
YW5kIGV4dGVybmFsIHJlZmVyZW5jZXMsDQp3aGlsZSB0aGUgbm9uLXIgdmFyaWFudCBzdXBwb3J0
cyBvbmx5IGV4dGVybmFsIHJlZmVyZW5jZXMuIEkgYWdyZWUgd2l0aCBoYXZpbmcgc2VwYXJhdGUN
CmNvbXBhdGlibGVzLiBXZWxsLCBJJ20gdGhpbmtpbmcgb2YgYWRkaW5nIGEgcGFyYW1ldGVyIGlu
IGNoaXBfaW5mbyBpbnRvIHRoZSBkcml2ZXIgdG8NCmlkZW50aWZ5IGludGVybmFsIHJlZmVyZW5j
ZSBzdXBwb3J0LiBXaGF0IGRvIHlvdSB0aGluaz8NCg0KPiANCj4gPiArICAgICAgLSBhZGksYWQz
NTMxcg0KPiANCj4gVGhpcyBpc24ndCBtZW50aW9uZWQgaW4gdGhlIGRlc2NyaXB0aW9uIHRleHQu
DQo+IA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiANCj4gVGhh
bmtzLA0KPiANCj4gSm9uYXRoYW4NCg==

