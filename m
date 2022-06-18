Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4572855011B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiFRAOx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 20:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiFRAOu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 20:14:50 -0400
Received: from sonic310-12.consmr.mail.ir2.yahoo.com (sonic310-12.consmr.mail.ir2.yahoo.com [77.238.177.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5695D1570E
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655511287; bh=9TxwzDycA3KEb8oeya066opG4vzRyaGRNE/yQ1cFbhE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=k87zx+MnXuesAc9x9znXOgGHPv/prI9Y7J+hNtEHDSNCXkNHiom5IuF9/V/syGcx1KG0YuL0nGkDntAE99tx2CIZzVc878qcGlEeBbATJ72riRtzbey2WKHyfZnV4EIDvEuAGfJu+xqx4oRatqBPf2Jydpn4NV0a//srw4gBv9c/gRz/2oediAJmcfa579Pr6bVp2woh8kmSAl4IDB6117qBzZAQ6gfsf0+8yFaPVU7nOTfSi9VPcm4/ENpjLpbaPhr2PIhJB7BE1+X6aHI2QkU5KoUoGifTfNsDkOAbZqBVo+UvCsP9fiuwmvoGNx+1C64VK6bt4jOEuxSjpwQwhg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655511287; bh=6liy8oX0Yp/NkcUeHlmAFw01cIxTi/8teg0TzJRIsFL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Xi3Z7BBM53QxarG2J0ynOl6iRCfG0dME5vbSz4knltQnKrLOY/HdsdKdhzblYG1Rc6Nm8mslyNqhkRNk0xLJKjsHjsLf01wZuwo/OjjX8DFEAf44asLk38u7w22McrWCqMsaV3fUVHWPgzlXChQNjH7pgLmIlzhUELjLDjGz3AepBXypozDw3Fns/mMQIoTqMlYLrhTky66VZEk3ehU8CuM6u8V99k+utr6UYHxQ4tBj/XkPsoN1HEoU2PzbjhSDXEO5M/lCFKK9LoXBrn2y5VtH4IxTMQcBA5S/vZuBL2cW84QhubphufGhMAYEATQo1WdpUL/mQI/+u0Ug3eWcYw==
X-YMail-OSG: cOZfQzQVM1nfHGEs_utzRPcRekix.HzXuA1ce95KvR9pSiPI9V96_QI443q0Mop
 AZ8ouV_OTjgF53y8v.Cj7V6Goi8eVXHF2GGAX.WVsNdOZy9wWuyaAwikFVtahU_f8fOmjTk4XLbm
 1rXEkgUSQg.AKcD99Av_dNB1LjOpJab6fk6w.cbP0sbRdEM2Q7SVgp938.rZn4BDqNpAnLPwfaja
 M0LkrNqERfr5uhDyblIzSXHSgb_sbku.e.eOGmxGJkdIyI3TCFAGy1Q9gqI2daNtgh.9nHWBWUgU
 wQ9NZwMAQeK0TDsd8LCJRNZkJyOKc9IYphwtO1UBfuN.duHmhoKoUwlyEIXQR2Py2vffkS6eGOVV
 z1029szSmtzMYiT3UiXTnsdanscDxjBndgsM.eSLSEZQySayabPZKZTZWuPGWQLOaa8QCpRKZEmn
 xsrvEp5sOX3RGE1Et_Oa0hr3UygExcSABCmhbAqCp_SpwZAkfzEs.l7CdTwNi3heuf.Btj5RW7me
 DZ57TcsoFesvdBKgjdu9ktl_ifeSkdD7Tyuxu3NLZPp.UOrEg_YEVsFWLEvwh7MHcXlQ56L4UrtG
 vzoE5Aow42pbOwazhon.rHhMYbj6m1E4Mzq_7Aymr1OxvIS7hV_IjYSYA.7lEEwLjziA6KKCKfHJ
 KowW6ltp0rk6UeeEmavjWuVkmOLsieosO0R.MSCvLOZ6x7IuHg1YpsfuxIGZAAQYAaWrQ4dLZb3s
 4aOMpv_rwMv7w6ceoAtHvyng6zN5HbDs7nfAHz38qwSHU29EFmgTH6NsL1mTRTwZ13ukXWEBEG.f
 zdk_8JFG0PKQhelzQ4JLqlDL8qR4hwzk_YuXlp6zMtEBlHCPX1B_VqaTX3q1IwMg82h.tnXdupUH
 Jk.LPXXINS3sMR9SXPQbgVwZMRHbCl6SIU2FdqpxBmTwPiqgjNCdNbSQg_L0N7UrLH2qVdS7_L.p
 Yl.2r89wC3aRfFh5Cm5BXewblTSZsamQuqfpnA0eaOt1X_EM8bVAd8.KH17fN8f1ChOQ8PzoXOZS
 VQ4dbHD5xsOootGig4j.Vraj4ivMJQqBuUoBDoKEIcCsz7DZCbUzb739biWl0AmrttGpA.cj0Rv2
 VIaWSfFLM6ZmIeZbd1LOI6aw_Y14xd2ygS3uA2.eyMMOG7iKt49vgGF_UtmECCFYWdKw9Fzun6EC
 DJGtZvAakaMd2KENWkpgz3_2J_NrfDyLF8cZtOuYPhEsjSG2UOrgArZA4ONv6diMtpyjKoAsEWeN
 C0n7EGVawl2GUL0pVgXOrhoBYXqP.Sfyp2cCXavKXuSt1CDoBFnB0QbcCe1ATaVPcfkX_NfPhRUF
 nSTKfcR4y.CWn7KTbhWaMvdGZah_qaofOK2QVkItueXiKmw0rvDAT.sHzcTpE63QP9.mvNxgQf4O
 utO_4mWVgPXV2pnN5G4pC1LSempzje_w8qaNd8B72d9TVawxA6xJxIG8pWBtnp.tk2JSb.y7r1kO
 _D.BnUHGcMmaSS2_wTsrLZ734vYOihtjyZTrAV5YBYJ.DrFCNcCKpoYzdGv.0cMXzd1PhwjtY_ya
 PRzUAQaFcsMsAY4itradrPd29tKui6bFR_NSXjwjBr5Tr8fvPcMzKTXq_oIBY58gHh5oz3wtVHDW
 EmdITvfc2xBG7tEGeqR8XpNDIye2aadVwgoikk.N4GVmC8z3ynDdYy6eHVo6Hbl6qWulhiBazIqt
 EFTlpqRoQ8AnAlCx5.HWp3lVe1Pz5xMVgIQ51KZ_.FlkINj6J3NPG3RCpAFJdrR1zn21b4V5MeqD
 WAN3rhS32v6d9rPGmatcdm0b6Yeo6ael97cd2e8QQGIXwjEAYeRrqo9xBNU3YrWWOE8fAuT8I336
 J4tCCdP7vr9PpoAVQdlFRaVlgCDJIAce_h9jnJCVkhwKbUW2XQZpzA2mQJu3eFWTQF4joSK6Tfq4
 OOQ_5Ed27AaTU_CYcTyWDeYMpx99opy3XEDv52aykiX2zbaKtoqUpa.ytDPgWF.yKhr8QFj3SGFH
 dbsg2NGWc7Df0qF.yYsqmTJcwmW2isZWWPbIZ9r9l7ugzPY3b7D1C1TBTUtTKOpNnIKMhaozWW.U
 QN9X03exUvyR93_aRh_Sx..sCgpFsENa0r4qASQWvUoMnK97OzmvvvaLrvHoqQqP7yNpAAj1Jd1X
 50GAZeAPYd2jfsKzhnVTFSbfn.bsgzETelQtdezpnOQo.7w_12YL56V5ZtfVFuLlWUKRh_CiqCNI
 WloOFdZiONTd8p8irvgyF5JLUXoMXJkHzD_6YO8LfXO9O.MX8Lo6UT49hLoFguctQa58_rPgxtSP
 VSnNwDQ--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sat, 18 Jun 2022 00:14:47 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-74fwm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b08f14069c990c2ed22165f3e3da032;
          Sat, 18 Jun 2022 00:14:45 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 0/8] Add support for magnetometer Yamaha YAS537
Date:   Sat, 18 Jun 2022 02:13:08 +0200
Message-Id: <cover.1655509425.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1655509425.git.jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds YAS537 variant to the already existing driver for
Yamaha YAS magnetometers.

Patch 1 is a fix on the current driver.
Patches 2-7 are cleanups and refactoring.
Patch 8 finally adds the YAS537 variant.

Changes in v3:
 - In patch 3 fixed 2x typo "Divide".
 - In commit message of patch 4 fixed wording "in the yas5xx_get_measure()
   function".
 - In patch 4 in the comment for the temperature calculation fixed wording
   "is the number of counts".
 - In patch 4 added defaults to switch statements.
 - Splitted stray changes into new patch 7 v3. "Add YAS537 variant" is now
   patch 8 v3. I haven't added "Reviewed-by:" tag of Linus to patch 7 v3
   because as a separate patch these changes appear in a different context.
 - In new patch 7 v3, changed printk format specifiers in the function
   yas530_get_calibration_data() to "%16ph" and in the function
   yas532_get_calibration_data() to "%14ph". The first one is also a minor
   correction in behaviour, as the calibration data array size of YAS530
   is 16 (the dev_dbg printed 14 before).
 - Rebased to linux-next to include patch bb52d3691db8 "iio: magnetometer:
   yas530: Fix memchr_inv() misuse".
 - In patch 7 v3, changed memchr_inv() line for YAS532.
 - In patch 8 v3 in the function yas537_get_calibration_data(), changed
   memchr_inv() line for YAS537.
 - Removed comment "corresponds to 0x70" at define YAS537_MAG_AVERAGE_32_MASK.
 - Added suffixes _US and _MS in defines for YAS537.
 - In the function yas537_measure(), removed comments "Read data", "Arrange
   data", "Assign data".
 - In the function yas537_measure(), replaced bitwise shift by
   get_unaligned_be16().
 - Replaced "if (h[i] < -8192)" etc. by clamp_val().
 - In the functions yas537_measure() and yas537_get_measure(), replaced 8192
   by BIT(13) and 16384 by BIT(14).
 - Fixed typo "resolution" in the function yas5xx_read_raw().
 - Fixed typo "Divide" in patch 8 v3 in the function yas5xx_read_raw().
 - In patch 8 v3 in the yas537_get_calibration_data(), changed printk format
   specifier to "%17ph"
 - In the functions yas537_measure() and yas537_get_calibration_data(), drop
   some parentheses in regmap_write().
 - In the function yas537_power_on(), added comment "Wait until the coil has
   ramped up".
 - In the function yas5xx_probe(), put YAS537 variant and version printings
   into one print.
 - In the function yas537_get_measure(), fixed wording "is the number of
   counts" in the comment for the temperature calculation.
 - In the function yas537_get_measure(), added product description document No.
   into the comment for the temperature calculation (as I first thought the
   review comment "the number" is related to this).
 - In the function yas537_get_calibration_data(), corrected comment "Get data
   into these four blocks val1 to val4".

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

Jakob Hauser (8):
  iio: magnetometer: yas530: Change data type of hard_offsets to signed
  iio: magnetometer: yas530: Change range of data in volatile register
  iio: magnetometer: yas530: Correct scaling of magnetic axes
  iio: magnetometer: yas530: Correct temperature handling
  iio: magnetometer: yas530: Change data type of calibration
    coefficients
  iio: magnetometer: yas530: Rename functions and registers
  iio: magnetometer: yas530: Apply minor cleanups
  iio: magnetometer: yas530: Add YAS537 variant

 drivers/iio/magnetometer/Kconfig         |   4 +-
 drivers/iio/magnetometer/yamaha-yas530.c | 797 +++++++++++++++++++----
 2 files changed, 688 insertions(+), 113 deletions(-)

-- 
2.35.1

