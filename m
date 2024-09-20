Return-Path: <linux-iio+bounces-9665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3503497D618
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 15:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E998D285A93
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82242176FD2;
	Fri, 20 Sep 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YqQMD1fg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70C14D44F;
	Fri, 20 Sep 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838740; cv=fail; b=h5deHVbWP23JjH8doZsWc+1biCDoHFq1WrLVzxacGbL+Nkq4o6iN88B01FyUHCKkMS2LACaVJXNdUctUC2jy0ufKx/+BhSTzPcQkW6bPyRU+sAbt9cOCA3Z8xgQreS/DTl+ULXQhgYss2JGVeQk2MLkabKdPxwtPkdQfrqeXA8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838740; c=relaxed/simple;
	bh=AqVR17eW7edG+r3xUXKZQcjWJ4Z948u81UiFPQ7oWmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h2CZ7U57umC+xVu1CZxRrdmvlnW/62wa7KnAuVocmrY33xY4pplB2/FwgoVx8Y12EgNVAITnU0upBbsMYYXVv07iqOXd6izizeHdh6TqoiVSO4M9BUVjbTLVHhzOSnOsesNeFJlJCBd1OuAKqBdmpzFaalmyK6fTRdZsizMr6HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YqQMD1fg; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KBp4cs007608;
	Fri, 20 Sep 2024 09:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NvKWk
	awbvOj02e/voORJPkxG7IgASyhbblAEWY30myQ=; b=YqQMD1fgLZ5SGder0vpZm
	dn3PJLf2ihUuGiJPdkP4cEXfrFYKlwEtlbUHF+iGVhZG7yLyGilsjwPCOe/N0SxZ
	k1TfVxLPU4rFI9TYLune6/3LifS1+xoU856SUx0aBy/q8TAW33Ph7PcWane7SSep
	w9Vb7cn+odyNfmuS2mZ3K4Vdv3xR/ylZ2Sdi5aHLMyhQCosrHL6ht/KWgEP8bbl+
	raBY+fJ9ddUfjMS/1xfYyEEjKQCviY8rK5hMhi96u11XsP9HdwRJzmASWl74Eq83
	OSexmpDufdBbEvO3JwrUx2jlWa8FCSJcvCALacbuyx8NFQcKD6N4wM7ZBxcG/PIF
	g==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41rfuyxw47-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 09:24:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkNq97wFQW/rrW/l4ZoaWXh90rew1WGXRm+JZLFQihubNEAr1vtlnK9MeK9fYu2fShnzdus26Or9W/Ta5/T7A/26wUKLw3nR6zT1FhF6sh1N4YpQH3W6GcdL1/cSD2ZciRK/MaepVkKE+0wZId/XzK/8bqR+lXYEjdzbzAoku5bVjR8r2+sd7ldAV8MovYi0dXWFnaGVqbS1atsn0c9wk0OtzCv7am60lU3lRqSnhklPhucGRBmNsuHCTIFKy/mTwQoDM7vNVikbTe9++yPQ47+eDIY0ATgNy7ZGx9JgkYnlUvEAtA7m1Py8Dfcs5wEXTgerTnUtVRIJi9ugurnSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvKWkawbvOj02e/voORJPkxG7IgASyhbblAEWY30myQ=;
 b=g/0ziFnImluLKG8qUoTJQAdvJEMB8cVmlCBB7RMWMe8mkG9gOe0mQrMEjDWW4dTFy/qdMdJvdoxePsexV9HNNh2+qYvzz4OxXdesV8VsW3kNkH5WAo7ir2zZ7LyUWZQOaaXItlZe89Vju/GDmnEsqR/dYXNUxIlp1Fk8tePAh4cgt/uqr5Lsqgse0UUrmkBqspJzKnpv6BYpQpfIOGfVsc/omfaOYCentNrZdSizF+0cwAJRPumboZMquuga60IO80JOP+Bc0GzREH9Z05Yw/XCrck+ArKGp2LJOgLLrzh5mJOAO/TyDYZQ4GkWwMhkZQA/qq0SggdqllCRTTs310g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB4320.namprd03.prod.outlook.com (2603:10b6:805:fd::16)
 by PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 13:24:52 +0000
Received: from SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f]) by SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:24:52 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Tanislav, Cosmin"
	<Cosmin.Tanislav@analog.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Ivan Mikhaylov
	<fr0st61te@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Thread-Topic: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Thread-Index: AQHbBQ9UZ8Eg5c7ZH02X3bsabDe+u7JXhtkAgAkuSPA=
