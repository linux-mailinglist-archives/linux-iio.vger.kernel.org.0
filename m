Return-Path: <linux-iio+bounces-14916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D9A25912
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 13:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC2F166EAD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEEA20459E;
	Mon,  3 Feb 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="enL4oYds"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BDD2040A6;
	Mon,  3 Feb 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584902; cv=fail; b=A3cKrMGyZOJ99JubDMBh/H2AI67JnaA3YsDqKzP0ce0W9Qyv6QjzfZtCFveK5WNME8gTt4k8/S5KI0Cz6LilG6mBQr8MR4hop6WeVQbE8tdQHoUja3IvBSa/ELX1WTnbkKuL+KLzrIZADZy7bfazVL1ETBUKZC5GOmWe+CobGsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584902; c=relaxed/simple;
	bh=sxplNnVeE4KcwODNwL9JDwp891kCoLUbVwVxhtp3WBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G4hDSNmYpQGY730r9avCpG/nWdQpzz/MY6h1LMI37Y1LMdoKrXhoU4VF6b0Cb7IyWDNrgkXkWcx8t6dwkdg0WJ9wT+r7saieb0fG9bD0Ke+Ef3Vyv0PVaGVu6oNFwGZhUjxdHnDAcJGtu6wRgE6w03Sr1vXKOexW5L8Udek3uCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=enL4oYds; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513BN4tC021438;
	Mon, 3 Feb 2025 07:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=n8Asl
	BGmyWKeeQXsYJjCSsBUvZoyxCjfRVIYFuTu8Bo=; b=enL4oYdsALrKBV3UYT31C
	zIpGVkh5SpHAM1PRK8IrLf0VRFTrmNLZm4Tih7FHHg69wXXIQrloSeCUvx6OmvNi
	r0ANBDR6EiNkA9vkHnnypMMF/jXjazFDHHuSXq3VwMwcfPr50SghGHCqaUB6abnA
	xYVyqB46gEIWx9fHsGwpZ+pgVLtOsCQoNRQyXeKDPQFc8l5wuXQVmi6XGfnJIwCi
	ul1vmr/PvZngsfHHLFu4DNOAV1ieLJ5dUQ9ubBYlpgDOXLNG17vssst71pvU0GA6
	X1NcqniJ0J5hq6hZO1wovjAufWtbS1XFcQVja07AjEV5hrEcN1qFKZibpV845i6p
	w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44jvvmr4eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 07:14:39 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cj3cOkfAOClWfAlcE2gPbkvEC8DdxcE3Bg6MC96S/ll+GRLbcqtAoTXL+ynQFhduiPGEjlp1rrnuYX4KM3z8D8nC1OXTwyQ8VyG7KPRAWjsfXP754SycxTSnqVqoLbT9EFrdUR+WIdnF/R6Wc/hNDenh2LC7/sLkN9InRnFeIjL8bDHQLeoUPjNQvh8OaO9JQLV7dFSUW6HGa/Zi9Mbf9gvG/LHe4ylFEFkrv+mQC/5i58h4CVKAg8vBf7AXvfqYcgnISI30ImTm+Y/kL27NRfGpTgqP05tVpUyPitw0Stl38rXr1N5+WDj6nO6OwRV1u9b92TAQJGCnc36Kj6MDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8AslBGmyWKeeQXsYJjCSsBUvZoyxCjfRVIYFuTu8Bo=;
 b=LBXmNe6iP9aXjAe+Bz+4m0ANvCOwTTjjWphO2ArVO82f/T2CiKmEI0gUokW/v4iebOsQPmdUx3fl5AZN6cqbTRCaD5iRUE19YnvlnT34ifdGMBeUkxc0i7fJIiQD/sgimNnIUfJgRAKF9Iut6YoKYDhl+M4j37CR20z7ioe31PBKYLDzfSt6n6i/aSIfLTXDDlxc/HBDFmerv0ZSN+BYIfqWkOydiSRn4AlUKdvs2KxHNTU6Z7QbwgpBpqA1HTavKPgM2aUThdLLU5dzLbt5hXjkq4/p4BIsABJRY5i00Aluy58ChK1Wd9Btx6jgbfiexA+aR6wkm6XZef54QXX4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DS7PR03MB8093.namprd03.prod.outlook.com (2603:10b6:8:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 12:14:37 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%3]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 12:14:37 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Sam Winchenbach
	<swinchenbach@arka.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de"
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v2] iio: filter: admv8818: Force initialization of SDO
Thread-Topic: [PATCH v2] iio: filter: admv8818: Force initialization of SDO
Thread-Index: AdtvOQEi9bXXscljTwutNm1Yb3fHiAFYfpSAAGZf/5A=
Date: Mon, 3 Feb 2025 12:14:37 +0000
Message-ID:
 <CY4PR03MB3399C1B7511FD67DAB40CEAA9BF52@CY4PR03MB3399.namprd03.prod.outlook.com>
