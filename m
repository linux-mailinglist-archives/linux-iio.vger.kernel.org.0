Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE46E08E7
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 10:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDMI2Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 04:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDMI2X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 04:28:23 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79AF2685
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 01:28:22 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1842df7cb53so16989188fac.10
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681374502; x=1683966502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3lVC0QIahWICPUq2qmNtFjM9vCzRJJrRAYj3XSJFtR4=;
        b=Ll5bzTd9Zo3pxJCXNWIq1d/D5RufxKWgFf4ZG+qAJ4wFkRsvu+/vg/diWSShedfArH
         cbn67u70O9g4ivni3kEBudYPY3UuH6h1N6FriBHXtz2JJhB7C0ryHCBIBmD2LwGwFP2K
         lF5dFmWVXteeG2z5il+l1tWnXO1W1ovOw5H35z/tG2vQ+5NxBEPa2eROBJ9Bai9vrR+3
         y00kReBbAUr7T6odBsmHogkpoxCGm8ewPKkMs0Rjox4rnoDaKmKgThHkckguPhP6D+Ux
         o+WD6iJI7wvgeo9Sf9lFUGjYc0BuqgPPOh3B9NWoOzMq9KGkXUlnH9EKwMlDgj8mTo65
         H4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681374502; x=1683966502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lVC0QIahWICPUq2qmNtFjM9vCzRJJrRAYj3XSJFtR4=;
        b=A6wuhmoEUQGd8s+ptJO1lthk41waDIuumzzBxt9XMlHoNSOJWtu6g0iNSV6ab5uCJM
         iTSq2KHQ5XRDz6voBI5A2/67R4nxDfSRbrzeKC/83SIiTSDiu/f2aPGqTaygqOaXOWSQ
         hXNxWAngMBQiC3zck9aN7D02XrvEvs6wP3w60OhMZMwf4flsrxn8yJomKwsObGbTbesh
         +RX3nkaGL6OMCEfHl66xIs/oc6HNP2dIcCEa1cFNvKO0PCcKY3VA1JsGCe+JKIXI0DkH
         gka6Wjl9NEPqKoapNh28AOfbbtTt0qzHrj1Rwa/hZA8bQIuYipBSKLlu2CzCfOoHaZSV
         cL7Q==
X-Gm-Message-State: AAQBX9dNMTNqyYqhrxScOkC6HiIFpzlx6ESpL7ahqwy90q2B5n++JnyR
        bApwqbXFSal3H2Xqm7L8EXGFUmgaZvy/wQkwBGnnvwsTFa0=
X-Google-Smtp-Source: AKy350at+3KAu/ysiXmBQRGHdTbiseSU9DNjoDR0xCWir5/KG5LzHG35x7sV42wjK6iEbBIZrJylaeIvWSfFnaYHs9c=
X-Received: by 2002:a05:6870:2e0e:b0:187:7524:9a8d with SMTP id
 oi14-20020a0568702e0e00b0018775249a8dmr2007003oab.4.1681374501888; Thu, 13
 Apr 2023 01:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
In-Reply-To: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Thu, 13 Apr 2023 10:28:11 +0200
Message-ID: <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
Subject: [PATCH v2 1/3] iio: adc: ad7192: Fix null pointer dereference on probe
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

Pointer to indio_dev structure is obtained via spi_get_drvdata() at
the beginning of function ad7192_setup(), but the spi->dev->driver_data
member is not initialized, hence a NULL pointer is returned.

Fixed by changing ad7192_setup() signature to take pointer to struct
iio_dev, and get ad7192_state pointer via st = iio_priv(indio_dev);

Fixes: bd5dcdeb3fd0 iio: adc: ad7192: convert to device-managed functions
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
---
Changes in v2: obtained ad7192_state from iio_dev pointer as suggested
by Jonathan, removed Reviewed-by since the entire patch changed its
content.

 drivers/iio/adc/ad7192.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 55a6ab591016..94a9cf34a255 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -380,9 +380,9 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
  return clock_sel;
 }

-static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
+static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 {
- struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
+ struct ad7192_state *st = iio_priv(indio_dev);
  bool rej60_en, refin2_en;
  bool buf_en, bipolar, burnout_curr_en;
  unsigned long long scale_uv;
@@ -1073,7 +1073,7 @@ static int ad7192_probe(struct spi_device *spi)
  }
  }

- ret = ad7192_setup(st, spi->dev.of_node);
+ ret = ad7192_setup(indio_dev, spi->dev.of_node);
  if (ret)
  return ret;

--
2.34.1