Date: Fri, 20 Sep 2024 13:24:52 +0000
Message-ID:
 <SN6PR03MB4320E03B052A867DE73196CBF36C2@SN6PR03MB4320.namprd03.prod.outlook.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
	<20240912121609.13438-4-ramona.nechita@analog.com>
 <20240914180648.592cd69e@jic23-huawei>
In-Reply-To: <20240914180648.592cd69e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHJu?=
 =?us-ascii?Q?ZWNoaXRhXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVl?=
 =?us-ascii?Q?ZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjRhYTgyMjktNzc1My0xMWVmLWJi?=
 =?us-ascii?Q?NDctM2NlOWY3NDc1YjhlXGFtZS10ZXN0XGI0YWE4MjJiLTc3NTMtMTFlZi1i?=
 =?us-ascii?Q?YjQ3LTNjZTlmNzQ3NWI4ZWJvZHkudHh0IiBzej0iMjg4MiIgdD0iMTMzNzEz?=
 =?us-ascii?Q?MTIyODg2MTkzNjY4IiBoPSJncEpFVGpVVjVnaFpndUNlY3N2UUEwZDJCY2s9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFEZ0RBQUFFa25CM1lBdmJBVG1HbDFtWlVvOGVPWWFYV1psU2p4NERBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFTZ0lBQU80QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQTNMaFNmZ0FBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dC?=
 =?us-ascii?Q?bEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tB?=
 =?us-ascii?Q?WlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJm?=
 =?us-ascii?Q?QUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBTzRB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQXpnQUFB?=
 =?us-ascii?Q?QU1BQUFCT0FBQUFBQUFBQUdFQVpBQnBBRjhB?=
x-dg-refone:
 Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4320:EE_|PH7PR03MB7064:EE_
