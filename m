Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1E6ABA2E
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 10:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCFJnM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 04:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCFJnM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 04:43:12 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69279DBD0
        for <linux-iio@vger.kernel.org>; Mon,  6 Mar 2023 01:43:08 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t14so8942186ljd.5
        for <linux-iio@vger.kernel.org>; Mon, 06 Mar 2023 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1678095786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcMN9JbZ9ifDcLCp57SFNkdO1pBah9zhn6rddcb4N9U=;
        b=SMu+sHcAvQi9deN6JwtNl1jeQXl5VLbmWVqeMFlMBrv9A8wi3LPwoAwQNMNtkUKuYQ
         0YyGbBTSISJxegmefjs4LQ81NxAhg+KLFYmJutcczFDdTOocc3Wg6S8zi3FDAM74LQf6
         s9cJasQ3MP49ILq9pq1BmIbSkn0mYDJ3RHtY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678095786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcMN9JbZ9ifDcLCp57SFNkdO1pBah9zhn6rddcb4N9U=;
        b=wZs3WU9zbuGvoFmwMVJNaJqmUkbvm6hSm4lP19XfltT5J9mddU3tWKrPpEu6DnBLEb
         Za/Erhr5M2PRD1AIjl7hlE6UU3tcfJ9U+Ss14y5fpQhs8v5rm6or/CWZRUPASM/AzaF1
         Qg97L7iSA2RCVgHHJ31rpURoi57ARhWGf4LuX95j1aAx0gdtd7fk25d1ARxXeFxnhfIe
         RA+RcUlgQ1bU+Upzhvieo1CGu/gH7u3hLifYq/ty0ufNvdXsO3KYH88FB3/8aL9BJWmz
         SXtcm17HA5Z0sicLgx2HdDQ8I8GiHO9t7chJ4eDObBQ8AJSrvg5Q1QWFD54EQPa6MWNv
         im/g==
X-Gm-Message-State: AO0yUKVhTqtXGQpkp4CINjBUGhjlPfGh2tgDmUXc285kgl9FeLroPe2A
        R70vPBx4qskQ7yW0Wyf/tK7TxQ==
X-Google-Smtp-Source: AK7set9x+mvolD3p05ZthWcLiglULj+eqru/lw1Gx6a+cBBIEqiG/7Tgp3cKZLEy6oedNS2+5HPKhg==
X-Received: by 2002:a2e:910d:0:b0:295:c39c:d8ab with SMTP id m13-20020a2e910d000000b00295c39cd8abmr2691274ljg.39.1678095786609;
        Mon, 06 Mar 2023 01:43:06 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b002934ed148afsm1620091ljj.52.2023.03.06.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:43:06 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/2] iio: ad74413r: allow setting sink current for digital input
Date:   Mon,  6 Mar 2023 10:42:59 +0100
Message-Id: <20230306094301.1357543-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
References: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
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

v2:
- remove redundant type info in binding per Rob's bot
- use min() instead of if() in ad74413r_set_comp_drive_strength() per Jonathan

Rasmus Villemoes (2):
  dt-bindings: iio: ad74413r: allow setting sink current for digital
    input
  iio: ad74413r: wire up support for drive-strength-microamp property

 .../bindings/iio/addac/adi,ad74413r.yaml      |  9 ++++++++
 drivers/iio/addac/ad74413r.c                  | 23 +++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.37.2

