Return-Path: <linux-iio+bounces-11924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE11C9BD1BF
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 17:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D93F285C19
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C100114E2D8;
	Tue,  5 Nov 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HNR3RftU"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2045.outbound.protection.outlook.com [40.107.241.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83A126C0F;
	Tue,  5 Nov 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822924; cv=fail; b=Ul20JI8IYabdvAdI6qaKPAncxPr2MQ8TL7jLZvIrtgIRetQ0SPbi/sGgHhh1bis7uNlxw+JmvynczaC5DCwHj21sg2DuxG+75yGt9qNm/HXIAugL5kLb+2vTQehNBuMoftbLYQVdo51bUSKxZHjXJHY9tDURUahe+rHJFmld/uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822924; c=relaxed/simple;
	bh=TUnlzLcF3+E0x5Mlv1/DCEfdNYA/D2t/mCPILwul+3Y=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tv8bqgGWeTNnAtroCuSzLxJM2mKPkT2Vnme7mCg6EYSs1yVpEsxSM4JbTdGpL8L4N5enh9i4Vo/FwOHT9ZYj4nPlXGIu6I82YTZ+FIFyF8KXsKcZX/VDDjefVxJ0dHoKaHisgJ+0MIULgjlTM9k+R7Y7EqbGJ/R9tNKPucaSx7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HNR3RftU; arc=fail smtp.client-ip=40.107.241.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdxVO3P7b4Bl82oXbJovhQEd8gcB1JrP+8+bDPxcvuUIRhWUDxOPAkfu421vnZAgkorJFeHf5cW2y0HY9PoFiF8QFyKmqnfgt7CMwz+G4i24oTeFLERid4pIrVAsgFE416PPjpvIASRuNhFmwFonxlC91M8gaUJE9+sz/cM9yDIRl9VhMYXvT2B+G4bmPiItMfAPGb2V5K/vGPcNdyGcxwG+D8RUR/H2ixg424kAQg2Jkqz1FSmF7JhV7oPYCPt5G/zVqmQZFXwH7FMfIkrugQ+bjJf2Egp9mQMT+QQiP0wDCbmRpPysf+gWv5kRcAIXGm4qxgrhiZxBiEgu3CxK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14ldxjT79Z9TNU3HWaDozpz+gayBH2SKctJI+DuiX1Q=;
 b=SP/hrPEoOOmBL+r7HJILMKcacBwXgLT3vbe8tRl5p6/r9J/0+UDWh4GrDEtGiCtQPF7o5yr5u4bNmhISjwsvvsvTIJt2V4cvf0GbaID7tKbq4zIxkJTEV+fOrlJNcPkinlps4kzRVgHVhEefC85C2my5STL74Sy9Dqed7nQeSNZzlbxkY669Vg97I5Bts/gf8S9gczhrkZE7BSNv8pfs4Znuh6ubbGJEtERAhlaiMMt/dis6X3aeMC5gdplIchYfbOVrSQTGNYL7okv8wqxOG3sHtyqIo1Pzs+DS7kBA3Zu6dyLvVBGNYe/tri7p99/sLcjQt1ZYjMck4tpaWWGs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14ldxjT79Z9TNU3HWaDozpz+gayBH2SKctJI+DuiX1Q=;
 b=HNR3RftUc23UDQvQCn7s/+QijwxDYoJZjX+s/8NBdbVvVKXhnwYKzwx9efjpmq4l8IO9FeTqpKwql0Fw8AUnRVTL/X8qMNCA0taOQ45wBLa79GWLwotjSpy0xw7UKRV/IYwSiLNSlRiitcrE3xUvav+S9BPlRQcOA9/KK1XSDg3JwCSae4woIL6a2jsx6+qc72FL9/kGWOqmgxHw2U2fU7i2thDbsLfaIl49UOVo3MVfM0I1yek2gNiS/kSXprZIeqfAd3dira+QUhZqprSHJAvkVCx6J6bsi/jJzzNHx+V9OAGiDMRGNt2wLLSYRun6zRP+nqSwFo3CAGgu+1diNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8501.eurprd04.prod.outlook.com (2603:10a6:10:2d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 16:08:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 16:08:38 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] iio: adc: vf610_adc: use devm_* and dev_err_probe() to simple code
