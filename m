Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB3F55011D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 02:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiFRAOz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 20:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbiFRAOz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 20:14:55 -0400
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E55214D37
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 17:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655511292; bh=QafQc4ZMyctCnOKdCtBnq0f/dxsC+4Cf+E3CVMEn2HA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NtmOtP/KVm1GfNsLn+TzLvUBLC9OIsXqyNmFQg2S17T6pjM2kpAyJAnrOF+CqSAE43Lq+CE1lqnfAI/CZ+5VNw6iHEbz1dS4q0SJat6GWA6HyfYREW+0yKda8EbI3LHEiq5a8lCIddROXhjfviwt6mKbbbLz+YqKyXUCuz9UrOiSMSYephZOYMrOxC6llQ99tuwt6MBToRXHbcsP++Af7yHdVsjEp4XyfeQ7XBu3DBuHkBzwN6/7xdzjq+lEVqW2GxOSTxURCOKfaUnR+6X09edwiivLFwus7xiFaSh6b6DLr1eqV285Jemt1tbyYAbUzE+ndnprO1Y1OuDcPV5NHA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655511292; bh=q4KF4LnLCgGczavQeg4kZbz0UBI8FlurD6Ewv0UfQpp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mU8ML18TUvIcEbxLeg6lhWilNAMh4IilsuluRLt0mV6NHnvOy3d+w0Chrohgy2Gv3GqMZaznOr6ZNnuS7r8rGATITX/6CHKIfyuB/s4K4YKCdN32Fe1z/BpJMeEnVvranVM6C+N4FX/aXfeMTmH+h9bwgP4Vo0W3OWKWUqxZeAZeT/bYWqjAq3mmwEYshz83wxl0XdW/LfRFgbGRuLzYvfmjGyND/2XhAolR+UNjSs6HH7QLlnCE8aPA416uzXulsHN4roJAMor74P4X5CQdr7cZPScU4cxH+UOsWzd/DcHdt6f7FDp/uLC5ZdjqaXoCEhbCxl7HVE1DSZdmI88xSw==
X-YMail-OSG: QXckt8AVM1k5Tq_SBboGxY9z6NuiwLc2mrsX0ttdu8DV6_DMtVzI73JSwDy4wmB
 oEkvbFQtdNqdZy3gRA.2F3JdvXKGvUSTmKtub7_LNL54xfBtUhZ0b0OCh5t0Smkq9cktMIkvFpan
 6t5gj61EvPo2yM9wwkxiT4HJ5kNO_avwN15LXxp_IgP_6XC6XNmLel_9g41nT4mzDLxn4wyj9kT2
 rj7STNnhz_E5CJ7f6DuKA4zf4a5es9gwFtpyQs0OCNVPrC0GPIDMoqQjqKKSc2vKlLCedw_hWGHC
 GWK6NlpndxH01403VclPg2r5j6zG0rNJEZY3axFLQfuSdXqrV14gLHVRZm01UCLsdOX8gYqNg32b
 _bWwdAlMVPm_OLyUs7bjc5z3eIulVGBDCpRJqnjTjHwNOS5HWBCoP6WyyGbvr6RKRDxZbYiHyGNf
 hMWNaNPkEKKx.JLN36hnaftCrYnH5TOh0vuvuzZF0C5Uv6Jeo8C_4YzpQVsId9z0eGAHOBLaDReA
 W_ul5nCDEy0KnB3kXqPSH8mmAnbI6dnisvJAeMvkqjzG1EclEwM9wt.4mM2.YhInul39RqoiWU_7
 Kb6hEL3ipOkPWC5JObz.OXk_Wxi2SPIsjt2l4IHlbc.jZw0QGbP.LcSoHEK0QNFYBuy5MHd4873D
 5zAJxvUBU3Z5GUDgpjAyPgXdOHwL1q2evLpujajmyUYFgALqA6epARZnn5i_Lk.Y9o5whK6MbkkA
 b5Xy9N7sJcblQ_4Grvnfn.r9m1W67FGI3qLVmWYqzSQKpcDBsyN7z2F2MIkK7H19RA4x9tNucZT1
 R3kgmVS4mCCaf5c_LsLbcFij0YSQuf04qbNBQof8IlG.WWZdVlKE42_uBQ.JcW4kI2kb08qw0F0e
 ls63eFS0VFRQ.62SBK27iO0EXD_R25BUGvZVMkihNMjYPmKZKTvUyCc4FO3P4zAHcBBz8SN0x.f9
 HELJVA_CuBoDipzdNYbkMSnG83r.lZkOq.B6Qe7DZ7goZDfpojHnclMKHDMzFbGIlM_yZM3yhdBI
 2V6k.FYPnYk2WSeVs1CuZFzbDxlRt6_mYVZ7ne5lbmx0vZDzmlskDVI.KFX7sUJxHQaBF.YsZ._v
 4.c66zF0fTP5vyBlaFfE3EfdvTZIR4WaY43VnSJuy4dJdsLsEZWPjrvCA7tMu7Sgq5PNQLNYXNt5
 aUrioas57bU00xt1qi_gd6vckpgIfLq5f.dFnQY5z5XH7oP.Bw0io5krqOSFLfQnQFJvxbSJP4Ac
 3nb81Khu_QgvGurqZC96TFdIYhU5WRgXiA8umZp9n5SQyHUmLTcAh2kBNMkz1cZspaZmsay62cnZ
 7SRfA9J.LlWMCfFD9gc0k_rrh_uzDz8c9xDke7nvD8Avi8B885FzDTzHNoKxwbvlwcxz5hij.hf_
 u0L_Un3d7a4_k1GLJ.0s.jbJjTNpqKtrLBXmvOfJjDuaJ27ktYYHIo3KnIjTD7RBpO3cawWd8rY0
 FeF0L56ETNr3l5WgOjmNLd3qmOScGV158sAKK1bSzr83EsoERYHYk5gqOjO4BtiKIyjhGet4TFkK
 6kSiDYIwZpAZv5.6R3v3jURSssls.X2PoaHjcIuV5Rfti92pFK.Ma4SgCxXb0TqIDCYuHtnMcILg
 h4SvYa.tALvfKm0FsUdIn.KgteGQYBLmePlP1Wt418WpZ8rQH8g4JmOqJ6fOk4Y71ibgDRNLPLVA
 czjqyd0.OZ5b6mWfZ4lJCXmFQ6n71D4W4V6SVfp1TU0lsHc47bTkHx8A5D0tunyiU6mLY4oBkkXF
 KY1cFdhVEqzp4lewN5w6p4HGslAvgUsAPuEB7h8nKj_tcSrcjpBvv9CGZ7vxNB2VxEQ5pj39z.aR
 sriOWrInitQSNpgoxjWthxyCWFJ9EZrKjS.OKBtyViAuCGd_vz2EvVsSMx7zWL.53z5MuIwKyCTD
 yNXnMhTevGYvUb3UGtShpsLg83GZXfITAl54Fwis.fOJ.c69sbnU2eLrmdqZHRRhtJATSNzja0Tj
 E8yLvXCJgc8XvyHfnrCJKK_Irkto9az9FYABdNNrW.vBn14QWOtH_eAWPoQRtsJm.L6zEGn68muP
 Ul15Nz0L0wreeAFOQXNJwUVqXQ_geS0BSeApIRx_LV_qn0ywaZPnbMsSMRDyosjxp5mv6Xu0deUZ
 RqNTnOxZWJB7dLr9qFqW2rKt69ijafUxtp145BIW3SSc8k4OzKR.SIcQqoM.om8HPsMipAK3iTxk
 FOs8i3DpslxCgTSVV96XRLX5oZCWzELqMAapr9E46jvXAr_zrG90zuc8IOXZdPAimPtTpIprUmyk
 yUW.5bsvLa.XQIftnYA--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Sat, 18 Jun 2022 00:14:52 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-74fwm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b08f14069c990c2ed22165f3e3da032;
          Sat, 18 Jun 2022 00:14:50 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 1/8] iio: magnetometer: yas530: Change data type of hard_offsets to signed
Date:   Sat, 18 Jun 2022 02:13:09 +0200
Message-Id: <dd6fe7f67e2f8c917aabd6eb0e0deccc660b48c2.1655509425.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index b2bc637150bf..40192aa46b04 100644
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

