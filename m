Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016A2564A26
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 00:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiGCWDG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 18:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGCWDF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 18:03:05 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6E12BFE
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656885781; bh=XxodE1QncYH9cCTIAy6S9/ywmnpRBFai+jG1xD3UfWE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=qBnajfLjIxazHp/uNoFOWrYbPPcxK4DyS+fPMM1Qgjus3HydqzYT1D6tCXwVBai5OWvYblvfUVDquYoaN10EWo10XtRVQ94jyLkK8uX67PIK6D9LqDQMJANzQdgkfACJfWqvSagHAkxXk12WzXSwwpyuh/Qtxrs8qM78QJFwVMBJUHXI9W50mKhqsEWWxITpUPtGsVRrTt3lZNRDC4Edd2oz2w5iE3wJVHu9mKOy5ndXMDyxnt9rgVz3JhKTLnww6g5fUETn4WVVa6w+THT+guOgB3Bop0cVjeUrQFB4eZuSKaHoJFLmpzWUSO5O3RJDmqhTFGVaW+aT4f44NKZs3A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656885781; bh=/+Td3AnEpNCkfS8SCarHb5wGpNv3Ae9WBNRSG50Vckz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AfyJIZ6NkJePrjbh7G9iYp/pca6GGQNxbaRwvsi6GBHWKehg+45MnviGCYBg6bzIdltxB7M3qZyKx7I3VVmQ8MF5srSTvKN0itNYvaejvvphP980DCOIn1YEgrg0t6zrcE84KJR33DtmmHjm2N/uej2Hy+XyxqSIOL9E3vnP45UEFHMGGo1BV3OyqkGDquv8AK3KC1j0RiFJOrDg80Je8DzVN7eKc6b9N6p/NUAqxfisA1f/wkIprRvYmTfFet9j21NiM7W81LjBMzfEF5LZ+r/RmA2EW6t0Xwj9jsdDBvaVHqlQF2lpO96o3wdlgGSRRG3sij/0mSaHx657OqYPtg==
X-YMail-OSG: YD4O6mwVM1kgOHkAfRFXlE.MaoinuTx.30570ncoT97xfO8uFy70_WTt1ixhMxG
 8mYHr30G6fTXgnauhuS.T9jV.SeDaS5rg2prL7eNzqhL5Iqt9lE4gMk1xwm6tyGfoY2xNjJ2zw6j
 UxahST9SkAQzo2fUzMWdHCk4ieTEZOP6w2Gc05ar_54KRv_RFkgU7LqWKbqWZLcf0HYiRcMzt9Zy
 zWyEe_B68xMhYaQQQZk8aCiMCzCWfjIZ.YEVpicrLauX0OyljXJKAxcF7SXEKgs6TfK7ktxZsviG
 M9HA4FeX7Nx99KZfhJ4XAWwZf4T_kPasDgrltIfEzuaZ7Nccee05BtqTD8s9qVqJ.qmMU0ijSyC2
 uy4HBg3FhxrafYBVEuNTun.97.t8dbFpqn84eVJPMCyejp5BbD2F_ROLrTVcLvGhzgOy6WU.ZFS2
 SjG7kfY.hK4zBVhW8KrWW_3GS5RkLDTOE0v_Qx4KGXkqSaMcL703o1OATElPNmBnePfZkfptZnTm
 8L9BGqM1iBQ66xC_u0HNA2cXw3.nLIbv5Sa8CaRC2UZQcd5asofXwonI3onqY7nnUSrGEikpoOk.
 OWgfFXE3iCLx5lsPYb5Pt5VYxv252yjm50UW4dCofmJq64DxBZLlGPP6i5g4Vilh6kLfYBZHqUMX
 hb.X6z510J9ZnFd06o9OzwgkQbKF1lMlYxxvO.828w1bMGOMcWML0gpPX3i3fvHtQyFp4tWIItXO
 oFla9pqIJzd96boZE5Z3hJjoYP40o2_7j.T_alhrQ2kPRuTxt0puHpM9W3wIBUHfOaWxNMNJ364g
 ziwniXCOqWY4HcmJ01UkBEkhSMjGYWOY5ag1Wlf9zYF6JxGkVTVNMIWYmNNLmcWf9IyujK.yEwOs
 aoFPHfAH_2G79uCAwj_xl92nYF4xyI8qgGgvmjFdvcho.Wef0G.2xvFkmrMlfOBza0zf4D7KsjvY
 blQCG6QpAUQWuNmBKEvRm0dluO41bDwxw42WA27MdCyMzUb6UHpsPAR02veEslMVd_GS3aBaHvcP
 jNqR.SPUdnQt6WFhwjYtyfezY1S2VnCHk1J.FJH7LKZZoxUkxz3aE0bnearmf4tDv42MHw352YX3
 XSVhXV_ozoJz_t648fY0iz5UuhCIPyj3nJJDSUGMXFTVKv2Fw8ZXBZm8LEx6hIagBIjRvSY0o.aP
 MO0yzs7xhMWOYnD8H8RxrBS8arpRtSkXY918tfhUvgFYXJmrUnMXCtIrpyXxJ5J6uR_fYD2kTsFT
 wUMzd6h8d5HLNoZgezsQ8eqcXwueXQkCxhxeme5Mt4dZRo9TEXBaZDmptzNUazMTvqIbgrF20wEU
 0AMtecMtrfL9tcEjU7z6X8bTsN1Izp0RPqhR025VDfdcE0bNROXkX3NmzY9fIg9u9MYuukmKoFX9
 fGfBCtz6m87A_nu0JctCgPChOp56LdNRjix7ebE8KLYq6gpXzlxOTSHNS5rDokqA786LEbauTub3
 McZlnY3Y4OQV9kZwAeWLRaR8Xu7Hr1FAGaf4BPRF22Vwlg9Y7kVoDiIORnEgeUKEB9PaFmIgyZPb
 GAhiIG6gRPkjjnEl9kS9J4g5tvq.bH_yKYqhXCAuo3TSGyko3j0F7mTj5cdtewEMM.elxNgwU2pu
 oBSu2IKqFGH16ufAtr2eCwcFp9cVsSzUBdlHU_a8rVegBmUNG8ZkQFokgTBK5t8rrMbxyUKH2Z.G
 f7t_XIEH4s4CraJEsPB5w0b6LuJiWsVoiqwMqrOFcKOQL_HYAMGRtBb9nH81n_AM_xmQMdX2xruN
 Ju6eyJHrWPfwj2ar5afzkpOxW2UJSfWkDAusuxzir_zuGENol.V3qLSh4QfGZut5rWZHkGmiWkqX
 Z7eoOPWBxKb1en4S4ig81yTThVcWaj8qznjcR5fp7djxnt_HJ49qEeSM39X_y5tbbyaMIofa8bjO
 ZX421Cyd5pJqn2vYvz00LTMblPZRkp7mO6R9XVNCyBxPm1SUEZKP5YP.GizGJZ4QcSFK.mZXgoOt
 DAlAFc0HUldvmBJCpDx_3fD0yfL1atrZ23T7dcL9iMX5xg5vMUGj1SFYOnObgpHTU9YPboikExgB
 nlQ7AqeGO4qOfInXOSHkRlTdPgtPXs520hfsjiE1bykfafTEn8o0XSb7sy0uzmwpL92a9atmOTHE
 r8PXFR5ar_W5u6Dh94lRfKONItKug1TlQAe07pC0vTpDYCoTOA_o_k6BINJPU80yh5HqvrxweQRI
 cU1Q5bgGkmv9A2OWP7zAdubE_E0FhLO_jEM.WrOq7xHwu1PoZ6OX6cqGwoMDZ79_7qAVldHlnUR8
 49t_xqUo3hic9_pXPvuE-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Jul 2022 22:03:01 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-tv8mb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0849bd8970b52a790a5a1bb96f2e336c;
          Sun, 03 Jul 2022 22:02:59 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v4 00/10] Add support for magnetometer Yamaha YAS537
