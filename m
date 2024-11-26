Return-Path: <linux-iio+bounces-12709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3659D9E1B
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 20:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE47F166A25
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511F61DF24F;
	Tue, 26 Nov 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FHTKmzMM"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013067.outbound.protection.outlook.com [52.101.67.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3D1DE4FF;
	Tue, 26 Nov 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650806; cv=fail; b=IlPj4hik1ADzdRsl8Wmt6WDWzQFZv5BhQQsYAGG7RD8yqFd1tLS7q6bE1CDx8b0F82Vn0EobuNtsnB8Su6+1KWubQgMxlPHjlQQMWdtKE26kerW3wfKBe+TkmZuR4kfaTX5LzUOdsgZQ4IndXQWWA4nBQW2A7l+miWmTTdXm9xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650806; c=relaxed/simple;
	bh=tOE4mKNKmtBMV8Pd5B17TXxe7OglzDV32QGTf7E8ONY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QlM+v6sMtQuxN/TyesUqKyCEwb/nbu5e4mkK32uRPULvcBgY1XLAAWanezU6VuVyXWgyM9MSCTF6GOGRHYCwk3aVn3gnLsbb9DT7ukrBL5V5/LfuemPGH2rgg4dzEh+aQ+Xg9Xnwd6ULw+9UxvQu3XRwaZDo7OPbuHq6ufKxm/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FHTKmzMM; arc=fail smtp.client-ip=52.101.67.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4+Ta2dtpxrOEUxdnF5r6F6VilbqMO3WCV35bHuBSQS6fLNSIvX0EPNmfayHHPnIxQwVerPdRw0k2CRKE3liLTz6QrQHIdj5XN3vNmGCvJ/+f5Ysngyp3lHNWXcgW1wh/blEK6iD2EvFeW+CbX9AJ1orI0ld9PZWv5kecTQRoFB2vIeOaaWt2E01wcEV8ygw6VGKxPZR3JobNLB7ZAHAlhgL3KTWwl8XUM51iG4+dBZFTUIHMEyif6ts16hTaPcU/yL5rqaZqGlNNkjngq7ZsWyXlKyJuot4mZV/6ZQA6Y0HHqEbCXwcPiGpPdnFTb3UnzlccOtKNNUOC8GvGbcOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pHt8SQC/5gvZR+hq/9Av3RdAaPl5rvqKVPZbK+v02c=;
 b=OnLaTNzEMoFu6oh1lJuY5b7SFUn0n1Vzd6kcZ/RDT0x6yACOBbjOrpduwu5zaQT7Mj0al4N6KqhUGyWqWQQbSabTCKV3yy6iU/yz+UgmeSfSo1tKEeKNrFTJOh6zVApR8SNYvxSBzdcsomosspYT9ssJL6IEILx+J9J/kz4cDvgrWugbEooWmm2i6vDdbj4fSFL23X999360jaNDk8Gfwg+mbhPgOmw4JnesRiWlFYUZOKCx7fPUHderLFAu7vr+WzqhC9kkbJF3KVRGQALGhx7US1z6RXr5/wn7YjxTjtva1sGZu2242QU8QAjOtJr/hjWoLS8dY2WfnU0U3EHpuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pHt8SQC/5gvZR+hq/9Av3RdAaPl5rvqKVPZbK+v02c=;
 b=FHTKmzMMCj2sBdfRwLo6nvm5wpPqxSPgIWwCnNQcZoaL2WjyXxcEBvXU9QmBL4SEsdQTV+aPCTxduKDLEveK/8Pvb8a/X87y0EQFcUG3u1G7S+IN5XCxZz42zNWQQ9ETQ4fyHbzh/JZ8h/PHW6HqOei/Meypu3QqXT7zBM//cqzh98XoeRNHbOimmbQm21uvFOnrnM/b36aIc1Tp6Ydjc+zsQcb6pbqpxs0Sypn7we00Q51qYPYRvbmsC9yMSas4aNIRLQ1YFXngn7wX+nPjlN2+fCOW4q6vvzoxC0zhJ2HDkRPWujcH+Bhj35wsy3oJ7hDuHjdi1PbcTH10UUScWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9831.eurprd04.prod.outlook.com (2603:10a6:150:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 19:53:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 19:53:11 +0000
