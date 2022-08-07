Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1144258BB4E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiHGOop (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiHGOoo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 10:44:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF029FED
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 07:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56957B80AB2
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 14:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3E2C433D6;
        Sun,  7 Aug 2022 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659883481;
        bh=NGJtvZVt5ZGoTFdseEBQrc8i4uXKEeFUo44TaciX0oo=;
        h=From:To:Cc:Subject:Date:From;
        b=HRmXl1JC5g1Nb/P3hjmKgr7uG6crpw9sAEEDArbmXbgMnIWkOEbYt2r0tuPj5uEvR
         dYzpQLQAPcWnLztU4gQ/781TR/ukTweGMpeqkP2bBGxQnJBVNZnfgwk8CjJEHpV5Zc
         TH9DdL5sQ0+Z7Lq9LFAmBv7BMhfhqDk4rX09NRyNpGUq9QvJ3pLvI38QjtHFCAjtrS
         8vm2ZcN7NhP2OxBkZCdYbfAw5jmvF0e6qCO9g53BS3IUkXJ+3YDdVE4WsFJGfmQIWr
         MbHLWkJFw1cLMpi/bKScw8rbjUmWpgRYKeWbud/oYZUpCYoRNfGGdzCiqE6lHcpxIQ
         Z7CFpaxLGs4UQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] IIO: Clean up a couple of warnings that snuck in.
Date:   Sun,  7 Aug 2022 15:54:55 +0100
Message-Id: <20220807145457.646062-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm not sure how these slipped through my local tests and 0-day.
These are definitely shown with W=1, perhaps not without that
but IIO is generally W=1 clean.

Jonathan Cameron (2):
  iio: test: Mark file local structure arrays static.
  iio: light: cm32181: Mark the dev_pm_ops static.

 drivers/iio/light/cm32181.c         | 2 +-
 drivers/iio/test/iio-test-rescale.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.37.1

