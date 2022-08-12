Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6805916EF
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiHLVzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiHLVyp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:54:45 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F231B4439
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341281; bh=caI5YrEKF79TQRJda739FwKXTDN05RVs3N/XMdhJsGs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=r2Fm2xJQnkVGpvH/FjrMzJEJc1H7QKcgCcj0RZmt40/DcFbLI+jibx+usznmZAbKeltHkH0wwM0OUmH9usjoDz1VXeWHBOk5+aN0nA+DmKEbzqfgE9L6oa3zney2bsMcHxmZUeF6bqf6pFFYT6HV0ABR5YPDw+IlI7fcMj0G4DbzQQjdo+BpyR3gmfg9Um1wISP8+ihhHRoOW3EQEA+PFTWz4I7OYil6vl2mIrH27lyw8+8WmiFk1K17QUNJp6VGupLNdoobQqlgdlxlIKlqiXBdkljLUJHGqYmAkIqbNRI/TG3THVMHEuF+w3RX/4KGnBjXYf7hMdMh9Qo5OzNV0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341281; bh=S7M/3Krv3JLZ3bEmLx87WstdU5m7uqTHXZIt/gzEkW8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GhRdBoFa2FM+OORdp73Drd0b2PMiX70bgnHaPrFYIoCwRPyXUlbGo1mwOMQVFMCVV80btXwOY13Ojkuk6pODGtF6xo5OLaM9z8UlJl9rW+p6+AAwYMWbj120n+5Kaa5tgV3E521wZwKP3xFUVM+we7KiORAIXyTK+Ef+DbYExddVZSoVaswvD42dZQ9y0S+R3MlLfH2lAgNaXFeL63ud8anzao0fS9oPOD3zQyuAQg9pU98bF0WOqrCQBawPfZ9zTcQD7lp7GFJ7mjN1bD488sATPNL7LBoGMNwQiqATzqCMwfpYaVZNA2wDvq2WS+DpcjvSVQ+YJd7iCtM2j5EQNw==
X-YMail-OSG: Hr8.rPEVM1kASFQEjhCM2Ih4RibK4e5J9IaDxHsRYsXBLOK83AnSmQsAth136tK
 jewwh9H8JocPixayvEJzxgyGbHngWoo50yBi02Cc8fJFO__Xl9N1uZku2VVNTjqezCSWQw.Z5Tt5
 .huzejembKgmNCb20NJPphj7T4nJmRA4IRuP.Venii5VhxlAaWarh2X6mJOhhxW0Qd2.M5VrZHNM
 e2PFU7h.b.ht7B8U9LXu_eXpaX3aDjoOhsj7Nu5hn7j3WffpVUSKKiz6BEuAawICTZJ5hkjfkeJ7
 rbagcJeLYu72VmIR_W0o2NnKQY_ZG4Gx4iRhwh3QjADETZIFrrvfMylraoIe7SYPB5J4HMdneOz2
 sG7ZZLSabOFWgFsuT7DKMOSCWnlepzRT1CwW0R8O4EimNUNFsYhe5vaWVOgl8ZNb52O8D4R05oHN
 525fsneOMVZsDGRokaKaz8284ts4tomwIo7U_PC8PIO0wZaz4FUS.uIGC.msXnZ54ow2wkzQaYIt
 HqOPZ2qQo.OJXrRp3At.PEJRLJCGeg1EIXFw6j5pp.dWPzav3cOM_vSDS36a025ncAWDbSJTiz6c
 Lvg62eg8KZMkdJzoSvRJE82D.e4SIG7iqg1c.x0hY_f289cF8YUXZ5YubxX91hOw3T9Yjf.ij0kT
 4Ai_.Kk5fIi4VPZXhmniDBSUtgm0E3tOVFH9QWy3TEZmfv9ROfFacTsQospvT_zlHXD18Ia1WYL1
 UIbK63I8e4L6UKiQpmv.mSCMPQ76itdPTMvKcgQEFuixS0VHWQHKSvqJW79mekXNQKiRV1K0zyFP
 1LSBioI5_RcKTqAIhX0hk8C0LqpmLsPjRUgrzcHi6sqOE_VWPcE0kpA95X3ng2lSx34GZ.Ujh8b2
 iv2tfd_YKeVMTGyMrbdjmk8_C5D465iTcQrf65tHzRbu3yYR03nCQvKkkqNT9G_lM9ZuZzHEUg4o
 Mf78B56A_CxeEoJdZdi4gpNRPyd2eVM8jLr5RWs3ERxkcYXBMPsaHSX6.o0CUwDaJQcQ2RWWzHSU
 1oyf5AnlNCd7rrkapMaihA6BDW8R4NB200c_00smTc_NkZKq50.UUZPafGDebiqRanTtFHQzisH3
 wKR.ppAa1TNiZP7HkTc44xT2ROQ646RwlPGHMC51miqWEaCQZplhBlylhTCDZlNagWjP7aOT6PQc
 ELfNonmA63Xt.e1yoIXpeRzh1P7TRBf8RiMMhAs88JSUB5Oa_KygESDvvOnAFJ1AWvIVd9PXVXr6
 3137ibjTvbqS9w0YCjL4SOFPnuubr.Jg57w6BuAQWFiXHNXl_rTZPr4RcJTNJGDwvEqwXz_4YK7m
 fD2XD5XTA_0Qh0ozexav7_LZmRGnfxNbEHykB4lw.325RBGknTLlfUBQ7qXqMGb7GSIiDnnR6QIf
 N5p2kS1Yw6SFTJaxpbXmOxsH2uliC.8LSPtxwh_Y6lVvWdGHJbaIhPFb1LUzRDYpV2iMGp2obc4W
 ZD8Svf9Qvkn_RMvCzJGdOC5OqxTa_2ErB1Qc7WBVevk1BzOo.WfnupLwxlskbjsuAcpiWjF4eLS8
 C6yvUV4GGSiYazYwbr4mvigSWdpJJ3SRo2kJgtRIZjeXm7MJf.jX6TQemDqHxVXP033iHBSlc69w
 kkBotfjrBwXQNEp7OOHsbUUY64o_4ucewQuqmRGvGVzqT5qQaIqzieO0c.PYNb6WDHy3iRMPScGK
 nmCOb3S1ElFzoQLbZBTdc05VCI_c8zIPLhClXjsp0.wdHwpuDSr.YUNRR8xUDVLpHNYXA8OQmPtv
 ArQ4NF9FrD06x02D92C7ixhrIWAKwNgf2Cm6oOIcTBlyKtY9EfQwUR0_x5z9g2mInyU30EEwFeYm
 XZ2ZQr8klHv3p4.HfYB0uCFdmWaIRXJyE65VGu1EMoIbnjM8AzMz9dV0b.gvmyCmcWMNY07GM3Mv
 xQoGAvFFvutqqckUavUA1ECMTdNr.twQQRgM9dlhqsyYk0j0cUC9AbhUzNUBTRF.fa31ketZNUSN
 dKyGu3sYh9dj7E.3SBiP_TssAKnS.fu3W8lIhdeIMKHI_N5QoNKfIOk7tvSFK9ZcZuHmf3r8vdKy
 DafyV_yjmDy5ovlzRXMB00ZsZ88iBKXjLAxfhypaqIUsNKdSJmWfJJiZ6iMrjKpgOJc0T8OFw0g1
 hXEDifhSKjA0.jqe3js1N81SYBpY4a4usZQq9YPTww05.RdSz3utFEq7ac00Hs_d2hnH0DZj6W9O
 XHzbDP_WMESy9n9C3x39bDc0cAaY8KRsuZFf7lGdpPCSnJNd5vaMnkQGLSzRIFUf8H0VzlGQZ15o
 g9DAo3rLacffZUg--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:54:41 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-sqjll (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4374eb8c565a32f837f1ffd0e5de4e7d;
          Fri, 12 Aug 2022 21:54:38 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 01/14] iio: magnetometer: yas530: Change data type of hard_offsets to signed
Date:   Fri, 12 Aug 2022 23:54:06 +0200
Message-Id: <40f052bf6491457d0c5c0ed4c3534dc6fa251c3c.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
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

The "hard_offsets" are currently unsigned u8 but they should be signed as they
can get negative. They are signed in function yas5xx_meaure_offsets() and in the
Yamaha drivers [1][2].

[1] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas.h#L156
[2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L91

Fixes: de8860b1ed47 ("iio: magnetometer: Add driver for Yamaha YAS530")
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index aeaa4da6923b..d1f16729c60e 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -132,7 +132,7 @@ struct yas5xx {
 	unsigned int version;
 	char name[16];
 	struct yas5xx_calibration calibration;
-	u8 hard_offsets[3];
+	s8 hard_offsets[3];
 	struct iio_mount_matrix orientation;
 	struct regmap *map;
 	struct regulator_bulk_data regs[2];
-- 
2.35.1

