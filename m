Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBAC543FF5
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 01:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiFHXj6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jun 2022 19:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiFHXjz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2022 19:39:55 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F4436B67
        for <linux-iio@vger.kernel.org>; Wed,  8 Jun 2022 16:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654731553; bh=zjbMhCAlrSqRGUz0RLEP1QE+nW8Wt81yHd7xL8jsRjA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dVxRWe1yaOWjQT2oQf/7XcuwUlZLylftaO7CUa5JwnKe1XkKmbEJKwycqmpogjX5GwyIWPGn76eSL+XLJHOXNbAXauNWg6BGdU+2jojENcm085LENKpMBXup2UfCSZiccZ+HGTQjWRa92ihwji53jodxeU/jRU0fh8ummwD9nDLTLZYy+vXPddf8Bp0D31MsdcRLBltrWEz3yljCRQCNzKVmItRs15qV/suZaClpwuzgKD2iNfRH3DVYwUeJ/vZeFp4iX0g8JGTPw9rqApk3GfQefPvioqSM5g2nXL7Dm7HiOjUhyKu343HPi1vauB5EO5rp4I/jB9FNEUUaKvQZIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654731553; bh=LDnIjf37d4CjBMJK4CSjvjgcoemOrg2zNkNWLvnbByV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=k5s1V9milFk9Uk2HvUDPuPjDjA2rM9rK5Qb6NWfl1+KjZdJDaTbJ8Cjrrx9TTIjhGjxrRyOo7M1QsI8yAtjbnTPqp72FNqieMifSEFoyATaFtu91gh0ivkwU9pbhTc2RmTjo+visL/sunGxF8LVaWV+/mSXRhVs+Br6osoF3jn79nJ08Tt/+5vfINnxWZ6GGOrB7hzYYPixIlRAN+ApBVNSVR5CY+PxjmsekpuKPR52mu28rrRR7LHCyoRrLpfLcGzt+t5cq7NxtKTEVGVCcVksjYbC+dQj5WBd94FwqHjJ+dcMy4yY9qv2iZ5hDXerfGYGwplXvWFpOVaMko0Iulg==
