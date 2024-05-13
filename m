Return-Path: <linux-iio+bounces-5007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA28C4350
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 16:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E5028210D
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3149EC7;
	Mon, 13 May 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="X+VKxO2e";
	dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b="X+VKxO2e"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022019.outbound.protection.outlook.com [52.101.186.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FB23BE
	for <linux-iio@vger.kernel.org>; Mon, 13 May 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.19
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610830; cv=fail; b=oZT/z9wIrmZM4H8Dl13i5vS6jaPRrM+u288QZWVaizL6yTSRjhOmvTxBfBo/aG6P7kVVOi7/jVc3NlCEu4OTGgs3Rl3RFT/SsLSXjS2sDTvefWqi3jLuWItPY9ptBbxVhzEapL5rer26cwiiBT7zghshNqstL6gLqPLYP6MD388=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610830; c=relaxed/simple;
	bh=f5XuU3NLqwsJ+AK2oqdG3e9pFWvAwhsIVS3FwkKVoxM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VB1IVqtE1/OgHRml/Nz1urlNb3JVe2SxrqzQ1f4JT4HQqHztIglxKgvFvbvJb+xHrexvvsxoDBZe75DJgXZX50XDsSy19qg5BLSDnGxjrJj0fYo2GldO+oCuamGxodSwfL1LHRxOuNvU73f/No5hLgOIVMula4lLR4f8NPZhNvc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com; spf=pass smtp.mailfrom=sentec.com; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=X+VKxO2e; dkim=pass (1024-bit key) header.d=sentec.com header.i=@sentec.com header.b=X+VKxO2e; arc=fail smtp.client-ip=52.101.186.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sentec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentec.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=irllIzV68Z2hoy3F4Dc7ZtHjmyc/M4u9RsFv8UgnEUm98qmyn2zzt3TIqVHKc8mSFNuGidLOGBaOOwliI5O7vLBpgQ2ltDrTGnVy8wrJyteKlg9bvQeU4jAUA0eZZerZ+ro4yUyeKqZ4vc2dd8YOoKESr5iH2VU5iqwwr1e5P0psUq1fP9ECj/6J7lB2FADRoyhGZFRoDZAgTKmpOfhUpPkikSmNyZkt/VrgTrZ9/G6PvX6DeeX80MN0YlFZ5YfgdFUn4YGGT3jJJQuZhyGvEOykEKUUl9fVkMwUHpJDvvHqLp1dn1C7djRrwRm0NP1Q1wtOkz3w7O86bKFSO7LbFQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TYo++2Ns/jjo+O9Ao1DGC2nuDxzhCAxRxhHAbBu7RM=;
 b=HR8AfBWG7vVENbkW+83OuXzwQ7YOR+HqU54FvMa7lbo7pUZo5J/JX0mu6rGH5ksVXqF8/1g6dvKkTyvm3IcIKt5lYh1yoN9M4nKcqNGwCWzASwymgNCONZ7uK7x7y7FHO+LrtF8LQnZ9van3SGKm2lqSONoKE2ts1s7dP2GfvtBoXbuyUygS6TBjYwUWAAeHtZnQjXZ1LiekXrDqhKweEQzOIYFixfeVPZoXgbZ05H5i09f/f4zX6z8Gkp/hVgBRQ72iP70L/OmLa5ZNNbDKcCVS6RPEg0DoI4QaQ5rs1eJK/X9KbEkFZ83VE5mlW9zmluWDw9DK0u998SIE5fCUgw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.74.137.176) smtp.rcpttodomain=kernel.org smtp.mailfrom=sentec.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sentec.com;
 dkim=pass (signature was verified) header.d=sentec.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sentec.com] dkim=[1,1,header.d=sentec.com]
 dmarc=[1,1,header.from=sentec.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TYo++2Ns/jjo+O9Ao1DGC2nuDxzhCAxRxhHAbBu7RM=;
 b=X+VKxO2em21bbls1MCRRpArgezExskgZgKw40ahVAFGVDgvLdYIrObFExo2Kg9QUYXsadAsfrlOXVHHaeXHDSn5HCcWZPQ4vTxKJick1lRsnB4PVE6fd+MTkNG+Z+JzpMQJz3BREgZGaKL0bd0yc120OwTIy+yNEmW5hMzWt7lQ=
Received: from AS9PR05CA0038.eurprd05.prod.outlook.com (2603:10a6:20b:489::25)
 by GVAP278MB0150.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 14:33:45 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:489:cafe::9b) by AS9PR05CA0038.outlook.office365.com
 (2603:10a6:20b:489::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 14:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.74.137.176)
 smtp.mailfrom=sentec.com; dkim=pass (signature was verified)
 header.d=sentec.com;dmarc=pass action=none header.from=sentec.com;
