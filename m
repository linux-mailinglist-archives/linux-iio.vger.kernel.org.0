Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BA620822
	for <lists+linux-iio@lfdr.de>; Tue,  8 Nov 2022 05:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiKHEPT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 23:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiKHEOo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 23:14:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6831EDD
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 20:14:43 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so12277355pjd.4
        for <linux-iio@vger.kernel.org>; Mon, 07 Nov 2022 20:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeXjuqYbv+Cb2PzWLDv8ZdQcHNUBRbHrV9FuI04HiFk=;
        b=xrvPoM2tveDNMWjBFoOnZxZ9+swsBuT1Qj7K9yL1aecAL25mUzlcdaRunjKd9PsgvH
         PK6UGjKuUkb6ZbHelumE+CriPl9dIVBYX+BMpHEzIHQDA21UdTN5nAflmQaMn2zBvlwK
         4AOsYgqHTyVa1MOu3exEkIbqI82w89Ays+JQUXFZfXSzUk5I1SNfjFg0qFfe6WAobrJ9
         WUHyVaOZ4WJv1UU/RwqO4W3NSYT8R3PcwrO7eUiRySJKzfd0nTozZ4CkmwuzcK3ovt7K
         75TR3SWzehXXNtHYAAK7rkEVkyiL+ALXWBMSjZbalJOeXvB7rN8jkHKyHSl2YTxPrsGN
         c6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeXjuqYbv+Cb2PzWLDv8ZdQcHNUBRbHrV9FuI04HiFk=;
        b=NVAU7N2J4hCdZ8ucQUT7rWnD+q8TujUT8xB1KvrWOFMuLCZglxbm33m9vWzBEoE4YX
         WrOJ8dgmtEkezG3GrUL+g8y26FaiEVmYP4gBi6v1j2bG2K8spfxRxvvE5t5fMpYFv0UF
         1hLW8eafE5UgL+27SquP/O8msUGrH+50tEmKQe0rJrz9cKWLuOc5SU882O1USphjr+aG
         E/wepvx6s9b/iLfGjMirsqDn90aOMr6D5pokrP2B5gmkijYB7YYMQ2UM9ApqU5LPLFyJ
         smQ0lctONoGrS3qBGpqkIw09HplLMLUhaNWtrnGw4T4y/zk/Qhuldgwcqco9ux/loTBu
         Lfmg==
X-Gm-Message-State: ACrzQf3jROnQ+D3JniURApmujOL+vtJU6ZX0mRsOCzNXmy6gQ7CIW+W1
        n/f851Y1LaS+Kni3s9jO4W0x4A==
X-Google-Smtp-Source: AMsMyM49Cy0rzn7lDtrz7hhhWGHfpSa9jMSze1nNUDTy+W0egtDAsPT0pLjV0pdA5Le49S279Alv2Q==
X-Received: by 2002:a17:90a:3c8a:b0:213:8043:4b7f with SMTP id g10-20020a17090a3c8a00b0021380434b7fmr63212085pjc.99.1667880883405;
        Mon, 07 Nov 2022 20:14:43 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a809:63d1:2564:ea55:4e97])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902b78500b00186ac812ab0sm5799783pls.83.2022.11.07.20.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:14:43 -0800 (PST)
From:   Jagan Teki <jagan@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Jagan Teki <jagan@edgeble.ai>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v7 03/10] dt-bindings: iio: adc: rockchip-saradc: Add saradc for rv1126
Date:   Tue,  8 Nov 2022 09:43:53 +0530
Message-Id: <20221108041400.157052-4-jagan@edgeble.ai>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108041400.157052-1-jagan@edgeble.ai>
References: <20221108041400.157052-1-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add saradc compatible string for rockchip rv1126.

Cc: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v7:
- new patch

 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index e512a14e41b4..da50b529c157 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -22,6 +22,7 @@ properties:
               - rockchip,rk3328-saradc
               - rockchip,rk3568-saradc
               - rockchip,rv1108-saradc
+              - rockchip,rv1126-saradc
           - const: rockchip,rk3399-saradc
 
   reg:
-- 
2.25.1

