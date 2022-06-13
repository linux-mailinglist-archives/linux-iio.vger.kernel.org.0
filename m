Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6842E547D4B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 03:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiFMBQN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jun 2022 21:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiFMBQL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 21:16:11 -0400
Received: from sonic312-27.consmr.mail.ir2.yahoo.com (sonic312-27.consmr.mail.ir2.yahoo.com [77.238.178.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F32252A4
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 18:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655082966; bh=LelxBL+H4LXzzd26k7repQu8RNdcXsem6I1K0C0CDr8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=mPSsYeo5EsYBLXwcvjfsaF1ps3hY9zOx3nQUaPbR4ejTxL4GMy0PzxTXfkqRWuae1ivCFqefsTJM0jHs4tfHiiu3vDybWaUThTEQEolL0JxC+WMTW1JVB7+9G2S1NFAK33kjJKOQkysixW7Q/+mLJjWXUuspJxP5MFgUspOpA3TqjhmpCklWbXp57PXzGNP9rJ6S63xGSHJvmuMkAt6Hkfzkwq7i7a61d/ufRjqzBmHXt8oRLe84S3zoq6D7pmRfHOvTXf2VW3DHVhrdavoHi02QHESKnBWpkLKw/9GzniJU6lISB6v/+eKLReakI05sq2NENHaY1z7FqQwAs0qHSw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655082966; bh=d2A1P5ZVVPXwZLfMV7bYzjAduqUIdYT8Rf4krj+Piw7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WnN07UZ+7SGNNClpPeAD4fUjI4tgdiUsqoFDFgV6ZiLu/T08sAhZH3ITbktlN+GRx1Yk1tk19jx7EbJ8GEZ4vELD7vAPKgK1JR8jNVppssfSq1bn4H90/hXwtd64+9U8XCro+2wGaGwb5DnafjXNn9MEGPCqyO3wWJVAyV/yWoxypy5wiHLQ3pFqVAJKXN9g7hWDgmPUv931r7nMP2oRsVMF7pPJ3VoSVcuJPTW0WYW+P3UBozeLwEOsr787TCZFXGjtRqmbMRFQKFtvCJgWUP0a4iyS09cF1Ks841vDp1ZTccoLh5VlkNLFws3kyTqBBIItdVUsHyQiSJS1KhzXwQ==
X-YMail-OSG: acUkulIVM1m4CeCW.T99UaYzxxaXgghQaz_bpnIiHv3uitMLrY8mc8S3KPTSvzs
 aXmiF4rJIH8cKuUh.rJyHILJEpNVVAjkP.LRXSZR8tV9i9ocjG6RDvGKqwe.uJNeJkGZv21mQP5s
 S4PQaoJ1i2K5lChoueksOO9H1L4EGTa4gnOTii9AkJu8G54OaJCifJjUgy0HlMkKSY.Z4VEDlDEs
 xJ86VrqdJ4m.e2cp.N46Uo4rdsfYRxHwuQX0gePQ8HkaBOzW3v.OoWSBvztq_4kWfoc7VFpHjrsV
 UE5Kcg8BfpHatbfQ9oIFeyeGYFKua0ar8RhTv8h5zqVTp5bhrkkRfrof0AFDVsdBf49E.YqVJYYs
 1rg.9tf0VmZYECwnHnTKkuXZz4_zD9L9pKY1qO9Whiqv9FKqUsBa0iE9oTr_bNngy7fd9p3jRwCi
 uRpLb_vhbagjOupFLVH.y61zM0isfNsyx7JoBI1RC_b.yC8hfPw6.LPHTTnpt7A0bsVVNGxin2YJ
 ZVNr5zcv0ZuWTpibumWd8ZEXGSgrVjehmuJJuvB7fGgaXUtWc_g.pNhET19IFfGgffJYMtQ_.uM1
 aSsp0yfkhvYjtyByvDrE5c0eO8NZje5Wn3nlfr_4BAne1WQp.g.RLyoDllBNLBX1dN8G2uBP6dAh
 pcTcth1C3d33LOhFfWd3s_MuKOoSc3PVMQrXaKC78M5pl7u_qAmgXj.F_kQ3AKTbVctCbH.JC39w
 x278RwIeeUPMRkceg9pGBbhGNHihaGzxchmcbhvTLp55wb5GQkMFqhaJDGfxY3j3LFVo59jEZG3o
 JFES5U4Ez3F9mr4GRQXoodiHiC3Pf73tYXbAGZ865zlMSikhVrGXfwdeqhrFu.oppjSXDwK0ORR5
 liPBPQGYEnzY5KDijUaiiNqNmq3l3nh4y.upXb4DWgTou0XZ4.Thc8RWWgh2WzqX88FZ.xgH1qah
 ZEvbvR8wu1b6G_a0_rc7xBFSYCttnGT.tlU9uQgMV8oZ.0pM66i9fGglp4adgGLe2RSNTX6D5H2Y
 phNN4J7E.cdaIfDBeLcnaQefHpSyP163DslSJEs8qeQitCRpcwhoxPa2t6eRA2douW_VqVU8PWoN
 bpVAv8sBP09i284PqPcHrlKIW6OHNnsElEKxX7R3hYcHMFLschQTIJZagXofGcJHzOgIIFUdn5Wc
 74ZG6JMQD7d0KdQhMZysxOH8AGwykwNPpkyR2ULVZqZkzlI7ClvFbw2c4sG_RcpxOIVtZVlkY71U
 j84f2TDH62645HuTcgoW8EU2BWgV_xN18O81vljcnUltpQbgQalEm6U53ogtjdaBi5tt8zmG.OFx
 vP_Mj_BWY7ir2DTdJgW29CmkW2N_m8uZkZzw1ShSyyBqmpzM34lNSyInbOmXGF9nCpQf_3Yd0vKf
 RvEnS44OzsMNEnO5FJdi8oPfbBem75EY6Q1WUNBA8NtoFmGB16bgbb9MtxW65v2ETGoC85nnLWMs
 Ls3Bxpm19MiFxChDo.1Q2eJ5WCZObBMjIn3.6Zfy9onyCBnCgdKIIxTgVsBCgiom0HHIfUAeYQPz
 Vzt0q3RjCYW3to3dI1LPHq48WMTbNpvvcC.xqCJi9oA_W9tNHb7j28TPJMrI3TJnQRqRkb9C9Q0d
 4RR8btW4m7BGR6uYMcTHjnxVVW31R2PE9LWuCz7HclFqGKs2CKa5exCbVGiefkQEZvtSYK6RWoWl
 N2obhsqlZGR1ma8iXFnMgrFBixoLNukV6D6rFUouBx.AIVmrJPmPElHAmcov72bKtQYEDEIj9cX_
 VLJWzOCUvEPNCr0EaaSYzSWkNQgySzuOdroN.Xm4DAVx5uDqf0bLhTSe326Dd441UAqZV8v6p2yn
 p4Vu5r1ueUpHDzo9pEjgpmYqLw0_qNoTjkAvZfyyBcXDxeErwcg_w8yRk6psOu9XVWLCjgmk73le
 ixlrD2q.XIv1SkaHx.JFc5KzivpaOZHYwXW4GhhONcpUay.N6wocXJqUs708R2kqNGy3MXyYETfX
 I7nejVN7nsg8t7qd395Xhv9uUqR_Jek2ctevWKW.CEcnRrdQMT_Dpvr3ZzVu6Ekadk8nYh8GYWFs
 UymFWjUGEjP88qbkpHgfzXKZf9RvSfCL.KP0wEUDFwqQs7DoNjlY8WquuQvGrDzpcoUA5XuVktkz
 Orp2wuSahWJE85oxl9H65bVyuddhsDP2yozaGyVDahkFrBwFcMHkYcxy7YxGdgyeLbNN9CLyHV2S
 UQ6wfHXtxIL2l4SJSvuLOpQXsxmt5rIQuSQ9b3bX5TxC2gObY4yPywAa1W9iBvzdlQg1w.reQZxq
 wX9hT
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 13 Jun 2022 01:16:06 +0000
Received: by hermes--canary-production-ir2-6c7595c778-sh94p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 533ecd9feb2951b8ddc71d59837c1eed;
          Mon, 13 Jun 2022 01:16:04 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 0/7] Add support for magnetometer Yamaha YAS537
Date:   Mon, 13 Jun 2022 03:15:05 +0200
Message-Id: <cover.1655081082.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1655081082.git.jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds YAS537 variant to the already existing driver for
Yamaha YAS magnetometers.

Patch 1 is a fix on the current driver.
Patches 2-6 are cleanups and refactoring.
Patch 7 finally adds the YAS537 variant.

Changes in v2:
 - Reordered the patchset by moving patch 4 v1 to patch 1 v2.
 - Removed patch 6 v1 ("Remove redundant defaults on switch devid")
 - Accordingly, added "default:" to each switch statement in patch 7.
 - Moved renamings in patch 7 v1 into a separate new patch 6 v2. I added
   the "Reviewed-by:" tag of Linus to both patches, hope that's ok, else
   feel free to comment.
 - Removed regmap reads and related debug dumps in patch 7 in function
   yas537_dump_calibration(). As this function now applies to version 1
   only, replaced switch statement by if clause.
 - Also removed "hard_offsets" debug dumps in that function.
 - Fixed typo "initialized" in commit message of patch 7.

Jakob Hauser (7):
  iio: magnetometer: yas530: Change data type of hard_offsets to signed
  iio: magnetometer: yas530: Change range of data in volatile register
  iio: magnetometer: yas530: Correct scaling of magnetic axes
  iio: magnetometer: yas530: Correct temperature handling
  iio: magnetometer: yas530: Change data type of calibration
    coefficients
  iio: magnetometer: yas530: Rename functions and registers
  iio: magnetometer: yas530: Add YAS537 variant

 drivers/iio/magnetometer/Kconfig         |   4 +-
 drivers/iio/magnetometer/yamaha-yas530.c | 790 +++++++++++++++++++----
 2 files changed, 684 insertions(+), 110 deletions(-)

-- 
2.35.1