Received-SPF: Pass (protection.outlook.com: domain of sentec.com designates
 13.74.137.176 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.74.137.176; helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 14:33:43 +0000
Received: from ZRAP278CU002.outbound.protection.outlook.com (40.93.85.1) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 13 May 2024 14:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LALiNpK8XKNgV8YkHqc1XZ3IU2ePke3hS+OOv4ERfnXbnYoUa27FjLmgyx8UJE2qmu0GlcDUJt2zWYk9hC9pLZghMoCcKTejAkvuuQzxo/21yhv5rzU1icaskj9Fz50mLseBgxMm63MTssf2HuEoDNWLamcbGrh1keOH7nWDZbZ0Z9dh3/fT68s3L5MVnoD6H1XvhMvzhk23yH5prVNqzDCLBSBLXJ8kPzLrKUHxuPb2Z2lebrTwvwNXsiYinjOqxIFkOWZ0NVP7xmLr7FMthSfODN7e1oYcU6tjnF1pT3I2Yf7I0q+c40IJKVroj8JLoD88kfyjS3J7a3mT0Fdgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TYo++2Ns/jjo+O9Ao1DGC2nuDxzhCAxRxhHAbBu7RM=;
 b=VHTVhogPccnL/J5VhsKq67Pwsyn6j75eyHuwrnOrya6dHSnKIkXlf2g4CR9+pKs4Nq1GF2VGyYxeLr5sC6TucwGol3VFi+1kTsrPeW03wvY5fTeORnl9/OLBYLrheQfCPdFPcTJysTmBEc4/JVps+AZmpzOYz/4zk9SyqtJsy071RKth5vZHC0YNPf5LyY571ZetI1ea50zh+FatJvKW0XY+fKpzQ/ZpOVuj4ONtLlFem6bNy/uuPVV8hnw6rdXhuM4JNTG86RqgsU+Ox8TW0Kjp812HyeoeqpwhBsphgSLWVZxKYPv0KKC7JzZWGRsQpssgrPBw8JZM/dqSs7DmGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sentec.com; dmarc=pass action=none header.from=sentec.com;
 dkim=pass header.d=sentec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sentec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TYo++2Ns/jjo+O9Ao1DGC2nuDxzhCAxRxhHAbBu7RM=;
 b=X+VKxO2em21bbls1MCRRpArgezExskgZgKw40ahVAFGVDgvLdYIrObFExo2Kg9QUYXsadAsfrlOXVHHaeXHDSn5HCcWZPQ4vTxKJick1lRsnB4PVE6fd+MTkNG+Z+JzpMQJz3BREgZGaKL0bd0yc120OwTIy+yNEmW5hMzWt7lQ=
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::13)
 by ZR1P278MB1104.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 14:33:39 +0000
