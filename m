Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA853E87F
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jun 2022 19:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbiFFOPh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jun 2022 10:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239461AbiFFOP3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jun 2022 10:15:29 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4F82CE0A
        for <linux-iio@vger.kernel.org>; Mon,  6 Jun 2022 07:15:27 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id l1so10298823qvh.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Jun 2022 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HFPPt/n+GC7L3I3lYwZwtJYqMlp4sB7MAQn4ER7tLHE=;
        b=bVlDY6ViZmyAGO0CMS1dX7jnHLAN3Sjy0yQropvvm2Lr1B3viNAgrF0zZAEHZgkoSo
         EaaH4Y2EEipZNwnn640gwn71RrUbD614LSM+y1PZDe1Zkcki0fhSR/xKHsq0Z3+0fCzX
         WYnrxoNDXwCoYtl6E85JwIrgXh5fh4fk0+TblSwMVRst1DKOz5WIhzu/4ZEgyDroh/kY
         xcRF5hQX6F84RSfKLY4lxsSRJxi/XXw+kxAbFYIxgbj0lIIfzFATBquKuMrKx+NdnJLj
         jHsdNTXc6h+kjWScy6zNy3mf//Si+wZxFzFN9xubZEcyXBV1HrzL3iD2OVR23CWW8qf8
         0+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HFPPt/n+GC7L3I3lYwZwtJYqMlp4sB7MAQn4ER7tLHE=;
        b=tzDYXnl7jo3kt3KPFQRVyOUis67Sgq920q2haFGjDH3G0ImtZy8llFWZIXosaOnJuz
         DJ/6XbrurvHZij8Cp2GhJOI69o4lR842SZqsG7dzzlb6PgKT2U9+IhCaZXpkCS+g4w8R
         EKRl+1KCqAkzuoYmGfvq1LJwhSYjOYvUrB3/8t1yzaZlg+0K0s7ZcktRSFOEGiEn8niA
         Acdjmuk5y8uIcOpxojrvaKk5fykrMAdns700AV6jdKvWZwecVLmmNexaWGlcgIXVOGe2
         hJr7kHXNjbXNZHNsbSKwcXTgXJhdEb1sQZsHiqYFDnkLyfeh+8rF8dYs3zNd50ilrhOI
         Xs7A==
X-Gm-Message-State: AOAM530MGVD9UCPtH6niPpQhMzdL4rGB8F2fibhb6MXAHhmCq7KpXT2R
        OpQ4eIixikoJxToemtb0cxCPvg==
X-Google-Smtp-Source: ABdhPJzvOYgaZe9iJDCKBu3RdSOxluQVF2VwpiTpr2nF8YwL/LxLzUTel3SnX3fufJcqp+nCcRWFmg==
X-Received: by 2002:a05:6214:21eb:b0:464:5c48:4bc8 with SMTP id p11-20020a05621421eb00b004645c484bc8mr17346514qvj.23.1654524926468;
        Mon, 06 Jun 2022 07:15:26 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id c15-20020a05620a268f00b006a3af1bd183sm10335086qkp.127.2022.06.06.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:15:25 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/2] iio: Implement and utilize register structures for
Date:   Mon,  6 Jun 2022 10:15:16 -0400
Message-Id: <cover.1654118389.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The STX104 and CIO-DAC drivers were updated to use I/O memory accessor
calls such as ioread8()/iowrite8() in previous patch series [1]. This
patch series is a continuation of the effort to improve the code
readability and reduce magic numbers by implementing and utilizing named
register data structures.

[1] https://lore.kernel.org/all/cover.1652201921.git.william.gray@linaro.org/

William Breathitt Gray (2):
  iio: adc: stx104: Implement and utilize register structures
  iio: dac: cio-dac: Implement and utilize register structures

 drivers/iio/adc/stx104.c  | 70 ++++++++++++++++++++++++++-------------
 drivers/iio/dac/cio-dac.c | 24 +++++++++-----
 2 files changed, 63 insertions(+), 31 deletions(-)


base-commit: 7fa61f7dba74f6c5baf9f02b760924692acdd282
-- 
2.36.1

