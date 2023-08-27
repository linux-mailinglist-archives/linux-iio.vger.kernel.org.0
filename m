Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6B3789A00
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjH0BAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjH0A72 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 20:59:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE221AC
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ff09632194so3344179e87.2
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097963; x=1693702763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zw4LFk55BF1kI5ENct+TNGHr1/V1+AsRmygM9sjIhOk=;
        b=eltsvxH3Tq9WUCg+QlEKzeIJR/KSRwR5BjifQkto3wk6WTHNkJYjJ/VccJnaJODE56
         GTsiOSA1PAfyzlkPgq/agaZ/fDSrsGC2YJjU6LKnrfuceopSoOyJcb47G5SUjQDWzDBt
         2zP8C/slBCeyH0EELF7hnWDeMnzGWLYnzOvfs/AVSK9kX5ARnIgLyRwssj34IUeTo3gE
         5IetIOOidZPD2NGVM2zXOGT8RDMpQ0KCOkBAouoZqQN0sBNg2exeE6OsRc8AF9YsMLqr
         Uk0UTLUb98q30cCvI2CY7l/20XvHM1/LeV+LSL1Y8M2H7Sat9a/hcwU1UGZQBFZOTv2S
         HcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097963; x=1693702763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zw4LFk55BF1kI5ENct+TNGHr1/V1+AsRmygM9sjIhOk=;
        b=kUsBoTP1J/d2AWDbK562QkJAZridTyjMcz12P2I43qXmJ65FC8DkM06/QcRriUCd5M
         uLRleBTfOrzKG+CzYd3e+Q5wX25m2uhrtxrLU8ur3uFj50EZREbrqbV6qrs4BKiVFL1A
         6XbCWYVkg+MGev6zzgR+0mvK9c1W5pFH5fYj3tGCtbvvjPzwoW6kDJMU+BQsShha72dV
         ChiTmBXCGNeMWt9PpCP3vIJM6ZANLSnlAxLYI9gJTX5wZxtEVaCr7d0Y6X4MhBvg1HEG
         5/oD2IkYzk9HsfKJePraLrqGhiIEc/tDwWOmAajhiZikQXI0sm4HDmoquioLs54yMhOZ
         Hv4Q==
X-Gm-Message-State: AOJu0YwWsgvnBu2bmOXDOP06PNnZfGluXpkPtjAp3D2DUYNdNwsPK7vd
        E2RQxNBqxj7UNzAdCqnI9g1teQ==
X-Google-Smtp-Source: AGHT+IEE0KaenXKJIXB7VGrdFumKIGuaUSbFNFD0o8LWpKZnZZcvzRdIXX1ohQYD4OhfmW9zO6ylKw==
X-Received: by 2002:a05:6512:3e19:b0:4fe:181f:2736 with SMTP id i25-20020a0565123e1900b004fe181f2736mr21369199lfv.33.1693097962573;
        Sat, 26 Aug 2023 17:59:22 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:21 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
Subject: [PATCH v4 00/38] ARM: dts: qcom: cleanup PMIC usage
Date:   Sun, 27 Aug 2023 03:58:42 +0300
Message-Id: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

While reviewing APQ8064 CPUFreq patchset, Konrad pointed out that PMICs
are not a part of SoC and as such do not belong to the per-SoC files.

Cleanup the way 32-bit Qualcomm platforms treat PMICs:

- Move SSBI PMICs to separate files (as a bonus merging two different
  instances of PM8921, benefitting both platforms).

- Include such PMIC files only from the board files, keeping SoC file
  generic.

- Move RPM regulator definitions to board files too. They do not belong
  to the SoC dtsi files for the same reason.

- Move PMIC-specific GPIOs and supply properties to individual board
  files.

