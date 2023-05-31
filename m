Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D90718393
	for <lists+linux-iio@lfdr.de>; Wed, 31 May 2023 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbjEaNv1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 May 2023 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbjEaNt5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 May 2023 09:49:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868D92D42
        for <linux-iio@vger.kernel.org>; Wed, 31 May 2023 06:45:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f61530506aso61182215e9.1
        for <linux-iio@vger.kernel.org>; Wed, 31 May 2023 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685540647; x=1688132647;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7kySM637Tx/Dc82ge+V+wiyLzxskqVkDb7/090RLQQ=;
        b=kdThhklChayqX8Z/J3wtvMZ1Dgd8R4ZFxkexUfEg5dF+OGU6s2itYLsEJWSJiGWWff
         luGz8cIhSSxsybt8LE0JYlHda5FFW/MzVHgkWMueUr7cVIBSXc2FhTrbFS1Ik9QHPHsO
         2jcmEN042vwnKamwrKI2E7YDPSPf9Kq2/B/2xx6+aEISpJt4WRFkvnpJYKE1mVzVbRTO
         0KRqXEiSHp2wAe06qHv+rn6rklzV3EUoJlibgFvtfcJvEgbM2nMp0ePOErniSGAtftSi
         x61DVjJkLwBAECQK7g3qnGX+GV9rwFWXyR7hdRN5t1thJ3n44iXXqf4SUyTWzyaIhZVK
         8lCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685540647; x=1688132647;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7kySM637Tx/Dc82ge+V+wiyLzxskqVkDb7/090RLQQ=;
        b=S9Roj11doIIH9W6WDyCcuUgAJxqeM0VwZN/4YVEMfCCdgJC7xmNOJqmUWho8vYIxXO
         cxPpHtVXo0GmMUte4fUKY1TagCE+Vsk/rO/GSDS/KajPKQhYJq/KeT3uQg4zy2vidRjr
         GSh1paMfn/w/Zu1Dp0GOKI+PIXIxRXHVk4qCHbS6szHxMPbtJ5BLrIcGwZRWr+CoHjN7
         axQ1M6WaFDh3KbxAtqR4i8vA+3EXCISOLTraRFpTQgPez/NcMEQmfXAHss2kmtn6OKdN
         l2Ge1ZkdCK8J3+htpVdDC9dyCy4Vy9WVr74fwZOjkgB2Z/aIxExmSEVepvuLCzXpJtBw
         py6Q==
X-Gm-Message-State: AC+VfDxy36QwvXSBKULNSRMFGQ1s5/rvQin/+hw/mPJ/ni89XkpmyBBr
        WmJluuRWe9rcspeeh7wN7LZnug==
X-Google-Smtp-Source: ACHHUZ6GIntwDxwZs6YWJQ61R0rnMeRB/b1y3TfyI2dJJpkxjZ3IHCpt9CSUEaN6U8av4iYz2vAScA==
X-Received: by 2002:a7b:ca41:0:b0:3f6:3b9:eaeb with SMTP id m1-20020a7bca41000000b003f603b9eaebmr3935664wml.6.1685540647040;
        Wed, 31 May 2023 06:44:07 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c378b00b003f195d540d9sm24562983wmr.14.2023.05.31.06.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:44:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <20230530201235.22330-1-linux@fw-web.de>
References: <20230530201235.22330-1-linux@fw-web.de>
Subject: Re: (subset) [PATCH v3 0/4] Add mt7986 thermal
Message-Id: <168554064594.102887.3990598740109479693.b4-ty@linaro.org>
Date:   Wed, 31 May 2023 14:44:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Tue, 30 May 2023 22:12:31 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This series add thermal related devicetree-nodes and necessary
> dt-bindings.
> 
> I left pwm-fan for r3 for now as i cannot test this completely due to
> missing 2 pin-jack and 3v3 pwm-level which my fan cannot handle (starts
> spinning at ~3V). Only checked voltage of pwm there.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: nvmem: mediatek: efuse: add support for mt7986
      commit: 05f53e3c22a71ed53e0e88432c3db31f2d27e6e1

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

