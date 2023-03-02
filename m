Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381FD6A83D1
	for <lists+linux-iio@lfdr.de>; Thu,  2 Mar 2023 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCBNtm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Mar 2023 08:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCBNta (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Mar 2023 08:49:30 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49684166E8
        for <linux-iio@vger.kernel.org>; Thu,  2 Mar 2023 05:49:26 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f16so17651579ljq.10
        for <linux-iio@vger.kernel.org>; Thu, 02 Mar 2023 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iueLlhkJnKVWnKpGU+Y50/0H8Xgr6AsobmPXkM/XL+A=;
        b=YY6xM7EDrdJyx14rhCDNllwm89MTiHZHWEYkQyXVeEsr0pC6QQwhH2qpPdRshQJ0X3
         7VujWszdurF/4oU4BM2mGVabmRNli2mWdivwdZbJcMIXhhr9lV08G4huz+ZOaht7YzZH
         GioPDDFoaqxsk89esSfUqkPnWQHNR9wSZydZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iueLlhkJnKVWnKpGU+Y50/0H8Xgr6AsobmPXkM/XL+A=;
        b=XryL+qLfsVJGy8X0S9MZx2l/SRA9k1CjKh+UFjAV7inQKnJcb9sY7GkPpUPHFI6GeT
         lNqenZipXi5TZBgeW5OlOACAJreJFgb0gJ6lGV29wHDBmVsqHu/0ukprzDcCqZuj7Rjd
         T2D7Wqj0XXddLu2l/GuDlJTjwNhqUIdpy5tlS8afcAwMYRKIs/+2QO9pfLFXOZp6QkhR
         JpOFRRwq1Chvwl7jp+CN/3rf3lzbipxQBT1qtft35r6bDTdqkn+8gKEgkGm9xtcfA/sH
         fJSCJmJGMwAm3q6Ik8leonW2dUcNQfPz4PS18E4tWuqLQuZzjIueXuX5DYBRPBDQzuD2
         Z//w==
X-Gm-Message-State: AO0yUKX917b9yaXQFS/y+wzv82SBIMZ1BmVg07iA8G0qd/m8IX2wjRpY
        u8ia89MdtcQBFdgwrdzvhesfFg==
X-Google-Smtp-Source: AK7set/5gQNxzqnOWtQpW4JWEgRJCOFSkRB4NM4BnWrEvGgO3CNnk6CXVgfUqURzoTo8Ve0ljNrDbQ==
X-Received: by 2002:a2e:22c3:0:b0:294:6cfd:8a88 with SMTP id i186-20020a2e22c3000000b002946cfd8a88mr3067433lji.9.1677764964511;
        Thu, 02 Mar 2023 05:49:24 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s16-20020ac25ff0000000b004cb3e97bff8sm2139088lfg.284.2023.03.02.05.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 05:49:24 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/2] iio: ad74413r: allow setting sink current for digital input
Date:   Thu,  2 Mar 2023 14:49:19 +0100
Message-Id: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
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

Depending on the actual hardware wired up to a digital input channel,
it may be necessary to configure the ad74413r to sink a small
current. For example, in the case of a simple mechanical switch, the
charge on the external 68 nF capacitor (cf. the data sheet's Figure
34) will keep the channel as reading high even after the switch is
turned off again.

Add a DT binding and driver support for setting the desired sink current.

I have chosen the term "drive strength" because it matches existing
practice, even if this is only a sink. E.g. there's

 * @PIN_CONFIG_DRIVE_STRENGTH_UA: the pin will sink or source at most the current
 *      passed as argument. The argument is in uA.

and indeed it would be trivial to hook up that
PIN_CONFIG_DRIVE_STRENGTH_UA in ad74413r_gpio_set_comp_config().

However, unlike the debounce time, there does not appear to be any way
to actually tweak the drive strength from userspace, nor do I know if
that would actually be a good idea. For our application(s), the
current sink needed is a property of the attached hardware, and thus
can and should be defined in DT.

Rasmus Villemoes (2):
  dt-bindings: iio: ad74413r: allow setting sink current for digital
    input
  iio: ad74413r: wire up support for drive-strength-microamp property

 .../bindings/iio/addac/adi,ad74413r.yaml      | 10 ++++++++
 drivers/iio/addac/ad74413r.c                  | 24 +++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.37.2

