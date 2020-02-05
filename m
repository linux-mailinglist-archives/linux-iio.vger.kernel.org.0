Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D082F1539A0
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 21:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgBEUkM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 15:40:12 -0500
Received: from esa3.tennantco.iphmx.com ([68.232.154.86]:55751 "EHLO
        esa3.tennantco.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEUkL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 15:40:11 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Feb 2020 15:40:10 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tennantco.com; i=@tennantco.com; q=dns/txt;
  s=selector1; t=1580935210; x=1612471210;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gIUV8ZK2wVZNknl+9N6O5UArZ5tMGnzFxLcU3HzLQjY=;
  b=kBTkQzJdZkb0pbyf3w+aYwXE1McLbTlhgM9uroThfNmN3Vauu+81eQ/+
   5F4q/wnvE1XJwVeh2I6XAObZgSqEjDn+rNvpLyneESpSiunEHtmXI7z1B
   STi4lav67YOTPdvI6LTHrhL4ed8xjIeI2w4+EH8lBS30iQo6AZZ0TPLLf
   d9TMdzf7CEfvUcoujKziTfWGbp9yuxywbQNZWtRKYAfg3eLE1XGcmh9oi
   acWZSOGaDqX+OOyVKCmV3KN0iL0I9tXY/1jRhJ9/+2CNuF+nAOONFr/9P
   ZlxS6wRQV2KxIHBz8X0UmDFZ+AWNwL+CP7qEgDsy9REusH1qpTYq/EyPW
   g==;
IronPort-SDR: 3S3W1i4GGbpzd+1S+T6fFIXGhg7pZtXb0f/ujvboJUZyiFBHykIER6Zx8xJX/84a9Y8ggnvVc3
 EVGTA2Z7fSg5w5dtShQhvbiCPXRke7XV/+UX1udOk5SWmAgFb7tCOH6lAMLb9Bz17/dHgQMAPo
 LSBjff9O8FGkQG9rvpT6qlUfpl132kA1xGvzhD8Ex9RaluvOogR/wO/6ILfSH86c3nwibBcBG0
 ee3zYy8q0qINfn+RvATYBaSzPVmh66EHHvh3SDB4UCmxpsaheb/PTl/N8hoyq7YVr11gvXKTuV
 Os0=
IronPort-PHdr: =?us-ascii?q?9a23=3AjmTYJByrbqa5Ks3XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0ugVLvad9pjvdHbS+e9qxAeQG9mCt7QZ0qGP6PioGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZFiJ6osxR?=
 =?us-ascii?q?fFv3VFd/hLzm9sOV6fggzw68it8JNt6Shcp+4t+8tdWqjmYqo0SqBVAi47OG?=
 =?us-ascii?q?4v/s3rshfDTQqL5nQCV2gdjwRFDQvY4hzkR5n9qiT1uPZz1ymcJs32UKs7WS?=
 =?us-ascii?q?++4KdxSR/nkzkIOjgk+2zKkMNwjaZboBW8pxxjxoPffY+YOOZicq7bYNgXXn?=
 =?us-ascii?q?RKUNpPWCNdA4O8d4oPAPQHPeZEtIn2ul8CoQKjCQWwGO/jzzlFjWL006Inye?=
 =?us-ascii?q?QsCQHI0hI9EdwAs3raq8n6O6gVX+C016TI0SnPYulK1Trn9ITEbhYsquyMU7?=
 =?us-ascii?q?JqdsrRzFEiGQ3Fj1WUs4PlOS6e2OYKs2mV8eVhVf+khmkppQBxpjig3MEshp?=
 =?us-ascii?q?PLiIISxFHL6yV4zZ0pJdKmTk57Z8SrEJ1Mty6GMIt6WN8tQ2ZtuCsjzLANpJ?=
 =?us-ascii?q?21fDASxZg62xLSZOaLfoeK7x75VOucIi10iG9ndb6inxq+7Eytx+7mWsWqzF?=
 =?us-ascii?q?pHoTBJn9fCu3wXyRDf9tSLR/1g9Um7wzmPzRrc6uRcLEAxkqrUNoAuz6Yrlp?=
 =?us-ascii?q?oWrUTDBij2mFjqjKOOdkUr5Oyo6+P/b7v+upKSMJJ4hhznPqkzgsKyAv00Mg?=
 =?us-ascii?q?8VUGeF4+i806Dj/VHiT7VNk/02lLTWvIrCJcQBoa65HxFa3Zo/6xa+CDem1s?=
 =?us-ascii?q?4UnX4aLFJZfBKHiI/pO1LULP/kCve/hkygkDZtx//YIr3sGojBImTMnbv7cr?=
 =?us-ascii?q?tw6VRQxQowwNxF+p5ZCKwNLOr2WkDrtdzYChE5Mxazw+biENhz2IMfWWaVDa?=
 =?us-ascii?q?+fKq/cs1iI5+wxLOiMf4IVpCjyK/4j5/H0i385hUMSfa6z0ZQLb3C4G+xqI1?=
 =?us-ascii?q?+Fbnr0ntcBDWAKsxI9TOzsklKNSyJcZ3WoU6I8/Tw7B4emDIjZSo+wnrOLxD?=
 =?us-ascii?q?27EYFOZmBaFlCMFm/ld4eFW/gQdi6fLNRskj8aWri7TY8uyxWuuBX9y7p9Ie?=
 =?us-ascii?q?re4jcYuo771Nhp++3Tkgk/9ThuAMSHyGGAVGR0kX0URzAs0qB/pkt9xk2e3q?=
 =?us-ascii?q?dmm/ZYD8Bc5+tVUgcmMp7R1/R6C9XsVQ3fZNeIRk2rQs2jAT4vUN0x2dEPb1?=
 =?us-ascii?q?x7G9q8khDJxzCqDKMNl7yXGJw09brR33zwJ8Z71nbH27Atj1gnQstILmCmmK?=
 =?us-ascii?q?F/+BbJB4LTkEWWibyqdaIC0y7J7muDynCOvE4LGDJ3BIfCW3kDZkLQ5f/w40?=
 =?us-ascii?q?7YSLnmXbYmOVEa4c2PMK1Hbpvul1oQAL/DMc7CZn+t00S2DB+DxfvYb4zjcm?=
 =?us-ascii?q?4emiX1B00U1QweqzLOEQEkHWKZrn7TFnRFEVvyeE7qub16oWmgZko50wiEaE?=
 =?us-ascii?q?on27fjvlYtiOCRUbs2078epy4lp3BPAF+x29/MQ46YogdsZrp0edYw7U1Yk2?=
 =?us-ascii?q?TUq1ouEIanKvVOl1oXdUxXuFzjxl0jJpREmM5sjHQ1wRtaNa+e1lpHazifm5?=
 =?us-ascii?q?v3P+uEeSHJ4BmzZvuOiRnl29GM9/JKsaxg8Q+xtRy1Fkck73Rs2sVU1H3Z/J?=
 =?us-ascii?q?jREQ4OSsyhAF0v+U18oLfXKmkm6oXY2GckEJH8sySKmrdLTPAg1g7met5eNK?=
 =?us-ascii?q?2eEwqnP9weDs7oCOs1lkmBch8COulU6KUzecihcqjO1Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2EeFAC8JTte/6s6L2hlhBVQXoEIAwQ1CodSAQGFOoVBl?=
 =?us-ascii?q?wSDbYFCgRADVAkBAQEBAQEBAQEHAS0CAQEChD43gio4EwIDAQwBAQEEAQEBA?=
 =?us-ascii?q?QEFAgEBAQECaYU3DII7KQFxcQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQUCgQxAFhUZAQERJgEoZAYrARIigwSCSwMuAaBuPgIjAT8BA?=
 =?us-ascii?q?QuBBSmIYQEBgXMzgn8BAQWFLBhXgTUJCQGBLodEhG2BTD+EYoQyhgeYBJdmB?=
 =?us-ascii?q?4I9fJU7J4JIjFeLaQGLAINilyGDfgIEAgQFAg4BAQWBaSOBWDMaI4M8UBgNj?=
 =?us-ascii?q?ikXg1CKciQxgQUkjBYBgQ8BAQ?=
X-IronPort-AV: E=Sophos;i="5.70,407,1574143200"; 
   d="scan'208";a="17204689"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.tennantco.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 14:33:02 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moLDVdO8I+8nW6+/uktGVVjsokfvmUYe+Yq7OW4cNAePgAhC7w4ai2YPs8u3AePiNNKv6FcZbMJ3BXIYlmUYEuGB5Z4utZV63S6s/qm/D4FMxBCr7NKdNEUO5wszLAFrilXpMgXzoEom+S0+6YubfFgAZqr0MsQu6eoVwzlbhbkIPvN2MU5w3xbKiM1euYnGU7JUOqaBXoWUcLif7o5Yd/+rW1zeGmJgbr8J9jDjmHyp8QbRPzqAqz2NI8hjc40S755kQUjCljZExWoLAIwVg6eDi+6jmlU7oEcLweMriixCI+16zKM1Fa2EKwlGbFCbVEsp6+kvSiUhUG7pz+TAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIUV8ZK2wVZNknl+9N6O5UArZ5tMGnzFxLcU3HzLQjY=;
 b=XiYLh/kgcE+j7iOo70l+aiuvU+Q3bGjiHn1O9rnm1rG2MxCgPBvvYXCiA4WMQwazy4bzNaBMaenMUD2/kqEKGJtRlwaVMwRZZjQgBCc5wOKiKCyIp7MT2b8Pa+vyqBgw53ZSQ245/s6IDljgVzcv78Tn2YX/aNlRzKhj8LievPiMBpFzQ3pHTc42KIcjlToBrmt57B5FiCtHTEEpvRVg1aLKBn1NMz/lyjfVl3bCIoQ/G6y/BvrBmjd28NZsmnT64YKpVPv1rz561W/kfEXWXDkTHeEaIytJZsTr1mSBGQmfM1RImAx6R965f5SmOFcc42Z6j5TwYQyQIyN4AbgG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tennantco.com; dmarc=pass action=none
 header.from=tennantco.com; dkim=pass header.d=tennantco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tennantco.onmicrosoft.com; s=selector2-tennantco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIUV8ZK2wVZNknl+9N6O5UArZ5tMGnzFxLcU3HzLQjY=;
 b=pG0bDUbdQVKeuJZaFno8AkEQLEVsfftV5P+HGc45MMxcIGzIuPuMGG/gj8oSUrPLVfyAXKjsnEmtqFbTxyKnYy9L9ysPLL0eMJfV3TOKzo+RxOLty0L68WMBEoxWOOdb9sox+Femb0dZ5iiN0kYVn/VG6io7WHWDLOOWD+de+WA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Dylan.Howey@tennantco.com; 
Received: from CH2PR20MB3271.namprd20.prod.outlook.com (10.255.156.30) by
 CH2PR20MB3176.namprd20.prod.outlook.com (52.132.230.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 20:33:01 +0000
Received: from CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::5c21:1e0a:4a39:593b]) by CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::5c21:1e0a:4a39:593b%7]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 20:33:00 +0000
From:   Dylan Howey <Dylan.Howey@tennantco.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, Dylan Howey <Dylan.Howey@tennantco.com>
Subject: [PATCH] iio: accel: mma8452: Expose temperature channel
Date:   Wed,  5 Feb 2020 14:32:40 -0600
Message-Id: <20200205203240.13550-1-Dylan.Howey@tennantco.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:610:50::13) To CH2PR20MB3271.namprd20.prod.outlook.com
 (2603:10b6:610:2::30)