x-ms-office365-filtering-correlation-id: b0df1f6c-11a7-44c7-83d0-08dcd9779bff
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GurzRRsgisCB3XzPP3iI1BOV7WWG+Ja5HISy+3rLTL7I/m3+lm6rQZtYYsVD?=
 =?us-ascii?Q?D85Fon7JnFTOisso68a92ZkbNhrnV5Y+e3/9DYwHery96InyO3hBXlT7Bprp?=
 =?us-ascii?Q?iF1Ki38t9VCZkYnZq6qoE7GO4eR4cNrA14OG1LHLV4VTuxGE2oBixN/J5Pen?=
 =?us-ascii?Q?cua3+RmsLEGer6dK9NkPBg3Z58U2zh7IIVX5edUe/Jxb0qy1KQXFggJaqzY8?=
 =?us-ascii?Q?Nx+dFRJ6PkBz8gbA33T4ORe6OuYDpJjfuZfCXV/ynaFJxzleq5ZgCdUUG7uY?=
 =?us-ascii?Q?wNq99O6/rbI2ZPwVF9f99JekZKFeiSyksisUNUweg5i23yJilrV3I6Yg5oCl?=
 =?us-ascii?Q?wjZFTtq+INcKkOiyDA/b+SXnNYzh6P6RS4pn4gGWIlbXLGzn8RcwfwvljCTn?=
 =?us-ascii?Q?BCwRpN5byXL4/1hA5QI/1AL7nHlSZLsN1J4kjFs9/sPXZpsepLeUjhUgEDwd?=
 =?us-ascii?Q?QG4v5KZNYE2ZyGW43YlF58h646MCvjr5YlOplYWLj+zOODHjVKNmdBxL/eFs?=
 =?us-ascii?Q?j3KpMkWVthuk8h6AScmT8ekg2X+nkoUqaXttSh8XptuG/I/zd4q2lC4xzcXc?=
 =?us-ascii?Q?Gf/bSCxfhSt7wnTonJrO+s7i7seNl7+30X5MiMQXWKWdmj6ibPmG7PT3avzq?=
 =?us-ascii?Q?RhbXKIPgALdd4zr7iRakiIg51Dg/A2YEpUcfsuJn/nIrpjkwr1oEEhcMHoQ8?=
 =?us-ascii?Q?p1vG2yMxvnQjL4YNrCqj3ee6OaVA7HD4qL8kOyIcOHkQ9D6MdYFAWtVafhX6?=
 =?us-ascii?Q?b3NOgUa3iW99ENbkUPrLPui1cmsr3nyCQSse+GmTh2AhgVdA2X8zq1Nt4Umh?=
 =?us-ascii?Q?FuZJVznLV/yxyLt1aieLVLR3dGqIxdAe3G3wGHXPl8s1Sme2NCZUVCVKWxbo?=
 =?us-ascii?Q?7zA2mGmNZZRkFCB0VPCY5yH+SLAV2cxkGnf0NjWa+oUmdBNkqRbgjL0zgvie?=
 =?us-ascii?Q?qczLU0WNvaTb2Jjf8AhHkMrIgsx8t5SdTmYen0xb10NIzMs/2CQe13y33GmE?=
 =?us-ascii?Q?X3s62Onua7V+idKWH7Cpkl/+8T6VRAV+qHo4a2dy9h+SBmc89qtLUxamo/Sp?=
 =?us-ascii?Q?LdOFgo153BX7LezVHT6k8bVAR6V1kz2O7KLw8jeB/iNhv99TTCO5w7ImZnYk?=
 =?us-ascii?Q?XVmQAAhqc1PJ9UDpZUSoGHz9M6oXZVl0GQREh/EWg1Ox6Ljyl9o2s01zlUVL?=
 =?us-ascii?Q?cj0wnwNNGt42LOcrBpB4BBjuXm0dKnsGAD1IhbVAS5AJz65cjee7ydO48VFn?=
 =?us-ascii?Q?0LTMYY3CqVEzRRrSsZEPrht9N8g7EYmHFo8IoY+4idAGLTKZtGzmX8Sl9978?=
 =?us-ascii?Q?fUQkHqqbXw1sUH78OGPt8ehm6Qmsm+QvXUVt0/pEJnAyQg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB4320.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?69cs0fQ9X0a3eXTXoPsafNzDpxd0HikPAmVwpJkLjY9AnNfZ+sPZFz7Mttz6?=
 =?us-ascii?Q?CqaBw6JWkEnZ7AA71jHaG5OHDSYDGwiAxdGrhb18rSuh5wH34PTfh1N6tQA/?=
 =?us-ascii?Q?DCMTT38qJdijn4KY85oNYeXcM4YPDEYK991vZvrPjUAqf4O/mMZFhnP/21ta?=
 =?us-ascii?Q?XMHCGf0vmY/7V3uxVQMVEDnJ4j0K/bUXsc8uXa52gsrjmw3d6qdvSTDNFudq?=
 =?us-ascii?Q?3X/u2JrWv/u1yU0yo/5/03xErbCz0dvw7HWRWC8otvQD3K2XuqqFdz8x3NU9?=
 =?us-ascii?Q?0ndPmVOlb3pmqjPo2855lq6rN0kCNGoVJx6aTpDs77MydpQoVxcXQex2DJbP?=
 =?us-ascii?Q?0O3BK4kCn9wuVJ0VsdLfTw62hU5PqcMeSg2SKgKvP0gcxA9dMrakfXHDfLQU?=
 =?us-ascii?Q?XR+L/feyrVH9f19+Lpxa98JdmfvNJcuPipq7PuVRYV6ZoX+6eZ7SgBYLr3a4?=
 =?us-ascii?Q?yZSd193lPA2LcvvU6HlSc8yxKBS3FL8ZpgKsF5H8VOrYmr7XiCCIPSf6aPzL?=
 =?us-ascii?Q?0+uE+FH1sOSTTc0h42erVaF4trkK41LmT45qh+6Mcyk4hg3nBzCgxYbF/LWy?=
 =?us-ascii?Q?UiwhPlMF/aVNNQCWJ9g2ISYck/TdqjPsGo/5McUqVk4XpznBdVbrUNWcB7BW?=
 =?us-ascii?Q?uF96XvMjqKSds9DbnN7IdJx2Y46HCqDBOQAntXjnuKkFIBd+s7dGYWaNH9PI?=
 =?us-ascii?Q?TRZqUvFOA2brdLZwoe/MQrmA81NcMwdh+RTSPYD6bvIdFrifx4oPUdPOCIuL?=
 =?us-ascii?Q?nAiHi1K/SxPlkHKib4irjKkupLI5voH8SLeVXY6ov9BcxO/HcBfRZbSNSbj3?=
 =?us-ascii?Q?saHGF58Z8+gHVLGpt/ob2G5NRW/BPZhTJ83mpT3OQQ0GJPgCDm8c+YlDKtJL?=
 =?us-ascii?Q?gQEnwiJBpuNyT3HKAFV/U5FcDeJdhsgUh7KWC0k9GWXLobe/T7J4k8DJqkfE?=
 =?us-ascii?Q?GH356KOluQ6tWDD/4z4ZaaUS1Uz1aKQyS8D0h4SHC2c2n5vyBq4EyPgkyi0G?=
 =?us-ascii?Q?jL3tpX1rRhlncpIrVqX4bRo5TP052hm30GxGLdjRj4UgcPFNeVmopx1vQnRW?=
 =?us-ascii?Q?XIqYOg7clGZix4diJ3ek1tgvIHqr/fX/l7WLVssiuTYlVBlFRAyhG9FUssaB?=
 =?us-ascii?Q?OA1N0yfhZZV3DJe4+bUPhAtBDWEbnEa2BEopAAkiq+jszYYRcVICCbOsEaTy?=
 =?us-ascii?Q?j0e9SUJmuc+ZjwDBW8syT9qYLWBeR9w24w8NdYqCo/mdyiPE5gST3w0ORXxS?=
 =?us-ascii?Q?CuRYOIXxNFkLim1ogKKKYul4QuKPQukIODaC3L54+8VsI584KngEDaq1MjHn?=
 =?us-ascii?Q?UruFZM3XOgWV2SfGuofN/3PVoYC7lN/WXoWrd6K4A6JSdmHy4M7AaCtwHFms?=
 =?us-ascii?Q?UQRqHEwCYioRy8PPBGg+7AlUPdcnbd5wXoCwRueGOEzPmPS111x462cMI6x6?=
 =?us-ascii?Q?5hOg7EZ2PTSt6n/xij5MVsgeVzrI3xskmZLCx35gQgTGX0xiq8J9l2q1EeUk?=
 =?us-ascii?Q?Ihqd9hA0rktHzthYnXqznNemAnktft2GxNKzgqmjxXip+VPLIE1gqrcZeSkE?=
 =?us-ascii?Q?q7O9G9BsqUB4WD3cxRWv1/o6y9MQSUih2/xNxkQQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0df1f6c-11a7-44c7-83d0-08dcd9779bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 13:24:52.1061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wL2BnbO9wUVU5QKccZm3uJxX5UtNiqNB5ATpIEIZqRW+FuM3Ynf/j1sIdlZGtDkU51tzdopdTtUD3WlS1OZuMS6nXR5Whgk2azgPiwIlwKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7064
