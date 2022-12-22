Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B32C6540D8
	for <lists+linux-iio@lfdr.de>; Thu, 22 Dec 2022 13:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiLVMOO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Dec 2022 07:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiLVMNo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Dec 2022 07:13:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1155365C6;
        Thu, 22 Dec 2022 04:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1671710880; bh=G4ht3vV2Qi4yCodNxC2rKqBCJ5z+iRhOvFWldjVUyOM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=mpw2SsGxBjzRA+ae4ejTW9QiU5biKHx3c98cQM8bbE/ClHQ6jb9q/oYJ4ekd2pTox
         hhl+9WsXkvTR15b8cAWIuG/LNV0gedZJodyktgvRnMWe+5vXIhXzSO5Jyftr+NQHKy
         0D2upJ5S3XpiM11clIYL2CnNrEKMD9d5sS0f2itg9M+okOlEPF4nUSzTO/jtSrh6FX
         Un5FqCrmfs7+ynmnnZQ5cnTpPgysoJlRW6d3DTrkz2rdtb7PrdMRbYXnsRc2fYh8uU
         be8fVVbjG2wfm5jI/ejH/TPKo0F+ulDrAxtzUtPyKD5XfZZyi+uD1MBUpKa0q3eMgw
         nJbip0xQ65j2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.187]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MBDnC-1p1D6145sc-00ChCx; Thu, 22 Dec 2022 13:08:00 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
Date:   Thu, 22 Dec 2022 13:07:42 +0100
Message-Id: <20221222120742.232087-1-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yFOUXtw8gw0ShPfLwEJE7lHLbPvOB/fzL01jzlqfJYN1CuZPF0I
 v099GeLIBo1HtKQmOVvy+27LxzDW/b9n/bhPIOgPYMyGMk5tI/5RzcRC4rz2tJNw/qM4sno
 jwaavnSWwqJyzTiEXMA/y6qO6Ciz9FLhi+/uTLva6vZ0hltmBcUieWFnD5SIrLFidl/CAyM
 DhnJgKfnH6hYW7UzuKtJQ==
UI-OutboundReport: notjunk:1;M01:P0:VG7UoddkwGU=;lBEqt8t50Cq18Dfc/01Sw2TT/yd
 hWFHhqSDLMG88CND/KaJfyV98egDfXPiLs0sd/vqxY/bDM4RVMcCkXreu4Ut8ojbblBNy8zLV
 FpmsYXqLefGa9YqDy2f3auFtGICNasZ1Hq40EOCpmGPN0+5+78EVJRFavOV1JTakZTKm5Jomc
 XGsnfgotaxzKfOddDx5sCTNnCM7AvKgIFBF8Sl2Z0H1slLrpIGqMgo88DAdc78/l/jKw2xa7c
 3Bp1AYjH3D+BPWQch9jXEkdvV5JqZGNSuGaUnR6wW80EUiGeuYXoqY4FjNFxOX5PSQgIbU7gc
 E4BIhn9ybhQLnCVW1YakVj3IJ3yA1oqpEByCJaaOcQVFSNlPMTBMJ1VqrP3HqT58UA9VPi3Rf
 vvMuNqTZiLX8Sv1RQNBPAvLEj+qcfnHJaXy1LS1ovS3USSsuWqpubbNhVa2rDfX/jW+DP/AZZ
 VSHqz6ELU0VVWrS5KWvrabKh18hWJZIyPCrP3YwOeg9kkAIMhONZCxhVzsO5A3oLC2wi8yqPg
 rA3ieoVNUnJmsErbKK/Sp9zxg4C+DJLQIe4b2Sov379QsJZsMf62ftLUYVVtYO7BEhwzewv0S
 /JPatceaezoEtRDUjEcJsSHO6zfD98dtomRhwhT6mahLdEoUz7etox4XendLamcwlYbj3eyZU
 haya6p7KGFcXuj53D7k3hkPFDBM2CVrnj1PoSRz6XLQPBb9Sb9SVUL4u3uVVK+diI81O62o4e
 qloX1nB8hQ+8a3yiekzei0MChYiX5t41/xOk1cFTApp+H7X8zG1W0IiL1i/quq53XC8UUCrH/
 eYMLbhVxEFt7ymw7K6SqbPYoyLxgCTxWqVCFBzY7jBrv8o49kZhSQop2+860tUpqT8I0qVTsa
 +r5rVrSs1MueeaoY/wTUFa4DPExutyKKsOoC5dFrWRZR0+BpIhNLZyfJOS4fRpZcptnpduPYc
 BxGgdFJVxznUH3LsxSxNJtTXtAc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The hid-sensor-prox returned an empty string on sysfs in_proximity_scale
read. This is due to the the drivers reporting it's scale from an
internal value which is never changed from zero.

Try to query the scale of the HID sensor using hid_sensor_format_scale.

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--
Hello,

While trying to utilize hid_sensor_prox driver I noticed this problem.
Should this be part of the branch created for the other patch series I
have submitted?
See: https://lore.kernel.org/linux-iio/nycvar.YFH.7.76.2212201525010.9000@=
cbobk.fhfr.pm/T/#u

Regards,
Philipp Jungkamp

 drivers/iio/light/hid-sensor-prox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-s=
ensor-prox.c
index f10fa2abfe72..3322f8e56f41 100644
=2D-- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -222,6 +222,9 @@ static int prox_parse_report(struct platform_device *p=
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
2.39.0

