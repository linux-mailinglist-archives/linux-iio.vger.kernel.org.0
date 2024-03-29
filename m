Return-Path: <linux-iio+bounces-3922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60476892161
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 17:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921A11C258A7
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5678A85620;
	Fri, 29 Mar 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="ozpikqb3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4E1C0DD0;
	Fri, 29 Mar 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728939; cv=fail; b=CY4q9usI5h2xPAq6cyrL6Qixa7H8RfhT8MisuXyb4IQP4iNLIyyQJWrD8PLvUvt6hO11qKhzbgO3UtAaFPoW/YRrykI9L7VliIWn3gsydU/uSNx2gROGrx52WUaHTk4wbzfi5E19X8/rloo72enrWvHsrBFAlWBhvQqUoyAFh54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728939; c=relaxed/simple;
	bh=ka/NSgsj/xZ7JF0zI58mRnQiHPU45eUh112J8IIJ8ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=beghkVbioHjgxtktMeYRL2ezF3zezZOAjSIJLVZTdUo9mEeJwAVmIK2q+3PAyiZHyPtbSQOuHhE/pSi0gGW+QQzJzFOYYsMMN5J0J3HOZXKHc7f8+cwE6G4nevGx1ROPbq9iTUx8qU0II9w0CfNiImn42zaUOq2yvybIh9bQMIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=ozpikqb3; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TEdxVJ003047;
	Fri, 29 Mar 2024 15:16:12 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17010003.outbound.protection.outlook.com [40.93.130.3])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3x56f3gxkv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:16:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZSJhTnFZQ6q2kd6vWOClwVWKUo4B6MbtTcVipZmM2QXkH6qzctnpsGswYBTfOOSZnN5uUpu6EbLpJBbfskYWK7i72f+0CM+DIcnMjP859bP+AZNLOYgviXSY+zuCgI9nSFmj6Jlq0snB2ZHwHf21PWE4zn0vSo+HFaUmmXrD2gw3P+PkCEA6TYmN2cWvkQ9U/7+iF4Pq2rBoYWzf1X9246IhXaRGZSx2JTZLfy7Tuj9zeqyc6ODRXksixKtk7ejDIWT6dmEhIlVfurUEM3H9BswdRNIdAjFf0e8MVmcJ+gWNCkCNUQTi3SmsmLUaVCmpUKkNhlZqHOt9hE34IB4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79FJ13YagSB/87NV6Hcga4EeFyM+AwkNzG4QjslPBHM=;
 b=CBnye1Y5cSTILKXKlrS7EYoFvHZpxsOI3SisrjZWMBJDJH/QoWOI7ONF8cNoawsVQGyNvS/zQOJ6Y/rFDPXHIM/37fCKcN1VX30eGQSerTuif4jQm5Zj4ZXO5xQuGVRJUAQlC1U5o7oqd4n8ucNGn9oVxK6+L/lpKEgW65YQCnoCU+QgYEB6G5T8uIFgX+62pHTjXgP3FB5w5tp7O8GOoFJ/dY1dMnLnBbYxJBbRc/pPRDxZrJbhFwoB6dX1rv0O3tvSv9ACfJn0r++JRR3jjJUU0tu5agX4hRnySgY0U/3rgMmfEyfNft0sURY3/6SiLxwV6tGRfggEaFGDuESEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79FJ13YagSB/87NV6Hcga4EeFyM+AwkNzG4QjslPBHM=;
 b=ozpikqb3ceKgzNA3dBj27b64E5RuDEPo7lDp2ZA+lfHcxkcOTW7gPT0Ea0xdRkNY46H9yLSYa9NKHvY/6d4RWmnzWcZFx7vmqoE4Gl7FfQa/WTC63zgcjmqVuQLhT0cOKo8o5LYQGaS+0VWKYIIEFBTJXUqi+KjT8Z5gzCGkC+CDsJErKPipePEzehpFhxVk9z7xcLnoxv2DQzITjcbF3xIo3SxK8me0W7jD2cPc1XVRO4+2UKWQn6NXTi2i9YvGv8WAA95Vknvl3UpAwOkbPH+xIL2I80LH8nOkoAg/5xZGmk1UcmzZFaprIWhpmTsi/o6tAcJkuaTdN37s4CYjkg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB3434.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 15:16:06 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 15:16:06 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 2/2] dt-bindings: iio: imu: add icm42688 inside inv_icm42600
