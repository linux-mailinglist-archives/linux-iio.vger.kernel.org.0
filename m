Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8476158BE38
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiHGXHc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiHGXHb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:07:31 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C513438AE
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913649; bh=8Fz3yYl1tXTkqaM9AF5KjSfyN7X7bxpP77X26Ox/V18=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=c2awqPB3lVcu1p1js3eYdX1sIU/mAcIjmBpuP+ajRlR8+YBD0xugj3RKvrgZ3mHYEvvQM+2vMXiZzmWlEPKSpLC1AY0Y4rSn3vTYG/bv7CGl9w+KmzuDmYkxQ4Ko4Y9ctxapZRXFKiQmALnPli/QinMJbWeyWaSd5Vfm1nh0TJqnc6iEVEtj9kss0gUEoPEga1npNR1x6YDHxcF/eRInI62yEbgPDbSCD/pdkKoBY7aZ3BtzcvUNkcPXG4amUoj/0crN0ehGMB4iHEOok+kA/eNZ693qKBzaQx2y0bzC1zuZUp823++BcAfIm+4i31S+0qcSTLTB/xUSWsASvvhzdg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913649; bh=eaIXbSnmtkld5YpzK3JxExnpNWrrqkz3QTnqpcqOLxV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FzxI1ICXIcO6p04JEJ5f8aHHE2cQoHPpvAQW2SNJAO0jhmW9hY+0RwjVAe31Z18XPoXJNQ2jLSWIec9OPiuNfm5cmnYBPK73hu3w1RDnaOF1TJYKQ6ETF9A23ZWt5CVW09EUksH9+BnKoRQmGYPj9965f6QN7NyXW1UfJLMN3WUM4/AOVZU4w2avlwdEAavoMwa7nfXpaq8SbOD2ifqKOQ0pIejDjhxtdcw+AC0z6YUGDHMYlwU/wFrbT9VEkrPO/iQmuE49l+rNfMLsfelhDVnsfl8h5xQmFcBhoJoZ8U0Pe4XTMtg2cO+5vn1KFLoewQDHAqL4G9gmfyEowYbWaA==
X-YMail-OSG: Iem5lw8VM1nQZ6xhHtEYNYPqz0uhdlL7rn2x9SPv3RvMH9rTATGXIshVJJusODi
 5ByUr66AaJjV3H.fzNjsP5irWm.J2XVbf7.xtmRv1ezMZVxL_LFXxROAAkWfNQoxRL7JiCUrm.H2
 Kan_jGopDMid4yKTat8B2h4jumVtt4SpgbM35vQXV.iWucbyV2RDEGcOz69ezoAyY.hl5TxF3h3F
 yqciXDuibcPSXc22yqUGuBIyqkqKf_Rs3uwNzElds5.q0HGkv7DV9ovDyY7ldG5CB.Q_JPIryD_G
 Rc3GoVWr4EsC6SvLiOwbjYGuqZit48PH6IO4DrzUo6cZSMkutWlChlA2sDlEPv7guWxCvLB5.IEa
 tNVHUSSQa_PSqF9f41a248lxB93BirpEGUXvh3UUqBwmIGQbSV9afIzwc35iJ86Se0F8J.Tbt6.P
 Fr7OWmRrOF5xJtR_GokTNS8H7a4qo1wp2c89MRQvE5j98U_aTqQKBXcqiAOBhROnTczxr5qtWhWg
 It_iYgY03ld_gunV5HuQrXQKYh0TEkzOoJsdC0Zz_E.hJ4DlXnfs4GqcG2HGfj0wRntN2t6980cu
 brJpxsb_pMyYxy7dHqRMvypFlEOFeBKrB5r4hkGAD9e_AzC4e7rQAMjLhq1JO_TT9AA3yI_iXJax
 QBFTXVio4j8ZIrqWleULGf78GcZi3wLTwAme9gaa_dOGKy8vjW2e2yJO_if_obyq3BUf3MjBzDwf
 xSM_NiktyWZYD1O_cUcHPfPNN.FdLCvCySx.B3HgJ3vQhL5lCPe7NrEgwZeySIdM632Jh2EfeuyV
 0q_XQGbb7hjmUnuFeVpqcQ96HETb7BSSTGSyW5otM6SKQUSLFyewJU2RUvLM26hJHfBjCNF1dMoN
 Ti5U_f4Wr5Y1sdqgf02.pZ4peZuTjybp0ujTPfqBy6RqfTnVrF8JbA0n4EySsgZT8sJ_RxKQFpWj
 NeFIEpdjhTNK1DPiX_eBvwngmBJA0RaMUVx9aNOMA_D.51eUj0KfViqnOJANxM25AxsVFCNxXN6K
 x.3tkmi38yAXfHWh0C1OZDyUdzMLx6njPG9.DISY2t3QK2OuzDQSc_LpAzfVBrSPd2PQP6.m86XG
 hgPcQKixaNAXuKWXlotAaIA_q7piWCmqgY_czDzGvQnP0uZ6CWGgxmtWAIVLfh82UZmcbefiIFcD
 HmFhv9JQYr.Z90ljLgYWr_RddYCGcddKZ4wgzAocjVKPXbLHutkkBYkxunZnpzW4rU3M3Tld4dRr
 VLc7AS6aq8rKslxj5rWp5ajzGHe8_7ib8R2LKs1NBDVwNbMlRvF9zmLO9fBoxfeo6eJ7CMrsY6nu
 0ODoN..Qx.Vw1lWEsiZkGYVtgZhYi6tlg64KnAWHdm.tH6gIOACBt4Ipfz0I0tK53aV0OdyV27Fh
 x5gwSHkXyFAJ6n2ojXmSV7nAzqGP0cZJOJ_6M9H.UiX_UXCJYvJHXz9eip7GRWEMWlwN4sr2JjVw
 5htTfhaqLl1GfrbIvgi8UWkVaBAJRbLnZ3ZrUQNmv25q9ml1PMTsPIvnTqp8gQ5WaYtgFoL8Wzzw
 Nu.BReTXnKvmTd9pL8D4BsDsDlWnsTgH9Hy2RYR2gOwQkE1fOlSZB5K7OJ7TZ5HjcxktkIEjNhzc
 bGVYeLCBshThiD74Q_bvJsqFD_v44iN6ivhrWbn0n_vchxv8H72Z7gXK.U5weVnlEdHHX8TOx8l1
 Pt5sP.rki7_0NCNsT._.Qgnm1YR3hhBFifpxkP8jdRu2ER_.dFfhxpE.DRfYplHdkM5IX0EzmZzT
 7ow6V4DisnJMjHj6Yv3XhYH1MawnL0L9fQji5rB8SqFCz8Bq.Ni9LChTiYM6VtPhx_XaB6qZc1c7
 v0hHU9towOvM5cvw8UNLU_87P2is1z19S_g4zUh_kkMlFich0wbG759lLhRWKse_Z8a6ma3BH6oQ
 Vt.ycvTdCbu9Jvy0W936Ijy93GNjNIuikIZY9Z4JoDP1cIlItnBp07FkLO6_Ti7Wn5nMe.rLq_mw
 nYkKaenGPPw6oSPUvjpsxsUFRfOd8B3a4GAZUyQdG7yiWJozjvehBF8IlY7MxWV5xil5AS_fuMwu
 OVLAfQ4Pr5at.INSzrJM.k2dP0CXnNPt4roVk41TLjjNWKFqXaRRSqN3ZzfdgKEIyzC.VHX6Iymg
 qpYvnt.BwG1aifqbR73pzGUJaHp_5hqFgVHVeT7F1NrtVMIL12C3beNIWkgdzh87ezrdDDVFJ.lP
 SOxCL5eNFJT0FNuFLrE2FdxR_pu3OLzJy_a156xBGv746s7YAgR6Qh1cZdApM58IL3ieZ7QU6wlr
 DLelhkpMGWk6QfndVbXM-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:07:29 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc92a55cf24372a35650a28a19dee6ae;
          Sun, 07 Aug 2022 23:07:24 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 07/14] iio: magnetometer: yas530: Move printk %*ph parameters out from stack
Date:   Mon,  8 Aug 2022 01:06:46 +0200
Message-Id: <0f80659d4a5865a267cf75eaf14a23b8319ddb92.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index b27cc2b432ee..48995176fa39 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -664,7 +664,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
-	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
+	dev_dbg(yas5xx->dev, "calibration data: %16ph\n", data);
 
 	add_device_randomness(data, sizeof(data));
 	yas5xx->version = data[15] & GENMASK(1, 0);
@@ -711,7 +711,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
-	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
+	dev_dbg(yas5xx->dev, "calibration data: %14ph\n", data);
 
 	/* Sanity check, is this all zeroes? */
 	if (memchr_inv(data, 0x00, 13) == NULL) {
-- 
2.35.1

