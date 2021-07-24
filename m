Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA3C3D495A
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 21:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhGXSY7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXSY5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jul 2021 14:24:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4764CC061575;
        Sat, 24 Jul 2021 12:05:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b9so5142041wrx.12;
        Sat, 24 Jul 2021 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZG6iH7qljFvjZVp2NAbqIPjXBeZ+g+2A5OSjvjmCHwc=;
        b=aoTNUZ4LTzfzAjF8AUZXFttrasZdwRnEzoARVvTmUDQ+G8MgmQfz/xLxewIhFi+c1n
         CGlhpMDoWUVCioMxCubfyd9izi0k7lRTYDc3ZnP5LSd3e1qN8ewVm2h3Njv6vJaYrHGl
         OM9PWswDcuuMMHPyeCFm3cLZGvNFlWnbxLs73h+qpSzm0rWeBKEOasDFtBTCAqEpGDta
         pSaCK+zDt0jKC4dSo2zAnVyyXS32+kS/PpK0VAGDC2DZ5GjGJ9hQ+TmzbDcjrK/tbuGd
         P/NbvpVxXo57k3Iwtwnx9dkk9JfpueJo2TdmZweXVApQRyxi/ocP2JfWwAJRgZZRWbYi
         60yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZG6iH7qljFvjZVp2NAbqIPjXBeZ+g+2A5OSjvjmCHwc=;
        b=rlAygzq9oJEnoFEBfaaDzOreoP/aG4UB+yTArbxW6ysp0DTBFjH/k3KE5kYylYJCSb
         H/99t4nnFpHyTpWW1i4B1D+fyHzgKO4ZKQQcW16HgyvsME1zs0LvggbYgha9XvSFV+1G
         r5x0eURQjzijzBbFJRfYM+tafZfwTXTm01JOSL46gsSqv67qHwZJPTRrQqleoF3SjCDL
         1dT0DFqCXIvYWP1k+PY1gGuzQ4HJs7TbHclcMfosmIhHwqZsNwLH56I034NclBlfWRlN
         ovEiML1QXW6rdGX2BFoD9Ty22oW9VNeJ5+240PvCjKwB9Jfk/5M0X+q04wNeTwxUvhwk
         hGxg==
X-Gm-Message-State: AOAM530eHKPFfrlT8DMTPiQLOIk4oCwjZ99lovKsOBGxV+ykFlldWMPJ
        jGY/wuHd2S2yu9YVcdJ6D6I=
X-Google-Smtp-Source: ABdhPJz7wpkQ4xsx6TfNSI5hCjli346t18Z1Lpoh38pmc+aJgHHL9ljETqk+iDVZ6pKIWcdz+dVuIQ==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr11178364wrs.301.1627153526579;
        Sat, 24 Jul 2021 12:05:26 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id j15sm1117798wms.20.2021.07.24.12.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 12:05:26 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v3 0/4] iio/adc: ingenic: add support for the JZ4760(B) Socs to the ingenic sadc driver
Date:   Sat, 24 Jul 2021 21:04:44 +0200
Message-Id: <20210724190449.221894-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a set of patches to add support to the JZ4760(B) socs found in numerous gaming handhelds and some
mp3 players to the ingenic-sadc driver.

Changelog for this v3:
- Minor formatting change in ingenic-adc.c to remain within 80 lines
- Correctly set the ingenic,use-internal-divider property in the Documentation so it cannot be used on other
socs than the jz4760b, and modify the description as requested.

Thanks to Paul and Jonathan for their help

Christophe Branchereau (5):
  iio/adc: ingenic: rename has_aux2 to has_aux_md
  dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
  iio/adc: ingenic: add JZ4760 support to the sadc driver
  iio/adc: ingenic: add JZ4760B support to the sadc driver
  dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc
    Documentation

 .../bindings/iio/adc/ingenic,adc.yaml         |  19 ++++
 drivers/iio/adc/ingenic-adc.c                 | 101 ++++++++++++++++--
 include/dt-bindings/iio/adc/ingenic,adc.h     |   1 +
 3 files changed, 112 insertions(+), 9 deletions(-)

-- 
2.30.2

