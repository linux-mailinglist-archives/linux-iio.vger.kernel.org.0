Return-Path: <linux-iio+bounces-5338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C203B8D05BF
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEE128B107
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B50016C6AA;
	Mon, 27 May 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Ww5kxE1l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A815EFD8;
	Mon, 27 May 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822149; cv=fail; b=T/A0iP66kQie7QfhU8RgDeDMVVCAVK8Wir+cxVlMnMbk3CeYcDQFmBhjpL1KEGex298V6NVn0qbseIhFaRj7jrHTO8XyEo6s+EUVZdhWRn2IIMkrrAuY45cmjTFw9DOyDX10iuLDxHSOVy0JlJZ08aYxIeDSS/GEhbeQ8IWG7Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822149; c=relaxed/simple;
	bh=zlTlZbf0iZjuBqsgDJdA5vCdYJpo95T0NsrRnMFG8HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=raQD1ziyJHj1uLRfQCf3A8dAnFhZU/IsMIPzvcVfiDggSgSFmZ3Za8LhCgsGa4p/0mAs6x4Jqw94StmAnYOkCi5swLQ9cfieR1qBLLDmlW6rKPkywV230T5GjST96gnXryJjEnnm6ETeIHH8gv9k1cqF57usFoOIVCUKTnG4fPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Ww5kxE1l; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44QNMW3x007277;
	Mon, 27 May 2024 15:02:12 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2168.outbound.protection.outlook.com [104.47.23.168])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yba4x99sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 15:02:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1SLTpFcOwrl+4Qr5vuhqWS3jfxaGdsK9tLdnMDUDFYpqLLrpSZcFIMwdoT9ewpu6VMR5Wgi0uO5x4bRKY/YE8aajEP8w0qxUw6Gq5VNz3Q4ufPbxwCmUBBSdiAwDsQQPXZD4atJyw8ygEjZUaz33Lli/cqIs4jY/LHrlAWgE51paAygRF0wQ8HcLEzHqfcJ3QObaofX7PMrYv40NJi4sZ4sWfW+LV0XxZdVmOTyoUAOPXwrUDG3aYuCy3vGCGMq/5AOOAVY8DvtbQc61TQ1YqUxwr+hZvQlOm/ioIuTaV4bLbwYEQ0vmS72l7U28mq0oJ9x0odB1cgqzCg1BPzyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42e7G267tqwkuOjm6oo5JP6grr4fjDcXK0iP0IKDuIk=;
 b=Vy5n9II/B+CoRIb9ZgfT7Dso9NLh8yGGhgpOoEhCW8U58PN1fq1+BMz54d8nBYNK0mYb/I4yCl7hjjHngbbeHEC8lhEiFCwAeRALdQSP6eC/tN7AVpRQf9G8x2Z2XKdjrxxOmgw7q7FybL8in6pOvPKsKEcni2sHTn/eiVQpuqrCDVaWXtbulr33rJegTe26+QhjFIlMJDxona5m68yny0ght0Ey0SKdG4NnlFMbZn6R0zwekw0MGcocQHlfnXRz0E2OaSVmr0vFEbVtn8KPopuzJFukUDT5UVcCml5cN4gSYChqes5dtjUt/2a2YtsTMu6c5IF7VASwCe0lUh18DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42e7G267tqwkuOjm6oo5JP6grr4fjDcXK0iP0IKDuIk=;
 b=Ww5kxE1lz49Sj1BH+qTG2NlIICst1oOjvy+asaIrrVhu7qBnLKRn1MS73Pbv3GOIwMSv4bkWCcg/oohVtD10UQNd0hFFWcrlp9yHIYkjjFTKmvSuZbNhHK4JJ/ocrHDNSPvzZSSiOZedA1U5b9TrL7EKDvWlUYO0iVLk+kNrkFPUEDIe9Cuil9PDox35kA1P2cu7+JiWga7W4K0dp8lnZvLwZ5KQQH/+H+W/WhjXLiY4NkcG8hG1AWUano1prGwBbjDWyU3zLxiZE/aRwSlzppdHkLEGt1ARB56L8ryXJB+FDNrEG4kLR3izUjeFp0UeA/rnNVeNk7U0eu+lV1Vheg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OSZP286MB1680.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 15:02:07 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 15:02:05 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: stabilized timestamping in interrupt
