Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2FF547D4A
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 03:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiFMBRw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jun 2022 21:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiFMBRv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 21:17:51 -0400
Received: from sonic307-7.consmr.mail.ir2.yahoo.com (sonic307-7.consmr.mail.ir2.yahoo.com [87.248.110.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDF03120C
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 18:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655083068; bh=QUimuT243Rp+7EXbR/N0HCVEFU3g2y9SqxGTyDSnStI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jadywCWiM9mRlQ0eRtGOo1R0GVNboh5q0NY9QdbqxmHOFd9sig45CK6D6U5PyJFlyuWaT8jDVYXkNcGJhoq9bD4Vg+SKGOHbty5xDOi62JhUoIC45JdYx+xeAL7ilV9sJLn9zLEEN9EVirXzowx5/MKYEPBcMT8KVkhbc4SCpMfIyjJH6Bj519PoMX4rLIv20jcC5QkmxcDTAICO60wV3RkSVcpRfJnlMq68fPFTH69kVQUiQTtXErbuxCETcvjDC2mE+Ebe4kQwRLDVgLi/wfK6mdCwStFKIJ+axc6c2QKpcNdYtIea9A41FYQSujNDVtOLQe7OEP3iU+9ICgrTcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655083068; bh=vpAxF5f/PzE4bUZgMiGBpKIhclUQlxR/7kudIw8PcQz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jHkbnPBpUqwukA6LyeCfs10lbsT/FVxoURNoQR57NrjZ6VY+v0QwGPq58jsnH3xTgpdt1uwgjxUF4csmqlZ368pNYzGLnjkOR4lfhbpKilgeb7zl5dSpD0S6NB4hPQeRr+ZvMcPRjHARbsgYAc/LYe7td1g4hdJR2gkC+Zy5vPCVhVK9kKBreHpZzsyLj9Yjt3jdF3aqYh9P+C4vSNETx6uNZA61BCsDs1+J7LqsQYtodH3TZdSeE9gQCh/nZUPzyvVW9N16RbvsYj4NalG8WQ/uYapMbYUh38I275AvtUrTtkzcxiaNW3aZkNV8E2O591u6kTOB40/ywVZ1pqTKlw==
X-YMail-OSG: 2rrqs24VM1m44xGyh_nXoSj8O1ySiLF6kkV4c7K_jze.Z86IejZupn3qBM5rPMs
 NAellTRWU.rs6x_9WqQVM..dnIQWAmuPnshu1Cl7uECtL57O.MwUXf2M8BiXFvl.XR.2Z6migP.N
 IUxap1FRmHRFtt5XdneO7COh2..vew6HWeKtNQRqiEuyZrYYH54Hj.eEAwwMSMFi8EFLBrAv_k2b
 ibjO5Be_VXg9XTSCT4Ef6uupBUVB3PFew9wqbmUMKZGASeNxJFAmavVoE19ClH9DenM5GHdqsc.A
 s8th2O.mAFTwzwLqGuQxbAW1zPS7KIaX9dr8BcXF3o9At6N1A3Enh7KOytrPF8QrgEPFflADBd8L
 sUiBcv6usGxuj0TAWgaZL.nBw45W17upgkBZzxgtB934NLK2VcaxooSjjOWeL8.It4ben44qTBoN
 UnXewMNoi.vhVEt4jME7DFnZKKmmtYjwe8ga0F4oYfCf3gB2N0QC.B.XUYucjTposhvhXOASM7j2
 l2TcTIelL4NBBXkx6eS4GTaR0cVrEay2IrdUxHLxeiJ4bGWOOl5cXmf7W2Zt5Mr98jDF71sM.pdD
 iqiTmOQBoY39ZeoG4Jt7oWq1.hdgj6lfY.hp6P424HvmAHIwGTDvVjkOhsj7O5UoCuyAGFvtlfmY
 F_CsPpR1vxw02iJLlrv5qtMzwUExRuPhn3.pEN7JIGcEeunFh.sTe4lQJDmVzeP12ZuFCPniOkZe
 jH1gqjBtntXjgBJfzTQroiw6.0ScFXwkTJrEvuvOaza4L1fp3cpCAyP..l71T7yrSFAwdHiKqsuE
 ASPe59BP9m2g.w9WONzQroHT9_lYlNs5LOireB8WULnHo2daVTRbbZ7sOdzylsrUY_2Nl7mwiKKT
 7VUMH_UKV4GPs0SV7XckNHpmSOSS9ozyHGwekPYZ_xDqyl0pzwlN.K5uEiO8tVjDznt.VKMekBdM
 n1Ia8WHznJ5co6oXJcFHnUgy53mFoKCeiN5jzrWt0.8ckeNXy9d7etXmMcd3evIJNn28_dlDYj0D
 xRUyNF530nM8QRDmsYXxD.LberPR.JJsOj5QUmKupJZK5BMeU1NlJ8wgujL7zYvwt5dz.k6cjKNt
 f3Sw3YR1lkQDxqw4Rb1b7jadiEfny6e9iUXY9SiP7xNmn_WJD.99zBnZtHwuQewjjFos6zIDMA4a
 pTBV5.s_l6WZ8ZPNuymlFSzlHvkRdCWshkRC4cPewpX9h3k2a_QX4Fo4lS9cZQgSd7.HV8fr54vb
 umerK5i9P_hnjs47WwrwlHtNvWTwuNcqdPO9VEgEqIPYqSa7mjkcISzNoGti99NeqinJMm2GCmt1
 ACT.Q0MdLG4xEgi9bKj.MYsngZoiY0Pbj.94_nUI6xDInwRYMqjqIBVSNql9chJaD.i7PbDIiOuI
 1RbBSw3RO6FpSo2f1eUpo0gMZ6eeiegDZxlywz26U_Kar3EQqJd_0qZhBBPDo1gTYZ0qb65dBaBj
 .W8z4aKlggCB2veSuNfk_evBbBtFNB784YoVD59RwzJXbQCVDhneNo9ys2DEXwtYrOqyBK.X63kz
 r13PywdgmaEV65RNVIrTxn3leVqbdoL6FY6iPT_C.VC9975vcva.PAU7VsF0uq2btXVinyRRgZKt
 XUharKSgGfL8O5njG6Ej03SfpQ63WAYO72IcPLpKEhyhDs2nJXucRylGtHhkTfuHvDxWwC5K8ybz
 RBVuMoxgZj7W99hMyEZbtEMnJDzXCdGSQV6XkOeltvcbsakGz0Rv7Yk9o4fpH4jr2AuYZlwyxCb8
 P188.6LMV_bZ2b_G85Uu9KxwPRkiK7h.Evps6XEJwB_PzQNH1jgl0cB08B_tUFgXsfcQBrkHw.9i
 rFrpjI.VHK9iT7NFv78108QV3aobZ.B8cjc3cKJS2msagoZv1t2FQFvjA0e45OwUFtnTa0WwCPhF
 InUIhOVfKYWE2jVebR1t4Q8GpYzkwbyLUVRPRr_Y8aJ.Vi9q3fH0zyopSu_y4.ynEz4t6m8wGykt
 BcQeJ0ZLGupJliOTR6bCzN7GY_QzwW0KYq.cWTIKcTWlETVRfrprA3XU5PxlnEFCzDuXQ6_QKC9k
 03hQTudX2wZihTX_US5BGOc1CqV_tebAZ4Hs9DogQJpJMsO8yeY2nHhCrV_jPMFhYUu7WwDEecop
 4HKgUARNZrG0L7sbFjiBEAnQEoHB5VbM.jW.Zw_u15tzrGb6VlEYKAINV7PT0BeSGgLQt9kah7fF
 1PbS_bPSR0QPlGm8eqCuxG5k95KOVTYoCwKtKH6S4snu6.S8Y8ZAwf8aCUqhZXrzI1uhypalGY4s
 GYEGS_781GGe5yA--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Mon, 13 Jun 2022 01:17:48 +0000
Received: by hermes--canary-production-ir2-6c7595c778-c54g9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4419c1e75f73c3038b6a16962b132f56;
          Mon, 13 Jun 2022 01:17:47 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 3/7] iio: magnetometer: yas530: Correct scaling of magnetic axes
Date:   Mon, 13 Jun 2022 03:17:10 +0200
Message-Id: <66eace1d414ad977d8af70c0e1c6b9c74c5bf9bf.1655081082.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655081082.git.jahau@rocketmail.com>
References: <cover.1655081082.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Looks like YAS530 raw values return picotesla and YAS532 nanotesla. Adapt
comments and scaling.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 28 +++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 2d71ae837bf5..40c81c082782 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -310,8 +310,6 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
  * @yo: Y axis out
  * @zo: Z axis out
  * @return: 0 on success or error code
- *
- * Returned values are in nanotesla according to some code.
  */
 static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
 {
@@ -417,14 +415,24 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 			*val = 1;
 			return IIO_VAL_INT;
 		}
-		/*
-		 * The axis values are in nanotesla according to the vendor
-		 * drivers, but is clearly in microtesla according to
-		 * experiments. Since 1 uT = 0.01 Gauss, we need to divide
-		 * by 100000000 (10^8) to get to Gauss from the raw value.
-		 */
-		*val = 1;
-		*val2 = 100000000;
+		switch (yas5xx->devid) {
+		case YAS530_DEVICE_ID:
+			/*
+			 * Raw values of YAS530 are in picotesla. Devide by
+			 * 100000000 (10^8) to get Gauss.
+			 */
+			*val = 1;
+			*val2 = 100000000;
+			break;
+		case YAS532_DEVICE_ID:
+			/*
+			 * Raw values of YAS532 are in nanotesla. Devide by
+			 * 100000 (10^5) to get Gauss.
+			 */
+			*val = 1;
+			*val2 = 100000;
+			break;
+		}
 		return IIO_VAL_FRACTIONAL;
 	default:
 		/* Unknown request */
-- 
2.35.1

