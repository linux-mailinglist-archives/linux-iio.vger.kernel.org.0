Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4CD6294E9
	for <lists+linux-iio@lfdr.de>; Tue, 15 Nov 2022 10:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKOJzZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 04:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKOJzX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 04:55:23 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DD365F9
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 01:55:21 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s8so6462142lfc.8
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 01:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f4zxcZ/5nPMHcfGpObgAYnAA7vWPHzrHK0NitDUTLM=;
        b=OeubwhbxdIfz0aEAv9BRbLsIfviL7qSKBjc1sG8maAgoYTDIE7ICssPLrxtswLYJUB
         ujRxKu0QnkecST1Z4OR6oV6S70fNkY2EgOlqJV46E6FnOtKjV8IoXvOD+CpZy0zODqjv
         4JmzFJWCphcuwg5/qBlfRxGF3B1pGSsJ2nS4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6f4zxcZ/5nPMHcfGpObgAYnAA7vWPHzrHK0NitDUTLM=;
        b=xyU9ycojudACeJxlzgZPmfxNJf0KrsJfjlP6KXE6cxr3eMoHwqz2foFGbFZwbGmY/r
         Fey+7fHxWt8/J8Sjz5T6+WezezzwUz9j9OSy5JiqRxX5UaOH63PaOUk1i/mx386Yv6Zb
         JzRpGQybWqYfObmWHtkTncViCBVAOFQkWQ/3GvTtxL7/fuVfOglNi/sgoAMUaO0qrIsO
         GD7KG9HCu+3teSCP44hxCKu4r4TV/7IQmaQjOh9ZwNmuWO3TwoVwQbgXSZKKP3CJdNz4
         RfoU/uLdkGReU7oNaKDiVnBITV1CzK1VAi62Ianuv7Sw0DI8g9dYEBecc1CEcHjBLjll
         MCbQ==
X-Gm-Message-State: ANoB5plKPOyd5xVk65p7bKCtf6Fv24SK94CMiuf0DGCRFfedPB82hABG
        h90nIWs93Ti9Ng5I4VMPOn7gdg==
X-Google-Smtp-Source: AA0mqf4B1dGT4gH+hEp8hRtblF49bEkY0uTVTCvQ1FPRbPOe8PvqPHIW1e35lJ181gViqsxSnV45Gw==
X-Received: by 2002:a19:645e:0:b0:4a9:e27a:1cfa with SMTP id b30-20020a19645e000000b004a9e27a1cfamr5177422lfj.147.1668506120064;
        Tue, 15 Nov 2022 01:55:20 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q3-20020a19f203000000b00493014c3d7csm2148598lfh.309.2022.11.15.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:55:19 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/3] iio: addac: ad74413r: add spi device id table, support reset gpio
Date:   Tue, 15 Nov 2022 10:55:14 +0100
Message-Id: <20221115095517.1008632-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix a run-time warning from the SPI core by providing a spi_device_id
table, and add binding and driver support for a reset gpio.

v2:
- drop the two patches related to refin-supply
- fall back to getting device data from the spi_device_id entry
- update the example in the binding with a reset-gpios entry
- fix a style nit

Rasmus Villemoes (3):
  iio: addac: ad74413r: add spi_device_id table
  dt-bindings: iio: ad74413r: add optional reset-gpios
  iio: addac: ad74413r: add support for reset-gpio

 .../bindings/iio/addac/adi,ad74413r.yaml      |  4 +++
 drivers/iio/addac/ad74413r.c                  | 29 +++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
2.37.2

