Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA1A1F20D8
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFHUoN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:44:13 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:3912 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgFHUoF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:44:05 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KgTij024950;
        Mon, 8 Jun 2020 13:44:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=ts7RgAAzhzPOnSMR0uB3yQL4tELJfE/5U3WAV+hW0JY=;
 b=vX+gTubzqmDmohps87A9D4pWOsEVtXD44DO9hUBF7EquYHPaTHAAdhKwqzSjEUJZ/dar
 QX9H3gY1zl1sViFT7C8FL2nl7lyH37zJPg0k6piuHcAgq1MocxwLV4SA+J1JSghxA/I8
 uX9NffapB8sWfyAIQ7Ph4ksn/WkbuAMYKe1YDBpULDTe4UBWRYsBnkXlOlma5z5IyDZr
 Ww3DiJ/Kj+Fqla8l9ZYwz/4sxyqMqVZmgT6mzRD9Nv2Zuf2etzQ4OyOxFGv4MSVuwn/e
 TzLgYhgXkBEjcEBQHDMS7d57BPfZfMabYB2/Y3Fdd5VGLAaeiFtYFw19JO727tElEvNI yw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00328301.pphosted.com with ESMTP id 31g867h0f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdIt4ljYsTAbfZ2rOCqj0ErTDtxMjM6b3ELQLHwx0ZmLhkzHOFRvRpAH7UBHbCu7nlc2cDYqmXmuURzD91mXtj+xG0050T6exZxLCCmHR9l65IGzmeZpcYRjv11Zd0/YY54ASGIWBGpI+w6qxzq3BeqMyHNkfw9toigvgxG6EUidWnXJO9gP21xsf2x0WCAQ0wzLJ7aOrfjjetb6PR19WdlUlm6zGxJBjoq0T3V8ISB+VcpwLD/xFgQiEl5h1f3o3eqkurOWhXy2ORYnBjEAc73Q/2birjqD35Mradj50YGJ+EtzpiLoMdO1rFSOK0FdYpshfX5wfT5viT9tjzDHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts7RgAAzhzPOnSMR0uB3yQL4tELJfE/5U3WAV+hW0JY=;
 b=DhxcKbENK6hTNAi44CKIN3hXvpbRg1PsAWwXSBUhsA+jaWqFA5wlUf+KqvRhzIYaPq45AN2tKtyjPNhY8GZumukps0RqZh89wfoX9cEK5EzzAOCCHpgSvbo41yzc8rzrvTDxoxt6eMy/e+XAIqzlT+NXEnIIknYIM1mWUPj7cXC3Gvz36LlQBSx5dqYbHtQ4bQ526GGj+I1iwjZdeKVm8Ilvwbme2fOjzo4S5tWQrZrdYfRIhCxXAsg2k/cHESjsm465O9SRxlootLd3QAIRqoVc4j3q7rl9zRrmePpwvlvuDJJjQYBZQfBVRLtfTUEcLhJCljMn4r0MojyQOf+AcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts7RgAAzhzPOnSMR0uB3yQL4tELJfE/5U3WAV+hW0JY=;
 b=SxQ9N6OzGPTzYbH5MYFWu4X8ImZgOOwbUxIuL72DfhSqzoU/ATbuYnaWtU/cTyu2oC8gieK4p1oQtL34+ntj6hufbs8r8hTxwW4ZRTyUMFBt4P+iyTOBxeRWB9JVcTh8CMOU0MDl3uVJYdPJ/3gtj2glnXmGpY9w5TcT/a1wsVc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:44:02 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:44:02 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 08/13] Documentation: ABI: add specific icm42600 documentation
Date:   Mon,  8 Jun 2020 22:42:45 +0200
Message-Id: <20200608204250.3291-9-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:44:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cc0a044-8c8c-40a2-f1d3-08d80becad32
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB395132B18467ECFBB52D6E97C4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:337;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJFdoT5HC6xdXIcT9KexWk3u5Bb0KV42O7hGRUvJGJUV1+hYDNOjv4reFojbdCImdCPdddsco/XBylPZh5zoo4B4LlG337mLJagMQX55Xg4d0AwcX+pRWiXGdkFMu+zsTLMXvJSWn7fTU3MB5tY/InvZ0LX84N576g1CYAaOmy0Bg8zLkTrX9WX607M/tXkg/GfThTAkvDXRKUv7G3ihzNHukoaJb25JKTkTt325coQZAg/7cZxl1dd/4QI0uYWYMrFdXB73ysApGQlcZNKxUtUv97y7MJzFEtfmY+Fs+JgRzH01if7ZVh/zonRzk3oeN0hlhr0PiHtXsR20ivirIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(19627235002)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DkxBHk9I+2jDPmKNwfqQY9gj8oEO0qzioB8OlYMb0+UJU/Z91b+OOIGE1SjbEGepfswEb2+4ePpWNTJed058upDIdB0KQ3y7kdtedBY/1yPNyXNO+eYpB+mukbDQVpiw8cNhuTO+zjCQixIgAH6wpTUtERlJOt1qTc2i19MMudwEQHeZBRpGp9xm4l5saqn52olkUGuczMeJnAiQ92XCTOI3vfEwBXUlzFNSFREAw9IaKd3tykCsDX0vYD9+XgLv+rKVgRj3l87kDAgkWeT/SEN7pPZVakW+jW59QaYazKk88xkXzidstgWJY8xUrYjmIs0rL0StquAyvNTawm6m5k3nOuQ9XscLcKEoL+LRb7a4HWRUDaxv5Z/jradXm6iQl742H89fhunuS9ry12abd38YBSIlmXc5zSzOh6jHfYk5IxgBzclVgQjFmjo2CkCgWDAeOPS40rA1bTy5ug3WUMwd+ZaLkBm+2fu5/xpmE0o=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc0a044-8c8c-40a2-f1d3-08d80becad32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:44:02.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3W3B1egcpwu7+BYC746ScDTcs5XLJX2Z0ezRU/QJKdO2PG6mpgtTrZttq2C2mURd6K83hvrmJCHpgm2ifq/k39fOEcmudAvljwrvKg9BjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 cotscore=-2147483648 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080144
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hardware offset available as calibscale sysfs attributes are real
physical values exprimed in SI units.

calibscale_available sysfs attributes represents the range of
acceptable values.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 .../ABI/testing/sysfs-bus-iio-icm42600        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-icm42600

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-icm42600 b/Documentation/ABI/testing/sysfs-bus-iio-icm42600
new file mode 100644
index 000000000000..0bf1fd4f5bf1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-icm42600
@@ -0,0 +1,20 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias
+KernelVersion:  5.8
+Contact:        linux-iio@vger.kernel.org
+Description:
+		Hardware applied calibration offset (assumed to fix production
+		inaccuracies). Values represent a real physical offset expressed
+		in SI units (m/s^2 for accelerometer and rad/s for gyroscope).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
+KernelVersion:  5.8
+Contact:        linux-iio@vger.kernel.org
+Description:
+		Range of available values for hardware offset. Values in SI
+		units (m/s^2 for accelerometer and rad/s for gyroscope).
-- 
2.17.1