MIME-Version: 1.0
Received: from Dell-Inspiron.localdomain (198.204.33.200) by CH2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:610:50::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 20:33:00 +0000
Received: by Dell-Inspiron.localdomain (Postfix, from userid 1000)      id 2C008D404A8; Wed,  5 Feb 2020 14:33:00 -0600 (CST)
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [198.204.33.200]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0865c30b-43dd-4459-00f8-08d7aa7a97dc
X-MS-TrafficTypeDiagnostic: CH2PR20MB3176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR20MB3176639D2434AD4648968EAAEF020@CH2PR20MB3176.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(110136005)(52116002)(26005)(36756003)(1076003)(42186006)(66946007)(6266002)(86362001)(6666004)(316002)(5660300002)(66476007)(66556008)(2616005)(478600001)(81166006)(81156014)(2906002)(8936002)(8676002)(4326008)(186003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR20MB3176;H:CH2PR20MB3271.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: tennantco.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HW82zNW5HNDP6LPYjBKECKhTRZYzHITfu0nXNfazoN4XrtxoqFz2p5hA1Ql/G7YupyrG1JjTouxRN/hxNSo0mqC5l/dOeqtCgjAaqH1OrSnIvrv0S5eL52+jYFwVh1Tbj4YGqLQjgT1TU6uFQnw01FCU1Dl44j5X31HhLiwfdv0Xj8PI2ECpC/csgmPyQMTeinCdSvikuk3jOvXPo5sdlEm9FzfBPqe9An7FlzC69xcn7rhQ7h1cw4J9TFo/Ic5KAg5BRjCnQVyqbp67NWtrh2YzqvSE+HAOX8FRG6VAP+Vn7t3iBgjitia+7akYe56ld4XZgMVFcTWE+FemkG29krU/tSg+RfrHvAB+Posov3JKY0T7wD/CTbU6tdN/Jmet7HCRg8kBJcUXI5ow2N5QrokqOWBDkuURr0ztnynE1c11fS/LyL1dG19CWn4bN5IP
X-MS-Exchange-AntiSpam-MessageData: CuofNQfaEAOCJkjV+VIpZd05u2wx24MoVqEgT3aaKLiDSd9zwqsreUONLYTDL6FhW/uJaihyZp7LIovYu1ODJzDGgg7KviJyfOJlQdWspKwqHy8/H4XWc0yA+dVyxXY1fb61b31ze8AShToYrmgoZw==
X-OriginatorOrg: tennantco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0865c30b-43dd-4459-00f8-08d7aa7a97dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 20:33:00.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 854ee4fb-bf50-420c-8a26-5b96d626ac37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nAUisG+yYlD13/wkdaCN0HXeIaYgYbaJUmMwxjp54butMi2mSE+7u6pdz3NbH5BnJgKNve50wUNDlNN/uND7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR20MB3176
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

FXLS8471Q devices support temperature readout as 8-bit signed value,
0.960C/LSB, -40C to 125C.

Enabling temperature readout reduces the selected ODR by a factor of
2, e.g. with ODR set to 800Hz and temperature enabled the sample rate
will be 400Hz.

Signed-off-by: Dylan Howey <Dylan.Howey@tennantco.com>
---
 drivers/iio/accel/mma8452.c | 119 ++++++++++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index eb6e3dc789b2..016dcc14e96e 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -83,8 +83,13 @@
 #define MMA8452_OFF_X				0x2f
 #define MMA8452_OFF_Y				0x30
 #define MMA8452_OFF_Z				0x31
+#define FXLS8471_CLEAR_DRDY			0x33
+#define FXLS8471_TEMP_OUT			0x51
+#define FXLS8471_TEMP_EN_MASK			GENMASK(1, 0)
+#define FXLS8471_CTRL_REG6			0x5b
+#define FXLS8471_CTRL_REG7			0x5c
 
-#define MMA8452_MAX_REG				0x31
+#define MMA8452_MAX_REG				0x5c
 
 #define  MMA8452_INT_DRDY			BIT(0)
 #define  MMA8452_INT_FF_MT			BIT(2)
@@ -103,6 +108,7 @@ struct mma8452_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	u8 ctrl_reg1;
+	u8 ctrl_reg6;
 	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
 };
