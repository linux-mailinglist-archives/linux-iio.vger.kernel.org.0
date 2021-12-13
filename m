Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDD5472BB5
	for <lists+linux-iio@lfdr.de>; Mon, 13 Dec 2021 12:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhLMLnf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Dec 2021 06:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhLMLne (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Dec 2021 06:43:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896AC061574
        for <linux-iio@vger.kernel.org>; Mon, 13 Dec 2021 03:43:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mwjjw-00079I-GT; Mon, 13 Dec 2021 12:43:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mwjju-004IlV-8u; Mon, 13 Dec 2021 12:43:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mwjjt-00027A-BS; Mon, 13 Dec 2021 12:43:29 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] counter: ti-eqep: Use container_of instead of struct counter_device::priv
Date:   Mon, 13 Dec 2021 12:43:12 +0100
Message-Id: <20211213114312.1406562-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=2vlFU+eqwS9veDOtlDpdAxKEuDo83KhQdLwHLGFe+dg=; m=FNxM8XON3yPSC37Azgc7BAi0QseP+ddPj8+Jc+Fmvks=; p=ToLiUo9JbuW9MKjyCTzjhJdpYDvBg97FdWHRg/JnmlE=; g=9459ad8bc78190558df9123f8bebe28ca1c396ea
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmG3Mc0ACgkQwfwUeK3K7Ak5DQgAgy6 QahQMvhDIOiVUc2sMaSRam9BfqlS9+FCrtbiCiZVD2/36ftqwlIinr1j510xmPH3O4d+oWjyz3pHr Oj/+SReeL/zqzMl/W77Yd2OR6QuIvXRnPSux8yns8fxxdB0exI9kuKaVLy5lQ9xlVdUw+P4ZtKUiG bPUR9QvWexreypGAy8QJsTvOW3HUVtQNJUcXX4SKXTGSip0szFsXsdGryEyRnwwmpIvBUUn8Vq8Qc a5vnwLNHcbmWjZs6zAhDQiTfxTFLFunePOe+5u8xnUbOc4DwT1RYNHQIIHU1quldUvMqaGW4crClb EovWn3S1sFG4WeWf7TkmbQ/FrkMINHQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Using counter->priv is a memory read and so more expensive than
container_of which is only an addition. (In this case even a noop
because the offset is 0.)

So container_of is expected to be a tad faster, it's type-safe, and
produces smaller code (ARCH=arm allmodconfig):

	$ source/scripts/bloat-o-meter drivers/counter/ti-eqep.o-pre drivers/counter/ti-eqep.o
	add/remove: 0/0 grow/shrink: 0/9 up/down: 0/-108 (-108)
	Function                                     old     new   delta
	ti_eqep_position_enable_write                132     120     -12
	ti_eqep_position_enable_read                 260     248     -12
	ti_eqep_position_ceiling_write               132     120     -12
	ti_eqep_position_ceiling_read                236     224     -12
	ti_eqep_function_write                       220     208     -12
	ti_eqep_function_read                        372     360     -12
	ti_eqep_count_write                          312     300     -12
	ti_eqep_count_read                           236     224     -12
	ti_eqep_action_read                          664     652     -12
	Total: Before=4598, After=4490, chg -2.35%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ti-eqep.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 09817c953f9a..9e0e46bca4c2 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -87,10 +87,15 @@ struct ti_eqep_cnt {
 	struct regmap *regmap16;
 };
 
+static struct ti_eqep_cnt *ti_eqep_count_from_counter(struct counter_device *counter)
+{
+	return container_of(counter, struct ti_eqep_cnt, counter);
+}
+
 static int ti_eqep_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 cnt;
 
 	regmap_read(priv->regmap32, QPOSCNT, &cnt);
@@ -102,7 +107,7 @@ static int ti_eqep_count_read(struct counter_device *counter,
 static int ti_eqep_count_write(struct counter_device *counter,
 			       struct counter_count *count, u64 val)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 max;
 
 	regmap_read(priv->regmap32, QPOSMAX, &max);
@@ -116,7 +121,7 @@ static int ti_eqep_function_read(struct counter_device *counter,
 				 struct counter_count *count,
 				 enum counter_function *function)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 qdecctl;
 
 	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
@@ -143,7 +148,7 @@ static int ti_eqep_function_write(struct counter_device *counter,
 				  struct counter_count *count,
 				  enum counter_function function)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	enum ti_eqep_count_func qsrc;
 
 	switch (function) {
@@ -173,7 +178,7 @@ static int ti_eqep_action_read(struct counter_device *counter,
 			       struct counter_synapse *synapse,
 			       enum counter_synapse_action *action)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	enum counter_function function;
 	u32 qdecctl;
 	int err;
@@ -245,7 +250,7 @@ static int ti_eqep_position_ceiling_read(struct counter_device *counter,
 					 struct counter_count *count,
 					 u64 *ceiling)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 qposmax;
 
 	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
@@ -259,7 +264,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 					  struct counter_count *count,
 					  u64 ceiling)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 
 	if (ceiling != (u32)ceiling)
 		return -ERANGE;
@@ -272,7 +277,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 static int ti_eqep_position_enable_read(struct counter_device *counter,
 					struct counter_count *count, u8 *enable)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 	u32 qepctl;
 
 	regmap_read(priv->regmap16, QEPCTL, &qepctl);
@@ -285,7 +290,7 @@ static int ti_eqep_position_enable_read(struct counter_device *counter,
 static int ti_eqep_position_enable_write(struct counter_device *counter,
 					 struct counter_count *count, u8 enable)
 {
-	struct ti_eqep_cnt *priv = counter->priv;
+	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
 
 	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : 0);
 

base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.30.2