Date: Tue,  5 Nov 2024 11:08:21 -0500
Message-Id: <20241105160822.2761261-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5bbc5b-e98b-4526-dda7-08dcfdb41bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tdch5rM3qNVGX9wXfvNU1S4rj5L2OKPuSDPasiqaDWOj9KkSNpHGyJDwXm0I?=
 =?us-ascii?Q?eYurvFIezJxV30W+Rqd6cM1uQ0kD9iPNDooGc4ZUS/kTrc93qaQ1f3lfvIzn?=
 =?us-ascii?Q?NjHC8onCM+oDuyPHqPhATRiEM0acPUA4Iol8bTvJAJqipeMIDOuMBI0euj2H?=
 =?us-ascii?Q?eniacYCk7RmOIWLS8DXSmZ2xUwWwlU72cS0aUI1vD8v7f+BU8titI9/TK4tS?=
 =?us-ascii?Q?VXjbrLame1W4o6MuHZLgcPNo8xxV1GXS3xOyldcGYkE03gZN5JE7YlVIVpU6?=
 =?us-ascii?Q?hfLHRSIfaWuUyofEg1IDJ3peZyUXCww2JQGKj13GXWMFBdtRFIkJ9/TdpWZX?=
 =?us-ascii?Q?pkg6pd6/y6MelwH8svoq/Chz2BWR+0P4/xsaciffeNFwwvM6CR2atSVjPTV1?=
 =?us-ascii?Q?ZknYGEhs6MIUkdS53Z/h9kv7hBEk6j8ecvJhZZ39pPDWH2HMHVfISChPbkEN?=
 =?us-ascii?Q?OUzotHR16XOUzHayEnRfnqkmY2G2ROR0bkAP32qVLVpF/57xwH4V40AyviFH?=
 =?us-ascii?Q?Howyu0nj1aBVAfjzKOXfvQt7d0tJbt9CSnbw42s1/4Hj+ffl0rAYfvbsiJPh?=
 =?us-ascii?Q?oOdRuzvyV1D270cY+k2Y5X20Wm0eVMmx1Sb1vfcPz/YI6+W25eMziMkKFxw5?=
 =?us-ascii?Q?wcrYn9ILxa4kPybtFnXww2HPQmRpnMXNrthbGbqF4DqQiBgcNkLMUqtI6vKQ?=
 =?us-ascii?Q?HZe/mpSrJUUSpuHz0nMdfi/5NB5aKCVFdbrJl67/UkYq8nAs9pe3mWh04b4j?=
 =?us-ascii?Q?UQFgFpv4qzlCJON2jy2O7cfoqQ/O2ljZANAARht+WjiuZsLfhPqFlid7nQIX?=
 =?us-ascii?Q?IPZ44gIq/cFR1Dm/8il+yMTjausMAd4qoW8xXw1aECw3EouFZt7zGAnoBFZk?=
 =?us-ascii?Q?oPlCIJVqMSrwStaumaS5mO4moFovb061osw+Y9UdYMCG3kcND2UmyzcyEuAT?=
 =?us-ascii?Q?jBr9dySGPLxDmhgM5sDRHq6xmk8K0clX+QLK6oJMyZpEV6B6zCmb5oeXpBJL?=
 =?us-ascii?Q?GVbUxfEx77mqUmA5/niYGUmHoBZShnbNR6NQZ/XIsQLxLleTpc2QV21X+xw/?=
 =?us-ascii?Q?UkMBc3mvLbRcHZRCBgm+cRZFOy+VwIRysZcldj8RhphqFGc9CoafUNodFg69?=
 =?us-ascii?Q?hA0HTMN3IKU6pj9Gj3j1UsIezLkG7tWBd3b5JayKSDHzP2HqqmS1r49Wjpo1?=
 =?us-ascii?Q?q8vpO+oAly8linNwLy6O3AfyAw15D7R7HFAFJhdS1rANNfgKmtIScxcTLAV5?=
 =?us-ascii?Q?r97her0OgZFGetEqdUqt4t0q8q8AxaYZqrv14VieXVVvHAYUsByTgP/g56u3?=
 =?us-ascii?Q?VtLNZ+M9/TPUczsTn3oi3hGk/eNa8NIDocL/kCuc3zbx/p5YtNjjTV7REmrM?=
 =?us-ascii?Q?mofGiss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rjISbaO81fi3iIJifMWWDzUqsE+Y22TWhJHmbna+ecILHl8OBL8ozpZ6RJUd?=
 =?us-ascii?Q?vSt3iqM5WNN36ZqSrWV+GCDyGJYT9fHSuQNKqhcxf2/Svgy7Z8I+kG7IlfTC?=
 =?us-ascii?Q?YRZ9vU/30T3n7D/wOhf2iDUh+q6deDAbGmmGeyXx4DQn+cJQooTV5KnI6TaP?=
 =?us-ascii?Q?XGRN7trnOCdRWjh6yL3W/ITP4OSSOzSX0r1PJYyMjKWEVHW823RuWhBXuWJk?=
 =?us-ascii?Q?YqlW2+4qGbiuvyyLuy1OEOl7B4fAdDLmwh21I9N73rcVKvyfIDRFKbnwVKim?=
 =?us-ascii?Q?gUrUWoGZ6Ic8x4WdgMWOA+DDw27mm4HbiRJPuWYYBeycMhcU2i6kvZ65yO9U?=
 =?us-ascii?Q?0AxG79qFEY8/yJC79AMtWFCSN6piqlnTjHO+EWRuEfeA4oZAxOnteOv90epG?=
 =?us-ascii?Q?OqXuFnf8QtJYGOkr+xed65DHmlLHy+eJevEdRvHjmSgYfeq6nbM1JZyvzI7Q?=
 =?us-ascii?Q?Wie+cHtQFraUeOeSeFNZyvq/CdZtRmjQWA8xIas3SuUZ6YUNs/c2tAcpd74m?=
 =?us-ascii?Q?Rd7eArvj7mmOotyG8kJDGEe9UN6UR86nh7qJfD6qHC4aPmKQQRel3Iir5ZJX?=
 =?us-ascii?Q?+GPnnLAOBlq09vcnF2/39CQrM9aTSmdJgP2eroilE7Vky7sswgAhkO+szSr9?=
 =?us-ascii?Q?H4nwlemsL7bowyUzIfSX6zPwVs8JP3zCn1V9QGL7I7Q9D7EpzNpFLuZa2WFg?=
 =?us-ascii?Q?Z5Jd+LCu4KDMbCvZiFr/dUoIxZv19Jxzq5uLr91vj8ocT0FUFeKnhHUKPbzJ?=
 =?us-ascii?Q?ATwVh0zcrtFUAYp8TI8cRSXxWCmLSmP9GDoyDwmpNRYMS457DQBRi5SV54Ra?=
 =?us-ascii?Q?AWVurvGSFKIeDteV9bLrNzVPZz3gue8ksb46M5t+W1AILuQHP0sNUG7VeNOH?=
 =?us-ascii?Q?e99NliBnl5VMqhTpEYMIGPMwBbpZx71Dxrc8OIIQuxIkkCwLxwW8YIL7wfwV?=
 =?us-ascii?Q?1B5uaeMNJAvoGJdWfbvXgLX2tS/GamDsutyX6ffL7pNOvxd2p0zjg3jMWEFW?=
 =?us-ascii?Q?ol5oKvyFxUmNJsgGXZOYFki8HgLaqZgkhnxniQp+5LqCtDC+fZu/Im8ooXbu?=
 =?us-ascii?Q?UXTJ3D+fPaUGdU8ZeoDhqMAbhHfL3tGk/qiR1wFnM30tabFg6cmbu0uyYy/i?=
 =?us-ascii?Q?0Ibpl+UrXrog5tygIxVY0c8yvhEpSqwZyGZ2tTjFEIcfg8biS9f5aWphwzfS?=
 =?us-ascii?Q?yidNaDwPTQTCvQ4A3zPj2Vva/CBQHNO1JYJXJYLsPCbEpE5tD7TZbFZqTO3a?=
 =?us-ascii?Q?vFPQIJf5/lE9B0FwgKYIp94BaEFFJDJHkJ9WCivAlhkEzFuGflTl8K/JxtEG?=
 =?us-ascii?Q?Pytx1wqklGkwIkExgTVxeVU/AxRclFCq8qP5aLlo3jxKTNmHv4HYHW2rsx1q?=
 =?us-ascii?Q?9xZ71YgV6YETt+auwItIMH1PCRfBsJpa3dNBYAUExVtYeC2EpB7Pc1zSi0+v?=
 =?us-ascii?Q?4OzNXkqyTb7ny35zuPRK4jlIVMp7SO1zwfTDskv6sZuPfqih+NiFhBU9t9Qn?=
 =?us-ascii?Q?tXGu5aR4ZokOLTlZ2NaZtHrlaTWTmN5R7Da2Zv+AsLL5vlrcdcSnkIKl0c/K?=
 =?us-ascii?Q?BGiqwNXK3/k94shpRZ+DLSeNAy3mw5tzCxh4Fhlo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5bbc5b-e98b-4526-dda7-08dcfdb41bd5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:08:38.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/U1gZMKjRB5Tc3h4hwp/xE2uKDndHGW11mX17v39IKkWUfnPFSWJ4rC80iZ/dfcP0B7w+J91/6UB626vU6AZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8501

