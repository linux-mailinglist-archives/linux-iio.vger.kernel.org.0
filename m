Return-Path: <linux-iio+bounces-9658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2275197CB2F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 16:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946E91F22E53
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8619B59D;
	Thu, 19 Sep 2024 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="NMCi2IwC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC31919EECA
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726757512; cv=fail; b=i+TIn7IY6Pul3oWyCUFC8+is/s19Sl/CN6NzdKR+B1KrQPNvMu9nHZ6RuzsITMjaE0H9fxSVvNRQscWKJPlNqoDmgPnO+h75Ai91pBydmjZN6eBF3eDEz9cZiaykM1OPWhZWhZt3J8rRnvLQDF4GLQcgWDAjTZkk97Q4NP07HGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726757512; c=relaxed/simple;
	bh=+0FiaeFee+RAgY8QAXL92AVcGBseHrHO8TQDNL/+ShU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlYUpBWMgsUSWCuZrcySJmVCfZjdjOBaxSS4D2N8eD6R0FslU8chhOUkyYg+04PB25QT4qkRmiO5TlJYic7ULuL2NSJeTBotsk/f3cYHZG4P0apSIephUY+B/xE3/b+78XvCa5OkXKE4evUNZtBMhhYkFm97nr5rAFeUJq+AOuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=NMCi2IwC; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J3Mr0P005832;
	Thu, 19 Sep 2024 14:27:44 GMT
Received: from ty3p286cu002.outbound.protection.outlook.com (mail-japaneastazlp17010005.outbound.protection.outlook.com [40.93.73.5])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41nt89u55c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 14:27:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/RyDu7BoTsSueLCbpoMCKRDKFjoqTIg+YI8NggU8W8BEpk2XAd16CgH+nFTtBbqR0c+8K0Bap0fYg40zkt6taa1S33FmZNKgDa9/U/QcViWE6kbfe0bkUiHf5wUTbI5mwA63AuXgQob+qxgoalqudRjgWlfqzhjyAb1BeL9kzfKRjBW7I7PsNXwW9qS14pNEIAdEId1OfJnaKanV8/ii2X1jqEA9wMbQDFUF1j/EClt0eX89ruQhExoA6ohN01t/AssTrICgTIZaEjhsPx+8BdtO5of86XpzOo4RH17L9wJ0ZZ5YV/9WAvN+HEiYoLOXbXXsKJsgcOrPro8mAEVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCCVlqCmKS20FaZW2s3SpLr9LN838VsxgGFd4RrX0Ww=;
 b=MoUPpatINo2UNvnz5+Y2WaEc0VfUVriQ6M3mcnxJcydyZfK7/oFRU6O960+CoQULK0UF8S6inKf9Soy7TrGEKcBb7zl5tpv17OHUOf2EazUGM5lpdxn9dERF2DWRXBvOvaDW5mrdeO2ZkCsR50io8suiAU5rwRfyeF8/8g/+sqpYnhPzbadcX+Eqr1176lv6ikzX4T8c6u9mVZ9DEd15DTDzXYFovsfYFk5AW6OpBjniajTP1G7bueoz3L6NdFsbqLW9fogz0SzyZErmN5wNmcxado0nAcwi5/vN365GBL8MpqyCvRT8PL7abIz5mSXdMUN8Q+wIb1Ie2C2lg9d76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCCVlqCmKS20FaZW2s3SpLr9LN838VsxgGFd4RrX0Ww=;
 b=NMCi2IwC6K46sqYc9nFxv5BTiCv2rgD3IZNRl5FdSlOXOBvD72cKtYKBrdpfzHDw+7ez2+S8QrzdHeqvT2/p/1lhWm9JJ/YCmwk9cqWi1Mn0wI57bG2U6Ei/MHRNCEowmINfnPIBntHgWcyGVlUz6LwBju2d9ndkop3Q3Vny4bm9aupBZvLU9GPX3HleR7ZlS3tJqhI1jVO5zcNR8IgJG4/A4ReYOvdA66t/z2Y5JHTBectU7/Q5XHAHRADIHm+336NK3z9kC/sn55DHuGqS/E9dVuyFg9BOY+6xbXiTWrgluvi2dI+tYHLXmHcGrdkvxEE0KwMefutKitaFTyJb9w==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYRP286MB4946.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 14:27:41 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 14:27:41 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp bindings to mpu6050
