Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDD057B718
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jul 2022 15:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiGTNNF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jul 2022 09:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiGTNND (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2022 09:13:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2025B786
        for <linux-iio@vger.kernel.org>; Wed, 20 Jul 2022 06:13:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so1242402wmb.5
        for <linux-iio@vger.kernel.org>; Wed, 20 Jul 2022 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LgN/S0aDXYI9VGCuWlvvgvQnGpuTnnqHsiuzMd2wxQ=;
        b=hZDBwVWDP5UPXoM/26p/r+j251hc2vAqDOCERxSqp1n7sS06JhTWTNUFrAn/iDVTDd
         sk1s9gAeT8g6iMlidLoC2ByWsp6jDzKjyGiwTrHFM+kSqmhnpOGy27aGmIOCRSPQXtjU
         iuHcWvpuEBu/GQL3HjFfyH38HWdcfRwpw/QCs8xRs37MzT7Ik+pcHBHS4PQz7Y7kmEGs
         2zEZT/L22GV5s5xGf/GZOt2FikEOhhfo8etSuo2R+s9KR06g6oLOKoKJ9cp2Devph4aN
         HYnuH9yadQ7mkeUaGKIxYyw+FFFXzGLODhmRa8DXLmg2/yBLqQ88/ndcWxmAnabBH3H2
         gPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LgN/S0aDXYI9VGCuWlvvgvQnGpuTnnqHsiuzMd2wxQ=;
        b=eM7MnK636DBtuUvJrbxslgJVwJnLAZtzt5QgeNLxFjS2Wijnz+9wYhv0frHXXQEiv/
         QuiHljRDn6CNJYViTfzPupZ/cN710D4IqrZMxNC5YTvKU+17cFetPZ2tjeM37XFA8rAm
         Lrja21XIy0UA6UN7PFZY5W4neWJTyNLuLH4VVaa/MYiruaIp+FmVA02ulLXW1+F2zxni
         QeS4OLWzUtFhOwZaopePtdbYMGAhG6//ASIXa+0p2keSlJTYzlpzAyReJcgEvJ9r/+kA
         X4SqOR2ocJpe2nvithbG2FkOR0f8LoSidQ57mbYJzTE0O1Ly4DjB4sMjNxMFYvFQCbIR
         uvYA==
X-Gm-Message-State: AJIora9VH2ZGzm9SxIKEI/L9/0PWjF3TpKXud2Bbr/b9HNNrrzwRfdh9
        /W7obsupyd/Kj0U6QduSriW1dw==
X-Google-Smtp-Source: AGRyM1tHJE+D+NzsNowU+goDfK+LE01p5AmV4nGBMM9nPZVjT15IP9nJaaafPk1bF4qVs2pE8TNv1A==
X-Received: by 2002:a05:600c:3b91:b0:3a3:1cbe:d531 with SMTP id n17-20020a05600c3b9100b003a31cbed531mr3812400wms.159.1658322779330;
        Wed, 20 Jul 2022 06:12:59 -0700 (PDT)
Received: from amjad-ThinkPad-T490.home (2a01cb040613180084408ac44a1fa242.ipv6.abo.wanadoo.fr. [2a01:cb04:613:1800:8440:8ac4:4a1f:a242])
        by smtp.googlemail.com with ESMTPSA id y11-20020adfc7cb000000b0021d6924b777sm16853316wrg.115.2022.07.20.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:12:58 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     fparent@baylibre.com
Cc:     broonie@kernel.org, chaotian.jing@mediatek.com,
        chunfeng.yun@mediatek.com, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux@roeck-us.net,
        matthias.bgg@gmail.com, qii.wang@mediatek.com, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, ulf.hansson@linaro.org,
        vkoul@kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH 16/17] arm64: dts: mediatek: add mt8365 device-tree
Date:   Wed, 20 Jul 2022 15:12:57 +0200
Message-Id: <20220720131257.530168-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220531135026.238475-17-fparent@baylibre.com>
References: <20220531135026.238475-17-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Fabien,

> +		tzts4: tzts4-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&thermal 4>;
> +			trips {};
> +			cooling-maps {};
> +		};

AFAIK mt8365 has only 3 thermal sensors, therefore tzts4 should not be
added.

Regards,
Amjad
