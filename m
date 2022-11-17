Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E662E9D7
	for <lists+linux-iio@lfdr.de>; Fri, 18 Nov 2022 00:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiKQXtK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 18:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiKQXtH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 18:49:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB6528BF
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 15:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668728938; bh=oNUFG+zVXBZTn6a9L42OesJqyqm7jfClcKQ1QvZfqLA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ENGdSRbtUD/LMic07aMe4ZMweiy0cOXMrOiV+qo9Uib8AZkdZaPxs7LfUvzAMmI0Q
         lCr1xk+P75hqcY8F36d3ZPLonzKM0vSRuCDjFOd9QfVB2y0xePsgBFhkTerA+rqmeg
         Zd9K+xPXsuwT459xMMWtP5bwPK2N07mOwLMlJ5MIrCQV3g0DwPgvkqDCiI2JuXT/Ln
         s+MsM/5QltUmofmV6qiK/EfSGHHJGf6qV7T2fXMU+i6/4LAQ+x4OIlXmlervNdtOEJ
         W2zGm6pe4f825FjvnuZ9rmKUs7FOgU/OLVSIB/4yh4fU9ZlRcpwwdxnd6fYBrv2PSH
         sUyC++2utzVng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.31]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M1Hdw-1oxSW819vW-002oix; Fri, 18 Nov 2022 00:48:58 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH v3 2/4] HID: hid-sensor-custom: Add LISS custom sensors
Date:   Fri, 18 Nov 2022 00:48:22 +0100
Message-Id: <20221117234824.6227-2-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117234824.6227-1-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
 <20221117234824.6227-1-p.jungkamp@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mk5soXo7846gxSR7IROUJyjnh9yxWZJKx1M7fMr2a13FrgmUSiR
 GAE1BwMAQ8KqfD+SB5tmrWcxq9KIJ/KgXr2iigJiirls0Tfo9dVYFjWcbrUZCRJljmEnLCc
 pFOan/hBqEXn5oc7R7e7M0l2hAbOXZXoXPTBJXKiYkFfAZUU8dyG0d8qMb4J8zg4Z6sWd7E
 yhG0mmUdXZH0ypuxqLDvg==
UI-OutboundReport: notjunk:1;M01:P0:v0v1/2Kwl/w=;flv8MUygq/s58Ri3omixtG/gmFU
 AiKwWroCFuajuf36eO3O4WIaf+yRV1mJ7e8eaZVZxOBhXNyQkfdiAtucTpwQxnsQ3oKaU2iMW
 dCkrbS1W6eZ53dDYCTlfSkR1PGfa5jSKV4uYD2uUeX5hsoSMfLp52JVVJ49hhVt3PgVta6osE
 TlwD4w+S2p6YnagKtkdpRtdCh8wZ8DbEoTMlMfnfRfTB5rnTzvfkPifIrz9/zY5uoE/9xX42w
 +IPObMt7a58HQCH40hOE+9hnh8otDxNPO5bb8ISqRDnW9vET/tlMvphOtZiF+2mMbPLfRMlXz
 qSxupjzgin2tR3WvKuGnPX0+8q9uxDjjlsSzGxxc6yU1QWFzFOjg/7cGPJXvqVQrf4Cq0JtVC
 xapCLviqC8HNMBtWWIrezedOrgjhA+KKBdg+RntQAdC0yyHmTQe82gIeT4cQmorVY+c8dzCty
 IHTRipsHeK6xOseujgc7ooV6YACtLbW2RGcTDgx81uAjrXiqyzgjKrxepMYYhBIb0T46je0nX
 RyPL2E2mKJRIJM1Znx8MZBws6878Bu/p3y0E4hqGjczfmbwC3An4qiR+/8739ryp+pGEjctTL
 53DldcJXcd+EliEZySa+DQIlRt2w21U3wNUPRLOP71vJwwIi0zk72Jvyf3T9ZG6t3kq5It86Y
 /XbP6pFwht5FJKmi5CyQvP4XcE0ma6FoSdSNMRjN6sg68etsgX3hszdGdmWPSCmld3BTOGbKh
 EO88V8o6xQZnf5oj7v6TDb52Q8WzNgBqxoOeFZZXrJFHpM9+Fyc9oKeAi+zkELxEx0cfzhmuu
 +D/o7vswv+ARec/LeV7XsRJULtCiROfr4zcU+z3T1CoNEJuqa3FK7Rru71WUUi5xCMuNH9SUi
 l8dA1QLy8KSuRfMQJJMIfxoI3DotCqFf/3KK7spTXqVCZkVwHut1kLqzsXpVvH5m8gKfZy4Cv
 ESLrUQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the Lenovo Intelligent Sensing Solution (LISS) custom sensors to the
known custom sensors.

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--
Here is the requested noop commit that changes the device ids for the know=
n
LISS sensors.

 drivers/hid/hid-sensor-custom.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cust=
om.c
index 89e56913c92e..85db14406b23 100644
=2D-- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -782,6 +782,29 @@ static const struct hid_sensor_custom_match hid_senso=
r_custom_known_table[] =3D {
 		.luid =3D "020B000000000000",
 		.manufacturer =3D "INTEL",
 	},
+	/*
+	 * Lenovo Intelligent Sensing Solution (LISS)
+	 */
+	{	/* ambient light */
+		.tag =3D "LISS",
+		.luid =3D "0041010200000082",
+		.model =3D "STK3X3X Sensor",
+		.manufacturer =3D "Vendor 258",
+		.check_dmi =3D true,
+		.dmi.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		}
+	},
+	{	/* human presence */
+		.tag =3D "LISS",
+		.luid =3D "0226000171AC0081",
+		.model =3D "VL53L1_HOD Sensor",
+		.manufacturer =3D "ST_MICRO",
+		.check_dmi =3D true,
+		.dmi.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		}
+	},
 	{}
 };

=2D-
2.38.1

