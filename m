Return-Path: <linux-iio+bounces-13767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1B99FB9B5
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 07:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C881884764
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B47F154449;
	Tue, 24 Dec 2024 06:14:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020133.outbound.protection.outlook.com [52.101.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337E219FF;
	Tue, 24 Dec 2024 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735020863; cv=fail; b=XsOAE89xpfAvbjNtDrOJbim/yxGrV2R7e8ojJ1Zyfr2tiG/sQ0k+v4Z02nADqlvSwGee74rT2F643cxiPFdPLcXdjHGmhqW4j6YopKlzfOA8tz8HIUc6ry93AiqApLJ6AkIPSh9xr/fPCdyUubXI1MceIywQuVP29/DO2Z8U2zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735020863; c=relaxed/simple;
	bh=eQWJvSVOa4B/I3KXZ7cLnEgCzP4qPki6TZqo1sp88ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGDd5515fzk0cYzkXN1yPL8b47gwYEn3vwzlIAep2mKxbRDQT3q4jc3GZ5MFSoc4PIxijJ3dJAGeUT4rCs3zsVuOMXZ4kgC/eUS9cQNXaXgp5+sB2MRuDs2V8xJ+GRgm776wa6rll4X+zYHAyw/7ehW6HOfUU6ScyjHAhJyCJWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgY87php/vez3kIZ8TVKFzE9ffLV91ewPVhB6xJ5ZJgV42KUl9GYG4JhnYR0j7rpYB6gLDn8j/BO3/vRd2mTt/C6IN/EL2q0USaPBpNtj8c2ZcBZPo7TvnSW4BAFv037JGmGKXNjBqeuKgD8eXjte78Ue6dUQqWsLNqqPV5webpltlicd4FlKzGJYZrO88QiPCzuBWFfKR1ocTjFZYZyu+/gZoReirmJLV8KDRuKKJgCslzkkkK2KUKw2UCHWy45h2hRPqd3S8d87oW4ZLMPW/vmvIMNx6wUkJnfX+sDYpNql755FqDExHF2pU2xsmbNn3Gt7EY9gtQEfk2iaAAMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwTYPynRYDrE6iiPij+GI9Fwq/Kq0RJu/FGXPxVMXjo=;
 b=E1UYPWKvPQivgASAfbX3PLHLUZykfKWSPzL+5/abAwoNRtvjuenGJpmq/9ahNc9ASukEL81lv1qvb5Yzsk2R01+fnchXQuBfNeTpmG2a+w/Nmr/nL09EV7oqDtZT2kV76nq/3uqZMxGdIrv0byu3mEK+FRVhpx3HkAUqt6URuvVFjAIWTyhUzX+OLqf2Z7q4gCVNCi8o81AnUpavjjxjs2BO3TkatkmaYGz1aP6h2huVLEiM7DD1cxhWUHcRsWqzdlmUeSxQOzmsWSdqcKaUpdfTYKno3LYVuvl10+XokIzwk3ieVAbQwRSjzBJnppKWM/mE8bWMckJV91M4e8AcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by MA0P287MB0331.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 06:14:17 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%4]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 06:14:17 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: jic23@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andreas Dannenberg <dannenberg@ti.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: light: opt3001: add compatible for opt3004