References:
 <SA1P110MB106911327A8819E9AF67E676BCE2A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
 <20250201111813.6b8cbf5b@jic23-huawei>
In-Reply-To: <20250201111813.6b8cbf5b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy02ZTE4YThmNi1lMjI4LTExZWYtYjAyMy1kNDgx?=
 =?us-ascii?Q?ZDc1MDZkZGVcYW1lLXRlc3RcNmUxOGE4ZjgtZTIyOC0xMWVmLWIwMjMtZDQ4?=
 =?us-ascii?Q?MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIyODc5IiB0PSIxMzM4MzA1ODQ3NTU3?=
 =?us-ascii?Q?OTk2MzkiIGg9IkJoS1NhRW8wL2JyemprZEtvcDlTRHpMVHU4VT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Qlh4bk13TlhiYkFUVXphKzE4SUc4N05UTnI3WHdnYnpzREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBVEFZNU53QUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DS7PR03MB8093:EE_
x-ms-office365-filtering-correlation-id: 08370005-9708-4067-747a-08dd444c5410
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w/OzR3+7mKkleYZddCMEMb0Wp9gMaLWJCVkKXBxN5HHets1nFBMydKWbWb39?=
 =?us-ascii?Q?Jb+jdUziOlnRT4Ye6R/O4RSBFaM1UPm5i6DF62tcBB2Y/WooWb7wk1OOPcGk?=
 =?us-ascii?Q?emw24k9YOHsd7pWVwPwGz9YIEfJhe/Q+L74ruCleQxbyfWuOgA7PFsdcg5SW?=
 =?us-ascii?Q?45Q/WdSG5qa7SVsUIZZcReyYZ09JeeQwEX2c9SoLgL1H4zK21LNVvjlR6HPP?=
 =?us-ascii?Q?Ft00j1HpIoLd59P7QSZVehLj7mVGdaGMAoCKG6BaJ40DEtM/Cm/OTKzKpuyx?=
 =?us-ascii?Q?cuqm1oo6obsFZYKVHdUNDIKdcBK4Qh3+fb7okofOO1BcSaQ3+PrHMPXjSJ4H?=
 =?us-ascii?Q?TOhBCJRmE+QTCdy1F6wIKXC04OoyeaEYA1LftFxNvXzpxTRmhnKbro1gFBU4?=
 =?us-ascii?Q?HoPNFaRmLqnacrdC/Oshq4kU90n41zPSPfzuwrnF5TOD+dlUF6W+NkWc/zBU?=
 =?us-ascii?Q?B1AuHOm4ZIi9KfRSxxt8TlAWQ3AGsT4gx1oAKmKyZnipDoqclE0X+ZNl2O/F?=
 =?us-ascii?Q?T0cnHmMVpEKZXu0lpiB6O4Z05E9vhmLSBpe7Xo9bynuh6b4J6cI9i78zE6wt?=
 =?us-ascii?Q?Bxe9g0tVoLn6HpLqPjHAj3jphVuRbRAC3pj7Vmdi5lvAeATkLCEokddIU181?=
 =?us-ascii?Q?gjxfS4MShQawaFfXRezbaLztO4W8ylUb87fdVeebkTtIKYuKFXZeHaK++AM1?=
 =?us-ascii?Q?yuS6ebMN5C1qUSn/8ZODRZ9PQnN39wCFr4QNltGsKwBqzMFfVY2/UdjbLOy9?=
 =?us-ascii?Q?j/QPV6SzhyzoEBY6qeXH0Ineih5iT7bnPFBRsXGrZF5gU8kwprquuhirt5A0?=
 =?us-ascii?Q?BCxaxIjLgcUjZ18/OGHy5I1abNnjwREtyt/CSpT4goAc42trMpALOlbSOayT?=
 =?us-ascii?Q?hEawA/JSGoycjf/Wjhp/Ttck7nN3mBzUE2stO3DEMBfHNScnSG1FO7dldqkv?=
 =?us-ascii?Q?8aU4Rce8mSMMu8pvpAdyH3umV3yulBZ/oZ+4GjXQ/O0A0L/fcD/fn2TJNfei?=
 =?us-ascii?Q?ZhjCJXVbBtFJdREpZ5TFL4zCNSXXxVvwumangE4QApG4fYxC4eLp3l3llYsh?=
 =?us-ascii?Q?08rHNyq7vpn9obmfYd1qYbZ/3Ib3fH3uv4fJD67Y78StCplXj/qdJsRwV9gq?=
 =?us-ascii?Q?lXM/fSSSU346y8L0Qhaa13V2By3/VyIISX984COwWObOjRdsS/hLMLIa7UVi?=
 =?us-ascii?Q?bhVApVoYwFLlZU9iugHWX1hmHmS01lVy2AnzEV3gcjwsxPXRrTvZ1L7pjP9j?=
 =?us-ascii?Q?0Ma0Iii0CDH1wyyIQkK1VjKQtXIphY9EZjHXgTmxHXr6K1rfSNtMW2lVUE3m?=
 =?us-ascii?Q?7f2GlbPAzQ9P1knFF8Itek/fTtbCyjaA61qJVfjtW/ud8PO/uHH//IipocZ7?=
 =?us-ascii?Q?7fAO7q2qORnMmUC3RnQ+W8V90p2IXcykyIDPQK5nXhlBnJUKIWbPJGa80Q6V?=
 =?us-ascii?Q?sNs1tbNOxoEIO74Ns1tyYRAWy5orFKn/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KhCGhRxemWALkPJ2NcH0Fvgr/NceTOSAfHn86sgmy4E5jyDb22YN0DAeTOvZ?=
 =?us-ascii?Q?REDXUHc5/600C6f5/g67qIwzRAWnMurUNLL5kKs1v/sOhsfkXnUuhFJGqZqe?=
 =?us-ascii?Q?eGEIIORDexaS+zkdvppLu7EKHq7BruFGWArDSenr9hrA6K6SYS+hdF51Pl5c?=
 =?us-ascii?Q?6VcYcQCdBhFOpiTzNTdsTZQGZyJEqni0OoOVt5ZBRQuIihWx910hBT18JiRU?=
 =?us-ascii?Q?2a1zsH/JQPlY0CuwA/t0JGHvCGsJUcjE5HDJwGsbq/IYhQLSLpRD4VGMfmxO?=
 =?us-ascii?Q?bWEuk01NXd/h1YOr7jzVvf7yjEcf33CpvTmr2ht/39QDcUmtTI3Fw6ajKmNQ?=
 =?us-ascii?Q?/LWSvtM34QoRGPsqCRNRUh6UN7b87Ud40CxIEVeubfHwRmCMMRdUqmpoWhvj?=
 =?us-ascii?Q?9A9k3oknqLPh9kt3hUW2qiNBDoAJmqJcx609IYfc5CbLnighp11mMVRpGQJs?=
 =?us-ascii?Q?kqJO39MEalhnd0RjACOOa3FQuzVymsPIzgEgDY9s9AIapJD++EpWNshFiODd?=
 =?us-ascii?Q?TXJkfj/YW8higwGoIuINBlHl3WCxm6zs74Tswu96Aizkz5rqaUtgS7wSlVxK?=
 =?us-ascii?Q?ccsWgNWWLSTWeQ+9lMBJhGNRQujWStxVRUPGQ+EZ7qdNJzdghVWAxV9pjPNB?=
 =?us-ascii?Q?c/7SqCR9B9DnbaYtb35vhb3CdNe1LMYHliPXPZMb/pNMzo7VNHgkMG3UoCPL?=
 =?us-ascii?Q?Lsgq+NrEyf0cQG/SLlfOjxVVija3PtK2KpRdbIFU9qPtsWwoC1QHfASnbZ+Q?=
 =?us-ascii?Q?Tb92nKU8uT2y4/922QMbswcfOGLI0GIDPFWSDqZAT7NI6/Y22uyJ7e5NK7KJ?=
 =?us-ascii?Q?QSdP7TS4Kz9fMXQrxCm2eYX68YErnbK/gvQz6LtFtQvwNKs/yUuoQYIn1boE?=
 =?us-ascii?Q?kRmgk9nnrafGrIvnK/3E8Lltt16IB7TNX0WSPhlNpQGuJoSTzEDBkvMc+CWZ?=
 =?us-ascii?Q?DWytB5rVl4dlRPMYHYXy6bgOO0MsLO1RsEcVai+jSIMmScFM6HEUk4hEEV9p?=
 =?us-ascii?Q?yDWtZXvFp/nIssAFy1nrjFxhKeYNWAsiUE+1sIOp86xjJ6CheOwCxGF1M3pY?=
 =?us-ascii?Q?5ZY8OgOZ7I3bw58uZrugcVM8AaG6TSlLI0BbPk9UcI+j4gfp2zsADiwmY+gq?=
 =?us-ascii?Q?K93jzGBd9J9jgpOm3Gj/aJDibPqXVaH806Lg8Km+UpgX9VT46/mg5AYzeBc0?=
 =?us-ascii?Q?iSVA/YfdiJdJjUEXgYxCCJ51ostOylN8xFVWA2QRUWlt6UJ00q38L14zVwxt?=
 =?us-ascii?Q?eYDQ05bDJokbOqOSLmxHYCErVLPl8fvqod1RIhQf5cIQ9Wms3wLkDjF4uwBt?=
 =?us-ascii?Q?dW+jNvyUW5Vn/hNSWz7y8o3xGfDsvfdz7AauAeaZMhLoFS4hFAaYJgxhlA01?=
 =?us-ascii?Q?uULSJiXVrRcDTjKcwv0Qkhu2A7AXRXG86b4yTwWMjfesHqKkCG7/AQLj0YPh?=
 =?us-ascii?Q?wjPkoaaTlwykLLjdfNuuSqhxQ0HIJexnG5fQZl/w/AoFQKPgMn9UGXFCWqUb?=
 =?us-ascii?Q?vw723Gyr7DaR8N8c1iguIliq3I0xn3Fu1q7esl7/SbILEf+yUYjOukGBSrpn?=
 =?us-ascii?Q?9L/osi189fsgmuWZVF11NCqAsZx8KJI1bHpVuZFBsCmAxlqnD4n7YqS72Z6G?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08370005-9708-4067-747a-08dd444c5410
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 12:14:37.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ndVQx1uh+vLer5/W8nLzGqrWDgJfKQpSr7R+p6a+M6ciQ3ar3xcPIKb54wLJgcLW+SAW80owkb0mg3G1vvotHiFcvB9mgKIsGG0LZdx0Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8093
X-Proofpoint-GUID: iF4T3ietZobnNzMsSYqCYgz9qoOIBzFV
X-Proofpoint-ORIG-GUID: iF4T3ietZobnNzMsSYqCYgz9qoOIBzFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030091

