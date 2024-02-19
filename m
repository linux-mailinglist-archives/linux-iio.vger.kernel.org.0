Return-Path: <linux-iio+bounces-2765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497C985A295
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C951F215B6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E992C856;
	Mon, 19 Feb 2024 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="j2Icz4g6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015AD2C6BB;
	Mon, 19 Feb 2024 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343814; cv=fail; b=uqO/X32VKuF1w0rushvsfvmcAJEKi2yWpXCHl6OmDYRHG+wCONPNwhnGRulPj9pp6eB7tV21qvfLSo+iRXtqnwcB9P50ZwRTGK1+ep9TO9T+OOFjfK4HDLI4uH+rUrO115AhQ0wfThjgfCZhnegcOwbw3PUlepshJf/ozBYvHJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343814; c=relaxed/simple;
	bh=E1hdI2xGPCRYRTFZR8q2CbgwomkZb0vPHe5M4Okj0K4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oGax+IhkwG/ZAnWPkkUA02mgttHqsjSLViizqbyC0+PgcdxBNkAIiqsokunyKhwQGRZy/yVoFuWHZYbKdWfRrpHSCHiR59u604+zw5U4CL2b2aibhCURBYAtPtPgO4B/zEHhvoAb5ThCaB1S7B7C2jXL5DK5RNKrLJUtGYXQK3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=j2Icz4g6; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J97RxB013389;
	Mon, 19 Feb 2024 10:49:49 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2104.outbound.protection.outlook.com [104.47.23.104])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wap5js63v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 10:49:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkGNmIKVWu8zfubq3my5mm18gXgfERPRtk7rdrOwo92MFlbhPD1o4C6LrR3gk+f7EDY6z9HAfogi7bcxZ7vYT7r8hA9HezxeUrKOKVSVCvTR5eBAhvjy2QUydZRUhBcak4zQpx4MtiVi4y5l9ybu9CjnMiEWhtoRkdJRegJEzZWZYwcxJd7x0wIgd+NNHpuD9VL0BNtQcVSSSv2hLe6CpKS9V703TKOg3FqQFPCT8eABZXFk3FtaUvOJcIYyY47NwX3CN4inUh8aA9Z+lEVdSLgDHaH9MZGed8R4/9X2ZUyFpPJOqaNlt5iEKVPmwHcgB+3PRVtOhlKzlSLuThMJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaxQNkDNaNL1RiPdygUwndOb9UcqeQue+ML+yZG84cE=;
 b=XIEuac+FNzL7FZfRdTPvTlxRMDdxdiCs+pvnvqytxJnQ4hcFPKBPC9BkAzBzJyYXBBpUIvvXbcnnifsIzbRH0YWFkU7IZU3PCkNaMWYdGLSA/mYxyoru8NtI8+GycNs7Rbp6N70xf1sSCA0eziPUmrzMsrvLR4Yia7N2Exxdwq6v+OYOoMDTByePzVG/CzR3fM/TI2T/UvAGnrmWqUh8m7l6fQJisGIt4wPYu/XzYYjyAwGo2EPkmmomxt4pKPfPOpg1AxmBHGEO4DrHtD4mYuwfzuYgBjsrlISQz3/AgTFK9vnxBHVqexfsH5xk0MDEbeT9GdnqJQ0Qp9GvaZa9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaxQNkDNaNL1RiPdygUwndOb9UcqeQue+ML+yZG84cE=;
 b=j2Icz4g6RcZbW5dk3lStp6A3Xsg9NMQftQTAhjD1EnlRMbQrxZ2E98PIegSK80PAU8gK9dkcBJ2gj+eqRidhRmVjAS8gSy9oen2TRewyc3eDybUMh+rZValMJhjoSpB9cK3ZVZg08RX17/wS7/qxl8Xb/7M1z4NrColfiRXows+5oSlse0YKoNCoILeHXS2A0LoMVWXwcdUXL9ysOzZrKAO5/FOYVXeMfMyYoMfMUlwkbscNYe2URUIJxZQkH22FisRwH/IspHByg3GvItOHI5UhH+zHFoolFcdEP4QeRa8IPsXn6WXIej8taT1cRqBHbNYS4+DnFQ86bvd6iRvaeQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY1P286MB3106.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 19 Feb
 2024 10:49:36 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 10:49:36 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: imu: inv_mpu6050: fix frequency setting when chip is off
