Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBD2FA3FE
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jan 2021 16:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405093AbhARPDB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jan 2021 10:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405219AbhAROwp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jan 2021 09:52:45 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99FC061574
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 06:52:05 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id b10so18475888ljp.6
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 06:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0TSPYDv5XLvkcKJyd9FXdxRdT8c1olJkUJTenoQBLk=;
        b=xeZI2nV1WpcEHH5v6RF37EzP2mXduc8p8BDdSRw5WBx4KviNLBnXcyIvsox8z5HCSt
         7R4U+S22A2AxW4ZAuJRAbUS+eguhCE0MzJduDJzttcN2bhYuRQXOcgNszu8qOoe6eOEq
         qwZYsRx603Qb7VVcP5m0O3P7hGgcuYqf00dyG/8tJXLc9QLe5SaQCuzHrcC8qcsW8F9V
         C2sfpmkxidscoRZ1aiLkeXuAcuhRaMZzPMMLipKgfMi1V1XWqpVJp+OkSS3bLmNnR7DV
         5N0vVXQ4FjMOTqiwAQe6mghFhcPnovdhnGziZ0d4g8eiT3Kbk05hYBN7slLfa/t3B9Xr
         0oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0TSPYDv5XLvkcKJyd9FXdxRdT8c1olJkUJTenoQBLk=;
        b=G4Gnmj3LK6IdbcJSWwnRDbZWaD7neOj66KHbaaEgRJd0fBh6X4IC68D1flu0QliCEF
         o0/8sgLh3J28B4Z5+Y6dKUmgnI4+Zajbdm1GkNcYzKcdUaeogjrVP1QbLSZs6iRQGCI3
         cvBXe5FUQYAP3mz5fRha3xa+XxkRvmS6fF/3J23L8yOauW7MMAK9YU45o+eGsnLppnL8
         OtTBAiDPubS0wQUxzF+tSgeQcSJwhskJYoZJqm/H7rKfYM1OasFgKgGZ9b9If6n8pOBa
         9J68tKjW5J2hGjFDbzKY0b2xJ/u8I9DzKW3V9jWkSutY0PRwP05X742HcwkldYMsuaui
         nT5Q==
X-Gm-Message-State: AOAM533UYtCD4J1xwLmMAXbQa5JJ4SG0qYV36nsDaWR/iaahhjMBGmk3
        jJhy6mWRR+OL4WIK7jkSxwRJrg==
X-Google-Smtp-Source: ABdhPJzcwO8vaqhmX3W3xU+kf8j8vlWDGyOQ8kp3TzsGCGSaYsR+e/YUw5WNVla7Iq7DlTqOXl9VwA==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr19058ljg.291.1610981523647;
        Mon, 18 Jan 2021 06:52:03 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.64.4])
        by smtp.gmail.com with ESMTPSA id h13sm1969697lfj.110.2021.01.18.06.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:52:03 -0800 (PST)
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
Subject: [PATCH v11 0/5] qcom: pm8150: add support for thermal monitoring
Date:   Mon, 18 Jan 2021 17:51:55 +0300
Message-Id: <20210118145200.504951-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
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