Received: from ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f]) by ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM
 ([fe80::44a0:22a7:f760:f8f%6]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 14:33:39 +0000
From: Arthur Becker <arthur.becker@sentec.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH V2] iio: light: driver for Vishay VEML6040
Thread-Topic: [PATCH V2] iio: light: driver for Vishay VEML6040
Thread-Index: AQHapT/pMyXRHcRfmUyP13y9qgd2bA==
Date: Mon, 13 May 2024 14:33:39 +0000
Message-ID: <ZR1P278MB111789B39F5CC0086DAFA35081E22@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-GB, de-DE, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sentec.com;
x-ms-traffictypediagnostic:
	ZR1P278MB1117:EE_|ZR1P278MB1104:EE_|AMS0EPF00000191:EE_|GVAP278MB0150:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3b3b54-2c2f-4fba-eaf6-08dc7359b169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?Zm+HigmgstkME278qssJE1DAWW2nnUcAYN4A4a6YWSrbWwKKvv5KScsh7p?=
 =?iso-8859-1?Q?ytPWXzOD1L8FQXDENgcCA8jB1PXXmbkk9V4WIoE/jHHOIyIlVc4hfGSobM?=
 =?iso-8859-1?Q?tq5MvTdqSh/cS6r8EX2aeaEp8cgPLGrqlFYdPB++5p2TenZHL6QkXXnscW?=
 =?iso-8859-1?Q?LNTZ0lITKeZhrPt9Ifw9uMfHtBSzw+NH9/WLKVU/+yngre4XEFMDKYdywK?=
 =?iso-8859-1?Q?P0Rq6RBpduh4sX1hrp9/9/qzN/JFniKWE7TtiBCmAsnva8qkmRjuEaO0Yl?=
 =?iso-8859-1?Q?yPhGyMBhTacNaZpRvuy9XtSbDlrX43fa1PHf/aZ++2/7e6TAIKCwj5/5vA?=
 =?iso-8859-1?Q?l5NszGkZgfwbb2yKNbMvMQXtJNIYJxBq0HxhraZWFv2PdxxU/3Jf0qUDHx?=
 =?iso-8859-1?Q?qSfymZInfO1psg9Af5JhusEMN4BS/q1dFvW4MRsBMKhanO3sOdVft4Vqw4?=
 =?iso-8859-1?Q?fELWKSb94b5vDzsETPsvp04pSf6G6B7az4RUWJJSNASxdohpx66IfdJwRr?=
 =?iso-8859-1?Q?+bQcuNfyiyQexuja94Tb/sQ5LuauB2/w0f8zaw19mBZuSE5BdEu0d5gfDO?=
 =?iso-8859-1?Q?RJOwdLMZ3dvEHJGfq6/j0vFrNjbPWP8pXF8fGr/iH72W1/fbgkg8kREoby?=
 =?iso-8859-1?Q?n46J4NPz9XUdNAP2jMO7WOv0geWSsru8+VbvnqrZImqepjYeou5FHoj4RW?=
 =?iso-8859-1?Q?1QdkiEACQtnkK19U7p5nP968k2+iyxRYuAwVFX0AO6p3tiuvE+LZ8V0OPw?=
 =?iso-8859-1?Q?+ZZKqEGYZz+kx6oic5gUAL9Df7dhQ5c5FlmUb5uABj+OKM98zfOefHOxuh?=
 =?iso-8859-1?Q?OPYgTT0FYj1Gk+X8jc0I0UeyjaBZkqmxWutkRpVg3wZcFT1WU8W+IjYkXI?=
 =?iso-8859-1?Q?ckBMpeNAQOPuXRBkhuHM5hwjwuZTdLgmF+E0c2Hfm0rN8w4trfTscHRcZa?=
 =?iso-8859-1?Q?zrL8MS1ekXGQp/IVkKCr13tumX83Kqd+Q3HT3DQE4j0j41sVNbf2D1VBx/?=
 =?iso-8859-1?Q?A8oHIm2isW/ninEfYS4FMFfwA7Nt+H9K80G5GUzqQ5FQBHbtOE+rsT+zHt?=
 =?iso-8859-1?Q?m7vb3HKa6V1/sjBlaemCQWaNxiCSOIB12I0zJ028uTMravT02hnTfriaNB?=
 =?iso-8859-1?Q?KZrxsfYZ/e6DFkq3JNiw9IsPdBqY6wDEypn3qS6eviDMdgUn3MnrO/jl0t?=
 =?iso-8859-1?Q?DHz44Jr90bFs3y0jQG6eKK3c6aVyTXl03IA3vsqAW/qHhXz1lY4dEQFm31?=
 =?iso-8859-1?Q?dgItj0ysGimcSwemFm24DhoWjigExvVFtc8H4MQgrdohCL8Qn+eYno0PL7?=
 =?iso-8859-1?Q?r4JQuTKOQlatRMAcVQ6TjZ6C3A=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1104