X-Proofpoint-GUID: gOxunQe3_w34stH3NJD0zE5nvVfryQt2
X-Proofpoint-ORIG-GUID: gOxunQe3_w34stH3NJD0zE5nvVfryQt2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxlogscore=991 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200097

Hello all,

Just a minor question
...
>
>> +
>> +static irqreturn_t ad7779_trigger_handler(int irq, void *p) {
>> +	struct iio_poll_func *pf =3D p;
>> +	struct iio_dev *indio_dev =3D pf->indio_dev;
>> +	struct ad7779_state *st =3D iio_priv(indio_dev);
>> +	int ret;
>> +	int bit;
>> +	int k =3D 0;
>> +	/*
>> +	 * Each channel shifts out HEADER + 24 bits of data therefore 8 * u32
>> +	 * for the data and 64 bits for the timestamp
>> +	 */
>> +	u32 tmp[10];
>> +
>> +	struct spi_transfer sd_readback_tr[] =3D {
>> +		{
>> +			.rx_buf =3D st->spidata_rx,
>> +			.tx_buf =3D st->spidata_tx,
>> +			.len =3D AD7779_NUM_CHANNELS * AD7779_CHAN_DATA_SIZE,
>> +		}
>> +	};
>> +
>> +	if (!iio_buffer_enabled(indio_dev))
>> +		goto exit_handler;
>
>If buffers aren't enabled, the push to buffers won't do anything. So this =
race shouldn't matter.  If it does, what happens?
>I'm curious because I'd expect any races that cause trouble in this case t=
o be pretty universal across drivers.

I added that condition rather because the DRDY pulse will keep on being gen=
erated even when the buffers are not active,
and it would be better to exit the function sooner. I tested it and it does=
 not break to remove the condition, I just
thought it made more sense like this. Should I delete it?

>....

Best regards,
Ramona Nechita



