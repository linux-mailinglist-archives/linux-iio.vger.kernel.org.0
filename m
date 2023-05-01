Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04286F3AEB
	for <lists+linux-iio@lfdr.de>; Tue,  2 May 2023 01:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjEAXR5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 1 May 2023 19:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjEAXR5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2023 19:17:57 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081030F2
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 16:17:56 -0700 (PDT)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5211040E42;
        Tue,  2 May 2023 01:17:54 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH RESEND v3 0/5] iio: adc: qcom-spmi-vadc: Propagate fw node label to userspace
Date:   Tue,  2 May 2023 01:17:32 +0200
Message-Id: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Implement read_label in qcom-spmi-vadc to see DT-specified label names
in userspace.  At the same time clear up some documentation around
extend_name to promote read_label, and normalize similar code in
qcom-spmi-adc5.

v3 resend: added missing to/cc addresses via b4 prep --auto-to-cc.

Changes since v2:
- Dropped RFC tag;
- Reworded @extend_name deprecation comment.

v2: https://lore.kernel.org/r/20230116220909.196926-1-marijn.suijten@somainline.org

Changes since v1:
- qcom-spmi-vadc: Use read_label instead of extend_name.

New since v1:
- core: Point users of extend_name field to read_label callback
- qcom-spmi-adc5: Use datasheet_name string literal for
  iio_chan_spec::datasheet_name;
- qcom-spmi-adc5: Fall back to datasheet_name instead of
  fwnode_get_name() for iio_chan_spec::extend_name (gets rid of @xx in
  sysfs filenames and labels);
- qcom-spmi-adc5: Remove unnecessary datasheet_name NULL check.

v1: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/
---
Marijn Suijten (5):
      iio: core: Point users of extend_name field to read_label callback
      iio: adc: qcom-spmi-adc5: Use driver datasheet_name instead of DT label
      iio: adc: qcom-spmi-adc5: Fall back to datasheet_name instead of fwnode name
      iio: adc: qcom-spmi-adc5: Remove unnecessary datasheet_name NULL check
      iio: adc: qcom-spmi-vadc: Propagate fw node label to userspace

 drivers/iio/adc/qcom-spmi-adc5.c | 15 +++++++--------
 drivers/iio/adc/qcom-spmi-vadc.c | 19 ++++++++++++++++++-
 include/linux/iio/iio.h          |  3 +++
 3 files changed, 28 insertions(+), 9 deletions(-)
---
base-commit: 92e815cf07ed24ee1c51b122f24ffcf2964b4b13
change-id: 20230502-iio-adc-propagate-fw-node-label-b1fff2e63ae8