From: Frank Li <Frank.Li@nxp.com>
To: jic23@kernel.org
Cc: Frank.Li@nxp.com,
	haibo.chen@nxp.com,
	imx@lists.linux.dev,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] iio: adc: vf610_adc: use devm_* and dev_err_probe() to simple code
Date: Tue, 26 Nov 2024 14:52:55 -0500
Message-Id: <20241126195256.2441622-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8bcdac-fd0e-449c-b9b5-08dd0e53f500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pj3gGeWvpD96kWNm/ifq3m5LYFbPv/beL50GQr9r8oVJObzSsAuGydZN9AtU?=
 =?us-ascii?Q?xc+dja3kSHf5g84BfW6bYK+uSCvY3PCyKOVqQxDw6WMxwR9xmFEcRKi7edpY?=
 =?us-ascii?Q?c6nCl7IX8C+87pQpltzI0bkYr/QuxN0MgQ25ZC+CtAyjJUctBSCo/TC66Qww?=
 =?us-ascii?Q?N3dUG4YQBSgRcU5m2Hc/xePgpA/33M8xWOaBp56JG9HmK0+p7jkFaHfjHIzx?=
 =?us-ascii?Q?Ix84L4/TCF5LlfVVhiNSzhjw+MhOuriVniR1VTD327uJ/KSuJ4UI4IVDlqN1?=
 =?us-ascii?Q?o966GyBemZ3ErDL3pbpZSxYd9550yQTJCfFqKljeX8RMiRMYTq6WoOogW3KX?=
 =?us-ascii?Q?ODEFcG4LBIPOV8YH2M0DTovpcUKIssx1JvU+Mko0dvtFqwWBnKdkHF2AhK87?=
 =?us-ascii?Q?J70OwFcv2fdTZJVeEo44l7X9RZ2mnpyYwHm3+KqeGSTnGy5cFQtSwU15aCIu?=
 =?us-ascii?Q?HaJBkBev6knivKPOT/FJpP3SXyJn+9LWb2xydcakiY1oHeFvPSQ+k2EH69Zk?=
 =?us-ascii?Q?oyLzNLmNmDfULDb/aW2TfNd6Fy5wL+zT6Jl1+s3MdIYBa+52YKmSpvWg4SZl?=
 =?us-ascii?Q?yeT8rnyZfQOQx/RCNXbjBEYqCpsuN0Oc9rzHfv6iSvDxk93rHNKpMrUImF2p?=
 =?us-ascii?Q?vaJyxYYqayN7ubwhzEUoBtowo8Wnf9J/kgwDiG4xzNGalZ3+ftgPRHqmbO5s?=
 =?us-ascii?Q?8Zjq/5iWBqbcvwN5Qad0YLDcPqQ4gV9LbO+cv3brMAStRKkR1E6tgGaUkXVv?=
 =?us-ascii?Q?tzewsmqEWG94FnnpNcs4K4y9EbwZS1BFpBUMasZ5R48Mg/h4MqTCo/WeQL64?=
 =?us-ascii?Q?C924frhBqjK4ygSBlNaDnCpPeZho4nGkkWFkcaum2vYN3m02oMfwwnSfhoyn?=
 =?us-ascii?Q?LUGpkPypaPam7PkMuSXzef2nAEWQc5/tIAZTTaHw3Pr8OYdJwPgOSh0nUECE?=
 =?us-ascii?Q?thjHs45QNRkAkWPDc8NZuKaXONdN9AtChcfNVxhaw9XGhylEdf21Mohs6KhX?=
 =?us-ascii?Q?uyQnbuRzNcxKKfDRVVt6lxPXcQ7mzbQT0psYPe2K14+0Q9mz4JLA2YC0qQNT?=
 =?us-ascii?Q?vZwkpwpBJBjEN+kTDpSbdKbodxQr8VU6h37sVn8OgosvAeKaZmeyN+/wQua8?=
 =?us-ascii?Q?UCWlWt6k5E7Kc9wTsHPs0gawhWXaoJiOcvr48mpeNQZXeWTd3pIsndVFeZJ9?=
 =?us-ascii?Q?SmtQkuVm0KRRvRCFFvCWoHH/7KVa4yU1rPDKEshf3Gib+Ue25yQ3fwYK2jG0?=
 =?us-ascii?Q?JS4wpSJrIUSZC+cu7MAQ9IrG6Zd/RQbhWmd9V0qnyIumqrF/X2aFiiPSrZP1?=
 =?us-ascii?Q?GHCYEtihOhF7XGM5d/vTyd4lj8V0S6KL5+nMNmRLch/N9JegMvqaEMZmyniM?=
 =?us-ascii?Q?ki0/N4UZEEHgFpH1uxXl8qp+0utepf/pL80yTPrObsOEyHNOOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6VbXrJ1PLr8Rg+F9bTCiE8sPOtVueovVEmZ76RwvsRFxRhYoQG6VII9E0MVQ?=
 =?us-ascii?Q?ImCjmtoPK+q99Jmlpnu7Srth13aEvGxvZz6tG+0hwvmUXSTgIfGjMOoireUP?=
 =?us-ascii?Q?T3QqqEagnvHl5xfIrRddAtloa6HjtEdE/U0Mg7Nbxwd8RTIhvboZzQyszHuv?=
 =?us-ascii?Q?ZNASdLiSwcPFU2kf1mdDbhx4kWo5mW4BoSWPlfeCxR3lT2p1822hZUp6A8rI?=
 =?us-ascii?Q?AeQPB6oJRphtzuHZNKz4fLTwrEmjeI76HUS2pizePO+T6HOploQPAoH0aJqB?=
 =?us-ascii?Q?ARFcONWFvwCNVXrvExJxwXrFSRTo359JCQqfJDxdOb4fxpYZT2DynD9iEwG9?=
 =?us-ascii?Q?cLWi9eRPxDvbP56L5gYr7hU++chdlQyFQENBtT1Vy5STtO8fSXoDQWqG60+E?=
 =?us-ascii?Q?JoWQ7eH135wpXfvojkh8bE0WLa7hZbnu1B5glf57unxqenJxeCa/sj4yfQfI?=
 =?us-ascii?Q?DBuskhysOVbucRucHAx7A9NhNpPDr4eGaazfMxxmIwVpYlpQkgyT42CkmWO2?=
 =?us-ascii?Q?F7rgA0oPDPVirzjOzTEYuM9GHln+uWS80+34Daebv3yrL/8psDURFUh8D2Pn?=
 =?us-ascii?Q?JnXRnNl2FVdJIovI0lE+IVhragsYe9Z6uRjsKDyqVv7OrGgPoxqEupoUVgbd?=
 =?us-ascii?Q?CGtf4SoxDZ1RqUTcc6Hie3iCiNoNLPKoL05uVMuvb7lDNt9Vr36cY/x25e5n?=
 =?us-ascii?Q?FaWzb1nNIb+U9pHS/Ttvv126lSXsEckTqsZaIRpG3Ab1/wIDeDXXYd0SuqZu?=
 =?us-ascii?Q?NEOCl1lXGhjWEavO++FfdVGlA0kHRkoaLH6xSsv+OadqK7JzzKjI0Hudj/bz?=
 =?us-ascii?Q?EXvvraZi4jGyMddMXLqJCzyuY38Um/0HolJ7L+0TEPn63ZBMF900mz7r9ikZ?=
 =?us-ascii?Q?WsyTXzCYTsygpZFyhcj6dfbxx/qsGzcWC0AxMBKqtNlx+N/tYw4U7cKpQKon?=
 =?us-ascii?Q?tO6EYdBOOTfYuN1K4oaRTu3NrXaQPOcr3EzbELWhX7FD4CcOOTXzU3lXMFj9?=
 =?us-ascii?Q?0LPGUFmlpT54WG9AbIbVdtX8yZwvIxLm0MKoXDO+f59zGBVcg9AKGOOo35jU?=
 =?us-ascii?Q?ql2bvCTVFYhAWcnARUgi/xP6KnRl3syHV5XfLzQRKoL8bCV1GxB9DKGE4H5w?=
 =?us-ascii?Q?fGp0J0g6pCWwOJzpyKuav1YyGAhnAA67CjKGH7+jAkVv+ad9Mrr8GPHAJ2+o?=
 =?us-ascii?Q?1A3JQbp+xijZCUF7zqPCVmOqG7NXNnsiiHe5QKzb/MbBAVZCtYP3Dcbufmie?=
 =?us-ascii?Q?oZU/olNM0H0+SwRJklXYTkXq3IFBIFsk0lKmGNl+R0Wz5JlKqqyqe94Jtcnw?=
 =?us-ascii?Q?Uv6qZdRcASWfhwDKS0NyakUP3KoNMaH7pDZarR29+e4PykdYwRq1EflBfyhp?=
 =?us-ascii?Q?ogPvEAgjw73kauE6OTQoPH/22obr+pq0bVQXjPkcCbJtBuLyGs9dywHw3Tae?=
 =?us-ascii?Q?Qxjy4Lfx4AFnpN7oZxXHSDHTVz2/3l+M+r9tXPxGXGjqH9c5Wdbc8j7mPQXt?=
 =?us-ascii?Q?vrjnfomuELjMJ867ZePhJCIyfm7qnPm6PMz8b6S2sgRev6alrN4NVcJY7yOb?=
 =?us-ascii?Q?oJLa3QUqcm6KVqAUutxyc1X+VFrGecQAr69YS2E2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8bcdac-fd0e-449c-b9b5-08dd0e53f500
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 19:53:11.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9mfaFQM0qSl4zzvEQKt8QzJgnl0QnM3gXA/+RBkGSzqY/1+UYvPLPbguNMXOoClFxHtPbVkVCGLq1b9xLA4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9831

