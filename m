Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F08310135
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 01:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhBEACH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 19:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhBEACE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 19:02:04 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF6C06178A
        for <linux-iio@vger.kernel.org>; Thu,  4 Feb 2021 16:01:24 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m22so7291610lfg.5
        for <linux-iio@vger.kernel.org>; Thu, 04 Feb 2021 16:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLqPTFh6CuSeccJgUeUot2gtzesuWCTA8N4g9JUgJlg=;
        b=fhw60sCMKSzS6vpKxVfqfnprR1Gtbsn0Wxse5P5rrCDoZ6UwYx7uLY25tp2uuhFX7O
         BemTos5LhfGk5sleNbZ+39yJ1FXQ/e/Rz6CgdB//tPK4ReckJ1rGdJjM8gi665JDYbmA
         LKiS7Kr7pf3dQ7q/L/wQeFCdT3CTu6nBdwghdKOslF9VgUGLviXJdkjy2QtjMeIrZTsM
         s46gZj8bvH1K61SP3c6iLBj4IjD7tzGqYqgt8En8L8VUnxa7apl5kH9IheBa6sJrxF0N
         nre6zg9VGTaAvLmm2JVwwStMDQAZKN7w3OcQMHl3BvD84AE4rY0yiyQ1e05n714z1ZBW
         iByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLqPTFh6CuSeccJgUeUot2gtzesuWCTA8N4g9JUgJlg=;
        b=f9bMP6MdsdN8s2C5jNW19bi2noLt+TPEFqpkZkp4wdqgK329g40sJKBQSWs5XDWoKJ
         Gn3CpYhYUe7SJKNRFEtcFFBYU/MgyoAKekSwl8uHC1VxbwPmTNoRQeoGdRCg7xIRR3Le
         RpgQKHq9W2TJ+cG+Usvl26WM+tJUcpfwFgP8WpI2IjtbUAQoo/WmWRKmKmUF1pNyZggx
         2QyIoYRMENW6dNo5rwoSzu/kGIbiVc9SjIfaWloIlNYKoB2KaY2Zd82dZK4OZEiZGXh5
         KYvplv2ieIltpOGL1FWEXdtWjd76Az/aGiNBKXxLTRFV1J8TCaP1U1Jpks/0MaIVyMGq
         GJ1g==
X-Gm-Message-State: AOAM531aaRHWgHwQl8/W8sxhpHUE3WnO60CXhHXHL4A4HUFrXF/bKGhI
        4s5JOvM6pVh7T0FG8jyp5VSoiw==
X-Google-Smtp-Source: ABdhPJyL2cGQ3cX3iT0ggBpT5cJGbH5cWbn0wNvpFUEBfbnV9f5wHpFlWmZm4QiOa+XIxvQp21WB/A==
X-Received: by 2002:a05:6512:2248:: with SMTP id i8mr939789lfu.632.1612483282579;
        Thu, 04 Feb 2021 16:01:22 -0800 (PST)
Received: from eriador.lan ([188.162.64.67])
        by smtp.gmail.com with ESMTPSA id x11sm799532ljh.69.2021.02.04.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 16:01:22 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: [PATCH v14 0/2] thermal: qcom: add support for adc-tm5 PMIC thermal monitor
Date:   Fri,  5 Feb 2021 03:01:16 +0300
Message-Id: <20210205000118.493610-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch serie adds support for thermal monitoring block on Qualcomm's
PMIC5 chips. PM8150{,b,l}, qrb5165-rb5 board and sm8250-mtp board device
trees are extended to support thermal zones provided by this thermal
monitoring block.  Unlike the rest of PMIC thermal senses, these thermal
zones describe particular thermistors, which differ between from board
to board.

Dependencies: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-thermal-5.11-rc1

Changes since v13:
 - Really fix adc_tm5_get_temp(). Failed to squash the fixup into the
   v13.

Changes since v12:
 - Drop patches taken into linux-next.
 - Fix adc_tm5_get_temp to handle IIO_VAL_INT properly (removed in v9).

Changes since v11:
 - Drop io-channel-ranges from dts example.

Changes since v10:
 - Rebased on top of ib-iio-thermal-5.11-rc1 immutable branch, with
   IIO-related patches picked up by Jonathan.
 - Changed thermal zone device tree nodes to use -thermal suffix
   following the schema.
 - Reordered device tree nodes to keep the alphanumeric sorting order.

Changes since v9:
 - In patch 12 add comments to the code as requested by Daniel Lezcano.
 - Change copyright comment in qcom-spmi-adc-tm5.c to clearly note
   driver history.

Changes since v8:
 - Simplified qcom_vadc_map_voltage_temp() code by removing ascending
   tables support
 - Simplified qcom-vadc-common volt/temp mapping code
 - Implement suggestions by Matthias Kaehlcke: message formatting,
   rewrite comments, remove unused variable initialization.

Changes since v7:
 - Move qcom-vadc-common.h header to include/linux/iio/adc/ dir.
 - Use explicit sizeof(var) instead of hand-coding 1 when accessing
   adc-tm registers.
 - Remove buffer read from adc_tm5_init().
 - Remove extra on-stack var from adc_tm5_get_temp().
 - Minor formatting changes as suggested Daniel.

Changes since v6:
 - Added include <linux/bitfield.h> as noted by Jishnu Prakash.

Changes since v5:
 - Reworked DT bindings:
   * Removed qcom,adc-channel, instead it is parsed from io-channels
   * Renamed qcom,hw-settle-time to include -us suffix
 - Re-added monitor enabling which got lost during refactored. Noted by
   Jishnu Prakash.
 - Use threaded IRQ handler as susggested by Jishnu.

Changes since v4:
 - Added kernel-doc comments to ADC-TM structures
 - Used several sizeof(buf) instead of hand-conding register size

Changes since v3:
 - Fix DT description to spell "thermal monitoring" instead of just TM
 - Fix warnings in DT example
 - Add EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name)
 - Fixed whitespace chanes in qcom-vadc-common.c
 - Removed error message if IIO chanel get returns -EPROBE_DEFER

Changes since v2:
 - IIO: export of_iio_channel_get_by_name() function
 - dt-bindings: move individual io-channels to each thermal monitoring
   channel rather than listing them all in device node
 - added fallback defaults to of_device_get_match_data calls in
   qcom-spmi-adc5 and qcom-spmi-adc-tm5 drivers
 - minor typo fixes

Changes since v1:
 - Introduce fixp_linear_interpolate() by Craig Tatlor
 - Lots of syntax/whitespace changes
 - Cleaned up register definitions per Jonathan's suggestion
 - Implemented most of the suggestions from Bjorn's and Jonathan's
   review