Date: Fri, 29 Mar 2024 15:15:35 +0000
Message-Id: <20240329151535.712827-3-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329151535.712827-1-inv.git-commit@tdk.com>
References: <20240329151535.712827-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::19) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB3434:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cT+SBscS0LfiSsj240fSommrzmWYZ0cKYFRXY0/Khq728EHk+tDHWa3sl629IMvsu2s2C02nzW3LU/wGjdupKNHux9zSDw9udRxo9q+8ort3mcxSaEvFhuJAAW1XrocgVVGiFuwZ6nStL/jyABj2iysyjjz0xyT7Vr7tQtr8u3XsJMBUwG87zoHqOWI9x+SrmXm575q6fUsSIka0HYhZLS71jlIUWmJki3k0cXE5gnHxh8YIyxw7jIpboSjytW9QcHvghyRWV6lnvVHf6AoBl86Nw/yIS7qrOxhHZZ6cTlHfYBY/QFAlvFgVDcn1iU0xRUSSRudmd961OfovVaD/ffaytEWNMNwB2dm3VAGy+0o8gOx83M6W5hbIKbSq716s9LGSqjKQjSQDk1uS6AoESNtwPv+iDZd+GJKkap+FF2KLd61uoQGmvkc1TUK7d6pJB5Lo3h9k9LIyDnRgAvNo+7WMksJDJBir324IewudRPjpSKvU2OuKTMq47KVIa9MKKkZEzh7Z6w1TjdCPFSvNzkYxQrkpmWmPRRTu/npMfrQa9n7E2x178iZQV0caKELneiMyl6iWYrcm6Kpa9yJqcEdol2QHcg7RxIsWMwohc/0Aw/yh5/F+B2uuNSch3q9sSrbvAraMW4uA7/3DSkjJ9fewoIawFwzjxVbvDzl83E6VUAnQ88NNKx8GFAax2QUXlUIuW9GXcb5ltKgxks2OPAKMVXzfvBtcPWSyqTTYoM1G+3YDkaUND6teFXUhvq7/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005)(3613699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+JxvPfvc/UdL8AsZjj13JC9g/2QsxyLb1cfJb5TFoCIH0/GLij/7Me+YWizG?=
 =?us-ascii?Q?FoJpywoFIuHcCk6oYEOs5SPDxARVTEecnwoq9D34wCHJfcOxOBsxg0eakI8t?=
 =?us-ascii?Q?rp6a5OGal+QoAt1edHqsQqIfvdZ1a5oCy264iPcAdQJuuYEahBQ3xCJoDqYe?=
 =?us-ascii?Q?PtwKN/FP2+1NlID6l3PoU1hnKHRqwzO1wPQgI8vYjOvB7bj2Jw5qoamOgOQ7?=
 =?us-ascii?Q?Xe/6L1Ek+sdUdnusttBWgmVSXoOSUccUPMhCzF7cb482htAbs0Q9Pge8yPNO?=
 =?us-ascii?Q?ZmHrez2DoldrGxArxsVjeAr+xXN09eIR9MrklRYrBcpVQpiC6/UwSRuBuidk?=
 =?us-ascii?Q?0LgvKOQ7rRl3/Hdv6qgHUat4Em8yCrmPrF1k00QdYEJIywWMkvfmSwsGtpHr?=
 =?us-ascii?Q?yw4t9bJd8DI2pdAcayFDAohtYc0n6cD9fMwYpRHC2i8Sve+JXXrfIlQX3d0F?=
 =?us-ascii?Q?lhBEEXfD0LcA5ItozoR9bcNVREEPTLfFH5bKaW0vbwmqhyRH5efB+wYHLKym?=
 =?us-ascii?Q?jp9Bv5xmyiao24y20lUyIxSGZ9VC/TjlkODImqELFYoy/jQbGE/Mtl7heDGu?=
 =?us-ascii?Q?BYCMfn4piYp6FSglqRf+/Op1tl19YH76tTXeS4URarvwf0GiEEs+W2La/FKM?=
 =?us-ascii?Q?A0/c+tNNAKZC/KP1rO4Iacy/1MFo+MhrJeLj4osUUSKnHAo+cLBlWi1/+JbH?=
 =?us-ascii?Q?y38s0xlKyt0lj1/46diZMs+IbCgdzuFbUhCl5Tdp589CpDzfLdkl+sQP7mfF?=
 =?us-ascii?Q?zR1dzluoxrTb8NREigiRrN6DyWVhHSFAA2Tdtof0tV3CjsSI28ZhqMxNPyPv?=
 =?us-ascii?Q?/iUmOkpZK1l3k+yB8lmzpTlByJ/aWdkU2uoy/QlZANlmUbQ2qks/9lqXIGIz?=
 =?us-ascii?Q?iwBs1GfHYA9Qqbfy55nZVcmoMMYbKu8M6RDQea05YMcbAS3BjwZ1zTMEdryc?=
 =?us-ascii?Q?5DSzA8EP1B5i/DtOTTcew04sP9mxEuzb7iDxpz4FdCxFmquBo+7IahULpamS?=
 =?us-ascii?Q?uGm0wGMYFVzgFXEgk1zJ2EbBuIOZDhvuyCr3sQhLLkj4JoPknmljIz+EXGwl?=
 =?us-ascii?Q?8fskP8VsukFCEVvEaO6cLXaggqwrXAJfMk1Ri9fKKsqwreYfZTiTEzMZiNZi?=
 =?us-ascii?Q?sYiCAwFdS7ehgDW6oJThWk+LL71kfzF7jKLIbQ7S0iVelbi9EanlB3HucaTC?=
 =?us-ascii?Q?lLYocj7WaFxaF/oyomQGJVxglHffHn+zBHLr0bPMY+Am91FNXoMypjLyTo1i?=
 =?us-ascii?Q?UHMfdjhcNO/k62mOq1r8v1TfX7xwNCcZi6HOEjhTj9GM/RUr30IGuycHHtHT?=
 =?us-ascii?Q?sVZXBiCgJvOagL/HPGyYivWwONMxQ4V0kquE4vQlsUQTYm3seCxGrcgb26A2?=
 =?us-ascii?Q?l+BoVa9j0HENLpiwZHr99aUyWc96t0RzBCrL0Sh5VCC9QCvKbaBgiMBd4FFj?=
 =?us-ascii?Q?SZzw/Gw6XU6nYpxHeHZhw75dbU2F0hFTK2xrgrcZAPDJTG5h73tdz+St4gpe?=
 =?us-ascii?Q?kZzvYkuoh5m0Ilaor69f7AsnbmYWxXj8rMITTH7iNhAvWgSf9fZ1IKuAmAWU?=
 =?us-ascii?Q?EfnoVSn8ybnrgaCdyXGnBbWNI4M6FA0+xAnYxsNB?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfc34f0-0209-42ef-104e-08dc500327b6
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:16:06.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqOSb42naA9+whAnsvrvydi7RHov9TPfMBDzArAPvTnjmc9/xKJ/Mwu+UMIBAIswtEfH1FIQPRec+mqr64DXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3434
X-Proofpoint-GUID: 8qhgr00iGD8voZkH-XYSM04UsYj1YRj6
X-Proofpoint-ORIG-GUID: 8qhgr00iGD8voZkH-XYSM04UsYj1YRj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290135

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add bindings for ICM-42688-P chip.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 7cd05bcbee31..152aec8d82ff 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -31,6 +31,7 @@ properties:
       - invensense,icm42602
       - invensense,icm42605
       - invensense,icm42622
+      - invensense,icm42688
       - invensense,icm42631

   reg:
--
2.34.1