Date: Mon, 27 May 2024 15:01:17 +0000
Message-Id: <20240527150117.608792-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OSZP286MB1680:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b84b7b8-f0dd-49d6-b5df-08dc7e5df85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|52116005|1800799015|376005|38350700005|3613699003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?k6Vr9DGJQA//xVkBBjBokijrt2SLVtMI6OldYCatcSq85QMdOC5WtYjVTekT?=
 =?us-ascii?Q?uFhLSYCQIzg5ILqJYoLM/9wB54e+OKlb/z4/lKlodNVBLxQVCGh+9uVsDVIY?=
 =?us-ascii?Q?JG93ZGwo0T2uDNsB7jsmHLFejMsezD/P4iDNpiJ5t38f6NSKh9aFkQots/hp?=
 =?us-ascii?Q?c2GlD4WmathmbAfL95JHWN9FokFiHlLurOegv42SHOyEHatfIgrvSKEqO7Ul?=
 =?us-ascii?Q?WAF5DEr7yAgQAhmzJ/36tr1kvNE5DPP0zFI/dhQmwOPaAD7RcFRw1Xq39OTU?=
 =?us-ascii?Q?K/LHY6FQ8KYKhyuO2m0W/b0Le2eJ8BkQ+bEbzeOil3bnCIlbSEpHFKUwaxAc?=
 =?us-ascii?Q?6/JkPwpS6vHNol8BcgEX1/EK7J5RGp20KtsWv4BaV7thohatFrrDHQD/k7HC?=
 =?us-ascii?Q?+bgeveoRuwpFQTFryZhnH+dGUO2//3MgQL2Y7tKPpcaTPQYNZFU3MIEKoaD4?=
 =?us-ascii?Q?z1DXcm/oX3Pot1FMn7JWM1s/gh4uUlkCJxCPErBaCXjrUQsO7yvAQEQF2Pvu?=
 =?us-ascii?Q?ldYVnRRgIscampx0f3qwZCia+J9Zs+jGAtXPPmC4dp81TK+/lLLBiamvw1sK?=
 =?us-ascii?Q?6hT++EyuwoC8jppLHJPU8/BPf1AJ0jX793O5EhigDxLZy8Lz9XKIWja/MnJt?=
 =?us-ascii?Q?yT2UbumN7aKmnkCDhLQ8VTWo0vyC2hgmmBCTLGsW3lNgNX/ZN7qDsnWT4rz4?=
 =?us-ascii?Q?W7RYwoPZxzd5bKJzfV4G1jmIDwoFv/vE5FbD6kJecJn8EUpkoIkC2WxVJWyZ?=
 =?us-ascii?Q?2UsA2Qe7fuze0dTEUc60JWeyiIsaOm89nG1PbQ1s5bKPvzMKTHH3uHQ/IUYm?=
 =?us-ascii?Q?z4mX6j6a5SL+fjjEPsbLL2Sl+gbN3K8kkL5EVRKOqMCUcWa1nuWlnT1AIv2M?=
 =?us-ascii?Q?iKAnMC6QnCPQHEb1cGGvH5oV0VgVFAoajKxhu53KoJW4xZQpA5HExjqLq3AS?=
 =?us-ascii?Q?9o8fKK0+KABbFAGfwNl+ZNZKPdbQS16gZFTFpRxQE3tdEalhBN+IP07crQQ/?=
 =?us-ascii?Q?YTKZjnrzbId/IFjdX94VDilfpSE4651kw0s28QS4V/bYPzx5WDvsz1SX50a5?=
 =?us-ascii?Q?pCzmbSixD8boClQj0zYXvbSxg1SXKNuWXZffTQsDaVChMYRwlJ3vdjz4VW0V?=
 =?us-ascii?Q?B2Y3aRhlDhQeGnZ6oNUfYEzwZAeHveFjGx/IKM7ogZtM4sim67WBAjcFBAvC?=
 =?us-ascii?Q?0DEsmVeEEUgOcF903e5yh4Dk8DArBKtRz7Mllys3z5C7uyAkIdvjfneka1sH?=
 =?us-ascii?Q?DxzeGuG/f+H9twQYr5ykbRqoXkRJslIgxBhRly+z7VYPewnqtdazbpzBEeHV?=
 =?us-ascii?Q?2SVHIgaeaO2NszgUTnwPbOoHtwvFKiWKBLtF+PhYdeLibX9LBw/WoGItastC?=
 =?us-ascii?Q?gsGqvyc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VR7lfG0pySFX9qbrhS2fkNK99Mo7dZA5PEjH1UBcTijq/ay36aOq5gK/1Rab?=
 =?us-ascii?Q?b1QLkLY+ETgwFA4RpbQq5/76WI764y/6dc5QnZTAB1PFeWc8cTWX2UtnGDMz?=
 =?us-ascii?Q?oPm1m+56aaP4HLt36wHqxUSLB8CeOm9wIZjdS9iv5B7ECq1fDl9xKVITEMRX?=
 =?us-ascii?Q?elLNrB6/1K1hN0zyvSIFLSc3axHh/yISCSnxE4QBz/9dDNYudHVcNAVIuPYv?=
 =?us-ascii?Q?6HW/YqxscATAWcTLG6i9qYiKJw68KL9idLeMl7OLx7MDkpYZPJNW0j6Dt/9r?=
 =?us-ascii?Q?TgTlZG6ygyMHqD1g4ZXFVhPW/LbiuBx9hVtkus4JKhCVo97prAaXQXf20xtM?=
 =?us-ascii?Q?SLu0DzFKy+mOAzFguMqgHAIvI8EnDaO/GTs0gx7AdDJYbyMPSeP9YLYdy1Mo?=
 =?us-ascii?Q?F28rvG/XS32pgfmL6DyjpkCFBWP3BmTIywYMiccYzXoWRl6U5VHYz3AUSl1I?=
 =?us-ascii?Q?yQtuC1sYqNoXqnpz4HZ8gwwRn8Aqjh2HuGrQ+6OWP5roO4KGWMVxMne64VFO?=
 =?us-ascii?Q?8gxBa/h+featV6RRN2DVn0pHhEOFmbzCUnnDFo45iA190pf0y9EX231AybeW?=
 =?us-ascii?Q?TgdDa58Z9cUsit8R0chHh3b/8OhBVtbXWOtPmA3NLskbSOmG5OnXa4XtQYyl?=
 =?us-ascii?Q?Ngvy2LSsgqstGLe0o2fIOdbEmc8rfFrXYjkVMEYkHAPnbJeylH+U0YKxHQ62?=
 =?us-ascii?Q?1EV1YzDYJt+hTShZIbcr4/rYN3Y4aCSlC2l1oxX++fe/L64V/4dHQD3t+QfI?=
 =?us-ascii?Q?Bv0PfaRcGn/E70/8bqd27vU+YaUrejxvmzBCsYdf7wyHT/j2Tk5jqs3JvMn4?=
 =?us-ascii?Q?q4eEbw2Doc6FrVbp18lTMjftoZyGQ3wCLqFsmUgQPkSxeRpJ3oGy3H1x3vSN?=
 =?us-ascii?Q?Ivoc3BXXC2fzltLN1aUojpLLGFX2t/f8ouIVrTy/irFgDxCGEXWR6vNtio+k?=
 =?us-ascii?Q?GPhJUitu2eFGPbNVNm2p3emn3sKG7PQJxBgXMH3TyxsMiqNKNr5MI0G7J/Mn?=
 =?us-ascii?Q?gP1BaFpUmPRRZ7vJvbvnOEfIEOITJt8NruTAbj1ukFrxemiDFI+YMcV1fck/?=
 =?us-ascii?Q?JXwwDCiS+MBoFXkAbOuwSpZpno5jT/GK0l7EhdTfgIO8No9iZGTler9WbkQw?=
 =?us-ascii?Q?FyNXRtIOIreDDkaTvG732YH6vhitFX5NkAw9O05hNM1uBNIeT32pl7ywYY5N?=
 =?us-ascii?Q?C/M0d0LmdzPFguZLPpm5v1+x+CPzisLubQ+EBeRoohWz0XSs8+Pn4fXNfvv5?=
 =?us-ascii?Q?vJLuLHHIw9MUUZo0CdzYdPBs+7KMZp//yOVAmPmC9l4kMwGHSePowtrUs2Y8?=
 =?us-ascii?Q?7tnpvb0FVYPHn13xvXw6Xn0fw7i081t+pChFFTAHkPAlieRzgVPr1s+Vsvje?=
 =?us-ascii?Q?fXHQGbzA/hnQMF4J/7QDpqNes6vj8nmodEvNan4BZFatgMiy6Lm5ihGtKnQq?=
 =?us-ascii?Q?bNPKAW9pztSql5P35X3cKnQfYIAjtoMRwzkyQSN5PYUc8wEzS2yv5x1QT+31?=
 =?us-ascii?Q?IK2Wd5W8aIAJcsfmc3Wx/GwY65nqhfv09uZilU+6v+xJVywU5WsreWJVchps?=
 =?us-ascii?Q?63gwvqSZBhEV+vjB3u+/N0NY9z8aryQB1xMtHyuG?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b84b7b8-f0dd-49d6-b5df-08dc7e5df85d
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 15:02:04.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emBZJnzj4ybaoIKR6ii8r8pweLSC3o34SMIvPjl6XHfGx9iTzrBypVNYd0YOKlJ4emuKS1eK+VhbJvswO582GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1680
X-Proofpoint-ORIG-GUID: Z7dg9PPRjlRERzt6RcbpjzMKYfbZOyul
X-Proofpoint-GUID: Z7dg9PPRjlRERzt6RcbpjzMKYfbZOyul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=834 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405270123

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Use IRQ ONESHOT flag to ensure the timestamp is not updated in the
hard handler during the thread handler. And use a fixed value of 1
sample that correspond to this first timestamp.

This way we can ensure the timestamp is always corresponding to the
value used by the timestamping mechanism. Otherwise, it is possible
that between FIFO count read and FIFO processing the timestamp is
overwritten in the hard handler.

Fixes: 111e1abd0045 ("iio: imu: inv_mpu6050: use the common inv_sensors timestamp module")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 0dc0f22a5582..3d3b27f28c9d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -100,8 +100,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		goto end_session;
 	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
 	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
-	inv_sensors_timestamp_interrupt(&st->timestamp, nb, pf->timestamp);
-	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
+	inv_sensors_timestamp_interrupt(&st->timestamp, 1, pf->timestamp);
+	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, 1, 0);
 
 	/* clear internal data buffer for avoiding kernel data leak */
 	memset(data, 0, sizeof(data));
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 1b603567ccc8..84273660ca2e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -300,6 +300,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
 	if (!st->trig)
 		return -ENOMEM;
 
+	irq_type |= IRQF_ONESHOT;
 	ret = devm_request_threaded_irq(&indio_dev->dev, st->irq,
 					&inv_mpu6050_interrupt_timestamp,
 					&inv_mpu6050_interrupt_handle,
-- 
2.34.1


