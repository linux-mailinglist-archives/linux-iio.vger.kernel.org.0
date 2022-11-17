Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35BD62E9C7
	for <lists+linux-iio@lfdr.de>; Fri, 18 Nov 2022 00:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbiKQXnu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 18:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbiKQXnm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 18:43:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F7A451
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 15:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1668728607; bh=OrLBMed6ZHmDPzSPtZqNsBpkm0DKoQGZyE9AcMIGK2Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Uv9uZWuiiefC0BMFPEz1F7KNx4cz7EZPfDsnDIpqVhqP9iLfyPinzI4eQrsoaXONl
         DqvgM5y5tvvv83pDqXHZxusirjRcKkAb1nmcLARE0gNZMvzZeb/pdhH60dxYaTJsEj
         yOAeupFuO4357sOjaSX2gAqkhv3HrGaifiY+Rr33+F5SWTj/7zOUbW+3EbH1+8N/kB
         4bXYc3wH3lktG9Oh3SFAlFNmNxGXtv43lfrJRAgTbAwiVU1wmjQN7HiKi4buLacdIQ
         qRjSfVmj8GhPjMg4pzJbL4Wel3Jnxa/ZvoUvQVpkozZX30456iPqgD8ACN8xQtLtvV
         nyz9r80PxPhWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.31]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MbAcs-1pX5EN0Po8-00bduS; Fri, 18 Nov 2022 00:43:27 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH v2 2/4] HID: hid-sensor-custom: Add LISS custom sensors
Date:   Fri, 18 Nov 2022 00:43:00 +0100
Message-Id: <20221117234302.3875-2-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117234302.3875-1-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
 <20221117234302.3875-1-p.jungkamp@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ONBvvDKhoEtO14roUmTVNN2fiXj6vwxKug90caj1PDqBFWqfz2z
 idAlYpLyEhwjF2NU/LmGTtjYwhxp7nM7Na3IVDaK8tVd7EhcTdScx1+IpI92eI9aDqgDhCJ
 pTcyB9kCQGcgSIWVdQM/lfastulvnUybt1MXjXICbH4hUOzyZ2yojexa6OSV1fpNoR3U39m
 NMH0Lnq9j/RL5afq9p7Qw==
UI-OutboundReport: notjunk:1;M01:P0:bBYOZbcKTIU=;IB049hPRiBatN94fvs6XdAfniN2
 f8/DGK0gHoEWpHRZuKCilZDJoESXzjsZ/6N65+4J8hpzzOOoquwZtSxIu3xiJclFUPVtAxzwx
 xva8OLOK0HXRBoBZp+yRnOusvFngfOIlOWzgLiNuokT1CjK3JfuGA5jVt8swbboQJxgytgOzu
 UK/hlWsHVnj9CEc7/NIrcspCmXumEV7oEFK54Xy4Dyi127XnhPRZQsErryTLDE3l0cxUGWeWK
 nilpQIWi/gBFRMxuWpND5qK/jDygbHZ2B5p7IGdZ2N/ajMvSnae81wRKUzZWgoPBeEGZCq94R
 STy/G8spdlUrBoIeEpvefQ5WvbdffhxtAvTQqayr3qazsuX7r7XV/6jxUcMAxYjevcXfl4+1C
 4FCzloJbF6kowh4sau37XXmI1e8BmmC9N7FnA0Ebks86T7rE5vSJPiPQkYXzzR+aj5wt/gebA
 HuEju+n6dCILveWYZHnr+x9mUW0obxw5Yra4IJ6x9josNlgiigSi+8WEF14oCpY/oC1MbAcGY
 eVZMY6cwIHc1FuWIOMfspSniBCcW2GUc/j2ODYURp+pXaTcN42LOQx3FJGVf02/aE4vKuBa4Y
 cOOdvYmDAmkAkfcPXHKh/5ncYkQo1jctvXQCit+EUUeT4ieeO2MsASwQsMXMojaYqEHQ7Czj0
 +GPcXjeJ01Wr/TgbUeJ6ZDpnR0zEAGG44KFNl+QemZsKy6wfBAp6KhiwU59p1ciVvwpPOsxM3
 EFEaTE54AhOtOk/p8ir3Xl3UKWRtLHCkVNnk9gF9pxMMW8yqK/pIM7L+7nUvt1pNzvr+wqJ1E
 V4SJS5pa+SeTLWp71Ey2gr+i0CopWAiIeQDjo6X7uFX6SoDHPvCD9aQA8Y25DBC1X0QUtqyIU
 BmFLLRrP0XsJD7UPY1C+xGjRyVnvt96pw47NQZEAoq7hYdR/WZt4UFOAzUOlEg1g7+JTFlJPU
 7JWcBw==
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

