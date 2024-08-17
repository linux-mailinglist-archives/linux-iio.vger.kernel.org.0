Return-Path: <linux-iio+bounces-8526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A3C955764
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 13:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8B21C20FFA
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548351494DB;
	Sat, 17 Aug 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XABVzlZv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594E13E033;
	Sat, 17 Aug 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723893632; cv=fail; b=DwJ8QSsdTdOOuYa+q8YPmEq01OZia2CwFUVpQs1moSe5S3C6Yed+C8SobatyA9IM5S1GU87YDHeESHZHODYtUy7II0YHqin94+Xjd4KPRWPLbqKmDSbnRdH8VBJ7YLa0fxEaW6BJ4LVvhOD0Dniuct8vztK9pku+tV5dMTQPLqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723893632; c=relaxed/simple;
	bh=n7bNxU5YJYtinFjydHEXjawP6Lo5t6no20sYxxHhWvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=If7l0Ix9ok2rHV/c9VawhIUeQBDS9ELZiLZnNhsB7M8A2Hv8tKsiHxJuJTqvF75y5EnLDP+rG1Z06p4Bfqb6dtT179OGPdqrWq+HCVjiVv28uHo1YPuZngUdm48dcSfgc7qmPtTpx5oth/JaUd3XOCmU5g2Va47Q368vIrFuLE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XABVzlZv; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H8t01A004877;
	Sat, 17 Aug 2024 07:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=X1BnP
	3gxLXRiDYy6THQUuoOhIgE7uJEeixTyAAoak7k=; b=XABVzlZvrBflRvUv4BTim
	gQwjMixYDuQkNXUE/inP6RyJnnLIklEz6KAUBgQ0OmrIJEJBHBKZdeG+DuSLseWj
	XJcUPrS3o9cXBySVNuOWx6Pml5VLsiWRPadE7zxm1kVnQsQYZpTZ2yc/4IyXYaaN
	s9LQFYuKtA0ruHcNrD9RHjj4XXNE4cRIuNHUcMmUxMdreik8QPglfdoju84s0lbM
	erc5rYW4zHqzQZsTB0haQMIXXaNqF1a4yXy0ztIHWfRDQUcsCqP2BEjJ9vwLnYVM
	Z59Stu3tmsQHRWwkn1eGg8GWKxZ+4hTXLc27vNNcrCEIkaoPKpkwXkXcM6vfiZpn
	g==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 412rs2g7r6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Aug 2024 07:20:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4KqNtFSjq9YToxTGH0X0FfN/D9dbUaj6ZYJSFtXhLXvBjIsWwLn6/wJBGtFedFWsGnZJNQIY7XfqGBg0JG1HCu3cu31RCBEqrNDlNZxH+J45mRyEmowj9SWuWYZx9eaLDxkbB/7GBjCLYAOmPZXkMebPf7kyHItOjWfF9anDF1Cj9FdFENGN820EuFVKrb1aB9YrmqQZQT8rZ+ARZYloULqHe+uW4kVIn68Eg7nd54wtNj9JHBxYgSLvnP0UV2gZtT6tWc4pLhnoed/1EjDN1WGDzWusyTM+by0zmEdi4FD6qXPMfET4hsE2u0lz4FMGtdTCLgGXYiUM/ySp2LYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1BnP3gxLXRiDYy6THQUuoOhIgE7uJEeixTyAAoak7k=;
 b=yyk9icKkB8LE/TOCreFDNcSaEed7gYiJ5KhYEJzHIIHK4AtqNuEUqMPS8qai/jJtANs6e+pgNq5uQ6GJhTYxObprMNtdJF8FKkcAtWj/cLCneDL+g56blRwwaVS0W9W8GxJmy97ZXqyS/Ms0zZ+6ojow/4V8Ico5xodHNgGQs9lpz5v9I5WBMxy4dXLxC2RLN2ztG13acIgoy2XfRRglCuqD/GZNmv2Sj5OgekLEvhZSVaBOVS59yLvEHCVQ9iegTiUbC8Ne3NjPSrmrUHDsXONIha8Kfn2da1XaJ8+fWRoYTSBRpMapI5KgQTLplZMhmZK0aSKl6cgs/MKDzqE55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by BY5PR03MB5077.namprd03.prod.outlook.com (2603:10b6:a03:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Sat, 17 Aug
 2024 11:19:58 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%4]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 11:19:58 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        David
 Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: iio: dac: add docs for ad8460
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: dac: add docs for ad8460
Thread-Index: AQHa5Yy0o6d1lQ6IiEC71XeSdM9+JLIrYziQ
Date: Sat, 17 Aug 2024 11:19:58 +0000
Message-ID:
 <SJ0PR03MB6224DC1CDD88776698BAB33691822@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240730030509.57834-1-Mariel.Tinaco@analog.com>
	<20240730030509.57834-2-Mariel.Tinaco@analog.com>
 <20240803110545.61885486@jic23-huawei>
