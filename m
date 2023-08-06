Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492B477151F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Aug 2023 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjHFNHA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Aug 2023 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFNG7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Aug 2023 09:06:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA3319A6
        for <linux-iio@vger.kernel.org>; Sun,  6 Aug 2023 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1691327199; x=1691931999; i=p.jungkamp@gmx.net;
 bh=1cntvCccU9PIxnQIHTK24pvznNp8Y0OyrDsIxorKFSc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=jzpG6WvWZlvyDaQMK3wK6DxjLdt4p5ikIiePleqHzCh7LgFGVX67f7Ay1rOBGxYTbwzfJKc
 VZLaXi2YKuAFWbCnzARmPivTRlsHdTJphLybXYh08I4nXLzEfQfePNiILCSP2n1rexhmAIdwT
 tyd2B2ZlUBB8BtutGxnZpYuy2YXKkZFkXPNvNuRxuybcqGKeDdy0gx0GGhsxXosyxHrQW6ZgO
 +pnzRJQlrfpQ39pJJI3VUBwhbt/9oTpE95WbOVLOrtgNyrkjN+sE+fpAmLthMjkNxR2/3NM6u
 waUbZkjNw2iXbBsZxM+qkF1TgOhZ1n3eZkc0m9mhJSUrrnUjOqbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from yoga9.fritz.box ([79.193.195.172]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGr8-1qKSuX12dC-00Yl3A; Sun, 06
 Aug 2023 15:06:39 +0200
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
Date:   Sun,  6 Aug 2023 14:59:26 +0200
Message-ID: <20230806130558.89812-2-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gXuuZG9e/q5Cv3eqhh5b/8GV/dkW2wmTCNM17Lth/TvmQYEs7Xc
 Bcn8ToWmwJHAb6gfPyJVx/527f1Lr6ip5unrJ1Bm0sGhrMOt+UvrIuQdSqsR1PM2VHMTDe1
 2Qv8HtaZJd1Gau/FMc9KhP73FTb0wjmV79gJQu+jWLCscd148reJYPfOxYi+SAzpRlYXHLO
 ExZwmrhVI3kCH8bGqyyWA==
UI-OutboundReport: notjunk:1;M01:P0:zkTaFwbUU14=;raRRE1EnwLik60/+82BFGIaKeQs
 9yvM1Xj+J7Kc8ps3oKrhiDYquf1VYnSv6G2V3BNLtvzXz3FQEvTqfWt9mxh1rPCCIwkyIaxZq
 vz/Sn7n+2sWnKN4epFbvEECClbAAlTdY30ZXWaadlL7RKnFS2eD7mwKImRUi89Xq1gMz4wSys
 SjT9bhK3QKczq+yY/eVdMYPIdjrNCxyVBtgwWeDl9f3bCDMkc2xL5LHtyg9BgcBnsNTXkaj2L
 CHS7AIY19xwkanFo95YOwjLHoFqp+AIXbTUcn9UNG/h7FHhBUX/SFr17KVIjC/npCS86lew+l
 WIuBmhpISMVDJ4jD/GxXNK7mQxm0jGKsfFtXsx+x587lqFLhTo85flrGnBA/yIjIoFHM4nPYs
 fNCeu77QwFGUWOQjSR9wd1UOt60cVup+1f5k3AdXaes7a6J2MwVkuG8z72U3IR6ttWrbs0wDT
 1K5646FGxs7Labp66acEz8SZkUWAXLTID9Wwoy3v0Fx6UHcFMO9nX6LmotrPbowOe8no93nyS
 pCml6Ek9jMyApoK7XlPf6BX+dxjgjv/+VOp0utCeqFzMBVh1JT45jv4tIHswlo9nbbdWWUE8a
 Iq/pSOeneWK/wkVuvzz/JZ7uZlSoQCh+TEvGHh4Q0Vh/KbH9DcngT0mZB/zmIvUhF0C+JfYcv
 p3+/2l8r2AZPZBHS8RsjmGdmvzxHnmWZFplQiyUUR1gPYfk1cdUsnUbWS87DoH1T5xM6nF3pY
 fQLOZ+OyBaby4Q7tcCchLefr8xWLoQOyIzPnCJD7u8PkkiP2icCNi1m5AquXRZXDHZ2inM5/B
 5e7+CkOBXk+5UEXsxY4n+SKPW0g3SOWXsel0AiN6JeMqRm8kejb3Th5O/NNc/McIpw+d87Ypi
 yV9kgY3VUE6zuiFXohpS/gJN/zPez0KS4kFm3K6zI5h3RdWk0lxMDFmSpJC7RWnWGQ3nral+2
 nBrqMwODLCS76qr/SX8kzjJIbJA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The hid-sensor-prox returned an empty string on sysfs in_proximity_scale
read. This is due to the the driver's scale never being initialized.

Try to query the scale of the HID sensor using hid_sensor_format_scale.

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--
Hello,

up until now I've used the sensor directly through the buffered IIO interf=
ace,
ignoring the in_proximity_scale attribute. But while integrating it with
iio-sensor-proxy I noticed that a read on scale return an empty string,
breaking the code there.

Looking at the code in `hid-sensor-prox.c` it is fairly obvious that the s=
cale
just wasn't being initialized. I now added the hid_sensor_format_scale cal=
l
similar to the ones found in e.g. `hid-sensor-als.c`.

Regards,
Philipp Jungkamp

 drivers/iio/light/hid-sensor-prox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-s=
ensor-prox.c
index a47591e1bad9..aaf2ce6ed52c 100644
=2D-- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -227,6 +227,9 @@ static int prox_parse_report(struct platform_device *p=
dev,
 	dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
 			st->prox_attr.report_id);

+	st->scale_precision =3D hid_sensor_format_scale(usage_id, &st->prox_attr=
,
+				&st->scale_pre_decml, &st->scale_post_decml);
+
 	return ret;
 }

=2D-
2.41.0

