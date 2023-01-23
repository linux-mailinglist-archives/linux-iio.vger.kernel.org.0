Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242E9678912
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 22:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjAWVEZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 16:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjAWVEY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 16:04:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151A360AF;
        Mon, 23 Jan 2023 13:04:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA84E61092;
        Mon, 23 Jan 2023 21:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F7BC4339C;
        Mon, 23 Jan 2023 21:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674507862;
        bh=CVVF40aIqyqHuHo5QkyM/mqnSUoD6khV2a9bfpLNjLk=;
        h=From:To:Cc:Subject:Date:From;
        b=mfc5nGdhbTQHKS96aFAAYhGHqgGQtHEQwGNQCfoW1bECCUUvMIAag+B3WjF/5/zV5
         Xlp+vJ120UbeyNBOxUKEYKmOQqmqB1zymvNx4+QZWz4a8BNVXC+PDOKLN6TpJIRQaM
         wQ3O4JgzqS4j9o3GCZawgUVfH9QP7SkS+j0RrD3FBD3wzmWosm6FLdz/DofYem8f8V
         o1fiq59l/h1noYlTNB6H64wX9YJOufPBjdWgF/X0uQg2GmBJqxqhPLcojG+M4CAqAm
         mOKVqWrgwtCKjkZWUebvaWP5PSlV8LYDP3Oi4f4iOXNacfFidSqA+QPi8FQvC8cKJA
         zZYVAa6fpkrow==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 00/12] staging: iio: accel: adis16203 Inclinometer cleanup and graduation
Date:   Mon, 23 Jan 2023 21:17:46 +0000
Message-Id: <20230123211758.563383-1-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst taking a look at what we still have in staging, I noticed that this
driver was (probably) only still there due to the need to define some ABI
for the odd 180 degree offset channel (same as the other channel
minus 180 degrees).

Rather than leaving the driver in staging for ever, let us just drop that
channel and move on. The rest of the series is trivial driver cleanup.

Note this is only build tested, so would be great if people can take
a good look.  If anyone happens to have one of these that would be even
better (they are still marked for production use more than 12 years after
the driver was submitted).

There are lots of features we could support if anyone wanted to, but
it should be functional for basic channel reading without the bells
and whistles.  I've tried to incorporate the relevant device tree bindings
however (multiple interrupt lines, supplies and reset gpio).

Cc: Barry Song <baohua@kernel.org>
(mostly for comedy value, not expecting you to remember the driver :)

Jonathan Cameron (12):
  staging: iio: accel: adis16203: More conventional header ordering
  staging: iio: accel: adis16203: Drop excessive register comments
  staging: iio: accel: adis16203: Rename incli channel registers
  staging: iio: accel: adis16203: Drop the 180 degree offset channel
  staging: iio: accel: adis16203: Simplify handling of calibbias
  staging: iio: accel: adis16203: Drop driver name define
  staging: iio: accel: adis16203: Make units explicit in name of delay
    define
  staging: iio: accel: adis16203: Trivial whitespace cleanup
  staging: iio: accel: adis16203: Drop setting drvdata as nothing gets
    it
  staging: iio: accel: adis16203: Trivial style cleanup
  staging: iio: accel: adis16203: Move out of staging
  dt-bindings: iio: accel: Add ADIS16203 Inclinometer

 .../bindings/iio/accel/adi,adis16203.yaml     |  59 +++++
 drivers/iio/accel/Kconfig                     |  12 +
 drivers/iio/accel/Makefile                    |   1 +
 drivers/{staging => }/iio/accel/adis16203.c   | 212 ++++++------------
 drivers/staging/iio/accel/Kconfig             |  12 -
 drivers/staging/iio/accel/Makefile            |   1 -
 6 files changed, 136 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
 rename drivers/{staging => }/iio/accel/adis16203.c (51%)

-- 
2.39.1