Note, enabling DT schema triggers warnings for pmic:led@48 in
qcom-apq8060-dragonboard.dts. This node uses custom ('cm3605') trigger
to make the LED follow the state of the proximity / ALS device.
Previously [1] Rob pointed out that this is not the best way and the
device should be switched to `trigger-sources' instead. However as I do
not have this device, I'm not brave enough to introduce these changes.

Note2: DT binding changes are largely independent from the DTS changes,
they can be applied separately.

[1] https://lore.kernel.org/linux-arm-msm/20221205220709.GA2713165-robh@kernel.org

Changes since v3:
- Moved PMIC interrupts to board DT files, they are not a property of
  the board, not the SoC.
- Dropped qcom, prefix from ssbi node names in ipq8064 and mdm9615 DT
  files.

Changes since v2:
- Rebased on top of linux-next to fix conflict
- Picked up dt-bindings patches from old, not-fully merged series.
- qcom,pm8921-keypad: droped the no-autorepeat property (Rob, Dmitry)
- Moved qcom,ssbi to /bus/ (Krzysztof)

Changes since v1:
- To ease reviewing break cleanups from the  "split PMIC" patches
  (Konrad).

Dmitry Baryshkov (38):
  dt-bindings: input: qcom,pm8921-keypad: convert to YAML format
  dt-bindings: mfd: qcom-pm8xxx: add missing child nodes
  dt-bindings: mfd: qcom-pm8xxx: allow using interrupts-extended
  ARM: dts: qcom: apq8064: correct XOADC register address
  ARM: dts: qcom: msm8960: introduce label for PMIC keypad
  ARM: dts: qcom: msm8660-surf: use keypad label directly
  ARM: dts: qcom: apq8064-nexus7: move sdcc1 node to proper place
  ARM: dts: qcom: mdm9615-wp8548-mangoh-green: group include clauses
  ARM: dts: qcom: strip prefix from PMIC files
  ARM: dts: qcom: apq8064: fix PMIC node labels
  ARM: dts: qcom: mdm9615: fix PMIC node labels
  ARM: dts: qcom: msm8660: fix PMIC node labels
  ARM: dts: qcom: msm8960: fix PMIC node labels
  ARM: dts: qcom: apq8064: move PMIC interrupts to the board files
  ARM: dts: qcom: mdm9615: move PMIC interrupts to the board files
  ARM: dts: qcom: msm8660: move PMIC interrupts to the board files
  ARM: dts: qcom: msm8960: move PMIC interrupts to the board files
  ARM: dts: qcom: msm8960: split PMIC to separate dtsi files
  ARM: dts: qcom: apq8064: split PMICs to separate dtsi files
  ARM: dts: qcom: mdm9615: split PMIC to separate dtsi files
  ARM: dts: qcom: msm8660: split PMIC to separate dtsi files
  ARM: dts: qcom: pm8058: reorder nodes
  ARM: dts: qcom: pm8921: reorder nodes
  ARM: dts: qcom: pm8018: move reg property
  ARM: dts: qcom: pm8921: move reg property
  ARM: dts: qcom: pm8058: use defined IRQ flags
  ARM: dts: qcom: pm8921: switch to interrupts-extended
  ARM: dts: qcom: pm8018: switch to interrupts-extended
  ARM: dts: qcom: pm8058: switch to interrupts-extended
  ARM: dts: qcom: apq8064: move RPM regulators to board files
  ARM: dts: qcom: mdm9615: move RPM regulators to board files
  ARM: dts: qcom: msm8660: move RPM regulators to board files
  ARM: dts: qcom: msm8960: drop useless rpm regulators node
  ARM: dts: qcom: msm8974: move regulators to board files
  ARM: dts: qcom: pm8921: Disable keypad by default
  ARM: dts: qcom: apq8060-dragonboard: rename mpp ADC channels to
    adc-channel
  ARM: dts: qcom: ipq8064: drop qcom, prefix from SSBI node name
  ARM: dts: qcom: mdm9615: drop qcom, prefix from SSBI node name

 .../bindings/input/qcom,pm8921-keypad.yaml    |  89 +++++++
 .../bindings/input/qcom,pm8xxx-keypad.txt     |  90 --------
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  36 ++-
 arch/arm/boot/dts/qcom/pm8018.dtsi            |  55 +++++
 arch/arm/boot/dts/qcom/pm8058.dtsi            | 159 +++++++++++++
 .../qcom/{qcom-pm8226.dtsi => pm8226.dtsi}    |   0
 arch/arm/boot/dts/qcom/pm8821.dtsi            |  22 ++
 .../qcom/{qcom-pm8841.dtsi => pm8841.dtsi}    |   0
 arch/arm/boot/dts/qcom/pm8921.dtsi            | 137 +++++++++++
 .../qcom/{qcom-pm8941.dtsi => pm8941.dtsi}    |   0
 .../qcom/{qcom-pma8084.dtsi => pma8084.dtsi}  |   0
 .../dts/qcom/{qcom-pmx55.dtsi => pmx55.dtsi}  |   0
 .../dts/qcom/{qcom-pmx65.dtsi => pmx65.dtsi}  |   0
 .../dts/qcom/qcom-apq8026-asus-sparrow.dts    |   2 +-
 .../dts/qcom/qcom-apq8026-huawei-sturgeon.dts |   2 +-
 .../boot/dts/qcom/qcom-apq8026-lg-lenok.dts   |   2 +-
 .../qcom-apq8026-samsung-matisse-wifi.dts     |   2 +-
 .../dts/qcom/qcom-apq8060-dragonboard.dts     | 164 ++++++++-----
 .../dts/qcom/qcom-apq8064-asus-nexus7-flo.dts |  70 +++---
 .../boot/dts/qcom/qcom-apq8064-cm-qs600.dts   |  35 ++-
 .../boot/dts/qcom/qcom-apq8064-ifc6410.dts    |  42 ++--
 .../qcom-apq8064-sony-xperia-lagan-yuga.dts   | 111 +++++----
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      | 201 +---------------
 .../dts/qcom/qcom-apq8074-dragonboard.dts     |  31 ++-
 .../boot/dts/qcom/qcom-apq8084-ifc6540.dts    |   2 +-
 arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts   |   2 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi      |   2 +-
 .../qcom/qcom-mdm9615-wp8548-mangoh-green.dts |   4 +-
 .../boot/dts/qcom/qcom-mdm9615-wp8548.dtsi    | 143 +++++++++++-
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi      | 183 +--------------
 arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts  |  61 +++--
 arch/arm/boot/dts/qcom/qcom-msm8660.dtsi      | 217 +-----------------
 arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts   |  27 ++-
 .../qcom/qcom-msm8960-samsung-expressatt.dts  |   7 +-
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi      |  45 +---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  31 ++-
 .../qcom/qcom-msm8974-sony-xperia-rhine.dtsi  |  31 ++-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi      |  27 ---
 .../qcom/qcom-msm8974pro-fairphone-fp2.dts    |  31 ++-
 .../qcom/qcom-msm8974pro-oneplus-bacon.dts    |  31 ++-
 .../dts/qcom/qcom-msm8974pro-samsung-klte.dts |  12 +-
 ...-msm8974pro-sony-xperia-shinano-castor.dts |  31 ++-
 arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts     |   2 +-
 arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts     |   2 +-
 .../dts/qcom/qcom-sdx55-telit-fn980-tlb.dts   |   2 +-
 arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts     |   2 +-
 46 files changed, 1171 insertions(+), 974 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8921-keypad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
 create mode 100644 arch/arm/boot/dts/qcom/pm8018.dtsi
 create mode 100644 arch/arm/boot/dts/qcom/pm8058.dtsi
 rename arch/arm/boot/dts/qcom/{qcom-pm8226.dtsi => pm8226.dtsi} (100%)
 create mode 100644 arch/arm/boot/dts/qcom/pm8821.dtsi
 rename arch/arm/boot/dts/qcom/{qcom-pm8841.dtsi => pm8841.dtsi} (100%)
 create mode 100644 arch/arm/boot/dts/qcom/pm8921.dtsi
 rename arch/arm/boot/dts/qcom/{qcom-pm8941.dtsi => pm8941.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pma8084.dtsi => pma8084.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pmx55.dtsi => pmx55.dtsi} (100%)
 rename arch/arm/boot/dts/qcom/{qcom-pmx65.dtsi => pmx65.dtsi} (100%)

-- 
2.39.2