In-Reply-To: <20240803110545.61885486@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?iso-8859-1?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG?=
 =?iso-8859-1?Q?10aW5hY29cYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04?=
 =?iso-8859-1?Q?NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05ZmU4MDYwNC01YzhhLTExZW?=
 =?iso-8859-1?Q?YtOGMyYS03NDA0ZjE1MjNjZThcYW1lLXRlc3RcOWZlODA2MDYtNWM4YS0x?=
 =?iso-8859-1?Q?MWVmLThjMmEtNzQwNGYxNTIzY2U4Ym9keS50eHQiIHN6PSIzNzY2IiB0PS?=
 =?iso-8859-1?Q?IxMzM2ODM2NzE5NDYxNzUxMDkiIGg9IlpCb215Yy9zKzAzckpENnRjVEhl?=
 =?iso-8859-1?Q?SXFvQTE3cz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVT?=
 =?iso-8859-1?Q?FSU1JVRk5DZ1VBQURnREFBQ0ZJcDlpbC9EYUFhMjk4OVlHSWk2NnJiM3ox?=
 =?iso-8859-1?Q?Z1lpTHJvREFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQV?=
 =?iso-8859-1?Q?NnSUFBTzRBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBM0xoU2ZnQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOE?=
 =?iso-8859-1?Q?FjQUJ5QUc4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdC?=
 =?iso-8859-1?Q?dkFITUFhUUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQU?=
 =?iso-8859-1?Q?FBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFi?=
 =?iso-8859-1?Q?d0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFB?=
 =?iso-8859-1?Q?QVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUU?=
 =?iso-8859-1?Q?JqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFPNEFBQUFBQUFBQU?=
 =?iso-8859-1?Q?NBQUFBQUFBQUFBSUFBQUFBQUFBQUFnQUFBQUFBQUFBemdBQUFBTUFBQUJP?=
 =?iso-8859-1?Q?QUFBQUFBQUFBR0VBWkFCcEFGOEFj?=
x-dg-rorf: true
x-dg-refone:
 d0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCbUFHRUFiQUJ6QUdVQVh3Qm1BRzhBY3dCcEFIUUFhUUIyQUdVQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFESUFBQUE9Ii8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|BY5PR03MB5077:EE_
