Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B5D6E08FA
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDMIdx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 04:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjDMIdv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 04:33:51 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E802D7F
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 01:33:44 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id bm45so3772526oib.4
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681374823; x=1683966823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MkMEzm5Bx+QwNMXwUVJE0CRyJbdWVf8/MgbsIc/reEk=;
        b=BumFeyqwA36Fj16Pq20+nre14YxBJvUrBmQ37WYLkexmyykG0AikAHIIN8hPww1HTw
         Cbiookm218ZwhMtsCTC2PC8WkVuAqgoI85wX8i6RAaK/H5pAAwimB97vDpwhyGt/3RBZ
         5a+Kn7FzI2VXwdRJt4nPSItU8eD/CZaoapkGakrT3zxVNfkQ0g6kpedsRcmVqyzMmeHe
         Ib5vL6WcHhpv2GxCJUOVl8FGVINQTOkNclqV0o7tVvGujKlpLhIp5VouOLdaWKBX+plW
         IbccxXO0YZ3ZM8vvCnPO6tbi7tBgkbjskCNs0Vd+zl5QJJWxOe734mOQWAQSKzkFSuWj
         txMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681374823; x=1683966823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkMEzm5Bx+QwNMXwUVJE0CRyJbdWVf8/MgbsIc/reEk=;
        b=Ot+DNz1e1E14N4zyYuCFw6R6iuGrZ81yjmtSsT2OLzjRcYxr97uOR9uMPeXIlKPe/1
         ZdcY23cwvfVokuByC8/1sXv4z2+rWNaX5ebvxPbUESp1zxClhOv1NBLbiC9cOAaJiIHB
         HFYgqg2DtJwS7mrshqPQslpzCaYlm4iYcUaywHUQbYHyScpqpgNpr0gNM3pGTfnK2rG+
         z3Px5Eu1cYuEj1NYjNJ8lD9CRBxzsdBHzG1H051wDcyhFTuvKAJnjVL0aPzhKk5+9TOh
         l/Bn8HM63GmUmEq+RrvGXbZYDvMNzd2C0w/FvuDJPMpUDS4B1AcoC7+Q7M7+V2gg6Up1
         5mdw==
X-Gm-Message-State: AAQBX9cuZybnkGKyVjOhXW3T1pJ0uk6xXvSX4fo+dnIgephcdNx+3FFB
        Mz8beaDH/e+k1spUGWZ36DtR6PKEl3OM2FNNHIXyU7KftJM=
X-Google-Smtp-Source: AKy350bODJ1Ik81e+LL9IflbvdqZdPkk9L6ywy27gSSjwHxLofIrrCwNH0nSFQiz6qSEDPKh8K/0vC2K3FEePK+0GIQ=
X-Received: by 2002:aca:120c:0:b0:38b:f7fa:40ac with SMTP id
 12-20020aca120c000000b0038bf7fa40acmr313205ois.8.1681374823427; Thu, 13 Apr
 2023 01:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
 <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
In-Reply-To: <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Thu, 13 Apr 2023 10:33:32 +0200
Message-ID: <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
Subject: [PATCH 2/3] iio: adc: ad7192: Fix internal/external clock selection
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

Fixed wrong selection of internal clock when mclk is defined.

Resolved a logical inversion introduced in c9ec2cb328e3.

Fixes: c9ec2cb328e3 iio: adc: ad7192: use devm_clk_get_optional() for mclk
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
---
 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 94a9cf34a255..5a9c8898f8af 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -367,7 +367,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
     clock_sel = AD7192_CLK_INT;

     /* use internal clock */
-    if (st->mclk) {
+    if (!st->mclk) {
         if (of_property_read_bool(np, "adi,int-clock-output-enable"))
             clock_sel = AD7192_CLK_INT_CO;
     } else {
-- 
2.34.1