Date: Thu, 19 Sep 2024 14:27:18 +0000
Message-Id: <20240919142719.162431-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919142719.162431-1-inv.git-commit@tdk.com>
References: <20240919142719.162431-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::23) To OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:174::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYRP286MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dcc148-4453-4edc-d73a-08dcd8b73842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dUhFk+bmOrYbeSBc+Uq5YnzIelf46vIKCkkEzs66kkOI7YCCOXNmqgEocRwR?=
 =?us-ascii?Q?R4ugrNEmsff2EX1O2myoZ6ApWApVCNNc+vruUNOR8C4i+MCQlFR63jE9jxuz?=
 =?us-ascii?Q?4viB/gu9ln2mYrpBu30zIMIYiyRppdUgbl0chAzXzzt++LFZ2QqTIDuoZbIm?=
 =?us-ascii?Q?pkBMbuzKbI/JyhCO7+qn5jUVeCnCp/hzY5vPni6txkxlCzKmOPGTIxzIx8K1?=
 =?us-ascii?Q?Le6pxpqqFqzoVLLGvGL6MTDFml8Zm8ij5czsSUtkm8VteUIjiYE/SYT4O4b6?=
 =?us-ascii?Q?NzxOm246LUnTTd/J4uFfD6tne/RrSIXsv3CdeHuUB6yoV6WEWh16yaPvm8PJ?=
 =?us-ascii?Q?dq2k0z+durLj8aEpB4WJYQSnm0XZZ+BNrRPEajwcYau1FN/Xi0OTkBF44As2?=
 =?us-ascii?Q?K/Y4STbG+asIfq/OTFE4ZqNL5/T7l6F+YUoPzqDVFPDbUfqHzN4kReYLNVch?=
 =?us-ascii?Q?4awKXT1Fus6Dg6r6OscFblUmVy+KIb7GWwXtlztxM2NFKcGcrugZabWQCCE1?=
 =?us-ascii?Q?Lm4IBB63Em9OXMS7dkNvdVGd7kMOFXfEGGUxmFNckuwUG8KONOld/n0G2k9D?=
 =?us-ascii?Q?ayCUGKxcGXX/dPA7FAzkzwlk89p8Fg2W+1SNzGkMJis7kET/ayuSsmOwhYLM?=
 =?us-ascii?Q?tWuGuZZWBjlAuD4lBp5auxz4MOdt0U8YoKPFcVal2gKxz5ZXWva4aAxAH83U?=
 =?us-ascii?Q?N1aYHcZhSwEcn4KaN07cqiTjJqPfTSetT9U+Gy3uKWDQDTAr1iyyVyUuH+u7?=
 =?us-ascii?Q?WlBWB/jtX8fHChkufIB/jhxPjgRAb2ywPbvVGwC6fZiS5F6l6KiEep6oMxS7?=
 =?us-ascii?Q?CkLqLHB7YVMntJZHpatt+PXQ6Z6ihYn0MG/F4OT+KwPQRQibH4OD+9cZqV+p?=
 =?us-ascii?Q?xlLzlrbyau2mv04X82m1nyIqqzVXLnjiAfkXqncgjhkSZWck9yG5aJIBE+Br?=
 =?us-ascii?Q?SMecHr50haXwG4IQd03hGbzqBnn+OHH1TXXBtsh8ISGPKM1Q1xJMDS8f5nno?=
 =?us-ascii?Q?YJmz2ebUFQVj/906otwDlYGiiYOljJa9zj5eumUXMFw74SdEXMBCc4bUvr73?=
 =?us-ascii?Q?Q+gDVok5dq17pl0yGnFXJxpGj0i5PoaSJZ80vHKqBB9Y/qvatPYiOOMWw41c?=
 =?us-ascii?Q?Y7arDTLegBSXpRYWPuzu4a4P7rsURgN9IxvuRqszOsGeyvPoJZNZrMbl0+c+?=
 =?us-ascii?Q?dF8H268I668+wHqNbEJ2N0dFIq3mzEH3ERmOZxUnuE0GzqzrwSg/mZ84DT/K?=
 =?us-ascii?Q?MLY+HZZFJIsxfy7fZ/B3l+JJg96HKziGjXurq9hUojCEf7O4lEDuY9q0gV/N?=
 =?us-ascii?Q?H1jBaS5patskLofG5PJy60ZRRH50Ge9t2Feqh7La1Bkz3V4WjvRjHABgSQpw?=
 =?us-ascii?Q?fPdjuNNLXjBAiE9o2/ll5/IekEZ71SVuq+JWBAKwPV9Cs6w5EQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vfj5E9CHhiEZMLjs6n9RGHfjoT747jGBTGgM2n9X6/VBueMqzWH5uSJJ79Op?=
 =?us-ascii?Q?G7sMcw6SIBfHNIT7QWSjurmTSggAyMQWV84hIz79wx2wvBh/olkSpE3528y0?=
 =?us-ascii?Q?4WYcEXFTGHN6kO2t0mtqByI97jQVw1/Dx/ooII5wuspvrC3H095spo27mJrK?=
 =?us-ascii?Q?MiWvKb0PXg7La1IrJDhbTLaDZ5VSFTOafIDyIsyOQ8n39uZcWNNbunKEuhb4?=
 =?us-ascii?Q?DRqIfrDV4Ffi6LLjYQXeMdBS+KJfZw7/cKJunvFXm90W6DxpCKrGweAX3AGF?=
 =?us-ascii?Q?eqgqWLsEM70T26HIDPoiM5VpP+1idR07jmlItLeqxSfOXxInE666QViQG0AW?=
 =?us-ascii?Q?UOldmbtJzrNb0gORMy8rKj3pXed37GQYcwj/tFUpi+uLIG3qatbUVeJgJM+n?=
 =?us-ascii?Q?euMLtBYXpLgEaF9ZmKW+aLajhM6rsG0+J/0hHNHHLkDjD8oi+NgfMi4MshPL?=
 =?us-ascii?Q?uH0XWX6+WMUQZBErtwwXBAy64HkePVDkR11xoMiTb8vyqxGHVvfaIPdd1sBw?=
 =?us-ascii?Q?F3cpxSPwEpTvMtQyebwtTZKeYbro1oWVxmwKB7egGtpnNis+b3wBg5+Gtp8g?=
 =?us-ascii?Q?7Y2FM0SWtnzfmr2gA5jRlF230K4p+nQuL165kc0Cz6yCRAw8W7iOeRCGywb+?=
 =?us-ascii?Q?wWUr+qq9E2tFML8XQYyFlk5Xf/UcHmuKtK784wogscNmJ84RJPkwiZ+Gcpw5?=
 =?us-ascii?Q?id7sMsdZN9/I7tGjrcJbRSz90M+acSoDCzXJDxvKlMvDdIjmmQbXuZ/Dbx89?=
 =?us-ascii?Q?m3ymdshB1JK9UOzsY3k3RILmtCy2nZmMI4SyjoBuaaK8DcpaSf0MFtCAAkdd?=
 =?us-ascii?Q?Uex3QUr+0k2dF6N+DeF0GzaOd8y7SLs8J2m5KMj+ZueErBb3kH2HAUTNnHUx?=
 =?us-ascii?Q?v6RGqMqGuf9L2u+TngbaMJraZ6cNJQCw72nO3y62Pfw2CJ55sycvIKok6i+s?=
 =?us-ascii?Q?jxXiGgrxPkaHntsYqHcH7XDqE0CO2nDsiOJbBd7g1pY/gLcckJia1C5fKwTQ?=
 =?us-ascii?Q?4O9jdpQsJUvd+/N6jbq+UWEUQe+AdjbfCQB55JBDoayUtSm947KUVijcBbG0?=
 =?us-ascii?Q?gq2dNslYs+NJ82iLFuM1pRn98as+jauRq56vpe0m0VZN144FUSAAUfNcGfgz?=
 =?us-ascii?Q?MUiI+YeiafViX+JHL8TcbSXV64C9qNSSgHvKev2BxVYEr5h1X5Nl7I7reLfF?=
 =?us-ascii?Q?rVorNjCZlcwpI+6Qawyp7anFYMPlb4BvylSw+1biY/1881yaNCAZ+nXVkUuw?=
 =?us-ascii?Q?KE75usW76dbfY1mXxQ6zxB2m3cnkPh6o6nwhAb9VychcBbSPvpKFqXUSmugB?=
 =?us-ascii?Q?K1dxDRBMotnzWfYYllpn/wKDNzaXx/AulfjUiBbl3RmZx2k3R9jG9Zmqc9Tw?=
 =?us-ascii?Q?bJWKuk1QEvgmyrNnapHgkMDor6OvLwgxec9IXMFKqDO0ncJnmMSpMz2p7CWr?=
 =?us-ascii?Q?4AoOvHIGMXvi76+uNpnujGXIsi3g/VTtXQM+CPQ3SINds4bTBBgPd/vqtBan?=
 =?us-ascii?Q?fFi1YgUlOmuW3vx08YEYbCfKL0F2uHFCeRWwSO1t9E3pAuQukFHUvsN8v+AG?=
 =?us-ascii?Q?RM3V5pbxjzJoTcHTHnbXNLeaq8bhiUGkEeUUjMiM?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dcc148-4453-4edc-d73a-08dcd8b73842
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 14:27:41.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6vuoqGpXPJYIpmvcxTATyLWRN2q6s3jy+O052HsYM7txHU1XvhJ2mSLFSFcpiJtp1wekdTaVXtIgLHZMnUdDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4946
X-Proofpoint-ORIG-GUID: j6pkrvXxlMcYghD-YAiCFx4wEi7Eg3jI
X-Proofpoint-GUID: j6pkrvXxlMcYghD-YAiCFx4wEi7Eg3jI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190095

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

IAM-20680HT & HP are 2 variants of IAM-20680 fully compatible.
They just have better specs, temperature range and a bigger FIFO.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index 587ff2bced2d..a8d30ef015fa 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -36,6 +36,11 @@ properties:
       - items:
           - const: invensense,icm20608d
           - const: invensense,icm20608
+      - items:
+          - enum:
+              - invensense,iam20680hp
+              - invensense,iam20680ht
+          - const: invensense,iam20680

   reg:
     maxItems: 1
--
2.34.1