x-ms-office365-filtering-correlation-id: 8681c48c-ef50-4168-10a2-08dcbeae876b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1vcqubGmeP9EhQzdAv9UiQBC6RWdi3A/4B/U/2X75LRHcJuHhBnmQKYz+s?=
 =?iso-8859-1?Q?yD/FfGrKYNLRhbIaGFG9lbccYoYy8mBGwC+ApTOVaat2+5Lbs6QbxG//Q+?=
 =?iso-8859-1?Q?tYt50pFos2ILmzVUbthzT1Tfgg3bzlailmXfTJtSGE7+tqYTp8B4/JRz7P?=
 =?iso-8859-1?Q?dW6fou7BOAAWQNw31przvjtl9sIjzZUujY9KyOl1GPlFDiZW8/GrtMYAtG?=
 =?iso-8859-1?Q?j9eZEPcqeqDNOWo/aTF5q9adO8kyhpWGC4CZtqpBT2FeOasc6B11Fo+aGy?=
 =?iso-8859-1?Q?1WyCy4fZc2i+jiGSOT3ZCMXZtCIgBPF0QmKN2IGcxjjLos3JeOtdlpgmMR?=
 =?iso-8859-1?Q?RF8HT5O7EA/ieLsVWmvxCCkwL3YxouuMb8g94HYoGYiRbN2/Sa8ubL/9MV?=
 =?iso-8859-1?Q?nChHtjhglP1tA7kFMoHmwtm/5Z+4H0HFRoQLY0AidiC73s8E7lcAvSAL0F?=
 =?iso-8859-1?Q?TqdsaSltzuvvoQxpYe2HlFZ7lWCrVpHGXTLGmKsa3hcjzK3MkW0gUfX7bx?=
 =?iso-8859-1?Q?TCGJ0og+1z5fuOKbC+4GPH0lWozztJIPkCO6OHnCKybh9B+xFk8M5/3/Lb?=
 =?iso-8859-1?Q?9Bvf9d48udtjqXruBSEZyjBXUnwHuJxGa6p2CacmMqwzuH5tqbaUSBIt8n?=
 =?iso-8859-1?Q?7RlML8XWLhE8JYOrRSwI6rUU3aQzcEZgwhxwD+W5XM8N4y30piWXvqpA6n?=
 =?iso-8859-1?Q?NPl+erLwDEO4Wzwfputyuq2pqXK2w5kduEFbe7z7wNl4oNNwQ0/Kr2Jhyp?=
 =?iso-8859-1?Q?ukpeHhFDDBVtUENOrfQkQHWGH4XJNLiQNypEwSc59cVDOTz6pOySXuoRcI?=
 =?iso-8859-1?Q?fFQ2kAHK4+Qq16Y/jfvSK74PrH/zqSO0MY7aqxtV7arrJZHms4W30VH/AU?=
 =?iso-8859-1?Q?+Rnwnwu4CssXFRGbwQe/PSDUjmpsgVU6+K6Jy6FilvAPJSue6qtZkGYNXy?=
 =?iso-8859-1?Q?PryGJu+Xo+I3mCFx9ubTKgE1BvSJczWuNkn4bLGqiZwxYyyizsxVY6cgUx?=
 =?iso-8859-1?Q?kQzceKOTU1LPlOK6yu1YhbRSZk4GTVGMjBMhiWxfMsnrJnHkNUpzg2pdNn?=
 =?iso-8859-1?Q?XO4UvAqWl/OGz400hYnZhJUJwUpXIQV3FhNDHAc9qHctEVuZJ7avYNZHJe?=
 =?iso-8859-1?Q?wTiBlkbEy1wZFhtQ8RxBTX8HxYM1Y/Oqwa1YasPf5Kx+qY+bOWALk63e+/?=
 =?iso-8859-1?Q?k2mFecJSwGCEp1JR9zTy9fthnyaGrK5Cr6TjfMn5j40ZO+MQjwX9ivEv8X?=
 =?iso-8859-1?Q?HoyU1N/c3QyrjvxlryI4ALPfj/yh7bceEeknTQPDgA76szXr8uxmIOxSOY?=
 =?iso-8859-1?Q?QvGrMf6IOwTtx4RNLAMqoIzk525Zp7Xk5sdKDo/emHEsJeXy06pBiBJdli?=
 =?iso-8859-1?Q?Y36Rd2ZCGaVX9LjWHNRA0lNVuSxsNFXF2XRPDMaDGEOHA9M/uh4UpdAlvM?=
 =?iso-8859-1?Q?yUNVFwXFTFLFWUMIQZytdC98qeKJ49H1YZh4gw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IM1B9E4kKVOBpVeAMfV+fwG5aWWwEhxI2bTlGHUlG5jGSpeMj7DN6gThcE?=
 =?iso-8859-1?Q?qfIfqPyoCrUn7lLz03i8+5/Rnnosd8HyTjKBHUcqcIzzfmmLUjCOfQe6vl?=
 =?iso-8859-1?Q?kO5S5wNjXARm+ugnaLg99sO4UNcG+aMlKzd4n0ppyhzF4cG6uXPTWtt6tE?=
 =?iso-8859-1?Q?oBv25JMEkAgRJDdjD8YbA9QCtpBkWu+0ptwMdMfoqd06ByUT83WIzUtKNs?=
 =?iso-8859-1?Q?XfyCDK8JVhqh4mHAtkxVUyhYBPPk0cf0/JmsINnGUPftYXzq3Ym6AOIAwT?=
 =?iso-8859-1?Q?CRIYv5Mz7pGIm3ayHv9KBqITyXlZRpkQ+aLEIQhdXU7QSIXqFbP+17WGQ6?=
 =?iso-8859-1?Q?HWabGFZeABJNPs0nxgpevzpW7cei6GH3+ya0xkOhyc4Z82F+FoMbaQMkZX?=
 =?iso-8859-1?Q?3CkGyFZgEmKShX7k3yCTMM8UYIC0121sRp/y/EhdcILv983FRfpisMiSJ3?=
 =?iso-8859-1?Q?pJvlJ1lb63RCFxW5mCgseIKmzKpF2obSvkM+D8nlddvlgof6LZjghWIjbD?=
 =?iso-8859-1?Q?joLGmoMKCBwJg+2Di3tLwocJTV4kxb4BmBFeWutMmj27Ejiq2Y401rWwLk?=
 =?iso-8859-1?Q?vowwxQHIhfrw3LPtSmYtvjCFvfVMvmveH0nhL2JIu3jtv/bdHUvXisNHfn?=
 =?iso-8859-1?Q?1P0ghgbC4ceSlQTNyRinuDDqA23kCTU4Lr5h1irIxMVoWvnNo+fv1XRbX0?=
 =?iso-8859-1?Q?cDD+shSXrnYrBJLlqtTNq2yDoKJ1eLSUJuIakBiSdxSK+oq9W5rDqIhtMR?=
 =?iso-8859-1?Q?1oQFj98YvfPh+EGkQnkX8vemvtHDaEoQhaTd+NqF1Nq8YGs/4So2jBY25o?=
 =?iso-8859-1?Q?eEqIaGreEA9HDqIU3bjDWq1qKT7fTIysA5C5/Ckd53KC2dNty3ctemfIq9?=
 =?iso-8859-1?Q?bj9d2iOMdNehJUbteOnrU3U3aCmGJt2wKWKFo+nnbrQZFiLvF1mTIfr5/d?=
 =?iso-8859-1?Q?CaibCFsbZr0zkRYy/A8+B8d81biPPpQA0gLqIpXUMK2KDfteVt4VBLMWqg?=
 =?iso-8859-1?Q?Mf60GKgN7batO0yrryI4IMshfS1d+R15j3jRB7TQfFbFaVf1Gy0dD+iVd2?=
 =?iso-8859-1?Q?VEDbl5LNhHtekRi7ymoletIoNvaw4fycijFmJRQy1pS1gvtru2XRXQxjw/?=
 =?iso-8859-1?Q?L+lrPPSgy8FY60dK5GXXexDlyUlrJaIlLfU6ihgiD6yrBipODA088jnzBB?=
 =?iso-8859-1?Q?HjzK8+EepwXnk4KedBmLHF/NwvrBj7zBSihddeDHMnlPC0TcSKZqPszv7L?=
 =?iso-8859-1?Q?VNXBwNCI5CIEiqVW0Awg5at0GxPa9+0nZBqSviuGTs3q1bDapbZKH7n9G+?=
 =?iso-8859-1?Q?K7Gfs/sBnES9eMNF7dAyc7xmFG4v/pOzLCWL7nW5GUsz3GVRWp4kAncZ3W?=
 =?iso-8859-1?Q?68uZrAJXOWx/DOScOa0GgV9GM7CboGsaPUt3KuKio+kyqlmkrlMdjug6OS?=
 =?iso-8859-1?Q?YBuz0O0NEbq0Jpp679FLExRjXNsK/UOc7wIUpRUq8L9bWSKsVge+QgOEEa?=
 =?iso-8859-1?Q?pUk5mRQETuRdlbKMdANbHG8/7YHqC7ZlOeCoAAwWdfts96V3OkyGLpXVFr?=
 =?iso-8859-1?Q?NRWDWSJULGc50ky0XmcPHMXdbDjNNKVrtwBG7/5aXBaomAEcJOOlGTFFuk?=
 =?iso-8859-1?Q?s3PUFRheW8ejAmna5bKEZTkOliHEkElbPq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6224.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8681c48c-ef50-4168-10a2-08dcbeae876b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2024 11:19:58.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8Un1FEi/mhajQ7lIiRR2Kx1jKbSia1mtZPJsWS+QtjlQbZhxkVXIDkIyaAeqGL9RyeS7HG9+1qH/TBPQKBIoYm+xldaQv/DMEX2Alzhm+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5077
