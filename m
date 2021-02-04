Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895B33100AB
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 00:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBDX3G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 18:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhBDX3E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 18:29:04 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700CDC061786
        for <linux-iio@vger.kernel.org>; Thu,  4 Feb 2021 15:28:23 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v24so7177266lfr.7
        for <linux-iio@vger.kernel.org>; Thu, 04 Feb 2021 15:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wrnz6l1Kc/IHahayxg6JcFhU1NyXvIp7/tC0nvwYbY8=;
        b=IIHALYqnetpnKRgTpAh13O6zD5lMJsFclZYluHf7Y4H7Y0rG2lKSNOXOoLoKbqv0RR
         omZIi0iYUeTfesxYInX6G1GBDLSAvyrT708zTyQA8qIxb3P5hApb2IAySU//iKmzNXDV
         KuCOZvlHyqjaiT9AhuJphQ6B2vOMUbV9m6whhE7JjLDVPeCPG8UlJXoTHfXMDYI7SISo
         7sv7Bg+Anj99JL23va5jsAmpBcOsqBXPMKfGyJZkr2htGauTVNmqMf8V2vAZHkDjegyF
         Qi6fubWamfhh1q1BkCucfAfuVYtexj7pOMnDe/eAY21fQC1l9ehIpq8bWQMT9OfKGkO4
         3qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wrnz6l1Kc/IHahayxg6JcFhU1NyXvIp7/tC0nvwYbY8=;
        b=egVi0AzZG6JoqbNylqRU+OtlvvE6Qfz0scLiwBGA9VR4GT+nASqa5zCdKvyvW2U/K0
         uL0+cMy00fP4t/3zIFydTupJHSbi7KOdfrVgOsgR3HdbWK7xPFH7XZf38NwwtXgZTdec
         ngzmHxBQaKLJ0wlYNzxBNciwD4RkcfZvjCGIPM6IAihZtayqYelnWsGuPDjmkZVbHHQv
         tvGO2vmW+XdnshkbWE1ieIBSXG1mv4gGQp+5Tzui3xFt4EGKmL0TTwdBJCXmqWzi5Ovr
         cCdmzSCM6ezb4qqUraNO1NyvL4ndicAYk2V2qUureWD/ErhEsU1QFl2M/LgPm+ugC/Aa
         +tXg==
X-Gm-Message-State: AOAM5332ggPOLLUKGy4C211XLkm/K2JGJwPb9VpDSu7xNZyOw+GIOiGe
        YcZvLpdVHDo/PTGWyJLuzlo23g==
X-Google-Smtp-Source: ABdhPJyPcrSjtwNtcsr/OAnEPKURpvfJ87fi1O5MdTpqiONZtt1PtXszDX9oR73Kmg35m9rXYi0e9Q==
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr966579lfg.140.1612481301784;
        Thu, 04 Feb 2021 15:28:21 -0800 (PST)
Received: from eriador.lan ([188.162.64.67])
        by smtp.gmail.com with ESMTPSA id x20sm769906lfe.256.2021.02.04.15.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 15:28:21 -0800 (PST)
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
Subject: [PATCH v13 0/2]
Date:   Fri,  5 Feb 2021 02:28:07 +0300
Message-Id: <20210204232809.474733-1-dmitry.baryshkov@linaro.org>
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