Date: Mon, 19 Feb 2024 10:49:01 +0000
Message-Id: <20240219104901.88743-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0581.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::11) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY1P286MB3106:EE_
X-MS-Office365-Filtering-Correlation-Id: 963cafc6-0bc0-406f-189e-08dc313876ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dHhuIdwhJTsBdxwG0RLqyIJcKQX3csLT4mC+6DmXnivh64awb94zpMfSEYNsI+lOM9/KXyIRUfnhZnfPHfi3Rb4FGuLPZNKFrCrqiD1zxaHp7quUatPMoA9e0S1dVQzX9pCtB2IvR3ivt7qg8z1ZogWgIf05aDqFcn1hrIvgE6X9h94eIUTdegr4x/LtVbKEAwAw8Cb3La+nAjrI+9muEYqLg8nUIXWuB3p1JrNsb1RMdFTkw5rYFO4MEIy6gON4eHAH7Aso5vb6g6aAn+oZaJImlpvWetn7uCopQXeJpJTNjfyp2UHIO5YSl2KvTvQWhfsZ5egXG3mW7QKWfb30fw/KqFp3JEUzaZNI0khdBFxeWdjuvAJMZDAbYv6+6c+81XwwfftzqNXhfBdeTcN3mVhDQshNgg357SU6v/judsclJT4/de9C4/Ai0/ZwMzeBT4kNywpMLgYpxUQIcBvG5lL5xMSu4X8v9nyzelQ+/k0i3NcMJY7xnuLTsK4u1dNNgij71EqLap/1ig+D8Z9Cwmyw6btEhPKlVjbVSUtebVw7jUVf94cvJUjLqr1gmI0yJFw4kp5XCfOTkhI27fiEEpPXKl3zr/4c7EzPjA0xOjbK1jS4NUcy9Vs5WaZ3oun1aYDtkkvig+5mn7ovkt8rbg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PjDKgZJCnhZEGe82f8D+2P1PwSpg5dUI5uHVNqkgJ+avt5sXx3q4Hg0dh5q6?=
 =?us-ascii?Q?75ijdYguR/XSTq7ptum61dlwyuC7WsaNXc8qS6Dvibt5W05XcYn9ffkq2jQh?=
 =?us-ascii?Q?EgAzjjDT46VhIP3XDY6AUdBQaUiB7DaiLZ4yKJsew0c+WMi572NSdfFBdec3?=
 =?us-ascii?Q?QQZy/i7LssVg+3xEQLrtVcfKh5ofV7Aivqp7K8j+KDeZ5wU4cS/UiDt/wITx?=
 =?us-ascii?Q?z5UYlTv9cSfGfgq7vAKcu1E5pucJtALVGmAxQaRCXvxOoJ4hE8nJr/htD4fM?=
 =?us-ascii?Q?z/LsCdL14Qe+c8F2ku2xvkKs2RNsuoV9RarZUU2WnULDxX8zP3x/kXMxcNga?=
 =?us-ascii?Q?Xv8h+9WOxB0O2C9VE5y+21h3WMxv04LM7if0fm4S905z5Wo+Y9dJR+tAjGUG?=
 =?us-ascii?Q?/Isln2oMnUZHGu3F9DwPIQxvkv7yvn9SwjONzxsdZIQxZmRYX4rFRC8Bwi20?=
 =?us-ascii?Q?k/NvAwgaSHAUDc7WRtqwpAaCgRLa8vsRIFu4+QrCYXsVLQzl5kb4BJ684B8k?=
 =?us-ascii?Q?evUf3F5PzWEtW59e7RFe5/fJq85hKBsu1YfXvbq2HNYgGuG0raYclZAmqa7C?=
 =?us-ascii?Q?iSiPzQFPFohZQAQq7FB62J5iHpROnaErPWrq3/++FsOXXZDgINf4h5JjPYVU?=
 =?us-ascii?Q?Psh/FH3htwHSOHXKjqK+dBG3wPWFKdDaJlymja0ffisPAVGmAcrfwlnamLri?=
 =?us-ascii?Q?NTnn54OZhUq+x8py5D3tVhulh0GksMhy7sV3Ee83oiGbi3fe1RIlLajO4DAA?=
 =?us-ascii?Q?nE42fYujD3C2GDmKnZdFbaFFq3cnpkq/jvaLT2GRAuZC6MtsgILt6pBOaKzY?=
 =?us-ascii?Q?YG7ZIFpQa+znoblc3v0dVGEtB1p3OJFCg7PS4Z7/EbjUbxBKbV1PSOGhfV9S?=
 =?us-ascii?Q?7uKEp/iO1LdQF1xy4qs424D7sm/0Mcarhf5lTakIbNCKrxnFYp2OvQ+phCuK?=
 =?us-ascii?Q?N5XjYCIgTIF/IRHMZonHeDqq6/KoX4I0FN8WAUpKDX+T3r15AuYONlrnrl7g?=
 =?us-ascii?Q?l5OIy5YOCwseLkU+h8zi4S19gd+ll5No+yjkbA6RihWM2JBuRKjALyeYktif?=
 =?us-ascii?Q?Ii37SKrzIbzEL15Ce4T+Ddj6dwZaW7I12pn7NAcPlojK3S4MbXv0n041RZZb?=
 =?us-ascii?Q?cFFaTw2p9Lt4FZbsiHxM1a1HbLLDl8eiDi7HLdvVu3fJXDHat6JAWP3RxHkg?=
 =?us-ascii?Q?XPKUGfxO+HwP8KUmNlF8qXtkNxIX/OWmSD/lizvyJJ415NkpmYt/Ycj7F3+5?=
 =?us-ascii?Q?RvlhJYHE3R6qX+Vp7AWUoEfUGMDOa5SOBURJ7fEnMTC10P1W5p2sQJJqvnDV?=
 =?us-ascii?Q?L1u/SlCtFKP4X72ipweUUFUO5+uDBfZqLDgIotsM1w/q+rhN3fJ+N4iy/7Xk?=
 =?us-ascii?Q?C7YF+IJYpYbuSyOoSZKitpZ/x0H4RwEYT1gdfVrfCVNbLs/DUKq4lM60lNR2?=
 =?us-ascii?Q?bGLFmtEgTZ+N86F8FYfCB3HjGpg97VpTJa6ygpbh/qNgMwdrqVyr1LudkmmS?=
 =?us-ascii?Q?pDpgORrRpMhQ7kqCUcLrez1DcWqaGLnzWuSqStu08sVbe400mRuareMVTRD7?=
 =?us-ascii?Q?wCOcRsH/SuDUyCcEXKJ6w9rTcED4rabCHdqPhhkf?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963cafc6-0bc0-406f-189e-08dc313876ae
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 10:49:36.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwV5sXbju6VfQlSKUbYpbMzOfCCLy17iyUod5ybfE28ej45+BKeNqTwqdN84btzoWYFWieniKID0MdU0nVyAGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3106
X-Proofpoint-ORIG-GUID: 4iMIaxTpFkYuF1EmpcfR429Gd2XhfkFe
X-Proofpoint-GUID: 4iMIaxTpFkYuF1EmpcfR429Gd2XhfkFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_08,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190081

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Track correctly FIFO state and apply ODR change before starting
the chip. Without the fix, you cannot change ODR more than 1 time
when data buffering is off.

Fixes: 111e1abd0045 ("iio: imu: inv_mpu6050: use the common inv_sensors timestamp module")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 676704f9151f..e6e6e94452a3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -111,6 +111,7 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 	if (enable) {
 		/* reset timestamping */
 		inv_sensors_timestamp_reset(&st->timestamp);
+		inv_sensors_timestamp_apply_odr(&st->timestamp, 0, 0, 0);
 		/* reset FIFO */
 		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
 		ret = regmap_write(st->map, st->reg->user_ctrl, d);
@@ -184,6 +185,10 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		if (result)
 			goto error_power_off;
 	} else {
+		st->chip_config.gyro_fifo_enable = 0;
+		st->chip_config.accl_fifo_enable = 0;
+		st->chip_config.temp_fifo_enable = 0;
+		st->chip_config.magn_fifo_enable = 0;
 		result = inv_mpu6050_prepare_fifo(st, false);
 		if (result)
 			goto error_power_off;
--
2.34.1