Use devm_* and dev_err_probe() simplify probe function and remove
vf610_adc_remove().

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- add Haibo's review tag
---
 drivers/iio/adc/vf610_adc.c | 77 +++++++++----------------------------
 1 file changed, 19 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 4d83c12975c53..4e737b193c012 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -823,10 +823,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "Failed allocating iio device\n");
-		return -ENOMEM;
-	}
+	if (!indio_dev)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed allocating iio device\n");
 
 	info = iio_priv(indio_dev);
 	info->dev = &pdev->dev;
@@ -842,27 +840,22 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	ret = devm_request_irq(info->dev, irq,
 				vf610_adc_isr, 0,
 				dev_name(&pdev->dev), indio_dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
-		return ret;
-	}
+	if (ret < 0)
+		dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
 
-	info->clk = devm_clk_get(&pdev->dev, "adc");
-	if (IS_ERR(info->clk)) {
-		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
-						PTR_ERR(info->clk));
-		return PTR_ERR(info->clk);
-	}
+	info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
+	if (IS_ERR(info->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
+				     "failed getting clock, err = %ld\n",
+				     PTR_ERR(info->clk));
 
 	info->vref = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(info->vref))
 		return PTR_ERR(info->vref);
 
-	ret = regulator_enable(info->vref);
-	if (ret)
-		return ret;
-
-	info->vref_uv = regulator_get_voltage(info->vref);
+	info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev, "vref");
+	if (info->vref_uv < 0)
+		return info->vref_uv;
 
 	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
 