> On Sat, 25 Jan 2025 14:54:44 +0000
> Sam Winchenbach <swinchenbach@arka.org> wrote:
>=20
> > When a weak pull-up is present on the SDO line, regmap_update_bits fail=
s
> > to write both the SOFTRESET and SDOACTIVE bits because it incorrectly
> > reads them as already set.
>=20
> I can see this as a valid micro optimization but I'm struggling a bit
> on how you can use the device if the pull up is weak enough that
> you can't read data back from it. Does the reset in some way
> solve that?
>=20
> Having asked for the fixes tag, I'm less sure on whether this is a fix.
>=20
> Antoniu, I'd also like your input on this one!
>=20
Indeed, this can be considered as a "bug". I had a look over the datasheet =
and the SDO line is disabled by default.

So the `update_bits` doesn't quite make sense in this scenario.

> >
> > Since the soft reset disables the SDO line, performing a
> > read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO line
> > doesn't make sense. This change directly writes to the register instead
> > of using regmap_update_bits.
> >
> > Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> >
>=20
> No blank line here.  Fixes is part of the tags block that various scripts
> scan.
>=20
> > Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> > ---
> >  drivers/iio/filter/admv8818.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv881=
8.c
> > index 195e58bc4..9cd1eee84 100644
> > --- a/drivers/iio/filter/admv8818.c
> > +++ b/drivers/iio/filter/admv8818.c
> > @@ -577,21 +577,15 @@ static int admv8818_init(struct admv8818_state
> *st)
> >  	struct spi_device *spi =3D st->spi;
> >  	unsigned int chip_id;
> >
> > -	ret =3D regmap_update_bits(st->regmap,
> ADMV8818_REG_SPI_CONFIG_A,
> > -				 ADMV8818_SOFTRESET_N_MSK |
> > -				 ADMV8818_SOFTRESET_MSK,
> > -
> FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
> > -				 FIELD_PREP(ADMV8818_SOFTRESET_MSK,
> 1));
> > +	ret =3D regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > +			   ADMV8818_SOFTRESET_N_MSK |
> ADMV8818_SOFTRESET_MSK);
> >  	if (ret) {
> >  		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
> >  		return ret;
> >  	}
> >
> > -	ret =3D regmap_update_bits(st->regmap,
> ADMV8818_REG_SPI_CONFIG_A,
> > -				 ADMV8818_SDOACTIVE_N_MSK |
> > -				 ADMV8818_SDOACTIVE_MSK,
> > -
> FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
> > -				 FIELD_PREP(ADMV8818_SDOACTIVE_MSK,
> 1));
> > +	ret =3D regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > +			   ADMV8818_SDOACTIVE_N_MSK |
> ADMV8818_SDOACTIVE_MSK);
> >  	if (ret) {
> >  		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
> >  		return ret;


