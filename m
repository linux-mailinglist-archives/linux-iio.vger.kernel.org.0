Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F273D372B
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 10:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhGWISE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 04:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGWISD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 04:18:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF5C061575;
        Fri, 23 Jul 2021 01:58:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z8-20020a1c4c080000b029022d4c6cfc37so3046655wmf.5;
        Fri, 23 Jul 2021 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+tvkneWqFNuFXwgztNmpZ6245wB98P+2fGEEotpNgU=;
        b=d4XsK4a+xAUkAerLoLRvNXkDfShJWUm9GtCgWAFOkj09do9Rz/vEvpyjuXoIifzSWr
         o0QBI0GwPHzSwqCuIuDFZJ3qig+IDGkVmVA53AxsUD/oWbIEJ8GbbNTjf5UBqGvJYULK
         EMzjlTe/OLmIqZFmy0a72jbsHnm4sjJaraklsGWF8QXA9kZpGDw8QCSQ6Yvhiwe4YeGc
         VzosmH8ii1g8laryeCGa3sToah0eS6wRMw6f8Hu+zhHHBTj8Roe35JfcZ/CiUxd2mPdK
         PRzUYZx5jTaz5l39/UF63575vZvfcM3frpF7BW6p8dA9tUFW0q6u6j5eJZ1u+JDWi8cm
         8lXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+tvkneWqFNuFXwgztNmpZ6245wB98P+2fGEEotpNgU=;
        b=BbPFeO0+p1C3pqPf1m/aeGzICkJ0moy/nxrHXLw+LzDrCq0kslyLBi4S2+DnMtxKNw
         H5z/8iYyz2uUqlpHApS8jEVhA0Ae2ufyHDokeY+AvToK2Xz8Cf7yxkFxv60rKQMHZJ0C
         PRdRLs0+9TSSlCCtkx5mP6yHp5AqIQWKvtCZOTh4BMR1AQ23nYA7pMqLLpPkaOZFCRXb
         gw+LOmzJb9MeiObKgbocLan9WAuSq3tzHFTbuLaGXqJsuBxO6k5PkLEg3GDo2SwylwTR
         o9pkLwKsOUQodMLQ804mgmmiqywwkQwE5KDdpG/K358/cpf2h79EkWn+loIJ8kMdPRpe
         tGPw==
X-Gm-Message-State: AOAM5323CcEliC85ax1mVAPJ6uT328EGaxQoq75Yd6iVbFY/s1vXMpXc
        ue4r6hscE+JFm3k9PJc10VY=
X-Google-Smtp-Source: ABdhPJxFepvS3q7t8SZqKe1Ll7vZlYBcTcDgGT35/+ZojJnhtq0mohzryyIgEcdYB5NpXvcKs7jqcA==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr3536549wmj.144.1627030714307;
        Fri, 23 Jul 2021 01:58:34 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id l23sm17503607wme.22.2021.07.23.01.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:58:34 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH V2 0/5] iio/adc: ingenic: add support for the JZ4760(B) Socs to the ingenic sadc driver
Date:   Fri, 23 Jul 2021 10:58:08 +0200
Message-Id: <20210723085813.1523934-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
References: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a set of patches to add support to the JZ4760(B) socs found in numerous gaming handhelds and some
mp3 players.

Christophe Branchereau (5):
  iio/adc: ingenic: rename has_aux2 to has_aux_md
  dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
  iio/adc: ingenic: add JZ4760 support to the sadc driver
  iio/adc: ingenic: add JZ4760B support to the sadc driver
  dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc
    Documentation

