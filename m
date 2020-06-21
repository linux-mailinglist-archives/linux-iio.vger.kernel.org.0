Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E92202C5C
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 21:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgFUTfz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 15:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbgFUTfy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 15:35:54 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7536C061795
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:35:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a9so16917622ljn.6
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptnYrELo7OBVoFrm8dUMAxEike2DTsFTeyQJ5HcATrg=;
        b=BaYc0xA8zu63T+A22o/taXsXmLXsDmXtKhSk7PrRd42eelTQOQCH00SX/1MYmE/7xd
         cQDlrg4SH97xhNmealfOFwg+YGS33VrHETaEiXtZvisUHWvh2J52RfW5Ya/HlGcfW9e8
         QPvjrKtOhubGBIEQUnD8eUL92TAHkUDysvt3KanuJtl391ih/d48xiaMoPKKa0JyawdO
         EHaEBuwHgU26VmT0j8QUNLnDewYudeaM0469hSZrFovgRlIAN1Ux7MU+8X48q7JboLc/
         xRKLiJi8XwKt+9GPNPxlF2LnvjDGkSNBRN9cKro5j0uS6r4RqaGz4pGoz2GZnWLlfy8E
         dx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptnYrELo7OBVoFrm8dUMAxEike2DTsFTeyQJ5HcATrg=;
        b=QBB7e/dd2Rkpq5PT3NlCnQnJKt+j9HpqlfPZpUDqGOUS+j/Uuut6VJacc6BMGWHMvT
         IUdlRTDD2OGgn22mqiOUIHb/91PfWmF8Z+tx+wWpfxeX8vJRo4b/3IhMnalIwAijm9xp
         +/BVIZeI4lkGsx+EjytNYYJqIFsSCCsLPh/xJaRbvty9MOtlsI03WFeogW0HWSx5IXz9
         ZdwOo2h6VjOz+nJT4FN9ibVGe23VfJZtONjV3svhj8GCz0zUUcr8m6vYQCi0KJR1Mn3X
         gmhWcXGSkvvbR86YK6hyXk9VhH75vlOqSytq6dPjnjbaA0ieRRTKZBN+pY/ikIEl75Td
         3GQw==
X-Gm-Message-State: AOAM532MatYA2jNwLeUg4Qq/JKcrGqVaNJibtMRxNBkLc0UgGxIMb1kF
        4fLGFhosN4sKsNUueNs/rh3LKQ==
X-Google-Smtp-Source: ABdhPJwbcUlAKweA4cGWnTXd4COHwCP98joQlkLHF9Trfe1E9WM/neSzgb9beSdjUuA8RqruGSETDA==
X-Received: by 2002:a2e:7c03:: with SMTP id x3mr6553796ljc.227.1592768153174;
        Sun, 21 Jun 2020 12:35:53 -0700 (PDT)
Received: from eriador.lan ([188.162.65.109])
        by smtp.gmail.com with ESMTPSA id r13sm2917854lfp.80.2020.06.21.12.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 12:35:52 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH 0/5] qcom: pm8150: add support for thermal monitoring
Date:   Sun, 21 Jun 2020 22:35:44 +0300
Message-Id: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch serie adds support for thermal monitoring block on Qualcomm's
PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
to support thermal zones provided by this thermal monitoring block.

-- 
With best wishes
Dmitry