@@ -113,6 +119,7 @@ struct mma8452_data {
  * @channels:			struct iio_chan_spec matching the device's
  *				capabilities
  * @num_channels:		number of channels
+ * @avaiable_scan_masks:		bitmask of available scan elements
  * @mma_scales:			scale factors for converting register values
  *				to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
  *				per mode: m/s^2 and micro m/s^2
@@ -139,6 +146,7 @@ struct mma_chip_info {
 	u8 chip_id;
 	const struct iio_chan_spec *channels;
 	int num_channels;
+	unsigned long available_scan_masks[2];
 	const int mma_scales[3][2];
 	u8 ev_cfg;
 	u8 ev_cfg_ele;
@@ -156,6 +164,7 @@ enum {
 	idx_x,
 	idx_y,
 	idx_z,
+	idx_temp,
 	idx_ts,
 };
 
@@ -204,7 +213,7 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 	return 0;
 }
 
-static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
+static int mma8452_read(struct mma8452_data *data, u8 buf[7])
 {
 	int ret = mma8452_drdy(data);
 
@@ -216,7 +225,19 @@ static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
 		return ret;
 
 	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
-					    3 * sizeof(__be16), (u8 *)buf);
+					    3 * sizeof(__be16), buf);
+
+	if (FXLS8471_TEMP_EN_MASK & data->ctrl_reg6) {
+		buf[6] = i2c_smbus_read_byte_data(data->client,
+							FXLS8471_TEMP_OUT);
+
+		/*
+		 * A read of the dummy register 33h is required to reset drdy
+		 * for the next interrupt cycle after reading the temperature.
+		 * Value read from register is don't care.
+		 */
+		i2c_smbus_read_byte_data(data->client, FXLS8471_CLEAR_DRDY);
+	}
 
 	ret = mma8452_set_runtime_pm_state(data->client, false);
 