X-YMail-OSG: yWzGPWgVM1nUBHc8XTFETHe1l0IYBDil7SfAvezbMPxvU8DjFAr.qN6uRhqFbI5
 RHisOtVcPGumISVG0a.DX6B_75KsnpzIlq3xA8JyMVv9x16At.GPkOSiFCXcT_QygisdlHywkmsH
 U7IoY.4hNGIqJ2a2AJkics19_YaxEESs5bM.a_RuchGvbmWOuXcir6f6ZFkP3nWIPdCJUkEmq.3S
 D9aKzTYlDtYxoaMQbhmYmM0W33XACQK4V9QncDChe2YqeuU5Dvoyx85EbJ0_9LXUyk4pViq2KU6a
 t.8RdvC.2cJZuJEFnzuuvdBrlVOZtUCpft80UzRzqOPkT91HFEgiaTpDNa0eVT.AW5XtfZycHkc6
 4oUBh8zT3Stn4FxvprD1hG8NeB58U4bAXmOLW.eMaQNJ3ZfKAw0jBGxu9N39zQ0RC52yHPnukRlN
 BbBZYArCK_afscwC3R7etLbiANbDMWfSfAjqSS4RwL1_Q3ir9dnMQVPPsXjnMnVH4BBOG6h.lfDa
 1kJjqTvbvDw3qwfowv12FfsOap5vWV_vXOTTxLQfubPpkEAGsAjUmnDxK65L0sByqX3C8Pvsn4jd
 7y7WHnqicvJUk42Jp6O_MDvPSYKxJBF1Yt2aDwFk607L7njihd71jfkBQZa0OcZj.HJbec_vbp0t
 MEViG4V_X51JJRd6r_M1rs1jds_cd2JloMzUz7TiF8HB01xxYa5ReVEf0R0yWqvaWkcJseUKmzUN
 wgTJ4JUSzT53r.crFc.WDfQw.KcvTQPTHrDX5Vp1nT8PYC2zYyQJIWxdObhPNlgwa3Rm6MVysPLS
 R5fQ7QMMhh8T4e7lJAM0NC3y8m5H3WgHgr_5uAd1op_S99Rks8xiZY7PZjuU9_hQ5rMgJ8NlJgo4
 UnDmOsElN2j0ZOBDsAgttBOptM3IZ58qJx.iGC7b94RmcpTys95k13LqNwYNMDSXH0tT4faEOEMg
 aFeOCgOztJLDZNtxdaitwnj.xC6om3MtJmZPutZtUlw7J8tv5ZS9fjPTYShxKk.A0MesYJ.mUD_A
 Ag0ONpevDq4DcBC5GTktC1b0_u8PONEMYMAvLDwjt6X5h5lFh9eHKrXDSM39ouln3HKrsEywj9j7
 lj2VDhlysqgq2CGWH7ZiP9MTdZ63e4iMn1gLFPjaU.SN5w8HyCwAXKMZnIX1wd3TmVX2pUfk.FdU
 p0AcaCO5fuG7Xk4ME.LVk.40Sn.Y1qLcm7en31oIVW98EISX9.XtFHpjoF.jIZGwBqo36jMCK3iV
 jGXrwtmJIu6DYo7aJ5vjo97PC4LXm3KzpvLWNX95sVoEHxXbQF0v4M9WX4SEfeoEkDXSC2pp6LNY
 o19jZgAz.37R9Ny5ewIuKTkTcmm.0U_ONtQ_O6dfJMozKn0o8d5CLRNGJh99VRxCLn1WXyv56QRc
 0Jj9BJ3VpohsyfjmVVufGCSFxJX_fYSGoldXF1vpn0RNkaeCx0V9r_sxGFCXAMHYks6SxuMjVUKx
 fh7vNRXFHMd1zK8CdK6ko3_.if6gtM0JvpuIStdkLJkXkpyuuSaOBWo3aQRr_TczWo8LgQmGGE3f
 VvVbLhP5td1nOHKao.9QNEXTpZX4zbSuS1l6MNzG4J37Jmd75FpwP16tudHOQGG0bkxvY9vNEFaB
 jwASRgWejwr5dsEqclEC8lPBEh69cbmynxjgjVDc65Tod3KscvON_IEEJZXmQ78xdIVMSTa7xb5n
 T2_3POwfamnXoc73dbPXj_LBAi3cJBxrJkNtAxdvbl3w.aAPv6QT61VGfJRGk8zuMLo.ljUwYs1P
 Jr7OOhsDkx40ZJ3vuhaUnhJ_.SCzrKv1EERY7az9h4bWFmop.wJkFM8IBJU_nNKrcGVsE7Q_YIky
 A.nM6oUZRAvedjHLHApyh1TE8W1OyBpnAoqZsgmbZj6yKn3.rIH7NWOGD177e5duXVsdffLbZVzi
 4B9cj1XqRnCjuo3bHP0e3TLFfPmAhW0L2LsdxDJI4gSKX7eEfZ.xKx2hEde24Y8kImJlLKmFTPDA
 5_XVLLO2Z1.g8UGGLg213QC.7bsJFIa5lNpRdCzqJP184BzUeeCRMMXfnDStmMG0oCjWmBwY7hJI
 CgHT630iP7LNH2fNmyLoa_o7iW0gQp4fn9Mm8U4cPYrXz2.W5YgFBbtyJJI8nx7W3dQ88kKXcZ5_
 kNo5F0b1Cg_sNOOxy5MaxGcYNPUcM7_jsDCKk0AqihdJaya7AiaTCB1oF64_jSoSrWSdkgz_LzbU
 5gwPq3dFOI0YERprXLd1kVMQs0iKcmrS521L0Zo4sfJB5lfGo6MlXGFxPA0dYa0XFiYaK7d4Y.J6
 esd8hR51FiMtI2xw-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Wed, 8 Jun 2022 23:39:13 +0000
Received: by hermes--canary-production-ir2-6c7595c778-tcd7b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f9021a74071b88f5034921531ba09f62;
          Wed, 08 Jun 2022 23:39:10 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 6/7] iio: magnetometer: yas530: Remove redundant defaults on switch devid
Date:   Thu,  9 Jun 2022 01:38:05 +0200
Message-Id: <5ae4b9dda3032acba8b8b0e39352e9e3953e3f88.1654727058.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1654727058.git.jahau@rocketmail.com>
References: <cover.1654727058.git.jahau@rocketmail.com>
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

This is a preparation for adding YAS537 variant.

In function yas5xx_probe(), there is a switch statement checking for device
IDs. If the ID is unknown, it exits with a device error. In later functions,
it's not neccessary to check the validity of the device IDs again.

When adding YAS537 in a later patch, several of such switch statements will be
added. To make it more uniform, the redundant ones in YAS530/532 get herby
removed. This is done in a separate patch for better history control.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 31637a890b7f..59844e1b794c 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -251,13 +251,9 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 		*y1 = yas532_extract_axis(&data[4]);
 		*y2 = yas532_extract_axis(&data[6]);
 		break;
-	default:
-		dev_err(yas5xx->dev, "unknown data format\n");
-		ret = -EINVAL;
-		break;
 	}
 
-	return ret;
+	return 0;
 
 out_unlock:
 	mutex_unlock(&yas5xx->lock);
@@ -289,9 +285,6 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 			/* Elaborate coefficients */
 			coef = yas532ac_coef[axis];
 		break;
-	default:
-		dev_err(yas5xx->dev, "unknown device type\n");
-		return val;
 	}
 	/*
 	 * Linearization formula:
@@ -798,9 +791,6 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
 	case YAS532_DEVICE_ID:
 		center = YAS532_DATA_CENTER;
 		break;
-	default:
-		dev_err(yas5xx->dev, "unknown device type\n");
-		return -EINVAL;
 	}
 
 	/*
-- 
2.35.1