@@ -879,52 +872,21 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = vf610_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
 
-	ret = clk_prepare_enable(info->clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Could not prepare or enable the clock.\n");
-		goto error_adc_clk_enable;
-	}
-
 	vf610_adc_cfg_init(info);
 	vf610_adc_hw_init(info);
 
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					NULL, &iio_triggered_buffer_setup_ops);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Couldn't initialise the buffer\n");
-		goto error_iio_device_register;
-	}
+	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, &iio_pollfunc_store_time,
+					      NULL, &iio_triggered_buffer_setup_ops);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Couldn't initialise the buffer\n");
 
 	mutex_init(&info->lock);
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Couldn't register the device.\n");
-		goto error_adc_buffer_init;
-	}
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Couldn't register the device.\n");
 
 	return 0;
-
-error_adc_buffer_init:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_iio_device_register:
-	clk_disable_unprepare(info->clk);
-error_adc_clk_enable:
-	regulator_disable(info->vref);
-
-	return ret;
-}
-
-static void vf610_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct vf610_adc *info = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	regulator_disable(info->vref);
-	clk_disable_unprepare(info->clk);
 }
 
 static int vf610_adc_suspend(struct device *dev)
@@ -972,7 +934,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
 
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
-	.remove         = vf610_adc_remove,
 	.driver         = {
 		.name   = DRIVER_NAME,
 		.of_match_table = vf610_adc_match,
-- 
2.34.1


