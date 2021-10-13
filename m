Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74CF42B378
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 05:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhJMD3M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 23:29:12 -0400
Received: from mail-eopbgr1300111.outbound.protection.outlook.com ([40.107.130.111]:36864
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237477AbhJMD3L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Oct 2021 23:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUOnmfW5lp+mUZg4NQ3p0Q0I2M54Mte9lTPCw1j8XzBhrMBAHYPjHecLu3F2jfI/ANiR6xClHN0W2rc6io8mO2jNuMPla9fzUYQBMJXegJYKtN4CLweCshYejbSHI099A3h2GfRgy4B5+8Q3rkuiXA7lFJaWVBuZEwsL+pHhbLdviPNCVNlVpEFCytvXO2fMqum3rmMzFINlqOGTq7nM7ozIbojehwkWyRnG3Z8mQ2SxpKpvOCyhhMEzsvmJ3/bKWqzLiUXec+qygBbX8C5vyd483brV41gYBzxBRSKClKP8hGlGHIDBYJ6YoHhcMJnKq/63QpKVL7A44Jjkx9EEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GenKSiIsPYbxQtkO6HJUWv8A4R7OdeoZUusW9bW8gQE=;
 b=jKH05/52+dIkqCqCAvGaY/d19M+HNGpPniqmM8lvQmvBuf40iqjwyQE2aRKsRlajWM/FY7OQlkZLetTXSIrqbLsAJbUl79DClKQE3PVw+RgwLuO85benMFxNY/2QDuIVETMg+EITTG85ngif58BWkDU9+ljBLLNwW7CRxNpucPVR3JGcrp/1JtSPMWiYOs7wo9GEOIwFGaiVYFBN+2/UAf6asQubQPJc4klQXRuCUyFen20puEa4Vp09dUjFBoWq9Kp/ArPmhetK5nxV+d0bgC/nJi6lFBPgGcMB7s5nSItjCgNkWZH3L1Vs2urKKwWxJs5XJMaoRv+egXb2TPSqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GenKSiIsPYbxQtkO6HJUWv8A4R7OdeoZUusW9bW8gQE=;
 b=VdjgPjgQwMqZArCD3XR5MC73bg42rxRmoE4AS446j/LSxS9ltyP33oWsvzqPy6jGi1SaEdeOe1cbEQrSsPY76BBBCnAN4KJoEYAFRHxxZU6At4K4TCKJ6lWPtbQz74dso3VVxOtTYcxeqL0/Ka0vd5vEpjvXCM4huCOsv05Uquk=
Authentication-Results: foss.st.com; dkim=none (message not signed)
 header.d=none;foss.st.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3243.apcprd06.prod.outlook.com (2603:1096:100:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 03:27:07 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:27:07 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] counter: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:26:59 -0700
Message-Id: <1634095619-4174-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0032.apcprd03.prod.outlook.com
 (2603:1096:203:c9::19) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HKAPR03CA0032.apcprd03.prod.outlook.com (2603:1096:203:c9::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.4 via Frontend Transport; Wed, 13 Oct 2021 03:27:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72721946-a903-4ae6-6942-08d98df95592
X-MS-TrafficTypeDiagnostic: SL2PR06MB3243:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB324365A18452128DE284034BBDB79@SL2PR06MB3243.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLuurFMi7K2z3qM61jL3QF2mLpoyjNTATrirETwX/2pXAuvRIXwPFP+Q2/asvDXdsARiMlkEYVj88LMDuJK2IAsPXXUsmsLcj/9oj5IOxgsDVcan8p6Kia8Rrjs4QzX7+a3rajj4B89o+A3KtsE8Of+nrM5EranO4P8i2Z1mWjNy7Tup2JsnxM5wzkhoSqeuBMzrrDOpkhZg6gnJmtgfMwq6bI74K+hADn/FQSJrK/2dIl1d16uGFvAicrfqes/JeLTRDBDtpZMfs95/ZK5qq6SGvjOvOYPRhc7VWuDLTU4Hv3PNPt7NkB3tzu8dhNceTt6goMpXWIWX/6xKBLTRfcz7WQH1PhFjUTX5PFGS6rOIUhC9lKhlGvdjrTcEIzHufVrIRUbiIhw2mC6R03LJu7WFnxXJCGNn1gG7vJ+Wg1g8tLbRsVDBH9e5C2PEI9FeiCft9Swb7T8rLlgUbaQfVdt7LuPJoP/uAGzKcgWA4T4RWhOSAx5ZC+up3V1OJFBgUFyACblih+1Z+XVLx81f4AuE1q9l0eS63s6X7qviWzFRKSXJmcOM4e0oG325WvftBd//W9LqXLtXycgza01pJIzk3bhHQ1zNMK30UUsAhNrdIpNUiilfs2rcY0dx4M/IEHbXxHPZWiXGHbxE30Ffwm6EhcXyBUqp6XapsTPLow61N1eeuIsroUAqxj7yDNEUQHlY5fetS//Q+yi54GPoiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(26005)(6512007)(4326008)(66946007)(8676002)(36756003)(66476007)(83380400001)(38100700002)(6666004)(66556008)(38350700002)(107886003)(316002)(52116002)(186003)(8936002)(6486002)(5660300002)(6506007)(110136005)(956004)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kFH0Wp4cSJcSDaT519U5cKm607ItOJzBSlMK2WBEyrfh2FhLETlHlJdh48BA?=
 =?us-ascii?Q?4ub+6azGjC0CpxVFCc042BIbnjwGQ2AQEEwUd1sTwvGjyX+jzU/Nql98K/ZT?=
 =?us-ascii?Q?wYSrRxaxpXZtLqbtqQqZyv+0eppPetWKPAOmFLA7eG4RYY3IswN0Bqdti7HB?=
 =?us-ascii?Q?SHKfdm5EnzCVZiorc33Pe37wgR9UJ7lHbJllc78oiAOgIWHi+yWDhEssBZRr?=
 =?us-ascii?Q?7bMrkWujehazpZ7N5eGt36ceXlzIoXtv0EkVVa5YPXmyh3M4a4ncmH/hY1ln?=
 =?us-ascii?Q?EPBrutaaeX6QX/8gAb6GNPWbbVAhfPnVaCVttHcFyNFppv8xAdU6G+meJjNM?=
 =?us-ascii?Q?U4/UUXh4qTGLY0/UKGKXeyIN8FqnF15nU5iubTNAFqRNdEvCoJuwboSVg4+O?=
 =?us-ascii?Q?n+oeXjhB7sYSbPEsDlJDdDVWm/KmFr1CFHPwJw1pYTk6EZzCSyGPqIGimnRM?=
 =?us-ascii?Q?KM8eJDjRjAJ3b9EoUCpyc6Rg2ATMfLJcq0AzgGKEf8hjAq05q9l9Vo88HdAU?=
 =?us-ascii?Q?Nkkev2Obx9wK9sfiZGw1OXeek94ekmgWGlunqdIkCse055Hy2P/yTl4fupSA?=
 =?us-ascii?Q?sGZpnKul/v5Yg6cmXJQtaRqCm45rhx324IYWPpdyPKYgV9SSn4sORGgWbgJ5?=
 =?us-ascii?Q?FJqcYKW0TsXFbO82S6VYrUEmcOGw5OySjvt0mdXTcRKxOfC39I41QjInE6+v?=
 =?us-ascii?Q?7ATc6iwHbY0B/eftBPq8g5WYFivMFlR3iwDZFgQilSAG7ZfnUYAoMY6jJQ8A?=
 =?us-ascii?Q?ToFcs4EZ0aor3oxsr2QFpyT1r0HNlWraILwxgNPq5QmbEMCWTuMhbxJEdVlL?=
 =?us-ascii?Q?pUlQ9ORC+yQDvgZP8R1DejU+dh3kF4+ZD/m1R7NjTTyzURxwSCo0edCMYE7M?=
 =?us-ascii?Q?/V6Lj1Y2aICrjhxg0Ui8HUcDys1opwH8yH/1JmX6pufbIyKH4z3DJvzUuhPv?=
 =?us-ascii?Q?IsUN4WO1PYPe19miOzqmzXhnGsNwJzvdvGf3ErFyTJH6sYx+JsWS+Q7HkoUt?=
 =?us-ascii?Q?L2I7ax+RbYnTXawOFCo/SNRb5Cwe/l9q/+aAiyMzafKQval4PuEv/PzxK5MY?=
 =?us-ascii?Q?n5E4H3R0kpSXxjWwqh84kdU88pw5rwqvEZlfEOv9bigjHUAQQ2yhg6cDHS5D?=
 =?us-ascii?Q?u9f8fbZovk8PGqL3ijRHecHevBlPd+huHU/NDuo5gAa2ZcJU2nazrU1XgGaK?=
 =?us-ascii?Q?+NmEDVW7rgxj1RueA3ivkwGyrR5VGdsbpmf/IRREJDcsD97uvL/e+UTMmq6S?=
 =?us-ascii?Q?4u1/r49th0IbXrCzHWQPXxoYFrRCmMvsvCKzI0zQ09WlvDIfZl8K3KR2HJ4D?=
 =?us-ascii?Q?AaemjOuzNuHPvkUoMLPonvBI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72721946-a903-4ae6-6942-08d98df95592
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:27:07.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLhohVsJOuEUQilbrIRgbSe3HhqHD6Lfc/2H061VC1rQcKGmTzQo2VRLu2kDONcCieNzf/l8RtKZXlAc2Bl6mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3243
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the following coccicheck warning:
drivers/counter/stm32-lptimer-cnt.c:265:8-16: WARNING: use scnprintf or sprintf.
drivers/counter/stm32-lptimer-cnt.c:176:8-16: WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 drivers/counter/stm32-timer-cnt.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index c19d998..6f1113a 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -262,7 +262,7 @@ static ssize_t stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", priv->ceiling);
+	return sysfs_emit(buf, "%u\n", priv->ceiling);
 }
 
 static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 603b30a..e772586 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -173,7 +173,7 @@ static ssize_t stm32_count_ceiling_read(struct counter_device *counter,
 
 	regmap_read(priv->regmap, TIM_ARR, &arr);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", arr);
+	return sysfs_emit(buf, "%u\n", arr);
 }
 
 static ssize_t stm32_count_ceiling_write(struct counter_device *counter,
-- 
2.7.4

