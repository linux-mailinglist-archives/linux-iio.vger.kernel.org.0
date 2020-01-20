Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769A6142762
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgATJhN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:37:13 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:20370 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgATJhN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 04:37:13 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9Tq6S007127;
        Mon, 20 Jan 2020 01:36:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=SiWIoTxyDbzRIsUM2KYgSmOydCXzhJ2aoO2pC6/MFxo=;
 b=IQcAIT/5ibfYLch/J5OPdrvZalJPK2tlGclFhEDE5z/PqdDB1C5x3xpwokXneQQy24o1
 AryFccxR2zkDbuLV4Pmyb/LJg4XLV58FLKItvAslsz7DaLWaX6hMm2C0cYV71HRgudSl
 1tW3Yif+Ve3YKcQ6floBBFDnt4g7EWUjKSdnEFI/8oA5JcvB9rgujCQRAIe6FDRbcZpT
 Airbl5MJNWTQGBT8wjm/9vH+zXkYLNgiPgdRQhxlu2N7I40E2h5HLWqs697bnM3JzjUH
 oo/ClDGrRTSfMCe74OmiWOhXj1C6J2RxtNhiPWfYfJVYFuOCAiW8gJD7XINRksYxV7mi Fg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00328301.pphosted.com with ESMTP id 2xm1gqrmt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 01:36:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6KWQrYJ7T3zgibxuztb1rMLzyeCL9gESsT5vRO/E9EgI/ySLllM7XDO5S3+6cEgcq98TIH2NJ5/AOhWa4niXJSDP0Ac9D4JZGMhRTHJxEqAt8XeEm/oEe9Q6fNhXheZvIJkIhCBdTG+oCOSb7oLnSVjV2jfekN9FozPzzcn5cZTAZ5CwyaDsUArbNsWjTR/6AYpGRjeKz2uNhsBBi6jb22SuSIBhZ4wXUqEMUdo+b0BYn1gmLjDiaUG5gFaU7AulV8cr/oLcooMEe/OM/Is2p8xfY0fu2f1z1BJQDIhr1LXnX++gcdqL5YgqFMDhIFJg1L37G0PWvhUjStrvGfy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiWIoTxyDbzRIsUM2KYgSmOydCXzhJ2aoO2pC6/MFxo=;
 b=lqRf6TG3yz/umLblWyLw8hTQC0yijtbkZy0K2InboLr5RuzmxJ5wl+uNyCtQhYFomNOnGt7pZsMk61W4TNwmvZkRI9FenKmzlj9BDl1FFMO2j+OC+s1LH44vcZXQ6WStf/Y5MKzf1fHu0o6yi7p7NtCeDGKtssMjn1VB/Q34uX8hwEo2V7WuiP19/QF9PA9zvNQYEb2pSP2PIsV5vBW3fkcLl5Hu0c0NKRtmPzBRbTqldhKB2tJFUTOmZjVqtVvdQQh714C7VUTIVzLLuwBiAYhn7VN+I3DbUakHJXt9NvsRy/0/2/EjOFufTqYMvws69BHgMRHVJ524vL4NDvLrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiWIoTxyDbzRIsUM2KYgSmOydCXzhJ2aoO2pC6/MFxo=;
 b=bSprz5kuzUxb2YBH+OarIeNQI2AwfFYIy7sm5jOeorNjhkMeJaWgCodsxbrEPj+JpxcBKhRY26Fyt3rpkOu2KrsuLl820+bj2uSxkuQStYAiw8jazkm9QJm+iWv3vJmzuzkrr68wxfOeg/q/TvzqxRAgu1UT7oZcyhXCXhWPSsc=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 09:36:55 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:36:55 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 4/9] dt-bindings: add description for icm20609 and icm20689
Date:   Mon, 20 Jan 2020 10:36:15 +0100
Message-Id: <20200120093620.9681-5-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120093620.9681-1-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:36:52 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28b53587-c0bf-45ee-572a-08d79d8c496c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404862D01379AAF1C9ED15C1C4320@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(66946007)(66476007)(66556008)(7696005)(52116002)(4744005)(86362001)(36756003)(107886003)(5660300002)(6666004)(2906002)(8676002)(81166006)(186003)(81156014)(54906003)(1076003)(8936002)(478600001)(4326008)(16526019)(316002)(956004)(2616005)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4048;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouRueZZEwcjXOtlyHhCoHD6jBoG+LHJuKJi0rAGS17DQND3ghePHZkT99PYEPz6rUbN3jqb0LkGS2Qdq7OI5PPDlhVO0gWKh7HZvK5zXBhA387p95K8JgZEyjNR4PMHtZlM6og+/iAvv32YWr6XpUWgb1WrA5Zr+F+VqtAlIghxYgZr0oFsvzkQV4UaIijNjWIx4G3aixBZyn8VhoBhCiVd9RM+nvnm9aRFPUSkh7z0DDMa8JXQ1nxcB8cU/e4O8xRsWQvi8nHQuIn3FCDenMxXVnnCCLCRd7AzYlH68stKh1ZwB70Tads1LTxqZj/yOZQWpLqiaCKW8Zhg/hc8nakWgsl8e0tnxDZ1TzjwIKuRl1yPQmAdmpXa6c/KAfQ5CqqcXqGCKIcol3WITJfiWzmMqI+p+RGhY8/5lTE2KuUVeVaETnVZwO8UZ5w9Xlb/F
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b53587-c0bf-45ee-572a-08d79d8c496c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 09:36:55.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ox57PslQuMkEvHMPXGfVh7YyvSpQ2MKG1AvPL8M4UOITlwCWvE5H2Z08sj2AAs4g1rm5ALnStMYmGFhVvPMgaI4bf79j5d+eNDFAMoNDp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=656
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New supported chips.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index 38483ea31fd4..606daa145975 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -12,6 +12,8 @@ Required properties:
 		"invensense,mpu9250"
 		"invensense,mpu9255"
 		"invensense,icm20608"
+		"invensense,icm20609"
+		"invensense,icm20689"
 		"invensense,icm20602"
  - reg : the I2C address of the sensor
  - interrupts: interrupt mapping for IRQ. It should be configured with flags
-- 
2.17.1

