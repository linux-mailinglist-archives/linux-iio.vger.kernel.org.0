Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170E827E5F4
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 12:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgI3KCV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 06:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgI3KCQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 06:02:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE25C0613D2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 03:02:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r24so1057775ljm.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dEnvUN6y4l8bN572xWFcvNos83VKKHZF/MtmBy4QG+U=;
        b=XFH7F1yIVgeuDY9PL0FhlRcEmq+tLf2SYNRbk0xfFoe3UnMzG7vZcO1eBPb1wdnEO5
         EG0vtU3lLHve8Or6iuVssXWZ+AtLChp5jwYuiAD4uMr7N2bXaP2k4/4etM4qNWyissC2
         hUcEn/iOFxwgDuTuofrxpUn5bkkRPKPI24kkQY4dk8gr/RrwhST/uY4zqxeFMY1SFXAQ
         82n0+kNMhnWd2dbChWmE1rNQmyGW6t8C3GFzVgAt6VdJVjD9MY7IRu+NTSdgFWCAIbni
         DckvSMDpch0AlmerCnvTKbU1WSVrSiGl2Djq10K1auZ7gxsIoyB8teqI8YUmK4pfK72s
         bmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dEnvUN6y4l8bN572xWFcvNos83VKKHZF/MtmBy4QG+U=;
        b=Ka6FFMaeV1f9NNVvGa9YVHwzknnqSx/k9LNoXSyoZ7bqnniLxsJYZX9jgTvqA5uKrJ
         Y4+Q+B/bW6E6k15lFyKyzfM2fFQ6VTMwYlhxHxuSkBJGyypNFeNTEE8FqzpZ1nhc0RXm
         qez2mtFcZR+MdNXvjxcwIsOXibO6rW6o279Jg5BO3mXBIZANkKtOJBymZW/xIkP8+fcg
         xJIKO89HSA+DdzAKO1KA0kkneyz8lZetWM3xrare2VzBHm3THNtBfKiJJ7VEG3iCWoCq
         gzuSuvU9kkg2eLQsdanWnngBLrdCmEDSXjM/naoAmkytqVRUFmK71SyVUKI42I0xxVa3
         GYhQ==
X-Gm-Message-State: AOAM532Qf5Fbofrwzu6sVgzwzxLnbNO5InKpQCHnziuF0OAdS4I6tHPV
        PTvq+rGjHa+9xb3ELkgbwEXtsA==
X-Google-Smtp-Source: ABdhPJz5ntskvCOv+Iz5WOt47n4yiDYsnjzaTIWG5QJrq58KINZSFISwQnSUDMYL539taRJez+WOuQ==
X-Received: by 2002:a05:651c:1205:: with SMTP id i5mr633295lja.47.1601460133963;
        Wed, 30 Sep 2020 03:02:13 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id w4sm132479lff.231.2020.09.30.03.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 03:02:13 -0700 (PDT)
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
Subject: [PATCH v6 00/10] qcom: pm8150: add support for thermal monitoring
Date:   Wed, 30 Sep 2020 13:01:53 +0300
Message-Id: <20200930100203.1988374-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch serie adds support for thermal monitoring block on Qualcomm's
PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
to support thermal zones provided by this thermal monitoring block.
Unlike the rest of PMIC thermal senses, these thermal zones describe
particular thermistors, which differ between from board to board.

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



