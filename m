Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98FFDFA1
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 15:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfKOOGr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 09:06:47 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:3598 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727574AbfKOOGq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 09:06:46 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFDu4Dh010259;
        Fri, 15 Nov 2019 06:06:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=lK7Vk3YdBei15dyxowMBtHml9HfmUxQhITJs9/cxhww=;
 b=TxmqeQRK8i6fjBPa9CJKQJZLJtXUW8+LnwDzDXeVQAgx6QbTRXDo0p0syVvo57UVgi52
 rqaffEmEZ/v6u08mq0au0nKgvYxWpKdV5jSQuLNZ22lj3thS17oFyKqbIwvE5iURAHah
 pYx1GW9mlMXFb7TwVE89HD166vkm7vC7U3FvR/2M50LsHVo56GPOZpp+vsm9Rzrffabi
 zNVO3Q9lHbT4E3JGqJr5/AUW+tyZDNE8M4AUSk+HOEFe6sN0wF2T4x1AKlKi1F9JST7Y
 le8v8i8AIEJ9jM+QtlOFfZ7LtMnRPqilEi7d1mweErX0gOaocJl9vTOkLZgLmW8XhMXy cA== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2053.outbound.protection.outlook.com [104.47.49.53])
        by mx0a-00328301.pphosted.com with ESMTP id 2w8x598wae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 06:06:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5a1VQ3h/09nMfMiUMDWSjLG6yP9pDIOlOwK0GhMfoVA6FD1FRXCC7xOdBIpqbvm6moU40s66yzajEezbscsDMSUKeJRyFjyCkVZDo78cREhUR/xDlF487uidhwOpk8pPPlsC0760hx1o1JNjMsrVb4/jJxPdOL3DvSQ6viOBE0TRpNcIg7sENk2tJXGb2S7oHN39rrfri0VpArOrHotsZtPU7f2qnZ+MfjY+fkplC6cjT9EVOSaJv6wX35uLKTt5dpzAblHtrq90KyXPeJTO563gImNKgetiBnhcB4QWBkzfDjMU1fQFTwCxm8HB1Lhquozseg0RKtxzBj/SarLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK7Vk3YdBei15dyxowMBtHml9HfmUxQhITJs9/cxhww=;
 b=aXPgT1Gz7yuWT1tv0GQm9O46Q4gL7wofVTHfMp1I6Z6+Hed12m/tTLno3iZAaA+5UvMJHo1lHgZXNzIN2xYdVRovIT2CbXutFwqDNnkN4NONU2D6I5tesT3rx0YTsUuc0LWB3Dmc4d+R0AXXSkOC97NQvc4mbJ3RoAbKTdbx1EMVzFY+NCTBboD+41nGnIa9GfcMISEheI/hU7zVkOzzsYDJnYxe38Gr11m7Sf4YvlevPXcq5XKF7wsKGkexZRJNhTC2fZo/7COhNN3hKKLaWFd2kc9+lRDx1RxKQCqaAW/EoLr83wXRT1reTz0mS0SAgg9ypSMCCQdzh83flHotPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK7Vk3YdBei15dyxowMBtHml9HfmUxQhITJs9/cxhww=;
 b=aFgMuQ2JvddrmYEDf5hXxXusYlKiWxIrBUbf6xtQZh9VKZ4ST/RZnVOQNkSyn8BoKrtGffPmP9s87FZyk5oAaK20u7+gA0kqrW7rpTlDq7+IYRbgl5vGE1Ugu8Av10wFa17vwX5t/BUl2STmIQiCp2Y6Sx79p3QEctDycJjHpXQ=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4126.namprd12.prod.outlook.com (10.255.125.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 14:06:41 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 14:06:41 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 0/2] Add MPU9150 magnetometer support
Date:   Fri, 15 Nov 2019 15:06:20 +0100
Message-Id: <20191115140622.6429-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::28) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37d8307f-63b9-4b3e-e859-08d769d5098a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB412630FFC014CA8140C93093C4700@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39850400004)(376002)(366004)(189003)(199004)(8936002)(6916009)(186003)(99286004)(7736002)(6506007)(478600001)(486006)(16586007)(25786009)(36756003)(386003)(2616005)(476003)(14454004)(26005)(6436002)(80792005)(48376002)(305945005)(4326008)(50466002)(2351001)(14444005)(47776003)(66066001)(2361001)(2906002)(66556008)(50226002)(66476007)(66946007)(86362001)(81156014)(4744005)(107886003)(81166006)(6666004)(5660300002)(6486002)(8676002)(52116002)(51416003)(316002)(6116002)(3846002)(1076003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4126;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipnDwGWO7UIW6wRWo84+YeNW8QeSEzDKAWV2xj2C1FigG1JVEd34hwo9kCdlVjtsEUkaEdsVlfPrnSVKus8G2QEJH/7KO2PWpL+mW2vs9HGqyE82t3LShQ46aH8Co/F+dD7P/pf437gBvGyKp2Yd7jlcs88+KPIGgl9yQQVnd5N1J/zfZtRReVQnW9Pq7GALnL3xnmKWGS8dOpgUPcMeNUtXWbBy63L20JrlzRFtNV3PnR2AsWmlyZ5OtYt+nsbamCeamkRRymwg1jUhK85m6295jIZroFZze3hCmptGouBz5q0PeMc3ivtfabzAf+tlWb3GeNBawmFwoGzg1fUu8ItfbzTC3cR7tPlcFLKAs4R96mH1susH5GpBLP8k14kwE6uWslVZIwVhsa9qxWKs09UOHdBDmn/GoH+XgfJd1YcWED5KNYQt3bcRYxeLrCw8
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d8307f-63b9-4b3e-e859-08d769d5098a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 14:06:40.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbafN9XGTqiNwGaQCT5eTBIobRicb7CLqq4x02tjRULhXneCSjeIKDVcx4xHtj5+7yDSedmZAsZlcU+bze1B10ncQCjIo2hrIv/f74TDPtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=615 spamscore=0 adultscore=0 suspectscore=1
 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911150126
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

WARNING: this patch series apply on top of linux-next master branch. It requires
both MPU925x magnetometer support and the fix no data on MPU6050.

This series adds support of driving MPU9150 magnetometer (AK8975) from MPU6050.

Jean-Baptiste Maneyrol (2):
  iio: imu: inv_mpu6050: delete not existing MPU9150 spi support
  iio: imu: inv_mpu6050: add support of MPU9150 magnetometer

 drivers/iio/imu/inv_mpu6050/Kconfig           |  6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 57 ++++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    | 80 +++++++++++++------
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  1 +
 6 files changed, 107 insertions(+), 40 deletions(-)

-- 
2.17.1