X-Proofpoint-GUID: x8urjlhtbvuC1iGw2DsQTenQ1OSQXWGw
X-Proofpoint-ORIG-GUID: x8urjlhtbvuC1iGw2DsQTenQ1OSQXWGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_05,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408170080



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, August 3, 2024 6:06 PM
> To: Tinaco, Mariel <Mariel.Tinaco@analog.com>
> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Hennerich,
> Michael <Michael.Hennerich@analog.com>; Conor Dooley
> <conor+dt@kernel.org>; Marcelo Schmitt <marcelo.schmitt1@gmail.com>;
> Dimitri Fedrau <dima.fedrau@gmail.com>; David Lechner
> <dlechner@baylibre.com>; Nuno S=E1 <noname.nuno@gmail.com>
> Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: add docs for ad8460
>=20
> [External]
>=20
> On Tue, 30 Jul 2024 11:05:08 +0800
> Mariel Tinaco <Mariel.Tinaco@analog.com> wrote:
>=20
> > This adds the bindings documentation for the 14-bit High Voltage, High
> > Current, Waveform Generator Digital-to-Analog converter.
> >
> A few additions to Krzysztof's much more detailed review.
>=20
> Wrap patch descriptions to 75 chars. not sub 55.
>=20
> > Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> > +
> > +  adi,rset-ohms:
>=20
> Please rename this as rset sounds like reset to me.  Not sure what a good=
 name
> is however!
>=20
>=20
> > +    description: Specify value of external resistor connected to FS_AD=
J pin
> > +      to establish internal HVDAC's reference current I_REF
> > +    default: 2000
> > +    minimum: 2000
> > +    maximum: 20000
> > +


Replaced the name

  adi,external-resistor-ohms:
    description: Specify value of external resistor connected to FS_ADJ pin
      to establish internal HVDAC's reference current I_REF
    default: 2000
    minimum: 2000
    maximum: 20000

Regards,
Mariel