X-CodeTwo-MessageID: 0a89adf5-497c-4802-8cfe-f701a679ee03.20240513143342@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	368e6584-5e3a-4292-0e9c-08dc7359ae85
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|35042699013|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?t5kwZBPBPC0rWF63mxJULfCbgyUSmpw5bf+KPjjMjm/17wgmvWAqPvWbRt?=
 =?iso-8859-1?Q?lDKU/aYed+LJejfQ9ydKgmOQgUhjUxf6fWKKWupsWF6+hoj4xSldvT6pHw?=
 =?iso-8859-1?Q?NlapkCKaeBwICfXzG5X3lak9lIng2+kojk+yLP8QtMkkBFtQ0BAheOLn/b?=
 =?iso-8859-1?Q?6NPWBlalM5fMhhMgP9XcveFd4+lDf5uB3sg/ljtveJEmOY1xb3dD2a0ctl?=
 =?iso-8859-1?Q?ZOyvf7dYgz94hnj2uop7KZVXHZiRjpffESG4cR6PlJgM0ohtjCWvVDZiR9?=
 =?iso-8859-1?Q?zBRBHwP7HwLKLVs1Ogk3c5ZrTloz/URV8HMqfM9e1D2INLaC9O8qLfCD1z?=
 =?iso-8859-1?Q?JvWWCDpHZ4EP+i7pvyqic48d8Y8n36DF8rX7S1i1i009mOs/cqlH0Zc39j?=
 =?iso-8859-1?Q?/JaAlETWDehrrICkDau6+fUeYahMQts+aphjDPRP646GbjO1SNsAgOjvNX?=
 =?iso-8859-1?Q?XPVlXc7XRYVSdy4U7PaFFYrXBIrDtF0NncNm3tE82VhJkyzjKihX0IjBG6?=
 =?iso-8859-1?Q?QD9IFD8NWa1lDGHY4CWCl7741NiRJ9qt5Ia6eVMeGxJHh2Zvug+1RB0Hob?=
 =?iso-8859-1?Q?ROy+cC689pe0KA95ZIfQH3Th7YjdgP0Ga6CJSxg9arf62+cwlyCP3Z+7B5?=
 =?iso-8859-1?Q?TaMeiPjTpe6piSsZbe4jwx4SVDUncC8CtiWFVr8Zbx+mE4u7wy6ptSqQ/U?=
 =?iso-8859-1?Q?z6DBCg4QJh/XNgrfF5MMguTUVp1zfTatybmuktjKvYyOnhXJVpkO++ipC3?=
 =?iso-8859-1?Q?AOC71lAXAmv4KK2DBoJuWxVF2RKQj/03hD1vQqzOIlx54MmhYY4JF3jgu6?=
 =?iso-8859-1?Q?heMzd4X4/LnHa9ltzdOhd7GsGM/XyW8md/mMMFDuC09kt6cYjfzlQOdG3j?=
 =?iso-8859-1?Q?HNQFxu0R0iKXSGTiVd1j6FmcR4po6x8yxhLeGvRuyQQuomVFtRGlYJXB4m?=
 =?iso-8859-1?Q?08J6kdaiHl0W2uQXj+x/cYV6RF0u+SzTP1RF8dtVPlDu4q+dDO55mICG15?=
 =?iso-8859-1?Q?GvlP4gUyHOHbajwfr1tMTILeFSLbhdxytOg7wiomaEbZJa5cJ23GAZEQrc?=
 =?iso-8859-1?Q?R6QiSpQ0qYwfRGr42IkuBvFGuymdRv8BPvHLYgIME8gu003hpHF0K4PUTj?=
 =?iso-8859-1?Q?3VPB/xOSKpQr1AOq0Z0xQh2WIoXe7UqZ9IAw7dwdIxF9U6hdm52UEV1RDQ?=
 =?iso-8859-1?Q?8s32tPO01yVpHTnbdKWtTumcyS9mBxVANRC9zXoW6XMpkIM0TGweHPsU/b?=
 =?iso-8859-1?Q?vR84KfEFFVHwcXYE2aa3NjaT1O237L2uhzZTX4gIu5CbSYevuHFuBKdPf1?=
 =?iso-8859-1?Q?zAWaEukPLvocAitPVuFJd8RXIhoV+jYog0X/Dxp2nB1/2WkCpAhwLSmO8J?=
 =?iso-8859-1?Q?BrAtl9NYVY?=
X-Forefront-Antispam-Report:
	CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(35042699013)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: sentec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 14:33:43.8997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3b3b54-2c2f-4fba-eaf6-08dc7359b169
X-MS-Exchange-CrossTenant-Id: 0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0cfe5cb4-0f5d-4077-ac2f-a1a82ad165a3;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0150

