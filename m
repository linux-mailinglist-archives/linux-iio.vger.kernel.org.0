Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DF91C9077
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgEGOng (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:36 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:49462 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727857AbgEGOne (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:34 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047Ebhbf006057;
        Thu, 7 May 2020 07:43:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=fEwmw9ER5fwbE7/630gcavOolHhI9ezXUsNWuYkyYSg=;
 b=iQC7hIwZ6pydHDAR0Pgm7WyUi+02kCJrJ2OKRZKWomBi+l777W8F0UzeZn3NqHnRi6yQ
 wSBoJHuJ4z6xKkTgMY4qK5GN5GOShYf/KCiuWi1lHFInuuRRtti1gz7jgQqlTNeZpTLq
 7i9yIqhboLwVm/bho/e38fRWANpEfJX73JwP/SZo8xQR8t4JdPM16QFyrqx5s8oU8SZx
 dad+q+QS3JvBPFTBxOGOJXvRh2eH6eb2+/CsFtX2dlTpY+NrZpowHEeQxsf0LNQURQdg
 2rQm6IOjDrCPLGWvC4K1VpEi1HGfEHekFQuUR4tTvMCBi2YQUszPCn5jQZt1oWYnhKbp 2A== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-00328301.pphosted.com with ESMTP id 30s4tnatww-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nchpGGhKnoY6rsQnliL7SilrzTPnqnNijhl5ZZUYNWRD2P3xY80vK2SsheusNFqb4V/l4CIAHgfT9FVqLh6jcUcTFIdslmApCUH6vNqlur5iGcfVFQr9tyc4zjqKsLaMMK2CJ2DiHFZdYFChOMGsJZLGrj2jmGRYgG4h5sJ/dZfvKGSidGMkR0BNKOzkg2MDwyG8HZPyq9yIBXZh/38YeL/vQdrejpSLEB3OCgI2NA7oo/QJTOtjEh8SW16Fey7qiFCmV/NcuC8Qw/smDGfR0afdDOFCqBgYwl+WyUAPYALnhuAEObeeMD9xEkgn7ci8xcZ9vrDZWgFPyNLxYnbL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEwmw9ER5fwbE7/630gcavOolHhI9ezXUsNWuYkyYSg=;
 b=MkdAhZwBfZ59wd4N4CMuEML6hT/iodIRYLNTjmM9qe1xdISo/Ixs2DoR5rM6FxDTG5UebKezf3RBU/DFc2YWLsCpmnV/QzBZobqZHx+8I7Wawwy9OkvTnZcLFFUpQBYPQEs99s/PoUjll12d6UUKE1YPjJIE6F63t2Vefpkn8sYZpANC2Hs2zPUTzOZ3ZFBAsRXndDVXvEFkuWPL2p+PofO5TUu/hdFL80hV+llsW4FHrSYeHVM0JDw/N02BEt16U03g930bUAyrEDlXmzIPyeLM8Evrr3lo2FEEAGwPvbaW/UVxmgJbnu5rf0LuiLfRRbCy7YHN6mu3ZcVpD+LRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEwmw9ER5fwbE7/630gcavOolHhI9ezXUsNWuYkyYSg=;
 b=Ayp+xS08CizKyQLVV7390d0yKAI5qQPnDCQp2wVlSoXTsK6bYfT7EvI73NJ4K3+1eykfu9GMVPE2Xm4fwFF5kQauf+WdmjvkugQStWP6/qbaJ/sbjE2ziNUp+1GTkofor7iQYXtXpMcDuWqh3xdqrmi/IohVW1V2XZKiscNttdM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 14:43:29 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:29 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 12/12] MAINTAINERS: add entry for inv_icm42600 6-axis imu sensor
Date:   Thu,  7 May 2020 16:42:22 +0200
Message-Id: <20200507144222.20989-13-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf2f4123-155e-41bd-d99e-08d7f295019d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4501819A3CE942A61E87DE60C4A50@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tIfo+rg3TeQfbiJBhZNPtIM4yhSo7GvAJ9c/pPjLd26Hq+qyltQ/5A5DRP7ooVJ6R31dhD9Ugav2gZW9TQhz3l78u4X3TFgZCa+bb+XsnHPYtTyse+v0rvtJ5Su1Hd08p3zWpXgiJxfxw7EXPyaGRo6S6JJd03njyxFXu/qdAAaNf/4jCS558Jlgsp9ww2rclxVUxwVhl8Kn2k+KRQ6Otn5J4fSTbmDueDexUdAGbXXfc+oPtehSBU92pO5YrGO30KeufELtZTp9BjkwKQZ5I2s6rSR1Fc6IlM6d7uapwJfHc0TsxHY5UPjHSVWEjZPXmHgNPSPMxYT4s/v2TkEVRZ5DuOKCl1XGboipQw6xgCDshW4nlO4sFqYkrsYdzbooJkFaGL0oHzBLjuOk6eql4NUTNgKboKlRnW7+TpjCO9tigiuQqjvLU3z2hx/ZfzxLwPLlIkOAXyJcNiXATibQ3dQUIYVwPfL6jKeDXkqE3fqhS10Wf2YHa9ceV9G0zs9GadAIXTbAaKf8sL6T3Nwk0MQDwEEz85b+X6cUuqMzxl/AuuJExxemaK7FgaqyaXLSgSnBCmLt/cQjQ1PugPyIDnjAC8aJqNSu6Oj3oG1Ln0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(396003)(39850400004)(366004)(33430700001)(966005)(107886003)(4326008)(8676002)(6486002)(2906002)(316002)(5660300002)(8936002)(1076003)(26005)(7696005)(33440700001)(66946007)(956004)(66476007)(52116002)(2616005)(86362001)(186003)(83320400001)(83280400001)(83310400001)(83290400001)(16526019)(478600001)(6666004)(36756003)(4744005)(66556008)(83300400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8Finn44NzEpmZo1n6xEKRDAnLHo4LdBDVBHqwQ4QYiMD8uYcibSGOjFqqsVUrKAtQ21nl3ateOCcWDp2ewMbra6PCEYbJZ7nFq+4LpRvimO7wKjkHRSNyR98aLl/+C3QvZ5kyDLkKcyrGj+8jY8oDJdQrKuYWSOUiLGNCpZdJKHhAQfnfFxjxkDNiOvDNvpL5aQE2STOsBl3UJoTPGf3Y7GLWr87d3qEn6HDlcdV7U5Zp/pqf7fX2IPjEZeEBfMpmziaqdk0rSSXTtkq1vQxQ3vNr7NPf1z04IQGumsnlWO7Bn5DuBmRJL/ZCunidZVkKGMy5hH+CrIEyGuuJ7r7eqo0VcD8jVF1QuaT3ATPVTUbKL9ascjoeV+v+MWomk7q+84hQ2Y+4IL5rjgwJ6GpN0krjXniBYOXx+2mMlgvY1x66VWKQTVjrV2kys+hGt0EetdYmO1lXMXWKog3oeL+NF/s5M2S47S912ansZDyaC7KRa/5EAtkhuJrorRyxZ3uZKDy7OVlOdBE1EzLoCNyOEAatFR5eQ07BTQAYN4FiZjieqZjmjqe4xqyJnOvco4s791QcSzy9DgLrwiyQXP3j3zCu4sYahSY9UhnK6XrNIIpKuZIqlddRizDlyY2uGmFfOLscW/1ZgXvmEFFB170/7nHl1qTj09iIdyyz8b+AdUTWn3Ek/vugB27gLoE7lKgHfKRJDlx4Y5V4EshNBLlIgJVjahSuYDcqkqSvm+A1kZeDOF9Bh7WDVzCgxCj8DjoRsoLy+Fs3GkrD8WwDdpA3k8yxKVvG0UDcHJh/6E/v1U=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2f4123-155e-41bd-d99e-08d7f295019d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:29.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gaTtrGRGO45yKmhpRN5PtKCblu0wodWVe3cP/paUxOEUvHdSjs5vTL8u+32Gp2czQxweyYagcy6w4OF1l/Z0D0sL8RLkew+4zsMtnHjEkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add MAINTAINERS entry for InvenSense ICM-426xx IMU device.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10eb348c801c..1714390e2721 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8864,6 +8864,14 @@ F:	include/dt-bindings/interconnect/
 F:	include/linux/interconnect-provider.h
 F:	include/linux/interconnect.h
 
+INVENSENSE ICM-426xx IMU DRIVER
+M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W	https://invensense.tdk.com/
+F:	Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+F:	drivers/iio/imu/inv_icm42600/
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