@@ -454,7 +475,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
-	__be16 buffer[3];
+	u8 buffer[7];
 	int i, ret;
 
 	switch (mask) {
@@ -470,17 +491,37 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		*val = sign_extend32(be16_to_cpu(
-			buffer[chan->scan_index]) >> chan->scan_type.shift,
+		switch (chan->type) {
+		case IIO_ACCEL:
+			*val = sign_extend32(be16_to_cpu(
+			*(__be16 *)&buffer[2 * chan->scan_index])
+			>> chan->scan_type.shift,
 			chan->scan_type.realbits - 1);
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			if (!(FXLS8471_TEMP_EN_MASK & data->ctrl_reg6))
+				return -EINVAL;
+
+			*val = sign_extend32(buffer[6], 7);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		i = data->data_cfg & MMA8452_DATA_CFG_FS_MASK;
-		*val = data->chip_info->mma_scales[i][0];
-		*val2 = data->chip_info->mma_scales[i][1];
-
-		return IIO_VAL_INT_PLUS_MICRO;
+		switch (chan->type) {
+		case IIO_ACCEL:
+			i = data->data_cfg & MMA8452_DATA_CFG_FS_MASK;
+			*val = data->chip_info->mma_scales[i][0];
+			*val2 = data->chip_info->mma_scales[i][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = 960;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		i = mma8452_get_odr_index(data);
 		*val = mma8452_samp_freq[i][0];
@@ -517,6 +558,12 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 
 		*val = mma8452_os_ratio[ret][i];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 50; /* 0 LSB @ 25 degree C */
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = !!(data->ctrl_reg6 & FXLS8471_TEMP_EN_MASK);
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -731,6 +778,16 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			}
 		}
 		break;
+
+	case IIO_CHAN_INFO_ENABLE:
+		if (val)
+			data->ctrl_reg6 |= FXLS8471_TEMP_EN_MASK;
+		else
+			data->ctrl_reg6 &= ~FXLS8471_TEMP_EN_MASK;
+		/* Note: enabling temperature reduces ODR by a factor of 2. */
+		return mma8452_change_config(data, FXLS8471_CTRL_REG6,
+				data->ctrl_reg6);
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -1003,10 +1060,10 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mma8452_data *data = iio_priv(indio_dev);
-	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
+	u8 buffer[16]; /* 3 16-bit channels + temp + padding + ts */
 	int ret;
 
-	ret = mma8452_read(data, (__be16 *)buffer);
+	ret = mma8452_read(data, buffer);
 	if (ret < 0)
 		goto done;
 
@@ -1159,6 +1216,19 @@ static struct attribute_group mma8452_event_attribute_group = {
 	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
 }
 
+#define FXLS8471_TEMP_CHANNEL { \
+	.type = IIO_TEMP, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) | \
+		BIT(IIO_CHAN_INFO_ENABLE), \
+	.scan_index = idx_temp, \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = 8, \
+		.storagebits = 8, \
+	}, \
+}
+
 static const struct iio_chan_spec mma8451_channels[] = {
 	MMA8452_CHANNEL(X, idx_x, 14),
 	MMA8452_CHANNEL(Y, idx_y, 14),
@@ -1199,6 +1269,15 @@ static const struct iio_chan_spec mma8653_channels[] = {
 	MMA8652_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
 };
 
+static const struct iio_chan_spec fxls8471_channels[] = {
+	MMA8452_CHANNEL(X, idx_x, 14),
+	MMA8452_CHANNEL(Y, idx_y, 14),
+	MMA8452_CHANNEL(Z, idx_z, 14),
+	FXLS8471_TEMP_CHANNEL,
+	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
+	MMA8452_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
+};
+
 enum {
 	mma8451,
 	mma8452,
@@ -1213,6 +1292,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 		.chip_id = MMA8451_DEVICE_ID,
 		.channels = mma8451_channels,
 		.num_channels = ARRAY_SIZE(mma8451_channels),
+		.available_scan_masks = {0x7, 0},
 		/*
 		 * Hardware has fullscale of -2G, -4G, -8G corresponding to
 		 * raw value -8192 for 14 bit, -2048 for 12 bit or -512 for 10
@@ -1237,6 +1317,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 		.chip_id = MMA8452_DEVICE_ID,
 		.channels = mma8452_channels,
 		.num_channels = ARRAY_SIZE(mma8452_channels),
+		.available_scan_masks = {0x7, 0},
 		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
 		.ev_cfg = MMA8452_TRANSIENT_CFG,
 		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
@@ -1253,6 +1334,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 		.chip_id = MMA8453_DEVICE_ID,
 		.channels = mma8453_channels,
 		.num_channels = ARRAY_SIZE(mma8453_channels),
+		.available_scan_masks = {0x7, 0},
 		.mma_scales = { {0, 38307}, {0, 76614}, {0, 153228} },
 		.ev_cfg = MMA8452_TRANSIENT_CFG,
 		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
@@ -1269,6 +1351,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 		.chip_id = MMA8652_DEVICE_ID,
 		.channels = mma8652_channels,
 		.num_channels = ARRAY_SIZE(mma8652_channels),
+		.available_scan_masks = {0x7, 0},
 		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
 		.ev_cfg = MMA8452_FF_MT_CFG,
 		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
@@ -1285,6 +1368,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 		.chip_id = MMA8653_DEVICE_ID,
 		.channels = mma8653_channels,
 		.num_channels = ARRAY_SIZE(mma8653_channels),
+		.available_scan_masks = {0x7, 0},
 		.mma_scales = { {0, 38307}, {0, 76614}, {0, 153228} },
 		.ev_cfg = MMA8452_FF_MT_CFG,
 		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
@@ -1299,8 +1383,9 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 	},
 	[fxls8471] = {
 		.chip_id = FXLS8471_DEVICE_ID,
-		.channels = mma8451_channels,
-		.num_channels = ARRAY_SIZE(mma8451_channels),
+		.channels = fxls8471_channels,
+		.num_channels = ARRAY_SIZE(fxls8471_channels),
+		.available_scan_masks = {0xf, 0},
 		.mma_scales = { {0, 2394}, {0, 4788}, {0, 9577} },
 		.ev_cfg = MMA8452_TRANSIENT_CFG,
 		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
@@ -1340,8 +1425,6 @@ static const struct iio_info mma8452_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static const unsigned long mma8452_scan_masks[] = {0x7, 0};
-
 static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					      bool state)
 {
@@ -1487,7 +1570,7 @@ static int mma8452_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
-	indio_dev->available_scan_masks = mma8452_scan_masks;
+	indio_dev->available_scan_masks = data->chip_info->available_scan_masks;
 
 	ret = mma8452_reset(client);
 	if (ret < 0)
-- 
2.17.1