Date:   Mon,  4 Jul 2022 00:02:34 +0200
Message-Id: <cover.1656883851.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1656883851.git.jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds YAS537 variant to the already existing driver for
Yamaha YAS magnetometers.

Patch 1 is a fix on the current driver.
Patches 2-9 are cleanups and refactoring.
Patch 10 finally adds the YAS537 variant.

Patch 9 adds the "chip_info" approach. As this change is quite extensive, it
might need some more discussion and refinement. Also the patchset as such.
However, applying that patch late in the patchset allows a good traceability
how the other changes were introduced.

By adding patch 9 (chip_info), some of the review comments on the last patchset
became obsolete:
 - Patch 8 v3: Comment "Can't return here, because you leave the PM counters
   imbalanced."
 - Patch 8 v3: Comment on strncpy() vs. strscpy(),
 - Patch 8 v3: "fall through" comment at function yas5xx_volatile_reg().
 - Patch 8 v3: Empty line between "break" and "default" within switch statement
   of function yas5xx_probe().

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

Jakob Hauser (10):
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
  iio: magnetometer: yas530: Add YAS537 variant

 drivers/iio/magnetometer/Kconfig         |   4 +-
 drivers/iio/magnetometer/yamaha-yas530.c | 808 +++++++++++++++++++----
 2 files changed, 680 insertions(+), 132 deletions(-)

-- 
2.35.1

