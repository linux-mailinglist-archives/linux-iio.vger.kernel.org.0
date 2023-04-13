Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153A96E08E2
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDMI1A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 04:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDMI07 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 04:26:59 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFD4B5
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 01:26:58 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1842e8a8825so16912045fac.13
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681374417; x=1683966417;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fcoig/3rqF+Gt2Kg2v/+kJhcnHA2KTveUI1hxCDfrFQ=;
        b=cOPVKd3ual1QWBBwq4Nt7qY5YtIVbu/s1iRKt6yixPKbZsoGI2wMClKucDuJJVPgUt
         oiHI/eDnlqlv1HYdryu30LlqS2yemSW8lfnANdZFk1izlCjHjwqt6WRjCGiS875Dpfae
         MCIYD3lFug++WBW70dyTL5LKz+LcYFNFQ0wHL654K0DLYUSblycUy/T4NoxGQpbDhKNY
         4jhP5MU+BmEYfcn9f6weGHEodwaGYbadzj+c+d1W7oDyTCXG4eOjirlTDRsB3nO0X3ev
         rdBpFrNN3B5DWg+iYdEbTNAV0Lt5eXB83PQawT2Pb0rpmnM2qQ/kEK6rW4LSfG+bW+xc
         6Xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681374417; x=1683966417;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fcoig/3rqF+Gt2Kg2v/+kJhcnHA2KTveUI1hxCDfrFQ=;
        b=j2Tnq7HcyO02hC9MGbG3cwAZg3IFz2dLqon3n6l2FxSImAdpdJpGrvoE3VtIIrlVcC
         1tYTUe9e65E2gvDQlxXpKhYsfoibX7wta1Ls8RMdv2VALWyzh3ZKdoOaBPjgm3vXGCvQ
         hMNhpfkym+26aX9QKCaGTkFbbh4TLDsp3NV8nLY5ppPpezbIiK0khPwsHZodgFJ0VGfL
         ve+J9rqNjnhxbO+NuSFfDDCHAPvqMkK5PjZiv2JsK0iEb7ztu7JRVT9BaY5/oUscKM7c
         VW9gVm9TvyOuEunO2pZh5TcgfnfCIftgTHVGfaD8imoggYnuAmCPCQQS0mFR7k7ihF+Z
         kwpQ==
X-Gm-Message-State: AAQBX9fmfNLFzMU5GaA32SbCNkDt9wj1qMhC71NFr6BLNt0MqSJsovCX
        diB0J98WVhbLlpbSwrJcnijZ3PVJOmer1t0Yse13YqY93QA=
X-Google-Smtp-Source: AKy350ZLgsJfkX/g6vBIbV2GMPFktmJ/VGYWhrbmx4A/dtimQiuexFqjpjAN3YxjtW+vfOipkXe71gvixgGW8SCWG+w=
X-Received: by 2002:a05:6870:d0c5:b0:183:f343:f8ce with SMTP id
 k5-20020a056870d0c500b00183f343f8cemr842603oaa.8.1681374417693; Thu, 13 Apr
 2023 01:26:57 -0700 (PDT)
MIME-Version: 1.0
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Thu, 13 Apr 2023 10:26:46 +0200
Message-ID: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
Subject: [PATCH v2 0/3] iio: adc: ad7192: Functional fixes
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series fixes two bugs introduced in ad7192 ADC driver in
the last commits and adds related bindings documentation.

Changes in v2:
 - Obtained ad7192_state from iio_dev pointer
 - Added patch on bindings documentation

Backported patches have been tested on a custom board (ARM v7, NXP)
with kernel 5.15.

There is still an unresolved issue with the IRQ management on the
shared SPI-SDO/RDY pin causing single samples to be discarded. More
information and possible solutions here:
https://lore.kernel.org/all/CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com/

In addition, this patch is required to make libiio start up correctly:
https://lore.kernel.org/all/20230330102100.17590-1-paul@crapouillou.net/

Links to v1:
- https://lore.kernel.org/linux-iio/CAPJMGm4GDVdAmwB4sHVkg78UhtVpmbCL6KT8-KbEY7cRSD5UZg@mail.gmail.com/
- https://lore.kernel.org/linux-iio/CAPJMGm4StRvJ4zTyrOb7ebo47LrR9bBuZ46p7VOxkDfwWSG=PA@mail.gmail.com/

Fabrizio Lamarque (3):
  iio: adc: ad7192: Fix null ad7192_state pointer access
  iio: adc: ad7192: Fix internal/external clock selection
  iio: adc: ad7192: Clarify binding documentation

 .../bindings/iio/adc/adi,ad7192.yaml          | 28 +++++++++++++++----
 drivers/iio/adc/ad7192.c                      | 26 +++++++++--------
 2 files changed, 36 insertions(+), 18 deletions(-)

-- 
2.34.1
