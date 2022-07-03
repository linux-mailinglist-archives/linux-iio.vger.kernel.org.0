Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D506564A33
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 00:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiGCWDa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 18:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiGCWD2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 18:03:28 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEFB2DE2
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 15:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656885802; bh=06ZbKj/O4G/euSZD9awuYJpka4OzYY+PQp4ku8CMgmQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VTjDKusmbE02aK9POjVKUDrEC5I4ZIGFE3sIKrhcmxXegw59xksRqoCToLxs5XUe3kwS96oAfHiiVhUcYNHZn4URm7Ap4bdC9OwAJo9r/O1GpFOw42+yJqTuuN2QlwjbJlrjEzh74TZlVHfTGxSzpsmQfHF9jVUhnx/nJiGMqcd/Q7o/1596Gj3iE+KbbomLwOGoefXK8pHVWZxrx+CBe4lBh6IgTl1i+GZXd937Y56cBKG9lYy766WT42JeKXuvFKpUXsWSBXJ6CL0k8C4ENJjULTyvwqcWB77Ny0WCFlE8/nKjgTpgnvMs1IDTpq8vuxcTmUUcDbFyp+KbvAJteQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656885802; bh=lTQ94aS5OZ7nfyRM+YnALrl2PnpTbe3/pEq6ipE9ij+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=C8HJCFUJuLc+dpaeX6FX77AD77phZ7iRTHaM9ZG/bwGHfrR5nzFJYwFu77EOUqh4U1+QmM2V1McHu9aQoIihEl+FJQe82BqOwGY3CPvfjtNmjNqdPvJ+btc762NJVousljaiLOQMHLKJ0y3VIZMOuikTsPJFWe0nqze/jL5GBrg7KtYOUQPtu0EdU3eXSFXl3zwzqszgYpjFtzCg+WIAefbcr9aOQVakwy74LcKz4ZiU2vYzsjZfR5o0zy/bH2AGDVxMGxfcpAx9HF6mA87kR8AAK5v387/FXKm6BHd2/b9byZ/SzxHuddHnuoI+mCuF//VGsolR+v/GvFjvdlgYPg==
X-YMail-OSG: b5S8CAkVM1nYj4_978Yb7KgsgpymF5eeAD4qFPsBZfm4XF85cTS6nwlMZ0_YqE1
 tNOaXdqZgFVkDNoDqAkP6BqIwQW4V67emtgzSJ1VvRKhUZSH5JeuprHxguThIuDNrmJ8zXevrma7
 WRs0GEKd_aKjQerT2sFNrdrihWTMlZNMo11J9Pe6uyOhG_0rOytmBMEHr64lWo_7hIARYLSBAOru
 j34KD9Un9Bd7NCL9NbG1TQ_3G_ZiU.2HR.W2KJVc.OM3aN1ehLRehrQiHbXMMVUaPRzkVjaY8AEB
 di6xmu6m1uZj0Q2vmvhT9kH2ogyAXHMs0DlYT1x1m1zMKvZF0ES.LI4ro8s2Su8uO.tXjjUejI7u
 .CALFJroQ03KBmx8Vn5G.HLXv9oy9nPoqs_aabHHEqVL0e_NmQtlmeOUgJxkmDT9PaY8qoS7reVs
 rMQUwXUYBS3_JQqWd2edcbDSoex7GD7H24z8XAcC.FNSyXFmPY_Coz8S9waJBZLUGZVUpYsrdhlE
 BxIhXGhA5M3LxZdmMQDcnsVsvlSkLmpf9l5Pjy2KT1N4lPRTiv8R3JRLOmi2Q8zCJAzBmDZ1lCSn
 HsGSzWm_5yJbzVnQ5E.oMzUv6Fc5k_WT23fYbIdZE8cYmQsQVh.vGYTFUPqkBsOnpcECl4FzQJC5
 dYa4B3WkPzalYkjf0PwLM1RaRV.os_D0Dun5hckbgq6vOv8vqNMoCPvEjuaaupSJ9FFDQqEQkky4
 X5IXUphBBO7FSHESpFTlXkt7x3NqiiZI4FMjfcrTYuEbR2YW8E11L1oQXYxp2rj7WIDupzwVXlpm
 83vfGmf6m9w6XskeDxyNkzUx2_O7cvUUNiN9OgdyEY0PpCpGHT1wlvzoARZbu2hwpKiDsQBmdEM4
 xZu29Jhlte41VdvU0HiY.iZXYqHLMqvqMj1tXX7VdWuKCnwW5.BE8rD3DSpHCD69GMCmfoP6.HaU
 AErgwMsfT9a8zIBZcPIYiw9txZvhx9mketyfOQvZzXUGKtOq9Kptk7zivcl22wsPdvbfY5LD2XYE
 dCrodCi4vVONX9OGfBeqaGiEqObLD7OEyMLUaBKY2U5ynL6o67MYO4S_VUp_Jt3gVA_QVS4P8855
 GLln.VHp7_LS_L0oTAwzQFg8ugcZTKg862vGbkb5iuYKN32PPEH6PibYTyJ8jWlTOMsR8O8ldEnK
 jpi0mT871o71aCM9.L41szKu9ef6ODYF631AWlorb.G3zktZBsx.UbxL7_fvb1p.CocdGwFEeSgv
 Kn_3bq3GD0XQiwjI9xHIDvnDJjR652o8JJ.bou.LwuveSssxG3CfZIcPo4eQXhunjNC7iN7uyntQ
 MpxlKRdRKc7tKx8JlzUnrxz_4vAv1WDyqJYhaSfvFqxtGmv6kvPpI.jHzOp0q1FX3TY94fykUnkt
 ZixcM6BROWjlM8ocjiqcOjPn4kuTiaZ254dD4y0TxF2.GEtLQw032S3C4IOOyd6.OySNljh0VAFV
 091Y9RxjRtupptwDC3scJoFyzfv7CRI4htXv_R59OB3F4FTNwOwd58uA9Nrpc7TrXrgvASPUsBkc
 fkHAYvASQpRf5UIdQbI11MbozIflGGcJi3h8OIj4MX7fmEvhcOt_tUHcsnb6KG4_oM7aV_eV18GG
 6y1vxzMzhAMduAZKPeW4kUWmLc7Y_EMDZA5_9YYhbRtNABnC8jgp52d7HSLrCRIQdKoL_DPtPXdg
 vR841Af4fQh8x1LyDvjSsfMC5SyzpVBFRFIgIr5vbGO7oTUeTdShaep48wHLybmFME6DdaoJSKPD
 9uzVHVIV0h15Mmpr632k0vQ4SzDKMwyOs_s1D8YcsmcrBlPqYgRa8hEqnS_y7fTvtSjDG63KctkA
 Ea9KdGVS4DD_pN.IWPrzDw2scfdguI9k5d1pdhpgZchG_PEpb92Mhi_gvIShEnHa19L5U.t6glH5
 fFvg..MlH4MQ9XwiYtEIIrky1WMgwYkE9J3pcVrQxK.hk2Eh0d4GWrB_Izc5yRIoRhXdTSfMQwXY
 aNPN.UlPnUh0t05ZeRQ9Vvl_uYN3jusDs4Ej.SwSvBVIHeMAyYpNnGhyVAvbsr1kWv4v22P.lmvZ
 _tJFNLGLjGO6xEyiKYVpuG3gzeAiAfhWFFiD8HB5Dp6nTGuZTW2sQuqdXAi1mN_1VfWHGIZTyo6T
 RvKH0ouibkymiedTG2Vrep4ekvRdc5mzX72EvFIZAQD0NTRrm2ZoRYKQkDi2xadkABkgEz6K5hFJ
 n7sFEQ4YvfMKl1vteN9kC5Gk8xB2k9XifsLN9nT.UCbVkwAaBUAfiGe96wYqnJowTRhWCRXpqTJO
 xZ.hfKtoqzc8ERuti
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Jul 2022 22:03:22 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-tv8mb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0849bd8970b52a790a5a1bb96f2e336c;
          Sun, 03 Jul 2022 22:03:20 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v4 07/10] iio: magnetometer: yas530: Move printk %*ph parameters out from stack
Date:   Mon,  4 Jul 2022 00:02:41 +0200
Message-Id: <b311ddc1f38c6baab99af97b4d3982d0b981198e.1656883851.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656883851.git.jahau@rocketmail.com>
References: <cover.1656883851.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use less stack by modifying %*ph parameters.

Additionally, in the function yas530_get_calibration_data(), the debug dump was
extended to 16 elements as this is the size of the calibration data array of
YAS530.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index c250909df8f4..8358d4b3d1e2 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -661,7 +661,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
-	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
+	dev_dbg(yas5xx->dev, "calibration data: %16ph\n", data);
 
 	add_device_randomness(data, sizeof(data));
 	yas5xx->version = data[15] & GENMASK(1, 0);
@@ -708,7 +708,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
-	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
+	dev_dbg(yas5xx->dev, "calibration data: %14ph\n", data);
 
 	/* Sanity check, is this all zeroes? */
 	if (memchr_inv(data, 0x00, 13) == NULL) {
-- 
2.35.1

