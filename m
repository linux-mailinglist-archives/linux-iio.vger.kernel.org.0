Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288195916ED
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiHLVzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiHLVyp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:54:45 -0400
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D65B4436
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341280; bh=yj8ErZ91Kf7sDoBoW+AE1OMOXweGwX2bNGxKY81H8DQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Gx30bgJG/ACatWXW/Mq3w642+w22yrBx4bF4EHUGEATWtqkvrLzXmXMw+UlZCzy/N3X1iyiZhBX6p3HBz4fKTHZay8tNR6YAOyPbiMlw6LJrg9lIcIsRqgbDF0S0PnkJO7BH1I+V6KYZk73I9EzzPkVJyJWS8c11qX2aK4FW+TN9g6Cg9nJhmT1pMDd1R8eghll+KLx+eMtmsSYyghmrfnuqCUs2PCUFq1Kot7mD06cQTV4ab0C+GKgOvSHLN3gdW2uF2pdcKbyLBkklUuY63X/gdyIhdz65Ip61wWJ2kke3cDF7OYTQmXe6Q5YLyWW+2dMGsSwg9hdB+Dg3475jTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341280; bh=74eWSff/udTV/XSeHTra+ZwVJ9W3bsEtlJAm5d/ETbx=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GdCOlE4TIf8s1fbm0ETkXjB4hjq/1UfumsD27UxgJINMQvIPsVGObgAOEMVWIoVKGfqO2xkDEe3Yckt2pDBYEqzjjFKibqbmOTpzYo7hZei494CS77gKDsf2GPjAYoi4ZWkq56rJ81DFurHtX5BN8E1lPVbJWXdkWCpiPOa/spScs+JmwjqeA19rca9dnJyhO0mWkVeJMQNEHnEzEuQnyJr0R/CqdijMoS/W+aIzmWl7ZGnRzWE2E9W4gRlX6/4PbU9b4MPWlP5sn8yAePJLnZL+qrp0GdU8O1xyBjyNUttkCjfsiwDVWey8flzCtP0Ad0rTsifOGFR8D8z79QKQGQ==
X-YMail-OSG: w_8xIBoVM1lk2o4ujcfKxfFaA8_DV40a3nAF3wd9oNkmkgzn.IjFmu6XymkzJ2c
 vYZMUEuXh2bDaVkPkCMsjmapIVTT6nkwxq52.95.21cxG7K78Xj_X5TUYauOpxuOIoDE12xHqTVY
 8GOk_BLgYTzOYdR.omwOq3LwpZ6hnDk0e8eJoNan_XTgu9snZB354ldnzpkfG3b_GjibzJfauMov
 cwQLvubvpnEtGH548Gdxxv67qr9gpHFYb6bg_.wU55vRnclXQVhozrGDXYe.MysVi_33rLGS9TPe
 mMnjAv4dq1NGCSGIuQR0OmaDsvb_BrBKfb_nP8WfUlzZGOqu2f0ajsXIzm8ig5dpJERhsFzQBcW_
 96RwSGDWg5rK_zuV3Y5nmZNf9ndx4H5cCa8cFe5hJlnSQUkuaMrv76Bi6TndnYtTQurlv4OACpTU
 nkOM_RTpZMPHV1es6S8yekMYQaBZHCmVKXx0QHzWB.3B4IJrrkb6EzgcoXH4YftSS2r62eTJ6WzE
 3h7Pf78pUF45rHxvpi2ErT_rhgEFcpYBRmifcJIuKQPOoUwYzB4dRkt2y0pnPgTBBCn9Ymu2ycQA
 7B4TzCqBtkOw210dGZnGqYGuhqhl3LUsdyMnRzWBzG86winwxYF9IobHd4gCROMkXIQ3IfZ3g25D
 i24ArnhbNlMTxTZAYPaQ7oqtTUYWO6G0kF8YZBLQrgLe_9Pvubn9pSMD1T8sh2m_savKwcWvBazX
 _uPq42mPKgjVHdoWZOGY8jR1nJW4bgHMu4vYHTjvOd.Faf9QKXt_1m.AJkZdgGL8kOBn6ccGORpd
 4d2S5fcBkLLX0yYU0h6yqSzdX5diPSG8QjGtLsoUPqicfgd0GToxUIK07M1HpXpctOnc7I1QJLNl
 3VCTkD5bsRnGIZNc126rlDZkOZ4vRR28FLHkkdEBGbcyBELiY.32i5YZP5yA3g3XKcbEfzo_oYiB
 H.f9pVZdpZnURxzBuLeLOLBpv.Xm0sYNRA5V9cHKm1jEG1Rw.DXgcQmyJcRPFQwf8G2Q8ppUqyh9
 H6jzObUz5AsnN27LEucyfHTepHThA4QaN83sMDSBEFrptWikCJUnoJSxTAI15CItTUEczeHzrm8s
 ue1R6cSgVGU0Uo8Lwd65c_bQ1j6NssfWWz50CpBp82TvVM_jL18GdTTKbdJTuomE7VIRippOkSFO
 wK5XGxVTbyaK5dnqAr.NjuHA9b_HyqmXDp3fM3RBVmLnRxn7YcND7QvTINmXld5Mpwc9B8phIyMT
 DWm4h42G2jac.1YpbTQgPmu4CRtQ4OhWFLkn9CU0sgo.xaxMeAw_nZnuoN92c_bYA3f1wCKoNdA5
 8nZ.dHVcC9oyWA6h5mJvf.ifHVjb3Xv6wyjM5W70noubEkQKtp.rWCFvjVB6O2leJHoEAviKH6K1
 g.cL9zcRfMdh826.4KPGGMuSGR4qmW4mszt4ggY_blZpdSTqx_Wl5UKK.yQeUi0rGBzCWjbSO73K
 aWAyfrU2SbALYBZmPdnyqjZDzAhhuHAgGFCsQx.XZXgea8wixEvwkvMi3dc_hEHQO96LdVHFcC3z
 2fPg_2X1tfdFgVx3IxwaG9AUGldk7v2.KU6BkgoBr3kCbL4sZcuJaORnFEjsKpelIifAU3.jRyBt
 ROWTqvCwoOXQ19wdkrluFKx9Uh34WBFnr7c0.u0E9V6Qlf5HtgFIons4ZfsSFp08CW_oHYqXDaVJ
 gBHiFjAb0qLHdHunJ5qvFfYOE6rdkB_5L04UIC6OSgAGJIBnuhtFEhudMOv.28RkjFbfZRppXAN9
 WX40KVkeBIA2xUOyACGq6SRKWbSz_fu1Uzi3uGEsHimdX3AypDoeN3Hq9H8kLBa3jp3IpC_YhGeq
 UFQrKiZq3quL.ypdrsLB_4SwS.U1lXz4DUrAb8tj56gmBBYWXYspzR9YHDwwnbUfXSoa0M0OFjAh
 b3amUdYH8cMKGK.puT3IbUpxKjRmhaS3_3vrnFMU4eq1Vx2VXoDPasV6noILVune2sH0pr6Dymtd
 CCbslsO9Bnxg0QzP1AljWLhYSyiqUL6itvfMcjVUYLdjFwpDkZiqGFjw9vjgo.NsCESrgzHP_ZEj
 Ndw0NgjvEfckCdEozhxHk_W5Sjat.BLQ.zADpTs2xFJgbuKXttWNy6DAu2_0RyzVnP8T.9xarmjo
 gEI08r9FCN3DaWtk2uNpVoZ9bCeD_WPPpOX1XH7PYaZSaQj9.Ghb9w7leZQnGxc5NwBC086SZewk
 RuOs_5rPVY8f0eIrWAiu34BZQnFiwZoz0MtAdURDAL6Bv4OoJSdV.JYxIm5WZ1JJkcVhO1pVdf48
 YtGqOEuyU40UHB6aCkV7RRv7L46PIVsipaIZPIudnrW0i.aw3tcN3oJ2Fc71j3aGknAUqCjwdhAX
 BJUSkj1tTGkonrEZfdmsnGcM-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:54:40 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-sqjll (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4374eb8c565a32f837f1ffd0e5de4e7d;
          Fri, 12 Aug 2022 21:54:37 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 00/14] Add support for magnetometer Yamaha YAS537