Implements driver for the Vishay VEML6040 rgbw light sensor.=0A=
=0A=
Included functionality: setting the integration time and reading the raw=0A=
values for the four channels=0A=
=0A=
Not yet implemented: setting the measurements to 'Manual Force Mode' (Auto=
=0A=
measurements off, and adding a measurement trigger)=0A=
=0A=
Datasheet: https://www.vishay.com/docs/84276/veml6040.pdf=0A=
signed-off-by: Arthur Becker <arthur.becker@sentec.com>=0A=
---=0A=
V1 -> V2: Addressed review comments. DT-bindings in separate patch=0A=
=0A=
 drivers/iio/light/Kconfig    |  11 ++=0A=
 drivers/iio/light/Makefile   |   1 +=0A=
 drivers/iio/light/veml6040.c | 307 +++++++++++++++++++++++++++++++++++=0A=
 3 files changed, 319 insertions(+)=0A=
 create mode 100644 drivers/iio/light/veml6040.c=0A=
=0A=
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig=0A=
index fd5a9879a582..7ff517b728ec 100644=0A=
--- a/drivers/iio/light/Kconfig=0A=
+++ b/drivers/iio/light/Kconfig=0A=
@@ -654,6 +654,17 @@ config VEML6030=0A=
 	  To compile this driver as a module, choose M here: the=0A=
 	  module will be called veml6030.=0A=
 =0A=
+config VEML6040=0A=
+	tristate "VEML6040 RGBW light sensor"=0A=
+	select REGMAP_I2C=0A=
+	depends on I2C=0A=
+	help=0A=
+	  Say Y here if you want to build a driver for the Vishay VEML6040=0A=
+	  RGBW light sensor.=0A=
+=0A=
+	  To compile this driver as a module, choose M here: the=0A=
+	  module will be called veml6040.=0A=
+=0A=
 config VEML6070=0A=
 	tristate "VEML6070 UV A light sensor"=0A=
 	depends on I2C=0A=
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile=0A=
index 2e5fdb33e0e9..ae957c88aa0c 100644=0A=
--- a/drivers/iio/light/Makefile=0A=
+++ b/drivers/iio/light/Makefile=0A=
@@ -61,6 +61,7 @@ obj-$(CONFIG_US5182D)		+=3D us5182d.o=0A=
 obj-$(CONFIG_VCNL4000)		+=3D vcnl4000.o=0A=
 obj-$(CONFIG_VCNL4035)		+=3D vcnl4035.o=0A=
 obj-$(CONFIG_VEML6030)		+=3D veml6030.o=0A=
+obj-$(CONFIG_VEML6040)		+=3D veml6040.o=0A=
 obj-$(CONFIG_VEML6070)		+=3D veml6070.o=0A=
 obj-$(CONFIG_VEML6075)		+=3D veml6075.o=0A=
 obj-$(CONFIG_VL6180)		+=3D vl6180.o=0A=
diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c=0A=
new file mode 100644=0A=
index 000000000000..9ce807d5484a=0A=
--- /dev/null=0A=
+++ b/drivers/iio/light/veml6040.c=0A=
@@ -0,0 +1,307 @@=0A=
+#include <linux/bitfield.h>=0A=
+#include <linux/err.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/iio/iio.h>=0A=
+#include <linux/iio/sysfs.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/regmap.h>=0A=
+=0A=
+/* VEML6040 Configuration Registers=0A=
+ *=0A=
+ * SD: Shutdown=0A=
+ * AF: Auto / Force Mode (Auto Measurements On:0, Off:1)=0A=
+ * TR: Trigger Measurement (when AF Bit is set)=0A=
+ * IT: Integration Time=0A=
+ */=0A=
+#define VEML6040_CONF_REG_RW 0x000=0A=
+#define VEML6040_CONF_SD_MSK BIT(0)=0A=
+#define VEML6040_CONF_AF_MSK BIT(1)=0A=
+#define VEML6040_CONF_TR_MSK BIT(2)=0A=
+#define VEML6040_CONF_IT_MSK GENMASK(6, 4)=0A=
+#define VEML6040_CONF_IT_40 0=0A=
+#define VEML6040_CONF_IT_80 1=0A=
+#define VEML6040_CONF_IT_160 2=0A=
+#define VEML6040_CONF_IT_320 3=0A=
+#define VEML6040_CONF_IT_640 4=0A=
+#define VEML6040_CONF_IT_1280 5=0A=
+=0A=
+/* VEML6040 Read Only Registers */=0A=
+#define VEML6040_REG_R_RO 0x08=0A=
+#define VEML6040_REG_G_RO 0x09=0A=
+#define VEML6040_REG_B_RO 0x0A=0A=
+#define VEML6040_REG_W_RO 0x0B=0A=
+=0A=
+static const int veml6040_int_time_avail[] =3D { 40, 80, 160, 320, 640, 12=
80 };=0A=
+=0A=
+enum veml6040_chan {=0A=
+	CH_RED,=0A=
+	CH_GREEN,=0A=
+	CH_BLUE,=0A=
+	CH_WHITE,=0A=
+};=0A=
+=0A=
+struct veml6040_data {=0A=
+	struct i2c_client *client;=0A=
+	struct regmap *regmap;=0A=
+};=0A=
+=0A=
+static const struct regmap_config veml6040_regmap_config =3D {=0A=
+	.name =3D "veml6040_regmap",=0A=
+	.reg_bits =3D 8,=0A=
+	.val_bits =3D 16,=0A=
+	.max_register =3D VEML6040_REG_W_RO,=0A=
+	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,=0A=
+};=0A=
+=0A=
+static int veml6040_read_raw(struct iio_dev *indio_dev,=0A=
+			     struct iio_chan_spec const *chan, int *val,=0A=
+			     int *val2, long mask)=0A=
+{=0A=
+	int ret, reg, it_index;=0A=
+	struct veml6040_data *data =3D iio_priv(indio_dev);=0A=
+	struct regmap *regmap =3D data->regmap;=0A=
+	struct device *dev =3D &data->client->dev;=0A=
+=0A=
+	switch (mask) {=0A=
+	case IIO_CHAN_INFO_RAW:=0A=
+		switch (chan->channel) {=0A=
+		case CH_RED:=0A=
+			ret =3D regmap_read(regmap, VEML6040_REG_R_RO, &reg);=0A=
+			break;=0A=
+		case CH_GREEN:=0A=
+			ret =3D regmap_read(regmap, VEML6040_REG_G_RO, &reg);=0A=
+			break;=0A=
+		case CH_BLUE:=0A=
+			ret =3D regmap_read(regmap, VEML6040_REG_B_RO, &reg);=0A=
+			break;=0A=
+		case CH_WHITE:=0A=
+			ret =3D regmap_read(regmap, VEML6040_REG_W_RO, &reg);=0A=
+			break;=0A=
+		default:=0A=
+			return -EINVAL;=0A=
+		}=0A=
+		if (ret) {=0A=
+			dev_err(dev, "iio-veml6040 - Can't read data %d\n",=0A=
+				ret);=0A=
+			return ret;=0A=
+		}=0A=
+		*val =3D reg;=0A=
+		return IIO_VAL_INT;=0A=
+=0A=
+	case IIO_CHAN_INFO_INT_TIME:=0A=
+		ret =3D regmap_read(regmap, VEML6040_CONF_REG_RW, &reg);=0A=
+		if (ret) {=0A=
+			dev_err(dev, "iio-veml6040 - Can't read data %d\n",=0A=
+				ret);=0A=
+			return ret;=0A=
+		}=0A=
+		it_index =3D FIELD_GET(VEML6040_CONF_IT_MSK, reg);=0A=
+		if (it_index >=3D ARRAY_SIZE(veml6040_int_time_avail)) {=0A=
+			dev_err(dev,=0A=
+				"iio-veml6040 - Invalid Integration Time Set");=0A=
+			return -EINVAL;=0A=
+		}=0A=
+		*val =3D veml6040_int_time_avail[it_index];=0A=
+		return IIO_VAL_INT;=0A=
+=0A=
+	default:=0A=
+		return -EINVAL;=0A=
+	}=0A=
+}=0A=
+=0A=
+static int veml6040_write_raw(struct iio_dev *indio_dev,=0A=
+			      struct iio_chan_spec const *chan, int val,=0A=
+			      int val2, long mask)=0A=
+{=0A=
+	struct veml6040_data *data =3D iio_priv(indio_dev);=0A=
+=0A=
+	switch (mask) {=0A=
+	case IIO_CHAN_INFO_INT_TIME:=0A=
+		for (int i =3D 0; i < ARRAY_SIZE(veml6040_int_time_avail); i++) {=0A=
+			if (veml6040_int_time_avail[i] =3D=3D val) {=0A=
+				return regmap_update_bits(=0A=
+					data->regmap, VEML6040_CONF_REG_RW,=0A=
+					VEML6040_CONF_IT_MSK,=0A=
+					FIELD_PREP(VEML6040_CONF_IT_MSK, i));=0A=
+			}=0A=
+		}=0A=
+		return -EINVAL;=0A=
+	default:=0A=
+		return -EINVAL;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int veml6040_read_avail(struct iio_dev *indio_dev,=0A=
+			       struct iio_chan_spec const *chan,=0A=
+			       const int **vals, int *type, int *length,=0A=
+			       long mask)=0A=
+{=0A=
+	switch (mask) {=0A=
+	case IIO_CHAN_INFO_INT_TIME:=0A=
+		*length =3D ARRAY_SIZE(veml6040_int_time_avail);=0A=
+		*vals =3D veml6040_int_time_avail;=0A=
+		*type =3D IIO_VAL_INT;=0A=
+		return IIO_AVAIL_LIST;=0A=
+=0A=
+	default:=0A=
+		return -EINVAL;=0A=
+	}=0A=
+}=0A=
+=0A=
+static const struct iio_info veml6040_info =3D {=0A=
+	.read_raw =3D veml6040_read_raw,=0A=
+	.write_raw =3D veml6040_write_raw,=0A=
+	.read_avail =3D veml6040_read_avail,=0A=
+};=0A=
+=0A=
+static const struct iio_chan_spec veml6040_channels[] =3D {=0A=
+	{=0A=
+		.type =3D IIO_INTENSITY,=0A=
+		.channel =3D CH_RED,=0A=
+		.channel2 =3D IIO_MOD_LIGHT_RED,=0A=
+		.modified =3D 1,=0A=
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=0A=
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+		.info_mask_shared_by_type_available =3D=0A=
+			BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+	},=0A=
+	{=0A=
+		.type =3D IIO_INTENSITY,=0A=
+		.channel =3D CH_GREEN,=0A=
+		.channel2 =3D IIO_MOD_LIGHT_GREEN,=0A=
+		.modified =3D 1,=0A=
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=0A=
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+		.info_mask_shared_by_type_available =3D=0A=
+			BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+	},=0A=
+	{=0A=
+		.type =3D IIO_INTENSITY,=0A=
+		.channel =3D CH_BLUE,=0A=
+		.channel2 =3D IIO_MOD_LIGHT_BLUE,=0A=
+		.modified =3D 1,=0A=
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=0A=
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+		.info_mask_shared_by_type_available =3D=0A=
+			BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+	},=0A=
+	{=0A=
+		.type =3D IIO_INTENSITY,=0A=
+		.channel =3D CH_WHITE,=0A=
+		.channel2 =3D IIO_MOD_LIGHT_CLEAR,=0A=
+		.modified =3D 1,=0A=
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=0A=
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+		.info_mask_shared_by_type_available =3D=0A=
+			BIT(IIO_CHAN_INFO_INT_TIME),=0A=
+	}=0A=
+};=0A=
+=0A=
+static int veml6040_shutdown(struct veml6040_data *data)=0A=
+{=0A=
+	return regmap_update_bits(data->regmap, VEML6040_CONF_REG_RW,=0A=
+				  VEML6040_CONF_SD_MSK, VEML6040_CONF_SD_MSK);=0A=
+}=0A=
+=0A=
+static void veml6040_shutdown_action(void *data)=0A=
+{=0A=
+	veml6040_shutdown(data);=0A=
+}=0A=
+=0A=
+static int veml6040_probe(struct i2c_client *client)=0A=
+{=0A=
+	struct veml6040_data *data;=0A=
+	struct iio_dev *indio_dev;=0A=
+	struct regmap *regmap;=0A=
+	int ret;=0A=
+=0A=
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {=0A=
+		return dev_err_probe(&client->dev, -EOPNOTSUPP,=0A=
+				     "I2C adapter doesn't support plain I2C\n");=0A=
+	}=0A=
+=0A=
+	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));=0A=
+	if (!indio_dev) {=0A=
+		return dev_err_probe(&client->dev, -ENOMEM,=0A=
+				     "IIO device allocation failed\n");=0A=
+	}=0A=
+=0A=
+	regmap =3D devm_regmap_init_i2c(client, &veml6040_regmap_config);=0A=
+	if (IS_ERR(regmap)) {=0A=
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),=0A=
+				     "Regmap setup failed\n");=0A=
+	}=0A=
+=0A=
+	data =3D iio_priv(indio_dev);=0A=
+	i2c_set_clientdata(client, indio_dev);=0A=
+	data->client =3D client;=0A=
+	data->regmap =3D regmap;=0A=
+=0A=
+	indio_dev->name =3D "veml6040";=0A=
+	indio_dev->info =3D &veml6040_info;=0A=
+	indio_dev->channels =3D veml6040_channels;=0A=
+	indio_dev->num_channels =3D ARRAY_SIZE(veml6040_channels);=0A=
+	indio_dev->modes =3D INDIO_DIRECT_MODE;=0A=
+=0A=
+	ret =3D regmap_update_bits(=0A=
+		data->regmap, VEML6040_CONF_REG_RW, VEML6040_CONF_IT_MSK,=0A=
+		FIELD_PREP(VEML6040_CONF_IT_MSK, VEML6040_CONF_IT_40));=0A=
+=0A=
+	if (ret) {=0A=
+		return dev_err_probe(&client->dev, ret,=0A=
+				     "Could not set Integration Time: %d\n",=0A=
+				     ret);=0A=
+	}=0A=
+=0A=
+	ret =3D regmap_update_bits(data->regmap, VEML6040_CONF_REG_RW,=0A=
+				 VEML6040_CONF_AF_MSK,=0A=
+				 FIELD_PREP(VEML6040_CONF_AF_MSK, 0));=0A=
+	if (ret) {=0A=
+		return dev_err_probe(&client->dev, ret,=0A=
+				     "Could not set Automode: %d\n", ret);=0A=
+	}=0A=
+=0A=
+	ret =3D regmap_update_bits(data->regmap, VEML6040_CONF_REG_RW,=0A=
+				 VEML6040_CONF_SD_MSK,=0A=
+				 FIELD_PREP(VEML6040_CONF_SD_MSK, 0));=0A=
+	if (ret) {=0A=
+		return dev_err_probe(&client->dev, ret,=0A=
+				     "Could not set Enable: %d\n", ret);=0A=
+	}=0A=
+=0A=
+	ret =3D devm_add_action_or_reset(&client->dev, veml6040_shutdown_action,=
=0A=
+				       data);=0A=
+	if (ret) {=0A=
+		return dev_err_probe(&client->dev, ret,=0A=
+				     "Could not add shutdown action: %d\n",=0A=
+				     ret);=0A=
+	}=0A=
+=0A=
+	return devm_iio_device_register(&client->dev, indio_dev);=0A=
+}=0A=
+=0A=
+static const struct i2c_device_id veml6040_id_table[] =3D { { "veml6040", =
0 },=0A=
+							  {} };=0A=
+MODULE_DEVICE_TABLE(i2c, veml6040_id_table);=0A=
+=0A=
+static const struct of_device_id veml6040_of_match[] =3D {=0A=
+	{ .compatible =3D "vishay,veml6040" },=0A=
+	{}=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, veml6040_of_match);=0A=
+=0A=
+static struct i2c_driver veml6040_driver =3D {=0A=
+	.probe =3D veml6040_probe,=0A=
+	.id_table =3D veml6040_id_table,=0A=
+	.driver =3D {=0A=
+		.name =3D "veml6040",=0A=
+		.of_match_table =3D veml6040_of_match,=0A=
+	},=0A=
+};=0A=
+=0A=
+module_i2c_driver(veml6040_driver);=0A=
+=0A=
+MODULE_DESCRIPTION("veml6040 RGBW light sensor driver");=0A=
+MODULE_AUTHOR("Arthur Becker <arthur.becker@sentec.com>");=0A=
+MODULE_LICENSE("GPL");=0A=
-- =0A=
2.34.1=0A=

