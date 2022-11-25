Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EF36388CC
	for <lists+linux-iio@lfdr.de>; Fri, 25 Nov 2022 12:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiKYLcV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Nov 2022 06:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiKYLcQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Nov 2022 06:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E2B178A0
        for <linux-iio@vger.kernel.org>; Fri, 25 Nov 2022 03:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669375883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o0whn50hBaBPJSQq4RKgv9QraGn/cvKe5x1wVFmyAmE=;
        b=cGSw1Q+q5Cq5KodPshTs1VC3rwY1xl0uqKrv/I5gVCX163kmAuSVdE3b+zJPBQdUgd13/5
        gMHSii6TDwvSv3gQhCfNcV7qK5CblaIvR68SGYsmH8C3GetUv7qZiFmS2PWdlsStZsi1jo
        Nsk1n1DxOQE6dY1IYWCsz9985anxVCs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-k5qhGn1IPiu-SB6rb_fInA-1; Fri, 25 Nov 2022 06:31:22 -0500
X-MC-Unique: k5qhGn1IPiu-SB6rb_fInA-1
Received: by mail-qv1-f69.google.com with SMTP id on28-20020a056214449c00b004bbf12d7976so3462023qvb.18
        for <linux-iio@vger.kernel.org>; Fri, 25 Nov 2022 03:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0whn50hBaBPJSQq4RKgv9QraGn/cvKe5x1wVFmyAmE=;
        b=rJe7aKOr7Q4GjxeTnJqNzbFo+TZ9LFFY9z7hNaM85ThziUZOlp2S9zQLPonJBiWy/T
         F/ysCAEyLebLD34Nr5Cdk9QiFDiIJpofyaRbFI5cxW+C1oeN/4J9/CLm5lqj8BqxS2H/
         jrhWxzvRHuUaksw4n3ZQUBba391rnLaDMb+PjcoJP9Zz0zv8bhfLtPdX2dD1GY53Msrv
         TxhFL1NDrFP9i47Ar2UToExduc2jUVfT+MgKxGs7Kmxt5eRAThLgYxzeIfLb3UwaPmGh
         MaAwqlqM+lrilKxoSIFaWLWta2qTOtjnkdD/Ai/E3k3UPSivb0YkFBD0puB2MqIBcpFT
         d67g==
X-Gm-Message-State: ANoB5pnsJ4TAiUl/4nZcFJ3EeX6OB7Hufy/4m8yIvsg82PUh3ukvkqDG
        OS0tlHAfKT4hYhAdRF9btvOspOZv0SyBJYQk531e2N4Onpr2yiJDkyheFYoqaMGjyu8GMwTwYZa
        9tce/OjPbzBGI/4O3y5o=
X-Received: by 2002:ac8:734d:0:b0:3a5:2784:f462 with SMTP id q13-20020ac8734d000000b003a52784f462mr18738809qtp.590.1669375880844;
        Fri, 25 Nov 2022 03:31:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5MrrxAhGW+JX7yXKj/nNSxGBgtw9E8v2y+gdjXK61hr+gPJZuL1eilM+sjR/92x2KZrbXqiw==
X-Received: by 2002:ac8:734d:0:b0:3a5:2784:f462 with SMTP id q13-20020ac8734d000000b003a52784f462mr18738776qtp.590.1669375880599;
        Fri, 25 Nov 2022 03:31:20 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-28-144.cust.vodafonedsl.it. [2.34.28.144])
        by smtp.gmail.com with ESMTPSA id q1-20020a05620a0d8100b006fc2f74ad12sm2581080qkl.92.2022.11.25.03.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:31:20 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] iio: adc: xilinx-ams: fix devm_krealloc() return value check
Date:   Fri, 25 Nov 2022 12:31:12 +0100
Message-Id: <20221125113112.219290-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The clang-analyzer reported a warning: "Value stored to 'ret'
is never read".

Fix the return value check if devm_krealloc() fails to resize
ams_channels.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/iio/adc/xilinx-ams.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 5b4bdf3a26bb..a507d2e17079 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1329,7 +1329,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 
 	dev_channels = devm_krealloc(dev, ams_channels, dev_size, GFP_KERNEL);
 	if (!dev_channels)
-		ret = -ENOMEM;
+		return -ENOMEM;
 
 	indio_dev->channels = dev_channels;
 	indio_dev->num_channels = num_channels;
-- 
2.38.1