Date:   Fri, 12 Aug 2022 23:54:05 +0200
Message-Id: <cover.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1660337264.git.jahau.ref@rocketmail.com>
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
Patches 2-13 are cleanups and refactoring.
Patch 14 finally adds the YAS537 variant.

Changes in v6:
 - Rebased to torvalds/linux master (shortly before releasing v5.20-rc1)
   to include Jonathan's patch "iio: magn: yas530: Use
   DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros"
 - Patch 6: In commit message corrected "This is a preparation for adding
   the YAS537 variant."
 - Patch 6: Added period at the end of multi-line comments (3x "Used by
   YAS530, YAS532 and YAS533.")
 - Patch 7: In commit message replaced "Additionally" by "While at it".
 - Patch 9: Moved content of "product_name" and "version_names" from array
   directly into chip_info table due to C11 standard 6.6.7 considering array
   calls not as constant expression.
 - Patch 9: In commit message replaced "This commit introduces" by "Introduce".
 - Patch 9 & following: Introduced variable "ci" to substitute
   "yas5xx->chip_info".
 - Patch 9: Removed introduction of "enum chip_ids" as "yas5xx->chip". Instead,
   in the function yas5xx_probe(), used "id->driver_data" directly to
   initialize enumeration of "yas5xx_chip_info_tbl[]".
 - Patch 12: Moved values "t_ref" and "min_temp_x10" from array directly into
   chip_info table due to C11 standard 6.6.7 considering array calls not as
   constant expression. Comments were partially moved into the kernel doc of
   struct yas5xx_chip_info.
 - Patch 12: In the function yas5xx_calc_temperature(), changed data type of
   min_temp_x10 from int to s16 (as it's declared in struct yas5xx_chip_info).
 - Patch 13: In commit message corrected typo in word "function".
 - Patch 14: In commit message changed "This adds support" to "Add support".
 - Patch 14: In commit message changed wording "for YAS537 in the mainline".

Changes in v5:
 - Rebased to torvalds/linux v5.19.
 - Patch 6: Moved 3x comment "Used by YAS530, YAS532 and YAS533" into
   kernel doc.
 - Patch 6: Corrected missing renaming of 2x "yas530_get_measure",
   1x "yas530_power_on", 1x "YAS530_ACTUATE_INIT_COIL", 1x "YAS530_MEASURE".
 - Patch 7: Added "Suggested-by:" tag.
 - Split patch 9 v4 "Introduce 'chip_info' structure" into five patches 9-13.
 - Patch 9: In commit message changed wording "Device Tree".
 - Patch 9: Added commas to non-terminating arrays of "yas5xx_product_name",
   "yas5xx_version_name", and "yas5xx_chip_info".
 - Patch 9: Added "product_name" and "version_name" to "chip_info" struct.
 - Patch 9: Added "s" to array name "yas5xx_version_names".
 - Patch 9: Added indices to array "yas5xx_version_names".
 - Patch 9: For strings in arrays "yas5xx_product_name" and
   "yas5xx_version_names", applied char * instead of char [].
 - Patch 9: Initialize struct "chip_info" as const.
 - Patch 9: In function yas5xx_probe(), moved declaration of "id_check"
   to a new line.
 - Patch 9: In function yas5xx_probe(), after "if (id_check !=
   yas5xx->chip_info->devid)" applied dev_err_probe().
 - Patch 10: In function yas5xx_volatile_reg(), renamed integer "j" into
   "reg_qty".
 - Patch 12: Improved comments on arrays "t_ref_counts" and
   "min_temp_celsius_x10".
 - Patch 12: Changed arrays "t_ref_counts" and "min_temp_celsius_x10"
   to static.
 - Patch 12: Corrected wrong spelling of "celcius" with "c" in array
   "min_temp_celsius_x10"
 - Patch 13: In function yas5xx_probe(), added the conditional
   "if (yas5xx->chip_info->measure_offsets)" as a preparatory step for YAS537.
 - Patch 14: In function yas537_power_on(), replaced comment "Write registers
   according to Android driver" by "Writing ADCCAL and TRM registers".
 - Patch 14: In function yas537_power_on(), write register ADCCAL as a
   bulk write.
 - Patch 14: In function yas537_power_on(), in formula for "intrvl" replaced
   value "1000" by MILLI. Added "linux/units.h" to includes.

Changes in v4:
 - Rebased to torvalds/linux v5.19-rc4, as this now includes Linus' patch
   "Fix memchr_inv() misuse" on driver yamaha-yas530.
 - Removed redundant Cc tags.
 - Patch 2: Replaced "<= ... + 7" by "< ... + 8" and adapted commit message.
 - Patch 3: Added default for switch statement, I forgot to add this.
 - Patch 4: In function yas5xx_get_measure(), changed wording "milli degrees"
   to "millidegrees".
 - Patch 6: Changed the renaming of function from "yas530_532_" to "yas530_".
   Same for registers. Added additional comments where appropriate.
 - Patch 6: Removed "Reviewed-by:" tag of Andy.
 - Split patch 7 v3 into two patches -> patch 7 v4 and patch 8 v4.
 - Patch 8: Applied "if (a && b)" suggestion at memchr_inv() by Andy in
   function yas532_get_calibration_data().
 - Patch 8: Removed defines for device IDs YAS537 and YAS539 and accordingly
   the comment "These variant IDs are known from code dumps".
 - Patch 9: New patch to introduce the "chip_info" approach.
 - Patch 10: In function yas537_get_calibration_data(), removed "the exact
   meaning is unknown" from comment "Writing SRST register".
 - Patch 10: Also applied "if (a && b)" suggestion at memchr_inv() by Andy
   in function yas537_get_calibration_data(). Additionally changed the second
   condition from "== 0" to "!".
 - Patch 10: In function yas537_get_calibration_data(), removed empty lines
   within switch statement. In that context, removed comment "Get data into
   these four blocks val1 to val4".
 - Patch 10: In Kconfig, simplified wording.
 - Patch 10: In function yas537_get_calibration_data() "case YAS537_VERSION_0",
   reduced indent of "for" loop by splitting it into multiple loops. I didn't
   use integer j, as it was suggested by Jonathan, because only using integer i
   is more consistant with the loop in "case YAS537_VERSION_1".
 - Accordingly, split the "for" loop in "case YAS537_VERSION_1" into two loops
   as well. Technically this isn't neccessary but it improves readability.
 - Patch 10: Added new defines of masks for YAS537 and applied these by
   FIELD_PREP and FIELD_GET in function yas537_get_calibration_data()
   within "case YAS537_VERSION_1".
 - Patch 10: In function yas537_power_on(), added spaced at "YAS537_ADCCAL + 1".

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

v5: https://lore.kernel.org/linux-iio/cover.1659909060.git.jahau@rocketmail.com/T/#t
v4: https://lore.kernel.org/linux-iio/cover.1656883851.git.jahau@rocketmail.com/T/#t
v3: https://lore.kernel.org/linux-iio/cover.1655509425.git.jahau@rocketmail.com/T/#t
v2: https://lore.kernel.org/linux-iio/cover.1655081082.git.jahau@rocketmail.com/T/#t
v1: https://lore.kernel.org/linux-iio/cover.1654727058.git.jahau@rocketmail.com/T/#t

Jakob Hauser (14):
  iio: magnetometer: yas530: Change data type of hard_offsets to signed
  iio: magnetometer: yas530: Change range of data in volatile register
  iio: magnetometer: yas530: Correct scaling of magnetic axes
  iio: magnetometer: yas530: Correct temperature handling
  iio: magnetometer: yas530: Change data type of calibration
    coefficients
  iio: magnetometer: yas530: Rename functions and registers
  iio: magnetometer: yas530: Move printk %*ph parameters out from stack
  iio: magnetometer: yas530: Apply documentation and style fixes
  iio: magnetometer: yas530: Introduce "chip_info" structure
  iio: magnetometer: yas530: Add volatile registers to "chip_info"
  iio: magnetometer: yas530: Add IIO scaling to "chip_info"
  iio: magnetometer: yas530: Add temperature calculation to "chip_info"
  iio: magnetometer: yas530: Add function pointers to "chip_info"
  iio: magnetometer: yas530: Add YAS537 variant

 drivers/iio/magnetometer/Kconfig         |   4 +-
 drivers/iio/magnetometer/yamaha-yas530.c | 830 +++++++++++++++++++----
 2 files changed, 703 insertions(+), 131 deletions(-)

-- 
2.35.1

