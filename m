Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBB3D556C
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 10:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhGZHkM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 03:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhGZHkL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 03:40:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2E2C061757;
        Mon, 26 Jul 2021 01:20:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 9-20020a05600c26c9b02901e44e9caa2aso5677204wmv.4;
        Mon, 26 Jul 2021 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G1sESUOwYQF5ojlEDTCdGxRcHpdp4Ued2GOsbRa4r8E=;
        b=Vy1ELi+UlfPWWVKOn6Enti8XWXun8Jgu4aMxQ/ZoUG0fICnYniH1G+CAcwmZ2sZfPq
         Lh9/LPSXCSkfBJ8jojmO2Wr74Mp6MSGrle9fXb+JuIG75uuxgXAWrNKvESbZ1jfH83nw
         FO2OjGxUZU8ICpnusz577lNp9cCh5nyl4kMOL9TglJPRpSdyxQd/ge0SW+mmQKi6k4A1
         3pKXIWh2uZKOBTR2jIjftN0o+Wyg5lJ1bQR8OYy4B5NyXn+fRgytjCJOvwQNVmeUO7bC
         NFBX6/ldUEAZ8NZ3R51UkRg+dS3EYc4FZxPxsCrlnsyCGPiSjcu8icj/x4en5RKeZ2Z6
         nP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G1sESUOwYQF5ojlEDTCdGxRcHpdp4Ued2GOsbRa4r8E=;
        b=j8Ou/ngznwWcdaM2ofRgu3A47KFQ7klcvNyIhPkp74aHfLPNx6a90+N3bw/ZQlcGTa
         uBKsldzmgY1hyjFFupthAU+2mDNEfA+QaC4x2/nslqYyI8RObErIYPYriumkrirxhLPM
         Y/GpR4B/Lg4fZjsShaciI4Smddagvi3EkON4K3PYqVbDrVYunZWUlbfeS+xU50N3cFCr
         pcWZWw0gkOzgMIMPT+Prk9rf8sYtr8pLSugb47TOs10gmqtiDNOy7kejtdIAMQqq18cO
         wLsSOWhuqvgwJCTvvvY6swkyHibEhL7M1E1hZhX2Kq94dNJu7BqxPvrFzmaRFl8la7/0
         hK/g==
X-Gm-Message-State: AOAM531E/561oBGZCGRaeHoW0L6cmLu75IPfdggJ+Hmi5+3xUS5ouSfb
        J4v4Oehl/Xk6eiZCp4H5MRc61i9W7IgHQ9ndPLc=
X-Google-Smtp-Source: ABdhPJwmFS8dF925El9HP8gniYqsBVNoAbPZxkCZR8v9fe2u3uB/uWVQMxnigTx694dU7UKIRO1grA==
X-Received: by 2002:a05:600c:2194:: with SMTP id e20mr1539929wme.77.1627287637393;
        Mon, 26 Jul 2021 01:20:37 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id w13sm4799464wru.72.2021.07.26.01.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:20:36 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu, paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v4 0/5] iio/adc: ingenic: add support for the JZ4760(B) Socs to the ingenic sadc driver
Date:   Mon, 26 Jul 2021 10:20:28 +0200
Message-Id: <20210726082033.351533-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a set of patches to add support to the JZ4760(B) socs found in numerous gaming handhelds and some
mp3 players to the ingenic-sadc driver.

Changelog for this v4:

Fix patch 4/5 that was missing the .compatible string for the jz4760b.

Christophe Branchereau (5):
  iio/adc: ingenic: rename has_aux2 to has_aux_md
  dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
  iio/adc: ingenic: add JZ4760 support to the sadc driver
  iio/adc: ingenic: add JZ4760B support to the sadc driver
  dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc
    Documentation

 .../bindings/iio/adc/ingenic,adc.yaml         |  19 ++++
 drivers/iio/adc/ingenic-adc.c                 | 102 ++++++++++++++++--
 include/dt-bindings/iio/adc/ingenic,adc.h     |   1 +
 3 files changed, 113 insertions(+), 9 deletions(-)

-- 
2.30.2

