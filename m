Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA336CAFE0
	for <lists+linux-iio@lfdr.de>; Mon, 27 Mar 2023 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC0UWD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Mar 2023 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC0UWD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2023 16:22:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DB5C1
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 13:22:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l7so8824986pjg.5
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679948522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cl6cMr3JcAM8W1VUEcRXSiJXToHRt+/BDgX+6G2l1gA=;
        b=IkfRpbsamRfbsB0b+5u1xiKEV4Lwamg+3ehvQDYhIPaTRMLH5s7cmfC4Vkene4LrJ7
         QaDGv/c0EPrSrcfAz9pummloT29tflCKrSqq0C3YdsEBFwHVXZgnz/IEGl9F3pIGvu0b
         RjcMlroFYDXljEifRMSpF1XD0ajdTJX/g9TJ/T2S9t9+EacPpWedY9No3GX9dTZVQ98Z
         LFg53Rp0unPch0ClvhiY4NxGyeZhzsGW+cmwpRTprXsAh6MkVJYTu4SRsqQwFzVH/lri
         EDn27q54Pw3e5yCAiqvkYD97RiCBEicFk/pc6kZWIVU9g86TCgU86RfrTr6OKJ+I9f5W
         JB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl6cMr3JcAM8W1VUEcRXSiJXToHRt+/BDgX+6G2l1gA=;
        b=OBEAm+TDLoP/bwYLWhpjZFvQL5QcEHo8PDRZtMUjVJWJqQyuLOfcI3kiNFy4FZ89ej
         /Pe6M9hQghINXP962TiC2FX8wujhmUJX89sLXgXY9CpGPG8l4M7g0Mvm3trfEe+4Oi8Y
         BjMuZx2xEAt8pxXUVSnLk2q8Akdh3z66h3mBslxmIfqi7eoNnkg9RfjVNz8udkK8kpJe
         LxUmfaI38Omo1e0JwNHVj7IwQmTny/PqqRi2BES6dyQBIN3nLpi/tUB8RHq5yGcWSvSH
         TcaACDiZoPjVeL8Ff3wMaWf2SXNHYfogPEQOVJ2L4Crj4f0KMSITa2iOHSeuoL461IG4
         EKFA==
X-Gm-Message-State: AAQBX9dzMOWUP9CXsNRHOk2Gg2LFMCvvM+3l1HSyLPJS+lfSEgdB2TI0
        qj91vlN0diB2WC6YDRjcMQ14BcJdbcHLrJ3R2+vuVoHU76aBRDf+
X-Google-Smtp-Source: AKy350bkc5MSSnfdbKpQCeo7lAyTihYV90yhx3kFS4L4ZoO0bEo4jEE+5shN6Tf0uadmWNWSKRuCXI4zp0QQBy7aE+k=
X-Received: by 2002:a17:902:c1c4:b0:1a1:b9e6:28ae with SMTP id
 c4-20020a170902c1c400b001a1b9e628aemr4502531plc.2.1679948521790; Mon, 27 Mar
 2023 13:22:01 -0700 (PDT)
MIME-Version: 1.0
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Mon, 27 Mar 2023 22:21:45 +0200
Message-ID: <CAPJMGm4StRvJ4zTyrOb7ebo47LrR9bBuZ46p7VOxkDfwWSG=PA@mail.gmail.com>
Subject: [PATCH 2/2] ad7192 driver: fixed unexpected internal clock fallback
 when no mclk clock is defined.
To:     alexandru.tachici@analog.com
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allow the use of external clock when mclk clock is defined.
When defining a mclk clock source in device tree with adi,clock-xtal
property, the external crystal oscillator is not turned on.
Without the change, the driver always uses the internal clock even
when mclk clock is defined.

Current implementation seems to contain a typo, since it expected
st->mclk to be NULL within ad7192_of_clock_select() in order to select
the external clock, but, if null, external clock cannot loaded
correctly (out of bounds due to invalid mclk) in ad7192_probe().

I believe this patch follows the author's intended behavior.
 After applying this patch, the external oscillator is started as expected.

I kindly ask your feedback, I may adjust the patch according to your
suggestions. I could also follow up with another patch on
documentation, containing the following (related) issues:

- adi,int-clock-output-enable is undocumented
- adi,clock-xtal is undocumented
- regulator name avdd and its description is quite misleading, since
this is unrelated to the AVdd pin (#20) of AD7192; it is used instead
as reference voltage (REFIN1 on #15/#16 or REFIN2 on #7/#8). See
int_vref_mv variable within driver implementation.

Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
--- linux/drivers/iio/adc/ad7192.c=E2=80=82=E2=80=822023-03-13 19:32:42.646=
239506 +0100
+++ linux/drivers/iio/adc/ad7192.c=E2=80=82=E2=80=822023-03-14 10:19:32.361=
924242 +0100
@@ -367,7 +367,7 @@ static int ad7192_of_clock_select(struct
 =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82clock_sel =3D AD7192_CLK_INT;

 =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82/* use internal clock */
-=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82if (st->mclk) {
+=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82if (!st->mclk) {
 =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82if (of_property_read_bool(np, "adi,int-clock-out=
put-enable"))
 =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82clock_sel =3D AD7192_CLK_INT_CO;
 =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82} else {