Use devm_* and dev_err_probe() simplify probe function and remove
vf610_adc_remove().

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
- Remove vref check in remove action callback

Change from v3 to v4
- keep vref_uv as u32
- keep original regulator part and only add
devm_add_action_or_reset(&pdev->dev, vf610_adc_remove, info)

Change from v2 to v3
- change vref_uv to int from u32 to fix below warning
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070633.NIrO7Ert-lkp@intel.com/
smatch warnings:
drivers/iio/adc/vf610_adc.c:857 vf610_adc_probe() warn: unsigned 'info->vref_uv' is never less than zero.

vim +857 drivers/iio/adc/vf610_adc.c

Change from v1 to v2
- add Haibo's review tag
---
 drivers/iio/adc/vf610_adc.c | 78 ++++++++++++-------------------------
 1 file changed, 25 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 4d83c12975c53..fb7afa91151f2 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -814,6 +814,13 @@ static const struct of_device_id vf610_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vf610_adc_match);
 
+static void vf610_adc_action_remove(void *d)
+{
+	struct vf610_adc *info = d;
+
+	regulator_disable(info->vref);
+}
+
 static int vf610_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -823,10 +830,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
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
@@ -842,17 +847,12 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	ret = devm_request_irq(info->dev, irq,
 				vf610_adc_isr, 0,
 				dev_name(&pdev->dev), indio_dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
 
-	info->clk = devm_clk_get(&pdev->dev, "adc");
-	if (IS_ERR(info->clk)) {
-		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
-						PTR_ERR(info->clk));
-		return PTR_ERR(info->clk);
-	}
+	info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
+	if (IS_ERR(info->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk), "failed getting clock\n");
 
 	info->vref = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(info->vref))
@@ -862,6 +862,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&pdev->dev, vf610_adc_action_remove, info);
+	if (ret)
+		return ret;
+
 	info->vref_uv = regulator_get_voltage(info->vref);
 
 	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
@@ -879,52 +883,21 @@ static int vf610_adc_probe(struct platform_device *pdev)
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
@@ -972,7 +945,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
 
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
-	.remove         = vf610_adc_remove,
 	.driver         = {
 		.name   = DRIVER_NAME,
 		.of_match_table = vf610_adc_match,
-- 
2.34.1


