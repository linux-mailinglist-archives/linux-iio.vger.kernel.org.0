Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDCF58BE27
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiHGXD3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiHGXD1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:03:27 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA522AE7
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913404; bh=vRQhYZY4GnZeBblQP9hRKY+5MzyQSb0GARQBELLKxks=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=M/e6LXUmecZqfVM79ODH9/yPhLVNo0rBHDZYDmG37KnLMkGvcLBt3pHMa7vVGX1x8U6DBogMSOcFWIy7d+wsrf5RllEq2e+jl+0CGNqyM18v2Iy6iDrILeQuDl/PkfOi/viNBFNvX3gxAmrKgfbYAMA9lRE0RpLZH1h0uXYgR2ZynyS8qcw7MZPobkbqXTno+hBbuDsnpbOt/LoEHwx76cZJozdNdPxoJUjs6SXYMW/ugVi9nySBZUhx9SgMFMaVyupjxQ3Lq8tqhlVMUc0mXUrdRSpJ4YXD9IKNfRi6vzsQm5euR8xgJlSIVPytnwNpMGpJBX20Ol3tt0pqwNEQlA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913404; bh=IqXpvOqfvrb7ToBpKYa2ZPlvbJB7uOwlAT+Io0o55K0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OIIq5Wz2+fRO2kV9x/oWxKxGfUUXZZryBZPU15lCa8PECEUWi3i1qAAWahYTKnBr6lBSfBSs0mCTsc4oZCIiz62VXTLBBrGoWal1ZcHJNpUj2yd7t7rYxNJLb2kZ+4nk/K6trR3CIGriW/hWCMxwYTDqiMmfOj2R85YPiqVs3z9tIejiSuoeFE+45NrZO7BmVdAy7JqNaPxZVxhVhzlYwTBF0ooN2fYWYctTa089TtCjKrVAOI4zaWWm/OleN1DzUnqQoM9H6RNEv/VrKCb0Mp6wJGKmUGoze6/VePTc7Qc0g6sVEn6b0wiG6xi5c2f7Vcfznx4Ne1OQ+/zXNquBDg==
X-YMail-OSG: 9DIYGLcVM1liONHU0dd9TnppKEcfRPLDyDqu3VP69CJOL2iLQHByjZMSUf_pUxC
 tUWQnRd25DQzXfIAXCwnrR3_h__BUIoMD1Hf0szHTKJWMVYKBIFwelZE9taxRXIfzmEeo9KyXTeS
 3J.Pq.iaYrajF1jbFN3Jtre11K.CwhCKKQgYa7mPU5ezys3PB4oIa9ObH3VxDV1KTncNxm3j7vzE
 xDtiVgWUV.3_MwtD2Bc00nhRKWUEM5l2lEjIZP5Bj2c77fMgXC_X_u3PN32CvNzrTPdCGtwXbZ4F
 mySV3k3JU1vfuBM_XfsrykyVbfzb3WClR2DaTcIDjC_PkLW0cWA40HAEuSwQY5zSnM8Y8xJojSjc
 t2PzNM0hvmbQauMNanJzSBru1fM2LjASX5.WaNmgi41jNOq5zAJ7xVXgdE_Z6A1dTqvot9OlvNlX
 Zc.dP.B3o33IFjL2_mmpshMF94f3P6sr2WoZCuUe9KTniDOXpvLcIbSwIM6kwgkQdcIzH7795Q4n
 22AnXhpJmBNzQoCzB4lxdmfUC38bLIBSUTeBSGz40pcdkoB4rqxKX7UTESYQOgTbWONmmmJB473a
 U2GHpgT93rg09Iy9FSwMBuTwSzjtRKUG.2fn8BGIuk44u20s.XVpp_JEFdDL9bl_ZdlhvF.oF3.i
 ElM_HgSDWl.g3mEAvD_zgpP4lq7Kk3mO0YyOCn.l_n0feRKvfXQs3aDX8Zg8CMA9x7Gs.BOrkJuf
 Dk1G5IRmzpdiYojX8RYnaCJVvESYRWnekE8xtYzhh9nGRl8_jUoQv2EdQ.bOfGKG.mKaV3l37kD6
 d8vDPo0nbp_5xs9_YXB9zNh1FSGONFPUqcwAX5.s9NUzpU2urnTU9kIKR97.QJL.7kWzjsg7aieC
 4sZZ_kyWlegm5jSJtznBer84RX6hfpzJjf_QwsJRUlz6_1cV7TqHtu_r8l6Q7o0tJndOBM2ojwB1
 xyk7Z1BTArxVpHw0REARmKmcU3IqbaAW3WEl02wmsO2XAN68rzxxS12zMwPfulkUtF2J3m9lSEQr
 8prPWz9XnroXO1ddcWi4cZYZCbriA1r_EqL.ykyrtJin_UmJ_rfBVTC4hOnHGfnQTaaMUEtHcQbS
 Tv3GNx8xmeKnik5oWIRadANlDaTcDZFhY41sqAQXVdJpWWZenKkGsyblWboJphMBT5BJHGQzro5n
 ostFKu0p7DswAhMDYx8HOlJxvbMOAiQvOOet4dajM2gl3vjxSxTSymjLGKxGzf5.pETKhEpyMcel
 yVVg87YVbUpJz3eGIqx21a4O9rgWmvzHb7q9xVxwUiex1cJmhYY4oCb2isYvx1_yo2z2e6ZUS8gh
 IZm.KtuUu3XR2ToeK1xlcC.RZH7pXyIbf5Q9gNmoXBy4_ldfbajX1nm8k7vYPhtzFvCcfUKtoHAK
 _IvokoBFFT1xkn74wh935KDWE2v5fhHgnzhN9bgikACnhRu.Bd1QAA7TdYrlsREg8w7aWLNttX9r
 wirdO9_2OJyRac9veAPyB2o7Jvov_mUHGYR0D_NYELJzD04xEZbCYVwzptKreIthYEhb3CBcB6ln
 qgKlhHz9Rau2LWC_EfjtqI57PFZiHYZ5NNzc9dDaGsnu3gjokbs7pE4IdSxXre5g4tqW7Ajm5GJU
 LiE14ZJ6hi.ILC_LEVS7enNSe7_8jbnLSDxrVRKuW5SGnM.8KtcTkPcDyKvFsfjDwTc0cN.BZPbv
 glkbRLkiQ6yl_usCM34.MC8lXO6FY0N96A39vCjuDwYZXLvis5mYjAd.vUgfknTRakhtFe8PzcxZ
 21ZX0ZC9kgDyyYqSQ.WNDV_OZZofdwTVw4Xxks77Qkl5DdEKxtApw58nj9sEyjX4xEHwCZwOa9Mc
 EZKMWmO.V2QM2aLqhSMfLob_wRe7cWkGSVlBdnR9WSUmlGlqov9A0WnrDPBtAylldO6O07R.5wB7
 lfQW6u78RBCJJzvTLfyykxrEMKoHkQdXT9Hnx1iC2tPrajZ3.ph.DDAP1s3pM9h3iD3She9QzePi
 LQLxmBYH3O87Rnqcc6TcnwXYxv8fg2QBSgSRzsYBLuOBLHyJHXGNQ4PXaCoUs4tcO..jlAsjpflz
 ApAe7kEOo03gOpjGEMb0gdGB3ta4r0tn_CpsTo2F.b1ClqmU3_cGmuCMflLGW6Nv.iJI5HpZueFT
 N2ehzgmV.toQGKAS1Z.pVZgXW5MKn2kQbvbbAoRs524MxEXD.ObLdEVKo29bVlvYVOOYsa1vL5A8
 J7xLn_YEIbDfjrzG5mUb_S6wRMI.bd3rltiwYe5dITuJ6ery0TPht8MNFWIN1c_YIcPgnVsLaCPm
 rUEaBlyLcurz5shSA_HwKGqvdpYbUuZhd1YxtHe8shcTuJge_HmWIh50FjzZyzagHhM6ikswTizI
 x2YOfzVTW9yO.CzBamfvnLnY-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:03:24 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-r76pr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12b0bfa600682cb6edf92800aaf76d46;
          Sun, 07 Aug 2022 23:03:23 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 00/14] Add support for magnetometer Yamaha YAS537
Date:   Mon,  8 Aug 2022 01:02:05 +0200
Message-Id: <cover.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1659909060.git.jahau.ref@rocketmail.com>
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
 drivers/iio/magnetometer/yamaha-yas530.c | 854 +++++++++++++++++++----
 2 files changed, 727 insertions(+), 131 deletions(-)

-- 
2.35.1

