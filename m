Return-Path: <linux-iio+bounces-27112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 762A9CC2836
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 13:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59D383015D09
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC134BA50;
	Tue, 16 Dec 2025 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="fyyvqHkX"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021140.outbound.protection.outlook.com [40.107.130.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2605B34BA33;
	Tue, 16 Dec 2025 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885278; cv=fail; b=sG3ZT8UV3GomyGcI+Ev3EuwcjD+9aV+I4VgvkeLJo3G4stQzUT6Ux3n/y209g77jaS9WO5use15rhTImBU9PJO6/AP7H/neDne4Y2trq/LS/b39r9fNJ5BaZsf+bFcstrr9HmiLecjBsA9d/nG3YR6vN+n3CKn3tiislqWy7zPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885278; c=relaxed/simple;
	bh=U3joWO7yAzVBil3qssR0eB5i8eXf3LlgTQxIskhEXjs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=jVys0Dptq+zJjf978ravuEbuXIN5qsQ76oxW+r7dtEZ5xB2BZuy2i5u1oSn2et42rsyjyc6cFom+XZAq5qqp5ArmartDddf/v+aSs9ZVXTZvCufxkYABgPbl2x9c5nNXORbFLWDEfnfjGrmT5z+Oc9Qj/iCejsb2mQtGJpzSX18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=fyyvqHkX; arc=fail smtp.client-ip=40.107.130.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aw3oNr6uCyMokKfhgcaPlDyawADL8fJoDYrlCuvkS9+CK796zy5steQxMbpps5rBFuRKH35Kini/DptkQ4wBK3iJbNHKevBP4p7KCPA/rnXszhszs2Gan7u6huI9O3QcxJCbMOLi4awWyY9v2X5CwqCRffngoKOaP1Ba70kEsugsTsD9JKDUppGRbKCsqJnr6h0w1Md7Qb/YZRgrU5DYX8zkMfLOP7241uubIsQYL9jQcRIIM74RXRmmRYPhlADKEqcxKasly1m753QnREFZBUH1TyY6sWFbjaxesRwbbu3Zbuj371XVrqwkuIIGWFuPKSOLoGHTAaxX1azE3aqtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOkx9NcfzoZDPtiEkLZpvLrPHAXJyAHRiC/kxRAKHb0=;
 b=nEKaUTaGZ6pSXuw+ql2R/XYF//7xkBJMGgHhvm6KLy5Qd3/e7diiImTVW7W+uCOCQyIcZzoYWmf1eilXgkW/eyn8eu/XlDKzAOCi7Jay5yVhFazfPInMYg9cKeqgBXMzfQC6mFNRbKfFFXsSw4S+Yn8DwDoWxyaHkmlW8debP50+heGf7XNqFdbUvX37JLfOvstMZeOzicPfGFglwh4VdFMDXb5INhCFfFLn8u2aI4ed9n6SJcuIoBs8ol1M13vgbuR9kTZNUTiRsPiGIIz+ZS1C2BgPuOQVsUwgfUkyeurinl+4FG0cqpC9h+xHE/ti9Rzbd6G2bEnWE/qZOEsshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOkx9NcfzoZDPtiEkLZpvLrPHAXJyAHRiC/kxRAKHb0=;
 b=fyyvqHkXtUz3Jg9oitMCmxoJGkwZ0JXJ+lCEQqMYw/v+lXoWdF5SEQM413fX8T1D2kqEIbUIAXf3L4HuWtSHXZkS35HbXmh8McId4sP3y5j8JW88AxfU47YeU+E1b0PS1ZTsXzxaqXcFAk/Z+T7jhxWK6F56UeNy6lTdtzXLculd8oCCXdjUvChZwxj2zQabayuYcfvqpVSbi9/wz5EH1v4X255c8uyvqj9xMDeJ7yKYuzvzZJjpDFZcdQo2ZYtMvSZ4JjSbrBQhLLJEmz1xWddLxa2PRcGN3cj/kEe6SEKOAemBeFACelaJmWiqskQtYkeWspTHBqeCOt99GzhGBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DU4PR06MB10185.eurprd06.prod.outlook.com (2603:10a6:10:626::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 11:41:10 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 11:41:10 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH 0/2] iio: adc: ad9467: Enable operation without iio-backend
Date: Tue, 16 Dec 2025 11:40:04 +0000
Message-Id: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABRFQWkC/x3MQQqAIBBA0avErBtQs8KuEi0sxxoKC40IorsnL
 R98/gOJIlOCrngg0sWJ95AhywKmxYaZkF02KKFqqWSNo0brjG5a3I8zx3bD0U4rBYeq8lIYQ6R
 dC3lwRPJ8//N+eN8PLexNoGwAAAA=
X-Change-ID: 20251215-b4-ad9467-optional-backend-23f1099ee4d7
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765885270; l=694;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=U3joWO7yAzVBil3qssR0eB5i8eXf3LlgTQxIskhEXjs=;
 b=1RykRfT/9O9hjgVVaxxgkTjlYJttq7ccPVh0vMO7sWGC1YArrEEi6EZOIIfFCupQg/fJt/1wS
 YznwAjTNkE+Cz03X47TazbyruAgrWW4Os+JUFUNrpQ/69KZaazc/bjX
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV2PEPF0000383B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:b) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DU4PR06MB10185:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee2e818-8daf-4ac9-ed51-08de3c98027a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnRiRzFJWUlmUVQ1SDgwRys3cHZNNHRCWmRJMEgxM2gwUzVTN3ZnK3U5ajhp?=
 =?utf-8?B?VEMzQVFUMDBvbVd5Si9qdjhwM1MydDRwVTZ3RTJyVFBCeGIwWEFnMUp0TUNQ?=
 =?utf-8?B?Y0FrS3plTWhGTWkveEFJR2FCSlRQMEZrVy9YdXRHVW1lMkFIOHdYQ3N2SHZK?=
 =?utf-8?B?aS8xaVBaMXJ3WkNCci9wQzBzL3pRd0IwZ3JRK3E0YkpHbjZCRlpETm8xc3NJ?=
 =?utf-8?B?LzA5dE1ETk90dEd6ZlhQSFlZL1dOQUpsOGhFOXlQNC93SHNZWUV4Tml3QkVN?=
 =?utf-8?B?Q2gveWM1RmI2TUtMNEpFVWZPUnNZcW5zYlNwd2k2NzQ5UFgrN1RKeWQyQ3lB?=
 =?utf-8?B?SXJSankvcXdrTGtsNlZzSmNIZG0zR2pYSVBLOXZ3dFU3YWRMK1c0djRXa09m?=
 =?utf-8?B?M1E1emV3cW44ditxVk9leUtHWHMrS3NLaVNPaHlhYlJOWTFDSUFadjdlcG5W?=
 =?utf-8?B?Q21yaDBqK24rNzhVTVhHQ0hNeWFESXNqRnZNU1o2NHBJdUg5WW51dnBUY1Zn?=
 =?utf-8?B?ckk2L1ZWK1piU2NNNUpjS3M1TDBocTZ4YmNqeVF3ZUpQNE8vbXRLOWhTeWdH?=
 =?utf-8?B?UnBrbC9HVEpxWnVRaHQ0c3Q5TlNnT3o1UXFzcE1DYUlOZmRRdm5LRVRNWncw?=
 =?utf-8?B?WVIxblR1Yzl6a1V0NXhKckQ5dDlDVVdTR0p3ZjN4SDl3RXNFWE9nMm9ZbGM4?=
 =?utf-8?B?UWp6MUNQbHlBZ0pHcVRuNUdHbjVpMi9XOXJPK2dXTWhhc0p4RDhsR3ZtRTh4?=
 =?utf-8?B?dkNXQVV1NEFHc3d4SStQSVVYU1ZVdWtXNHFkeExoMmFIZFAzaVBocURaaW1k?=
 =?utf-8?B?d1NMQ1hQZS9yWXJoM1NRUFNvUXVXTFBkTGQ4VDRGMml5MWo5VzFBczIwcGpK?=
 =?utf-8?B?SC9WSXBubG9oWCt5QS9wZGhkalI1WEFTRUI5cTBJSE4venlkbGxYRmkya09i?=
 =?utf-8?B?Sjc1VkNMWkZvMWhLUW1PeFVuMWZISlhubGdFRHpnOVkwM1BSSHVRS3ZYQVgv?=
 =?utf-8?B?cnpCcnhzYmZvMXFZZUdpbU04WDh3RTNCczlvTWtFdDJ6bG1uV3pheEk2UHBG?=
 =?utf-8?B?U3BZM0YyRGFjb21xTlU4bzVVNnpDS09ELzJsb0NhdHBOQy93NGV0dldMeUpi?=
 =?utf-8?B?d1hRWUhVeG5yUXZqZ0RBVWJDT3lUZkxFeEE0SkpNVWxhZi9xd285QzZYbFBK?=
 =?utf-8?B?TlYxbmRFaW56bkZRMWtQczJoL0RUMVN0eitsUlRNSkRVeGVlK2YzQk5UTHk2?=
 =?utf-8?B?V3JCSGIxSC90WEYvV2I0Si9BWHFDWVM4dHV0ZTd5UUtDL2ZVVEdFTGFwTG8w?=
 =?utf-8?B?MWoyOXpxNzU4T1IzQ1JwL2lPTlhkeCtieVhQQnkxMGR3bUx6WExKZGlOKys3?=
 =?utf-8?B?L0JOUVlxYUtaSHJKN3hqT0dTSzVBNTMrTVBxaEdjenFmUm1mbnVOd1p3b2Ry?=
 =?utf-8?B?WC9mQlBXWDFVcnZtNmVETXlkbGZSN2UvVGp3clNJQmc1SVZlQzkzTi8vNDRk?=
 =?utf-8?B?cXJkS2ZVN1FlZUVyNGIvdURvd21YbWgxdTFZMmUwS01seXQyVndrdzJwKyt4?=
 =?utf-8?B?V2wreEdVemtiSWp0STIxQStybkpUZlNJbmMwdUNPWUNoM1R4STRGS1pPQ3Vu?=
 =?utf-8?B?SkY0VWhYM1dxczRvRHIxUDZiRWdpdGh2ZVNWWDZQSjVkNWY2alUzcHlYSndG?=
 =?utf-8?B?bEtyOTEzWTdsdklQTWFUTjhHM0JER3hTT2JPOEJtenRGWWI3S1ZwdldTK3pW?=
 =?utf-8?B?dmhXTkViNjFoQVNaN2RKckN1RXM0Zjk4UjNTSUF0a0trSFIrMEk1NXR6a3Mv?=
 =?utf-8?B?azVlVmF2Tk9PK0tJSnczTS9Ka3BGa2xoa1dxbzVOVnFFVVhwQy83dWVlOHp4?=
 =?utf-8?B?MXh4aTRIZE1xbW9aSGt1SFVaeDV6NnhqejI4OTk0NXc5WGZ6OHNrMU5wOTA4?=
 =?utf-8?B?SFVsNXBvL1cwdE9FVitwRXhNNlhpNHY3T3N0RnRBYXJLU1RSMFFqT2ZMY3BM?=
 =?utf-8?B?UkVPTVlSSFBSdGhvdFdKYUI1VWcwU3B3VlFuRDdvT0J6Z0w5V0dxcTN6aGlr?=
 =?utf-8?Q?TiV5Lj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm83dndhY0dLaEQreEViSVdzNCtUUU9Qd0hvbnhCM08yM1FaYzVUY0pRR1NV?=
 =?utf-8?B?bU44NlpaUDVXV3BxSkpxd014eHZ0Zk4xMjU1VHh3TUJXU0l2VlhTSzV6SUc5?=
 =?utf-8?B?aGdHQVdxR2NpQ3JUMFJwTzk5aVZ1KzliaVgzUkl3d3VOc05PN2tSNmRqNGNB?=
 =?utf-8?B?blFQQ0hCRjI5Z2hKTWU2eWlXOXhIaFBNRmtJV2Q5UER5U3c0djg5emJYVTNx?=
 =?utf-8?B?MHBSWXdQWGtpb2YyejVhTlN5RmRnLzFzcG9jVnZ2b0x0T1R1cUpraG56QVp3?=
 =?utf-8?B?RTJVSlptSVZvYXJBVi9jNm15N3M4M3hTellwZk1MK1NJWnBwNE9MTmxMRm1O?=
 =?utf-8?B?cmVQNm0vdzUyZTlSd1k5N0JoM1lBNU92alk5QjUrKzhmbHBuMnNua2FmMVg5?=
 =?utf-8?B?UlRrQWZla1IxdFBiNytVZTYxcjhtR1FxZkJZQVhZU2p3WVFWa1dOMVltbDZj?=
 =?utf-8?B?aW0vcDlJSi8rYUZYT2pvQU9GZmZCZU0vM3BmRnZBQjdEaUhoZ3pYODJ5QWIy?=
 =?utf-8?B?cUIvWnFnWjB0VGY3eTRyWFc5UDdhbFVYOXU1dHRIK2gwd2FGNjFyaDR4bTZT?=
 =?utf-8?B?T1pZcWhHeDZBS1drTnltNzJVcXVBYytldzVZQlpKZE1icEwzL1hWOFJnRGJT?=
 =?utf-8?B?VTFRNnpaK3FuRDFheGUyZDVYTTRqbVh3WHUrWEEzNHNWTTRFVUNWR090cVht?=
 =?utf-8?B?Z1MzS0RTOEN0UERWenR2ZFB6UmpBaS94YWd4aXlGZjEzNWlFbDVSVG1tdE0x?=
 =?utf-8?B?V3BaeVQ5dWpaNDVFU1RKY1ZnYkRmUVBoTmE4R0ZSbWNoY2dEQXJaSUl4bDJL?=
 =?utf-8?B?eDc0WG5Nc1h0cnBkazI1SWpQMjhTeUcvM2hPeVd6RzMwbnRqK2gzVTBXcXB3?=
 =?utf-8?B?S3lNRmpQWVI3MXNFZ3lTNy9iRE0rRUhLOE45TURhaUFGYTBaZUZJSis4b0Y4?=
 =?utf-8?B?MUliT0FnTThjeG9mMExPbFJwK25TdDZhLzJBVzZaaHVMY2FXZEwyMnJoZEw4?=
 =?utf-8?B?SVhwTWxKOTNNVzhXK3NjcmlWOTRtcC9ZZEo2Si9OdFlEenYvc0JYWHU1c0Er?=
 =?utf-8?B?TXpPRFhvSjRkR1VBWERyKzJBemJxYk9XTnJmMzlabUdvdy91QjIwaVJLa2R2?=
 =?utf-8?B?VGFnTGtyMDhacHBXNEFvVGJveDU5TEQ2N245Y2NXRVA0Q292dUlVb1RhTlFa?=
 =?utf-8?B?Qk9OeVord1V6TGxUYkNRSmlIeFBmNDhSbWRzTmhPMmtwWlI0NDFSL2lGMnpT?=
 =?utf-8?B?ODBnaFYrMjdva2Q5andHOENVTXVyZE5lUlB2a2VUMTBGRzJabGlqamNVbHhT?=
 =?utf-8?B?QWJLYjNvUEhVV25jTExwWXpUSUFPZC9xaXdjME9mcWtDcWJjVWdsNjRNL0hv?=
 =?utf-8?B?LzJVeFVRTWJiODVvZGU5VEhmRkJwYTRWT2ZOeUgxbXNRMkVYUi95L1BJbEFx?=
 =?utf-8?B?ZFlMUkY5U0JaRU5sV3VqWFV4N3ViUkIvSEdEaE9HRS82VXQ1aGFzZ1BsSXJG?=
 =?utf-8?B?WS9BUzUrMUNGdVJYT2tldGdzajhnNks0Z1ViVm9jUlJycHZCUXpNVUh5bmQ4?=
 =?utf-8?B?SkNXanNHUmlDZTZVY2tLelE2M1Ztbng3WGczcFQ0a0lHL2FOR2JzbEpyZWRH?=
 =?utf-8?B?S0NqUkwrcGRVQkFYZjZSV3Vtb2ZQZHhIZUlNTzN3MGVhUllRM3U3WW1JNVZs?=
 =?utf-8?B?UXk2OFQ2U0dHZ2lYOGZlTnQvLzVyVFR3Y1RSWUZsUlBwMWQ3dGdub1c2Tksv?=
 =?utf-8?B?K041cVBUamxKMkhOMjRMM055NWVIdXJEeUR6TXZWRW53N0svTHBQalhxQ1J6?=
 =?utf-8?B?SUdjU0ZINnpxUHVNWHZ5WG9vaGJBSUZKNlluRWlyWlN3YVgxRGRJOHN4UUhz?=
 =?utf-8?B?UXUxcEkzaUQ0MEtxakVac3BwVUMzdU51WVpGV2hlTDNORkFtVnpRT3RMRUYy?=
 =?utf-8?B?UGE2VjhlR2hsR3ZIUEZrbEcyUEpLMk5LaURwS1l0cGRHc2NSNENkTDFYeDJV?=
 =?utf-8?B?L3ErWjVpQUd4a2RGK2tGYzFZY20rS3hMdGdobzNqdFhzQ2c2WE1LaGRlS0ow?=
 =?utf-8?B?alJBTmwyOExMZXI5MUhCbURmV3RxaWpUdzVDUHkvWmloN3RaNVZ4Sk0rMllx?=
 =?utf-8?B?c3pFYUkzcVVqeUtWcEdSb2I5OEJ6Z2JCZEM2SUlSNTExYzBSdC9NejRMSG45?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee2e818-8daf-4ac9-ed51-08de3c98027a
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 11:41:10.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sW5+qeCRnlXAVbYX/noKXFQXNaMBPtNtZ++ZoXStr7jY2m9ud+HW7UowCHxH/cCSVZsiTpfzwp38mjZ4q9i8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10185

Not all users can or want to use the device with an iio-backend.
For these users, let the driver work in standalone mode, not coupled
to the backend or the services it provides.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Tomas Melin (2):
      iio: adc: ad9467: include two's complement in default mode
      iio: adc: ad9467: make iio backend optional

 drivers/iio/adc/ad9467.c | 70 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 20 deletions(-)
---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251215-b4-ad9467-optional-backend-23f1099ee4d7

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>