Date: Tue, 24 Dec 2024 11:43:15 +0530
Message-Id: <20241224061321.6048-2-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
References: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::9) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|MA0P287MB0331:EE_
X-MS-Office365-Filtering-Correlation-Id: 1200a068-4061-4ce3-8dcb-08dd23e232ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DHAFTUGrJSFC/qwgdn6jNu93yg8I1KW9VNtxjP+hJfZugOFKNJs+byhOLOJQ?=
 =?us-ascii?Q?oAFO8jiFC8yTP7ZtNUpu2z5yASlKcAAZtLWrTs7tmpNUVSCVkkGLQq63UYWv?=
 =?us-ascii?Q?xtW6gNjv1aGQYg9rhl2zZfL+ElUwoe8DgY+QrwFI1DVvg434zQfRAWQxR1rx?=
 =?us-ascii?Q?WL2CXxJ7goPpHOXvJlICem+/lFTCM63nQ+70omWReZzu6VIw91X85lVGcwUh?=
 =?us-ascii?Q?onKCRZ/O69REhpWRe06hT3eTMcBC+RSpWdim4RbyP54wmp9UfoGKWqbvuhPT?=
 =?us-ascii?Q?KcwTvn/g+CjL/xhL5lTODDYlqRLC5BTAVGkJVEKlCCt88fPGXQIOcOUbB4EB?=
 =?us-ascii?Q?ZrzfdN10MYqpdOB9er4saPm5Z94aZUdWSidXBjRZKzHxh+OtMhzv4Jd+IgCQ?=
 =?us-ascii?Q?cXwyLctXAgpwPx+aXM2OaPypTMVAVAc+fSoY1Q4LhUxfDvQ66M5tbY+DJm5f?=
 =?us-ascii?Q?tlYyOIF/gVa9NMhwPjqP5v/bH2z3It5oSXSm7yOIk8VnV7HAsOpyJl4G/gvF?=
 =?us-ascii?Q?KZT/wR/9/F0QBdqGmFkyiivtpL5Qb0t6A08w3tLtMI0t6Eay5p4zhrQUU4yj?=
 =?us-ascii?Q?P6m8jFkz0Ayt2tB+lhvHFRw7Ekit+gPHl/8vwqB+xdJRaeLl6URkNApd2vpp?=
 =?us-ascii?Q?kSJLj0teF60jiY8Nn7ZrJ7eKz0qpElvCC7MqYyrWKKtaI1dVUCNEXeq6W4Zz?=
 =?us-ascii?Q?0wDrwIFgVlHuvl4j4qtcVot7rqmewjZvF95k+EG02pkoenXRgeKgmlqDT+CD?=
 =?us-ascii?Q?y5F42QmBbZv0z37PHfzsxLwzYezazadwz8eUT6bwe9JIicol6zTP6mkDX2bN?=
 =?us-ascii?Q?Dg8ES8PkoqZFJY0T8E4yV8A9EXsCoq76THw/ZFlb1Lf2q0ZkmSBE6T9kXur5?=
 =?us-ascii?Q?/VG5Nvk7x3qQiCvdKmzf2156Mkvp8vyOVduNDPRa1d53i0/Ot1m/s6HU7DrC?=
 =?us-ascii?Q?iYzBop7KjoUAsBNiusIJD6Xvpr6W7a0froKb/qvrakcciNPsGVE2kXlRGWjS?=
 =?us-ascii?Q?ofTVg1EJIofSybHigyvKZmmYGOXgg+v4WHiWtBbI2SzJ/4waL6qxdosFsGEn?=
 =?us-ascii?Q?cRNa6fSeGKz0ezTfStUb6iuOpLuQoSqsJvrNGNyyhhdZm2i96IvB/i5WRk0T?=
 =?us-ascii?Q?6q2Yb6MLcKoRBzRyYGd5HpEMrelR+gQjOyS/jujU8rZN4zgBOPzaTzrdJWsj?=
 =?us-ascii?Q?qY34lo56Rj7kKJMfPPP4j+el2F0AIqbRLF8ta7zpKZZoyJ7wxZq7TSaolEnv?=
 =?us-ascii?Q?je80We4PnDo6HR5f1c0AomTa9srlRND72hj4mfpWXPh03bGxOM9eq1cyWeZG?=
 =?us-ascii?Q?dZfUq9B0KwhvdgsrZa1oULUuicYxtH/3q9xlyQEldXccN3R44vspk/wAtJ0H?=
 =?us-ascii?Q?bId8zE55miccrlMP2NAmuFkeXLzFnYnexTo/V0NaiG9zVCORalsMutIXTknW?=
 =?us-ascii?Q?Xpterc7aI+Ka1dE5qLH6KZXIx50yLT07?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yKfueWJQaySEEkvg5e2yEfA0hY6jzkO9IPeySlhyolM82wlObi7+5L/isgzW?=
 =?us-ascii?Q?fvbWKADpU8ZQRGejeota9HBSZ5JT7gLZGzdJnjIl2yw1Xn6I4I/pR/kG+MbH?=
 =?us-ascii?Q?G/Pgu6p8HH+hwJvC2pDwj3+ZgDARpaBVrpui89MTdvl42hOdbbRoqZqzTBWp?=
 =?us-ascii?Q?zh2uq1041JrBww/VS4pPiebIAK1+1AWLF6/QekvuMKZWNkYh40dpwvj38eFc?=
 =?us-ascii?Q?XjKJoe4CrjnRCx1vzxDTO79NsP1TBKvOLeQq+AF9FTvN0iNxx2VNhVQv83/v?=
 =?us-ascii?Q?kr1vlw44RpidGNvjtq8NKxxdtl4ALYhFxlRHzrRwa3YoXTIyzk36q0I/blso?=
 =?us-ascii?Q?/RNiCSVp5PBhHqXpduK1YWq1Ryvtv3vJ42hYMxuxYCWMeXwNrqicCZnZrShq?=
 =?us-ascii?Q?Jj27sFM+6nHcR8BYILA0liCgVViQlunnykPO2ARqG6ipOl+SYxXoGmBGVIHZ?=
 =?us-ascii?Q?X+SQdLKzR0Sgo80sJfe6ffq+DCnvQAwYk1qpHWeCZTGcocnBx/Akh4HLwSE2?=
 =?us-ascii?Q?Ie8qFO1QxC7vAGQkelmvjaMjgToU+1rlDf6PPE9MlYOx4IDb0i8vKX62xkjs?=
 =?us-ascii?Q?0Bftpp5nqBnhVbHHsv1smClzl2arkQwEhXsepe/dYqtE/MUA44HCcXq+sYiS?=
 =?us-ascii?Q?XOiS1gIfCPhdQ2h4wCKYoNxzhmKirTNIpGfcFwdFMUFLmGTd/mXoGfOSBOgv?=
 =?us-ascii?Q?kk5+U0Ap84Y4DHmE5QZuMLIiy4xzt438CW/Vkxk9KuEVM27t8G+lGZ4uJP5Y?=
 =?us-ascii?Q?BUecpg8879Q2wTJCyDwW0ErgIRnEsjJuj3pSZ7b7rkq6d4S6blLKCXzoCR5p?=
 =?us-ascii?Q?q/WJIBloBmOOG+CeE6fwmzbWtJdFbvGmqDTjh5/tDKLzFOyxl22yKmZgPj4T?=
 =?us-ascii?Q?gsGEw50RVd9bq/Zlv1xGJ2q3bC7eZI+xAnP77RTE2g9FZ+d+sttwG49rgkJz?=
 =?us-ascii?Q?BcpWARhv1B9Fq6olDSaXWu9+HygdxjBW5HwUZvCPZr5JCQ8keUbMzi/y3CoO?=
 =?us-ascii?Q?hYWogLXcOqf7qQUwPJ7PzkA68gGFoNR5b+vQD5OxDrz4tfF6XYTmsDLWyDZk?=
 =?us-ascii?Q?+VyUmBxRuSimqpO6H0ZBREApa6nEYBR1fV8g9AmcSx4aTiZyWU3dkuFmsZ2H?=
 =?us-ascii?Q?VnwdBiXaMxIaUUfsz8AtLM6tS5RRSgATJ8z8DOVRqHoCoVnVsWYKojQ1Kkof?=
 =?us-ascii?Q?Tbg1F80ZXjNZnR4/vvfmaliEy13nHwEly4/F5zoiMQYUk96k67QnB/sk18G0?=
 =?us-ascii?Q?R0mY3oeZtE/ecSem3YRN8/nAET0c3TBCobIb34DqnIK/eqr+Us3nXqItlHjh?=
 =?us-ascii?Q?EPqJAXxIbxl8KNProIL1uWTjm8co8zsFVjKxgCwib0ZUmLiZAETiuR8W9S4O?=
 =?us-ascii?Q?DSMNKlReEps24luU4dDyPVjlev/S9GrGkHyo7lB9zfrMNJ70WagytQG9YgN4?=
 =?us-ascii?Q?6RvVIRqV/9vYzgUMEpKXHd87/6+MUVOd3D/EHDKr85wbiZmxyR5fTQVJeABr?=
 =?us-ascii?Q?OS3kjN95m7ogUl4iIqaB4MYikocOX8BGJPJjPQdQZeudRNQ2RiNPSoqME76V?=
 =?us-ascii?Q?owVBlSm+mDWN6RHWtZRowiytfaW6rKiSciCHcDnk0QV41wAEVLBwF80BbWIi?=
 =?us-ascii?Q?pyvs6m8BIcQcckELtOSptqg=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 1200a068-4061-4ce3-8dcb-08dd23e232ae
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 06:14:17.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzuU5Ug9p81eWicufNDsFCRRzoOO0ly98tcgoefGaIwKOKeLWfLrce8t+qMfwZ5vxMA3B+JsYXtuRM5KKyWpX6wP+UjhOTOsxTboCJDP8rXctfKXq09eFyEJO0yFQsQB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0331

Add Support for OPT3004 Digital ambient light sensor (ALS) with
increased angular IR rejection

The OPT3004 sensor shares the same functionality and scale range as
the OPT3001. This Adds the compatible string for OPT3004.

Datasheet: https://www.ti.com/lit/gpn/opt3004

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
index 67ca8d08256a..05b9a4f510bd 100644
--- a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - ti,opt3001
       - ti,opt3002
+      - ti,opt3004
 
   reg:
     maxItems: 1
-- 
2.34.1


