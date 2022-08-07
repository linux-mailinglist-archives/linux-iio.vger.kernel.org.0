Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C2758BE2A
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiHGXDk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiHGXDj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:03:39 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com (sonic303-21.consmr.mail.ir2.yahoo.com [77.238.178.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642832AF3
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913416; bh=RGArz7Zwo1YrpUAyYAm1grVSpdiCN8Oa/NeiK93F+nA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DtAKcIiE8ZhVLHjOTGR/SraZcdQGMYxByzyFLwKn7TmoOAWm0E/z+swGaCfk/Oyp3z1TDKRdUanK9sTd1d5fodH8r+xzjTGA68sywsb4oR9/ftJH7RghOof0uxRaOX1HahH7SDfXyEDm5lJ3EtQ1hySbPmJ3G3iiI/9kD5HlaojW+W/PsxJv5n9VYwe8GRBGEnM9VBUM4/PUXTYbQbFSUH8u7bGtJjqID9ejglg6ypCaOIFHNa9bXBbbFfEA3PMn5AsqFVDWVGVBlAUaAalWxup/M17OX3SAsMigl2c2qhQoJm1yYDmi3mPtMCX+QYZ24RVKh7LbWJdmnEtbEp50sA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913416; bh=jtL6asjC6CWMwjFIVecbhhHryD6TTv0fXDQbOeL1WUM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OKIWVG/GwrqYVsq+u3KLT7qKZs5gxtawZ38U2KBXrWjiTnpfpAfWMrxqAcDpLK/GgcB0Njq/pfh9jL+P+Fv5QMQAZ26nkyXVrtOO5C66nrBCyi1OXmrUDeBqiaSPpNbTwuKnJ06cLtLbz/YglFcczKaqkQWL3LY5/kqiORTuubgkkoFqpZNnomtAdOalowzq3tdpTqp6qioviJ87Ou6E/jLueRp35NtsPQU566256EfvlWJGejcg1kYNGIzZR6+xJoboPOb6T34Qcm5Fqv/nqtFlGU5BDlX2Uqdy51UbD9IwojiMgnmEhlQpW36h45ZqdmA01m3F64vNnvKQsI4RXA==
X-YMail-OSG: glLGcR4VM1kdK15_ldsUx.EMpg6Cqm0GMjRAKexezHBwhKrq9qBGqdSYBqC3lhD
 SWVLtU8ec0tbeIE72wW4ha_PiyBzR99XsBPZu2ySEtPQVtpqZk9SOWZEmQYqX3MGkon.FMkgcXWc
 G8ENXRJJipV62qHqsRhEZzLhJmvzNhwOswFzUoJmI97V_R6_Y1w73vLC7lz.yxhaEYnBK2TDzdVl
 DC74KDkX5AWoyNspLkzTLd7w3D8nPVaeTOJ1NB8qRvPufMdoJQ6JjpsvORnkoyiyj3.h.5ZXMIt2
 ucii9s6AAS8cEN6Hrbh8mPYfWJzC6QjX9hyz7bm7fO2DP2xxw0cEBnhLxeRgJI7vpoyU4_9nOFu4
 rIvelk8xWr5lBtTbx5fp1L3Yyj9x6HNGaRxmvBAMrFDJoI9DTOR9nlJg.DjKjyT84uOdlb4JswRy
 4SkGhWOcsIklg9De1Vn8yeV4LD2zZt7qqJCyK7T1y5MGF5YxPrI3m7VVV2nrfeGRloUdiBXX8KHQ
 wXxg4OxSSbEBNyLkHm30Turwpu9aTd8wvWzpv7j_.YBF88.RNz0lhggkVhjilfSwm4IOik74gam9
 Dk7Atcae_hzpWcFa0mtJQfyZ86Is6QS9puWtlaX9CkjE_Jcl11ZsGrr_Q1_pIvoxA9iVsd1Nkv0n
 qn68aKjhNeGhv.WR9blQ.kFltLJk2RHDgXLaAwt5EcK7RN7vyeTnX6cqnXuxzaDlGpZEck1nw72K
 uLOQnmeqYg9YkdWWgp1pX5eB8_Is7469rtpxQ6HgAlfkm3gYXqw7HKUPOmhW1uHVMBZYq9hahiPx
 67hSC5RohUoyk6VrvZ.ORPqLZjjAy45OezRLvIbBGmASB22elXg7v0Ozwxeecj.SsabPDsaLwriF
 7N.UDhUYw2rR3zTvE.t0JQ65JplYChkWEVW85SmUQ9Kot994j5L5KPWdgtVP5kcZkiDxDxC5bMvs
 EuC_OatyF1eVbrEYxEj9GJ4itIzws8jWtvKdL1zacRWnq68LYFJA4qFVj4SSCBh04tPFzypgwhwO
 QW1HA4_oMZbKJ1w8y2eqXpJp9B5xT2jedV4PutzasczQrPeaaRNlZHRNomFq.k_zsc2O1GHul65q
 ss.69TBXgJ3Qy288NxxNmEJQfmdUW_JIQjbdbfz2nxdVqa1DkPvHT_TtJKdmFuqkEh5iR1Su2vMM
 Pe6e_42gMWORmVgjNbuJVUP71wV5JJzaJmc50MuPozyBY7XFCHsKHEcgG7781SPR4vm3g_zDreqf
 YisX6Ps5lcNVH5RUWW32ifyE7ipBSBsCYbrwESINKzmfTy1h4LbC_MgRyxM8S6XAmRBRQe4d6swp
 tdb3oPqEUCRdld2Yg1m3iR9lKRu95zZ6V2XmrWyaZ9zhU4QplmlT9iVJGmcpxDZMxhefgfGRHZEM
 t53avk3xMnzTLVVBOHMapRGln6z9CfBYPbzU7T3DNuQ3ri1eOKdLUvOcwhqAyN.UG9r1O.G6cYo9
 l9ACnnajTVRlWTJzCK3QewGidfKWNFcRkFt1mQ3q7xi2ol3bunglQS6jPdLUzTFSkefncYSlIQap
 7tU1i0GZ5B6q4Kt6AGoD8Lr1NkjbeltNpOuvb68sCJMPieM8wZHkm8u9EfXNFwhYA4WrMciyyN3E
 DsOJ2606KGfkpgs3Y2T3RTLwldbMdw21_.G20wbEuThpr4b7xTv8Cg4ogjYXUl2T6woUQUr0MYUE
 nMDx1XVTwJSoTv8Qj5UENgKcuD2AIfDT4ljrDKUiIpVFvE5UKr_5Qd5NZmlJx0BylY6uKjqeks2p
 ZB0uVIkDWShe.hURWpQIMKn2kUKA4xOtzVVWQTBKlLa_wnIwGGo9iZtPUpcpxprkqcHe33kWSvTA
 zV_r5.VvkoyQwtb23fkO5I1A4rUCxru_yMkd7Z1WZZfpQEVpj8bQzoVmM.kJoNjDNzDAphvP79jI
 2YuGbatYDxU6fk0Urngq.jUXFo.iXdFcVw9fFoYfo2up6ehuqtGlTKVK5ZZWivOxwFEjgpiUefGz
 FdlZekW4.osuOATkfdmptFZ9WO3MgKXSZWthwd4ys1s81HzsNF_qoLqPAMLKAkJdhSt66qiG50Pc
 PR7M2AzTy8W_G_EMF2kGB9CPnW1Tbwqve.lHWgzpRqTrhJ.N4Zc74SgW22km8IFu5ZnsQWrW1DJX
 1t4KAgeOA8JjXZ59tCwLQ_MApT1uMS8W9bVyL5DTokZ5kZG0q5kWGJgCO.bkIDTkMdjRGPstI7CT
 lkbBuzoDPzj7WyQTU8Wtg_v_OA6juXNSdR451RqYDmfuFRZWxMnfXr9CZ3na1kHvEOJoZT7in3lh
 SdSciYlEtjKpuaA--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:03:36 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-r76pr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12b0bfa600682cb6edf92800aaf76d46;
          Sun, 07 Aug 2022 23:03:34 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 01/14] iio: magnetometer: yas530: Change data type of hard_offsets to signed
Date:   Mon,  8 Aug 2022 01:02:06 +0200
Message-Id: <4293862b3deb526ee1163b6fc8d0786c3d9816fd.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
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

